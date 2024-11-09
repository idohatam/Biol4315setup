#this function will check if miniconda is already installed on the computer and will update to most recent version


conda_check <- function(){
  #Check if conda is installed
  chk <- Sys.which("conda")
  if(nchar(chk)==0){
    stop(paste("Miniconda isn't installed or path isn't set properly, 
               either set the path or run the conda_dl function"))
  } else{
    #Check that channels are ok
    channels <- system("conda config --show channels", 
                       intern = TRUE)
    
    if(length(which(grepl(paste(c("conda-forge", "bioconda"), 
                                collapse = "|"), channels))) ==2){
      stop(paste("We're good to go, proceed with package instalation via the package_setup function"))
      
    } else {
      system("conda config --add channels bioconda")
      system("conda config --add channels conda-forge")
      system("conda config --set channel_priority strict")
      print("Conda channels are now set, 
            proceed with package instalation via the package_setup function")
    }
    }
  
  
  
                         }
  
