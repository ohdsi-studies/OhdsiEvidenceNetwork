OHDSI Evidence Network
=============

<img src="https://img.shields.io/badge/Study%20Status-Started-blue.svg" alt="Study Status: Started"> 

- Analytics use case(s): **Characterization**
- Study type: **Methods Research**
- Tags: **Evidence Network**
- Study lead: **CLair Blacketer**
- Study lead forums tag: **[Clair Blacketer](https://forums.ohdsi.org/u/clairblacketer)**
- Study start date: **[June 11, 2024](https://youtu.be/gudHWsaMArg)**
- Study end date: **-**
- Protocol: **<a href="docs/EvidenceNetworkStudyProtocol_v1.0.pdf">docs/EvidenceNetworkStudyProtocol_v1.0.pdf</a>**
- Publications: **-**
- Results explorer: **-**

OHDSI network study designed to characterize the data sources in the network and result in a resource to connect researchers with questions to data partner organizations who have data. 

# How to run the study and participate in the network 

The following instructions will guide you through the process of setting
up your system to run this network study, how to run it, and what to expect moving forward.

## System setup and configuration

Start by making sure your R environment is set up by following the instructions
on the [OHDSI HADES R Setup site](https://ohdsi.github.io/Hades/rSetup.html). 
Be sure to install R, RTools, RStudio and Java. Next, verify that you can
properly connect from R to your OMOP CDM via DatabaseConnector per the instructions
[here](https://ohdsi.github.io/Hades/connecting.html#Configuring_your_connection) and
[here](https://ohdsi.github.io/DatabaseConnector/articles/Connecting.html).

Once you have installed the tools mentioned above and confirmed database
connectivity via R, you are ready to take the next step.

## Download the study package

To get started, you will want to download the study code in this repository
to your local machine. Instructions for downloading are found [here](https://docs.github.com/en/repositories/working-with-files/using-files/downloading-source-code-archives#downloading-source-code-archives-from-the-repository-view). In this guide, we will assume that you have
downloaded the .ZIP archive to **`D:/git/ohdsi-studies/OhdsiEvidenceNetwork`.**

## Restore the execution environment

[Use RStudio to open the project file](https://support.posit.co/hc/en-us/articles/200526207-Using-RStudio-Projects#:~:text=There%20are%20several%20ways%20to,Rproj).) `OhdsiEvidenceNetwork.Rproj` which is found in 
the root directory of `D:/git/ohdsi-studies/OhdsiEvidenceNetwork` (or wherever
you opted to download the study package). When you open the project, you will
see the following:

```r
R version 4.2.3 (2023-03-15 ucrt) -- "Shortstop Beagle"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

# Bootstrapping renv 1.0.7 ---------------------------------------------------
- Downloading renv ... OK
- Installing renv  ... OK

- Project 'D:/git/ohdsi-studies/OhdsiEvidenceNetwork' loaded. [renv 1.0.7]
- One or more packages recorded in the lockfile are not installed.
- Use `renv::status()` for more details.
```

The first time you run this study, you will need to restore the execution
environment using [renv](https://rstudio.github.io/renv/). To do this,
in the console run:

`renv::restore()`

and follow the prompts to install all of the packages. This will take some time
to complete (approximately 30 minutes). Once this operation is complete, please
close RStudio and re-open the project. You will again see the message above stating
that packages recorded in the lockfile are not installed. You can safely 
ignore this message moving forward. At this point you are ready to run the study.

## Running the study

Open the file `codeToRun.R` found in the root of your study package
directory (e.g. `D:/git/ohdsi-studies/OhdsiEvidenceNetwork`). This script will
require some modification to work in your environment. At the top of the 
script, you will a commented out note to tell you to run `renv::restore()`. If 
you followed the earlier instructions, this is not necessary but is a reminder.

### Environment Settings

```r
# Turn off the connection pane to speed up run time
options(connectionObserver = NULL)
```

### Study execution settings & CDM connection details

The next block of code will require edits for your environment:

```r
##=========== START OF INPUTS ==========
# Create the connection details for your CDM
# More details on how to do this are found here:
# https://ohdsi.github.io/DatabaseConnector/reference/createConnectionDetails.html
connectionDetails = DatabaseConnector::createConnectionDetails(
  dbms = "redshift",
  connectionString = "jdbc://",
  user = "my_cdm_user_name",
  password = "my_cdm_password"
)

# The schema where your CDM-structured data are housed
cdmDatabaseSchema <- ""

# The schema where your achilles results are housed
resultsDatabaseSchema <- ""

# The schema where your vocabulary tables are housed, typically the same as the cdmDatabaseSchema
vocabDatabaseSchema <- cdmDatabaseSchema

# A unique, identifiable name for your database
cdmSourceName <- ""

# The folder where your results should be written
outputFolder <- ""

# The version of the OMOP CDM you are currently on, v5.3 and v5.4 are supported.
cdmVersion <- "5.4"

# Whether the function should append existing Achilles tables or create new ones
appendAchilles <- FALSE

# The schema where any missing achilles analyses should be written. Only set if appendAchilles = FALSE
writeTo <- ""

# Whether to round to the 10s or 100s place. Valid inputs are 10 or 100, default is 10.
roundTo <- 10

# Vector of concepts to exclude from the output. Note: No patient-level data is pulled as part of the package or included as part of the output
excludedConcepts <- c()

# Whether the DQD should be run as part of the profile exercise
addDQD <- FALSE


##=========== END OF INPUTS ==========
```

### Executing the study

Once you have set the values as described above, you can run the entire study by
executing the database profile function at the end of  `codeToRun.R` script. 

```r
# execute the database profile function
DbDiagnostics::executeDbProfile(connectionDetails = connectionDetails,
								cdmDatabaseSchema = cdmDatabaseSchema,
								resultsDatabaseSchema = resultsDatabaseSchema,
								writeTo = writeTo,
								vocabDatabaseSchema = vocabDatabaseSchema,
								cdmSourceName = cdmSourceName,
								outputFolder = outputFolder,
								cdmVersion = cdmVersion,
								appendAchilles = appendAchilles,
								roundTo = roundTo,
								excludedConcepts = excludedConcepts,
								addDQD = addDQD
)
```
## Sharing Results

Once you have successfully executed the study, your results will be **in a zip file** located in
the folder: `D:/git/ohdsi-studies/OhdsiEvidenceNetwork/<your cdmSourceName>/<cdm source release date from CDM_SOURCE table>`.
Within this folder the full results are stored as CSV files which you can inspect before providing the results to the study coordinator.

Once you have reviewed your results and are ready to provide them to the study coordinator, you can use the `ShareResults.R` script located in the root of the project in `D:/git/ohdsi-studies/OhdsiEvidenceNetwork`. This script will require some modifications to reflect the location of the zipped results. 

```r
##=========== START OF INPUTS ==========
# The zip file created in the codeToRun.R. Copy the entire path after the phrase 
# "Final results are now available in: " in the console.    
zipFileName <- '[location of the zip file: e.g. /Documents/synthea/20220329/DbProfileResults.zip]'
# For uploading the results. You should have received the key file from the study coordinator:
keyFileName <- "[location where you are storing: e.g. ~/keys/study-data-site-covid19.dat]"
userName <- "data-site-datadiag"

##=========== END OF INPUTS ==========
```

To explain these settings:

- **zipFileName**: The path to the zip file output from the `codeToRun.R`.
- **keyFileName**: The path to an RSA private key that is provided by the study
coordinator.
- **userName**: The user name provided by the study coordinator. For this study it is data-site-datadiag