# load XDF file
#dfDiscovery <- rxImport(inData = "./data/DiscoveryAgentsRecoded.xdf")

# load the data form SQL Server
#sConnection <- "Driver=SQL Server;Server=JOSE;Database=Amerilife_STG;Trusted_Connection=TRUE"
sConnection <- "Driver=SQL Server;Server=FL-TPA-BI-01.alg.local;Database=Amerilife_STG;Trusted_Connection=TRUE"
sqlTableName <- "staging.SSAS_Discovery_Recoded"

# Summarize the data by Agent 
sQuery <- "
SELECT  [pk] = MIN([pk])
,[Agent] = MIN([Agent])
,[NPN]
,[CRMGender] = MIN([CRMGender])
,[CRMCounty] = MIN([CRMCounty])
,[CRMState] = MIN([CRMState])
,[CRMZipCode] = MIN([CRMZipCode])
,[HasKits] = MAX([HasKits])
,[HasContracts] = MAX([HasContracts])
,[IsDirectContract] = max(isDirectContract)
,[HasCommissionPayments] = MAX([HasCommissionPayments])
,[DSCPrimaryAddressType] = MIN([DSCPrimaryAddressType])
,[DSCPrimaryCounty] = MIN([DSCPrimaryCounty])
,[DSCPrimaryMetropolitanArea] = MIN([DSCPrimaryMetropolitanArea])
,[DSCPrimaryZipCode] = MIN([DSCPrimaryZipCode])
,[DSCPrimaryZipCode3DigitSectional] = MIN([DSCPrimaryZipCode3DigitSectional])
,[DSCDateOfBirthYear] = MIN([DSCDateOfBirthYear])
,[DSCGenderCode] = MIN([DSCGenderCode])
,[DSCAgentLicenseTypeHealth] = MIN([DSCAgentLicenseTypeHealth])
,[DSCAgentLicenseTypeLife] = MIN([DSCAgentLicenseTypeLife])
,[DSCAgentLicenseTypeVariableProducts] = MIN([DSCAgentLicenseTypeVariableProducts])
,[DSCAgentLicenseTypePropertyCasualty] = MIN([DSCAgentLicenseTypePropertyCasualty])
,[DSCNumberStateLicensesHealth] = MIN([DSCNumberStateLicensesHealth])
,[DSCNumberStateLicensesLife] = MIN([DSCNumberStateLicensesLife])
,[DSCNumberStateLicensesVariableProducts] = MIN([DSCNumberStateLicensesVariableProducts])
,[DSCNumberStateLicensesPropertyCasualty] = MIN([DSCNumberStateLicensesPropertyCasualty])
,[DSCStateLicensedCount] = MIN([DSCStateLicensedCount])
,[DSCSellsRetirementPlanProducts] = MIN([DSCSellsRetirementPlanProducts])
,[DSCCarrierAppointments] = MIN([DSCCarrierAppointments])
,[DSCAppointmentCount] = MIN([DSCAppointmentCount])
,[DSCYearsOfExperience] = MIN([DSCYearsOfExperience])
,[DSCEarliestAppointmentDate] = MIN([DSCEarliestAppointmentDate])
,[DSCDuallyLicensed] = MIN([DSCDuallyLicensed])
,[DSCInCRD] = MIN([DSCInCRD])
,[DSCRIAAffiliation] = MIN([DSCRIAAffiliation])
,[DSCBDRIARep] = MIN([DSCBDRIARep])
,[DSCBrokerDealerAffiliation] = MIN([DSCBrokerDealerAffiliation])
,[12MonthRevenueFromContractCompleted] = SUM([12MonthRevenueFromContractCompleted])
,[12MonthRevenueFromContractEffective] = SUM([12MonthRevenueFromContractEffective])
,[12MonthFromFirstRevenue] = SUM([12MonthFromFirstRevenue])
,[24MonthRevenueFromContractCompleted] = SUM([24MonthRevenueFromContractCompleted])
,[24MonthRevenueFromContractEffective] = SUM([24MonthRevenueFromContractEffective])
,[24MonthFromFirstRevenue] = SUM([24MonthFromFirstRevenue])
,[RevenueSinceInception] = SUM([RevenueSinceInception])
,[PolicyCount] = SUM([PolicyCount])
,[Payments] = SUM([Payments])
,[Commission] = SUM([Commission])
,[PaymentCountSinceInception] = SUM([PaymentCountSinceInception])
,RecordCount = COUNT(*)
FROM [staging].[SSAS_Discovery_Recoded]
group by NPN
"

sqlDataTable <- RxSqlServerData(connectionString = sConnection,
    sqlQuery = sQuery)
    #table = sqlTableName)
df <- rxImport(inData = sqlDataTable,
    rowsPerRead = 10000,
    stringsAsFactors = TRUE)

# Common libraries
library(ggplot2)
library(car)
library(dplyr)
library(corrplot)
library(gplots)
library(gridExtra)
library(cowplot)
library(corrplot)
library(caret)
library(knitr)

# Set the row names to the pk from SQL
row.names(df) <- df$pk
#rxGetVarInfo(df)