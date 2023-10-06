# Inclusion/exclusion criteria --------------------------------------------------------

flow <- flow[1:8, ]

flow <- rbind(c("General inclusion/exclusion criteria", ""), flow)

flow <- rbind(flow, c("Project specific inclusion/exclusion criteria", ""))

rsdata <- rsdata410 %>%
  filter(!is.na(shf_ef_cat))
flow <- rbind(flow, c("Exlude posts with missing EF", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_ef_cat %in% c("HFpEF", "HFmrEF"))
flow <- rbind(flow, c("Include posts with EF >= 40", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_indexdtm >= ymd("2011-01-01"))
flow <- rbind(flow, c("Exclude posts with index date < 2011-01-01 (start of loop diuretic recording in SwdedeHF)", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(!is.na(shf_loopdiuretic))
flow <- rbind(flow, c("Exclude posts with missing information on loop diuretic", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_loopdiuretic == "No" | !is.na(shf_loopdiureticusage))
flow <- rbind(flow, c("Exclude posts with missing information on loop diuretic usage", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_loopdiuretic == "No" | shf_loopdiureticusage == "When necessary" | !is.na(shf_loopdiureticdose))
flow <- rbind(flow, c("Exclude posts with missing information on loop diuretic dose", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_indexdtm <= ymd("2021-06-30"))
flow <- rbind(flow, c("Exclude posts included >= 2021-07-01 (< 6 months follow-up)", nrow(rsdata)))

rsdata <- rsdata %>%
  group_by(lopnr) %>%
  arrange(shf_indexdtm) %>%
  slice(1) %>%
  ungroup()

flow <- rbind(flow, c("First post / patient", nrow(rsdata)))

rm(rsdata410)
gc()
