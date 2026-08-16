test_that("tr_process_response combines paginated responses without losing over-allocation", {
  resp = function(date) {
    httr2::response(
      status_code = 200L,
      headers = list(`content-type` = "application/xml"),
      body = charToRaw(sprintf(
        '<feed xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"
               xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices">
           <m:properties>
             <d:NEW_DATE>%sT00:00:00</d:NEW_DATE>
             <d:BC_1MONTH>0.04</d:BC_1MONTH>
           </m:properties>
         </feed>',
        date
      ))
    )
  }
  dt = tr_process_response(list(resp("2022-02-01"), resp("2022-02-02")), parse_yield_curve)
  expect_identical(dt$date, as.Date(c("2022-02-01", "2022-02-02")))
  expect_no_warning(dt[, updated_at := NA])
})
