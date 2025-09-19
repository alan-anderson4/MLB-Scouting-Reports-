library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)
library(scales)
library(kableExtra)
library(knitr)
library(rmarkdown)
install.packages("tinytex")
tinytex::install_tinytex()

# Filter Tiger Pitchers
pitcherdata24 <- readRDS("D:/Baseball/pitcherdata24.rds")
Tigers_Pitching24 <- pitcherdata24 %>%
  filter(pitcher_team == "DET")

# Get unique pitchers
pitchers <- unique(Tigers_Pitching24$player_name)


# Set output directory
output_dir <- "D:/Baseball/Scouting Reports" #change this to where you want each report saved to
dir.create(output_dir, showWarnings = FALSE)

# Loop through each unique pitcher

for (p in pitchers) {
  message("Rendering report for: ", p)
  
  
  # Create safe filename
  output_file <- paste0(gsub(" ", "_", p), "_report.pdf") #name this however you see fit
  
  
  rmarkdown::render(
    input = "D:/Baseball/Scouting Reports/pitcher_report_template.Rmd", #make sure this matches where your file is saved 
    output_file = output_file,
    output_dir = output_dir,
    params = list(pitcher_name = p),
    envir = new.env()
  )
}

# Run the Script
#source("generate_pitcher_reports.R")
