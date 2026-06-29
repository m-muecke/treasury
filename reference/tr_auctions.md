# US Treasury marketable securities and auction results

Retrieve data on US Treasury marketable securities from the
TreasuryDirect API. `tr_auctions()` returns auction results for
securities that have already been auctioned, `tr_announcements()`
returns securities whose auctions have been announced but not yet held,
and `tr_upcoming()` returns the upcoming auction schedule.

## Usage

``` r
tr_auctions(type = NULL, days = NULL)

tr_announcements(type = NULL, days = NULL)

tr_upcoming(type = NULL)
```

## Source

<https://www.treasurydirect.gov/webapis/webapisecurities/>

## Arguments

- type:

  (`NULL` \| `character(1)`)  
  Security type to filter by, one of `"Bill"`, `"Note"`, `"Bond"`,
  `"CMB"`, `"TIPS"`, or `"FRN"`. If `NULL`, all types are returned.
  Default `NULL`.

- days:

  (`NULL` \| `integer(1)`)  
  Restrict the results to securities from the last `days` days. If
  `NULL`, the most recent securities are returned. Default `NULL`.

## Value

A
[`data.table::data.table()`](https://rdrr.io/pkg/data.table/man/data.table.html)
containing the securities or `NULL` when no entries were found.

## Details

These functions return every field provided by the API (around 120
columns), with names converted to snake case, date columns parsed to
[Date](https://rdrr.io/r/base/Dates.html) and numeric columns parsed to
numeric. Fields that do not apply to a given security type are returned
as `NA`. The API returns at most the 250 most recent matching
securities.

## Examples

``` r
# \donttest{
# auction results for the most recently auctioned notes
tr_auctions("Note")
#>          cusip issue_date security_type   security_term maturity_date
#>         <char>     <Date>        <char>          <char>        <Date>
#>   1: 91282CQW4 2026-06-30          Note          7-Year    2033-06-30
#>   2: 91282CQX2 2026-06-30          Note          5-Year    2031-06-30
#>   3: 91282CQY0 2026-06-30          Note          2-Year    2028-06-30
#>   4: 91282CQQ7 2026-06-15          Note 9-Year 11-Month    2036-05-15
#>   5: 91282CQV6 2026-06-15          Note          3-Year    2029-06-15
#>  ---                                                                 
#> 246: 91282CCB5 2021-05-17          Note         10-Year    2031-05-15
#> 247: 91282CBZ3 2021-04-30          Note          7-Year    2028-04-30
#> 248: 91282CBL4 2021-04-15          Note 9-Year 10-Month    2031-02-15
#> 249: 91282CBS9 2021-03-31          Note          7-Year    2028-03-31
#> 250: 91282CBL4 2021-03-15          Note 9-Year 11-Month    2031-02-15
#>      interest_rate ref_cpi_on_issue_date ref_cpi_on_dated_date
#>              <num>                 <num>                 <num>
#>   1:         4.250                    NA                    NA
#>   2:         4.125                    NA                    NA
#>   3:         4.125                    NA                    NA
#>   4:         4.375                    NA                    NA
#>   5:         4.125                    NA                    NA
#>  ---                                                          
#> 246:         1.625                    NA                    NA
#> 247:         1.250                    NA                    NA
#> 248:         1.125                    NA                    NA
#> 249:         1.250                    NA                    NA
#> 250:         1.125                    NA                    NA
#>      announcement_date auction_date auction_date_year dated_date
#>                 <Date>       <Date>             <num>     <Date>
#>   1:        2026-06-18   2026-06-25              2026 2026-06-30
#>   2:        2026-06-18   2026-06-24              2026 2026-06-30
#>   3:        2026-06-18   2026-06-23              2026 2026-06-30
#>   4:        2026-06-04   2026-06-10              2026 2026-05-15
#>   5:        2026-06-04   2026-06-09              2026 2026-06-15
#>  ---                                                            
#> 246:        2021-05-05   2021-05-12              2021 2021-05-15
#> 247:        2021-04-22   2021-04-27              2021 2021-04-30
#> 248:        2021-04-08   2021-04-12              2021 2021-02-15
#> 249:        2021-03-18   2021-03-25              2021 2021-03-31
#> 250:        2021-03-04   2021-03-10              2021 2021-02-15
#>      accrued_interest_per1000 accrued_interest_per100
#>                         <num>                   <num>
#>   1:                       NA                      NA
#>   2:                       NA                      NA
#>   3:                       NA                      NA
#>   4:                  3.68546                      NA
#>   5:                       NA                      NA
#>  ---                                                 
#> 246:                  0.08832                      NA
#> 247:                       NA                      NA
#> 248:                  1.83356                      NA
#> 249:                       NA                      NA
#> 250:                  0.87017                      NA
#>      adjusted_accrued_interest_per1000 adjusted_price allocation_percentage
#>                                  <num>          <num>                 <num>
#>   1:                                NA             NA                 36.22
#>   2:                                NA             NA                 86.81
#>   3:                                NA             NA                  5.66
#>   4:                                NA             NA                 71.34
#>   5:                                NA             NA                 42.92
#>  ---                                                                       
#> 246:                                NA             NA                 32.49
#> 247:                                NA             NA                 88.71
#> 248:                                NA             NA                 19.14
#> 249:                                NA             NA                 40.90
#> 250:                                NA             NA                 27.17
#>      allocation_percentage_decimals announced_cusip auction_format
#>                               <num>          <char>         <char>
#>   1:                              2            <NA>   Single-Price
#>   2:                              2            <NA>   Single-Price
#>   3:                              2            <NA>   Single-Price
#>   4:                              2            <NA>   Single-Price
#>   5:                              2            <NA>   Single-Price
#>  ---                                                              
#> 246:                              2            <NA>   Single-Price
#> 247:                              2            <NA>   Single-Price
#> 248:                              2            <NA>   Single-Price
#> 249:                              2            <NA>   Single-Price
#> 250:                              2            <NA>   Single-Price
#>      average_median_discount_rate average_median_investment_rate
#>                             <num>                          <num>
#>   1:                           NA                             NA
#>   2:                           NA                             NA
#>   3:                           NA                             NA
#>   4:                           NA                             NA
#>   5:                           NA                             NA
#>  ---                                                            
#> 246:                           NA                             NA
#> 247:                           NA                             NA
#> 248:                           NA                             NA
#> 249:                           NA                             NA
#> 250:                           NA                             NA
#>      average_median_price average_median_discount_margin average_median_yield
#>                     <num>                          <num>                <num>
#>   1:                   NA                             NA                4.200
#>   2:                   NA                             NA                4.135
#>   3:                   NA                             NA                4.138
#>   4:                   NA                             NA                4.480
#>   5:                   NA                             NA                4.147
#>  ---                                                                         
#> 246:                   NA                             NA                1.629
#> 247:                   NA                             NA                1.249
#> 248:                   NA                             NA                1.620
#> 249:                   NA                             NA                1.225
#> 250:                   NA                             NA                1.467
#>      back_dated back_dated_date bid_to_cover_ratio call_date callable
#>          <char>          <Date>              <num>     <num>   <char>
#>   1:         No            <NA>               2.50        NA       No
#>   2:         No            <NA>               2.35        NA       No
#>   3:         No            <NA>               2.64        NA       No
#>   4:        Yes      2026-05-15               2.57        NA       No
#>   5:         No            <NA>               2.64        NA       No
#>  ---                                                                 
#> 246:        Yes      2021-05-15               2.45        NA       No
#> 247:         No            <NA>               2.31        NA       No
#> 248:        Yes      2021-02-15               2.36        NA       No
#> 249:         No            <NA>               2.23        NA       No
#> 250:        Yes      2021-02-15               2.38        NA       No
#>      called_date cash_management_bill_cmb closing_time_competitive
#>            <num>                   <char>                   <char>
#>   1:          NA                       No                 01:00 PM
#>   2:          NA                       No                 01:00 PM
#>   3:          NA                       No                 01:00 PM
#>   4:          NA                       No                 01:00 PM
#>   5:          NA                       No                 01:00 PM
#>  ---                                                              
#> 246:          NA                       No                 01:00 PM
#> 247:          NA                       No                 01:00 PM
#> 248:          NA                       No                 01:00 PM
#> 249:          NA                       No                 01:00 PM
#> 250:          NA                       No                 01:00 PM
#>      closing_time_noncompetitive competitive_accepted competitive_bid_decimals
#>                           <char>                <num>                    <num>
#>   1:                    12:00 PM          43927162000                        3
#>   2:                    12:00 PM          69854999700                        3
#>   3:                    12:00 PM          68035905000                        3
#>   4:                    12:00 PM          38914680400                        3
#>   5:                    12:00 PM          57733403100                        3
#>  ---                                                                          
#> 246:                    12:00 PM          40960994000                        3
#> 247:                    12:00 PM          61976072000                        3
#> 248:                    12:00 PM          37986519600                        3
#> 249:                    12:00 PM          61938581000                        3
#> 250:                    12:00 PM          37966272200                        3
#>      competitive_tendered competitive_tenders_accepted corpus_cusip
#>                     <num>                       <char>       <char>
#>   1:         109847684000                          Yes    912821US2
#>   2:         164427300200                          Yes    912821UR4
#>   3:         181436815000                          Yes    912821UQ6
#>   4:          99959349000                          Yes    912821UK9
#>   5:         153124410000                          Yes    912821UP8
#>  ---                                                               
#> 246:         100582365000                          Yes    912821MH5
#> 247:         143424297000                          Yes    912821MF9
#> 248:          89558462000                          Yes    912821GD1
#> 249:         138411341000                          Yes    912821MA0
#> 250:          90545182000                          Yes    912821GD1
#>      cpi_base_reference_period currently_outstanding direct_bidder_accepted
#>                          <num>                 <num>                  <num>
#>   1:                        NA                    NA            13044711000
#>   2:                        NA                    NA            17820350000
#>   3:                        NA                    NA            23343000000
#>   4:                        NA            5.1972e+10             4796000000
#>   5:                        NA                    NA            12131465100
#>  ---                                                                       
#> 246:                        NA                    NA             7015000000
#> 247:                        NA                    NA            12765200000
#> 248:                        NA            9.6229e+10             6160000000
#> 249:                        NA                    NA            11150900000
#> 250:                        NA            5.5874e+10             6748585000
#>      direct_bidder_tendered
#>                       <num>
#>   1:            16829900000
#>   2:            21416600000
#>   3:            28404000000
#>   4:             7916500000
#>   5:            16178000000
#>  ---                       
#> 246:            11835000000
#> 247:            18240200000
#> 248:            10110000000
#> 249:            16300900000
#> 250:             9865000000
#>      estimated_amount_of_publicly_held_maturing_securities_by_type
#>                                                              <num>
#>   1:                                                   1.42819e+11
#>   2:                                                   1.42819e+11
#>   3:                                                   1.42819e+11
#>   4:                                                   3.99990e+10
#>   5:                                                   3.99990e+10
#>  ---                                                              
#> 246:                                                   4.76930e+10
#> 247:                                                   1.22375e+11
#> 248:                                                   6.13660e+10
#> 249:                                                   7.15940e+10
#> 250:                                                   2.05640e+10
#>      fima_included fima_noncompetitive_accepted fima_noncompetitive_tendered
#>             <char>                        <num>                        <num>
#>   1:           Yes                     0.00e+00                     0.00e+00
#>   2:           Yes                     4.90e+06                     4.90e+06
#>   3:           Yes                     2.05e+08                     2.05e+08
#>   4:           Yes                     0.00e+00                     0.00e+00
#>   5:           Yes                     5.00e+06                     5.00e+06
#>  ---                                                                        
#> 246:           Yes                     0.00e+00                     0.00e+00
#> 247:           Yes                     0.00e+00                     0.00e+00
#> 248:           Yes                     0.00e+00                     0.00e+00
#> 249:           Yes                     0.00e+00                     0.00e+00
#> 250:           Yes                     0.00e+00                     0.00e+00
#>      first_interest_period first_interest_payment_date floating_rate
#>                     <char>                      <Date>        <char>
#>   1:                Normal                  2026-12-31            No
#>   2:                Normal                  2026-12-31            No
#>   3:                Normal                  2026-12-31            No
#>   4:                Normal                  2026-11-15            No
#>   5:                Normal                  2026-12-15            No
#>  ---                                                                
#> 246:                Normal                  2021-11-15            No
#> 247:                Normal                  2021-10-31            No
#> 248:                Normal                  2021-08-15            No
#> 249:                Normal                  2021-09-30            No
#> 250:                Normal                  2021-08-15            No
#>      frn_index_determination_date frn_index_determination_rate
#>                             <num>                        <num>
#>   1:                           NA                           NA
#>   2:                           NA                           NA
#>   3:                           NA                           NA
#>   4:                           NA                           NA
#>   5:                           NA                           NA
#>  ---                                                          
#> 246:                           NA                           NA
#> 247:                           NA                           NA
#> 248:                           NA                           NA
#> 249:                           NA                           NA
#> 250:                           NA                           NA
#>      high_discount_rate high_investment_rate high_price high_discount_margin
#>                   <num>                <num>      <num>                <num>
#>   1:                 NA                   NA   99.94002                   NA
#>   2:                 NA                   NA   99.66491                   NA
#>   3:                 NA                   NA   99.87843                   NA
#>   4:                 NA                   NA   98.70309                   NA
#>   5:                 NA                   NA   99.81296                   NA
#>  ---                                                                        
#> 246:                 NA                   NA   99.45929                   NA
#> 247:                 NA                   NA   99.62655                   NA
#> 248:                 NA                   NA   94.98581                   NA
#> 249:                 NA                   NA   99.66649                   NA
#> 250:                 NA                   NA   96.34694                   NA
#>      high_yield index_ratio_on_issue_date indirect_bidder_accepted
#>           <num>                     <num>                    <num>
#>   1:      4.260                        NA              25281614000
#>   2:      4.200                        NA              43028302200
#>   3:      4.189                        NA              37726415000
#>   4:      4.538                        NA              30435505400
#>   5:      4.192                        NA              36781410000
#>  ---                                                              
#> 246:      1.684                        NA              25961765000
#> 247:      1.306                        NA              35372097000
#> 248:      1.680                        NA              22640766600
#> 249:      1.300                        NA              35471441000
#> 250:      1.523                        NA              21568158700
#>      indirect_bidder_tendered interest_payment_frequency low_discount_rate
#>                         <num>                     <char>             <num>
#>   1:              32190284000                Semi-Annual                NA
#>   2:              51983700200                Semi-Annual                NA
#>   3:              54184815000                Semi-Annual                NA
#>   4:              37206849000                Semi-Annual                NA
#>   5:              48981410000                Semi-Annual                NA
#>  ---                                                                      
#> 246:              31997365000                Semi-Annual                NA
#> 247:              41247097000                Semi-Annual                NA
#> 248:              26229462000                Semi-Annual                NA
#> 249:              38621441000                Semi-Annual                NA
#> 250:              27229182000                Semi-Annual                NA
#>      low_investment_rate low_price low_discount_margin low_yield maturing_date
#>                    <num>     <num>               <num>     <num>        <Date>
#>   1:                  NA        NA                  NA     4.140    2026-06-30
#>   2:                  NA        NA                  NA     4.085    2026-06-30
#>   3:                  NA        NA                  NA     4.080    2026-06-30
#>   4:                  NA        NA                  NA     4.400    2026-06-15
#>   5:                  NA        NA                  NA     2.880    2026-06-15
#>  ---                                                                          
#> 246:                  NA        NA                  NA     0.880    2021-05-15
#> 247:                  NA        NA                  NA     0.880    2021-04-30
#> 248:                  NA        NA                  NA     0.080    2021-04-15
#> 249:                  NA        NA                  NA     0.080    2021-03-31
#> 250:                  NA        NA                  NA     0.880    2021-03-15
#>      maximum_competitive_award maximum_noncompetitive_award maximum_single_bid
#>                          <num>                        <num>              <num>
#>   1:                 1.540e+10                        1e+07          1.540e+10
#>   2:                 2.450e+10                        1e+07          2.450e+10
#>   3:                 2.415e+10                        1e+07          2.415e+10
#>   4:                 1.365e+10                        1e+07          1.365e+10
#>   5:                 2.030e+10                        1e+07          2.030e+10
#>  ---                                                                          
#> 246:                 1.435e+10                        5e+06          1.435e+10
#> 247:                 2.170e+10                        5e+06          2.170e+10
#> 248:                 1.330e+10                        5e+06          1.330e+10
#> 249:                 2.170e+10                        5e+06          2.170e+10
#> 250:                 1.330e+10                        5e+06          1.330e+10
#>      minimum_bid_amount minimum_strip_amount minimum_to_issue multiples_to_bid
#>                   <num>                <num>            <num>            <num>
#>   1:                100                  100              100              100
#>   2:                100                  100              100              100
#>   3:                100                  100              100              100
#>   4:                100                  100              100              100
#>   5:                100                  100              100              100
#>  ---                                                                          
#> 246:                100                  100              100              100
#> 247:                100                  100              100              100
#> 248:                100                  100              100              100
#> 249:                100                  100              100              100
#> 250:                100                  100              100              100
#>      multiples_to_issue nlp_exclusion_amount nlp_reporting_threshold
#>                   <num>                <num>                   <num>
#>   1:                100             0.00e+00               1.540e+10
#>   2:                100             0.00e+00               2.450e+10
#>   3:                100             0.00e+00               2.415e+10
#>   4:                100             1.47e+10               1.365e+10
#>   5:                100             0.00e+00               2.030e+10
#>  ---                                                                
#> 246:                100             0.00e+00               1.435e+10
#> 247:                100             0.00e+00               2.170e+10
#> 248:                100             2.77e+10               1.330e+10
#> 249:                100             0.00e+00               2.170e+10
#> 250:                100             1.44e+10               1.330e+10
#>      noncompetitive_accepted noncompetitive_tenders_accepted offering_amount
#>                        <num>                          <char>           <num>
#>   1:                72861700                             Yes         4.4e+10
#>   2:               140118100                             Yes         7.0e+10
#>   3:               759106400                             Yes         6.9e+10
#>   4:                85320600                             Yes         3.9e+10
#>   5:               261616100                             Yes         5.8e+10
#>  ---                                                                        
#> 246:                39006500                             Yes         4.1e+10
#> 247:                23939100                             Yes         6.2e+10
#> 248:                13500000                             Yes         3.8e+10
#> 249:                61445700                             Yes         6.2e+10
#> 250:                33739300                             Yes         3.8e+10
#>      original_cusip original_dated_date original_issue_date
#>              <char>              <Date>              <Date>
#>   1:           <NA>                <NA>                <NA>
#>   2:           <NA>                <NA>                <NA>
#>   3:           <NA>                <NA>                <NA>
#>   4:           <NA>          2026-05-15          2026-05-15
#>   5:           <NA>                <NA>                <NA>
#>  ---                                                       
#> 246:           <NA>                <NA>                <NA>
#> 247:           <NA>                <NA>                <NA>
#> 248:           <NA>          2021-02-15          2021-02-16
#> 249:           <NA>                <NA>                <NA>
#> 250:           <NA>          2021-02-15          2021-02-16
#>      original_security_term pdf_filename_announcement
#>                      <char>                    <char>
#>   1:                 7-Year          A_20260618_6.pdf
#>   2:                 5-Year          A_20260618_2.pdf
#>   3:                 2-Year          A_20260618_5.pdf
#>   4:                10-Year          A_20260604_2.pdf
#>   5:                 3-Year          A_20260604_4.pdf
#>  ---                                                 
#> 246:                10-Year          A_20210505_3.pdf
#> 247:                 7-Year          A_20210422_4.pdf
#> 248:                10-Year          A_20210408_6.pdf
#> 249:                 7-Year          A_20210318_4.pdf
#> 250:                10-Year          A_20210304_6.pdf
#>      pdf_filename_competitive_results pdf_filename_noncompetitive_results
#>                                <char>                              <char>
#>   1:                 R_20260625_3.pdf                  NCR_20260625_3.pdf
#>   2:                 R_20260624_3.pdf                  NCR_20260624_3.pdf
#>   3:                 R_20260623_2.pdf                  NCR_20260623_2.pdf
#>   4:                 R_20260610_2.pdf                  NCR_20260610_2.pdf
#>   5:                 R_20260609_3.pdf                  NCR_20260609_3.pdf
#>  ---                                                                     
#> 246:                 R_20210512_2.pdf                  NCR_20210512_2.pdf
#> 247:                 R_20210427_3.pdf                  NCR_20210427_3.pdf
#> 248:                 R_20210412_4.pdf                  NCR_20210412_4.pdf
#> 249:                 R_20210325_3.pdf                  NCR_20210325_3.pdf
#> 250:                 R_20210310_2.pdf                  NCR_20210310_2.pdf
#>      pdf_filename_special_announcement price_per100 primary_dealer_accepted
#>                                 <char>        <num>                   <num>
#>   1:                              <NA>     99.94002              5600837000
#>   2:                SPL_20260618_2.pdf     99.66491              9006347500
#>   3:                SPL_20260618_1.pdf     99.87843              6966490000
#>   4:                              <NA>     98.70309              3683175000
#>   5:                              <NA>     99.81296              8820528000
#>  ---                                                                       
#> 246:                              <NA>     99.45929              7984229000
#> 247:                              <NA>     99.62655             13838775000
#> 248:                SPL_20210408_1.pdf     94.98581              9185753000
#> 249:                              <NA>     99.66649             15316240000
#> 250:                              <NA>     96.34694              9649528500
#>      primary_dealer_tendered reopening security_term_day_month
#>                        <num>    <char>                  <char>
#>   1:             60827500000        No                 0-Month
#>   2:             91027000000        No                 0-Month
#>   3:             98848000000        No                 0-Month
#>   4:             54836000000       Yes                11-Month
#>   5:             87965000000        No                 0-Month
#>  ---                                                          
#> 246:             56750000000        No                 0-Month
#> 247:             83937000000        No                 0-Month
#> 248:             53219000000       Yes                10-Month
#> 249:             83489000000        No                 0-Month
#> 250:             53451000000       Yes                11-Month
#>      security_term_week_year  series soma_accepted soma_holdings soma_included
#>                       <char>  <char>         <num>         <num>        <char>
#>   1:                  7-Year  M-2033    6586413700    3.0986e+10            No
#>   2:                  5-Year AA-2031   10478385600    3.0986e+10            No
#>   3:                  2-Year BD-2028   10328694400    3.0986e+10            No
#>   4:                  9-Year  C-2036             0    0.0000e+00            No
#>   5:                  3-Year AP-2029             0    0.0000e+00            No
#>  ---                                                                          
#> 246:                 10-Year  C-2031   21750697500    6.6844e+10            No
#> 247:                  7-Year  K-2028   11840294700    4.8316e+10            No
#> 248:                  9-Year  B-2031    5833637100    1.8422e+10            No
#> 249:                  7-Year  J-2028   11133409500    3.9506e+10            No
#> 250:                  9-Year  B-2031    2355050000    7.4370e+09            No
#>      soma_tendered spread standard_interest_payment_per1000 strippable    term
#>              <num>  <num>                             <num>     <char>  <char>
#>   1:    6586413700     NA                            21.250        Yes  7-Year
#>   2:   10478385600     NA                            20.625        Yes  5-Year
#>   3:   10328694400     NA                            20.625        Yes  2-Year
#>   4:             0     NA                            21.875        Yes 10-Year
#>   5:             0     NA                            20.625        Yes  3-Year
#>  ---                                                                          
#> 246:   21750697500     NA                             8.125        Yes 10-Year
#> 247:   11840294700     NA                             6.250        Yes  7-Year
#> 248:    5833637100     NA                             5.625        Yes 10-Year
#> 249:   11133409500     NA                             6.250        Yes  7-Year
#> 250:    2355050000     NA                             5.625        Yes 10-Year
#>      tiin_conversion_factor_per1000   tips total_accepted total_tendered
#>                               <num> <char>          <num>          <num>
#>   1:                             NA     No    50586437400   116506959400
#>   2:                             NA     No    80478403400   175050703900
#>   3:                             NA     No    79328705800   192729615800
#>   4:                             NA     No    39000001000   100044669600
#>   5:                             NA     No    58000019200   153391026100
#>  ---                                                                    
#> 246:                             NA     No    62750698000   122372069000
#> 247:                             NA     No    73840305800   155288530800
#> 248:                             NA     No    43833656700    95405599100
#> 249:                             NA     No    73133436200   149606196200
#> 250:                             NA     No    40355061500    92933971300
#>      treasury_retail_accepted treasury_retail_tenders_accepted   type
#>                         <num>                           <char> <char>
#>   1:                 18721700                              Yes   Note
#>   2:                 48019100                              Yes   Note
#>   3:                312015400                              Yes   Note
#>   4:                 38560800                              Yes   Note
#>   5:                 90506100                              Yes   Note
#>  ---                                                                 
#> 246:                 21923500                              Yes   Note
#> 247:                 17442100                              Yes   Note
#> 248:                  6938000                              Yes   Note
#> 249:                 49197700                              Yes   Note
#> 250:                 10734300                              Yes   Note
#>      unadjusted_accrued_interest_per1000 unadjusted_price   updated_timestamp
#>                                    <num>            <num>              <char>
#>   1:                                  NA               NA 2026-06-25T13:04:09
#>   2:                                  NA               NA 2026-06-24T13:04:16
#>   3:                                  NA               NA 2026-06-23T13:04:15
#>   4:                                  NA               NA 2026-06-10T13:03:58
#>   5:                                  NA               NA 2026-06-09T13:04:05
#>  ---                                                                         
#> 246:                                  NA               NA 2021-05-12T13:02:50
#> 247:                                  NA               NA 2021-04-27T13:03:33
#> 248:                                  NA               NA 2021-04-12T13:04:01
#> 249:                                  NA               NA 2021-03-25T13:03:26
#> 250:                                  NA               NA 2021-03-10T13:03:21
#>      xml_filename_announcement xml_filename_competitive_results
#>                         <char>                           <char>
#>   1:          A_20260618_6.xml                 R_20260625_3.xml
#>   2:          A_20260618_2.xml                 R_20260624_3.xml
#>   3:          A_20260618_5.xml                 R_20260623_2.xml
#>   4:          A_20260604_2.xml                 R_20260610_2.xml
#>   5:          A_20260604_4.xml                 R_20260609_3.xml
#>  ---                                                           
#> 246:          A_20210505_3.xml                 R_20210512_2.xml
#> 247:          A_20210422_4.xml                 R_20210427_3.xml
#> 248:          A_20210408_6.xml                 R_20210412_4.xml
#> 249:          A_20210318_4.xml                 R_20210325_3.xml
#> 250:          A_20210304_6.xml                 R_20210310_2.xml
#>      xml_filename_special_announcement tint_cusip1 tint_cusip2
#>                                  <num>      <char>       <num>
#>   1:                                NA   912834K80          NA
#>   2:                                NA        <NA>          NA
#>   3:                                NA        <NA>          NA
#>   4:                                NA        <NA>          NA
#>   5:                                NA   912834ZZ4          NA
#>  ---                                                          
#> 246:                                NA        <NA>          NA
#> 247:                                NA        <NA>          NA
#> 248:                                NA        <NA>          NA
#> 249:                                NA        <NA>          NA
#> 250:                                NA        <NA>          NA
#>      tint_cusip1_due_date tint_cusip2_due_date
#>                    <Date>                <num>
#>   1:           2033-06-30                   NA
#>   2:                 <NA>                   NA
#>   3:                 <NA>                   NA
#>   4:                 <NA>                   NA
#>   5:           2029-06-15                   NA
#>  ---                                          
#> 246:                 <NA>                   NA
#> 247:                 <NA>                   NA
#> 248:                 <NA>                   NA
#> 249:                 <NA>                   NA
#> 250:                 <NA>                   NA
# announced bill auctions
tr_announcements("Bill")
#>          cusip issue_date security_type security_term maturity_date
#>         <char>     <Date>        <char>        <char>        <Date>
#>   1: 912797TW7 2026-07-02          Bill        6-Week    2026-08-13
#>   2: 912797SA6 2026-07-02          Bill       13-Week    2026-10-01
#>   3: 912797VJ3 2026-07-02          Bill       26-Week    2026-12-31
#>   4: 912797UR6 2026-06-30          Bill        4-Week    2026-07-28
#>   5: 912797UV7 2026-06-30          Bill        8-Week    2026-08-25
#>  ---                                                               
#> 246: 912797RA7 2025-10-02          Bill       13-Week    2026-01-02
#> 247: 912797SD0 2025-10-02          Bill       26-Week    2026-04-02
#> 248: 912797RE9 2025-09-30          Bill        4-Week    2025-10-28
#> 249: 912797RQ2 2025-09-30          Bill        8-Week    2025-11-25
#> 250: 912797SH1 2025-09-30          Bill       17-Week    2026-01-27
#>      interest_rate ref_cpi_on_issue_date ref_cpi_on_dated_date
#>              <num>                 <num>                 <num>
#>   1:            NA                    NA                    NA
#>   2:            NA                    NA                    NA
#>   3:            NA                    NA                    NA
#>   4:            NA                    NA                    NA
#>   5:            NA                    NA                    NA
#>  ---                                                          
#> 246:            NA                    NA                    NA
#> 247:            NA                    NA                    NA
#> 248:            NA                    NA                    NA
#> 249:            NA                    NA                    NA
#> 250:            NA                    NA                    NA
#>      announcement_date auction_date auction_date_year dated_date
#>                 <Date>       <Date>             <num>      <num>
#>   1:        2026-06-25   2026-06-30              2026         NA
#>   2:        2026-06-25   2026-06-29              2026         NA
#>   3:        2026-06-25   2026-06-29              2026         NA
#>   4:        2026-06-23   2026-06-25              2026         NA
#>   5:        2026-06-23   2026-06-25              2026         NA
#>  ---                                                            
#> 246:        2025-09-25   2025-09-29              2025         NA
#> 247:        2025-09-25   2025-09-29              2025         NA
#> 248:        2025-09-23   2025-09-25              2025         NA
#> 249:        2025-09-23   2025-09-25              2025         NA
#> 250:        2025-09-23   2025-09-24              2025         NA
#>      accrued_interest_per1000 accrued_interest_per100
#>                         <num>                   <num>
#>   1:                       NA                      NA
#>   2:                       NA                      NA
#>   3:                       NA                      NA
#>   4:                       NA                      NA
#>   5:                       NA                      NA
#>  ---                                                 
#> 246:                       NA                      NA
#> 247:                       NA                      NA
#> 248:                       NA                      NA
#> 249:                       NA                      NA
#> 250:                       NA                      NA
#>      adjusted_accrued_interest_per1000 adjusted_price allocation_percentage
#>                                  <num>          <num>                 <num>
#>   1:                                NA             NA                    NA
#>   2:                                NA             NA                 85.81
#>   3:                                NA             NA                 96.12
#>   4:                                NA             NA                 24.04
#>   5:                                NA             NA                 70.50
#>  ---                                                                       
#> 246:                                NA             NA                 70.07
#> 247:                                NA             NA                 61.66
#> 248:                                NA             NA                 63.91
#> 249:                                NA             NA                  8.52
#> 250:                                NA             NA                 60.09
#>      allocation_percentage_decimals announced_cusip auction_format
#>                               <num>           <num>         <char>
#>   1:                              2              NA   Single-Price
#>   2:                              2              NA   Single-Price
#>   3:                              2              NA   Single-Price
#>   4:                              2              NA   Single-Price
#>   5:                              2              NA   Single-Price
#>  ---                                                              
#> 246:                              2              NA   Single-Price
#> 247:                              2              NA   Single-Price
#> 248:                              2              NA   Single-Price
#> 249:                              2              NA   Single-Price
#> 250:                              2              NA   Single-Price
#>      average_median_discount_rate average_median_investment_rate
#>                             <num>                          <num>
#>   1:                           NA                             NA
#>   2:                        3.690                             NA
#>   3:                        3.810                             NA
#>   4:                        3.540                             NA
#>   5:                        3.650                             NA
#>  ---                                                            
#> 246:                        3.830                             NA
#> 247:                        3.680                             NA
#> 248:                        4.025                             NA
#> 249:                        3.950                             NA
#> 250:                        3.785                             NA
#>      average_median_price average_median_discount_margin average_median_yield
#>                     <num>                          <num>                <num>
#>   1:                   NA                             NA                   NA
#>   2:                   NA                             NA                   NA
#>   3:                   NA                             NA                   NA
#>   4:                   NA                             NA                   NA
#>   5:                   NA                             NA                   NA
#>  ---                                                                         
#> 246:                   NA                             NA                   NA
#> 247:                   NA                             NA                   NA
#> 248:                   NA                             NA                   NA
#> 249:                   NA                             NA                   NA
#> 250:                   NA                             NA                   NA
#>      back_dated back_dated_date bid_to_cover_ratio call_date callable
#>           <num>           <num>              <num>     <num>    <num>
#>   1:         NA              NA                 NA        NA       NA
#>   2:         NA              NA               2.32        NA       NA
#>   3:         NA              NA               2.58        NA       NA
#>   4:         NA              NA               2.74        NA       NA
#>   5:         NA              NA               2.79        NA       NA
#>  ---                                                                 
#> 246:         NA              NA               2.74        NA       NA
#> 247:         NA              NA               3.00        NA       NA
#> 248:         NA              NA               2.61        NA       NA
#> 249:         NA              NA               2.65        NA       NA
#> 250:         NA              NA               2.93        NA       NA
#>      called_date cash_management_bill_cmb closing_time_competitive
#>            <num>                   <char>                   <char>
#>   1:          NA                       No                 11:30 AM
#>   2:          NA                       No                 11:30 AM
#>   3:          NA                       No                 11:30 AM
#>   4:          NA                       No                 11:30 AM
#>   5:          NA                       No                 11:30 AM
#>  ---                                                              
#> 246:          NA                       No                 11:30 AM
#> 247:          NA                       No                 11:30 AM
#> 248:          NA                       No                 11:30 AM
#> 249:          NA                       No                 11:30 AM
#> 250:          NA                       No                 11:30 AM
#>      closing_time_noncompetitive competitive_accepted competitive_bid_decimals
#>                           <char>                <num>                    <num>
#>   1:                    11:00 AM                   NA                        3
#>   2:                    11:00 AM          88575550300                        3
#>   3:                    11:00 AM          76541668000                        3
#>   4:                    11:00 AM          62288250000                        3
#>   5:                    11:00 AM          72776157700                        3
#>  ---                                                                          
#> 246:                    11:00 AM          80222868000                        3
#> 247:                    11:00 AM          71527610000                        3
#> 248:                    11:00 AM          93534061600                        3
#> 249:                    11:00 AM          83690451000                        3
#> 250:                    11:00 AM          64531116500                        3
#>      competitive_tendered competitive_tenders_accepted corpus_cusip
#>                     <num>                       <char>        <num>
#>   1:                   NA                          Yes           NA
#>   2:         210178680300                          Yes           NA
#>   3:         201230922000                          Yes           NA
#>   4:         184355950000                          Yes           NA
#>   5:         206795162700                          Yes           NA
#>  ---                                                               
#> 246:         223183828000                          Yes           NA
#> 247:         217709186000                          Yes           NA
#> 248:         254260709600                          Yes           NA
#> 249:         224267591000                          Yes           NA
#> 250:         189891075000                          Yes           NA
#>      cpi_base_reference_period currently_outstanding direct_bidder_accepted
#>                          <num>                 <num>                  <num>
#>   1:                        NA           1.76066e+11                     NA
#>   2:                        NA           1.34238e+11             6285000000
#>   3:                        NA                    NA             5499030000
#>   4:                        NA           1.52867e+11             2262020000
#>   5:                        NA           6.99130e+10             1910250000
#>  ---                                                                       
#> 246:                        NA           7.57720e+10             5625700000
#> 247:                        NA                    NA             5973320000
#> 248:                        NA           1.48486e+11             5403910000
#> 249:                        NA           6.51850e+10             5077800000
#> 250:                        NA                    NA             3935225000
#>      direct_bidder_tendered
#>                       <num>
#>   1:                     NA
#>   2:             8.7850e+09
#>   3:             8.5000e+09
#>   4:             5.2500e+09
#>   5:             5.7750e+09
#>  ---                       
#> 246:             1.1275e+10
#> 247:             1.1900e+10
#> 248:             1.2040e+10
#> 249:             1.2100e+10
#> 250:             9.3250e+09
#>      estimated_amount_of_publicly_held_maturing_securities_by_type
#>                                                              <num>
#>   1:                                                   2.49478e+11
#>   2:                                                   2.49478e+11
#>   3:                                                   2.49478e+11
#>   4:                                                   2.18878e+11
#>   5:                                                   2.18878e+11
#>  ---                                                              
#> 246:                                                   2.79973e+11
#> 247:                                                   2.79973e+11
#> 248:                                                   2.45020e+11
#> 249:                                                   2.45020e+11
#> 250:                                                   2.45020e+11
#>      fima_included fima_noncompetitive_accepted fima_noncompetitive_tendered
#>             <char>                        <num>                        <num>
#>   1:           Yes                           NA                           NA
#>   2:           Yes                      1.8e+09                      1.8e+09
#>   3:           Yes                      7.0e+08                      7.0e+08
#>   4:           Yes                      2.0e+09                      2.0e+09
#>   5:           Yes                      1.0e+09                      1.0e+09
#>  ---                                                                        
#> 246:           Yes                      0.0e+00                      0.0e+00
#> 247:           Yes                      1.0e+08                      1.0e+08
#> 248:           Yes                      0.0e+00                      0.0e+00
#> 249:           Yes                      0.0e+00                      0.0e+00
#> 250:           Yes                      0.0e+00                      0.0e+00
#>      first_interest_period first_interest_payment_date floating_rate
#>                      <num>                       <num>        <char>
#>   1:                    NA                          NA            No
#>   2:                    NA                          NA            No
#>   3:                    NA                          NA            No
#>   4:                    NA                          NA            No
#>   5:                    NA                          NA            No
#>  ---                                                                
#> 246:                    NA                          NA            No
#> 247:                    NA                          NA            No
#> 248:                    NA                          NA            No
#> 249:                    NA                          NA            No
#> 250:                    NA                          NA            No
#>      frn_index_determination_date frn_index_determination_rate
#>                             <num>                        <num>
#>   1:                           NA                           NA
#>   2:                           NA                           NA
#>   3:                           NA                           NA
#>   4:                           NA                           NA
#>   5:                           NA                           NA
#>  ---                                                          
#> 246:                           NA                           NA
#> 247:                           NA                           NA
#> 248:                           NA                           NA
#> 249:                           NA                           NA
#> 250:                           NA                           NA
#>      high_discount_rate high_investment_rate high_price high_discount_margin
#>                   <num>                <num>      <num>                <num>
#>   1:                 NA                   NA         NA                   NA
#>   2:              3.740                3.828   99.05461                   NA
#>   3:              3.840                3.970   98.05867                   NA
#>   4:              3.610                3.670   99.71922                   NA
#>   5:              3.660                3.732   99.43067                   NA
#>  ---                                                                        
#> 246:              3.860                3.953   99.01356                   NA
#> 247:              3.715                3.839   98.12186                   NA
#> 248:              4.080                4.150   99.68267                   NA
#> 249:              4.000                4.081   99.37778                   NA
#> 250:              3.805                3.907   98.74224                   NA
#>      high_yield index_ratio_on_issue_date indirect_bidder_accepted
#>           <num>                     <num>                    <num>
#>   1:         NA                        NA                       NA
#>   2:         NA                        NA              36293300300
#>   3:         NA                        NA              43179598000
#>   4:         NA                        NA              40573510000
#>   5:         NA                        NA              50594407700
#>  ---                                                              
#> 246:         NA                        NA              47169473000
#> 247:         NA                        NA              47403245000
#> 248:         NA                        NA              52403266600
#> 249:         NA                        NA              50860751000
#> 250:         NA                        NA              42149024000
#>      indirect_bidder_tendered interest_payment_frequency low_discount_rate
#>                         <num>                     <char>             <num>
#>   1:                       NA                       None                NA
#>   2:              39721680300                       None             3.605
#>   3:              50001922000                       None             3.725
#>   4:              46535950000                       None             3.490
#>   5:              66330162700                       None             3.540
#>  ---                                                                      
#> 246:              53498828000                       None             3.750
#> 247:              63589186000                       None             3.620
#> 248:              59920709600                       None             3.950
#> 249:              56742591000                       None             3.885
#> 250:              52141075000                       None             3.700
#>      low_investment_rate low_price low_discount_margin low_yield maturing_date
#>                    <num>     <num>               <num>     <num>        <Date>
#>   1:                  NA        NA                  NA        NA    2026-07-02
#>   2:                  NA        NA                  NA        NA    2026-07-02
#>   3:                  NA        NA                  NA        NA    2026-07-02
#>   4:                  NA        NA                  NA        NA    2026-06-30
#>   5:                  NA        NA                  NA        NA    2026-06-30
#>  ---                                                                          
#> 246:                  NA        NA                  NA        NA    2025-10-02
#> 247:                  NA        NA                  NA        NA    2025-10-02
#> 248:                  NA        NA                  NA        NA    2025-09-30
#> 249:                  NA        NA                  NA        NA    2025-09-30
#> 250:                  NA        NA                  NA        NA    2025-09-30
#>      maximum_competitive_award maximum_noncompetitive_award maximum_single_bid
#>                          <num>                        <num>              <num>
#>   1:                 2.800e+10                        1e+07          2.800e+10
#>   2:                 3.220e+10                        1e+07          3.220e+10
#>   3:                 2.765e+10                        1e+07          2.765e+10
#>   4:                 2.450e+10                        1e+07          2.450e+10
#>   5:                 2.625e+10                        1e+07          2.625e+10
#>  ---                                                                          
#> 246:                 2.870e+10                        1e+07          2.870e+10
#> 247:                 2.555e+10                        1e+07          2.555e+10
#> 248:                 3.500e+10                        1e+07          3.500e+10
#> 249:                 2.975e+10                        1e+07          2.975e+10
#> 250:                 2.275e+10                        1e+07          2.275e+10
#>      minimum_bid_amount minimum_strip_amount minimum_to_issue multiples_to_bid
#>                   <num>                <num>            <num>            <num>
#>   1:                100                   NA              100              100
#>   2:                100                   NA              100              100
#>   3:                100                   NA              100              100
#>   4:                100                   NA              100              100
#>   5:                100                   NA              100              100
#>  ---                                                                          
#> 246:                100                   NA              100              100
#> 247:                100                   NA              100              100
#> 248:                100                   NA              100              100
#> 249:                100                   NA              100              100
#> 250:                100                   NA              100              100
#>      multiples_to_issue nlp_exclusion_amount nlp_reporting_threshold
#>                   <num>                <num>                   <num>
#>   1:                100             5.78e+10               2.800e+10
#>   2:                100             4.28e+10               3.220e+10
#>   3:                100             0.00e+00               2.765e+10
#>   4:                100             4.96e+10               2.450e+10
#>   5:                100             2.26e+10               2.625e+10
#>  ---                                                                
#> 246:                100             2.49e+10               2.870e+10
#> 247:                100             0.00e+00               2.555e+10
#> 248:                100             5.18e+10               3.500e+10
#> 249:                100             2.28e+10               2.975e+10
#> 250:                100             0.00e+00               2.275e+10
#>      noncompetitive_accepted noncompetitive_tenders_accepted offering_amount
#>                        <num>                          <char>           <num>
#>   1:                      NA                             Yes         8.0e+10
#>   2:              1624548800                             Yes         9.2e+10
#>   3:              1758351800                             Yes         7.9e+10
#>   4:              5712166000                             Yes         7.0e+10
#>   5:              1224092000                             Yes         7.5e+10
#>  ---                                                                        
#> 246:              1777251900                             Yes         8.2e+10
#> 247:              1372405300                             Yes         7.3e+10
#> 248:              6466130800                             Yes         1.0e+11
#> 249:              1309619300                             Yes         8.5e+10
#> 250:               469733000                             Yes         6.5e+10
#>      original_cusip original_dated_date original_issue_date
#>               <num>               <num>              <Date>
#>   1:             NA                  NA          2026-02-12
#>   2:             NA                  NA          2025-10-02
#>   3:             NA                  NA                <NA>
#>   4:             NA                  NA          2026-03-31
#>   5:             NA                  NA          2026-04-28
#>  ---                                                       
#> 246:             NA                  NA          2025-07-03
#> 247:             NA                  NA                <NA>
#> 248:             NA                  NA          2025-07-01
#> 249:             NA                  NA          2025-07-29
#> 250:             NA                  NA                <NA>
#>      original_security_term pdf_filename_announcement
#>                      <char>                    <char>
#>   1:                26-Week          A_20260625_3.pdf
#>   2:                52-Week          A_20260625_2.pdf
#>   3:                26-Week          A_20260625_1.pdf
#>   4:                17-Week          A_20260623_1.pdf
#>   5:                17-Week          A_20260623_3.pdf
#>  ---                                                 
#> 246:                26-Week          A_20250925_4.pdf
#> 247:                26-Week          A_20250925_3.pdf
#> 248:                17-Week          A_20250923_2.pdf
#> 249:                17-Week          A_20250923_3.pdf
#> 250:                17-Week          A_20250923_1.pdf
#>      pdf_filename_competitive_results pdf_filename_noncompetitive_results
#>                                <char>                              <char>
#>   1:                             <NA>                                <NA>
#>   2:                 R_20260629_1.pdf                  NCR_20260629_1.pdf
#>   3:                 R_20260629_2.pdf                  NCR_20260629_2.pdf
#>   4:                 R_20260625_2.pdf                  NCR_20260625_2.pdf
#>   5:                 R_20260625_1.pdf                  NCR_20260625_1.pdf
#>  ---                                                                     
#> 246:                 R_20250929_2.pdf                  NCR_20250929_1.pdf
#> 247:                 R_20250929_1.pdf                  NCR_20250929_2.pdf
#> 248:                 R_20250925_1.pdf                  NCR_20250925_2.pdf
#> 249:                 R_20250925_2.pdf                  NCR_20250925_1.pdf
#> 250:                 R_20250924_2.pdf                  NCR_20250924_2.pdf
#>      pdf_filename_special_announcement price_per100 primary_dealer_accepted
#>                                 <char>        <num>                   <num>
#>   1:                              <NA>           NA                      NA
#>   2:                              <NA>     99.05461             45997250000
#>   3:                              <NA>     98.05867             27863040000
#>   4:                              <NA>     99.71922             19452720000
#>   5:                              <NA>     99.43067             20271500000
#>  ---                                                                       
#> 246:                              <NA>     99.01356             27427695000
#> 247:                              <NA>     98.12186             18151045000
#> 248:                              <NA>     99.68267             35726885000
#> 249:                              <NA>     99.37778             27751900000
#> 250:                              <NA>     98.74224             18446867500
#>      primary_dealer_tendered reopening security_term_day_month
#>                        <num>    <char>                  <char>
#>   1:                      NA       Yes                  42-Day
#>   2:             1.61672e+11       Yes                  91-Day
#>   3:             1.42729e+11        No                 182-Day
#>   4:             1.32570e+11       Yes                  28-Day
#>   5:             1.34690e+11       Yes                  56-Day
#>  ---                                                          
#> 246:             1.58410e+11       Yes                  92-Day
#> 247:             1.42220e+11        No                 182-Day
#> 248:             1.82300e+11       Yes                  28-Day
#> 249:             1.55425e+11       Yes                  56-Day
#> 250:             1.28425e+11        No                 119-Day
#>      security_term_week_year series soma_accepted soma_holdings soma_included
#>                       <char>  <num>         <num>         <num>        <char>
#>   1:                  6-Week     NA            NA    1.6264e+10            No
#>   2:                 13-Week     NA    5961264700    1.6264e+10            No
#>   3:                 26-Week     NA    5118912000    1.6264e+10            No
#>   4:                  4-Week     NA    5491633300    1.6789e+10            No
#>   5:                  8-Week     NA    5883892800    1.6789e+10            No
#>  ---                                                                         
#> 246:                 13-Week     NA    4710356900    1.6659e+10            No
#> 247:                 26-Week     NA    4193366400    1.6659e+10            No
#> 248:                  4-Week     NA     284352300    7.1100e+08            No
#> 249:                  8-Week     NA     241699300    7.1100e+08            No
#> 250:                 17-Week     NA     184828900    7.1100e+08            No
#>      soma_tendered spread standard_interest_payment_per1000 strippable    term
#>              <num>  <num>                             <num>      <num>  <char>
#>   1:            NA     NA                                NA         NA  6-Week
#>   2:    5961264700     NA                                NA         NA 13-Week
#>   3:    5118912000     NA                                NA         NA 26-Week
#>   4:    5491633300     NA                                NA         NA  4-Week
#>   5:    5883892800     NA                                NA         NA  8-Week
#>  ---                                                                          
#> 246:    4710356900     NA                                NA         NA 13-Week
#> 247:    4193366400     NA                                NA         NA 26-Week
#> 248:     284352300     NA                                NA         NA  4-Week
#> 249:     241699300     NA                                NA         NA  8-Week
#> 250:     184828900     NA                                NA         NA 17-Week
#>      tiin_conversion_factor_per1000   tips total_accepted total_tendered
#>                               <num> <char>          <num>          <num>
#>   1:                             NA     No             NA             NA
#>   2:                             NA     No    97961363800   219564493800
#>   3:                             NA     No    84118931800   208808185800
#>   4:                             NA     No    75492049300   197559749300
#>   5:                             NA     No    80884142500   214903147500
#>  ---                                                                    
#> 246:                             NA     No    86710476800   229671436800
#> 247:                             NA     No    77193381700   223374957700
#> 248:                             NA     No   100284544700   261011192700
#> 249:                             NA     No    85241769600   225818909600
#> 250:                             NA     No    65185678400   190545636900
#>      treasury_retail_accepted treasury_retail_tenders_accepted   type
#>                         <num>                           <char> <char>
#>   1:                       NA                              Yes   Bill
#>   2:                923444200                              Yes   Bill
#>   3:                815600900                              Yes   Bill
#>   4:               4623284400                              Yes   Bill
#>   5:                829586100                              Yes   Bill
#>  ---                                                                 
#> 246:                987129300                              Yes   Bill
#> 247:                605390200                              Yes   Bill
#> 248:               5178360900                              Yes   Bill
#> 249:                909420100                              Yes   Bill
#> 250:                342156000                              Yes   Bill
#>      unadjusted_accrued_interest_per1000 unadjusted_price   updated_timestamp
#>                                    <num>            <num>              <char>
#>   1:                                  NA               NA 2026-06-25T11:02:10
#>   2:                                  NA               NA 2026-06-29T12:27:34
#>   3:                                  NA               NA 2026-06-29T11:35:19
#>   4:                                  NA               NA 2026-06-25T11:33:03
#>   5:                                  NA               NA 2026-06-25T11:33:04
#>  ---                                                                         
#> 246:                                  NA               NA 2025-09-29T11:35:04
#> 247:                                  NA               NA 2025-09-29T11:35:05
#> 248:                                  NA               NA 2025-09-25T11:34:57
#> 249:                                  NA               NA 2025-09-25T11:34:58
#> 250:                                  NA               NA 2025-09-24T11:35:18
#>      xml_filename_announcement xml_filename_competitive_results
#>                         <char>                           <char>
#>   1:          A_20260625_3.xml                             <NA>
#>   2:          A_20260625_2.xml                 R_20260629_1.xml
#>   3:          A_20260625_1.xml                 R_20260629_2.xml
#>   4:          A_20260623_1.xml                 R_20260625_2.xml
#>   5:          A_20260623_3.xml                 R_20260625_1.xml
#>  ---                                                           
#> 246:          A_20250925_4.xml                 R_20250929_2.xml
#> 247:          A_20250925_3.xml                 R_20250929_1.xml
#> 248:          A_20250923_2.xml                 R_20250925_1.xml
#> 249:          A_20250923_3.xml                 R_20250925_2.xml
#> 250:          A_20250923_1.xml                 R_20250924_2.xml
#>      xml_filename_special_announcement tint_cusip1 tint_cusip2
#>                                  <num>       <num>       <num>
#>   1:                                NA          NA          NA
#>   2:                                NA          NA          NA
#>   3:                                NA          NA          NA
#>   4:                                NA          NA          NA
#>   5:                                NA          NA          NA
#>  ---                                                          
#> 246:                                NA          NA          NA
#> 247:                                NA          NA          NA
#> 248:                                NA          NA          NA
#> 249:                                NA          NA          NA
#> 250:                                NA          NA          NA
#>      tint_cusip1_due_date tint_cusip2_due_date
#>                     <num>                <num>
#>   1:                   NA                   NA
#>   2:                   NA                   NA
#>   3:                   NA                   NA
#>   4:                   NA                   NA
#>   5:                   NA                   NA
#>  ---                                          
#> 246:                   NA                   NA
#> 247:                   NA                   NA
#> 248:                   NA                   NA
#> 249:                   NA                   NA
#> 250:                   NA                   NA
# upcoming auction schedule
tr_upcoming()
#>         cusip issue_date security_type    security_term maturity_date
#>        <char>     <Date>        <char>           <char>        <Date>
#>  1: 912797TW7 2026-07-02          Bill           6-Week    2026-08-13
#>  2: 912797VP9 2026-07-07          Bill          17-Week          <NA>
#>  3: 912797US4 2026-07-07          Bill           4-Week          <NA>
#>  4: 912797UW5 2026-07-07          Bill           8-Week          <NA>
#>  5: 912797UJ4 2026-07-09          Bill          13-Week          <NA>
#>  6: 912797VS3 2026-07-09          Bill          26-Week          <NA>
#>  7: 912797VQ7 2026-07-09          Bill          52-Week          <NA>
#>  8: 912797TX5 2026-07-09          Bill           6-Week          <NA>
#>  9: 91282CQZ7 2026-07-15          Note           3-Year          <NA>
#> 10: 91282CQQ7 2026-07-15          Note  9-Year 10-Month          <NA>
#> 11: 912810UU0 2026-07-15          Bond 29-Year 10-Month          <NA>
#>     interest_rate ref_cpi_on_issue_date ref_cpi_on_dated_date announcement_date
#>             <num>                 <num>                 <num>            <Date>
#>  1:            NA                    NA                    NA        2026-06-25
#>  2:            NA                    NA                    NA        2026-06-30
#>  3:            NA                    NA                    NA        2026-06-30
#>  4:            NA                    NA                    NA        2026-06-30
#>  5:            NA                    NA                    NA        2026-07-02
#>  6:            NA                    NA                    NA        2026-07-02
#>  7:            NA                    NA                    NA        2026-07-02
#>  8:            NA                    NA                    NA        2026-07-02
#>  9:            NA                    NA                    NA        2026-07-02
#> 10:            NA                    NA                    NA        2026-07-02
#> 11:            NA                    NA                    NA        2026-07-02
#>     auction_date auction_date_year dated_date accrued_interest_per1000
#>           <Date>             <num>      <num>                    <num>
#>  1:   2026-06-30              2026         NA                       NA
#>  2:   2026-07-01              2026         NA                       NA
#>  3:   2026-07-02              2026         NA                       NA
#>  4:   2026-07-02              2026         NA                       NA
#>  5:   2026-07-06              2026         NA                       NA
#>  6:   2026-07-06              2026         NA                       NA
#>  7:   2026-07-07              2026         NA                       NA
#>  8:   2026-07-07              2026         NA                       NA
#>  9:   2026-07-07              2026         NA                       NA
#> 10:   2026-07-08              2026         NA                       NA
#> 11:   2026-07-09              2026         NA                       NA
#>     accrued_interest_per100 adjusted_accrued_interest_per1000 adjusted_price
#>                       <num>                             <num>          <num>
#>  1:                      NA                                NA             NA
#>  2:                      NA                                NA             NA
#>  3:                      NA                                NA             NA
#>  4:                      NA                                NA             NA
#>  5:                      NA                                NA             NA
#>  6:                      NA                                NA             NA
#>  7:                      NA                                NA             NA
#>  8:                      NA                                NA             NA
#>  9:                      NA                                NA             NA
#> 10:                      NA                                NA             NA
#> 11:                      NA                                NA             NA
#>     allocation_percentage allocation_percentage_decimals announced_cusip
#>                     <num>                          <num>           <num>
#>  1:                    NA                              2              NA
#>  2:                    NA                             NA              NA
#>  3:                    NA                             NA              NA
#>  4:                    NA                             NA              NA
#>  5:                    NA                             NA              NA
#>  6:                    NA                             NA              NA
#>  7:                    NA                             NA              NA
#>  8:                    NA                             NA              NA
#>  9:                    NA                             NA              NA
#> 10:                    NA                             NA              NA
#> 11:                    NA                             NA              NA
#>     auction_format average_median_discount_rate average_median_investment_rate
#>             <char>                        <num>                          <num>
#>  1:   Single-Price                           NA                             NA
#>  2:           <NA>                           NA                             NA
#>  3:           <NA>                           NA                             NA
#>  4:           <NA>                           NA                             NA
#>  5:           <NA>                           NA                             NA
#>  6:           <NA>                           NA                             NA
#>  7:           <NA>                           NA                             NA
#>  8:           <NA>                           NA                             NA
#>  9:           <NA>                           NA                             NA
#> 10:           <NA>                           NA                             NA
#> 11:           <NA>                           NA                             NA
#>     average_median_price average_median_discount_margin average_median_yield
#>                    <num>                          <num>                <num>
#>  1:                   NA                             NA                   NA
#>  2:                   NA                             NA                   NA
#>  3:                   NA                             NA                   NA
#>  4:                   NA                             NA                   NA
#>  5:                   NA                             NA                   NA
#>  6:                   NA                             NA                   NA
#>  7:                   NA                             NA                   NA
#>  8:                   NA                             NA                   NA
#>  9:                   NA                             NA                   NA
#> 10:                   NA                             NA                   NA
#> 11:                   NA                             NA                   NA
#>     back_dated back_dated_date bid_to_cover_ratio call_date callable
#>          <num>           <num>              <num>     <num>    <num>
#>  1:         NA              NA                 NA        NA       NA
#>  2:         NA              NA                 NA        NA       NA
#>  3:         NA              NA                 NA        NA       NA
#>  4:         NA              NA                 NA        NA       NA
#>  5:         NA              NA                 NA        NA       NA
#>  6:         NA              NA                 NA        NA       NA
#>  7:         NA              NA                 NA        NA       NA
#>  8:         NA              NA                 NA        NA       NA
#>  9:         NA              NA                 NA        NA       NA
#> 10:         NA              NA                 NA        NA       NA
#> 11:         NA              NA                 NA        NA       NA
#>     called_date cash_management_bill_cmb closing_time_competitive
#>           <num>                   <char>                   <char>
#>  1:          NA                       No                 11:30 AM
#>  2:          NA                       No                     <NA>
#>  3:          NA                       No                     <NA>
#>  4:          NA                       No                     <NA>
#>  5:          NA                       No                     <NA>
#>  6:          NA                       No                     <NA>
#>  7:          NA                       No                     <NA>
#>  8:          NA                       No                     <NA>
#>  9:          NA                       No                     <NA>
#> 10:          NA                       No                     <NA>
#> 11:          NA                       No                     <NA>
#>     closing_time_noncompetitive competitive_accepted competitive_bid_decimals
#>                          <char>                <num>                    <num>
#>  1:                    11:00 AM                   NA                        3
#>  2:                        <NA>                   NA                       NA
#>  3:                        <NA>                   NA                       NA
#>  4:                        <NA>                   NA                       NA
#>  5:                        <NA>                   NA                       NA
#>  6:                        <NA>                   NA                       NA
#>  7:                        <NA>                   NA                       NA
#>  8:                        <NA>                   NA                       NA
#>  9:                        <NA>                   NA                       NA
#> 10:                        <NA>                   NA                       NA
#> 11:                        <NA>                   NA                       NA
#>     competitive_tendered competitive_tenders_accepted corpus_cusip
#>                    <num>                       <char>        <num>
#>  1:                   NA                          Yes           NA
#>  2:                   NA                         <NA>           NA
#>  3:                   NA                         <NA>           NA
#>  4:                   NA                         <NA>           NA
#>  5:                   NA                         <NA>           NA
#>  6:                   NA                         <NA>           NA
#>  7:                   NA                         <NA>           NA
#>  8:                   NA                         <NA>           NA
#>  9:                   NA                         <NA>           NA
#> 10:                   NA                         <NA>           NA
#> 11:                   NA                         <NA>           NA
#>     cpi_base_reference_period currently_outstanding direct_bidder_accepted
#>                         <num>                 <num>                  <num>
#>  1:                        NA           1.76066e+11                     NA
#>  2:                        NA                    NA                     NA
#>  3:                        NA                    NA                     NA
#>  4:                        NA                    NA                     NA
#>  5:                        NA                    NA                     NA
#>  6:                        NA                    NA                     NA
#>  7:                        NA                    NA                     NA
#>  8:                        NA                    NA                     NA
#>  9:                        NA                    NA                     NA
#> 10:                        NA                    NA                     NA
#> 11:                        NA                    NA                     NA
#>     direct_bidder_tendered
#>                      <num>
#>  1:                     NA
#>  2:                     NA
#>  3:                     NA
#>  4:                     NA
#>  5:                     NA
#>  6:                     NA
#>  7:                     NA
#>  8:                     NA
#>  9:                     NA
#> 10:                     NA
#> 11:                     NA
#>     estimated_amount_of_publicly_held_maturing_securities_by_type fima_included
#>                                                             <num>        <char>
#>  1:                                                   2.49478e+11           Yes
#>  2:                                                            NA          <NA>
#>  3:                                                            NA          <NA>
#>  4:                                                            NA          <NA>
#>  5:                                                            NA          <NA>
#>  6:                                                            NA          <NA>
#>  7:                                                            NA          <NA>
#>  8:                                                            NA          <NA>
#>  9:                                                            NA          <NA>
#> 10:                                                            NA          <NA>
#> 11:                                                            NA          <NA>
#>     fima_noncompetitive_accepted fima_noncompetitive_tendered
#>                            <num>                        <num>
#>  1:                           NA                           NA
#>  2:                           NA                           NA
#>  3:                           NA                           NA
#>  4:                           NA                           NA
#>  5:                           NA                           NA
#>  6:                           NA                           NA
#>  7:                           NA                           NA
#>  8:                           NA                           NA
#>  9:                           NA                           NA
#> 10:                           NA                           NA
#> 11:                           NA                           NA
#>     first_interest_period first_interest_payment_date floating_rate
#>                     <num>                       <num>        <char>
#>  1:                    NA                          NA            No
#>  2:                    NA                          NA            No
#>  3:                    NA                          NA            No
#>  4:                    NA                          NA            No
#>  5:                    NA                          NA            No
#>  6:                    NA                          NA            No
#>  7:                    NA                          NA            No
#>  8:                    NA                          NA            No
#>  9:                    NA                          NA            No
#> 10:                    NA                          NA            No
#> 11:                    NA                          NA            No
#>     frn_index_determination_date frn_index_determination_rate
#>                            <num>                        <num>
#>  1:                           NA                           NA
#>  2:                           NA                           NA
#>  3:                           NA                           NA
#>  4:                           NA                           NA
#>  5:                           NA                           NA
#>  6:                           NA                           NA
#>  7:                           NA                           NA
#>  8:                           NA                           NA
#>  9:                           NA                           NA
#> 10:                           NA                           NA
#> 11:                           NA                           NA
#>     high_discount_rate high_investment_rate high_price high_discount_margin
#>                  <num>                <num>      <num>                <num>
#>  1:                 NA                   NA         NA                   NA
#>  2:                 NA                   NA         NA                   NA
#>  3:                 NA                   NA         NA                   NA
#>  4:                 NA                   NA         NA                   NA
#>  5:                 NA                   NA         NA                   NA
#>  6:                 NA                   NA         NA                   NA
#>  7:                 NA                   NA         NA                   NA
#>  8:                 NA                   NA         NA                   NA
#>  9:                 NA                   NA         NA                   NA
#> 10:                 NA                   NA         NA                   NA
#> 11:                 NA                   NA         NA                   NA
#>     high_yield index_ratio_on_issue_date indirect_bidder_accepted
#>          <num>                     <num>                    <num>
#>  1:         NA                        NA                       NA
#>  2:         NA                        NA                       NA
#>  3:         NA                        NA                       NA
#>  4:         NA                        NA                       NA
#>  5:         NA                        NA                       NA
#>  6:         NA                        NA                       NA
#>  7:         NA                        NA                       NA
#>  8:         NA                        NA                       NA
#>  9:         NA                        NA                       NA
#> 10:         NA                        NA                       NA
#> 11:         NA                        NA                       NA
#>     indirect_bidder_tendered interest_payment_frequency low_discount_rate
#>                        <num>                     <char>             <num>
#>  1:                       NA                       None                NA
#>  2:                       NA                       <NA>                NA
#>  3:                       NA                       <NA>                NA
#>  4:                       NA                       <NA>                NA
#>  5:                       NA                       <NA>                NA
#>  6:                       NA                       <NA>                NA
#>  7:                       NA                       <NA>                NA
#>  8:                       NA                       <NA>                NA
#>  9:                       NA                       <NA>                NA
#> 10:                       NA                       <NA>                NA
#> 11:                       NA                       <NA>                NA
#>     low_investment_rate low_price low_discount_margin low_yield maturing_date
#>                   <num>     <num>               <num>     <num>        <Date>
#>  1:                  NA        NA                  NA        NA    2026-07-02
#>  2:                  NA        NA                  NA        NA          <NA>
#>  3:                  NA        NA                  NA        NA          <NA>
#>  4:                  NA        NA                  NA        NA          <NA>
#>  5:                  NA        NA                  NA        NA          <NA>
#>  6:                  NA        NA                  NA        NA          <NA>
#>  7:                  NA        NA                  NA        NA          <NA>
#>  8:                  NA        NA                  NA        NA          <NA>
#>  9:                  NA        NA                  NA        NA          <NA>
#> 10:                  NA        NA                  NA        NA          <NA>
#> 11:                  NA        NA                  NA        NA          <NA>
#>     maximum_competitive_award maximum_noncompetitive_award maximum_single_bid
#>                         <num>                        <num>              <num>
#>  1:                   2.8e+10                        1e+07            2.8e+10
#>  2:                        NA                           NA                 NA
#>  3:                        NA                           NA                 NA
#>  4:                        NA                           NA                 NA
#>  5:                        NA                           NA                 NA
#>  6:                        NA                           NA                 NA
#>  7:                        NA                           NA                 NA
#>  8:                        NA                           NA                 NA
#>  9:                        NA                           NA                 NA
#> 10:                        NA                           NA                 NA
#> 11:                        NA                           NA                 NA
#>     minimum_bid_amount minimum_strip_amount minimum_to_issue multiples_to_bid
#>                  <num>                <num>            <num>            <num>
#>  1:                100                   NA              100              100
#>  2:                 NA                   NA               NA               NA
#>  3:                 NA                   NA               NA               NA
#>  4:                 NA                   NA               NA               NA
#>  5:                 NA                   NA               NA               NA
#>  6:                 NA                   NA               NA               NA
#>  7:                 NA                   NA               NA               NA
#>  8:                 NA                   NA               NA               NA
#>  9:                 NA                   NA               NA               NA
#> 10:                 NA                   NA               NA               NA
#> 11:                 NA                   NA               NA               NA
#>     multiples_to_issue nlp_exclusion_amount nlp_reporting_threshold
#>                  <num>                <num>                   <num>
#>  1:                100             5.78e+10                 2.8e+10
#>  2:                 NA                   NA                      NA
#>  3:                 NA                   NA                      NA
#>  4:                 NA                   NA                      NA
#>  5:                 NA                   NA                      NA
#>  6:                 NA                   NA                      NA
#>  7:                 NA                   NA                      NA
#>  8:                 NA                   NA                      NA
#>  9:                 NA                   NA                      NA
#> 10:                 NA                   NA                      NA
#> 11:                 NA                   NA                      NA
#>     noncompetitive_accepted noncompetitive_tenders_accepted offering_amount
#>                       <num>                          <char>           <num>
#>  1:                      NA                             Yes           8e+10
#>  2:                      NA                            <NA>              NA
#>  3:                      NA                            <NA>              NA
#>  4:                      NA                            <NA>              NA
#>  5:                      NA                            <NA>              NA
#>  6:                      NA                            <NA>              NA
#>  7:                      NA                            <NA>              NA
#>  8:                      NA                            <NA>              NA
#>  9:                      NA                            <NA>              NA
#> 10:                      NA                            <NA>              NA
#> 11:                      NA                            <NA>              NA
#>     original_cusip original_dated_date original_issue_date
#>              <num>               <num>              <Date>
#>  1:             NA                  NA          2026-02-12
#>  2:             NA                  NA                <NA>
#>  3:             NA                  NA                <NA>
#>  4:             NA                  NA                <NA>
#>  5:             NA                  NA                <NA>
#>  6:             NA                  NA                <NA>
#>  7:             NA                  NA                <NA>
#>  8:             NA                  NA                <NA>
#>  9:             NA                  NA                <NA>
#> 10:             NA                  NA                <NA>
#> 11:             NA                  NA                <NA>
#>     original_security_term pdf_filename_announcement
#>                     <char>                    <char>
#>  1:                26-Week          A_20260625_3.pdf
#>  2:                17-Week                      <NA>
#>  3:                17-Week                      <NA>
#>  4:                17-Week                      <NA>
#>  5:                26-Week                      <NA>
#>  6:                26-Week                      <NA>
#>  7:                52-Week                      <NA>
#>  8:                26-Week                      <NA>
#>  9:                 3-Year                      <NA>
#> 10:                10-Year                      <NA>
#> 11:                30-Year                      <NA>
#>     pdf_filename_competitive_results pdf_filename_noncompetitive_results
#>                                <num>                               <num>
#>  1:                               NA                                  NA
#>  2:                               NA                                  NA
#>  3:                               NA                                  NA
#>  4:                               NA                                  NA
#>  5:                               NA                                  NA
#>  6:                               NA                                  NA
#>  7:                               NA                                  NA
#>  8:                               NA                                  NA
#>  9:                               NA                                  NA
#> 10:                               NA                                  NA
#> 11:                               NA                                  NA
#>     pdf_filename_special_announcement price_per100 primary_dealer_accepted
#>                                 <num>        <num>                   <num>
#>  1:                                NA           NA                      NA
#>  2:                                NA           NA                      NA
#>  3:                                NA           NA                      NA
#>  4:                                NA           NA                      NA
#>  5:                                NA           NA                      NA
#>  6:                                NA           NA                      NA
#>  7:                                NA           NA                      NA
#>  8:                                NA           NA                      NA
#>  9:                                NA           NA                      NA
#> 10:                                NA           NA                      NA
#> 11:                                NA           NA                      NA
#>     primary_dealer_tendered reopening security_term_day_month
#>                       <num>    <char>                  <char>
#>  1:                      NA       Yes                  42-Day
#>  2:                      NA        No                 119-Day
#>  3:                      NA       Yes                  28-Day
#>  4:                      NA       Yes                  56-Day
#>  5:                      NA       Yes                  91-Day
#>  6:                      NA        No                 182-Day
#>  7:                      NA        No                 364-Day
#>  8:                      NA       Yes                  42-Day
#>  9:                      NA        No                 0-Month
#> 10:                      NA       Yes                10-Month
#> 11:                      NA       Yes                10-Month
#>     security_term_week_year series soma_accepted soma_holdings soma_included
#>                      <char>  <num>         <num>         <num>        <char>
#>  1:                  6-Week     NA            NA    1.6264e+10            No
#>  2:                 17-Week     NA            NA            NA          <NA>
#>  3:                  4-Week     NA            NA            NA          <NA>
#>  4:                  8-Week     NA            NA            NA          <NA>
#>  5:                 13-Week     NA            NA            NA          <NA>
#>  6:                 26-Week     NA            NA            NA          <NA>
#>  7:                 52-Week     NA            NA            NA          <NA>
#>  8:                  6-Week     NA            NA            NA          <NA>
#>  9:                  3-Year     NA            NA            NA          <NA>
#> 10:                  9-Year     NA            NA            NA          <NA>
#> 11:                 29-Year     NA            NA            NA          <NA>
#>     soma_tendered spread standard_interest_payment_per1000 strippable    term
#>             <num>  <num>                             <num>      <num>  <char>
#>  1:            NA     NA                                NA         NA  6-Week
#>  2:            NA     NA                                NA         NA 17-Week
#>  3:            NA     NA                                NA         NA  4-Week
#>  4:            NA     NA                                NA         NA  8-Week
#>  5:            NA     NA                                NA         NA 13-Week
#>  6:            NA     NA                                NA         NA 26-Week
#>  7:            NA     NA                                NA         NA 52-Week
#>  8:            NA     NA                                NA         NA  6-Week
#>  9:            NA     NA                                NA         NA  3-Year
#> 10:            NA     NA                                NA         NA 10-Year
#> 11:            NA     NA                                NA         NA 30-Year
#>     tiin_conversion_factor_per1000   tips total_accepted total_tendered
#>                              <num> <char>          <num>          <num>
#>  1:                             NA     No             NA             NA
#>  2:                             NA     No             NA             NA
#>  3:                             NA     No             NA             NA
#>  4:                             NA     No             NA             NA
#>  5:                             NA     No             NA             NA
#>  6:                             NA     No             NA             NA
#>  7:                             NA     No             NA             NA
#>  8:                             NA     No             NA             NA
#>  9:                             NA     No             NA             NA
#> 10:                             NA     No             NA             NA
#> 11:                             NA     No             NA             NA
#>     treasury_retail_accepted treasury_retail_tenders_accepted   type
#>                        <num>                           <char> <char>
#>  1:                       NA                              Yes   Bill
#>  2:                       NA                             <NA>   Bill
#>  3:                       NA                             <NA>   Bill
#>  4:                       NA                             <NA>   Bill
#>  5:                       NA                             <NA>   Bill
#>  6:                       NA                             <NA>   Bill
#>  7:                       NA                             <NA>   Bill
#>  8:                       NA                             <NA>   Bill
#>  9:                       NA                             <NA>   Note
#> 10:                       NA                             <NA>   Note
#> 11:                       NA                             <NA>   Bond
#>     unadjusted_accrued_interest_per1000 unadjusted_price   updated_timestamp
#>                                   <num>            <num>              <char>
#>  1:                                  NA               NA 2026-06-25T11:02:10
#>  2:                                  NA               NA 2026-06-26T10:32:19
#>  3:                                  NA               NA 2026-06-26T10:32:13
#>  4:                                  NA               NA 2026-06-26T10:32:10
#>  5:                                  NA               NA 2026-06-26T10:32:18
#>  6:                                  NA               NA 2026-06-26T10:32:12
#>  7:                                  NA               NA 2026-06-26T10:32:11
#>  8:                                  NA               NA 2026-06-26T10:32:17
#>  9:                                  NA               NA 2026-06-26T10:32:15
#> 10:                                  NA               NA 2026-06-26T10:32:14
#> 11:                                  NA               NA 2026-06-26T10:32:16
#>     xml_filename_announcement xml_filename_competitive_results
#>                        <char>                            <num>
#>  1:          A_20260625_3.xml                               NA
#>  2:                      <NA>                               NA
#>  3:                      <NA>                               NA
#>  4:                      <NA>                               NA
#>  5:                      <NA>                               NA
#>  6:                      <NA>                               NA
#>  7:                      <NA>                               NA
#>  8:                      <NA>                               NA
#>  9:                      <NA>                               NA
#> 10:                      <NA>                               NA
#> 11:                      <NA>                               NA
#>     xml_filename_special_announcement tint_cusip1 tint_cusip2
#>                                 <num>       <num>       <num>
#>  1:                                NA          NA          NA
#>  2:                                NA          NA          NA
#>  3:                                NA          NA          NA
#>  4:                                NA          NA          NA
#>  5:                                NA          NA          NA
#>  6:                                NA          NA          NA
#>  7:                                NA          NA          NA
#>  8:                                NA          NA          NA
#>  9:                                NA          NA          NA
#> 10:                                NA          NA          NA
#> 11:                                NA          NA          NA
#>     tint_cusip1_due_date tint_cusip2_due_date
#>                    <num>                <num>
#>  1:                   NA                   NA
#>  2:                   NA                   NA
#>  3:                   NA                   NA
#>  4:                   NA                   NA
#>  5:                   NA                   NA
#>  6:                   NA                   NA
#>  7:                   NA                   NA
#>  8:                   NA                   NA
#>  9:                   NA                   NA
#> 10:                   NA                   NA
#> 11:                   NA                   NA
# }
```
