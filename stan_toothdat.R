tooth <- read.csv("toothdat.csv")

# remove NAs from pd 
tooth <- tooth %>%
  drop_na(maxpd) 

toothdat<-list(id = tooth$id,
               pd = tooth$maxpd,
               smk = tooth$smoke,
               N = nrow(tooth),
               J = length(unique(tooth$id)))

sample50 <- sample(toothdat$id, 50)
tooth50 <- tooth[tooth$id %in% sample50, ]

write.csv(tooth50, "toothdat50.csv", row.names = FALSE)

toothdat50 <- list(id = tooth50$id,
                   pd = tooth50$maxpd,
                   smk = tooth50$smoke,
                   N = nrow(tooth50),
                   J = length(unique(tooth50$id)))

# 
# rt = rDat$rt,
# so = rDat$so,
# N = nrow(rDat),
# ,
# K = length(unique(rDat$item)))