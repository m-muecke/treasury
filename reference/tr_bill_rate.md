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
[`data.table::data.table()`](https://rdrr.io/pkg/data.table/man/data.table.html)
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

The `maturity_date` and `cusip` columns give the maturity date and CUSIP
of the specific bill quoted for each maturity tranche.

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
#>            date   type maturity maturity_date     cusip value
#>          <Date> <char>   <char>        <Date>    <char> <num>
#>   1: 2022-01-03  close  4 weeks    2022-02-01 912796Q93  0.05
#>   2: 2022-01-03  yield  4 weeks    2022-02-01 912796Q93  0.05
#>   3: 2022-01-03  close  8 weeks    2022-03-01 912796S26  0.06
#>   4: 2022-01-03  yield  8 weeks    2022-03-01 912796S26  0.06
#>   5: 2022-01-03  close 13 weeks    2022-04-07 912796N47  0.09
#>  ---                                                         
#> 196: 2022-01-31  yield 13 weeks    2022-05-05 912796P45  0.24
#> 197: 2022-01-31  close 26 weeks    2022-08-04 912796S67  0.49
#> 198: 2022-01-31  yield 26 weeks    2022-08-04 912796S67  0.50
#> 199: 2022-01-31  close 52 weeks    2023-01-26 912796S34  0.76
#> 200: 2022-01-31  yield 52 weeks    2023-01-26 912796S34  0.77
#>               updated_at
#>                   <POSc>
#>   1: 2026-07-07 16:08:33
#>   2: 2026-07-07 16:08:33
#>   3: 2026-07-07 16:08:33
#>   4: 2026-07-07 16:08:33
#>   5: 2026-07-07 16:08:33
#>  ---                    
#> 196: 2026-07-07 16:08:33
#> 197: 2026-07-07 16:08:33
#> 198: 2026-07-07 16:08:33
#> 199: 2026-07-07 16:08:33
#> 200: 2026-07-07 16:08:33
# or for the entire year
tr_bill_rate(2022)
#>             date   type maturity maturity_date     cusip value
#>           <Date> <char>   <char>        <Date>    <char> <num>
#>    1: 2022-01-03  close  4 weeks    2022-02-01 912796Q93  0.05
#>    2: 2022-01-03  yield  4 weeks    2022-02-01 912796Q93  0.05
#>    3: 2022-01-03  close  8 weeks    2022-03-01 912796S26  0.06
#>    4: 2022-01-03  yield  8 weeks    2022-03-01 912796S26  0.06
#>    5: 2022-01-03  close 13 weeks    2022-04-07 912796N47  0.09
#>   ---                                                         
#> 2586: 2022-12-30  yield 17 weeks    2023-05-02 912796CW7  4.70
#> 2587: 2022-12-30  close 26 weeks    2023-06-29 912796ZR3  4.60
#> 2588: 2022-12-30  yield 26 weeks    2023-06-29 912796ZR3  4.77
#> 2589: 2022-12-30  close 52 weeks    2023-12-28 912796ZN2  4.51
#> 2590: 2022-12-30  yield 52 weeks    2023-12-28 912796ZN2  4.73
#>                updated_at
#>                    <POSc>
#>    1: 2026-07-07 15:58:34
#>    2: 2026-07-07 15:58:34
#>    3: 2026-07-07 15:58:34
#>    4: 2026-07-07 15:58:34
#>    5: 2026-07-07 15:58:34
#>   ---                    
#> 2586: 2026-07-07 15:58:34
#> 2587: 2026-07-07 15:58:34
#> 2588: 2026-07-07 15:58:34
#> 2589: 2026-07-07 15:58:34
#> 2590: 2026-07-07 15:58:34
# }
```
