# Project specific packages, functions and settings -----------------------

source(here::here("setup/setup.R"))

# Load data ---------------------------------------------------------------

load(here(shfdbpath, "data/v410/rsdata410.RData"))
# rsdata410 <- rsdata410 %>% # remove this
#  sample_n(3000) # remove this

# Meta data ect -----------------------------------------------------------

metavars <- read.xlsx(here(shfdbpath, "metadata/meta_variables.xlsx"))
load(here(paste0(shfdbpath, "data/meta_statreport.RData")))

# Munge data --------------------------------------------------------------

source(here("munge/01-vars.R"))
source(here("munge/02-pop-selection-1.R"))
source(here("munge/03-npr-comorb-outcome.R"))
source(here("munge/04-pop-selection-2.R"))
source(here("munge/05-fix-vars.R"))
source(here("munge/06-reccurent-outcome.R"))
source(here("munge/07-mi.R"))

# Cache/save data ---------------------------------------------------------

save(
  file = here("data/clean-data/data.RData"),
  list = c(
    "rsdata",
    "rsdatarep",
    "imprsdata",
    "imprsdata_pop1",
    "metaout",
    "metavars",
    "flow",
    "modvars",
    "stratavars",
    "tabvars",
    "outvars",
    "ccimeta",
    "deathmeta",
    "outcommeta"
  )
)

# create workbook to write tables to Excel
wb <- openxlsx::createWorkbook()
openxlsx::addWorksheet(wb, sheet = "Information")
openxlsx::writeData(wb, sheet = "Information", x = "Tables in xlsx format for tables in Statistical report: Loop Diuretic Therapy as a Prognostic Enrichment Factor for Clinical Trials in Patients with Heart Failure with mrEF and pEF", rowNames = FALSE, keepNA = FALSE)
openxlsx::saveWorkbook(wb,
  file = here::here("output/tabs/tables.xlsx"),
  overwrite = TRUE
)
