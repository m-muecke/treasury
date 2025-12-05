# Changelog

## treasury (development version)

## treasury 0.4.0

CRAN release: 2025-08-26

- Fixed bug in checking for {readxl} installation.
- Improved documentation.
- Renamed functions for consistency:
  - [`tr_bill_rates()`](https://m-muecke.github.io/treasury/reference/tr_bill_rate.md)
    to
    [`tr_bill_rate()`](https://m-muecke.github.io/treasury/reference/tr_bill_rate.md)
  - [`tr_par_yields()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md)
    to
    [`tr_par_yield()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md)

## treasury 0.3.0

CRAN release: 2025-07-10

- Migration to data.table package. Internal data manipulation is now
  done using data.table and all functions return data.table objects.

## treasury 0.2.0

CRAN release: 2024-07-05

- Better documentation.
- Support for Treasury High Quality Market (HQM) Corporate Bond Yield
  Curve data.
- Support for Treasury Nominal Coupon-Issue (TNC) Yield Curve data.
- Support for Treasury Real Coupon-Issue (TRC) Yield Curve data.
- Support for Treasury Breakeven Inflation Curve (TBI curve) data.

## treasury 0.1.0

CRAN release: 2024-03-22

- Initial CRAN submission.
