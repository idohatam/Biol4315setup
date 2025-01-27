#' @title Check Setup Step
#' @description A helper function to check if a specific setup step has been completed successfully.
#' 
#' @details This function takes a step name and checks if it has been executed successfully. It is typically used 
#' in the setup workflow to ensure that critical steps (e.g., installing Conda, setting up channels, etc.) 
#' have completed without errors. If the step has not been completed, it returns a failure message; 
#' otherwise, it confirms that the step is successful.
#' 
#' @param step_name A character string indicating the name of the setup step to check (e.g., "Conda installation").
#' @param report_section A character string that is used to identify steps
#' 
#' @return A character string indicating the success or failure of the checked step.
#' 
check_step <- function(report_section, step_name) {
  if (any(grepl("fail", report_section, ignore.case = TRUE))) {
    warning(sprintf("Setup workflow stopped because %s failed. Check the report for details:", step_name))
    stop(print(report_section))
  }
  message(sprintf("%s completed successfully.", step_name))
}