module ThresholdSampling
  using MLLibrary
  using ..DataParser
  function getThresholdDataSetIndicies(file,size,threshold,isTest)
    number_remaining =size
    isTest ? multiplier = threshold : multiplier=1-threshold
    number_needed =convert(Int,round(number_remaining*(multiplier)))
    #  println(number_needed)
    dataset= zeros(Int,number_needed,1)
    probability = number_needed/number_remaining
    line=0;
    index =0;
    stream = DataParser.DataStream.getDataSet(file)
    for i in enumerate(eachline(stream))
      #println(i)
      if number_needed==0
        break;
      end

      line+=1
      number_remaining-=1
      random = rand()
      if isTest? random <= (probability): random > (1-probability)
        index+=1
        dataset[index]=line
        number_needed-=1
      end

      probability = number_needed/number_remaining


    end
    DataParser.DataStream.closeDataSet(stream)
    return dataset

  end
  #assume that srand() will be called! this is important
  function getThresholdTrainingSetIndicies(file,size,threshold)
    getThresholdDataSetIndicies(file,size,threshold,false)
  end

  function getThresholdTestSetIndices(file,size, threshold)
    getThresholdDataSetIndicies(file,size,threshold,true)
  end


  function getThresholdDataSetInMemory(file,indices,datatype)
  size = DataParser.DataStream.getDataSetCount(file)
  #indices = datasetFunction(file,size,threshold)
  featureCount = DataParser.DataStream.getFeatureCount(file);
  stream = DataParser.DataStream.getDataSet(file)
  dataset = cell(length(indices),featureCount)
  index=0;
  loc=1

  for line in eachline(stream)
    index+=1
    if in(index,indices)
      dataset[loc,:]= split(strip(line,'\n'),",")
      loc+=1
    end

  end
  #println(size(testset))

  closeDataSet(stream)

  return dataset
end


function getTestSet(file,delimiter,threshold,datatype=Any)
  count = MLLibrary.DataParser.DataStream.getDataSetCount(file)
  indices =getThresholdTestSetIndices(file,count,threshold)

  return MLLibrary.DataSampling.DataReader.getDataSetInMemoryFromIndices(file,delimiter,indices)

end


function getTrainingSet(file,delimiter,threshold,datatype=Any)
  count = MLLibrary.DataParser.DataStream.getDataSetCount(file)
  indices = getThresholdTrainingSetIndicies(file,count,threshold)
  return MLLibrary.DataSampling.DataReader.getDataSetInMemoryFromIndices(file,delimiter,indices)
end

  function getSets(file,delimiter,threshold,seed=1,datatype=Any)
    srand(seed)
    trainingset = getTrainingSet(file,delimiter,threshold,datatype)
    srand(seed)
    testset = getTestSet(file,delimiter,threshold,datatype)
    return trainingset, testset
  end


end
