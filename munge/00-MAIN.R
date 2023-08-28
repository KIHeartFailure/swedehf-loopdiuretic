# Project specific packages, functions and settings -----------------------

source(here::here("setup/setup.R"))

# Load data ---------------------------------------------------------------

load(here(shfdbpath, "data/v410/rsdata410.RData"))
# rsdata410 <- rsdata410 %>% # remove this
#  sample_n(3000) # remove this

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
    "tabvars"
  )
)
