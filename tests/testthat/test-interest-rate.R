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
    expect_error(fn(c(2020L, 2021L)))
    expect_error(fn(c("2020", "2021")))
    expect_error(fn(1L))
  }
})

test_that("clean_yield_curve works", {
  data <- data.table(
    date = rep("2020-02-03", 13L),
    maturity = c(
      "BC_1MONTH",
      "BC_2MONTH",
      "BC_3MONTH",
      "BC_6MONTH",
      "BC_1YEAR",
      "BC_2YEAR",
      "BC_3YEAR",
      "BC_5YEAR",
      "BC_7YEAR",
      "BC_10YEAR",
      "BC_20YEAR",
      "BC_30YEAR",
      "BC_30YEARDISPLAY"
    ),
    rate = rnorm(13L)
  )
  actual <- clean_yield_curve(data)
  expected <- copy(data[1:12])
  expected[,
    maturity := c(
      "1 month",
      "2 month",
      "3 month",
      "6 month",
      "1 year",
      "2 year",
      "3 year",
      "5 year",
      "7 year",
      "10 year",
      "20 year",
      "30 year"
    )
  ]
  expect_identical(actual, expected)
})

test_that("clean_bill_rates works", {
  date <- rep("2020-02-03", 10L)
  rate <- 1:10
  type <- c(
    "ROUND_B1_CLOSE_4WK_2",
    "ROUND_B1_YIELD_4WK_2",
    "ROUND_B1_CLOSE_8WK_2",
    "ROUND_B1_YIELD_8WK_2",
    "ROUND_B1_CLOSE_13WK_2",
    "ROUND_B1_YIELD_13WK_2",
    "ROUND_B1_CLOSE_26WK_2",
    "ROUND_B1_YIELD_26WK_2",
    "ROUND_B1_CLOSE_52WK_2",
    "ROUND_B1_YIELD_52WK_2"
  )
  data <- data.table(date = date, type = type, value = rate)
  actual <- clean_bill_rates(data)
  type <- rep(c("close", "yield"), 5L)
  maturity <- c(
    "4 weeks",
    "4 weeks",
    "8 weeks",
    "8 weeks",
    "13 weeks",
    "13 weeks",
    "26 weeks",
    "26 weeks",
    "52 weeks",
    "52 weeks"
  )
  expected <- data.table(
    date = date,
    type = type,
    maturity = maturity,
    value = rate
  )
  expect_identical(actual, expected)
})

test_that("clean_long_term_rate works", {
  date <- rep("2020-02-03", 10L)
  rate_type <- rep(c("BC_20year", "Over_10_years", "Real_Rate"), 10L)
  rate <- 1:10
  data <- data.table(date = date, rate_type = rate_type, rate = rate)
  actual <- clean_long_term_rate(data)
  expected <- copy(actual)
  expected[, rate_type := rep(c("20 year", "over 10 years", "real rate"), 10L)]
  expect_identical(actual, expected)
})

test_that("clean_real_yield_curves works", {
  date <- rep("2020-02-03", 10L)
  maturity <- rep(c("TC_5YEAR", "TC_7YEAR", "TC_10YEAR", "TC_20YEAR", "TC_30YEAR"), 2L)
  rate <- 1:10
  data <- data.table(date = date, maturity = maturity, rate = rate)
  actual <- clean_real_yield_curves(data)
  expected <- copy(data)
  expected[,
    maturity := rep(c("5 year", "7 year", "10 year", "20 year", "30 year"), 2L)
  ]
  expect_identical(actual, expected)
})
