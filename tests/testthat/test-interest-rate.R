test_that("input validation works", {
  fns = list(
    tr_yield_curve,
    tr_bill_rate,
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
  data = data.table(
    date = rep("2020-02-03", 14L),
    maturity = c(
      "BC_1MONTH",
      "BC_1_5MONTH",
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
    rate = rnorm(14L)
  )
  actual = clean_yield_curve(data)
  expected = copy(data[1:13])
  expected[,
    maturity := c(
      "1 month",
      "1.5 month",
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

test_that("clean_bill_rate works", {
  date = rep("2020-02-03", 12L)
  rate = 1:12
  type = c(
    "ROUND_B1_CLOSE_4WK_2",
    "ROUND_B1_YIELD_4WK_2",
    "ROUND_B1_CLOSE_6WK_2",
    "ROUND_B1_YIELD_6WK_2",
    "ROUND_B1_CLOSE_8WK_2",
    "ROUND_B1_YIELD_8WK_2",
    "ROUND_B1_CLOSE_13WK_2",
    "ROUND_B1_YIELD_13WK_2",
    "ROUND_B1_CLOSE_26WK_2",
    "ROUND_B1_YIELD_26WK_2",
    "ROUND_B1_CLOSE_52WK_2",
    "ROUND_B1_YIELD_52WK_2"
  )
  maturity_date = as.Date("2020-03-01") + rep(1:6, each = 2L)
  cusip = rep(sprintf("CUSIP%d", 1:6), each = 2L)
  data = data.table(
    date = date,
    type = type,
    value = rate,
    maturity_date = maturity_date,
    cusip = cusip
  )
  actual = clean_bill_rate(data)
  type = rep(c("close", "yield"), 6L)
  maturity = c(
    "4 weeks",
    "4 weeks",
    "6 weeks",
    "6 weeks",
    "8 weeks",
    "8 weeks",
    "13 weeks",
    "13 weeks",
    "26 weeks",
    "26 weeks",
    "52 weeks",
    "52 weeks"
  )
  expected = data.table(
    date = date,
    type = type,
    maturity = maturity,
    maturity_date = maturity_date,
    cusip = cusip,
    value = rate
  )
  expect_identical(actual, expected)
})

test_that("parse_bill_rate attaches maturity date and cusip per tranche", {
  doc = xml2::read_xml(
    '<feed xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"
           xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices">
       <m:properties>
         <d:INDEX_DATE>2023-01-03T00:00:00</d:INDEX_DATE>
         <d:ROUND_B1_CLOSE_4WK_2>4.1</d:ROUND_B1_CLOSE_4WK_2>
         <d:ROUND_B1_YIELD_4WK_2>4.2</d:ROUND_B1_YIELD_4WK_2>
         <d:ROUND_B1_CLOSE_13WK_2>4.5</d:ROUND_B1_CLOSE_13WK_2>
         <d:ROUND_B1_YIELD_13WK_2>4.6</d:ROUND_B1_YIELD_13WK_2>
         <d:MATURITY_DATE_4WK>2023-01-31T00:00:00</d:MATURITY_DATE_4WK>
         <d:MATURITY_DATE_13WK>2023-04-04T00:00:00</d:MATURITY_DATE_13WK>
         <d:CUSIP_4WK>912796ABC</d:CUSIP_4WK>
         <d:CUSIP_13WK>912796XYZ</d:CUSIP_13WK>
       </m:properties>
     </feed>'
  )
  node = xml2::xml_find_first(doc, ".//m:properties")
  expect_identical(
    parse_bill_rate(node),
    data.table(
      date = rep(as.Date("2023-01-03"), 4L),
      type = c(
        "ROUND_B1_CLOSE_4WK_2",
        "ROUND_B1_YIELD_4WK_2",
        "ROUND_B1_CLOSE_13WK_2",
        "ROUND_B1_YIELD_13WK_2"
      ),
      value = c(4.1, 4.2, 4.5, 4.6),
      maturity_date = as.Date(c("2023-01-31", "2023-01-31", "2023-04-04", "2023-04-04")),
      cusip = c("912796ABC", "912796ABC", "912796XYZ", "912796XYZ")
    )
  )
})

test_that("clean_long_term_rate works", {
  date = rep("2020-02-03", 10L)
  rate_type = rep(c("BC_20year", "Over_10_years", "Real_Rate"), 10L)
  rate = 1:10
  data = data.table(date = date, rate_type = rate_type, rate = rate)
  actual = clean_long_term_rate(data)
  expected = copy(actual)
  expected[, rate_type := rep(c("20 year", "over 10 years", "real rate"), 10L)]
  expect_identical(actual, expected)
})

test_that("parse_long_term_rate parses the extrapolation factor", {
  make = function(factor) {
    xml2::read_xml(sprintf(
      '<properties xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices">
         <d:QUOTE_DATE>2004-01-02T00:00:00</d:QUOTE_DATE>
         <d:RATE_TYPE>BC_20year</d:RATE_TYPE>
         <d:RATE>5.21</d:RATE>
         <d:EXTRAPOLATION_FACTOR>%s</d:EXTRAPOLATION_FACTOR>
       </properties>',
      factor
    ))
  }
  expect_identical(
    parse_long_term_rate(make("0.05")),
    data.table(
      date = as.Date("2004-01-02"),
      rate_type = "BC_20year",
      rate = 5.21,
      extrapolation_factor = 0.05
    )
  )
  expect_identical(parse_long_term_rate(make("N/A"))$extrapolation_factor, NA_real_)
})

test_that("clean_real_yield_curve works", {
  date = rep("2020-02-03", 10L)
  maturity = rep(c("TC_5YEAR", "TC_7YEAR", "TC_10YEAR", "TC_20YEAR", "TC_30YEAR"), 2L)
  rate = 1:10
  data = data.table(date = date, maturity = maturity, rate = rate)
  actual = clean_real_yield_curve(data)
  expected = copy(data)
  expected[,
    maturity := rep(c("5 year", "7 year", "10 year", "20 year", "30 year"), 2L)
  ]
  expect_identical(actual, expected)
})
