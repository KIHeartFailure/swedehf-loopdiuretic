# Cut outcomes at 4 years

rsdata <- cut_surv(rsdata, sos_out_deathcvhosphf, sos_outtime_hosphf, global_followup, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_hosphf, sos_outtime_hosphf, global_followup, cuttime = TRUE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_deathcv, sos_outtime_death, global_followup, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_death, sos_outtime_death, global_followup, cuttime = TRUE, censval = "No")

rsdata <- rsdata %>%
  rename(
    shf_loopdiuretic_old = shf_loopdiuretic,
    shf_loopdiureticdose_old = shf_loopdiureticdose
  ) %>%
  mutate(
    censdtm = pmin(censdtm, shf_indexdtm + global_followup, na.rm = T),
    shf_loopdiuretic = factor(case_when(
      shf_loopdiuretic_old == "No" |
        shf_loopdiureticusage == "When necessary" ~ 0,
      shf_loopdiuretic_old == "Yes" ~ 1
    ), level = 0:1, labels = c("No", "Yes")),
    shf_loopdiureticdose = case_when(
      shf_loopdiureticsub == "Furosemid" | is.na(shf_loopdiureticsub) ~ shf_loopdiureticdose_old,
      shf_loopdiureticsub == "Bumetanid" ~ shf_loopdiureticdose_old * 40,
      shf_loopdiureticsub == "Toresamid" ~ shf_loopdiureticdose_old * 2
    ),
    shf_loopdiuretic_cat = factor(case_when(
      shf_loopdiuretic == "No" ~ 0,
      shf_loopdiureticdose <= 40 ~ 1,
      shf_loopdiureticdose > 40 ~ 2
    ), levels = 0:2, labels = c("No loop diuretic", "Dose 1-40mg", "Dose >40mg")),
    shf_indexyear_cat = case_when(
      shf_indexyear <= 2015 ~ "2011-2015",
      shf_indexyear <= 2018 ~ "2016-2018",
      shf_indexyear <= 2021 ~ "2019-2021"
    ),
    shf_ef_cat = droplevels(shf_ef_cat),

    # fix outcomes
    sos_out_deathcvnohosphf = ifelse(sos_out_deathcv == "Yes", sos_out_nohosphf + 1, sos_out_nohosphf),

    # comp risk outcomes
    sos_out_deathcvhosphf_cr = create_crevent(sos_out_deathcvhosphf, sos_out_death, eventvalues = c("Yes", "Yes")),
    sos_out_deathcv_cr = create_crevent(sos_out_deathcv, sos_out_death, eventvalues = c("Yes", "Yes")),
    sos_out_hosphf_cr = create_crevent(sos_out_hosphf, sos_out_death, eventvalues = c("Yes", "Yes"))
  ) %>%
  select(-shf_bmiimp, -shf_bmiimp_cat, ends_with("_excl"))

## Create numeric variables needed for comp risk model
rsdata <- create_crvar(rsdata, "shf_loopdiuretic_cat")

# income
inc <- rsdata %>%
  reframe(incsum = list(enframe(quantile(scb_dispincome,
    probs = c(0.33, 0.66),
    na.rm = TRUE
  ))), .by = shf_indexyear) %>%
  unnest(cols = c(incsum)) %>%
  pivot_wider(names_from = name, values_from = value)

rsdata <- left_join(
  rsdata,
  inc,
  by = "shf_indexyear"
) %>%
  mutate(
    scb_dispincome_cat = factor(
      case_when(
        scb_dispincome < `33%` ~ 1,
        scb_dispincome < `66%` ~ 2,
        scb_dispincome >= `66%` ~ 3
      ),
      levels = 1:3,
      labels = c("1st tertile within year", "2nd tertile within year", "3rd tertile within year")
    )
  ) %>%
  select(-`33%`, -`66%`)

# ntprobnp

nt <- rsdata %>%
  reframe(ntmed = list(enframe(quantile(shf_ntprobnp,
    probs = c(0.33, 0.66),
    na.rm = TRUE
  ))), .by = shf_ef_cat) %>%
  unnest(cols = c(ntmed)) %>%
  pivot_wider(names_from = name, values_from = value)

rsdata <- left_join(
  rsdata,
  nt,
  by = c("shf_ef_cat")
) %>%
  mutate(
    shf_ntprobnp_cat = factor(
      case_when(
        shf_ntprobnp < `33%` ~ 1,
        shf_ntprobnp < `66%` ~ 2,
        shf_ntprobnp >= `66%` ~ 3
      ),
      levels = 1:3,
      labels = c("1st tertile within EF", "2nd tertile within EF", "3rd tertile within EF")
    )
  ) %>%
  select(-`33%`, -`66%`)
