## -*- R -*-

# calcul du score de qualité moyen aux néomutations

library(gcbiasr)
library(dplyr)
library(ggplot2)


conversion_tract[
    conversion_tract$refb == conversion_tract$snpb &
    conversion_tract$refb != conversion_tract$expb,
    ] %>%
    keep_clean_only() %>%
    group_by(inconv) %>%
    summarise(mean = mean(qual))

conversion_tract %>%
    group_by(inconv) %>%
    summarise(mean = mean(qual))
