# README

## Introduction
This project is an analysis of global environmental indicator data. This repository contains the source data, code, and results of the analysis.

## Source data
The data used in this analysis come from the United Nations Statistics Division (UNSD) / United Nations Environment Programme (UNEP) Questionairre on Environment Statistics and were downloaded via Kaggle: https://www.kaggle.com/ruchi798/global-environmental-indicators (last updated June 5, 2021). This dataset contains many types of environmental indicators, including:     

	* Air and Climate     
	* Biodiversity     
	* Energy and Minerals     
	* Forest      
	* Governance     
	* Inland Water Resources     
	* Land and Agriculture     
	* Marine and Coastal Areas     
	* Natural Disasters     
	* Waste     
	    
This environmental indicator data is available for many different countries.

## Docker
To run the analysis, you will need to have Docker installed (https://docs.docker.com/get-docker/) as well as the ability to run Docker as your current user.     

First, navigate to the `bios-611-project/` directory in the command line.     

**Build docker container**     

Before running anything, you will need to build the container with the following command:     
```
docker build . -t project-env
```     

**Run an Rstudio server**     

To run an Rstudio server, run the following command. Note that `your_password_here` should be replaced with your own unique password before running.     

```
docker run -e PASSWORD=your_password_here --rm -p 8787:8787 -p 8080:8080 -v $(pwd):/home/rstudio -t project-env
```     

Then, to connect to the machine on port 8787, enter localhost:8787 in your browser. Enter rstudio as the username along with the unique password you created.

**Run a bash shell**     

To run a bash shell, run the following command.     

```
docker run -v $(pwd):/home/rstudio/project -p 8080:8080 -it project-env sudo -H -u rstudio /bin/bash -c "cd ~/project/; /bin/bash"
```

## Makefile
All derived datasets and figures for this project can be found in the Makefile.    

To utilize the Makefile to build these elements from the source data, first follow the instructions above to either run a bash shell or Rstudio instance. Then, follow the below instructions on how to use the Makefile.

**Make all derived datasets and figrues**    

To make the report and all of the derived datasets, figures, and logs for this analysis from the source data (excluding the Rshiny app - see instructions for running that below), run the following command in your terminal:
```
make all
```

**Make an individual file**     

To make an individual file of interest from the source data that is listed as a target in the Makefile, run the following command in your terminal, substituting `figures/emissions_pc_plot.png` for the file of interest:     
```
make figures/emissions_pc_plot.png
```

**Make the Rshiny app**

This project contains an interactive Rshiny app that plots CO2 emissions by year for a country of interest selected via a drop-down menu. To run the Rshiny app, run the following command in your terminal:
```
PORT=8080 make shiny_app
```
Then, connect to the machine on port 8080 by entering localhost:8080 in your browser.

**Clean all derived data**

To clean all of the derived files (datasets, figures, logs) from your repository, run the following command in your terminal:
```
make clean
```
This will permanently delete all derived data that is not the source data.


