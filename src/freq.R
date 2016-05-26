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



run_simul_chi2 <- function(data, n = 100, ...)
{
    has_23_marker <- function(data, ...)
    {
        data %>%
            filter(!is.na(sens)) %>%
            group_by(name) %>%
            filter(n() == 23)%>%
            {unique(.$name)}
    }

    sample_80_clones <- function(data, ...)
    {
        data %>%
            keep_clean_only() %>%
            group_by(mutant, name) %>%
            summarise() %>%
            group_by(mutant) %>%
            sample_n(80) %>%
            select(name) %>%
            {.$name}
    }

    markers_23_list <- has_23_marker(conversion_tract)
    test_weak_strong <- function(data, ...)
    {
        result <-
            conversion_tract %>%
            keep_clean_only() %>%
            ## garde seulement les marqueurs
            filter(!is.na(sens), name %in% markers_23_list) %>%
            ## échantillonne 80 clones
            filter(name %in% sample_80_clones(.)) %>%
            group_by(sens) %>%
            summarise(count = n()) %>%
            tidyr::separate(sens, into = c("ref", "rec"), sep = 1)

        strong_to_weak <- as.numeric(result[2, 3])
        weak_to_strong <- as.numeric(result[3, 3])

        chi2_result <- chisq.test(c(strong_to_weak, weak_to_strong))

        chi2_sens <- function(strong, weak) ifelse(strong > weak, "G", "L")

        c(chi2_result$p.value, chi2_sens(weak_to_strong, strong_to_weak))
    }

    replicats <-
        replicate(
            n,
            conversion_tract %>%
            test_weak_strong()
        )

    rep_data <- replicats %>% t() %>%
        as.data.frame(stringsAsFactors = FALSE)

    colnames(rep_data) <- c("pval", "sens")
    rep_data$pval <- as.numeric(rep_data$pval)

    rep_data
}

result <- run_simul_chi2(conversion_tract, 10000)
