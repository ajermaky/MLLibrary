function meanColumn(A)
  return mean(A,1)
end


function stdColumn(A)
  return std(A,1)
end

function sumColumn(A)
  return sum(A,1)
end

function getMinIndices(A,K=1)
  return sortperm(A)[1:K]
end

function getMajority(A)
  B=Dict()
  for i in A
    if haskey(B,i)
      B[i]+=1
    else
      B[i]=1
    end

  end

  max= maximum(values(B))
  # println(B)
  # println(max)
  filteredresults = filter(((k,v)->v==max),B)
  indices = collect(keys(filteredresults))
  return indices[rand(1:length(indices))]
end
