#' Check if Conda is Installed
#'
#' This function checks if Conda is installed on the system by looking for the `conda`
#' command in the system's PATH. It is used internally by the `conda_whats_installed` function.
#'
#' @details
#' The function will return `TRUE` if Conda is found in the system's PATH, meaning that Conda 
#' is installed and accessible. If Conda is not found, it returns `FALSE`, indicating that 
#' Conda is not installed.
#'
#' @return
#' A logical value: `TRUE` if Conda is installed, `FALSE` otherwise.
#'

conda_check <- function(){
  #Check if conda is installed
  if(nchar(Sys.which("conda"))==0){
    #return false is not installed, will be used to stop the wrapper function
    return(FALSE)
  } else{
    return(TRUE)}
  }
  
