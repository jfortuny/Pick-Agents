# Read data only from Amerilife_STG; mostly done for single variable analysis.
source("~/visual studio 2015/projects/Pick Agents/Pick Agents/code/sourceAmerilife_STG.R", encoding = "Windows-1252")

str(df)
summary(df)

#region Initial Analysis

# Single attribute analysis

#summary(df$PaymentCountSinceInception)
#summary(df$"12MonthRevenueFromContractCompleted")
#summary(df$"24MonthRevenueFromContractCompleted")

######################################################################
# Commissions
summary(df$Commission)
plot(df$Commission)
hist(df$Commission)

l2Commission <- log2(df$Commission + 28000)
hist(l2Commission)
l10Commission <- log10(df$Commission + 28000)
hist(l10Commission)
lCommission <- log(df$Commission + 28000)
hist(lCommission)

par(mfrow = c(2, 2))
csCommission <- scale(df$Commission, center = FALSE, scale = FALSE)
hist(csCommission, main = "No Center, No scaling")
csCommission <- scale(df$Commission, center = TRUE, scale = FALSE)
hist(csCommission, main = "Center")
csCommission <- scale(df$Commission, center = FALSE, scale = TRUE)
hist(csCommission, main = "Scaling")
csCommission <- scale(df$Commission, center = TRUE, scale = TRUE)
hist(csCommission, main = "Center, Scaling")
par(mfrow = c(1, 1))

yjCommission <- yjPower(df$Commission + 28000, -0.5)
plot(yjCommission)

