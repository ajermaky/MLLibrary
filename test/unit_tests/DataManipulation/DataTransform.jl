using RunTests
using Base.Test

@testmodule DataTransformTest begin
using CSE151MachineLearningLibrary

  function test_proxyColumns()
    gender = ["M" "F" "M" "M" "F"]
    month=[1 3 2 1 8]
    A=[gender' month']
    proxycolumns = [Dict("column"=>1,"proxy"=>["M" "F"]) Dict("column"=>2,"proxy"=>collect(1:12))]
    @test CSE151MachineLearningLibrary.DataManipulation.DataTransform.addProxyColumns(A,proxycolumns)==
    [1 0 1 0 0 0 0 0 0 0 0 0 0 0;
     0 1 0 0 1 0 0 0 0 0 0 0 0 0;
     1 0 0 1 0 0 0 0 0 0 0 0 0 0;
     1 0 1 0 0 0 0 0 0 0 0 0 0 0;
     0 1 0 0 0 0 0 0 0 1 0 0 0 0]
    # @test 1==0
  end

  function test_zScale()
    A=[1 2 3 4;5 6 7 8;
       9 10 11 12; 13 14 15 16]
    @test CSE151MachineLearningLibrary.DataManipulation.DataTransform.zScale(CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(A))==[-1.161895003862225 -1.161895003862225 -1.161895003862225 -1.161895003862225
 -0.3872983346207417 -0.3872983346207417 -0.3872983346207417 -0.3872983346207417
 0.3872983346207417 0.3872983346207417 0.3872983346207417 0.3872983346207417
 1.161895003862225 1.161895003862225 1.161895003862225 1.161895003862225]

 @test CSE151MachineLearningLibrary.DataManipulation.DataTransform.zScale(A, 1, 1)==[0 1 2 3; 4 5 6 7; 8 9 10 11; 12 13 14 15]
  end

  function test_floatConversion()
    A=["1" 2 3.1 "3.2"]
    @test CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat(A)==[1. 2. 3.1 3.2]
  end
end
