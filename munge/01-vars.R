# Variables for baseline tables -----------------------------------------------

tabvars <- c(
  # demo
  "shf_indexyear_cat",
  "shf_sex",
  "shf_age",
  "shf_age_cat",

  # organizational
  "shf_location",
  "shf_followuphfunit",
  "shf_followuplocation_cat",

  # clinical factors and lab measurements
  "shf_ef_cat",
  "shf_durationhf",
  "shf_nyha",
  "shf_nyha_cat",
  "shf_killip",
  "shf_xray", 
  "shf_bmi",
  "shf_bmi_cat",
  "shf_bpsys",
  "shf_bpdia",
  "shf_map",
  "shf_map_cat",
  "shf_heartrate",
  "shf_heartrate_cat",
  "shf_gfrckdepi",
  "shf_gfrckdepi_cat",
  "shf_potassium",
  "shf_potassium_cat",
  "shf_hb",
  "shf_ntprobnp",
  "shf_ntprobnp_cat",

  # treatments
  # "shf_diuretic",
  # "shf_loopdiureticusage",
  # "shf_loopdiuretic_cat",
  "shf_loopdiureticsub",
  "shf_thiazide", 
  "shf_rasiarni",
  "shf_mra",
  "shf_digoxin",
  "shf_diuretic",
  "shf_nitrate",
  "shf_asaantiplatelet",
  "shf_anticoagulantia",
  "shf_statin",
  "shf_bbl",
  "shf_device_cat",
  "shf_sglt2",

  # comorbs
  "shf_smoke_cat",
  "shf_sos_com_diabetes",
  "shf_sos_com_hypertension",
  "shf_sos_com_ihd",
  "sos_com_pad",
  "sos_com_stroke",
  "shf_sos_com_af",
  "shf_anemia",
  "sos_com_valvular",
  "sos_com_liver",
  "sos_com_cancer3y",
  "sos_com_renal",
  "sos_com_sleepapnea",
  "sos_com_depression",
  "sos_com_charlsonci",
  "sos_com_charlsonci_cat",

  # socec
  "scb_famtype",
  "scb_child",
  "scb_education",
  "scb_dispincome_cat",
  "shf_qol",
  "shf_qol_cat"
)

# Variables for models (imputation, log, cox reg) ----------------------------

tabvars_not_in_mod <- c(
  "shf_age",
  "shf_nyha",
  "shf_killip",
  "shf_bpsys",
  "shf_bpdia",
  "shf_map",
  "shf_heartrate",
  "shf_gfrckdepi",
  "shf_hb",
  "shf_ntprobnp",
  "shf_potassium",
  "shf_bmi",
  "sos_com_charlsonci",
  "sos_com_charlsonci_cat",
  "shf_sglt2",
  "sos_com_renal",
  "shf_qol",
  "shf_qol_cat",
  "shf_diuretic",
  "shf_loopdiureticusage",
  "shf_loopdiuretic_cat",
  "shf_loopdiureticsub",
  "shf_loopdiureticdose", 
  "shf_thiazide", 
  "shf_xray"
)

modvars <- tabvars[!(tabvars %in% tabvars_not_in_mod)]

stratavars <- "shf_location"

outvars <- tibble(
  var = c("sos_out_death", "sos_out_deathcv", "sos_out_hosphf", "sos_out_nohosphf", "sos_out_deathcvhosphf", "sos_out_deathcvnohosphf"),
  time = c("sos_outtime_death", "sos_outtime_death", "sos_outtime_hosphf", "sos_outtime_death", "sos_outtime_hosphf", "sos_outtime_death"),
  name = c("All-cause mortality", "CVD", "First HFH", "Total HFH", "First HFH/CVD", "Total HFH/CVD"),
  composite = c(0, 0, 0, 0, 1, 1),
  rep = c(0, 0, 0, 1, 0, 1),
  primary = c(0, 0, 0, 0, 0, 0),
  order = c(6, 3, 4, 5, 1, 2)
) %>%
  arrange(order)


metavars <- bind_rows(
  metavars,
  tibble(
    variable = c(
      "shf_thiazide"
    ),
    label = c(
      "Thiazide"
    )
  )
)

