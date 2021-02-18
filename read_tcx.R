library(XML)
library(tidyverse)

# https://stackoverflow.com/questions/41798040/use-the-xml-package-in-r-to-read-a-complex-tcx-file

df = xmlParse("~/Downloads/activity_6225545366.tcx")

nodes <- getNodeSet(df, "//ns:Trackpoint", "ns")
rows <-  lapply(nodes, function(x) data.frame(xmlToList(x) ))

df = bind_rows(rows) %>%
  as_tibble() %>%
  mutate(heart_rate = as.numeric(Value),
         power = as.numeric(Extensions.TPX.Watts))
