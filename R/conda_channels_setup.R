#Function that checks if the channels are set
conda_channels_setup <- function(){
  
  channels <- c("defaults", "conda-forge", "bioconda")
  #Check that channels are ok
  current_channels <- system2("conda", args= c ("config", "--show", "channels"), 
                              stdout = TRUE, stderr = FALSE)
  channel_status <- list()
  
  for (channel in channels) {
    # Check if the channel is already configured
    if (!any(grepl(channel, current_channels))) {
      # Add the channel if it's not already configured
      system2("conda", args = c("config", "--add", "channels", channel), 
              stdout = FALSE, stderr = FALSE)
      channel_status <- append(
        channel_status, paste0("Channel '", channel, "' added successfully."))
      
    } else {
      channel_status <-  append(
        channel_status, paste0("Channel '", channel, "' is already configured."))
    }
    
  }
  # Set channel priority to strict
  priority <- system2("conda", args= c ("config", "--show", "channel_priority"), 
                      stdout = TRUE, stderr = FALSE)
  if(grepl("strict", priority)){
    channel_status[length(channel_status)+1] <- paste("channel priority is strict")
  }else{
    system2("conda", args = c("config", "--set", "channel_priority", "strict"), 
            stdout = FALSE, stderr = FALSE)
    channel_status[length(channel_status)+1] <- paste("Channel priority set to 'strict'.")
  }
  
  return(unlist(channel_status))
}
