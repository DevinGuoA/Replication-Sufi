# How to replicate my write up 
**Dexin Guo**  
February 2025  

**See Write-up.pdf for more detailed analysis**
# Sufi (2009)  

By running `BA952 Replication/Sufi/do_file/main.do`, you are expected to get all empirical results in Sufi(2009).

## Raw Data Used

`BA952 Replication/Sufi/raw_data` includes the following datasets:

- `sufi(2009).dta` is the dataset provided by Sufi, which includes the key variables $\text{lineun}$, $\text{line}$, $\text{linetot}$, $\text{lineofcredit rs}$, $\text{lineofcredit}$, and $\text{def}$. Please see [Sufi's research publications](https://faculty.chicagobooth.edu/amir-sufi/research/refereed-publications) for more details.
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




