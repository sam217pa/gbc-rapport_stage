library(gcbiasr)
library(dplyr)
library(ggplot2)

set_gcbiasr_theme()

tosample <-
        conversion_tract %>%
        keep_clean_only() %>%
        filter(!is.na(sens)) %>%
        mutate(refb = as.character(refb),
               expb = as.character(expb)) %>%
        group_by(mutant)

mean_list <- lapply(
    replicate(
        10000
       ,
        tosample %>%
        # par mutant
        sample_n(80) %>%
        # échantillone 80 séquences
        group_by(name) %>%
        # calcule le taux de gc moyen par read
        summarise(gc = seqinr::GC(expb) - seqinr::GC(refb)) %>%
        summarise(mean = mean(gc))
       ,
        simplify = FALSE
    ),
    function(i) i$mean
)
mean(unlist(mean_list))

qplot(unlist(mean_list), geom = "density") +
    geom_density(fill ="gray", alpha = 0.2) +
    geom_vline(xintercept = 0.0, color = "red") +
    geom_vline(xintercept = mean(unlist(mean_list)))

mean_list <- unlist(mean_list)
