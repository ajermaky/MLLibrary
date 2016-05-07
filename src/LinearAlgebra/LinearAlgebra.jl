module LinearAlgebra
  files = ["Commons","HouseHolders"]
  for f in files
    include("$f.jl")
  end
end
