# Load data from Amerilife_STG
sConnection <- "Driver=SQL Server;Server=FL-TPA-BI-01.alg.local;Database=Amerilife_STG;UID=SQLserverR_user;PWD=Amerilife01"
# sConnection <- "Driver=SQL Server;Server=JOSE;Database=Amerilife_STG;UID=SQLserverR_user;PWD=Amerilife01"
# sQuery <- "select * from staging.SSAS_Discovery_Typed"
sTable <- "staging.SSAS_Discovery_Typed"

dsDiscovery <- RxSqlServerData(connectionString = sConnection, table = sTable, rowsPerRead = 10000, stringsAsFactors = TRUE)
rxGetVarInfo(data = dsDiscovery)

# save the file locally in xdf format
rxDataStep(inData = dsDiscovery, outFile = "./data/DiscoveryAgents.xdf", overwrite = TRUE)

# Examine the data; this may be better left for after reading the data from the xdf file
# str(dsDiscovery)
# head(dsDiscovery)
# rxSummary(formula = ~., data = dsDiscovery)

