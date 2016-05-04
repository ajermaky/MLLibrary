using CSE151DataParser
using CSE151KNeighbors
using Gadfly
using Colors


path=joinpath(Pkg.dir("CSE151KNeighbors"),"resources")

threshold =.1
#resources = ["3percent-miscategorization","10percent-miscatergorization","abalone.data","Seperable.csv"]
resources=[
["res"=>"abalone.data" ,"proxy"=>[Dict("column"=>1,"proxy"=>["M" "F" "I"])]]
["res"=>"Seperable.csv", "proxy"=>[]]
["res"=>"3percent-miscategorization.csv", "proxy"=>[]]
["res"=>"10percent-miscatergorization.csv", "proxy"=>[]]]
errors = Dict()

outfile = open(joinpath(Pkg.dir("CSE151KNeighbors"),"resources","ConfusionMatrix.txt"),"w")
for r  in resources

  println("Running Tests for ",r["res"])
  errors[r["res"]]=Dict()
  res = joinpath(path,r["res"])
  proxyColumns = r["proxy"]

  srand(1234)
  trainingSet = CSE151DataParser.getTrainingSet(res,threshold)
  srand(1234)

  testSet = CSE151DataParser.getTestSet(res,threshold)


  training_y = trainingSet[:,end]
  test_y = testSet[:,end]
  trainingSet=trainingSet[:,1:end-1]
  testSet=testSet[:,1:end-1]
  trainingSet=CSE151KNeighbors.DataTransform.addProxyColumns(trainingSet,proxyColumns)
  testSet=CSE151KNeighbors.DataTransform.addProxyColumns(testSet,proxyColumns)

  trainingSet= CSE151KNeighbors.DataTransform.convertToFloat(trainingSet)
  testSet= CSE151KNeighbors.DataTransform.convertToFloat(testSet)
  training_y= CSE151KNeighbors.DataTransform.convertToFloat(training_y)
  test_y= CSE151KNeighbors.DataTransform.convertToFloat(test_y)

#println(testSet)
  println("We got our Datasets!")
  #println(testSet)
  for K in [1 3 5 7 9]
    errors[r["res"]][K]=CSE151KNeighbors.KNeighborsModule.KNeighbors(trainingSet,testSet,training_y,test_y, CSE151KNeighbors.ConfusionMatrix.calculateErrorRate,K)

  end

  theset = errors[r["res"]]
  Kmin = collect(keys(theset))[indmin(collect(values(theset)))]
  println(Kmin)
  confusionmatrix = CSE151KNeighbors.KNeighborsModule.KNeighbors(trainingSet,testSet,training_y,test_y, CSE151KNeighbors.ConfusionMatrix.generateConfusionMatrix,Kmin)
  println(size(confusionmatrix))
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

draw(PNG(joinpath(Pkg.dir("CSE151KNeighbors"),"resources","myplot.png"), 800px, 600px), p)
