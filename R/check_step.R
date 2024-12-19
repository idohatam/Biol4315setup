# a helper function to check the report from each step of the setup workflow
#saves on code

check_step <- function(report_section, step_name) {
  if (any(grepl("fail", report_section, ignore.case = TRUE))) {
    stop(sprintf("Setup workflow stopped: %s failed. Check the report for details.", step_name))
  }
  message(sprintf("%s completed successfully.", step_name))
}