# All
dfPlot <- df %>%
select(Commission)
ggplot(data = dfPlot, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 1000, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions generated by an Agent") +
labs(x = "Total Commissions", y = "Frequency")

CommissionBinned <-
recode(df$Commission, "-30000:-5000='Debt 5 to 30k';-4999.99:-500='Debt 500 to 5k';
    -499.99:0='Small Debt';0.01:100='$0 to $100'; 100.01:200='$100 to $200';
    200.01:300='$200 to $300';300.01:400='$300 to $400';400.01:500='$400 to $500';
    500.01:1000 = '$500 to $1k';1000.01:5000 = '$1k to $5k';else = 'Above $5k' ",
    as.factor.result = TRUE,
    levels = c('Debt 5 to 30k', 'Debt 500 to 5k', 'Small Debt', '$0 to $100', '$100 to $200',
    '$200 to $300', '$300 to $400', '$400 to $500', '$500 to $1k', '$1k to $5k', 'Above $5k'))
dfBinned <- data.frame(table(CommissionBinned))
#barplot(table(CommissionBinned))
ggplot(data = dfBinned, aes(x = CommissionBinned, y = Freq)) +
geom_bar(stat = "identity") +
ylim(0, 45000) +
ggtitle("Frequency of Lifetime Commissions and Debt\ngenerated by an Agent") +
labs(x = "Total Commissions", y = "Count of Agents") +
theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
geom_text(aes(label = Freq), vjust = -0.2, color = "darkgreen", size = 3)

# Between $1 and $1000
dfPlot <- df %>%
select(Commission) %>%
filter(Commission <= 1000 & Commission > 0)
ggplot(data = dfPlot, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 10, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions from $1 up to $1,000\n generated by an Agent") +
labs(x = "Total Commissions", y = "Frequency")

# Above $5000
dfPlot <- df %>%
select(Commission) %>%
filter(Commission > 5000)
ggplot(data = dfPlot, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 5000, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions from $5000 and up\n generated by an Agent") +
labs(x = "Total Commissions", y = "Frequency")

# Between $5000 and $50000
dfPlot <- df %>%
select(Commission) %>%
filter(Commission > 5000 & Commission <= 50000)
ggplot(data = dfPlot, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 5000, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions from $5000 to $50,000\n generated by an Agent") +
labs(x = "Total Commissions", y = "Frequency")

# Between $5000 and $50000 - Counts - Stacked by Direct vs Upline
dfPlot <- df %>%
select(c(Commission, IsDirectContract)) %>%
filter(Commission > 5000 & Commission <= 50000)
ggplot(data = dfPlot, aes(x = Commission, y = ..count.., fill = IsDirectContract)) +
geom_histogram(binwidth = 5000, color = "grey60", size = 0.2) +
ggtitle("Frequency of Lifetime Commissions from $5000 to $50,000\n generated by an Agent") +
labs(x = "Total Commissions", y = "Counts")

# Between $500 and $2,500
dfPlot <- df %>%
select(Commission) %>%
filter(Commission <= 2500 & Commission >= 500)
ggplot(data = dfPlot, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 100, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions from $500 up to $2,500\n generated by an Agent") +
labs(x = "Total Commissions", y = "Frequency")

# Between $500 and $2,500 - Counts - Stacked by Direct vs Upline
dfPlot <- df %>%
select(c(Commission, IsDirectContract)) %>%
filter(Commission <= 2500 & Commission >= 500)
ggplot(data = dfPlot, aes(x = Commission, y = ..count.., fill = IsDirectContract)) +
geom_histogram(binwidth = 100, color = "grey60", size = 0.2) +
ggtitle("Frequency of Lifetime Commissions from $500 up to $2,500\n generated by an Agent") +
labs(x = "Total Commissions", y = "Count of Agents")

# Between $500 and $2,500 - Counts - Stacked by Direct vs Upline
dfPlot <- df %>% select(c(Commission, IsDirectContract)) %>% filter(Commission <= 2500 & Commission >= 500)
ggplot(data = dfPlot, aes(x = Commission, y = ..count.., fill = IsDirectContract)) +
geom_histogram(binwidth = 100, color = "grey60", size = 0.2) +
ggtitle("Counts of Lifetime Commissions from $500 up to $2,500\n generated by an Agent") +
labs(x = "Total Commissions", y = "Counts")

# Agents with debt
dfPlot <- df %>%
select(Commission) %>%
filter(Commission < 0)
ggplot(data = dfPlot, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 2000, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Counts of Lifetime Debts generated by an Agent\nThese Agents never produced revenue only debt") +
labs(x = "Total Debt", y = "Frequesncy")

# Agents with debt - Counts
dfPlot <- df %>%
select(Commission) %>%
filter(Commission < 0)
ggplot(data = dfPlot, aes(x = Commission, y = ..count..)) +
geom_histogram(binwidth = 2000, color = "grey60", size = 0.2) +
ggtitle("Counts of Lifetime Debts generated by an Agent\nThese Agents never produced revenue only debt") +
labs(x = "Total Debt", y = "Counts")

############################################################################
# 12 Month Revenue from Contract Completed
summary(df$`12MonthRevenueFromContractCompleted`)

# All
dfPlot <- df %>%
select(`12MonthRevenueFromContractCompleted`)
ggplot(data = dfPlot, aes(x = `12MonthRevenueFromContractCompleted`, y = ..density..)) +
geom_histogram(binwidth = 1000, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of First 12 Month Revenue From CC\ngenerated by an Agent") +
labs(x = "First 12 Month Revenue From CC", y = "Frequency")

CommissionBinned <-
recode(df$`12MonthRevenueFromContractCompleted`, "-30000:-5000='Debt 5 to 30k';-4999.99:-500='Debt 500 to 5k';
    -499.99:0='Small Debt';0.01:100='$0 to $100'; 100.01:200='$100 to $200';
    200.01:300='$200 to $300';300.01:400='$300 to $400';400.01:500='$400 to $500';
    500.01:1000 = '$500 to $1k';1000.01:5000 = '$1k to $5k';else = 'Above $5k' ",
    as.factor.result = TRUE,
    levels = c('Debt 5 to 30k', 'Debt 500 to 5k', 'Small Debt', '$0 to $100', '$100 to $200',
    '$200 to $300', '$300 to $400', '$400 to $500', '$500 to $1k', '$1k to $5k', 'Above $5k'))
dfBinned <- data.frame(table(CommissionBinned))
#barplot(table(CommissionBinned))
ggplot(data = dfBinned, aes(x = CommissionBinned, y = Freq)) +
geom_bar(stat = "identity") +
ylim(0, 10000) +
ggtitle("Frequency of First 12 Month Commissions and Debt\ngenerated by an Agent") +
labs(x = "First 12 Month Commissions", y = "Count of Agents") +
theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
geom_text(aes(label = Freq), vjust = -0.2, color = "darkgreen", size = 3)

# Above $50,000
dfPlot <- df %>%
select(`12MonthRevenueFromContractCompleted`, IsDirectContract) %>%
filter(`12MonthRevenueFromContractCompleted` > 50000)
ggplot(data = dfPlot, aes(x = `12MonthRevenueFromContractCompleted`, y = ..count.., fill = IsDirectContract)) +
geom_histogram(binwidth = 5000, color = "grey60", size = 0.2) +
#geom_density(color = "red", size = 1) +
ggtitle("First 12 Month Revenue From CC of $50,000 and up\ngenerated by an Agent") +
labs(x = "First 12 Month Revenue From Contract Completed", y = "Count of Agents") +
theme(legend.position = "top")

# Between $5000 and $50000 - Counts - Stacked by Direct vs Upline
dfPlot <- df %>%
select(c(`12MonthRevenueFromContractCompleted`, IsDirectContract)) %>%
filter(`12MonthRevenueFromContractCompleted` > 5000 & `12MonthRevenueFromContractCompleted` <= 50000)
ggplot(data = dfPlot, aes(x = `12MonthRevenueFromContractCompleted`, y = ..count.., fill = IsDirectContract)) +
geom_histogram(binwidth = 5000, color = "grey60", size = 0.2) +
ggtitle("First 12 Month Revenue From CC between $5,000 and $50,000\n generated by an Agent") +
labs(x = "First 12 Month Revenue From Contract Completed", y = "Count of Agents") +
theme(legend.position = "top")

# Between $2,500 and $5,000 - Counts - Stacked by Direct vs Upline
dfPlot <- df %>%
select(c(`12MonthRevenueFromContractCompleted`, IsDirectContract)) %>%
filter(`12MonthRevenueFromContractCompleted` > 2500 & `12MonthRevenueFromContractCompleted` <= 5000)
ggplot(data = dfPlot, aes(x = `12MonthRevenueFromContractCompleted`, y = ..count.., fill = IsDirectContract)) +
geom_histogram(binwidth = 100, color = "grey60", size = 0.2) +
ggtitle("First 12 Month Revenue From CC between $2,500 and $5,000\n generated by an Agent") +
labs(x = "First 12 Month Revenue From Contract Completed", y = "Count of Agents") +
theme(legend.position = "top")

# Between $500 and $2,500 - Counts - Stacked by Direct vs Upline
dfPlot <- df %>%
select(c(`12MonthRevenueFromContractCompleted`, IsDirectContract)) %>%
filter(`12MonthRevenueFromContractCompleted` <= 2500 & `12MonthRevenueFromContractCompleted` >= 500)
ggplot(data = dfPlot, aes(x = `12MonthRevenueFromContractCompleted`, y = ..count.., fill = IsDirectContract)) +
geom_histogram(binwidth = 100, color = "grey60", size = 0.2) +
ggtitle("First 12 Month Revenue From CC between $500 and $2,500\n generated by an Agent") +
labs(x = "First 12 Month Revenue From Contract Completed", y = "Count of Agents") +
theme(legend.position = "top")

# Agents with debt - Counts
dfPlot <- df %>%
select(`12MonthRevenueFromContractCompleted`) %>%
filter(`12MonthRevenueFromContractCompleted` < 0)
ggplot(data = dfPlot, aes(x = `12MonthRevenueFromContractCompleted`, y = ..count..)) +
geom_histogram(binwidth = 200, color = "grey60", size = 0.2) +
ggtitle("Counts of Debts generated by an Agent\nThese Agents never produced revenue only debt") +
labs(x = "Total Debt", y = "Counts")

###############################################################################################
# Top producers
topAgents <- df %>%
select(c(Agent, NPN, CRMGender, CRMState, CRMZipCode, Commission, PolicyCount)) %>%
filter(Commission >= 5000) %>%
arrange(Commission)
kable(topAgents)
###############################################################################################

# Bi-variate analysis of numeric attributes
plot(df$Commission ~ df$DSCYearsOfExperience)

dfBase <- df %>% filter(Commission >= 500) %>% select(c(Commission, DSCYearsOfExperience))
plot(dfBase$Commission ~ dfBase$DSCYearsOfExperience)

dfBase <- df %>% filter(Commission >= 500 & Commission <= 5000) %>% select(c(Commission, DSCYearsOfExperience))
plot(dfBase$Commission ~ dfBase$DSCYearsOfExperience)
dfBaseComplete <- complete.cases(dfBase)
y <- dfBase[dfBaseComplete,] %>% select(c(Commission))
x <- dfBase[dfBaseComplete,] %>% select(c(DSCYearsOfExperience))
cor(x, y) # Not correlated in the 500 to 5000 range?

# In bulk - Commissions only
names(df)[c(23, 24, 25, 26, 27, 30, 31, 47)]
cor(df[, c(23, 24, 25, 26, 27, 30, 31, 47)])
cor(df[, c(23, 24, 25, 26, 27, 30, 31, 47)], use = "complete.obs")
corrplot.mixed(corr = cor(df[, c(23, 24, 25, 26, 27, 30, 31, 47)], use = "complete.obs"), upper = "ellipse", tl.pos = "lt",
    col = colorpanel(50, "red", "gray60", "blue4"))
# There appears to be a medium correlation (Cohen's Rules of Thumb) between 
# Commissions and Years of Experience

dfBaseComplete <- complete.cases(df)
scatterplotMatrix(df[dfBaseComplete, c(23, 24, 25, 26, 27, 30, 31, 47)], diagonal = "histogram")
# We need to examine carefully the influence of the extremes; thay appear to 
# have large leverage

# In bulk - All revenue metrics
names(df)[c(23, 24, 25, 26, 27, 30, 31, 38:49)]
cor(df[, c(23, 24, 25, 26, 27, 30, 31, 38:49)])
corrplot.mixed(corr = cor(df[, c(23, 24, 25, 26, 27, 30, 31, 38:49)], use = "complete.obs"), upper = "ellipse", tl.pos = "lt",
    col = colorpanel(50, "red", "gray60", "blue4"))

# scatterplotMatrix(df[dfBaseComplete, c(23, 24, 25, 26, 27, 30, 31, 38:49)], diagonal = "histogram")

###########################################################################################################
# So it appears that the AmeriLife revenue is not related to the numeric attributes of a Discovery Agent  #
# except perhaps Years of Experience                                                                      #
###########################################################################################################
# As expected all revenue metrics from the DW are highly cvorrelated amongst themselves, with Commission  #
# showing the strongest correlation to all other revenue metrics, in any of its variants and leaving the  #
# policy metrics (RevenueSinceInception, PolicyCount, Payments and PaymentCountSinceInception) out of the #
# analysis, as well as the RecordCount metric.                                                            #
###########################################################################################################

# Will the correlations be different if we scale and center the measures (or even if we make them
# positive)?


# Bi-variate analysis of categorical attributes

# Select a subset of the columns
#dfBase <- df %>%
#select(starts_with("CRM"), starts_with("Has"), starts_with("DSC"), contains("Revenue"), 
    #PolicyCount, Payments, Commission, PaymentCountSinceInception, RecordCount)
dfBase <- df %>%
select(CRMGender, CRMState, CRMZipCode, DSCGenderCode,
    DSCPrimaryAddressType, DSCPrimaryMetropolitanArea, DSCPrimaryZipCode, DSCPrimaryZipCode3DigitSectional, DSCPrimaryCounty,
    DSCAgentLicenseTypeHealth, DSCAgentLicenseTypeLife, DSCAgentLicenseTypeVariableProducts,
    DSCAgentLicenseTypePropertyCasualty, DSCSellsRetirementPlanProducts, DSCCarrierAppointments,
    DSCDuallyLicensed, DSCInCRD, DSCRIAAffiliation, DSCBDRIARep, DSCBrokerDealerAffiliation,
    Commission)

#dfBaseComplete <- complete.cases(dfBase)
#names(df)[c(13:16, 18:22, 28, 29, 33:37, 47)]

plot(dfBase$Commission ~ dfBase$DSCGenderCode)

#endregion Initial Analysis


#############################################################################################################
# Verify top performars

topAgents <- df %>%
select(c(Agent, NPN, CRMGender, CRMState, CRMZipCode, Commission, PolicyCount)) %>%
filter(Commission >= 5000) %>%
arrange(Commission)

table(topAgents$CRMState)
topAgentsByState <- topAgents %>% count(CRMState) %>% arrange(desc(n))
kable(topAgentsByState)

# PR seems to have a large share of those; verifying Puerto Rico first
PRtopAgents <- topAgents %>%
filter(CRMState == "PR")
PRtopAgents

FLtopAgents <- topAgents %>%
filter(CRMState == "FL")
FLtopAgents

# Find bad performers
bottomAgents <- df %>%
select(c(Agent, NPN, CRMGender, CRMState, CRMZipCode, Commission, PolicyCount)) %>%
filter(Commission <= 0) %>%
arrange(Commission)

# Producers with some return
minReturn <- 400
producingAgents <- df %>%
select(c(Agent, NPN, CRMGender, CRMState, CRMZipCode, Commission, PolicyCount)) %>%
filter(Commission >= minReturn) %>%
arrange(Commission)

plot(producingAgents$Commission)
hist(producingAgents$Commission)
hist(producingAgents$Commission[producingAgents$Commission <= 10000])

library(dplyr)
library(tidyr)
library(ggplot2)

ggplot(data = producingAgents, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 500, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions generated by a Producing Agent") +
labs(x = "Total Commissions", y = "Frequency")

junk <- producingAgents %>% filter(Commission <= 10000)
ggplot(data = junk, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 500, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions generated by a Producing Agent\nFrom $400 to $10,000") +
labs(x = "Total Commissions", y = "Frequency")

junk <- producingAgents %>% filter(Commission > 10000 & Commission <= 50000)
ggplot(data = junk, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 1000, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions generated by a Producing Agent\nAbove $10,000 and below $50,000") +
labs(x = "Total Commissions", y = "Frequency")

junk <- producingAgents %>% filter(Commission > 50000)
ggplot(data = junk, aes(x = Commission, y = ..density..)) +
geom_histogram(binwidth = 10000, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Lifetime Commissions generated by a Producing Agent\nAbove $50,000") +
labs(x = "Total Commissions", y = "Frequency")


ggplot(data = producingAgents, aes(x = log10(Commission), y = ..density..)) +
geom_histogram(binwidth = 0.1, color = "grey60", size = 0.2) +
geom_density(color = "red", size = 1) +
ggtitle("Frequency of Log10 Lifetime Commissions generated by a Producing Agent") +
labs(x = "Total Commissions", y = "Frequency")


