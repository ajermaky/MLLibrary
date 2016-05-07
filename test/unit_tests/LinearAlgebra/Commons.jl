using RunTests
using Base.Test

@testmodule CommonsTest begin
  using CSE151MachineLearningLibrary
  function test_backsolve()

    A= CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat([1 2 3; 0 4 6;0 0 9])
    B= CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat([10;24;18])

    answer = [-2. 3. 2.]'
    @test CSE151MachineLearningLibrary.LinearAlgebra.Commons.backsolve(A,B)==answer

    A= CSE151MachineLearningLibrary.DataManipulation.DataTransform.convertToFloat([1 2 3; 0 4 6;0 0 9;0 0 0;0 0 0])
    @test CSE151MachineLearningLibrary.LinearAlgebra.Commons.backsolve(A,B)==answer


  end
end
