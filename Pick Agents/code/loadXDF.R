# load XDF file
dsDiscovery <- rxImport(inData = "./data/DiscoveryAgents.xdf")

# Examine the data
str(dsDiscovery)
summary(dsDiscovery)

head(dsDiscovery)

