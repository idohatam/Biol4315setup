# **Biol4315setup: Setup for Langara's Biol 4315 Lab Environment**

The `Biol4315setup` package automates the setup of the computational environment for Langara's Biol 4315, nucleic acid omics, course.
It ensurs that students have all required 3rd party tools, R packages, and Miniconda properly configured on the T450 Mac lab computers. 

**Note that this package is designed <u>_specifically_</u> for Intel Macs and will not work on other computers**


<br>

## **_Installing the package_**

To install the package, use the `remotes` package (recommended for simplicity):

```
install.packages("remotes")
library("remotes")
remotes::install_github("idohatam/Biol4315setup")

```

Alternatively it can be done using the `install_github` function from the `devtools` package.

```
install.packages("devtools")
library("devtools")
devtools::install_github("idohatam/Biol4315setup")

```
>Note that `devtools` is a larger than the `remotes`, so the installation may take longer.

## **_Setting up the computational environment_**

The package provides a single function, conda_whats_installed(), to handle the entire setup process:

1. Installs `Miniconda`
2. Configures `conda` channels
3. Installs required 3rd party tools
4. Installs required R packages

The function will resume from where it left off if interrupted.

```
library("Biol4315setup")
conda_whats_installed()

```

## **_Reporting issues_**

If you experience any issue with installation, please: 
- Report it on the repository's [issues page](https://github.com/idohatam/Biol4315setup/issues)  
- Or email me directly 