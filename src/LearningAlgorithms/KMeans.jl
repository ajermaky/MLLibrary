module KMeans
  using ..KNeighbors
  using ...Statistics
  using Distances
  function Kmeans(training_set,test_set,k=1)
    centroids = trainKmeans(training_set,k);
    assignment = [1:k]
    return KNeighbors.KNearestNeighbors(centroids,test_set,assignment)


  end

  function runKMeans(centroids,dataset,k)
    assignment = 1:k
    return KNeighbors.KNearestNeighbors(centroids,dataset,assignment)
  end

  function trainKmeans(training_set,k,seed)
    changed = true;
    #size is k by n
    centroids = initCentroids(training_set,k,seed)
    assignment = 1:k
    y=zeros(Int64,size(training_set)[1],1)
    index = 0;
    while(changed)
      index+=1
    #  println(centroids)
      y=KNeighbors.KNearestNeighbors(centroids,training_set,assignment)
    #  println(y)
      newCentroids = recalculateCentroids(centroids,training_set,y);
    #  println(newCentroids)
      if centroids==newCentroids
        changed=false
      end
      centroids = newCentroids
    end
    #println(index)
    return centroids,y;
  end
  #
  function initCentroids(training_set,k,seed)
    indices = []
    srand(seed)
    indices=randperm(size(training_set)[1])[1:k]
    return training_set[indices, :]
  end

  function recalculateCentroids(centroids,training_set, y)
    newCentroids = zeros(Float64,size(centroids))
    for i=1:size(centroids)[1]
      newCentroids[i,:] = Statistics.meanColumn(training_set[find(x->x==i,y),:])
    end
    return newCentroids
  end


end
