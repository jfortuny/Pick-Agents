# load XDF file
dsDiscovery <- rxImport(inData = "./data/DiscoveryAgents.xdf")

# Examine the data
str(dsDiscovery)
summary(dsDiscovery)

dsDiscoveryClean <- dsDiscovery
rxGetVarInfo(dsDiscoveryClean)
str(dsDiscoveryClean)

# Convert MarketingCompany, Marketer, Agent and NPN to factor
dsDiscoveryClean$MarketingCompany <- factor(dsDiscoveryClean$MarketingCompany)
dsDiscoveryClean$Marketer <- factor(dsDiscoveryClean$Marketer)
dsDiscoveryClean$Agent <- factor(dsDiscoveryClean$Agent)
dsDiscoveryClean$NPN <- factor(dsDiscoveryClean$NPN)

# Recode CRMGender and Convert to Factor
dsDiscoveryClean[dsDiscoveryClean$CRMGender == "U",]$CRMGender <- NA
dsDiscoveryClean$CRMGender <- factor(dsDiscoveryClean$CRMGender, levels = c("Male", "Female"), labels = c("M", "F"))
# review results of the recoding and conversion
str(dsDiscoveryClean)
#table(dsDiscoveryClean$CRMGender, useNA = c("always"))

# Recode CRMCounty and convert to factor
dsDiscoveryClean[dsDiscoveryClean$CRMCounty == "--",]$CRMCounty <- NA
dsDiscoveryClean$CRMCounty <- factor(dsDiscoveryClean$CRMCounty)
#levels(dsDiscoveryClean$CRMCounty)
#table(dsDiscoveryClean$CRMCounty, useNA = c("always"))

# Recode State and convert to factor
dsDiscoveryClean[dsDiscoveryClean$CRMState == "--",]$CRMState <- NA
dsDiscoveryClean$CRMState <- factor(dsDiscoveryClean$CRMState)
#levels(dsDiscoveryClean$CRMState)
#table(dsDiscoveryClean$CRMState)

# Recode ZipCode and convert to factor
dsDiscoveryClean[dsDiscoveryClean$CRMZipCode == "-----",]$CRMZipCode <- NA
dsDiscoveryClean$CRMZipCode <- factor(dsDiscoveryClean$CRMZipCode)

# HasKits, Contracts and Commisison Payments conversion to factor
dsDiscoveryClean$HasKits <- factor(dsDiscoveryClean$HasKits, levels = c("Y", "N"), labels = c("Y", "N"))
dsDiscoveryClean$HasContracts <- factor(dsDiscoveryClean$HasContracts, levels = c("Y", "N"), labels = c("Y", "N"))
dsDiscoveryClean$HasCommissionPayments <- factor(dsDiscoveryClean$HasCommissionPayments, levels = c("Y", "N"), labels = c("Y", "N"))

# Recode CarrierGroup and convert to factor
dsDiscoveryClean[dsDiscoveryClean$CarrierGroup == "Unknown",]$CarrierGroup <- NA
dsDiscoveryClean$CarrierGroup <- factor(dsDiscoveryClean$CarrierGroup)
#levels(dsDiscoveryClean$CarrierGroup)
#table(dsDiscoveryClean$CarrierGroup, useNA = c("always"))

# Recode Carrier and convert to factor
dsDiscoveryClean[dsDiscoveryClean$Carrier == "Unknown",]$Carrier <- NA
dsDiscoveryClean$Carrier <- factor(dsDiscoveryClean$Carrier)
#levels(dsDiscoveryClean$Carrier)
#table(dsDiscoveryClean$Carrier, useNA = c("always"))

# Recode Product and convert to factor
dsDiscoveryClean[dsDiscoveryClean$Product == "Unknown",]$Product <- NA
dsDiscoveryClean$Product <- factor(dsDiscoveryClean$Product)
#levels(dsDiscoveryClean$Product)
#table(dsDiscoveryClean$Product, useNA = c("always"))

# Recode IsDirectContract and convert to factor
dsDiscoveryClean$IsDirectContract <- factor(dsDiscoveryClean$IsDirectContract, 
    levels = c("Y", "N"), labels = c("Y", "N"))
#table(dsDiscoveryClean$IsDirectContract)

# Recode DSCPrimaryAddressType and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryAddressType == "U",]$DSCPrimaryAddressType <- NA
dsDiscoveryClean$DSCPrimaryAddressType <- factor(dsDiscoveryClean$DSCPrimaryAddressType)
#table(dsDiscoveryClean$DSCPrimaryAddressType, useNA = c("always"))

