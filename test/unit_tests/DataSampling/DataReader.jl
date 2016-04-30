@testmodule DataReaderTest begin
  using CSE151MachineLearningLibrary

  function test_DataSetMemory()

    resources=["abalone.data","3percent-miscategorization.csv","10percent-miscatergorization.csv","Seperable.csv"]
    for res in resources
      delimiter=","
      path = joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets",res)
      count = CSE151MachineLearningLibrary.DataParser.DataStream.getDataSetCount(path)

      featureCount = CSE151MachineLearningLibrary.DataParser.DataStream.getFeatureCount(path)
      threshold=.1
      srand(123)
      trainingsetindices = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getThresholdTrainingSetIndicies(path,count,threshold)
      srand(123)
      testsetindices = CSE151MachineLearningLibrary.DataSampling.ThresholdSampling.getThresholdTestSetIndices(path,count,threshold)

      trainingset = CSE151MachineLearningLibrary.DataSampling.DataReader.getDataSetInMemoryFromIndices(path,delimiter,trainingsetindices)

      testset = CSE151MachineLearningLibrary.DataSampling.DataReader.getDataSetInMemoryFromIndices(path,delimiter,testsetindices)
      @test size(trainingset)==(convert(Int,round(count*(1-threshold))),featureCount)
      @test size(testset)==(convert(Int,round(count*threshold)),featureCount)

    end


  end


end
