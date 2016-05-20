## -*- R -*-

## calcul du score de qualité moyen aux restaurations de l'haplotype sauvage.

library(gcbiasr)
library(dplyr)
library(ggplot2)

#' La distribution des scores de qualité n'est pas normale.
shapiro.test(sample(conversion_tract$qual, 1000))

set_gcbiasr_theme()

#' La moyenne et la médiane des scores de qualités aux sites restaurés et aux
#' sites non restaurés n'est pas significativement différente.
conversion_tract %>%
    keep_clean_only() %>%
    filter(cons == "x" | cons == "X", qual >= 40) %>%
    group_by(isrestor) %>%
    summarise(mean = mean(qual), count = n(), median = median(qual))

ggplot(conversion_tract,
       aes(x = qual)) +
    geom_histogram() +
    facet_wrap( ~cons , scales = "free")

#' Quand on enlève les sites restaurés de faible qualité, on n'a pas de
#' différences significatives. Quand on les laisse, la différence est
#' significative.

wilcox.test(x = conversion_tract$qual[
                conversion_tract$isrestor & conversion_tract$qual > 40
            ],
            y = conversion_tract$qual[
                is.na(conversion_tract$isrestor)
            ])

## Différence significative
wilcox.test(x = conversion_tract$qual[
                conversion_tract$isrestor #& conversion_tract$qual > 40
            ],
            y = conversion_tract$qual[
                is.na(conversion_tract$isrestor)
            ])
