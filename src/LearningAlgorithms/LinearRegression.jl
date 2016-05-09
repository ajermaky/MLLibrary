module LinearRegression
  using CSE151MachineLearningLibrary
  function linearRegression(X,Y, qrFunc)
    qrFunc(X,Y)
    return CSE151MachineLearningLibrary.LinearAlgebra.Commons.backsolve(X,Y)


  end

end
