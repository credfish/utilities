rm(list=ls())
library(RODBC)            # to connect to oracle
setwd("") # local fishpaste/data folder which has Rdata and access file

##*******## jump down to FISH REA WORKINGS if already saved as a .rfile
#nb .. you must have your own user ID and password here -
## GISUSER doesnt work anymore - and new model is that we all have our
## own IDs and passwords
ch <- odbcConnect("CRED_Oracle", uid = "IWILLIAMS", pwd = "************************")
##
## #list available tables
tv<-sqlTables(ch, tableType = "VIEW")
a<-as.vector(tv$TABLE_NAME[grep("V0_", as.character(tv$TABLE_NAME))])
b<-as.vector(tv$TABLE_NAME[grep("VS_", as.character(tv$TABLE_NAME))])
c<-as.vector(tv$TABLE_NAME[grep("V_BIA_PERC_COVER_PHOTO_STR",
                                as.character(tv$TABLE_NAME))])
d<-as.vector(tv$TABLE_NAME[grep("V_BIA", as.character(tv$TABLE_NAME))])
##
rawtables<-c(a,b,c)
rawtables
df <- sqlQuery(ch, paste("SELECT * FROM GISDAT.V0_FISH_REA")); head(df)
save(df, file="ALL_REA_FISH_RAW.rdata")
##
## commit new data file to master fish_paste/data on github


#TOW FISH #
df <- sqlQuery(ch, paste("SELECT * FROM GISDAT.VS_FISH_TDS")); head(df)
save(df, file="ALL_TOW_FISH_RAW.rdata")


#TOW BENTHIC#
df <- sqlQuery(ch, paste("SELECT * FROM GISDAT.VS_BENT_TDS")); head(df)
save(df, file="ALL_TOW_BENT_RAW.rdata")

#BENTHIC REA
#load("ALL_BIA_STR_RAW.rdata")
bia <- sqlQuery(ch, paste("SELECT * FROM GISDAT.V_BIA_PERC_COVER_PHOTO_STR_")
                ); head(bia)
save(bia, file="ALL_BIA_STR_RAW_NEW.rdata")
