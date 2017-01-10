using RunTests
using Base.Test

@testmodule DataTransformTest begin
using MLLibrary

  function test_proxyColumns()
    gender = ["M" "F" "M" "M" "F"]
    month=[1 3 2 1 8]
    A=[gender' month']
    proxycolumns = [Dict("column"=>1,"proxy"=>["M" "F"]) Dict("column"=>2,"proxy"=>collect(1:12))]
    @test MLLibrary.DataManipulation.DataTransform.addProxyColumns(A,proxycolumns)==
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
    @test MLLibrary.DataManipulation.DataTransform.zScale(MLLibrary.DataManipulation.DataTransform.convertToFloat(A))==[-1.161895003862225 -1.161895003862225 -1.161895003862225 -1.161895003862225
 -0.3872983346207417 -0.3872983346207417 -0.3872983346207417 -0.3872983346207417
 0.3872983346207417 0.3872983346207417 0.3872983346207417 0.3872983346207417
 1.161895003862225 1.161895003862225 1.161895003862225 1.161895003862225]

 @test MLLibrary.DataManipulation.DataTransform.zScale(A, 1, 1)==[0 1 2 3; 4 5 6 7; 8 9 10 11; 12 13 14 15]
  end

  function test_floatConversion()
    A=["1" 2 3.1 "3.2"]
    @test round(MLLibrary.DataManipulation.DataTransform.convertToFloat(A),1)==[1. 2. 3.1 3.2]
  end

  function test_zScaleColumn()
    A=MLLibrary.DataManipulation.DataTransform.convertToFloat([1 2 3 4;5 6 7 8;
       9 10 11 12; 13 14 15 16])
    Expected = [-1.161895003862225;
        -0.3872983346207417;
         0.3872983346207417;
         1.161895003862225]
    @test MLLibrary.DataManipulation.DataTransform.zScaleColumn(A,1)==[Expected A[:,2:end]]
         @test MLLibrary.DataManipulation.DataTransform.zScaleColumn(A,2)==[Expected Expected A[:,3:end]]
         @test MLLibrary.DataManipulation.DataTransform.zScaleColumn(A,3)==[Expected Expected Expected A[:,4]]
         @test MLLibrary.DataManipulation.DataTransform.zScaleColumn(A,4)==[Expected Expected Expected Expected]

  end

end
