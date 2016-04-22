@testmodule DataStreamTest begin
  using CSE151MachineLearningLibrary

  function test_DataSetCount()

    path = joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets")
    @test CSE151MachineLearningLibrary.DataParser.DataStream.getDataSetCount(joinpath(path,"abalone.data")) ==4177
    @test CSE151MachineLearningLibrary.DataParser.DataStream.getDataSetCount(joinpath(path,"3percent-miscategorization.csv")) ==10000
    @test CSE151MachineLearningLibrary.DataParser.DataStream.getDataSetCount(joinpath(path,"10percent-miscatergorization.csv")) ==10000
    @test CSE151MachineLearningLibrary.DataParser.DataStream.getDataSetCount(joinpath(path,"Seperable.csv")) ==10000



  end

  function test_getFeatureCount()
    path = joinpath(Pkg.dir("CSE151MachineLearningLibrary"),"resources","datasets")
    @test CSE151MachineLearningLibrary.DataParser.DataStream.getFeatureCount(joinpath(path,"abalone.data")) ==9
    @test CSE151MachineLearningLibrary.DataParser.DataStream.getFeatureCount(joinpath(path,"3percent-miscategorization.csv")) ==10
    @test CSE151MachineLearningLibrary.DataParser.DataStream.getFeatureCount(joinpath(path,"10percent-miscatergorization.csv")) ==10
    @test CSE151MachineLearningLibrary.DataParser.DataStream.getFeatureCount(joinpath(path,"Seperable.csv")) ==10
  end
#datastream = CSE151Seeder.getDataSet(path)


end
