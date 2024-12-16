# a function that downloads and installs miniconda
conda_dl <- function(){
  
  #download address
  
  URL <- "https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
  
  dest_file <- "Miniconda3.sh"
  
  #extra check if conda is installed:
  
  conda_install_statuss <- list()
  
  if(nchar(Sys.which("conda"))>0){
    conda_install_statuss <- append(
      conda_install_statuss, paste(
        "Minicanda was already installed and the path set correctly"))
    message(paste("Miniconda is installed and the path is set properly"))
    return(unlist(conda_install_statuss))
    }
  
  #download with curl and trycatch
  
  tryCatch({
    
    curl::curl_download(url = URL, destfile = dest_file)
    conda_install_statuss <- append(
      conda_install_statuss, "miniconda download was successfull")
    
  }, error = function(e){
    
    conda_install_statuss <- append(
      conda_install_statuss, paste("miniconda download failed with the error:", e$message))
    
  })
  
  
  #install miniconda
  
  tryCatch({
    
    system(paste("yes | bash", dest_file, sep = " "))
  }, error = function(e){
    
    conda_install_statuss <- append(
      conda_install_statuss, paste("Conda installation failed with error:", e$message))
  })
  
  
  #check the conda is installed
  
  if(Sys.which("conda")==""){
    #set path
    system(
      "echo 'export PATH=\"$HOME/miniconda3/bin:$PATH\"' >> ~/.bash_profile")
    
    #source the bash_profile
    
    system("source ~/.bash_profile")
    
    conda_install_statuss <- append(
      conda_install_statuss, paste("Path to conda installation was set"))
    #check that the path was set properly
  }
  
  

  return(unlist(conda_install_statuss))
}