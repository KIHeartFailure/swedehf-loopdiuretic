# Impute missing values ---------------------------------------------------

noimpvars <- names(rsdata)[!names(rsdata) %in% modvars]

# Nelson-Aalen estimator
na <- basehaz(coxph(Surv(sos_outtime_death, sos_out_death == "Yes") ~ 1,
  data = rsdata, method = "breslow"
))
rsdata <- left_join(rsdata, na, by = c("sos_outtime_death" = "time"))

ini <- mice(rsdata, maxit = 0, print = F)

pred <- ini$pred
pred[, noimpvars] <- 0
pred[noimpvars, ] <- 0 # redundant

# change method used in imputation to prop odds model
meth <- ini$method
meth[c("scb_education", "shf_indexyear_cat", "shf_ntprobnp_cat", "scb_dispincome_cat")] <- "polr"
meth[noimpvars] <- ""

## check no cores
cores_2_use <- detectCores() - 1
if (cores_2_use >= 10) {
  cores_2_use <- 10
  m_2_use <- 1
} else if (cores_2_use >= 5) {
  cores_2_use <- 5
  m_2_use <- 2
} else {
  stop("Need >= 5 cores for this computation")
}

cl <- makeCluster(cores_2_use)
clusterSetRNGStream(cl, 49956)
registerDoParallel(cl)

imprsdata <-
  foreach(
    no = 1:cores_2_use,
    .combine = ibind,
    .export = c("meth", "pred", "rsdata"),
    .packages = "mice"
  ) %dopar% {
    mice(rsdata,
      m = m_2_use, maxit = 10, method = meth,
      predictorMatrix = pred,
      printFlag = FALSE
    )
  }
stopImplicitCluster()

# Check if all variables have been fully imputed --------------------------

datacheck <- mice::complete(imprsdata, 1)

for (i in seq_along(modvars)) {
  if (any(is.na(datacheck[, modvars[i]]))) stop("Missing for imp vars")
}
for (i in seq_along(modvars)) {
  if (any(is.na(datacheck[, modvars[i]]))) print(paste0("Missing for ", modvars[i]))
}

imprsdata_pop1 <- miceadds::subset_datlist(imprsdata, expr_subset = rsdata$pop1 == TRUE)
