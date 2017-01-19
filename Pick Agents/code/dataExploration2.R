# Read data only from Amerilife_STG; mostly done for single variable analysis.
source("~/visual studio 2015/projects/Pick Agents/Pick Agents/code/sourceAmerilife_STG.R", encoding = "Windows-1252")

dfr <- df
library(gdata)
NAToUnknown(dfr$CRMGender, "Z")




summary(dfr$CRMCounty)
levels(dfr$CRMCounty) <- c("U", levels(dfr$CRMCounty))
dfr$CRMCounty[is.na(dfr$CRMCounty)] <- "U"

str(df)
summary(df)

#region asinh on test data created manually

# testing asinh
test <- c(-10, -2, 0, 1, 2, 10, 20, 100, 1000, 80000, 100000, 90000, 85000, 160000)
hist(test)
hist(test, breaks = 10)
hist(test, breaks = 20)
hist(asinh(test))
hist(asinh(test), breaks = 10)
hist(asinh(test), breaks = 20)

shiftedTest <- test + 15
par(mfrow=c(2,3))
hist(shiftedTest)
hist(shiftedTest, breaks = 10)
hist(shiftedTest, breaks = 20)

hist(asinh(shiftedTest))
hist(asinh(shiftedTest), breaks = 10)
hist(asinh(shiftedTest), breaks = 20)

hist(log2(shiftedTest))
hist(log2(shiftedTest), breaks = 10)
hist(log2(shiftedTest), breaks = 20)
hist(log10(shiftedTest))
hist(log10(shiftedTest), breaks = 10)
hist(log10(shiftedTest), breaks = 20)

myFormulaASINH <- function(x) {
    log2(x + sqrt((x ^ 2 + 1)))
}
shiftedTest
myFormulaASINH(shiftedTest)
hist(myFormulaASINH(shiftedTest), breaks = 10)
hist(myFormulaASINH(shiftedTest), breaks = 20)
hist(myFormulaASINH(shiftedTest))

# test for Commisisons
comm <- df$Commission + 30000
range(comm)
df$comm <- comm

par(mfrow = c(2, 3))

hist(comm,, main = "Commisisons Shifted")
hist(comm, breaks = 20, main = "Commisisons Shifted 20 breaks")
hist(comm, breaks = 100, main = "Commisisons Shifted 100 breaks")

hist(log10(comm), main = "Log 10 of Commisisons Shifted")
hist(log10(comm), breaks = 20, main = "Log 10 of Commisisons Shifted 20 breaks")
hist(log10(comm), breaks = 5, main = "Log 10 of Commisisons Shifted 5 breaks")

hist(log2(comm), main = "Log 2 of Commisisons Shifted")
hist(log2(comm), breaks = 20, main = "Log 2 of Commisisons Shifted 20 breaks")
hist(log2(comm), breaks = 5, main = "Log 2 of Commisisons Shifted 5 breaks")

hist(asinh(comm), main = "asinh of Commisisons Shifted")
hist(asinh(comm), breaks = 20, main = "asinh of Commisisons Shifted 20 breaks")
hist(asinh(comm), breaks = 5, main = "asinh of Commisisons Shifted 5 breaks")

# Look at the tails

#endregion asinh on test data created manually




# Brute force regression
#descriptors <- names(df)

df.complete <- complete.cases(df)
sum(df.complete)
summary(df)
levels(df$DSCAgentLicenseTypeHealth) <- c('Y', 'N')
levels(df$DSCAgentLicenseTypeLife) <- c('Y', 'N')
levels(df$DSCAgentLicenseTypeVariableProducts) <- c('Y', 'N')
levels(df$DSCAgentLicenseTypePropertyCasualty) <- c('Y', 'N')
levels(df$DSCSellsRetirementPlanProducts) <- c('Yes', 'No')
levels(df$DSCDuallyLicensed) <- c('N', 'Y')


lm1 <- lm(comm ~
HasKits +
HasContracts +
DSCPrimaryAddressType +
DSCPrimaryZipCode +
DSCPrimaryZipCode3DigitSectional +
DSCDateOfBirthYear +
DSCGenderCode +
DSCAgentLicenseTypeHealth +
DSCAgentLicenseTypeLife +
DSCAgentLicenseTypeVariableProducts +
DSCAgentLicenseTypePropertyCasualty +
DSCNumberStateLicensesHealth +
DSCNumberStateLicensesLife +
DSCNumberStateLicensesVariableProducts +
DSCNumberStateLicensesPropertyCasualty +
DSCStateLicensedCount +
DSCSellsRetirementPlanProducts +
DSCCarrierAppointments +
DSCAppointmentCount +
DSCYearsOfExperience +
DSCEarliestAppointmentDate +
DSCDuallyLicensed +
DSCInCRD +
DSCRIAAffiliation +
DSCBrokerDealerAffiliation,
data = df)