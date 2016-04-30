using RunTests
using Base.Test

@testmodule ErrorAnalysisTest begin
  using CSE151MachineLearningLibrary

  function test_confusionMatrix()
    testset = [1 0 1 1 1 1 1 0 0 0 0]
    predset = [1 1 0 1 1 1 0 1 0 0 0]

    @test CSE151MachineLearningLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(testset,predset)==[0 0 1;
                    0 3 2;
                    1 2 4;]

    testset = [1 2 3 4 1 2 4 1 3 2 1 2]
    predset = [1 1 4 1 1 2 3 2 3 2 1 4]

    @test CSE151MachineLearningLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(testset,predset)==[0 1 2 3 4;
                    1 3 1 0 0;
                    2 1 2 0 1;
                    3 0 0 1 1;
                    4 1 0 1 0;]
  end

  function test_generateWeightedErrorRate()
    testset = [1 0 1 1 1 1 1 0 0 0 0]
    predset = [1 1 0 1 1 1 0 1 0 0 0]

    confusionmatrix =  CSE151MachineLearningLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(testset,predset)

    @test round(CSE151MachineLearningLibrary.Utils.ErrorAnalysis.calculateWeightedSuccessRate(confusionmatrix),2) == .63

    testset = [1 2 3 4 1 2 4 1 3 2 1 2]
    predset = [1 1 4 1 1 2 3 2 3 2 1 4]

    confusionmatrix= CSE151MachineLearningLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(testset,predset)

    @test round(CSE151MachineLearningLibrary.Utils.ErrorAnalysis.calculateWeightedSuccessRate(confusionmatrix),2) == .44

  end

  function test_generateErrorRate()
    testset = [1 0 1 1 1 1 1 0 0 0 0]
    predset = [1 1 0 1 1 1 0 1 0 0 0]

    @test round(CSE151MachineLearningLibrary.Utils.ErrorAnalysis.calculateErrorRate(testset,predset),2)==.36
    #
    testset = [1 2 3 4 1 2 4 1 3 2 1 2]
    predset = [1 1 4 1 1 2 3 2 3 2 1 4]

    @test CSE151MachineLearningLibrary.Utils.ErrorAnalysis.calculateErrorRate(testset,predset)==.5


  end


end
