test_that("input validation works", {
  expect_snapshot(error = TRUE, tr_auctions("foo"))
  expect_snapshot(error = TRUE, tr_auctions(days = -1L))
  expect_snapshot(error = TRUE, tr_announcements(days = 1.5))
  expect_snapshot(error = TRUE, tr_upcoming("foo"))
})

test_that("clean_securities works", {
  dt = data.table(
    cusip = c("912797UP0", "91282CQQ7"),
    securityType = c("Bill", "Note"),
    auctionDate = c("2026-06-11T00:00:00", "2026-06-10T00:00:00"),
    interestRate = c("", "4.375000"),
    bidToCoverRatio = c("3.130000", "2.570000"),
    refCpiOnIssueDate = c("", "332.926430"),
    reopening = c("Yes", "")
  )
  actual = clean_securities(dt)
  expected = data.table(
    cusip = c("912797UP0", "91282CQQ7"),
    security_type = c("Bill", "Note"),
    auction_date = as.Date(c("2026-06-11", "2026-06-10")),
    interest_rate = c(NA, 4.375),
    bid_to_cover_ratio = c(3.13, 2.57),
    ref_cpi_on_issue_date = c(NA, 332.92643),
    reopening = c("Yes", NA)
  )
  expect_identical(actual, expected)
})
