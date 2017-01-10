using Gadfly
using Colors
using MLLibrary


path=joinpath(Pkg.dir("MLLibrary"),"resources","datasets")
seed=11
threshold =.1
delimiter = ","

#resources = ["3percent-miscategorization","10percent-miscatergorization","abalone.data","Seperable.csv"]
resources=["res"=>"SpamDataPruned.csv" ,"proxy"=>[],"path"=>Pkg.dir("MLLibrary","resources","datasets")]


training, test = MLLibrary.DataSampling.ThresholdSampling.getSets(joinpath(resources["path"],resources["res"]),",",threshold,seed)

# println(size(training), size(test))

training = MLLibrary.DataManipulation.DataTransform.convertToFloat(training)
test = MLLibrary.DataManipulation.DataTransform.convertToFloat(test)

training_data = training[:,1:end-1]
test_data = test[:,1:end-1]
training_labels = training[:,end]
test_labels = test[:,end]

dict, dictProb = MLLibrary.LearningAlgorithms.MultinomialBayes.getDictionary(training_data,training_labels)

predicted_labels = MLLibrary.LearningAlgorithms.MultinomialBayes.classifyDocuments(test_data,dictProb)

# println(size(predicted_labels),size(test_labels))
println(MLLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(test_labels,predicted_labels)
)
