
condat_update <- function(){

  conda_update_status <- list()
  
  tryCatch({
    system2("conda", args = c("update", "--all", "-y"), 
            stdout = TRUE, stderr = TRUE)
    
    conda_update_status <- append(conda_update_status, paste("Conda updated successfully"))
    
  },error = function(e){
    conda_update_status <- append(
      conda_update_status, paste("Conda updated failed with the following error:", e$message))
  } )
  
  return(unlist(conda_update_status))
  
}