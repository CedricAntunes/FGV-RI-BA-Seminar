# AUTOR: CEDRIC ANTUNES (FGV-RI)
# DATA: 5 DE AGOSTO DE 2025

# Limpando meu environment 
rm(list = ls())

# Managing memória
gc()

# Pacotes úteis ----------------------------------------------------------------
library(dplyr)

# Dados ------------------------------------------------------------------------

# Carregando o dado: Lista de alunos
df <- read.csv("C:/Users/cedri/OneDrive/Desktop/Thesis_Seminar/Thesis-Seminar_FGV-RI_2025.2_Students.csv", 
               stringsAsFactors = FALSE,
               # Levando em conta alunos com nomes com acento =)
               fileEncoding = "utf8")

# Manipulação ------------------------------------------------------------------

# Datas dos seminários, tal como previsto no syllabus
dates <- c(
  "August 19, 2025",
  "August 26, 2025",
  "September 2, 2025",
  "September 9, 2025",
  "September 16, 2025",
  "September 23, 2025",
  "September 30, 2025",
  "October 21, 2025",
  "October 25, 2025",
  "October 28, 2025",
  "November 4, 2025",
  "November 11, 2025"
)

# Essa seed garante que vocês possam replicar a atribuição aleatória
set.seed(781)

# Sampling uma única vez
df_randomizado <- df |>
  sample_frac(1)

# Tamanho dos vetores
n_students <- nrow(df_randomizado)
n_dates    <- length(dates)
base_size  <- floor(n_students / n_dates)
remainder  <- n_students %% n_dates

# Construindo um vetor de datas de atribuição, distribuindo as sobras
sizes <- rep(base_size, n_dates)
if (remainder > 0) {
  sizes[1:remainder] <- sizes[1:remainder] + 1
}

# Sobras
assignment_dates <- rep(dates, 
                        times = sizes)

# Criando df único
df_randomizado$Presentation_Date <- assignment_dates

# Salvando o dado --------------------------------------------------------------

# Salvando localmente
write.csv(df_randomizado, 
          "C:/Users/cedri/OneDrive/Desktop/Thesis_Seminar/presentation_assignments.csv", 
          row.names = FALSE)
