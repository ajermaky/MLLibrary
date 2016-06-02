using Gadfly
using Colors
using CSE151MachineLearningLibrary


path=joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets")
seed=11
threshold =.1
delimiter = ","

#resources = ["3percent-miscategorization","10percent-miscatergorization","abalone.data","Seperable.csv"]
resources=["res"=>"SpamDataPruned.csv" ,"proxy"=>[],"path"=>Pkg.dir("CSE151MachineLearningLibrary","resources","datasets")]


training, test = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getSets(joinpath(resources["path"],resources["res"]),",",threshold,seed)

# println(size(training), size(test))

training = CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(training)
test = CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(test)

training_data = training[:,1:end-1]
test_data = test[:,1:end-1]
training_labels = training[:,end]
test_labels = test[:,end]

dict, dictProb = CSE151MachineLearningLibrary.LearningAlgorithms.MultinomialBayes.getDictionary(training_data,training_labels)

predicted_labels = CSE151MachineLearningLibrary.LearningAlgorithms.MultinomialBayes.classifyDocuments(test_data,dictProb)

# println(size(predicted_labels),size(test_labels))
println(CSE151MachineLearningLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(test_labels,predicted_labels)
)
