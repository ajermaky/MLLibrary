
@testmodule ThresholdSamplingTest begin
  using CSE151MachineLearningLibrary
  function test_ThresholdTrainingIndices()

    resources=["abalone.data","3percent-miscategorization.csv","10percent-miscatergorization.csv","Seperable.csv"]
    for res in resources
      path = joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets",res)
      count = CSE151MachineLearningLibrary.DataParser.DataStream.getDataSetCount(path)

      threshold=.1
      srand(123)
      trainingset = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getThresholdTrainingSetIndicies(path,count,threshold)
      @test length(trainingset)==round(count*(1-threshold))
    end
  end

  function test_ThresholdTestIndicies()
    resources=["abalone.data","3percent-miscategorization.csv","10percent-miscatergorization.csv","Seperable.csv"]
    for res in resources
      path = joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets",res)
      count = CSE151MachineLearningLibrary.DataParser.DataStream.getDataSetCount(path)

      threshold=.1
      srand(123)
      testset = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getThresholdTestSetIndices(path,count,threshold)
      @test length(testset)==round(count*(threshold))
    end

  end

  function test_unionAndInterSection()
    resources=["abalone.data","3percent-miscategorization.csv","10percent-miscatergorization.csv","Seperable.csv"]
    for res in resources
      path = joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets",res)
      count = CSE151MachineLearningLibrary.DataParser.DataStream.getDataSetCount(path)

      threshold=.1
      srand(123)
      trainingset = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getThresholdTrainingSetIndicies(path,count,threshold)
      srand(123)
      testset = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getThresholdTestSetIndices(path,count,threshold)

      @test length(intersect(trainingset,testset))==0
      @test length(union(trainingset,testset))==count
      @test in(0,trainingset)==false
      @test in(0,testset)==false

    end
  end

end
