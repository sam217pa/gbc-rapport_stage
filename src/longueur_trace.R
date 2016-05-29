library(gcbiasr)
library(dplyr)

set_gcbiasr_theme()

length_tract <-
    conversion_tract %>%
    keep_clean_only() %>%
    group_by(name, mutant) %>%
    summarise(length = max(refp) - unique(switchp)) %>%
    ungroup()

length_tract

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

## # C'est un graphique que j'ai complètement abandonné, Franck a eu du mal à le
## # comprendre : c'est pas bon signe.
## plot_length <-
##     length_tract %>%
##     mutate(
##         mutant = factor(mutant, labels = c("GC", "AT", "AT/GC", "GC/AT"))
##     ) %>%
##     ## labels = c("GC", "AT", "AT/GC", "GC/AT"))) %>%
##     ggplot(aes(x = mutant, y = length)) +
##     geom_point(alpha = 0.2) +
##     geom_boxplot(width = 0.2, outlier.colour = "red") +
##     coord_flip() +
##     labs(x = "", y = "Longueur des régions converties")

## ggsave("img/conv_length.pdf", plot_length)

# degré de corrélation entre le nombre de points de bascule à une position
# donnée par type de donneur
breakpoints_distribution(conversion_tract) %>%
    ungroup() %>%
    mutate(switchp = cut(switchp, 23)) %>%
    group_by(switchp, mutant) %>%
    summarise(count = sum(distri)) %>%
    ungroup() %>%
    mutate(switchp = as.numeric(switchp)) %>%
    tidyr::spread(mutant, count) %>%
    select(-switchp) %>%
    GGally::ggcorr(label = TRUE)

conversion_tract %>%
    keep_clean_only() %>%
    filter(!is.na(sens), inconv, mutant %in% c("ws", "sw"), qual > 40) %>%
    group_by(expb) %>%
    summarise(count = n()) %>%
    ungroup() %>%
    mutate(#snpb = ifelse(snpb %in% c("A", "T"), "W", "S"),
           expb = ifelse(expb %in% c("A", "T"), "W", "S")) %>%
    group_by( expb) %>%
    summarise(sum = sum(count))

conversion_tract %>%
    keep_clean_only() %>%
    ## filter(name %in% has_23_marker(.)) %>%
    filter(name %in% has_23_marker(.),
           !is.na(sens),
           inconv,
           mutant %in% c("ws", "sw"),
           qual > 40) %>%
    group_by(expb) %>%
    summarise(count = n()) %>%
    ungroup() %>%
    mutate(#expb = ifelse(expb %in% c("A", "T"), "W", "S"),
           expb = ifelse(expb %in% c("A", "T"), "W", "S")) %>%
    group_by(expb) %>%
    summarise(sum = sum(count))
