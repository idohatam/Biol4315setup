
conda_whats_installed <- function(){
  #set up a list for report
  report <- list()
  
  #Check if conda is installed
  if(!conda_check()){
    message("Conda isn't installed running conda download and installation")
    cdlstat <- conda_dl()
    
  }else{
    report$conda_ins <- "conda is installed"
    message("Conda was previosly installed")
  }
  
  update_status <- tryCatch({
    system2("conda", args = c("update", "--all"), 
            stdout = FALSE, stderr = FALSE)
    TRUE
  },error = function(e){
    FALSE
  } )
  
  if(!update_status){
    report$conda_ud <- "conda updated failed please check the setup"
  } else {
    report$conda_ud <- "conda and conda packages are now up to date"
  }
  
  #check channels and setup
  report$conda_channel_setup <- conda_channels_setup() 
  
  #check tools
  
  report$conda_tool_setup <- conda_check_tools()
  
  #print report
  
}