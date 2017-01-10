module LinearRegression
  using MLLibrary
  function linearRegression(X,Y, qrFunc)
    qrFunc(X,Y)
    return MLLibrary.LinearAlgebra.Commons.backsolve(X,Y)


  end

end
