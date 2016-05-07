module LinearRegression
  function linearRegression(X,Y, qrFunc)
    Q,R = qrFunc(X)
    return CSE151MachineLearningLibrary.LinearAlgebra.Commons.backsolve(R,Q'*Y)


  end

end
