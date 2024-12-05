conda_check_tools <- function(){
  
  tool_list <- c("histat2", "samtools", "bowtie2", "wget", "bwa")
  installed_tools <- system2("conda", args = "list",
                             stdout = TRUE, stderr = FALSE)
  tools_status <- list()
  
  for (tool in tool_list) {
    #check tools
    if(any(grepl(tool, installed_tools))){
      tools_status <- append(tools_status, 
                             paste0(tool, "' is already installed."))
    }else{
    #install wget with conda
    tryCatch({if(tool=="wget"){
      system2("conda", args = c("install", "-y", tool, 
                                stdout = FALSE, stderr = FALSE))
    }else{
      #install everything else with mamba
      system2("mamba", args = c("install", "-y", tool, 
                                stdout = FALSE, stderr = FALSE))
    }
    tools_status <- append(tools_status, paste0(tool, "' was installed succesfully."))},
    error = function(e){
      tools_status <- append(tools_status, paste(tool, "installation failed with error:", e$message))
    })
      }
  }
  
  return(unlist(tools_status))
}