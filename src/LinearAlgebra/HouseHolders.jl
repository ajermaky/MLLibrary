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


    R[2:end,2:end]=newR


    return newHH*H,R
  end






end
