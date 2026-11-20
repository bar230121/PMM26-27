library(tidyverse)
rawdata <- read_csv("data/betriebsdaten.csv")
view(rawdata)
vergleich <- rawdata |> filter(maschine %in% c("M1", "M3"))
t.test(masse_mm ~ maschine, data = vergleich)
chargen <- rawdata |>
  group_by(maschine, charge) |>
  summarise(mm = mean(masse_mm, na.rm = TRUE), .groups = "drop") |>
  pivot_wider(names_from = maschine, values_from = mm)

chargen$M3 - chargen$M1
t.test(chargen$M3, chargen$M1, paired = TRUE)
