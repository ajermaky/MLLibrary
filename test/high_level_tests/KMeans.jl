using Gadfly
using Colors
using MLLibrary


path=joinpath(Pkg.dir("MLLibrary"),"resources","datasets")
seed=123
threshold =.1
delimiter = ","
QRDecomposeMethod =MLLibrary.LinearAlgebra.HouseHolders.householdDecompose

#resources = ["3percent-miscategorization","10percent-miscatergorization","abalone.data","Seperable.csv"]
resources=["res"=>"abalone.data" ,"proxy"=>[Dict("column"=>1,"proxy"=>["M" "F" "I"])],"path"=>Pkg.dir("MLLibrary","resources","datasets")]
errors = Dict()


training, test = MLLibrary.DataSampling.ThresholdSampling.getSets(joinpath(resources["path"],resources["res"]),",",threshold,seed)

proxy = resources["proxy"]



training=[MLLibrary.DataManipulation.DataTransform.addProxyColumns(training[:,1:end-1],proxy) training[:,end]]

test=[MLLibrary.DataManipulation.DataTransform.addProxyColumns(test[:,1:end-1],proxy) test[:,end]]

# println(training)
# println(test)

unscaled_training = MLLibrary.DataManipulation.DataTransform.convertToFloat(training)
unscaled_test= MLLibrary.DataManipulation.DataTransform.convertToFloat(test)

training_y = unscaled_training[:,end]
test_y = unscaled_test[:,end]
training = unscaled_training[:,1:end-1]
test = unscaled_test[:,1:end-1]
println("Data is ready")



unscaled_training = copy(training)
unscaled_test = copy(test)
training =MLLibrary.DataManipulation.DataTransform.zScale(training)

test = MLLibrary.DataManipulation.DataTransform.zScale(test,
MLLibrary.Statistics.meanColumn(training),MLLibrary.Statistics.stdColumn(training))


outfile = open(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week4","Problem1centroids.txt"),"w")
outfile3 = open(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week4","Problem1wcss.txt"),"w")
outfile4 = open(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week4","Problem1stats.txt"),"w")

outfile2 = open(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week4","Problem2.txt"),"w")

wcss=Dict()
rmse=Dict()
for k in [1,2,4,8,16]
  centroids,ktrain_y = MLLibrary.LearningAlgorithms.KMeans.trainKmeans(training,k,seed)

  write(outfile, "K: ","$k","\n\n")
  write(outfile, "Centroids:","\n","$centroids","\n\n")

  #this section is purely for average/standarddeviation. Can actually be removed...
  for i=1:k

    newTraining = training[find(x->x==i,ktrain_y),:]
    average = MLLibrary.Statistics.meanColumn(newTraining)
    standarddeviation = MLLibrary.Statistics.stdColumn(newTraining)

    write(outfile4, "K: ","$k","\n\n")

    write(outfile4, "Cluster $i","\n")
    write(outfile4,"Mean:","$average" ,"\n\n","Std:", "$standarddeviation","\n\n"
    )

  end
  #caclulate the wcss
  wcss[k]=MLLibrary.Utils.ErrorAnalysis.calculateWCSS(centroids,training,ktrain_y)
  wcsstemp = wcss[k]
  write(outfile3, "K: ","$k","\n\n")
  write(outfile3, "WCSS:","\n","$wcsstemp","\n\n")

  #Problem 2, we now run on test set
  kmeans_y = MLLibrary.LearningAlgorithms.KMeans.runKMeans(centroids,test,k)

  predicted_y=zeros(Float64,size(test_y))

  #go through each cluster, clean cluster, QR train, and predict
  for j=1:k
    training_indices=find(x->x==j,ktrain_y)
    test_indices=find(x->x==j,kmeans_y)
    println(k,' ',j, ' ',size(training_indices))
    println(k,' ',j, ' ',size(test_indices))
    if !(0 in size(test_indices))
      #println(k,j)
      cluster_k= unscaled_training[training_indices,:];
      cluster_k_y = training_y[training_indices];
      test_cluster = unscaled_test[test_indices,:];
      # println(size(test_cluster))

      standarddeviation = MLLibrary.Statistics.stdColumn(cluster_k)
      latentvar = []
      for l=1:length(standarddeviation)
        if standarddeviation[l]>.001
          push!(latentvar,l)
        end
      end
      cluster_k=cluster_k[:,latentvar]
      test_cluster= test_cluster[:,latentvar]
      betacol = MLLibrary.LearningAlgorithms.LinearRegression.linearRegression(cluster_k,cluster_k_y,QRDecomposeMethod)
      predicted_y[test_indices,:] = test_cluster*betacol
    end
  end
  write(outfile2, "RMSES", "\n\n")
  write(outfile2, "K: ","$k","\n\n")
  rmse[k]= MLLibrary.Utils.ErrorAnalysis.calculateRootMeanStandardError(predicted_y,test_y);
  rmsetemp = rmse[k]
  write(outfile2, "RMSE:","\n","$rmsetemp","\n\n")

  # println(predicted_y,test_y)







end
close(outfile)
close(outfile2)
close(outfile3)
close(outfile4)

println(rmse);
p = plot(

  Guide.ylabel("WCSS"),
  Guide.xlabel("K"),
  Guide.title("Within Cluster Sum of Squares"),
  x=collect(keys(wcss)),
  y=collect(values(wcss)),
  Geom.line
  # Geom.label(position=:above),
  # label=map(string,(values(wcss)))
  #color="DataSet"
)


draw(PNG(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week4","WCSSErrors.png"), 800px, 600px), p)


p = plot(

  Guide.ylabel("RMSE"),
  Guide.xlabel("K"),
  Guide.title("Root Mean Square Error"),
  x=collect(keys(rmse)),
  y=collect(values(rmse)),
  Geom.line,
  Geom.label(position=:above),
  label=map(string,(values(rmse)))
  #color="DataSet"
)
draw(PNG(joinpath(Pkg.dir("MLLibrary"),"resources","paResources","Week4","RMSEErrors.png"), 800px, 600px), p)
