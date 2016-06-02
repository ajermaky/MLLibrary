module MultinomialBayes
  using ...Statistics
  using StatsBase

  function getCounts(dataset)
    return Statistics.sumColumn(dataset)
  end

  function getDictionarySize(dataset)
    return size(dataset)[2]
  end

  function getClassifierCount(labels)
    return countmap(labels)
  end

  function getDictionary(data, labels)
    classifier_counts = getClassifierCount(labels)
    dictionarySize = getDictionarySize(data)
    dictionary = Dict{Integer, Array{Float64,2}}();
    dictionaryProbabilities = Dict{Integer, Array{Float64,2}}()
    for key in keys(classifier_counts)
      dictionary[key] = getCounts(data[find(x-> x==key,labels),:])
    #  println((sum(dictionary[key])))
      dictionaryProbabilities[key] = (dictionary[key].+1)./(sum(dictionary[key])+dictionarySize)
    end

    return dictionary, dictionaryProbabilities
  end

  function classifyDocuments(documents, dictionaryProb)
    predictedLabels = zeros(Float64,size(documents)[1],1)
    for i=1:size(documents)[1]
      probabilities = Dict()
      for key in keys(dictionaryProb)
        println(filter!(x->x!=0,dictionaryProb[key].^documents[i,:]))
        probabilities[key] = prod(dictionaryProb[key].^documents[i,:])
      end
      #println(probabilities)
      predictedLabels[i]=collect(keys(probabilities))[indmax(collect(values(probabilities)))]
    end

    return predictedLabels
  end

end
