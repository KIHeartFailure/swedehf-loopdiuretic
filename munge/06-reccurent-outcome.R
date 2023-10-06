# For MCF figure ----------------------------------------------------------

svpatreg <- patregrsdata %>%
  filter(sos_source == "sv")

svpatreg <- left_join(
  rsdata %>%
    select(
      lopnr, shf_indexdtm, shf_loopdiuretic, shf_loopdiuretic_cat,
      sos_outtime_death, sos_out_deathcv, censdtm, pop1, pop2
    ),
  svpatreg %>%
    select(lopnr, INDATUM, HDIA),
  by = "lopnr"
) %>%
  mutate(sos_outtime = as.numeric(INDATUM - shf_indexdtm)) %>%
  filter(sos_outtime > 0 & sos_outtime <= global_followup & INDATUM <= censdtm)

svpatreg <- svpatreg %>%
  mutate(sos_out_hosphf = stringr::str_detect(HDIA, " I110| I130| I132| I255| I420| I423| I425| I426| I427| I428| I429| I43| I50| J81| K761| R57")) %>%
  filter(sos_out_hosphf) %>%
  select(-INDATUM, -HDIA)

rsdatarep <- bind_rows(
  rsdata %>%
    select(
      lopnr, shf_indexdtm, shf_loopdiuretic, shf_loopdiuretic_cat,
      sos_outtime_death, sos_out_deathcv, censdtm, pop1, pop2
    ),
  svpatreg
) %>%
  mutate(
    sos_out_hosphf = if_else(is.na(sos_out_hosphf), 0, 1),
    sos_outtime = as.numeric(if_else(is.na(sos_outtime), as.numeric(censdtm - shf_indexdtm), sos_outtime))
  )

rsdatarep <- rsdatarep %>%
  group_by(lopnr, shf_indexdtm, sos_outtime) %>%
  arrange(desc(sos_out_hosphf)) %>%
  slice(1) %>%
  ungroup() %>%
  arrange(lopnr, shf_indexdtm)

rsdatarep <- rsdatarep %>%
  group_by(lopnr) %>%
  arrange(shf_indexdtm) %>%
  mutate(
    sos_out_deathcvhosphf = if_else(n() & sos_out_deathcv == "Yes", 1, sos_out_hosphf),
    extra = 0
  ) %>%
  ungroup()

extrarsdatarep <- rsdatarep %>%
  group_by(lopnr) %>%
  arrange(shf_indexdtm) %>%
  slice(n()) %>%
  ungroup() %>%
  filter(sos_out_deathcvhosphf == 1 | sos_out_hosphf == 1) %>%
  mutate(
    sos_out_deathcvhosphf = 0,
    sos_out_hosphf = 0,
    extra = 1
  )

rsdatarep <- bind_rows(rsdatarep, extrarsdatarep) %>%
  arrange(lopnr, sos_outtime, extra)

rm(patregrsdata)
gc()
