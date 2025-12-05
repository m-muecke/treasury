# Daily treasury bill rates

These rates are the daily secondary market quotations on the most
recently auctioned Treasury Bills for each maturity tranche (4-week,
8-week, 13-week, 17-week, 26-week, and 52-week) for which Treasury
currently issues new bills.

## Usage

``` r
tr_bill_rate(date = NULL)

tr_bill_rates(date = NULL)
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
[`data.table::data.table()`](https://rdatatable.gitlab.io/data.table/reference/data.table.html)
containing the rates or `NULL` when no entries were found.

## Details

Market quotations are obtained at approximately 3:30 PM each business
day by the Federal Reserve Bank of New York. The Bank Discount rate is
the rate at which a bill is quoted in the secondary market and is based
on the par value, amount of the discount and a 360-day year. The Coupon
Equivalent, also called the Bond Equivalent, or the Investment Yield, is
the bill's yield based on the purchase price, discount, and a 365- or
366-day year. The Coupon Equivalent can be used to compare the yield on
a discount bill to the yield on a nominal coupon security that pays
semiannual interest with the same maturity date.

## Deprecated functions

`tr_bill_rates()` has been deprecated and will be removed in a future
version. Please use `tr_bill_rate()` instead.

## See also

Other interest rate:
[`tr_long_term_rate()`](https://m-muecke.github.io/treasury/reference/tr_long_term_rate.md),
[`tr_real_long_term()`](https://m-muecke.github.io/treasury/reference/tr_real_long_term.md),
[`tr_real_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_real_yield_curve.md),
[`tr_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_yield_curve.md)

## Examples

``` r
# \donttest{
# get data for a single month
tr_bill_rate("202201")
#>            date   type maturity value
#>          <Date> <char>   <char> <num>
#>   1: 2022-01-03  close  4 weeks  0.05
#>   2: 2022-01-03  yield  4 weeks  0.05
#>   3: 2022-01-03  close  8 weeks  0.06
#>   4: 2022-01-03  yield  8 weeks  0.06
#>   5: 2022-01-03  close 13 weeks  0.09
#>  ---                                 
#> 196: 2022-01-31  yield 13 weeks  0.24
#> 197: 2022-01-31  close 26 weeks  0.49
#> 198: 2022-01-31  yield 26 weeks  0.50
#> 199: 2022-01-31  close 52 weeks  0.76
#> 200: 2022-01-31  yield 52 weeks  0.77
# or for the entire year
tr_bill_rate(2022)
#>             date   type maturity value
#>           <Date> <char>   <char> <num>
#>    1: 2022-01-03  close  4 weeks  0.05
#>    2: 2022-01-03  yield  4 weeks  0.05
#>    3: 2022-01-03  close  8 weeks  0.06
#>    4: 2022-01-03  yield  8 weeks  0.06
#>    5: 2022-01-03  close 13 weeks  0.09
#>   ---                                 
#> 2586: 2022-12-30  yield 17 weeks  4.70
#> 2587: 2022-12-30  close 26 weeks  4.60
#> 2588: 2022-12-30  yield 26 weeks  4.77
#> 2589: 2022-12-30  close 52 weeks  4.51
#> 2590: 2022-12-30  yield 52 weeks  4.73
# }
```
