
#  ------------------------------------------------------------------------
#
# Title : Import ChromPAin
#    By : PhM
#  Date : 2024-02-29
#
#  ------------------------------------------------------------------------

import <- function(){
library(tidyverse)
library(janitor)
library(baseph)
library(lubridate)
  
#
pat <- read_delim("datas/patient.csv", delim = ";",na = c("", "NA", "ND", "NK", "nk"), show_col_types = FALSE)
analg <- read_delim("datas/analg.csv", delim = ";", na = c("", "NA", "ND", "NK", "nk"), show_col_types = FALSE)
gestes <- read_delim("datas/gestes.csv", delim = ";", na = c("", "NA", "ND", "NK", "nk"), show_col_types = FALSE)
deces <- read_delim("datas/deces.csv", delim = ";", na = c("", "NA", "ND", "NK", "nk"), show_col_types = FALSE)

tt <- pat %>%
  left_join(analg, by = "id") %>%
  left_join(gestes, by = "id") %>% 
  left_join(deces, by = "id") %>%
  clean_names() |> 
mutate(terme = cut(tt$terme,
                    include.lowest = TRUE,
                    right = FALSE,
                    dig.lab = 4,
                    breaks = c(0, 28, 32, 37, 55),
                   labels = c("Très grande prématurité", "Grande prématurité", "Prématurité moyenne", "À terme"))) |> 
 mutate_all(as.factor)
#
saveRDS(tt, file = "datas/chrompain.RDS")
}
