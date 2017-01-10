using RunTests
using Base.Test

@testmodule MultinomialBayesTest begin
  using MLLibrary

  function test_getCounts()
    A=[1. 2. 1. 5.;
       4. 2. 1. 10.;
       3. 3. 2. 6.;]

    @test MLLibrary.LearningAlgorithms.MultinomialBayes.getCounts(A)==[8. 7. 4. 21.];
  end

  function test_getDictionarySize()
    A=[1. 2. 1. 5.;
       4. 2. 1. 10.;
       3. 3. 2. 6.;]

    @test MLLibrary.LearningAlgorithms.MultinomialBayes.getDictionarySize(A)==4
  end

  function test_getClassiferCount()
    A=[1;2;2;1;0;2;3;1;5]
    @test MLLibrary.LearningAlgorithms.MultinomialBayes.getClassifierCount(A)==Dict(0=>1,1=>3,2=>3,3=>1,5=>1)

    A=[1;0;1;0;1;1;0;0;0;1;1]
    @test MLLibrary.LearningAlgorithms.MultinomialBayes.getClassifierCount(A)==Dict(0=>5,1=>6)
  end

  function test_getDictionary()
    A=[1. 2. 1. 5. 1.;
       4. 2. 1. 10. 0.;
       3. 3. 2. 6. 1.;]

    dict,dictProb = MLLibrary.LearningAlgorithms.MultinomialBayes.getDictionary(A[:,1:end-1],A[:,end])
    @test dict==Dict(1=>[4. 5. 3. 11.],0=>[4. 2. 1. 10.])
    for key in keys(dictProb)
      dictProb[key] = round(dictProb[key],2)
    end
    @test dictProb ==Dict(0=>[.24 .14 .10 .52],1=>[.19 .22 .15 .44])
  end

  function test_classifyDocuments()
    A=[1. 2. 1. 5. 1.;
       4. 2. 1. 10. 0.;
       3. 3. 2. 6. 1.;]

    B=[1. 1. 1. 3. 1;
       2. 2. 1. 4. 0.;
       4. 2. 1. 1. 0.;]
    dict,dictProb = MLLibrary.LearningAlgorithms.MultinomialBayes.getDictionary(A[:,1:end-1],A[:,end])
    @test MLLibrary.LearningAlgorithms.MultinomialBayes.classifyDocuments(B[:,1:end-1],dictProb) == [1.;1.;1.]''
  end


end
