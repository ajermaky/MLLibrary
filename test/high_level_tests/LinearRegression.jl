using Gadfly
using CSE151MachineLearningLibrary
using Colors
path =Pkg.dir("CSE151MachineLearningLibrary","resources","datasets")
week3=joinpath("Week3")
# resources = #[["res"=>"regression_test.csv","path"=>joinpath(path,week3),"proxy"=>[]]]
resources = [["res"=>"regression-0.05.csv","path"=>joinpath(path,week3),"proxy"=>[]],["res"=>"regression-A.csv","path"=>joinpath(path,week3),"proxy"=>[]],["res"=>"regression-B.csv","path"=>joinpath(path,week3),"proxy"=>[]],["res"=>"regression-C.csv","path"=>joinpath(path,week3),"proxy"=>[]],["res"=>"abalone.data","path"=>joinpath(path), "proxy"=>[Dict("column"=>1,"proxy"=>["M" "F" "I"])]]]
# [["res"=>"abalone.data","path"=>joinpath(path), "proxy"=>[Dict("column"=>1,"proxy"=>["M" "F" "I"])]]]

errors = Dict()
for res in resources
  seed=123
  training, test = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getSets(joinpath(res["path"],res["res"]),",",.1,seed)

  proxy = res["proxy"]

  training=[CSE151MachineLearningLibrary.DataManipulation.DataTransform.addProxyColumns(training[:,1:end-1],proxy) training[:,end]]

  test=[CSE151MachineLearningLibrary.DataManipulation.DataTransform.addProxyColumns(test[:,1:end-1],proxy) test[:,end]]

# println(training)
# println(test)

  training = CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(training)
  test= CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(test)
  println("Data is ready")
  println(typeof(training))

  betacol = CSE151MachineLearningLibrary.LearningAlgorithms.LinearRegression.linearRegression(training[:,1:end-1],training[:,end],CSE151MachineLearningLibrary.LinearAlgebra.HouseHolders.householdDecompose)


  println("finished dcomposing")
  test_y = test[:,end]
  test = test[:,1:end-1]

  observed = test*betacol

  #println((observed),(test_y))

  rms = round(CSE151MachineLearningLibrary.Utils.ErrorAnalysis.calculateRootMeanStandardError(observed,test_y),2)
  errors[res["res"]]=rms
end

println(errors)


p = plot(

  Guide.ylabel("Root Mean Square Error"),
  Guide.xlabel("Data Set"),
  Guide.title("Root Mean Square Errors"),
  x=collect(keys(errors)),
  y=collect(values(errors)),
  Geom.bar,
  Geom.label(position=:above),
  label=map(string,(values(errors)))
  #color="DataSet"
)
# index = 1
# color_keys = []
# colors = distinguishable_colors(length(errors))
#
# for (k,v) in errors
#   a = layer(
#     x=k,
#     y=v,
#     Geom.histogram,
#     Theme(default_color=(colors[index]))
#     #Guide.colorkey(k)
#   )
#   push!(color_keys,k)
#
#   index+=1
#   push!(p,a)
# end
#
# push!(p,  Guide.manual_color_key("Legend", color_keys, colors))

draw(PNG(joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","paResources","Week3","RMSEErrors.png"), 800px, 600px), p)
