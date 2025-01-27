#' @title Verify and Install Third-Party Tools via Conda
#'
#' @description This function checks whether the required third-party tools 
#' are installed in the Conda environment. If any tools are missing, it 
#' installs them using Conda.
#'
#' @details The function iterates through a predefined list of tools required 
#' for the workflow. For each tool, it checks its availability using the 
#' `conda list` command. If a tool is missing, it attempts to install it 
#' via `conda install`. The function captures the status of each tool's 
#' installation and returns a detailed report. 
#' 
#' Errors encountered during the installation of specific tools are logged 
#' in the report, but the function continues checking and installing the 
#' remaining tools.
#'
#' Note that this is an internal helper function called by the wrapper function. 
#' Therefore, it assumes that Conda is installed and the required channels (e.g., Bioconda) are properly configured. 
#' If these prerequisites are not met, tool installation will fail.
#'
#' @return A character vector containing the status of each tool's 
#' installation. It indicates whether a tool was already installed or 
#' successfully installed. Errors during installation are also reported.
#'

conda_check_tools <- function(){
  
  tool_list <- c("histat2", "samtools", "bowtie2", "wget", "bwa")
  installed_tools <- system2("conda", args = "list",
                             stdout = TRUE, stderr = FALSE)
  tools_status <- list()
  
  for (tool in tool_list) {
    #check tools
    if(any(grepl(tool, installed_tools))){
      tools_status <- append(tools_status, 
                             paste0(tool, "' is already installed."))
    }else{
    #install wget with conda
    tryCatch({if(tool=="wget"){
      system2("conda", args = c("install", "-y", tool, 
                                stdout = FALSE, stderr = FALSE))
    }else{
      #install everything else with mamba
      system2("mamba", args = c("install", "-y", tool, 
                                stdout = FALSE, stderr = FALSE))
    }
    tools_status <- append(tools_status, paste0(tool, "' was installed succesfully."))},
    error = function(e){
      tools_status <- append(tools_status, paste(tool, "installation failed with error:", e$message))
    })
      }
  }
  
  return(unlist(tools_status))
}