#this function checks if conda is installed on the computer.
conda_check <- function(){
  #Check if conda is installed
  if(nchar(Sys.which("conda"))==0){
    #return false is not installed, will be used to stop the wrapper function
    return(FALSE)
  } else{
    return(TRUE)}
  }
  
