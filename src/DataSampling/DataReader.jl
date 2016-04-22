module DataReader
  using ..DataParser
  function getDataSetInMemoryFromIndices(file,delimiter,indices,datatype=Any)
    size = DataParser.DataStream.getDataSetCount(file)
    #indices = datasetFunction(file,size,threshold)
    featureCount = DataParser.DataStream.getFeatureCount(file,delimiter);
    stream = DataParser.DataStream.getDataSet(file)
    dataset = cell(length(indices),featureCount)
    index=0;
    loc=1
    for line in eachline(stream)
      index+=1
      if in(index,indices)
        dataset[loc,:]= split(strip(line,'\n'),delimiter)
        loc+=1
      end

    end
    #println(size(testset))

    DataParser.DataStream.closeDataSet(stream)

    return dataset
  end


end
