using Gadfly
using Colors
using MLLibrary


path=joinpath(Pkg.dir("MLLibrary"),"resources","datasets")

threshold =.1
delimiter = ","
#resources = ["3percent-miscategorization","10percent-miscatergorization","abalone.data","Seperable.csv"]
resources=[
["res"=>"abalone.data" ,"proxy"=>[Dict("column"=>1,"proxy"=>["M" "F" "I"])], "indices"=>[1 2 3 4 5 6 7]]
["res"=>"Seperable.csv", "proxy"=>[],"indices"=>[1 2 3 4 5 6 7 8 9]]
["res"=>"3percent-miscategorization.csv", "proxy"=>[],"indices"=>[1 2 3 4 5 6 7 8 9]]
["res"=>"10percent-miscatergorization.csv", "proxy"=>[],"indices"=>[1 2 3 4 5 6 7 8 9]]
]
errors = Dict()

outfile = open(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week2","ConfusionMatrix.txt"),"w")
for r  in resources

  println("Running Tests for ",r["res"])
  errors[r["res"]]=Dict()
  res = joinpath(path,r["res"])
  proxyColumns = r["proxy"]

  srand(1234)
  trainingSet = MLLibrary.DataSampling.ThresholdSampling.getTrainingSet(res,delimiter,threshold)

  srand(1234)

  testSet = MLLibrary.DataSampling.ThresholdSampling.getTestSet(res,delimiter,threshold)


  training_y = trainingSet[:,end]
  test_y = testSet[:,end]
  trainingSet=trainingSet[:,1:end-1]
  testSet=testSet[:,1:end-1]
  trainingSet=MLLibrary.DataManipulation.DataTransform.addProxyColumns(trainingSet,proxyColumns)
  testSet=MLLibrary.DataManipulation.DataTransform.addProxyColumns(testSet,proxyColumns)

  trainingSet= MLLibrary.DataManipulation.DataTransform.convertToFloat(trainingSet)
  testSet= MLLibrary.DataManipulation.DataTransform.convertToFloat(testSet)
  training_y= MLLibrary.DataManipulation.DataTransform.convertToFloat(training_y)
  test_y= MLLibrary.DataManipulation.DataTransform.convertToFloat(test_y)

  #println(r["indices"])
  for i in r["indices"]
    #println(i)
    #println(size(trainingSet))
    column= trainingSet[:,i]
    average = mean(column)

    standarddeviation=std(column)
    trainingSet = MLLibrary.DataManipulation.DataTransform.zScaleColumn(trainingSet,i,average,standarddeviation)
    testSet = MLLibrary.DataManipulation.DataTransform.zScaleColumn(testSet,i,average,standarddeviation)
  end

#println(testSet)
  println("We got our Datasets!")
  #println(testSet)
  for K in [1 3 5 7 9]
    predicted_y=MLLibrary.LearningAlgorithms.KNeighbors.KNearestNeighbors(trainingSet,testSet,training_y,K)

    confusionMatrix=MLLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(test_y,predicted_y)
    errors[r["res"]][K] = 1 - MLLibrary.Utils.ErrorAnalysis.calculateWeightedSuccessRate(confusionMatrix)
    println(errors[r["res"]][K])

    #MLLibrary.Utils.ErrorAnalysis.calculateErrorRate(test_y,predicted_y)


  end

  theset = errors[r["res"]]
  Kmin = collect(keys(theset))[indmin(collect(values(theset)))]
  println(Kmin)
  optimal_y = MLLibrary.LearningAlgorithms.KNeighbors.KNearestNeighbors(trainingSet,testSet,training_y,Kmin)

  confusionmatrix =MLLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(test_y,optimal_y)

  #println(size(confusionmatrix))
  write(outfile, r["res"],"\n","Minimum K: ","$Kmin", "\n","ConfusionMatrix: \n")
  largesize =size(confusionmatrix)[1]>3

  for i=1:size(confusionmatrix)[1]
    for j=1:size(confusionmatrix)[2]
      if(largesize)
        @printf(outfile,"%3d",confusionmatrix[i,j])
      else
        @printf(outfile,"%7d",confusionmatrix[i,j])
      end

    end
    @printf(outfile,"%s","\n")
  end

  write(outfile,"\n\n")


end

close(outfile)

p = plot(

  Guide.ylabel("Error Rate"),
  Guide.xlabel("K-Value"),
  Guide.title("Error Rate per K value"),
  #color="DataSet"
)
index = 1
color_keys = []
colors = distinguishable_colors(length(errors))

for (k,v) in errors
  a = layer(
    x=collect(keys(v)),
    y=collect(values(v)),
    Geom.line,
    Theme(default_color=(colors[index]))
    #Guide.colorkey(k)
  )
  push!(color_keys,k)

  index+=1
  push!(p,a)
end

push!(p,  Guide.manual_color_key("Legend", color_keys, colors))

draw(PNG(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week2","ErrorRatesVsK.png"), 800px, 600px), p)
