#Function that checks if the channels are set
channels_check <- function(){
  
  #Check that channels are ok
  channels <- system("conda config --show channels", 
                     intern = TRUE)
  
  if(length(which(grepl(paste(c("conda-forge", "bioconda"), 
                              collapse = "|"), channels))) ==2){
    return(TRUE)
    
  } else {
    return(FALSE)
  }
}
