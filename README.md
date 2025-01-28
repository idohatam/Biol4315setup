# **Biol4315setup package - Setting up the computational environment for Langara's Biol 4315**

The puroous of this package is to set up the required computational environment, and install all necessary 3rd party tools 
and R packages needed for the successful completion of the lab portion of Langara's Biol 4315, nucleic acid omics, course.

**Note that this package is designed <u>_specifically_</u> for Intel Macs and will not work on other computers**

<br>

## **_Installing the package_**


```
install.packages("remotes")
remotes::install_github("idohatam/Biol4315setup")

```

Alternatively it can be done using the `install_github` function from the `devtools` package.

```
install.packages("devtools")
devtools::install_github("idohatam/Biol4315setup")

```


## **_Setting up the computational environment_**

`conda_whats_installed()`


```
library("Biol4315setup")
conda_whats_installed()

```

## **_Reporting issues_**