#' @title Update Conda Packages
#'
#' @description This function updates all Conda-installed packages in the 
#' current environment to their latest compatible versions.
#'
#' @details The function uses the `conda update --all` command to ensure that 
#' all installed Conda packages are up to date. It captures the output and 
#' returns a status report indicating whether the update was successful or if 
#' an error occurred. Errors during the update process are caught and included 
#' in the status report for further troubleshooting.
#'
#' Note that this function assumes Conda is already installed and available 
#' in the system's PATH. If Conda is not installed, the function will fail.
#'
#' @return A character vector containing the status of the update process. 
#' If successful, it reports that all packages were updated. In the case of a 
#' failure, the status will include an error message.
#'


conda_update <- function(){

  conda_update_status <- list()
  
  tryCatch({
    system2("conda", args = c("update", "--all", "-y"), 
            stdout = TRUE, stderr = TRUE)
    
    conda_update_status <- append(conda_update_status, paste("Conda updated successfully"))
    
  },error = function(e){
    conda_update_status <- append(
      conda_update_status, paste("Conda updated failed with the following error:", e$message))
  } )
  
  return(unlist(conda_update_status))
  
}