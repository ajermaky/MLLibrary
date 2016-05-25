module HouseHolders

  function QRDecompose(R)
    println("computing I")
    I=eye(size(R)[1])
    println("phew")
    Q,R= decompose(R)
    return Q',R
  end
  function decompose(R)
    println(size(R))
    if 0 in size(R)

      return eye(size(R)[1]),1
    end
    a1 = R[:,1]
    lena1 = norm(a1)
    d11 = a1[1]>0?-1*lena1:lena1
    w11 = a1[1]-d11
    f1 = sqrt(-2*w11*d11)
    v = [w11; a1[2:end]]/f1
    #println(a1,lena1,d11,w11,f1,v)
    #A = 2*v*v'
    println("computing H...")
    H=eye(size(R)[1])
    BLAS.gemm!('N','T',-2.,v,v,1.0,H)
  #  println(H)

    println("did i compute H?")
    for i=1:size(R)[1]
      R[i,1]=0.
    end

    println("did i clear column1?")
    for i=2:size(R)[2]
      ai =R[:,i]
      fi = (2*v'*ai)[1]
      R[:,i] = ai-fi*v
    end
    # R=H*R
    R[1,1]=d11
  #  println(R)
  println("is it the matrix multiply??")

    newH,newR = decompose(R[2:end,2:end])
    newHH = eye(size(H)[1])
    # println(newHH)
    # println(newH)
    newHH[2:end,2:end]=newH
    println(newHH)


    R[2:end,2:end]=newR

    println("heh?")
    return BLAS.gemm('N','N',newHH,H),R
  end

  function householdDecompose(R,y)
    return decompose(R,y,1)
  end

  function decompose(R,y,n)
    if n-1 in size(R)
      return
    end
    #computes our needed values
    a1 = R[n:end,n]
    lena1 = norm(a1)
    d11 = a1[1]>0?-1*lena1:lena1
    w11 = a1[1]-d11
    f1 = sqrt(-2*w11*d11)
    v = [w11; a1[2:end]]/f1
    #clear out that first column
    for i=n:size(R)[1]
      R[i,n]=0.
    end
    #iterative approach to do Hai.
    for i=n+1:size(R)[2]
      ai =R[n:end,i]
      fi = (2*v'*ai)[1]
      R[n:end,i] = ai-fi*v
    end
    R[n,n]=d11

    #Optimized way to update y without matrices!
    y[n:end]-=2*(y[n:end]'*v)[1]*v

    return decompose(R,y,n+1)
  end
end
