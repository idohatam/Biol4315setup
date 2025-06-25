# **Biol4315setup: Setup for Langara's Biol 4315 Lab Environment**

The `Biol4315setup` package automates the setup of the computational environment for Langara's Biol 4315 *Nucleic Acid Omics* course.  
It ensures that students have all required **third-party tools, R packages, and Miniconda** properly configured on the **T450 Mac lab computers**.  

**⚠️ Important:** This package is designed _specifically_ for **MacOS** and will **not work on computers with other Operating Systems.**  

---

## **Installation**  

To install the package, use the `remotes` package (**recommended for simplicity**):  

```r
install.packages("remotes")
library(remotes)
remotes::install_github("idohatam/Biol4315setup")
```

Alternatively, you can install it using `devtools`:  

```r
install.packages("devtools")
library(devtools)
devtools::install_github("idohatam/Biol4315setup")
```

>**Note:** `devtools` is larger than `remotes`, so installation may take longer.

---

## **Setting Up the Computational Environment**  

The package provides a **single function**, `conda_whats_installed()`, that handles the entire setup process:  

1. Installs **Miniconda**  
2. Configures **Conda channels**  
3. Installs **required third-party tools**  
4. Installs **necessary R packages**  

If interrupted, the function will **resume from where it left off** when rerun.  

```r
# Load the package
library(Biol4315setup)

# Run the setup function
conda_whats_installed()
```

---

### **Troubleshooting**  

If `conda_whats_installed()` reports that Conda **is not found in the PATH after installation**, try the following steps:  

1. **Restart the Mac terminal**  
2. **Restart the R session**  
3. **Rerun** `conda_whats_installed()`  

The function will **continue from where it stopped** and should detect Conda correctly after restarting.  

---

## **Expanding Conda: Installing Additional Tools**  

Conda is a **powerful package manager** that allows you to install additional bioinformatics tools as needed.  
If, during the course, you find that you need extra third-party tools, you can install them via Conda **(as long as a version exists in Conda's repository).**  

### **Step 1: Ensure Conda is Activated**  

Before installing any tools, check if Conda is activated. Open a terminal and look for `(base)` next to your computer name:  

```bash
(base) computer-name:directory
```

- If you see `(base)`, Conda is **already activated**
- If you **don’t see it**, you need to **activate** Conda manually:  

```bash
conda activate
```

- If `conda activate` doesn't work, you may need to **initialize Conda first**:  

```bash
conda init zsh
source ~/.zshrc
conda activate
```

`source` will restart your terminal after `conda init`

>**NOTE:** it is possible that your mac isn't runnig zsh shell and require replaceing zsh with bash

---

### **Step 2: Search for and Install a Package**  

Once Conda is activated, you can **search** for available packages and **install** them.  

Example: Installing the **Flye assembler** for long-read sequencing data:  

```bash
# Search for Flye in Conda repositories
conda search flye

# Install Flye
conda install flye
```

---

## **Bonus: Using Virtual Environments for Tools**  

Conda allows you to create **separate virtual environments** for different tools.  
This is useful to **avoid dependency conflicts** and keep installations clean.
An example for this is the long read assembler `flye` which currently supports python versions 3.9 - 3.12.

### **Step 1: Create an Environment for a Specific Tool**  

To install `flye` inside its own virtual environment named `flye-env`, run:  

```bash

conda create -n flye-env python=3.10 -c conda-forge
conda activate flye-env
conda install flye=2.9.6 -c bioconda

```

- `-n` → Names the environment `flye -env`.  
- `python=3.10` → Installs `python` version 3.10.
- `-c` → Specifies which channel to use
- `flye=2.9.6` → specifies which version of flye to install

Next run `flye -h` to make sure that flye was installed properly.

---

### **Step 2: Deactivate and reactivate the Environment**  

To **Deactivate** the `flye-env` environment:  

```bash
conda deactivate
```

To **reactivate** and return to the base environment:  

```bash
conda activate flye-env
```

This method helps keep tools isolated and ensures no conflicts between dependencies.  

---

## **Reporting Issues**  

If you experience any issues with installation, please:  

- Report it on the **[GitHub Issues page](https://github.com/idohatam/Biol4315setup/issues)**  
- Or email me directly.  