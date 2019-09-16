# beastier self-testing script

print("=====================")
print("Self-testing beastier")
print("=====================")

library(beastier)

print("------------")
print("Session info")
print("------------")

print(sessionInfo())

print("--------------------------")
print("beastier's package version")
print("--------------------------")

print(packageVersion("beastier"))

print("--------------------------")
print("Show functions in package ")
print("--------------------------")

print(lsf.str("package:beastier"))

print("---------------")
print("Start self-test")
print("---------------")

library(testthat)

testit::assert(is_beast2_installed())

print("Create the BEAST2 options")

beast2_options <- create_beast2_options(
  input_filename = get_beastier_path("2_4.xml"),
  verbose = TRUE
)

expect_false(file.exists(beast2_options$output_log_filename))
expect_false(file.exists(beast2_options$output_trees_filenames))
expect_false(file.exists(beast2_options$output_state_filename))

print("Do a BEAST2 run")
output <- run_beast2_from_options(beast2_options)

expect_true(length(output) > 40)
expect_true(file.exists(beast2_options$output_log_filename))
expect_true(file.exists(beast2_options$output_trees_filenames))
expect_true(file.exists(beast2_options$output_state_filename))

print("============================")
print("Self-test of beastier passed")
print("============================")
