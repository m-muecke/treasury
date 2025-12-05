# Download Treasury Coupon Issues and Corporate Bond Yield Curves

The Yield Curve for Treasury Nominal Coupon Issues (TNC yield curve) is
derived from Treasury nominal notes and bonds. The Yield Curve for
Treasury Real Coupon Issues (TRC yield curve) is derived from Treasury
Inflation-Protected Securities (TIPS). The Treasury Breakeven Inflation
Curve (TBI curve) is derived from the TNC and TRC yield curves combined.

## Usage

``` r
tr_curve_rate(
  x = c("hqm", "tnc", "trc", "tbi"),
  type = c("monthly", "end-of-month"),
  year = NULL
)

tr_par_yield(x = c("hqm", "tnc", "trc"), type = c("monthly", "end-of-month"))

tr_par_yields(x = c("hqm", "tnc", "trc"), type = c("monthly", "end-of-month"))

tr_forward_rate(
  x = c("tnc", "trc", "tbi"),
  type = c("monthly", "end-of-month")
)
```

## Source

<https://home.treasury.gov/data/treasury-coupon-issues-and-corporate-bond-yield-curves>

## Arguments

- x:

  (`character(1)`)  
  One of the following options:

  - `"hqm"`: The Treasury High Quality Market (HQM) Corporate Bond Yield
    Curve.

  - `"tnc"`: The Treasury Nominal Coupon-Issue (TNC) Yield Curve.

  - `"trc"`: The Treasury Real Coupon-Issue (TRC) Yield Curve.

  - `"tbi"`: The Treasury Breakeven Inflation (TBI) Curve.

- type:

  (`character(1)`)  
  Either `"monthly"` or `"end-of-month"`. Default is `"monthly"`.

- year:

  (`NULL` \| `integer(1)`)  
  Year to download. Default is `NULL`. If `NULL`, then all available
  years are downloaded.

## Value

A
[`data.table::data.table()`](https://rdatatable.gitlab.io/data.table/reference/data.table.html)
containing the treasury rates.

## Deprecated functions

`tr_par_yields()` has been deprecated and will be removed in a future
version. Please use `tr_par_yield()` instead.

## Examples

``` r
if (FALSE) { # \dontrun{
# TBI Treasury Curve Breakeven Rates
tr_curve_rate("tbi")
tr_curve_rate("trc", "end-of-month", 2024L)
# TRC Treasury Yield Curve Par Yields, Monthly Average
tr_par_yield("trc")
# TNC Treasury Yield Curve Forward Rates, End of Month
tr_forward_rate("tnc", "end-of-month")
} # }
```
