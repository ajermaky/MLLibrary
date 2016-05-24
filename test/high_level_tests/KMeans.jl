using Gadfly
using Colors
using CSE151MachineLearningLibrary


path=joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets")

threshold =.1
delimiter = ","
#resources = ["3percent-miscategorization","10percent-miscatergorization","abalone.data","Seperable.csv"]
resources=
["res"=>"abalone.data" ,"proxy"=>[Dict("column"=>1,"proxy"=>["M" "F" "I"])],"path"=>Pkg.dir("CSE151MachineLearningLibrary","resources","datasets")]
errors = Dict()

outfile = open(joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","paResources","Week4","Res.txt"),"w")

seed=123
training, test = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getSets(joinpath(resources["path"],resources["res"]),",",.1,seed)

proxy = resources["proxy"]

training=[CSE151MachineLearningLibrary.DataManipulation.DataTransform.addProxyColumns(training[:,1:end-1],proxy) training[:,end]]

test=[CSE151MachineLearningLibrary.DataManipulation.DataTransform.addProxyColumns(test[:,1:end-1],proxy) test[:,end]]

# println(training)
# println(test)

training = CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(training)
test= CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(test)
println("Data is ready")

wcss=Dict()
for k in [1,2,4,8,16]
  centroids,y = CSE151MachineLearningLibrary.LearningAlgorithms.KMeans.trainKmeans(training,k)

  write(outfile, "K: ","$k","\n\n")
  write(outfile, "Centroids:","\n","$centroids","\n\n")
  for i=1:k
    write(outfile, "Cluster $i","\n")

    newTraining = training[find(x->x==i,y),:]
    average = CSE151MachineLearningLibrary.Statistics.meanColumn(newTraining)
    standarddeviation = CSE151MachineLearningLibrary.Statistics.stdColumn(newTraining)
    write(outfile,"Mean:","$average" ,"\n\n","Std:", "$standarddeviation","\n\n"
    )

  end

  wcss[k]=CSE151MachineLearningLibrary.Utils.ErrorAnalysis.calculateWCSS(centroids,training,y)
  wcsstemp = wcss[k]
  write(outfile, "WCSS:","\n","$wcsstemp","\n\n")

end
close(outfile)


p = plot(

  Guide.ylabel("WCSS"),
  Guide.xlabel("Data Set"),
  Guide.title("Within Cluster Sum of Squares"),
  x=collect(keys(errors)),
  y=collect(values(errors)),
  Geom.bar,
  Geom.label(position=:above),
  label=map(string,(values(errors)))
  #color="DataSet"
)

draw(PNG(joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","paResources","Week4","WCSSErrors.png"), 800px, 600px), p)
