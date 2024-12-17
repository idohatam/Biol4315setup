#Function that checks if the channels are set
conda_channels_setup <- function(){
  
  
  #set a list for report
  channel_status <- list()
  channels <- c("defaults", "conda-forge", "bioconda")
  
  #Check that channels are ok
  tryCatch({
    current_channels <- system2("conda", args = c("config", 
                                                  "--show", "channels"), 
                                stdout = TRUE, stderr = TRUE)
  }, error = function(e) {
    message("Error: Failed to retrieve conda channels. 
            Ensure Conda is installed and configured correctly.")
    channel_status <- append(channel_status,paste("Failed to retrive conda channles"))
    return(channel_status) #early exit
  })
  
  # Loop through channels to check/add them
  for (channel in channels) {
    tryCatch({
      if (!any(grepl(channel, current_channels))) {
        # Add channel if not already configured
        system2("conda", args = c("config", "--add", "channels", channel), 
                stdout = FALSE, stderr = TRUE)
        channel_status <- append(channel_status, paste0("Channel '", channel, "' added successfully."))
      } else {
        channel_status <- append(channel_status, paste0("Channel '", channel, "' is already configured."))
      }
    }, error = function(e) {
      channel_status <- append(channel_status, paste0("Failed to add channel '", channel, "': ", e$message))
    })
  }
  
  # Set channel priority to strict
  tryCatch({
    priority <- system2("conda", args = c("config", "--show", "channel_priority"), 
                        stdout = TRUE, stderr = TRUE)
    if (grepl("strict", priority)) {
      channel_status <- append(channel_status, "Channel priority is already set to 'strict'.")
    } else {
      system2("conda", args = c("config", "--set", "channel_priority", "strict"), 
              stdout = FALSE, stderr = TRUE)
      channel_status <- append(channel_status, "Channel priority set to 'strict'.")
    }
  }, error = function(e) {
    channel_status <- append(channel_status, paste("Failed to set channel priority:", e$message))
  })
  
  return(unlist(channel_status))
}
