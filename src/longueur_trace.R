library(gcbiasr)
library(dplyr)

set_gcbiasr_theme()

length_tract <-
    conversion_tract %>%
    keep_clean_only() %>%
    group_by(name, mutant) %>%
    summarise(length = max(refp) - unique(switchp)) %>%
    ungroup()

#' la distribution de la longueur n'est clairement pas normale.
ggplot2::qplot(length_tract$length)
shapiro.test(length_tract$length)

##==============================================================================
#' # Test de comparaison de moyennes non paramétriques.
#'
#' Je compare la moyenne des longueurs de traces de conversions, lorsque le
#' donneur est GC ou lorsque le donneur est AT.
#'
##==============================================================================
wilcox.test(
    (length_tract %>% filter(mutant == "w") %>% select(length))$length
   ,(length_tract %>% filter(mutant == "s") %>% select(length))$length
)


#' J'ai fait la même chose pour comparer les longueurs de traces de conversion
#' quand le premier donneur est w ou quand le premier donneur est strong.

wilcox.test(
    (length_tract %>% filter(mutant == "sw") %>% select(length))$length
   ,(length_tract %>% filter(mutant == "ws") %>% select(length))$length
)


#' test global de l'impact du donneur sur la longueur de la région convertie.
#' Non significatif.
kruskal.test(data = length_tract, length ~ mutant)

#' Calcul de la taille de population nécessaire pour voir un décalage de 30
#' paires de bases.
power.t.test(#length(length_tract$length),
             delta = 30,
             sd = sd(length_tract$length),
             alternative = "one.sided"
             ,power = 0.8
             )

#' Calcul du nombre moyen de nucléotides transférés

mean(length_tract$length)
sd(length_tract$length)

plot_length <-
    length_tract %>%
                           labels = c("CG", "AT", "AT/CG", "CG/AT"))) %>%
                           labels = c("CG", "AT", "AT/CG", "CG/AT"))) %>%
    ggplot(aes(x = mutant, y = length)) +
    geom_point(alpha = 0.2) +
    geom_boxplot(width = 0.2, outlier.colour = "red") +
    coord_flip() +
    labs(x = "", y = "Longueur des régions converties")

ggsave("img/conv_length.pdf", plot_length)
