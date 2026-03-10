## code to prepare `resultados` dataset goes here
resultados <- read.csv("data-raw/results.csv")

usethis::use_data(resultados, overwrite = TRUE)
