@testmodule DataStreamTest begin
  using MLLibrary

  function test_DataSetCount()

    path = joinpath(Pkg.dir("MLLibrary"),"resources","datasets")
    @test MLLibrary.DataParser.DataStream.getDataSetCount(joinpath(path,"abalone.data")) ==4177
    @test MLLibrary.DataParser.DataStream.getDataSetCount(joinpath(path,"3percent-miscategorization.csv")) ==10000
    @test MLLibrary.DataParser.DataStream.getDataSetCount(joinpath(path,"10percent-miscatergorization.csv")) ==10000
    @test MLLibrary.DataParser.DataStream.getDataSetCount(joinpath(path,"Seperable.csv")) ==10000



  end

  function test_getFeatureCount()
    path = joinpath(Pkg.dir("MLLibrary"),"resources","datasets")
    @test MLLibrary.DataParser.DataStream.getFeatureCount(joinpath(path,"abalone.data")) ==9
    @test MLLibrary.DataParser.DataStream.getFeatureCount(joinpath(path,"3percent-miscategorization.csv")) ==10
    @test MLLibrary.DataParser.DataStream.getFeatureCount(joinpath(path,"10percent-miscatergorization.csv")) ==10
    @test MLLibrary.DataParser.DataStream.getFeatureCount(joinpath(path,"Seperable.csv")) ==10
  end


end
