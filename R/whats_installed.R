#' @title Conda Workflow Setup
#'
#' @description This wrapper function orchestrates the entire setup workflow for your project.
#' It downloads and installs Miniconda (if needed), configures Conda channels, updates Conda packages,
#' installs third-party tools, and installs required R packages. 
#' Note that this will only work on Mac computers with Intel silicone
#'
#' @return A list summarizing the status of each step in the setup workflow.
#' Each entry in the list contains a status message indicating success or failure.
#'
#' @details If any critical step fails (e.g., Conda installation or channel setup), 
#' the function will terminate and print the corresponding error message. 
#' Non-critical failures (such as failed R package installations) will trigger warnings, 
#' but the workflow will continue. Note that the function does not take any arguments and 
#' internally runs a series of helper functions to complete the setup process. 
#'
#' @examples {
#'   # Run the full setup workflow
#'   report <- conda_whats_installed()
#'   print(report)
#' }
#' 
#' @export

conda_whats_installed <- function(){
  #set up a list for report
  report <- list()
  
  #Check if conda is installed
  if(!conda_check()){
    message("Conda isn't installed, miniconda will be downloaded and installed")
    report$conda_dl_inst <- conda_dl()
    check_step(report$conda_dl_inst, "")
    if(any(grepl("fail",report$conda_dl_inst, ignore.case = TRUE))){
      message("Setup workflow stopped: 
              Miniconda installation encountered the following issue, 
              please resulove it and try again")
      print(report$conda_dl_inst)
      stop()
    }else{
      message("Miniconda installation successful")
    }
    
  }else{
    report$conda_dl_inst <- "conda is installed"
    message("Conda was previosly installed")
  }
  
 
  #check channels and setup
  message("Proceeding with seting up channles")
  report$conda_channel_setup <- conda_channels_setup()
  #s
  if(any(grepl("fail", report$conda_channel_setup, ignore.case = TRUE))){
    message("Setup workflow stopped because at least one channel setup failed")
    print(report$conda_channel_setup)
    stop()
  }else{
    message("Conda channels set successfully")
  }
  #conda update
  
  message("Updating preinstalled conda packages")
  
  report$conda_update <- conda_update()
  
  if(any(grepl("fail", report$conda_update, ignore.case = TRUE))){
    message("Setup workflow stopped because at least one channel setup failed")
    print(report$conda_update_setup)
    stop()
  }else{
    message("Conda packages were updated successfully")
  }
  
  #check tools
  
  message("Installing the required 3rd party tools via conda")
  
  report$conda_tool_setup <- conda_check_tools()
  
  if(any(grepl("fail", report$conda_tool_setup, ignore.case = TRUE))){
    warning("installation of at least one of the 3rd party tools failed installation of R packages will continue however make sure to check the issue")
    print(report$conda_tool_setup)
  }else{
    message("The required 3rd party tools were successfully installed")
  }
  
  #install R packages
  message("installing the required R packages")
  
  report$R_packages_setup <- package_setup()
  
  if(any(grepl("fail", report$R_packages_setup, ignore.case = TRUE))){
    warning("installation of at least one one package failed installation of R packages will continue however make sure to check the issue")
    print(report$R_package_setup)
  }else{
    message("The required R packages were successfully installed")
  }
  
  
  #print report
  message("The setup workflow completed")
  return(report)
  
}