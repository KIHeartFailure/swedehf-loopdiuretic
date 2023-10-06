# Inclusion/exclusion criteria --------------------------------------------------------

flow <- rbind(flow, c("Exclusion criteria (to make similar to clinical trial)", ""))

rsdata <- rsdata %>%
  filter(shf_hb >= 8 | is.na(shf_hb))
flow <- rbind(flow, c("Exlude patients with Hb < 8 at index (missing Hb considered >= 8)", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_bmi <= 45 | is.na(shf_bmi))
flow <- rbind(flow, c("Exlude patients with BMI > 45 at index (missing BMI considered < 45)", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_age >= 40 | is.na(shf_age))
flow <- rbind(flow, c("Exlude patients with age < 40 at index", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_acutecoronary_excl == "No")
flow <- rbind(flow, c("Exlude patients with acute coronary syndromes within 3 months", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_endstagehf_excl == "No")
flow <- rbind(flow, c("Exlude patients with end-stage HF", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_cardiacsurgery_excl == "No")
flow <- rbind(flow, c("Exlude patients with cardiac surgery or cardiac mechanical support implantation within 1 month", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_pah_excl == "No")
flow <- rbind(flow, c("Exlude patients with significant pulmonary disease", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_postpartumcardio_excl == "No")
flow <- rbind(flow, c("Exlude patients with postpartum cardiomyopathy within 6 months", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_thyroid_excl == "No")
flow <- rbind(flow, c("Exlude patients with myocarditis, amyloidosis, cardiomyopathy in metabolic diseases within 30 days", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_obstructivehc_excl == "No")
flow <- rbind(flow, c("Exlude patients with obstructive hypertrophic cardiomyopathy", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_stroke_excl == "No")
flow <- rbind(flow, c("Exlude patients with stroke within 3 months", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_dialysis_excl == "No")
flow <- rbind(flow, c("Exlude patients with dialysis within 1 year", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_transplant_excl == "No")
flow <- rbind(flow, c("Exlude patients with history of solid organ transplant", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_cancer_excl == "No")
flow <- rbind(flow, c("Exlude patients with active malignancies", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(is.na(shf_gfrckdepi) | shf_gfrckdepi >= 15)
flow <- rbind(flow, c("Exlude patients with eGFR < 15 (missing eGFR considered >= 15)", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(sos_com_liver_excl == "No" & (!is.na(shf_potassium) | shf_potassium <= 5.5))
flow <- rbind(flow, c("Exlude patients with liver disease within 7 days or potassium >5.5", nrow(rsdata)))

flow <- rbind(flow, c("Population 2", nrow(rsdata)))

rsdata <- rsdata %>%
  mutate(
    pop1 = shf_sos_prevhfh1yr == "Yes" | (shf_ntprobnp >= 300 & !is.na(shf_ntprobnp)),
    pop2 = TRUE
  )
flow <- rbind(flow, c("Population 1 - Include patients with prior HFH < 1 year or NT-proBNP >= 300 (missing NT-proBNP considered < 300)", nrow(rsdata %>% filter(pop1))))

colnames(flow) <- c("Criteria", "N")
