module KMeans
  using ..KNeighbors
  using ...Statistics
  function Kmeans(training_set,test_set,k=1)
    centroids = trainKmeans(training_set,k);
    assignment = [1:k]
    return KNeighbors.KNearestNeighbors(centroids,test_set,assignment)


  end

  function trainKmeans(training_set,k)
    changed = true;
    #size is k by n
    centroids = initCentroids(training_set,k)
    assignment = [1:k]
    y=zeros(Int64,size(training_set)[1],1)
    while(changed)
      y=KNeighbors.KNearestNeighbors(centroids,training_set,assignment)
      newCentroids = recalculateCentroids(centroids,training_set,y);
      if centroids==newCentroids
        changed=false
      end
      centroids = newCentroids
    end
    return centroids,y;
  end
  #
  function initCentroids(training_set,k)

    return training_set[1:k, :]
  end

  function recalculateCentroids(centroids,training_set, y)
    for i=1:size(centroids)[1]
      centroids[i,:] = Statistics.meanColumn(training_set[find(x->x==i,y),:])
    end
    return centroids
  end


end
