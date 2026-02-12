# Daily treasury par real yield curve rates

The par real curve, which relates the par real yield on a Treasury
Inflation Protected Security (TIPS) to its time to maturity, is based on
the closing market bid prices on the most recently auctioned TIPS in the
over-the-counter market. The par real yields are derived from input
market prices, which are indicative quotations obtained by the Federal
Reserve Bank of New York at approximately 3:30 PM each business day.
Treasury began publishing this series on January 2, 2004. At that time
Treasury released 1 year of historical data.

## Usage

``` r
tr_real_yield_curve(date = NULL)
```

## Source

<https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>

## Arguments

- date:

  (`NULL` \| `character(1)` \| `numeric(1)`)  
  Date in format yyyy or yyyymm. If `NULL`, all data is returned.
  Default `NULL`.

## Value

A
[`data.table::data.table()`](https://rdrr.io/pkg/data.table/man/data.table.html)
containing the rates or `NULL` when no entries were found.

## See also

Other interest rate:
[`tr_bill_rate()`](https://m-muecke.github.io/treasury/reference/tr_bill_rate.md),
[`tr_long_term_rate()`](https://m-muecke.github.io/treasury/reference/tr_long_term_rate.md),
[`tr_real_long_term()`](https://m-muecke.github.io/treasury/reference/tr_real_long_term.md),
[`tr_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_yield_curve.md)

## Examples

``` r
# \donttest{
# get data for a single month
tr_real_yield_curve("202201")
#>            date maturity  rate
#>          <Date>   <char> <num>
#>   1: 2022-01-03   5 year -1.58
#>   2: 2022-01-03   7 year -1.25
#>   3: 2022-01-03  10 year -0.97
#>   4: 2022-01-03  20 year -0.55
#>   5: 2022-01-03  30 year -0.36
#>   6: 2022-01-04   5 year -1.56
#>   7: 2022-01-04   7 year -1.20
#>   8: 2022-01-04  10 year -0.91
#>   9: 2022-01-04  20 year -0.47
#>  10: 2022-01-04  30 year -0.27
#>  11: 2022-01-05   5 year -1.44
#>  12: 2022-01-05   7 year -1.10
#>  13: 2022-01-05  10 year -0.82
#>  14: 2022-01-05  20 year -0.39
#>  15: 2022-01-05  30 year -0.20
#>  16: 2022-01-06   5 year -1.30
#>  17: 2022-01-06   7 year -0.99
#>  18: 2022-01-06  10 year -0.73
#>  19: 2022-01-06  20 year -0.33
#>  20: 2022-01-06  30 year -0.15
#>  21: 2022-01-07   5 year -1.28
#>  22: 2022-01-07   7 year -0.97
#>  23: 2022-01-07  10 year -0.72
#>  24: 2022-01-07  20 year -0.33
#>  25: 2022-01-07  30 year -0.16
#>  26: 2022-01-10   5 year -1.24
#>  27: 2022-01-10   7 year -0.95
#>  28: 2022-01-10  10 year -0.70
#>  29: 2022-01-10  20 year -0.33
#>  30: 2022-01-10  30 year -0.15
#>  31: 2022-01-11   5 year -1.36
#>  32: 2022-01-11   7 year -1.05
#>  33: 2022-01-11  10 year -0.79
#>  34: 2022-01-11  20 year -0.40
#>  35: 2022-01-11  30 year -0.22
#>  36: 2022-01-12   5 year -1.32
#>  37: 2022-01-12   7 year -1.01
#>  38: 2022-01-12  10 year -0.74
#>  39: 2022-01-12  20 year -0.35
#>  40: 2022-01-12  30 year -0.17
#>  41: 2022-01-13   5 year -1.30
#>  42: 2022-01-13   7 year -0.99
#>  43: 2022-01-13  10 year -0.73
#>  44: 2022-01-13  20 year -0.34
#>  45: 2022-01-13  30 year -0.17
#>  46: 2022-01-14   5 year -1.24
#>  47: 2022-01-14   7 year -0.92
#>  48: 2022-01-14  10 year -0.66
#>  49: 2022-01-14  20 year -0.27
#>  50: 2022-01-14  30 year -0.10
#>  51: 2022-01-18   5 year -1.15
#>  52: 2022-01-18   7 year -0.84
#>  53: 2022-01-18  10 year -0.59
#>  54: 2022-01-18  20 year -0.22
#>  55: 2022-01-18  30 year -0.06
#>  56: 2022-01-19   5 year -1.11
#>  57: 2022-01-19   7 year -0.81
#>  58: 2022-01-19  10 year -0.57
#>  59: 2022-01-19  20 year -0.21
#>  60: 2022-01-19  30 year -0.05
#>  61: 2022-01-20   5 year -1.12
#>  62: 2022-01-20   7 year -0.76
#>  63: 2022-01-20  10 year -0.50
#>  64: 2022-01-20  20 year -0.17
#>  65: 2022-01-20  30 year -0.05
#>  66: 2022-01-21   5 year -1.16
#>  67: 2022-01-21   7 year -0.84
#>  68: 2022-01-21  10 year -0.59
#>  69: 2022-01-21  20 year -0.26
#>  70: 2022-01-21  30 year -0.12
#>  71: 2022-01-24   5 year -1.21
#>  72: 2022-01-24   7 year -0.89
#>  73: 2022-01-24  10 year -0.63
#>  74: 2022-01-24  20 year -0.27
#>  75: 2022-01-24  30 year -0.12
#>  76: 2022-01-25   5 year -1.22
#>  77: 2022-01-25   7 year -0.89
#>  78: 2022-01-25  10 year -0.63
#>  79: 2022-01-25  20 year -0.25
#>  80: 2022-01-25  30 year -0.09
#>  81: 2022-01-26   5 year -1.09
#>  82: 2022-01-26   7 year -0.78
#>  83: 2022-01-26  10 year -0.53
#>  84: 2022-01-26  20 year -0.18
#>  85: 2022-01-26  30 year -0.03
#>  86: 2022-01-27   5 year -1.10
#>  87: 2022-01-27   7 year -0.82
#>  88: 2022-01-27  10 year -0.59
#>  89: 2022-01-27  20 year -0.26
#>  90: 2022-01-27  30 year -0.11
#>  91: 2022-01-28   5 year -1.19
#>  92: 2022-01-28   7 year -0.90
#>  93: 2022-01-28  10 year -0.66
#>  94: 2022-01-28  20 year -0.30
#>  95: 2022-01-28  30 year -0.14
#>  96: 2022-01-31   5 year -1.20
#>  97: 2022-01-31   7 year -0.90
#>  98: 2022-01-31  10 year -0.65
#>  99: 2022-01-31  20 year -0.29
#> 100: 2022-01-31  30 year -0.12
#>            date maturity  rate
#>          <Date>   <char> <num>
# or for the entire year
tr_real_yield_curve(2022)
#>             date maturity  rate
#>           <Date>   <char> <num>
#>    1: 2022-01-03   5 year -1.58
#>    2: 2022-01-03   7 year -1.25
#>    3: 2022-01-03  10 year -0.97
#>    4: 2022-01-03  20 year -0.55
#>    5: 2022-01-03  30 year -0.36
#>   ---                          
#> 1241: 2022-12-30   5 year  1.66
#> 1242: 2022-12-30   7 year  1.61
#> 1243: 2022-12-30  10 year  1.58
#> 1244: 2022-12-30  20 year  1.62
#> 1245: 2022-12-30  30 year  1.67
# }
```
