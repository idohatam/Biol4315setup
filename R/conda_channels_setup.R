#' @title Configure Conda Channels
#'
#' @description This function ensures that the required Conda channels 
#' (`defaults`, `conda-forge`, and `bioconda`) are properly configured 
#' and sets the channel priority to `strict`.
#'
#' @details The function checks if the required Conda channels are already 
#' configured in the user's environment. If a channel is missing, it is added 
#' to the configuration. Additionally, the function verifies that the 
#' channel priority is set to `strict` for reliable package resolution. 
#' A status report is returned to indicate the success or failure of each step.
#'
#' Note that this function is an internal helper function used by the wrapper function.
#' Therefore it assumes Conda is already installed and available in the system's PATH. 
#' Any errors during channel configuration will be captured and reported in the status report.
#'
#' @return A character vector containing the status of each step, including 
#' whether channels were added or if they were already configured, and 
#' whether the channel priority was successfully set to `strict`.
#'

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
