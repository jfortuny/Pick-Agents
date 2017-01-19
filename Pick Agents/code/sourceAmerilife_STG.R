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

# Summarize the data by Agent - Recode Nulls as "U"
sQuery <- "
SELECT  [pk] = MIN([pk])
,[Agent] = MIN([Agent])
,[NPN]
,[CRMGender] = case when MIN([CRMGender]) is not null then MIN([CRMGender]) else 'U' end
,[CRMCounty] = case when MIN([CRMCounty]) is not null then MIN([CRMCounty]) else 'U' end
,[CRMState] = case when MIN([CRMState]) is not null then MIN([CRMState]) else 'U' end
,[CRMZipCode] = case when MIN([CRMZipCode]) is not null then MIN([CRMZipCode]) else 'U' end
,[HasKits] = MAX([HasKits])
,[HasContracts] = MAX([HasContracts])
,[IsDirectContract] = max(isDirectContract)
,[HasCommissionPayments] = MAX([HasCommissionPayments])
,[DSCPrimaryAddressType] = case when MIN([DSCPrimaryAddressType]) is not null then MIN([DSCPrimaryAddressType]) else 'U' end
,[DSCPrimaryCounty] = case when MIN([DSCPrimaryCounty]) is not null then MIN([DSCPrimaryCounty]) else 'U' end
,[DSCPrimaryMetropolitanArea] = case when MIN([DSCPrimaryMetropolitanArea]) is not null then MIN([DSCPrimaryMetropolitanArea]) else 'U' end
,[DSCPrimaryZipCode] = case when MIN([DSCPrimaryZipCode]) is not null then MIN([DSCPrimaryZipCode]) else 'U' end
,[DSCPrimaryZipCode3DigitSectional] = case when MIN([DSCPrimaryZipCode3DigitSectional]) is not null then MIN([DSCPrimaryZipCode3DigitSectional]) else 'U' end
,[DSCDateOfBirthYear] = MIN([DSCDateOfBirthYear])
,[DSCGenderCode] = case when MIN([DSCGenderCode]) is not null then MIN([DSCGenderCode]) else 'U' end 
,[DSCAgentLicenseTypeHealth] = case when MIN([DSCAgentLicenseTypeHealth]) is not null then MIN([DSCAgentLicenseTypeHealth]) else 'U' end  
,[DSCAgentLicenseTypeLife] = case when MIN([DSCAgentLicenseTypeLife]) is not null then MIN([DSCAgentLicenseTypeLife]) else 'U' end 
,[DSCAgentLicenseTypeVariableProducts] =  case when MIN([DSCAgentLicenseTypeVariableProducts]) is not null then MIN([DSCAgentLicenseTypeVariableProducts]) else 'U' end 
,[DSCAgentLicenseTypePropertyCasualty] = case when MIN([DSCAgentLicenseTypePropertyCasualty]) is not null then MIN([DSCAgentLicenseTypePropertyCasualty]) else 'U' end
,[DSCNumberStateLicensesHealth] = MIN([DSCNumberStateLicensesHealth])
,[DSCNumberStateLicensesLife] = MIN([DSCNumberStateLicensesLife])
,[DSCNumberStateLicensesVariableProducts] = MIN([DSCNumberStateLicensesVariableProducts])
,[DSCNumberStateLicensesPropertyCasualty] = MIN([DSCNumberStateLicensesPropertyCasualty])
,[DSCStateLicensedCount] = MIN([DSCStateLicensedCount])
,[DSCSellsRetirementPlanProducts] = case when MIN([DSCSellsRetirementPlanProducts]) is not null then MIN([DSCSellsRetirementPlanProducts]) else 'U' end  
,[DSCCarrierAppointments] = MIN([DSCCarrierAppointments])
,[DSCAppointmentCount] = MIN([DSCAppointmentCount])
,[DSCYearsOfExperience] = MIN([DSCYearsOfExperience])
,[DSCEarliestAppointmentDate] = MIN([DSCEarliestAppointmentDate])
,[DSCInCRD] = MIN([DSCInCRD])
,[DSCRIAAffiliation] = case when len(MIN([DSCRIAAffiliation])) > 0 then 'Y' else 'N' end
,[DSCBrokerDealerAffiliation] = case when len(MIN([DSCBrokerDealerAffiliation])) > 0 then 'Y' else 'N' end
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
dfr <- rxImport(inData = sqlDataTable,
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