@testmodule DataReaderTest begin
  using MLLibrary

  function test_DataSetMemory()

    resources=["abalone.data","3percent-miscategorization.csv","10percent-miscatergorization.csv","Seperable.csv"]
    for res in resources
      delimiter=","
      path = joinpath(Pkg.dir("MLLibrary"),"resources","datasets",res)
      count = MLLibrary.DataParser.DataStream.getDataSetCount(path)

      featureCount = MLLibrary.DataParser.DataStream.getFeatureCount(path)
      threshold=.1
      srand(123)
      trainingsetindices = MLLibrary.DataSampling.ThresholdSampling.getThresholdTrainingSetIndicies(path,count,threshold)
      srand(123)
      testsetindices = MLLibrary.DataSampling.ThresholdSampling.getThresholdTestSetIndices(path,count,threshold)

      trainingset = MLLibrary.DataSampling.DataReader.getDataSetInMemoryFromIndices(path,delimiter,trainingsetindices)

      testset = MLLibrary.DataSampling.DataReader.getDataSetInMemoryFromIndices(path,delimiter,testsetindices)
      @test size(trainingset)==(convert(Int,round(count*(1-threshold))),featureCount)
      @test size(testset)==(convert(Int,round(count*threshold)),featureCount)

    end


  end


end
