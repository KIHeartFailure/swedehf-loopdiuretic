source(here::here("setup/setup.R"))

# load data
load(here("data/clean-data/data.RData"))

dataass <- mice::complete(imprsdata, 3)
dataass <- mice::complete(imprsdata, 6)

# check assumptions for cox models ----------------------------------------

mod <- coxph(
  formula(paste0(
    "Surv(sos_outtime_hosphf, sos_out_deathcvhosphf == 'Yes') ~ shf_loopdiuretic_cat + ",
    paste0(modvars, collapse = "+")
  )),
  data = dataass
)

# prop hazard assumption
testpat <- cox.zph(mod)
print(sig <- testpat$table[testpat$table[, 3] < 0.05, ])

x11()
plot(testpat[1], resid = T, col = "red")
plot(testpat[5], resid = T, col = "red")

# outliers
ggcoxdiagnostics(mod,
  type = "dfbeta",
  linear.predictions = FALSE, ggtheme = theme_bw()
)
