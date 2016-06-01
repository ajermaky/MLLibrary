using RunTests
using Base.Test

@testmodule KNeighborsTest begin
  using CSE151MachineLearningLibrary

  function test_trainKMeans()
      # path = joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets","test.csv")
      # seed=123
      # trainingSet, testSet = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getSets(path, ",",.1,seed)
      #
      # trainingSet = CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(trainingSet)
      #
      # println(trainingSet)
      # println(CSE151MachineLearningLibrary.LearningAlgorithms.KMeans.trainKmeans(trainingSet, 4))
      #
      # @test 1==1

  end
end
