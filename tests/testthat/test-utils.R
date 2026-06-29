test_that("xml_updated extracts the feed timestamp", {
  doc = xml2::read_xml(
    '<feed xmlns="http://www.w3.org/2005/Atom">
      <updated>2026-06-14T06:32:11Z</updated>
      <entry><updated>2020-01-01T00:00:00Z</updated></entry>
    </feed>'
  )
  expect_identical(
    xml_updated(doc),
    as.POSIXct("2026-06-14T06:32:11Z", format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
  )
})
