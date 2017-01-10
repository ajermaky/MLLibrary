using RunTests
using Base.Test

@testmodule ErrorAnalysisTest begin
  using MLLibrary

  function test_confusionMatrix()
    testset = [1 0 1 1 1 1 1 0 0 0 0]
    predset = [1 1 0 1 1 1 0 1 0 0 0]

    @test MLLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(testset,predset)==[0 0 1;
                    0 3 2;
                    1 2 4;]

    testset = [1 2 3 4 1 2 4 1 3 2 1 2]
    predset = [1 1 4 1 1 2 3 2 3 2 1 4]

    @test MLLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(testset,predset)==[0 1 2 3 4;
                    1 3 1 0 0;
                    2 1 2 0 1;
                    3 0 0 1 1;
                    4 1 0 1 0;]
  end

  function test_generateWeightedErrorRate()
    testset = [1 0 1 1 1 1 1 0 0 0 0]
    predset = [1 1 0 1 1 1 0 1 0 0 0]

    confusionmatrix =  MLLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(testset,predset)

    @test round(MLLibrary.Utils.ErrorAnalysis.calculateWeightedSuccessRate(confusionmatrix),2) == .63

    testset = [1 2 3 4 1 2 4 1 3 2 1 2]
    predset = [1 1 4 1 1 2 3 2 3 2 1 4]

    confusionmatrix= MLLibrary.Utils.ErrorAnalysis.generateConfusionMatrix(testset,predset)

    @test round(MLLibrary.Utils.ErrorAnalysis.calculateWeightedSuccessRate(confusionmatrix),2) == .44

  end

  function test_generateErrorRate()
    testset = [1 0 1 1 1 1 1 0 0 0 0]
    predset = [1 1 0 1 1 1 0 1 0 0 0]

    @test round(MLLibrary.Utils.ErrorAnalysis.calculateErrorRate(testset,predset),2)==.36
    #
    testset = [1 2 3 4 1 2 4 1 3 2 1 2]
    predset = [1 1 4 1 1 2 3 2 3 2 1 4]

    @test MLLibrary.Utils.ErrorAnalysis.calculateErrorRate(testset,predset)==.5


  end

  function test_calculateRootMeanStandardError()
    y=[1;2;3;4;5;6;1;2;3]
    observed = [0;4;2;1;5;2;1;6;1]

    @test round(MLLibrary.Utils.ErrorAnalysis.calculateRootMeanStandardError(observed,y),2)==2.38

  end

  function test_calculateWCSS()
    centroids=[1 2 3 4;5 6 7 8]
    data=[1 2 1 1;4 1 2 2; 5 2 1 4;3 3 2 1]
    y=[1;1;2;2]
    wcss = MLLibrary.Utils.ErrorAnalysis.calculateWCSS(centroids,data,y)
    println(wcss)

    @test wcss==183
  end


end
