#A wrapper function that runs through the entire workflow from downloading and installing conda
#to 3rd party software and R package installation.

conda_whats_installed <- function(){
  #set up a list for report
  report <- list()
  
  #Check if conda is installed
  if(!conda_check()){
    message("Conda isn't installed, miniconda will be downloaded and installed")
    report$conda_dl_inst <- conda_dl()
    if(any(grepl("fail",report$conda_dl_inst,ignore.case = FALSE))){
      message("Setup warkflow stopped: 
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
    message("Setup warkflow stopped because at least one chennel setup failed")
    print(report$conda_channel_setup)
    stop()
  }else{
    message("Conda channels set successfully")
  }
  #conda update
  
  message("Updating preinstalled conda packages")
  
  report$conda_update <- conda_update()
  
  if(any(grepl("fail", report$conda_update, ignore.case = TRUE))){
    message("Setup warkflow stopped because at least one chennel setup failed")
    print(report$conda_update_setup)
    stop()
  }else{
    message("Conda packages were updated successfully")
  }
  
  #check tools
  
  message("Installing the required 3rd party tools via conda")
  
  report$conda_tool_setup <- conda_check_tools()
  
  if(any(grepl("fail", report$conda_tool_setup, ignore.case = TRUE))){
    warning("Instalation of at least one of the 3rd party tools failed \n installation of R packages will continue however make sure to check the issue")
    print(report$conda_update_setup)
  }else{
    message("The required 3 party tools were successfully installed")
  }
  
  #install R packages
  message("installing the required R packages")
  
  report$R_packages_setup <- package_setup()
  
  if(any(grepl("fail", report$R_packages_setup, ignore.case = TRUE))){
    warning("Instalation of at least one one package failed \n installation of R packages will continue however make sure to check the issue")
    print(report$conda_update_setup)
  }else{
    message("The required R packages were successfully installed")
  }
  
  
  #print report
  message("The setup workflow completed")
  return(report)
  
}