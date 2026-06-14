test_that("to_snake_case works", {
  actual = to_snake_case(c(
    "cusip",
    "securityType",
    "bidToCoverRatio",
    "cashManagementBillCMB",
    "auctionDateYear"
  ))
  expected = c(
    "cusip",
    "security_type",
    "bid_to_cover_ratio",
    "cash_management_bill_cmb",
    "auction_date_year"
  )
  expect_identical(actual, expected)
})

test_that("as_numeric_safe works", {
  expect_identical(as_numeric_safe(c("1.5", "2", "")), c(1.5, 2, NA))
  expect_identical(as_numeric_safe(c("a", "1", "")), c("a", "1", NA))
  expect_identical(as_numeric_safe(c("", "")), c(NA_real_, NA_real_))
})
