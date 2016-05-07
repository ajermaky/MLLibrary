
path =Pkg.dir("CSE151MachineLearningLibrary","resources","datasets","Week3","regression-0.05.csv")
seed=123
training, test = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getSets(path,",",.1,seed)

training = CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(training)
test= CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(test)
println("Data is ready")
println(typeof(training))

betacol = CSE151MachineLearningLibrary.LearningAlgorithms.LinearRegression.linearRegression(training[:,1:end-1],training[:,end-1:end],CSE151MachineLearningLibrary.LinearAlgebra.HouseHolders.QRDecompose)


println("finished dcomposing")
test_y = test[:,end-1:end]
test = test[:,1:end-1]

observed = test*betacol

println(CSE151MachineLearningLibrary.Utils.ErrorAnalysis.calculateRootMeanStandardError(observed,test_y))
