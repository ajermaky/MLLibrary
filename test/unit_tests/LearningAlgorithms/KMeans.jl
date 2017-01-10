using RunTests
using Base.Test

@testmodule KNeighborsTest begin
  using MLLibrary

  function test_trainKMeans()
      # path = joinpath(Pkg.dir("MLLibrary"),"resources","datasets","test.csv")
      # seed=123
      # trainingSet, testSet = MLLibrary.DataSampling.ThresholdSampling.getSets(path, ",",.1,seed)
      #
      # trainingSet = MLLibrary.DataManipulation.DataTransform.convertToFloat(trainingSet)
      #
      # println(trainingSet)
      # println(MLLibrary.LearningAlgorithms.KMeans.trainKmeans(trainingSet, 4))
      #
      # @test 1==1

  end
end
