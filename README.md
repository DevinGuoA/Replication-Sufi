# How to replicate my write up 
See Write-up.pdf for more detailed analysis
# Sufi (2009)  

By running `BA952 Replication/Sufi/do_file/main.do`, you are expected to get all empirical results in Sufi(2009).

## Raw Data Used

`BA952 Replication/Sufi/raw_data` includes the following datasets:

- `sufi(2009).dta` is the dataset provided by Sufi, which includes the key variables *lineun*, *line*, *linetot*,*lineofcredit_rs*, *lineofcredit*, and *def*. Please see [Sufi's research publications](https://faculty.chicagobooth.edu/amir-sufi/research/refereed-publications) for more details.
- `annual_fundamental.dta` is the dataset downloaded from Compustat, which includes the annual accounting variables needed to replicate the results.
- `sp500.dta` is the monthly dataset for S&P 500 indicators, which includes the key variable $ \text{spmim} $.

We use two methods to generate **cash flow volatility** and **industry sales volatility** in this replication:

$`\text{Yearly Volatility}_i = \sqrt{\frac{1}{5} \sum_{t=t-4}^{t} (var_{i,t} - \bar{var}_{i,t})^2}`$
- $`var`$ is the variables of firm $`i`$ in year $`y`$
Second, we also use standard deviation of quarterly observations within a year to measure the cash flow volatility and industry sale volatility, the quartly dataset used downloading from Compustat are as follows:
- `cash_flow_volatility_quarterly.dta`
- `industry_volatility_quarterly.dta`

$`\text{Quarterly Volatility}_i = \sqrt{\frac{1}{4} \sum_{q=1}^{4} (var_{i,q} - \bar{var}_{i,y})^2}`$
- $`var`$ is the variables of firm $`i`$ in quarter $`q`$ of year $`y`$

## Do file Structure

By running `0main.do`, you are expected to get all the empirical results in the replication. Specifically, it is connected to the following do files:
- `1merge_clean.do`: cleans the accounting variables from Compustat and merge with Sufi(2009) speicic dataset
- `1clean_basic.do`: implements the exclusion conditions to drop the abnormal observations and winsorize the variables
- `1clean_appendix.do`: cleans the variable using the alternative definitions as discussed above
- `3table/figure.do`: output the empirical results of the corresponding table or figure.
- `4diagnostic.do`: conduct the analysis on why the empirical results are not perfectly align with Sufi(2009) by summarizing the difference between the sample used.

![image](https://github.com/user-attachments/assets/880dcbe1-c2dc-4f4f-b03e-1d0da5ca40b0)

# Sufi and Roberts (2009)  

## Raw Data Used
'BA952 Replication/Sufi and Roberts/raw_data' includes the following datasets:
- `quarterly_fundamental.dta` is the quarterly accounting data from Compustat
- `violation.dta` is the unique dataset provided by Sufi and Roberts, which includes key variable *violtion*, Please see [Sufi's research publications](https://faculty.chicagobooth.edu/amir-sufi/research/refereed-publications) for more details.
- `sp500.dta` is the monthly dataset for S&P 500 indicators, which includes the key variable $ \text{spmim} $.
## Do file Structure

By running  `0main.do`, you are expected to get all the empirical results in the replication. Specifically, it is connected to the following do files:
-  `1clean.do`: cleans the accounting variables from Compustat and merge the firm characteristics with Sufi and Roberts(2009) specific data
-  `1clean_first_difference.do`: generates the first difference of the variables used in the regression according to Sufi and Roberts(2009)'s definition.
-  `1clean_first_difference_Appendix.do`: generates the first difference of the variables using only lagged one period.
-  '2table.do': output the empirical results of the corresponding tables.
![image](https://github.com/user-attachments/assets/ba80a214-3346-40ad-b27c-517b3b6f454c)

