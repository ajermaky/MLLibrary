module Statistics
  using ..DataParser
  files = ["extrastats"]
  for f in files
    include("$f.jl")
  end


end