# Recode DSCPrimaryCounty and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryCounty == "U",]$DSCPrimaryCounty <- NA
dsDiscoveryClean$DSCPrimaryCounty <- factor(dsDiscoveryClean$DSCPrimaryCounty)
#table(dsDiscoveryClean$DSCPrimaryCounty, useNA = c("always"))

# Recode DSCPrimaryMetropolitanArea and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryMetropolitanArea == "U",]$DSCPrimaryMetropolitanArea <- NA
dsDiscoveryClean$DSCPrimaryMetropolitanArea <- factor(dsDiscoveryClean$DSCPrimaryMetropolitanArea)
#table(dsDiscoveryClean$DSCPrimaryMetropolitanArea, useNA = c("always"))

# Recode DSCPrimaryZipCode and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryZipCode == "U",]$DSCPrimaryZipCode <- NA
dsDiscoveryClean$DSCPrimaryZipCode <- factor(dsDiscoveryClean$DSCPrimaryZipCode)
#table(dsDiscoveryClean$DSCPrimaryZipCode, useNA = c("always"))

# Recode DSCPrimaryZipCode3DigitSectional and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryZipCode3DigitSectional == "-1",]$DSCPrimaryZipCode3DigitSectional <- NA
dsDiscoveryClean$DSCPrimaryZipCode3DigitSectional <- factor(dsDiscoveryClean$DSCPrimaryZipCode3DigitSectional)
#table(dsDiscoveryClean$DSCPrimaryZipCode3DigitSectional, useNA = c("always"))

# Recode DSCDateOfBirthYear and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCDateOfBirthYear == "-1",]$DSCDateOfBirthYear <- NA
dsDiscoveryClean$DSCDateOfBirthYear <- factor(dsDiscoveryClean$DSCDateOfBirthYear)
#table(dsDiscoveryClean$DSCDateOfBirthYear, useNA = c("always"))

# Recode DSCGenderCode and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCGenderCode == "U",]$DSCGenderCode <- NA
dsDiscoveryClean$DSCGenderCode <- factor(dsDiscoveryClean$DSCGenderCode,
    levels = c("1", "2"), labels = c("M", "F"))
#table(dsDiscoveryClean$DSCGenderCode, useNA = c("always"))

# Recode DSCAgentLicenseTypeHealth and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCAgentLicenseTypeHealth == "U",]$DSCAgentLicenseTypeHealth <- "N"
dsDiscoveryClean$DSCAgentLicenseTypeHealth <- factor(dsDiscoveryClean$DSCAgentLicenseTypeHealth,
    levels = c("Y", "N"), labels = c("Y", "N"))
#table(dsDiscoveryClean$DSCAgentLicenseTypeHealth, useNA = c("always"))

# Recode DSCAgentLicenseTypeLife and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCAgentLicenseTypeLife == "U",]$DSCAgentLicenseTypeLife <- "N"
dsDiscoveryClean$DSCAgentLicenseTypeLife <- factor(dsDiscoveryClean$DSCAgentLicenseTypeLife,
    levels = c("Y", "N"), labels = c("Y", "N"))
#table(dsDiscoveryClean$DSCAgentLicenseTypeLife, useNA = c("always"))

# Recode DSCAgentLicenseTypeVariableProducts and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCAgentLicenseTypeVariableProducts == "U",]$DSCAgentLicenseTypeVariableProducts <- "N"
dsDiscoveryClean$DSCAgentLicenseTypeVariableProducts <- factor(dsDiscoveryClean$DSCAgentLicenseTypeVariableProducts,
    levels = c("Y", "N"), labels = c("Y", "N"))
#table(dsDiscoveryClean$DSCAgentLicenseTypeVariableProducts, useNA = c("always"))

# Recode DSCAgentLicenseTypePropertyCasualty and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCAgentLicenseTypePropertyCasualty == "U",]$DSCAgentLicenseTypePropertyCasualty <- "N"
dsDiscoveryClean$DSCAgentLicenseTypePropertyCasualty <- factor(dsDiscoveryClean$DSCAgentLicenseTypePropertyCasualty,
    levels = c("Y", "N"), labels = c("Y", "N"))
#table(dsDiscoveryClean$DSCAgentLicenseTypePropertyCasualty, useNA = c("always"))

