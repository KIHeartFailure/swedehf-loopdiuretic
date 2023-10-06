# Additional variables from NPR -------------------------------------------

load(file = paste0(shfdbpath, "/data/", datadate, "/patregrsdata.RData"))

# For additional exclusion criteria ---------------------------------------

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  opvar = OP_all,
  type = "com",
  name = "acutecoronary_excl",
  stoptime = -90,
  diakod = " I20| I21| I22",
  opkod = " FNG",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  opvar = OP_all,
  type = "com",
  name = "endstagehf_excl",
  stoptime = -5 * 365.25,
  opkod = " XE00| FXG00| FXH00| FXL10| FXL20| FXL30| FXM10| FXM20| FXM30| FXJ00| FXK00",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  opvar = OP_all,
  type = "com",
  name = "cardiacsurgery_excl",
  stoptime = -30,
  opkod = " FNG| FNA| FNB| FNC| FND| FNE| FNF| FNH| FMA00| FMA10| FMA20| FMA96| FMC00| FMC10| FMC20| FMC96| FMD00| FMD10| FMD20| FMD30| FMD33| FMD40| FMD96| FMW96| FKA| FKB| FKC| FKD| FKW96| FPE26| FPG36| FPG33| FPG30| FPG96| FPG20",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "pah_excl",
  stoptime = -365.25 * 5,
  diakod = " I270",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "postpartumcardio_excl",
  stoptime = -180,
  diakod = " O903",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "thyroid_excl",
  stoptime = -30,
  diakod = " I409| I400| I408| I411| I410| I401| I412| I514| I431| E85[0-8]",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "obstructivehc_excl",
  stoptime = -365.25 * 5,
  diakod = " I421",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "stroke_excl",
  stoptime = -90,
  diakod = " I600| I61| I62| I63| I64",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  opvar = OP_all,
  type = "com",
  name = "dialysis_excl",
  stoptime = -365,
  diakod = " Z49",
  opkod = " DR015| DR016| DR017| DR023| DR024",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  opvar = OP_all,
  type = "com",
  name = "transplant_excl",
  stoptime = -365.25 * 5,
  opkod = " KAS10| KAS20| KAS96| FQA| GDG19| GDG00| GDG30| FQB00| FQB10| FQW96| JJC00| JJC96| JJC10| JJC20| JJC30| DJ005| DJ006| JJC40| JLE03| JLE96| JLE00",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  opvar = OP_all,
  type = "com",
  name = "liver_excl",
  stoptime = -7,
  diakod = " K70| K71| K72| K73| K74| K75| K76| K77| B18",
  warnings = TRUE,
  meta_reg = "NPR (in + out)",
  valsclass = "fac"
)

# Cancer variable:
#  Cancer diagnosis in first position appearing twice within 5 years, but with less than 7 months between the two.
tmp_data <- inner_join(
  rsdata %>%
    select(lopnr, shf_indexdtm),
  patregrsdata,
  by = "lopnr"
) %>%
  mutate(difft = as.numeric(INDATUM - shf_indexdtm)) %>%
  filter(difft <= 0 & difft >= -5 * 365.25) %>%
  mutate(cancer = stringr::str_detect(HDIA, " C(?!44)")) %>%
  filter(cancer)

tmp_data <- tmp_data %>%
  group_by(lopnr, shf_indexdtm) %>%
  arrange(INDATUM) %>%
  mutate(difftcancer = as.numeric(INDATUM - lag(INDATUM))) %>%
  ungroup() %>%
  # arrange(lopnr, shf_indexdtm) %>%
  # select(lopnr, shf_indexdtm, INDATUM, difftcancer) %>%
  filter(difftcancer <= 7 * 30.5) %>%
  group_by(lopnr, shf_indexdtm) %>%
  slice(1) %>%
  ungroup() %>%
  mutate(sos_com_cancer_excl = if_else(cancer, 1, 0))

rsdata <- left_join(
  rsdata,
  tmp_data %>% dplyr::select(lopnr, shf_indexdtm, sos_com_cancer_excl),
  by = c("lopnr", "shf_indexdtm")
) %>%
  mutate(sos_com_cancer_excl = replace_na(sos_com_cancer_excl, 0)) %>%
  mutate(sos_com_cancer_excl = factor(sos_com_cancer_excl, levels = 0:1, labels = c("No", "Yes")))

metcancer <- data.frame(
  Variable = "sos_com_cancer_excl",
  Code = "C excl 44",
  Register = "NPR (in + out)",
  Position = "HDIA",
  Period = "2 occurences in 0--1826.25 with < 7 months between"
)

metaout <- bind_rows(metaout, metcancer)

# Repeated HFH ------------------------------------------------------------

rsdata <- create_sosvar(
  sosdata = patregrsdata %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  noof = TRUE,
  name = "nohosphf",
  stoptime = global_followup,
  diakod = " I110| I130| I132| I255| I420| I423| I425| I426| I427| I428| I429| I43| I50| J81| K761| R57",
  censdate = censdtm,
  warnings = TRUE,
  meta_reg = "NPR (in)"
)
