package_setup <- function(){
  
  #Generate a vector containing the list of installed packages
  
  listp <- installed.packages()[,1]
  
  #List of CRAN packages used in Biol 4315
  
  cranp <- c("BiocManager", "vegan", "tidyverse", "knitr","rmarkdown", "usethis",
             "fastqcr", "docopt", "DT", "pheatmap")
  
  #List of bioconductor packages used in 4315
  
  biocp <- c("Rqc","QuasR","genomation", "GenomicRanges", "Gviz", "ggbio",
             "systemPipeR","systemPipeRdata", "Rbowtie", "GenomicFeatures",
             "DESeq2", "edgeR", "BiocStyle", "GO.db","dada2", "Biostrings",
             "phyloseq")
  
  install_status <- list()
  #Install the cran packages
  
  # Avoid source install prompts
  options(install.packages.check.source = "no")
  # Always update packages when needed
  options(update.packages.ask = FALSE)
  
  cran_to_install <- cranp[!cranp %in% listp]
  
  if(length(cran_to_install) > 0){
    message("Installing CRAN packages...")
    tryCatch({
      install.packages(cran_to_install)
    }, error = function(e){
      warning(paste("Failed to install CRAN packages:", e$message))
    })
    if(length(
      cran_to_install %in% install.packages()[,1]) == length(cran_to_install)){
      message("All required CRAN packages installed successfuly")
      install_status$CRAN_success <- cran_to_install
    }else{
      message(
        paste("The following CRAN packages were not installed successfuly",
              cran_to_install[!cran_to_install %in% installed.packages()[,1]]))
      install_status$CRAN_success <- cran_to_install[
        cran_to_install %in% installed.packages()[,1]]
      install_status$CRAN_fail <- cran_to_install[
        !cran_to_install %in% installed.packages()[,1]]
    }
    
    
  }
  
  
  #Install the bioconductor packages
  bioc_to_install <- biocp[!biocp %in% listp]
  
  if(length(bioc_to_install) > 0){
    message("Installing Bioconductor packages...")
    tryCatch({
      BiocManager::install(bioc_to_install, update = TRUE, ask = FALSE)
    }, error = function(e){
      warning(paste("Failed to install Bioconductor packages:", e$message))
    })
    if(length(
      bioc_to_install %in% install.packages()[,1]) == length(bioc_to_install)){
      message("All required Bioconductor packages installed successfuly")
      install_status$bioc_success <- bioc_to_install
    }else{
      message(
        paste("The following Bioconductor packages were not installed successfuly",
              bioc_to_install[!bioc_to_install %in% installed.packages()[,1]]))
      install_status$bioc_success <- bioc_to_install[
        bioc_to_install %in% installed.packages()[,1]]
      install_status$bioc_fail <- bioc_to_install[
        !bioc_to_install %in% installed.packages()[,1]]
    }
    
    
  }
  
  
  #install the computational genomics in R package
  
  if(!"compGenomRData" %in% listp){
    message("Installing the compGenomRData package")
    tryCatch({
      devtools::install_github("compgenomr/compGenomRData")
      
    }, error = function(e){
      warning(paste("failled to install the compGenomRData package",
                    e$message))
    })
    if("compGenomRData" %in% installed.packages()[,1]){
      message("compGenomRData installed successfully")
      install_status$github_success <- "compGenomRData"
    }else{
      install_status$github_fail <- "compGenomRData"
    }
  }
  
  
  options(update.packages.ask = NULL)
  options(install.packages.check.source = NULL)
  return(install_status)
}