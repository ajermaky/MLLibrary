using RunTests
using Base.Test

@testmodule ExtraStatisticsTest begin
  using CSE151MachineLearningLibrary

  function test_meanColumn()
    A = [1 2 3 4;5 6 7 8]
    @test CSE151MachineLearningLibrary.Statistics.meanColumn(A)==[3.0 4.0 5.0 6.0]
    # @test 1==0
  end

  function test_stdColumn()
    A = [1 2 3 4;5 6 7 8]
    @test CSE151MachineLearningLibrary.Statistics.stdColumn(A)==[2.8284271247461903 2.8284271247461903 2.8284271247461903 2.8284271247461903]
    # @test 1==0
  end

  function test_sumColumn()
    A = [1 2 3 4;5 6 7 8]
    @test CSE151MachineLearningLibrary.Statistics.sumColumn(A)==[6 8 10 12]
    # @test 1==0
  end

  function test_getMinIndices()
    A=[1;2;-1;5;3;2;9;-3; 10]
    @test CSE151MachineLearningLibrary.Statistics.getMinIndices(A)==[8]
    @test CSE151MachineLearningLibrary.Statistics.getMinIndices(A,2)==[8, 3]
    @test CSE151MachineLearningLibrary.Statistics.getMinIndices(A,3)==[8, 3, 1]
    @test CSE151MachineLearningLibrary.Statistics.getMinIndices(A,4)==[8, 3, 1, 2]
  end

  function test_getMajority()
    A=[1;2;-1;5;3;2;9;-3;10]
    @test CSE151MachineLearningLibrary.Statistics.getMajority(A)==2
    A=[1;2;1;5;3;2;9;-3;10]
    maj=CSE151MachineLearningLibrary.Statistics.getMajority(A)
    @test maj==1 || maj==2
    A=[1]
    @test CSE151MachineLearningLibrary.Statistics.getMajority(A)==1


  end
end
