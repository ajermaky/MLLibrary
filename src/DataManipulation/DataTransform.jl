module DataTransform

  using ...Statistics
  #assume that you have a matrix m-n

  function convertToFloat(A)
    for i=1:length(A)
      val = A[i]
      #println(typeof(val))

      if typeof(val)==Int64
        A[i]=convert(Float64,val)
      elseif typeof(val)==ASCIIString || typeof(val)==SubString{ASCIIString}
        A[i]=parse(Float64,val)
      end
    end
    return convert(Array{Float64,ndims(A)}, A)

  end

  function addProxyColumns(A,proxyColumns)
    columns=[]
    for i in proxyColumns

      #for every column, create the proxy columns, find indicies for each, and yeah.
      col = i["column"]
      push!(columns,col)
      proxyentries = i["proxy"]

      proxy = zeros(Int, size(A)[1],length(proxyentries))
      column = A[:,col]
      for j=1:length(proxyentries)
        proxy[find(column.==proxyentries[j]),j]=1
      end
      A=[A proxy];
    end
    allcolumns = collect(1:size(A)[2])
    return A[:,setdiff(allcolumns,columns)];
  end

  function zScale(A,mean=nothing, std=nothing)
    if mean==nothing || std==nothing
      mean=Statistics.meanColumn(A)
      std = Statistics.stdColumn(A)
    end
    std= 1./std
    #B= convert(Array{Float64,2}, A)
    for i=1:size(A)[1]
        A[i,:]= (A[i,:]-mean).*std
    end
    return A

  end

end
