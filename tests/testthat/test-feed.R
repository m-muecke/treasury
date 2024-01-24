test_that("input validation works", {
  fns <- list(
    tr_yield_curve,
    tr_bill_rates,
    tr_long_term_rate,
    tr_real_yield_curve,
    tr_real_long_term
  )
  for (fn in fns) {
    expect_error(fn(NA))
    expect_error(fn("2020-01-01"))
    expect_error(fn("202"))
    expect_error(fn("abcd"))
    expect_error(fn("abcdef"))
    expect_error(fn(c(2020, 2021)))
    expect_error(fn(c("2020", "2021")))
    expect_error(fn(1L))
  }
})
