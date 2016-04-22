using CSE151MachineLearningLibrary
using RunTests
using Base.Test
module RegressionTest

end

RunTests.set_show_progress(false)

println("Running Tests")
println("...")

tests = ["unit_tests"]

for t in tests
  run_tests(t)
end

println("...")
println("Tests Done")
