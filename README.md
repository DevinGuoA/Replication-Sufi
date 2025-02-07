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



