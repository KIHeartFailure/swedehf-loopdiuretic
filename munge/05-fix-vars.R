# Cut outcomes at 3 years

rsdata <- cut_surv(rsdata, sos_out_deathcvhosphf, sos_outtime_hosphf, 365 * 3, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_hosphf, sos_outtime_hosphf, 365 * 3, cuttime = TRUE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_hospany, sos_outtime_hospany, 365 * 3, cuttime = TRUE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_deathcv, sos_outtime_death, 365 * 3, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_death, sos_outtime_death, 365 * 3, cuttime = TRUE, censval = "No")

rsdata <- rsdata %>%
  rename(shf_loopdiuretic_old = shf_loopdiuretic) %>%
  mutate(
    censdtm = pmin(censdtm, shf_indexdtm + 365 * 3, na.rm = T),
    shf_loopdiuretic = factor(case_when(
      shf_loopdiuretic_old == "No" |
        shf_loopdiureticusage == "When necessary" ~ 0,
      shf_loopdiuretic_old == "Yes" ~ 1
    ), level = 0:1, labels = c("No", "Yes")),
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
  group_by(shf_indexyear) %>%
  summarise(incmed = quantile(scb_dispincome,
    probs = 0.5,
    na.rm = TRUE
  ), .groups = "drop_last")

rsdata <- left_join(
  rsdata,
  inc,
  by = "shf_indexyear"
) %>%
  mutate(
    scb_dispincome_cat = factor(
      case_when(
        scb_dispincome < incmed ~ 1,
        scb_dispincome >= incmed ~ 2
      ),
      levels = 1:2,
      labels = c("Below median within indexyear", "Above median within indexyear")
    )
  ) %>%
  select(-incmed)

# ntprobnp

ntprobnp <- rsdata %>%
  group_by(shf_ef_cat) %>%
  summarise(
    ntmed = quantile(shf_ntprobnp,
      probs = 0.5,
      na.rm = TRUE
    ),
    .groups = "drop_last"
  )

rsdata <- left_join(
  rsdata,
  ntprobnp,
  by = c("shf_ef_cat")
) %>%
  mutate(
    shf_ntprobnp_cat = factor(
      case_when(
        shf_ntprobnp < ntmed ~ 1,
        shf_ntprobnp >= ntmed ~ 2
      ),
      levels = 1:2,
      labels = c("Below median within EF", "Above median within EF")
    )
  ) %>%
  select(-ntmed)
