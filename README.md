# TMAICPM Installation Guide

Welcome to the **TooManyAcronymsInComputers (TMAICPM)** repository! This guide provides you with a step-by-step process for installing and running the application using the provided installation script (`install.sh`).

## Requirements

Before starting, make sure your system meets the following requirements:

- **Linux-based system (Ubuntu/Debian or similar)**  
- **Python 3** and **Pip 3** for Python dependency management (if applicable)
- **Curl** and **Tar** for downloading and extracting files

The `install.sh` script will check and install any missing dependencies automatically.

## Installation Steps

### Step 1: Download the `install.sh` Script

You can either download the `install.sh` script from the [GitHub Releases](https://github.com/TooManyAcronymsInComputers/tmaicpm/releases) page or clone the repository directly:

```bash
git clone https://github.com/TooManyAcronymsInComputers/tmaicpm.git
cd tmaicpm
```


### Step 2: Running the Script:

### For User-Specific installation:

```
chmod +x install.sh   # Make the script executable
./install.sh          # Run the installation script
```
### For System-Wide installation:


```
sudo chmod +x install.sh  # Make the script executable
sudo ./install.sh         # Run the installation script with root privileges
```


