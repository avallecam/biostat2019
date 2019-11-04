#' zona de notas
#' 

# links
# documentación de paquetes a usar en la sesión

# tidyverse https://www.tidyverse.org/
# janitor http://sfirke.github.io/janitor/
# corrr https://tidymodels.github.io/corrr/
# broom https://broom.tidyverse.org/index.html
# haven https://haven.tidyverse.org/index.html
# readxl https://readxl.tidyverse.org/
# writexl https://docs.ropensci.org/writexl/
# skimr https://ropensci.github.io/skimr/
# compareGroups https://cran.r-project.org/web/packages/compareGroups/vignettes/compareGroups_vignette.html
# qvalue https://github.com/StoreyLab/qvalue
# qvalue https://www.bioconductor.org/packages/release/bioc/html/qvalue.html

# instalar paquete si es que está ausente ---------------------------------

# obligatorios

# en repositorio CRAN
if (!require("tidyverse")) {install.packages("tidyverse")}
if (!require("janitor")) {install.packages("janitor")}
if (!require("corrr")) {install.packages("corrr")}
if (!require("broom")) {install.packages("broom")}
if (!require("haven")) {install.packages("haven")}
if (!require("rlang")) {install.packages("rlang")}
if (!require("skimr")) {install.packages("skimr")}
if (!require("knitr")) {install.packages("knitr")}
if (!require("readxl")) {install.packages("readxl")}
if (!require("writexl")) {install.packages("writexl")}
if (!require("kableExtra")) {install.packages("kableExtra")}
if (!require("Hmisc")) {install.packages("Hmisc")}
# en repositorio Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("qvalue")

#puede presentar errores
if (!require("compareGroups")) {install.packages("compareGroups")}

# opcional
if (!require("devtools")) {install.packages("devtools")}
if (!require("qvalue")) {devtools::install_github("avallecam/avallecam")}

