using RunTests
using Base.Test

@testmodule KNeighborsTest begin
  using MLLibrary

  function test_KNearestNeighbors()
    A = [1 0 1 1 0 0;
         0 1 1 1 1 1;
         0 1 0 0 0 1;
         1 1 1 0 0 0;
         1 1 1 0 1 0;
         1 1 0 0 0 0]

    B = [1;0;0;1;0;0]
    #Predicted = [1;2.23606;2; 1;1.4142;1.4142]

    Test = [1 0 1 0 0 0]

    Theoretical = [1;1;0]
    for i=1:3
      actual = MLLibrary.LearningAlgorithms.KNeighbors.KNearestNeighbors(A,Test,B,(i*2)-1)

      @test actual[1] == Theoretical[i]
    end

  end
end
