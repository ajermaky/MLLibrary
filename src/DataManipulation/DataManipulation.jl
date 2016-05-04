module DataManipulation
  files = ["DataTransform"]
  for f in files
    include("$f.jl")
  end






end
