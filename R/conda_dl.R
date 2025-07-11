#' @title Download and Install Miniconda
#'
#' @description This function  downloads and installs Miniconda, note that it is hard coded to only download the Intel MacOSX installation package.
#'
#' @details The function first checks if Conda is already installed. If it is, it 
#' will return a message indicating that Conda is already installed and set up. If Conda 
#' is not installed, it will proceed to download and install Miniconda. The installation 
#' process is done via a bash script, and any errors during the download or installation 
#' will be captured and reported. After the installation, the function also ensures that 
#' the Conda path is correctly set in the system's environment.
#'
#' The function will return a status report as a character vector, which will indicate 
#' the success or failure of each step in the process.
#'
#' @return A character vector with the status of each step in the process, including 
#' any error messages encountered during the download, installation, or path setup.
#'


conda_dl <- function(){
  
  #check if the computer is an Intel Mac or an Apple silicon Mac
  info <- which(grepl("Apple M",system2("system_profiler", 
                                        args = "SPHardwareDataType", 
                                        stdout = TRUE)))
  if(length(info) == 0){
  
  #download address for intel
  
  URL <- "https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
  message("Intel Mac detected. Using x86_64 installer.")
  
  }else{
    
    #download address for the M series
    URL <-"https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh"
    message("Apple Silicon Mac detected. Using ARM installer.")
  }
  
  
  
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
  
  message("Downloading Miniconda installer...")
  
  tryCatch({
    
    curl::curl_download(url = URL, destfile = dest_file)
    conda_install_statuss <- append(
      conda_install_statuss, "miniconda download was successfull")
    
  }, error = function(e){
    
    conda_install_statuss <- append(
      conda_install_statuss, paste("miniconda download failed with the error:", e$message))
    return(unlist(conda_install_status))  # Exit early with status
  })
  
  
  #install miniconda
  
  message("Installing Miniconda...")
  
  tryCatch({
    
    system(paste("bash", dest_file,"-b -p $HOME/miniconda3", sep = " "),
           ignore.stdout = TRUE, ignore.stderr = TRUE)
    
  }, error = function(e){
    
    conda_install_statuss <- append(
      conda_install_statuss, paste("Conda installation failed with error:", e$message))
    return(unlist(conda_install_statuss)) #Exit early with status
  })
  
  
  message("Setting up PATH for Miniconda...")
  
  shell_profile <- ifelse(Sys.getenv("SHELL") == "/bin/zsh", "~/.zshrc", "~/.bash_profile")
  
  tryCatch({
    system(sprintf("echo 'export PATH=\"$HOME/miniconda3/bin:$PATH\"' >> %s", shell_profile))
    system(sprintf("source %s", shell_profile))  # Automatically source the profile
  }, error = function(e) {
    warning("Failed to update PATH.")
    conda_install_statuss <- append(conda_install_statuss, paste("Failed to set PATH for conda"))
    return(unlist(conda_install_status))  # Exit early with status
  })
  
  
  # Final PATH verification
  if (nchar(Sys.which("conda")) > 0) {
    conda_install_statuss <- append(conda_install_statuss, "Conda installed and configured successfully")
    message("Miniconda installed and configured successfully!")
  } else {
    default_conda <- "~/miniconda3/bin"
    conda_path <- file.path(path.expand(default_conda), "conda")
    
    if (file.exists(conda_path)) {
      Sys.setenv(PATH = paste(path.expand(default_conda), Sys.getenv("PATH"), sep = ":"))
      
      if (nchar(Sys.which("conda")) > 0) {
        conda_install_statuss <- append(conda_install_statuss, "Conda path manually updated and confirmed")
        message("Miniconda installed and configured successfully after manual path update!")
      } else {
        warning("Conda found but still not accessible after updating PATH.")
        conda_install_statuss <- append(conda_install_statuss, "Conda found but still not accessible from R")
      }
    } else {
      warning("Miniconda installation complete, but 'conda' is not in your PATH.")
      conda_install_statuss <- append(conda_install_statuss, "Failed verifying PATH for conda")
    }
  }
  
  return(unlist(conda_install_statuss))
}