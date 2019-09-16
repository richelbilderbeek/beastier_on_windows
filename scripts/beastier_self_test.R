# beastier self-testing script

cat("=====================")
cat("Self-testing beastier")
cat("=====================")

library(beastier)

cat("Session info")
print(sessionInfo())

cat("beastier version:")
print(packageVersion("beastier"))

cat(paste("Is BEAST2 installed:", beastier::is_beast2_installed()))
cat(paste("BEAST2 version:", beastier::get_beast2_version()))

cat("---------------")
cat("Start self-test")
cat("---------------")

library(testthat)

testit::assert(is_beast2_installed())

cat("-------------------------")
cat("Create the BEAST2 options")
cat("-------------------------")

beast2_options <- create_beast2_options(
  input_filename = get_beastier_path("2_4.xml"),
  verbose = TRUE
)

expect_false(file.exists(beast2_options$output_log_filename))
expect_false(file.exists(beast2_options$output_trees_filenames))
expect_false(file.exists(beast2_options$output_state_filename))

cat("---------------")
cat("Do a BEAST2 run")
cat("---------------")
output <- run_beast2_from_options(beast2_options)

expect_true(length(output) > 40)
expect_true(file.exists(beast2_options$output_log_filename))
expect_true(file.exists(beast2_options$output_trees_filenames))
expect_true(file.exists(beast2_options$output_state_filename))

cat("============================")
cat("Self-test of beastier passed")
cat("============================")
