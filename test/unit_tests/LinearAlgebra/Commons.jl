using RunTests
using Base.Test

@testmodule CommonsTest begin
  using MLLibrary
  function test_backsolve()

    A= MLLibrary.DataManipulation.DataTransform.convertToFloat([1 2 3; 0 4 6;0 0 9])
    B= MLLibrary.DataManipulation.DataTransform.convertToFloat([10;24;18])

    answer = [-2. 3. 2.]'
    @test MLLibrary.LinearAlgebra.Commons.backsolve(A,B)==answer

    A= MLLibrary.DataManipulation.DataTransform.convertToFloat([1 2 3; 0 4 6;0 0 9;0 0 0;0 0 0])
    @test MLLibrary.LinearAlgebra.Commons.backsolve(A,B)==answer


  end
end