# Recode DSCNumberStateLicensesHealth, DSCNumberStateLicensesLife, 
# DSCNumberStateLicensesVariableProducts, DSCNumberStateLicensesPropertyCasualty,
# DSCStateLicensedCount
dsDiscoveryClean[dsDiscoveryClean$DSCNumberStateLicensesHealth == -1,]$DSCNumberStateLicensesHealth <- 0
dsDiscoveryClean[dsDiscoveryClean$DSCNumberStateLicensesLife == -1,]$DSCNumberStateLicensesLife <- 0
dsDiscoveryClean[dsDiscoveryClean$DSCNumberStateLicensesVariableProducts == -1,]$DSCNumberStateLicensesVariableProducts <- 0
dsDiscoveryClean[dsDiscoveryClean$DSCNumberStateLicensesPropertyCasualty == -1,]$DSCNumberStateLicensesPropertyCasualty <- 0
dsDiscoveryClean[dsDiscoveryClean$DSCStateLicensedCount == -1,]$DSCStateLicensedCount <- 0

# Recode DSCSellsRetirementPlanProducts and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCSellsRetirementPlanProducts == "U",]$DSCSellsRetirementPlanProducts <- NA
dsDiscoveryClean$DSCSellsRetirementPlanProducts <- factor(dsDiscoveryClean$DSCSellsRetirementPlanProducts,
    levels = c("Y", "N"), labels = c("Y", "N"))

# Convert DSCCarrierAppointments to factor
dsDiscoveryClean$DSCCarrierAppointments <- factor(dsDiscoveryClean$DSCCarrierAppointments)

# Recode DSCAppointmentCount
dsDiscoveryClean[dsDiscoveryClean$DSCAppointmentCount == -1,]$DSCAppointmentCount <- NA

# Recode DSCYearsOfExperience
dsDiscoveryClean[dsDiscoveryClean$DSCYearsOfExperience == -1,]$DSCYearsOfExperience <- NA

# Recode DSCEarliestAppointmentDate
dsDiscoveryClean[dsDiscoveryClean$DSCEarliestAppointmentDate == "1900-01-01",]$DSCEarliestAppointmentDate <- NA

# Convert DSCDuallyLicensed and DSCInCRD into factors
dsDiscoveryClean$DSCDuallyLicensed <- factor(dsDiscoveryClean$DSCDuallyLicensed,
    levels = c("Y", "N"), labels = c("Y", "N"))
dsDiscoveryClean$DSCInCRD <- factor(dsDiscoveryClean$DSCInCRD,
    levels = c("Y", "N"), labels = c("Y", "N"))

# Recode DSCRIAAffiliation and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCRIAAffiliation == "U",]$DSCRIAAffiliation <- NA
dsDiscoveryClean$DSCRIAAffiliation <- factor(dsDiscoveryClean$DSCRIAAffiliation)

# Recode DSCBrokerDealerAffiliation and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCBrokerDealerAffiliation == "U",]$DSCBrokerDealerAffiliation <- NA
dsDiscoveryClean$DSCBrokerDealerAffiliation <- factor(dsDiscoveryClean$DSCBrokerDealerAffiliation)

# save the file locally in xdf format
rxDataStep(inData = dsDiscoveryClean,
    outFile = "./data/DiscoveryAgentsRecoded.xdf",
    overwrite = TRUE)

# save the file to SQL Server; use Integrated Security
sConnection <- "Driver=SQL Server;Server=FL-TPA-BI-01.alg.local;Database=Amerilife_STG;Trusted_Connection=TRUE"
sqlDestinationTable = "staging.SSAS_Discovery_Recoded"
sqlDataTableWrite <- RxSqlServerData(connectionString = sConnection,
    table = sqlDestinationTable)
rxDataStep(inData = dsDiscoveryClean,
    outFile = sqlDataTableWrite,
    overwrite = TRUE)

## save the file to SQL Server; use Integrated Security; writing to a table I created
#sConnection <- "Driver=SQL Server;Server=FL-TPA-BI-01.alg.local;Database=Amerilife_STG;Trusted_Connection=TRUE"
#sqlDestinationTable = "staging.SSAS_Discovery_Recoded_jf"
#sqlDataTableWrite <- RxSqlServerData(connectionString = sConnection,
    #table = sqlDestinationTable)
#rxDataStep(inData = dsDiscoveryClean,
    #outFile = sqlDataTableWrite,
    #overwrite = TRUE)