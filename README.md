# Sufi (2009), Sufi and Roberts (2009) Replication  
**Dexin Guo**  
February 2025  

**See README.pdf for more detailed analysis and the data needed provided through email or cloud file sharing**
# Sufi (2009)  

By running `BA952 Replication/Sufi/do_file/main.do`, you are expected to get all empirical results in this write-up.


### Definitions Discussion  

- **Cash flow volatility**: Defined as the standard deviation of cash flows over a five-year rolling window in the main results and as the standard deviation of quarterly cash flows within a year in Appendix: Sufi (2009).  
- **Industry sales volatility**: Defined as the standard deviation of industry sales over a five-year rolling window in the main results and as the standard deviation of quarterly industry sales within a year in Appendix: Sufi (2009).  
- **Firm age and Ln(firm age)**: Due to a high proportion of missing values in the firm-year observations of the Sufi (2009) dataset, missing firm age is replaced by the mean firm age in the industry in the same year. If `data year = IPO year`, then `firm age = 0`. Instead of using `Ln(firm age)`, we use `Ln(firm age + 1)` to ensure all values remain positive.  
- **Assets-cash**: Aligned with the winsorization process in other variables, we show assets minus cash after winsorization at the 5% level.
<img width="548" alt="Screenshot 2025-02-07 at 3 06 55 PM" src="https://github.com/user-attachments/assets/b35a6df6-02c5-4297-b5d9-bbd2ff8c4c10" />


## Discussion of Regression Results  

- The key regression results $\(\frac{\text{EBITDA}}{\text{assets-cash}_{t-1}}\)$ are aligned with Sufi (2009) in terms of the direction and significance of the coefficients. The trend shown in Figure 1 is also consistent. However, several aspects deserve attention:  

  - With $\(\ln(\text{firm age} + 1)\)$, the coefficient is **negatively significant** across all regressions, highlighting the importance of considering the sign of $\(\ln(\text{firm age})\)$.  
  - The coefficient of $\(\frac{\text{EBITDA}}{\text{assets-cash}_{t-1}}\)$ becomes statistically insignificant in columns (3)–(6), possibly due to differences in variable definitions and datasets.  
  - There are 1,676 fewer observations in the full sample (column (1)) compared to Sufi (2009), all of which are **inactive firms**.  

- The trend in **Figure 1** is consistent with Sufi (2009) and remains robust when using alternative variable definitions (see **Appendix: Sufi (2009)**).  
- In summary, slight changes in definitions could have significant effects on regressions that can’t be ignored. The robustness of the results shown by Sufi (2009) needs further discussion.

## Discussion of the Reduced Form Regression  

- This paper tries to answer the question: **What factors determine the use of bank credit?** The two stages are as follows:  

  **First Stage**:  
  $\Pr(\text{get use of credit}) = f(\text{possible factors})$  

  **Second Stage**:  
  $\Pr(\text{has line of credit}) / \text{The amount/proportion of credit used} = g(\Pr(\text{get use of credit}))$  

- However, we only have reduced form regression presented here in **Table 3**, which is not the whole story.  

## Discussion of Variable Definitions  

- Due to the long right tail of **Net Debt Issuance** and **Net Equity Issuance** (1% quantile = -1775, 95% quantile = 4253), we winsorize these variables using asymmetric quantile settings (1% and 85% for **Net Equity Issuance**). The results are consistent with Sufi and Roberts (2009).  

- Instead of using **txditc** (yearly deferred taxes and investment tax credit) as in Sufi (2009), we use **txditcq** (quarterly level) for consistency with other variables.  

- **Book equity** is defined as:  
  $\text{book value equity} = \text{seq} - \text{pstkq} + \text{ceqq} - \text{txditcq}$

## Discussion of Regression Results  

- **Our results are inconsistent with Sufi and Roberts (2009) in several aspects**, especially in first difference regression:  

  - **In Panel A**:  
    - The coefficient of **Covenant violation** in column (1) has a different direction, though it is statistically insignificant.  
    - The coefficients of **lag Covenant violation** are consistent with Sufi and Roberts but are more significant economically.  

  - **In Panel B**:  
    - The coefficients of **lag Covenant violation** are less economically significant compared with Sufi (2009) results.  
    - The coefficients of **Covenant violation** are more economically significant, though they remain statistically insignificant for columns (3)–(4).  

### Possible Reasons  

- **Use of `txditcq` instead of `txditc`** introduces two effects due to the change in definition:  
  - First, the number of observations changes due to the difference between `missing(txditcq)` and `missing(txditc)`.  
  - Second, the **Market-to-book Ratio** has economically and statistically significant correlation with the dependent variable. For example, in all fixed-effect regressions, the coefficient of **Market-to-book Ratio\(_t\)** is significant at 1% with a value of approximately 4.5.  

### Potential Problems in the Order of Winsorizing the Lag Control Variables and Generating Lag Variables  

- In Sufi and Roberts (2009), all **lag control variables** are winsorized at 5%. In contrast, in my `clean.do` file, I winsorize the variables before generating the lag terms to:  
  - Prevent double-winsorization. For example, winsorizing **Assets (at)** automatically addresses outliers in **Lag Assets**.  

- **Potential issue**:  
  - Lag terms are generated using observations outside the research period, leading to winsorization with extra observations and potentially introducing new information.  

- The coefficients of key variables differ from Sufi and Roberts (2009) when using lagged one-quarter differences for control variables in the **Panel B** regression. Specifically:  
  - **Covenant violation** turns negatively significant.  
  - **Lag Covenant violation** becomes insignificant (see **Appendix: Sufi and Roberts (2009)**).

## Appendix: Sufi (2009)  

The following results are generated using **within-year standard deviation** definitions to calculate the **cash flow volatility** and **industry sale volatility**.  

- **Table 1A** shows that under these definitions, the variance and the scale of these variables are relatively small compared with Sufi (2009) and Table 1.  

- Since it requires at least 2 quarters of observations of cash flow/industry sales to generate within-year standard deviations, fewer observations are included in our datasets.  

- **Figure 1A** shows consistent results with Sufi (2009) and Figure 1.  



