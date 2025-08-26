# treasury 0.4.0

* Fixed bug in checking for {readxl} installation.
* Improved documentation.
* Renamed functions for consistency:
  * `tr_bill_rates()` to `tr_bill_rate()`
  * `tr_par_yields()` to `tr_par_yield()`

# treasury 0.3.0

* Migration to data.table package. Internal data manipulation is now done using
  data.table and all functions return data.table objects.

# treasury 0.2.0

* Better documentation.
* Support for Treasury High Quality Market (HQM) Corporate Bond Yield Curve data.
* Support for Treasury Nominal Coupon-Issue (TNC) Yield Curve data.
* Support for Treasury Real Coupon-Issue (TRC) Yield Curve data.
* Support for Treasury Breakeven Inflation Curve (TBI curve) data.

# treasury 0.1.0

* Initial CRAN submission.
