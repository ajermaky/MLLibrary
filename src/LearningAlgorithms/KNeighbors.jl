module KNeighbors
  using ..DataManipulation
  using ..Statistics
  using Distances

  function KNeighbors(trainingSet, testSet, training_y,test_y, fn,K=1)
    m = Statistics.meanColumn(trainingSet)
    s = Statistics.stdColumn(trainingSet)
    println("m and s calculatd!")
    trainingSet=DataManipulation.DataTransform.zScale(trainingSet,m,s)
    testSet=DataManipulation.DataTransform.zScale(testSet,m,s)
    println("Scaled!")

    predicted_y=zeros(test_y)
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
      indices = ExtraStats.getMinIndices(collect(dot_prod[i,:]),K)
      predicted_y[i]=ExtraStats.getMajority(training_y[indices])

    end
    return fn(test_y, predicted_y)

  end

end
