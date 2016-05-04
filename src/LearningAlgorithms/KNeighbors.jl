module KNeighbors
  using ...Statistics
  using Distances

  function KNearestNeighbors(trainingSet, testSet, training_y,K=1)
    # m = Statistics.meanColumn(trainingSet)
    # s = Statistics.stdColumn(trainingSet)
    # println("m and s calculatd!")
    # trainingSet=DataManipulation.DataTransform.zScale(trainingSet,m,s)
    # testSet=DataManipulation.DataTransform.zScale(testSet,m,s)
    # println("Scaled!")

    predicted_y=zeros(Float64, size(testSet)[1],1)
    dot_prod = zeros(Float64,size(testSet)[1], size(trainingSet)[1])
    for i=1:size(testSet)[1]
      testSetRow=testSet[i,:]
      for j=1:size(trainingSet)[1]
        dot_prod[i,j]=euclidean(testSetRow,trainingSet[j,:])
      end
    end
    println("we got our matrix!")
    for i=1:size(dot_prod)[1]
      #find the K smallest distances and get their labels. Take a majority. predicted_y[i] = majority
      indices = Statistics.getMinIndices(collect(dot_prod[i,:]),K)
      # println(typeof(indices));
      # println(indices)
      # println(typeof(training_y))
      # println(training_y)
      predicted_y[i]=Statistics.getMajority(training_y[indices];)

    end
    return predicted_y
    #return fn(test_y, predicted_y)

  end

end
