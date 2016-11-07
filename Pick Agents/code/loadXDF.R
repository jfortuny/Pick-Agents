# load XDF file
dsDiscovery <- rxImport(inData = "./data/DiscoveryAgents.xdf")

# Examine the data
str(dsDiscovery)
summary(dsDiscovery)

head(dsDiscovery)

dsDiscovery[dsDiscovery$CRMGender == "U",]$CRMGender <- NA
dsDiscovery[dsDiscovery$CRMCounty == "--",]$CRMCounty <- NA
dsDiscovery[dsDiscovery$CRMZipCode == "-----",]$CRMZipCode <- NA
dsDiscovery[dsDiscovery$CRMState == "--",]$CRMState <- NA

table(dsDiscovery$NPN)
#dsDiscovery[dsDiscovery$CRMZipCode == "(Other)",]$CRMZipCode <- NA

table(dsDiscovery$CRMZipCode)
summary(dsDiscovery[dsDiscovery$CRMZipCode == "(Other)",])