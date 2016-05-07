using RunTests
using Base.Test

@testmodule HouseHoldersTest begin
  using CSE151MachineLearningLibrary
  function test_QRDecompose()
    A=[2. 2 4. 18.;
       1. 3. -2. 1.;
       3. 1. 3. 14.]

    Q,R = CSE151MachineLearningLibrary.LinearAlgebra.HouseHolders.QRDecompose(A)
    @test round(Q,2) ==[-.53 -.22 .82;-.27 -.87 -.41; -.8 .44 -.41]
    @test round(R,2)==[-3.74 -2.67 -4.01 -21.11;0 -2.62 2.18 1.31; 0 0 2.86 8.57]
    @test round(norm(Q)) ==1.


    B=[1. -1. -1.;
       1. 2. 3.;
       2. 1. 1.;
       2. -2. 1.;
       3. 2. 1.]
     Q,R = CSE151MachineLearningLibrary.LinearAlgebra.HouseHolders.QRDecompose(B)
     @test round(Q,2) ==[-.23 -.23 -.46 -.46 -.69;.35 -.49 -.13 .71 -.34;-.37 .7 -.06 .47 -.38; -.67 -.42 .59 .11 -.1; -.49 -.19 -.65 .23 .5]'
     @test round(R,2) ==[-4.36 -1.15 -2.06; 0 -3.56 -1.58; 0 0 2.5; 0 0 0; 0 0 0]
     @test round(norm(Q)) ==1.  end

  function test_decompose()
    A=[2. 2 4. 18.;
       1. 3. -2. 1.;
       3. 1. 3. 14.]

    Q,R = CSE151MachineLearningLibrary.LinearAlgebra.HouseHolders.decompose(A)
    @test round(Q,2) ==[-.53 -.22 .82;-.27 -.87 -.41; -.8 .44 -.41]'
    @test round(R,2)==[-3.74 -2.67 -4.01 -21.11;0 -2.62 2.18 1.31; 0 0 2.86 8.57]
    @test round(norm(Q)) ==1.


    B=[1. -1. -1.;
       1. 2. 3.;
       2. 1. 1.;
       2. -2. 1.;
       3. 2. 1.]
     Q,R = CSE151MachineLearningLibrary.LinearAlgebra.HouseHolders.decompose(B)
     @test round(Q,2) ==[-.23 -.23 -.46 -.46 -.69;.35 -.49 -.13 .71 -.34;-.37 .7 -.06 .47 -.38; -.67 -.42 .59 .11 -.1; -.49 -.19 -.65 .23 .5]
     @test round(R,2) ==[-4.36 -1.15 -2.06; 0 -3.56 -1.58; 0 0 2.5; 0 0 0; 0 0 0]
     @test round(norm(Q)) ==1.

  end

end
