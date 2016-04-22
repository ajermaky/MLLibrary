module DataStream
  function getDataSet(file)
    stream = open(file);
  end
  function getDataSetCount(file)
    dataset = getDataSet(file)
    line=0;
    for i in enumerate(eachline(dataset))
      #println(i)
      line+=1
    end
    closeDataSet(dataset)

    return line;
  end

  function getFeatureCount(file, delimiter=",")
    dataset = getDataSet(file)
    line=readline(dataset);

    closeDataSet(dataset)

    return length(split(line,delimiter));
  end

  function resetStream(stream)
    seekstart(stream)
  end

  function closeDataSet(stream)
    close(stream)
  end
end
