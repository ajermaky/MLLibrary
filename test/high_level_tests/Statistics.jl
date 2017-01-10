using Gadfly
using MLLibrary

println("Running Statistics Tests")
srand(123)
file = joinpath(Pkg.dir("MLLibrary"),"resources","datasets","abalone.data")
count=MLLibrary.DataParser.DataStream.getDataSetCount(file)
threshold=.1
total_runs = 5
num_runs= 1
run_increment = 10
runs_x = zeros(total_runs,1)
mean_y = zeros(total_runs,1)
std_y = zeros(total_runs,1)

for i=1:total_runs
  testset= zeros(Int,count,1)
  num_runs*=run_increment
  runs_x[i]=num_runs
  for run=1:num_runs
    testset[MLLibrary.DataSampling.ThresholdSampling.getThresholdTrainingSetIndicies(file,count,threshold)]+=1;
  end
  mean_y[i] = mean(testset)/num_runs
  std_y[i] = std(testset)/num_runs
end

p = plot(
  layer(
    x=runs_x,
    y=mean_y,
    Geom.line,
    Theme(default_color=colorant"blue")
  ),
  layer(
    x=runs_x,
    y=std_y,
    Geom.line,
    Theme(default_color=colorant"orange")
  ),
  Scale.x_log10,
  Guide.ylabel("Test Sample Statistic"),
  Guide.xlabel("Number of Runs"),
  Guide.title("Expected Value and Standard Deviation over Number of Runs"),
  Guide.manual_color_key("Legend", ["Mean", "Standard Deviation"], ["blue", "orange"])
)

draw(PNG(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week1","ExpectedValuesvsRuns.png"), 800px, 600px), p)
