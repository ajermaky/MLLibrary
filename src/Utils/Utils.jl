module Utils
  files = ["ErrorAnalysis"]
  for f in files
    include("$f.jl")
  end


end
