#this function checks if miniconda is installed on the computer.
conda_check <- function(){
  #Check if conda is installed
  if(nchar(Sys.which("conda"))==0){
    return(FALSE)
  } else{
    return(TRUE)}
  }
  
