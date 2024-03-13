library(flexdashboard)
library(tidyverse)
library(vroom)
library(here)
edu_noc <- vroom(here("data","edu_noc.csv"))

edu_noc|>
  group_by(NOC)|>
  mutate(prop=value/sum(value))|>
  filter(prop>.01)|>
  slice_max(prop, n=10)|>
  separate(Education, into=c("CIP", "Highest Attained"), sep=": ")|>
  write_csv(here("out","by_noc.csv"))

edu_noc|>
  group_by(Education)|>
  mutate(prop=value/sum(value))|>
  filter(prop>.01)|>
  slice_max(prop, n=10)|>
  write_csv(here("out","by_edu.csv"))
