module ErrorAnalysis
  using ...Statistics

  function generateConfusionMatrix(test_set,predicted_set)
    maxval = convert(Int,max(maximum(test_set),maximum(predicted_set)))
    minval = 1

    if(maxval==1)
      minval=0

      confusionmatrix = zeros(Int,maxval+1,maxval+1)

      for i=1:length(test_set)
        #println(test_set[i]," ",predicted_set[i])
        confusionmatrix[test_set[i]+1, predicted_set[i]+1]+=1
      end
    else
      confusionmatrix = zeros(Int,maxval,maxval)

      for i=1:length(test_set)
        #println(test_set[i]," ",predicted_set[i])
        confusionmatrix[test_set[i], predicted_set[i]]+=1
      end
    end
    topRow = collect(minval:maxval)
    sideRow = [0; topRow]



    return [sideRow [topRow';confusionmatrix]]

  end

  function calculateErrorRate(test_set,predicted_set)
    incorrect=0
    for i=1:length(test_set)
      if test_set[i]!=predicted_set[i]
        incorrect+=1
      end
    end
    println(incorrect/length(test_set))
    return incorrect/length(test_set)
  end

  function calculateWeightedSuccessRate(confusionmatrix)
    confusionmatrix = confusionmatrix[2:end,:]
    confusionmatrix = confusionmatrix[:,2:end]

    totals = Statistics.sumColumn(confusionmatrix)
    correct = diag(confusionmatrix)'

    averages = filter(x->!isnan(x),correct.*(1.0./totals))
    return mean(averages)
  end


  function calculateRootMeanStandardError(observed,actual)
    y = actual-observed;
    return sqrt(y'*y/length(y))[1]
  end

  function calculateWCSS(centroids,dataset, y)
    wcss = 0;
    for i=1:size(centroids)[1]
      cent = centroids[i,:]
      newdataset =dataset[find(x->x==i,y),:]
      wcss+=sum(newdataset*cent')
    end
    return wcss
  end

end
