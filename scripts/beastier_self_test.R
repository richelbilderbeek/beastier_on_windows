# beastier self-testing script

cat("=====================")
cat("Self-testing beastier")
cat("=====================")

library(beautier)
library(beastier)

cat("Session info")
message(sessionInfo())

cat("beastier version:")
message(packageVersion("beastier"))

cat(paste("Is BEAST2 installed:", beastier::is_beast2_installed()))
cat(paste("BEAST2 version:", beastier::get_beast2_version()))

cat("---------------")
cat("Start self-test")
cat("---------------")

library(testthat)

testit::assert(is_beast2_installed())

cat("----------------------------")
cat("Create the BEAST2 input file")
cat("----------------------------")
beast2_filename <- tempfile(tmpdir = rappdirs::user_cache_dir())
inference_model <- create_test_inference_model()
beautier::create_beast2_input_file_from_model(
  input_filename = beautier::get_fasta_filename(),
  output_filename = beast2_filename,
  inference_model = inference_model
)

cat("-------------------------")
cat("Create the BEAST2 options")
cat("-------------------------")

beast2_options <- create_beast2_options(
  input_filename = beast2_filename,
  verbose = TRUE
)


expect_false(file.exists(inference_model$mcmc$tracelog$filename))
expect_false(file.exists(inference_model$mcmc$treelog$filename))
expect_false(file.exists(beast2_options$output_state_filename))

cat("---------------")
cat("Do a BEAST2 run")
cat("---------------")
output <- run_beast2_from_options(beast2_options)

expect_true(length(output) > 40)
expect_true(file.exists(inference_model$mcmc$tracelog$filename))
expect_true(file.exists(inference_model$mcmc$treelog$filename))
expect_true(file.exists(beast2_options$output_state_filename))

cat("============================")
cat("Self-test of beastier passed")
cat("============================")
