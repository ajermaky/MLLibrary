module Commons
  function backsolve(X,Y)

    row = size(X)[2]
    betacol = zeros(eltype(Y),row,1)

    iterator =row
    while iterator>0

      betacol[iterator] = (Y[iterator]- (X[iterator,:]*betacol)[1])/X[iterator,iterator]

      iterator-=1
    end

    return betacol



  end



end
