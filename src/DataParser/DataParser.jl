module DataParser
  files=["DataStream"]
  for file in files
    include("$file.jl")
  end

end
