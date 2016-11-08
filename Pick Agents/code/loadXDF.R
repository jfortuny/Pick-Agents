# load XDF file
dsDiscovery <- rxImport(inData = "./data/DiscoveryAgents.xdf")

# Examine the data
str(dsDiscovery)
summary(dsDiscovery)

dsDiscoveryClean <- dsDiscovery
rxGetVarInfo(dsDiscoveryClean)
str(dsDiscoveryClean)

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
levels(dsDiscoveryClean$CRMState)
table(dsDiscoveryClean$CRMState)

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
levels(dsDiscoveryClean$CarrierGroup)
table(dsDiscoveryClean$CarrierGroup, useNA = c("always"))

# Recode Carrier and convert to factor
dsDiscoveryClean[dsDiscoveryClean$Carrier == "Unknown",]$Carrier <- NA
dsDiscoveryClean$Carrier <- factor(dsDiscoveryClean$Carrier)
levels(dsDiscoveryClean$Carrier)
table(dsDiscoveryClean$Carrier, useNA = c("always"))

# Recode Product and convert to factor
dsDiscoveryClean[dsDiscoveryClean$Product == "Unknown",]$Product <- NA
dsDiscoveryClean$Product <- factor(dsDiscoveryClean$Product)
levels(dsDiscoveryClean$Product)
table(dsDiscoveryClean$Product, useNA = c("always"))

# Recode IsDirectContract and convert to factor
dsDiscoveryClean$IsDirectContract <- factor(dsDiscoveryClean$IsDirectContract, 
    levels = c("Y", "N"), labels = c("Y", "N"))
table(dsDiscoveryClean$IsDirectContract)

# Recode DSCPrimaryAddressType and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryAddressType == "U",]$DSCPrimaryAddressType <- NA
dsDiscoveryClean$DSCPrimaryAddressType <- factor(dsDiscoveryClean$DSCPrimaryAddressType)
table(dsDiscoveryClean$DSCPrimaryAddressType, useNA = c("always"))

# Recode DSCPrimaryCounty and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryCounty == "U",]$DSCPrimaryCounty <- NA
dsDiscoveryClean$DSCPrimaryCounty <- factor(dsDiscoveryClean$DSCPrimaryCounty)
table(dsDiscoveryClean$DSCPrimaryCounty, useNA = c("always"))

# Recode DSCPrimaryMetropolitanArea and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryMetropolitanArea == "U",]$DSCPrimaryMetropolitanArea <- NA
dsDiscoveryClean$DSCPrimaryMetropolitanArea <- factor(dsDiscoveryClean$DSCPrimaryMetropolitanArea)
table(dsDiscoveryClean$DSCPrimaryMetropolitanArea, useNA = c("always"))

# Recode DSCPrimaryZipCode and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryZipCode == "U",]$DSCPrimaryZipCode <- NA
dsDiscoveryClean$DSCPrimaryZipCode <- factor(dsDiscoveryClean$DSCPrimaryZipCode)
table(dsDiscoveryClean$DSCPrimaryZipCode, useNA = c("always"))

# Recode DSCPrimaryZipCode3DigitSectional and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCPrimaryZipCode3DigitSectional == "-1",]$DSCPrimaryZipCode3DigitSectional <- NA
dsDiscoveryClean$DSCPrimaryZipCode3DigitSectional <- factor(dsDiscoveryClean$DSCPrimaryZipCode3DigitSectional)
table(dsDiscoveryClean$DSCPrimaryZipCode3DigitSectional, useNA = c("always"))

# Recode DSCDateOfBirthYear and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCDateOfBirthYear == "-1",]$DSCDateOfBirthYear <- NA
dsDiscoveryClean$DSCDateOfBirthYear <- factor(dsDiscoveryClean$DSCDateOfBirthYear)
table(dsDiscoveryClean$DSCDateOfBirthYear, useNA = c("always"))

# Recode DSCGenderCode and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCGenderCode == "U",]$DSCGenderCode <- NA
dsDiscoveryClean$DSCGenderCode <- factor(dsDiscoveryClean$DSCGenderCode,
    levels = c("1", "2"), labels = c("M", "F"))
table(dsDiscoveryClean$DSCGenderCode, useNA = c("always"))

# Recode DSCAgentLicenseTypeHealth and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCAgentLicenseTypeHealth == "U",]$DSCAgentLicenseTypeHealth <- NA
dsDiscoveryClean$DSCAgentLicenseTypeHealth <- factor(dsDiscoveryClean$DSCAgentLicenseTypeHealth,
    levels = c("Y", "N"), labels = c("Y", "N"))
table(dsDiscoveryClean$DSCAgentLicenseTypeHealth, useNA = c("always"))

# Recode DSCAgentLicenseTypeLife and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCAgentLicenseTypeLife == "U",]$DSCAgentLicenseTypeLife <- NA
dsDiscoveryClean$DSCAgentLicenseTypeLife <- factor(dsDiscoveryClean$DSCAgentLicenseTypeLife,
    levels = c("Y", "N"), labels = c("Y", "N"))
table(dsDiscoveryClean$DSCAgentLicenseTypeLife, useNA = c("always"))

# Recode DSCAgentLicenseTypeVariableProducts and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCAgentLicenseTypeVariableProducts == "U",]$DSCAgentLicenseTypeVariableProducts <- NA
dsDiscoveryClean$DSCAgentLicenseTypeVariableProducts <- factor(dsDiscoveryClean$DSCAgentLicenseTypeVariableProducts,
    levels = c("Y", "N"), labels = c("Y", "N"))
table(dsDiscoveryClean$DSCAgentLicenseTypeVariableProducts, useNA = c("always"))

# Recode DSCAgentLicenseTypePropertyCasualty and convert to factor
dsDiscoveryClean[dsDiscoveryClean$DSCAgentLicenseTypePropertyCasualty == "U",]$DSCAgentLicenseTypePropertyCasualty <- NA
dsDiscoveryClean$DSCAgentLicenseTypePropertyCasualty <- factor(dsDiscoveryClean$DSCAgentLicenseTypePropertyCasualty,
    levels = c("Y", "N"), labels = c("Y", "N"))
table(dsDiscoveryClean$DSCAgentLicenseTypePropertyCasualty, useNA = c("always"))

