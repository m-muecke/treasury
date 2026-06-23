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
#>   1: 91282CQQ7 2026-06-15          Note 9-Year 11-Month    2036-05-15
#>   2: 91282CQV6 2026-06-15          Note          3-Year    2029-06-15
#>   3: 91282CQT1 2026-06-01          Note          7-Year    2033-05-31
#>   4: 91282CQU8 2026-06-01          Note          5-Year    2031-05-31
#>   5: 91282CQS3 2026-06-01          Note          2-Year    2028-05-31
#>  ---                                                                 
#> 246: 91282CBS9 2021-03-31          Note          7-Year    2028-03-31
#> 247: 91282CBL4 2021-03-15          Note 9-Year 11-Month    2031-02-15
#> 248: 91282CBP5 2021-03-01          Note          7-Year    2028-02-29
#> 249: 91282CBL4 2021-02-16          Note         10-Year    2031-02-15
#> 250: 91282CBJ9 2021-02-01          Note          7-Year    2028-01-31
#>      interest_rate ref_cpi_on_issue_date ref_cpi_on_dated_date
#>              <num>                 <num>                 <num>
#>   1:         4.375                    NA                    NA
#>   2:         4.125                    NA                    NA
#>   3:         4.250                    NA                    NA
#>   4:         4.125                    NA                    NA
#>   5:         4.000                    NA                    NA
#>  ---                                                          
#> 246:         1.250                    NA                    NA
#> 247:         1.125                    NA                    NA
#> 248:         1.125                    NA                    NA
#> 249:         1.125                    NA                    NA
#> 250:         0.750                    NA                    NA
#>      announcement_date auction_date auction_date_year dated_date
#>                 <Date>       <Date>             <num>     <Date>
#>   1:        2026-06-04   2026-06-10              2026 2026-05-15
#>   2:        2026-06-04   2026-06-09              2026 2026-06-15
#>   3:        2026-05-21   2026-05-28              2026 2026-05-31
#>   4:        2026-05-21   2026-05-27              2026 2026-05-31
#>   5:        2026-05-21   2026-05-26              2026 2026-05-31
#>  ---                                                            
#> 246:        2021-03-18   2021-03-25              2021 2021-03-31
#> 247:        2021-03-04   2021-03-10              2021 2021-02-15
#> 248:        2021-02-18   2021-02-25              2021 2021-02-28
#> 249:        2021-02-03   2021-02-10              2021 2021-02-15
#> 250:        2021-01-21   2021-01-28              2021 2021-01-31
#>      accrued_interest_per1000 accrued_interest_per100
#>                         <num>                   <num>
#>   1:                  3.68546                      NA
#>   2:                       NA                      NA
#>   3:                  0.11612                      NA
#>   4:                  0.11270                      NA
#>   5:                  0.10929                      NA
#>  ---                                                 
#> 246:                       NA                      NA
#> 247:                  0.87017                      NA
#> 248:                  0.03057                      NA
#> 249:                  0.03108                      NA
#> 250:                  0.02072                      NA
#>      adjusted_accrued_interest_per1000 adjusted_price allocation_percentage
#>                                  <num>          <num>                 <num>
#>   1:                                NA             NA                 71.34
#>   2:                                NA             NA                 42.92
#>   3:                                NA             NA                 71.23
#>   4:                                NA             NA                 75.22
#>   5:                                NA             NA                 42.14
#>  ---                                                                       
#> 246:                                NA             NA                 40.90
#> 247:                                NA             NA                 27.17
#> 248:                                NA             NA                 25.19
#> 249:                                NA             NA                 32.14
#> 250:                                NA             NA                 51.45
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
#>   1:                   NA                             NA                4.480
#>   2:                   NA                             NA                4.147
#>   3:                   NA                             NA                4.240
#>   4:                   NA                             NA                4.125
#>   5:                   NA                             NA                4.015
#>  ---                                                                         
#> 246:                   NA                             NA                1.225
#> 247:                   NA                             NA                1.467
#> 248:                   NA                             NA                1.099
#> 249:                   NA                             NA                1.105
#> 250:                   NA                             NA                0.703
#>      back_dated back_dated_date bid_to_cover_ratio call_date callable
#>          <char>          <Date>              <num>     <num>   <char>
#>   1:        Yes      2026-05-15               2.57        NA       No
#>   2:         No            <NA>               2.64        NA       No
#>   3:        Yes      2026-05-31               2.52        NA       No
#>   4:        Yes      2026-05-31               2.34        NA       No
#>   5:        Yes      2026-05-31               2.64        NA       No
#>  ---                                                                 
#> 246:         No            <NA>               2.23        NA       No
#> 247:        Yes      2021-02-15               2.38        NA       No
#> 248:        Yes      2021-02-28               2.04        NA       No
#> 249:        Yes      2021-02-15               2.37        NA       No
#> 250:        Yes      2021-01-31               2.30        NA       No
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
#>   1:                    12:00 PM          38914680400                        3
#>   2:                    12:00 PM          57733403100                        3
#>   3:                    12:00 PM          43917937100                        3
#>   4:                    12:00 PM          69746462500                        3
#>   5:                    12:00 PM          68274791000                        3
#>  ---                                                                          
#> 246:                    12:00 PM          61938581000                        3
#> 247:                    12:00 PM          37966272200                        3
#> 248:                    12:00 PM          61989770000                        3
#> 249:                    12:00 PM          40976823200                        3
#> 250:                    12:00 PM          61994272000                        3
#>      competitive_tendered competitive_tenders_accepted corpus_cusip
#>                     <num>                       <char>       <char>
#>   1:          99959349000                          Yes    912821UK9
#>   2:         153124410000                          Yes    912821UP8
#>   3:         110712243000                          Yes    912821UN3
#>   4:         163570965500                          Yes    912821UM5
#>   5:         181345923000                          Yes    912821UL7
#>  ---                                                               
#> 246:         138411341000                          Yes    912821MA0
#> 247:          90545182000                          Yes    912821GD1
#> 248:         126765780000                          Yes    912821GG4
#> 249:          96961674000                          Yes    912821GD1
#> 250:         142898245000                          Yes    912821GB5
#>      cpi_base_reference_period currently_outstanding direct_bidder_accepted
#>                          <num>                 <num>                  <num>
#>   1:                        NA            5.1972e+10             4796000000
#>   2:                        NA                    NA            12131465100
#>   3:                        NA                    NA             4916350000
#>   4:                        NA                    NA             8609059400
#>   5:                        NA                    NA            20557500000
#>  ---                                                                       
#> 246:                        NA                    NA            11150900000
#> 247:                        NA            5.5874e+10             6748585000
#> 248:                        NA                    NA            13717900000
#> 249:                        NA                    NA             7753035000
#> 250:                        NA                    NA            10094325000
#>      direct_bidder_tendered
#>                       <num>
#>   1:             7916500000
#>   2:            16178000000
#>   3:             8093100000
#>   4:            12897000000
#>   5:            25366000000
#>  ---                       
#> 246:            16300900000
#> 247:             9865000000
#> 248:            18547900000
#> 249:            11695000000
#> 250:            15443600000
#>      estimated_amount_of_publicly_held_maturing_securities_by_type
#>                                                              <num>
#>   1:                                                   3.99990e+10
#>   2:                                                   3.99990e+10
#>   3:                                                   1.30939e+11
#>   4:                                                   1.30939e+11
#>   5:                                                   1.30939e+11
#>  ---                                                              
#> 246:                                                   7.15940e+10
#> 247:                                                   2.05640e+10
#> 248:                                                   7.09070e+10
#> 249:                                                   6.28640e+10
#> 250:                                                   1.28869e+11
#>      fima_included fima_noncompetitive_accepted fima_noncompetitive_tendered
#>             <char>                        <num>                        <num>
#>   1:           Yes                        0e+00                        0e+00
#>   2:           Yes                        5e+06                        5e+06
#>   3:           Yes                        0e+00                        0e+00
#>   4:           Yes                        1e+08                        1e+08
#>   5:           Yes                        0e+00                        0e+00
#>  ---                                                                        
#> 246:           Yes                        0e+00                        0e+00
#> 247:           Yes                        0e+00                        0e+00
#> 248:           Yes                        0e+00                        0e+00
#> 249:           Yes                        0e+00                        0e+00
#> 250:           Yes                        0e+00                        0e+00
#>      first_interest_period first_interest_payment_date floating_rate
#>                     <char>                      <Date>        <char>
#>   1:                Normal                  2026-11-15            No
#>   2:                Normal                  2026-12-15            No
#>   3:                Normal                  2026-11-30            No
#>   4:                Normal                  2026-11-30            No
#>   5:                Normal                  2026-11-30            No
#>  ---                                                                
#> 246:                Normal                  2021-09-30            No
#> 247:                Normal                  2021-08-15            No
#> 248:                Normal                  2021-08-31            No
#> 249:                Normal                  2021-08-15            No
#> 250:                Normal                  2021-07-31            No
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
#>   1:                 NA                   NA   98.70309                   NA
#>   2:                 NA                   NA   99.81296                   NA
#>   3:                 NA                   NA   99.76017                   NA
#>   4:                 NA                   NA   99.74511                   NA
#>   5:                 NA                   NA   99.86490                   NA
#>  ---                                                                        
#> 246:                 NA                   NA   99.66649                   NA
#> 247:                 NA                   NA   96.34694                   NA
#> 248:                 NA                   NA   99.53143                   NA
#> 249:                 NA                   NA   99.71750                   NA
#> 250:                 NA                   NA   99.97278                   NA
#>      high_yield index_ratio_on_issue_date indirect_bidder_accepted
#>           <num>                     <num>                    <num>
#>   1:      4.538                        NA              30435505400
#>   2:      4.192                        NA              36781410000
#>   3:      4.290                        NA              34425897100
#>   4:      4.182                        NA              52207838100
#>   5:      4.071                        NA              39294023000
#>  ---                                                              
#> 246:      1.300                        NA              35471441000
#> 247:      1.523                        NA              21568158700
#> 248:      1.195                        NA              23592880000
#> 249:      1.155                        NA              24836683200
#> 250:      0.754                        NA              39738459500
#>      indirect_bidder_tendered interest_payment_frequency low_discount_rate
#>                         <num>                     <char>             <num>
#>   1:              37206849000                Semi-Annual                NA
#>   2:              48981410000                Semi-Annual                NA
#>   3:              41618143000                Semi-Annual                NA
#>   4:              61390965500                Semi-Annual                NA
#>   5:              58227923000                Semi-Annual                NA
#>  ---                                                                      
#> 246:              38621441000                Semi-Annual                NA
#> 247:              27229182000                Semi-Annual                NA
#> 248:              23592880000                Semi-Annual                NA
#> 249:              29564674000                Semi-Annual                NA
#> 250:              46396645000                Semi-Annual                NA
#>      low_investment_rate low_price low_discount_margin low_yield maturing_date
#>                    <num>     <num>               <num>     <num>        <Date>
#>   1:                  NA        NA                  NA      4.40    2026-06-15
#>   2:                  NA        NA                  NA      2.88    2026-06-15
#>   3:                  NA        NA                  NA      2.88    2026-05-31
#>   4:                  NA        NA                  NA      4.07    2026-05-31
#>   5:                  NA        NA                  NA      3.90    2026-05-31
#>  ---                                                                          
#> 246:                  NA        NA                  NA      0.08    2021-03-31
#> 247:                  NA        NA                  NA      0.88    2021-03-15
#> 248:                  NA        NA                  NA      0.95    2021-02-28
#> 249:                  NA        NA                  NA      0.08    2021-02-15
#> 250:                  NA        NA                  NA      0.60    2021-01-31
#>      maximum_competitive_award maximum_noncompetitive_award maximum_single_bid
#>                          <num>                        <num>              <num>
#>   1:                 1.365e+10                        1e+07          1.365e+10
#>   2:                 2.030e+10                        1e+07          2.030e+10
#>   3:                 1.540e+10                        1e+07          1.540e+10
#>   4:                 2.450e+10                        1e+07          2.450e+10
#>   5:                 2.415e+10                        1e+07          2.415e+10
#>  ---                                                                          
#> 246:                 2.170e+10                        5e+06          2.170e+10
#> 247:                 1.330e+10                        5e+06          1.330e+10
#> 248:                 2.170e+10                        5e+06          2.170e+10
#> 249:                 1.435e+10                        5e+06          1.435e+10
#> 250:                 2.170e+10                        5e+06          2.170e+10
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
#>   1:                100             1.47e+10               1.365e+10
#>   2:                100             0.00e+00               2.030e+10
#>   3:                100             0.00e+00               1.540e+10
#>   4:                100             0.00e+00               2.450e+10
#>   5:                100             0.00e+00               2.415e+10
#>  ---                                                                
#> 246:                100             0.00e+00               2.170e+10
#> 247:                100             1.44e+10               1.330e+10
#> 248:                100             0.00e+00               2.170e+10
#> 249:                100             0.00e+00               1.435e+10
#> 250:                100             0.00e+00               2.170e+10
#>      noncompetitive_accepted noncompetitive_tenders_accepted offering_amount
#>                        <num>                          <char>           <num>
#>   1:                85320600                             Yes         3.9e+10
#>   2:               261616100                             Yes         5.8e+10
#>   3:                82069100                             Yes         4.4e+10
#>   4:               153591500                             Yes         7.0e+10
#>   5:               725260500                             Yes         6.9e+10
#>  ---                                                                        
#> 246:                61445700                             Yes         6.2e+10
#> 247:                33739300                             Yes         3.8e+10
#> 248:                10255400                             Yes         6.2e+10
#> 249:                23219900                             Yes         4.1e+10
#> 250:                 5771500                             Yes         6.2e+10
#>      original_cusip original_dated_date original_issue_date
#>              <char>              <Date>              <Date>
#>   1:           <NA>          2026-05-15          2026-05-15
#>   2:           <NA>                <NA>                <NA>
#>   3:           <NA>                <NA>                <NA>
#>   4:           <NA>                <NA>                <NA>
#>   5:           <NA>                <NA>                <NA>
#>  ---                                                       
#> 246:           <NA>                <NA>                <NA>
#> 247:           <NA>          2021-02-15          2021-02-16
#> 248:           <NA>                <NA>                <NA>
#> 249:           <NA>                <NA>                <NA>
#> 250:           <NA>                <NA>                <NA>
#>      original_security_term pdf_filename_announcement
#>                      <char>                    <char>
#>   1:                10-Year          A_20260604_2.pdf
#>   2:                 3-Year          A_20260604_4.pdf
#>   3:                 7-Year          A_20260521_4.pdf
#>   4:                 5-Year          A_20260521_7.pdf
#>   5:                 2-Year          A_20260521_6.pdf
#>  ---                                                 
#> 246:                 7-Year          A_20210318_4.pdf
#> 247:                10-Year          A_20210304_6.pdf
#> 248:                 7-Year          A_20210218_4.pdf
#> 249:                10-Year          A_20210203_2.pdf
#> 250:                 7-Year          A_20210121_6.pdf
#>      pdf_filename_competitive_results pdf_filename_noncompetitive_results
#>                                <char>                              <char>
#>   1:                 R_20260610_2.pdf                  NCR_20260610_2.pdf
#>   2:                 R_20260609_3.pdf                  NCR_20260609_3.pdf
#>   3:                 R_20260528_3.pdf                  NCR_20260528_3.pdf
#>   4:                 R_20260527_3.pdf                  NCR_20260527_3.pdf
#>   5:                 R_20260526_4.pdf                  NCR_20260526_4.pdf
#>  ---                                                                     
#> 246:                 R_20210325_3.pdf                  NCR_20210325_3.pdf
#> 247:                 R_20210310_2.pdf                  NCR_20210310_2.pdf
#> 248:                 R_20210225_3.pdf                  NCR_20210225_3.pdf
#> 249:                 R_20210210_3.pdf                  NCR_20210210_3.pdf
#> 250:                 R_20210128_3.pdf                  NCR_20210128_3.pdf
#>           pdf_filename_special_announcement price_per100
#>                                      <char>        <num>
#>   1:                                   <NA>     98.70309
#>   2:                                   <NA>     99.81296
#>   3:                                   <NA>     99.76017
#>   4:                     SPL_20260521_3.pdf     99.74511
#>   5: SPL_20260521_1.pdf, SPL_20260521_2.pdf     99.86490
#>  ---                                                    
#> 246:                                   <NA>     99.66649
#> 247:                                   <NA>     96.34694
#> 248:                                   <NA>     99.53143
#> 249:                                   <NA>     99.71750
#> 250:                                   <NA>     99.97278
#>      primary_dealer_accepted primary_dealer_tendered reopening
#>                        <num>                   <num>    <char>
#>   1:              3683175000              5.4836e+10       Yes
#>   2:              8820528000              8.7965e+10        No
#>   3:              4575690000              6.1001e+10        No
#>   4:              8929565000              8.9283e+10        No
#>   5:              8423268000              9.7752e+10        No
#>  ---                                                          
#> 246:             15316240000              8.3489e+10        No
#> 247:              9649528500              5.3451e+10       Yes
#> 248:             24678990000              8.4625e+10        No
#> 249:              8387105000              5.5702e+10        No
#> 250:             12161487500              8.1058e+10        No
#>      security_term_day_month security_term_week_year  series soma_accepted
#>                       <char>                  <char>  <char>         <num>
#>   1:                11-Month                  9-Year  C-2036             0
#>   2:                 0-Month                  3-Year AP-2029             0
#>   3:                 0-Month                  7-Year  L-2033    6491882600
#>   4:                 0-Month                  5-Year  Z-2031   10327995000
#>   5:                 0-Month                  2-Year BC-2028   10180452200
#>  ---                                                                      
#> 246:                 0-Month                  7-Year  J-2028   11133409500
#> 247:                11-Month                  9-Year  B-2031    2355050000
#> 248:                 0-Month                  7-Year  H-2028   13431124300
#> 249:                 0-Month                 10-Year  B-2031   14873930700
#> 250:                 0-Month                  7-Year  G-2028    8379799900
#>      soma_holdings soma_included soma_tendered spread
#>              <num>        <char>         <num>  <num>
#>   1:    0.0000e+00            No             0     NA
#>   2:    0.0000e+00            No             0     NA
#>   3:    2.9361e+10            No    6491882600     NA
#>   4:    2.9361e+10            No   10327995000     NA
#>   5:    2.9361e+10            No   10180452200     NA
#>  ---                                                 
#> 246:    3.9506e+10            No   11133409500     NA
#> 247:    7.4370e+09            No    2355050000     NA
#> 248:    4.5493e+10            No   13431124300     NA
#> 249:    4.5710e+10            No   14873930700     NA
#> 250:    3.1762e+10            No    8379799900     NA
#>      standard_interest_payment_per1000 strippable    term
#>                                  <num>     <char>  <char>
#>   1:                            21.875        Yes 10-Year
#>   2:                            20.625        Yes  3-Year
#>   3:                            21.250        Yes  7-Year
#>   4:                            20.625        Yes  5-Year
#>   5:                            20.000        Yes  2-Year
#>  ---                                                     
#> 246:                             6.250        Yes  7-Year
#> 247:                             5.625        Yes 10-Year
#> 248:                             5.625        Yes  7-Year
#> 249:                             5.625        Yes 10-Year
#> 250:                             3.750        Yes  7-Year
#>      tiin_conversion_factor_per1000   tips total_accepted total_tendered
#>                               <num> <char>          <num>          <num>
#>   1:                             NA     No    39000001000   100044669600
#>   2:                             NA     No    58000019200   153391026100
#>   3:                             NA     No    50491888800   117286194700
#>   4:                             NA     No    80328049000   174152552000
#>   5:                             NA     No    79180503700   192251635700
#>  ---                                                                    
#> 246:                             NA     No    73133436200   149606196200
#> 247:                             NA     No    40355061500    92933971300
#> 248:                             NA     No    75431149700   140207159700
#> 249:                             NA     No    55873973800   111858824600
#> 250:                             NA     No    70379843400   151283816400
#>      treasury_retail_accepted treasury_retail_tenders_accepted   type
#>                         <num>                           <char> <char>
#>   1:                 38560800                              Yes   Note
#>   2:                 90506100                              Yes   Note
#>   3:                 30164100                              Yes   Note
#>   4:                 54310500                              Yes   Note
#>   5:                293067500                              Yes   Note
#>  ---                                                                 
#> 246:                 49197700                              Yes   Note
#> 247:                 10734300                              Yes   Note
#> 248:                  2683400                              Yes   Note
#> 249:                 13001900                              Yes   Note
#> 250:                  4570500                              Yes   Note
#>      unadjusted_accrued_interest_per1000 unadjusted_price   updated_timestamp
#>                                    <num>            <num>              <char>
#>   1:                                  NA               NA 2026-06-10T13:03:58
#>   2:                                  NA               NA 2026-06-09T13:04:05
#>   3:                                  NA               NA 2026-05-28T13:04:03
#>   4:                                  NA               NA 2026-05-27T13:04:04
#>   5:                                  NA               NA 2026-05-26T13:04:09
#>  ---                                                                         
#> 246:                                  NA               NA 2021-03-25T13:03:26
#> 247:                                  NA               NA 2021-03-10T13:03:21
#> 248:                                  NA               NA 2021-02-25T13:03:29
#> 249:                                  NA               NA 2021-02-10T13:03:19
#> 250:                                  NA               NA 2021-01-28T13:03:40
#>      xml_filename_announcement xml_filename_competitive_results
#>                         <char>                           <char>
#>   1:          A_20260604_2.xml                 R_20260610_2.xml
#>   2:          A_20260604_4.xml                 R_20260609_3.xml
#>   3:          A_20260521_4.xml                 R_20260528_3.xml
#>   4:          A_20260521_7.xml                 R_20260527_3.xml
#>   5:          A_20260521_6.xml                 R_20260526_4.xml
#>  ---                                                           
#> 246:          A_20210318_4.xml                 R_20210325_3.xml
#> 247:          A_20210304_6.xml                 R_20210310_2.xml
#> 248:          A_20210218_4.xml                 R_20210225_3.xml
#> 249:          A_20210203_2.xml                 R_20210210_3.xml
#> 250:          A_20210121_6.xml                 R_20210128_3.xml
#>      xml_filename_special_announcement tint_cusip1 tint_cusip2
#>                                  <num>      <char>       <num>
#>   1:                                NA        <NA>          NA
#>   2:                                NA   912834ZZ4          NA
#>   3:                                NA   912834ZY7          NA
#>   4:                                NA        <NA>          NA
#>   5:                                NA        <NA>          NA
#>  ---                                                          
#> 246:                                NA        <NA>          NA
#> 247:                                NA        <NA>          NA
#> 248:                                NA        <NA>          NA
#> 249:                                NA        <NA>          NA
#> 250:                                NA        <NA>          NA
#>      tint_cusip1_due_date tint_cusip2_due_date
#>                    <Date>                <num>
#>   1:                 <NA>                   NA
#>   2:           2029-06-15                   NA
#>   3:           2033-05-31                   NA
#>   4:                 <NA>                   NA
#>   5:                 <NA>                   NA
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
#>   1: 912797RG4 2026-06-25          Bill        6-Week    2026-08-06
#>   2: 912797UH8 2026-06-25          Bill       13-Week    2026-09-24
#>   3: 912797TC1 2026-06-25          Bill       26-Week    2026-12-24
#>   4: 912797UQ8 2026-06-23          Bill        4-Week    2026-07-21
#>   5: 912797UU9 2026-06-23          Bill        8-Week    2026-08-18
#>  ---                                                               
#> 246: 912797NU7 2025-09-25          Bill       13-Week    2025-12-26
#> 247: 912797SC2 2025-09-25          Bill       26-Week    2026-03-26
#> 248: 912797RD1 2025-09-23          Bill        4-Week    2025-10-21
#> 249: 912797RP4 2025-09-23          Bill        8-Week    2025-11-18
#> 250: 912797SG3 2025-09-23          Bill       17-Week    2026-01-20
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
#>   1:        2026-06-18   2026-06-23              2026         NA
#>   2:        2026-06-18   2026-06-22              2026         NA
#>   3:        2026-06-18   2026-06-22              2026         NA
#>   4:        2026-06-16   2026-06-18              2026         NA
#>   5:        2026-06-16   2026-06-18              2026         NA
#>  ---                                                            
#> 246:        2025-09-18   2025-09-22              2025         NA
#> 247:        2025-09-18   2025-09-22              2025         NA
#> 248:        2025-09-16   2025-09-18              2025         NA
#> 249:        2025-09-16   2025-09-18              2025         NA
#> 250:        2025-09-16   2025-09-17              2025         NA
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
#>   2:                                NA             NA                 87.55
#>   3:                                NA             NA                 97.87
#>   4:                                NA             NA                 64.65
#>   5:                                NA             NA                 31.85
#>  ---                                                                       
#> 246:                                NA             NA                 33.51
#> 247:                                NA             NA                 21.38
#> 248:                                NA             NA                 24.14
#> 249:                                NA             NA                 62.10
#> 250:                                NA             NA                 32.31
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
#>   2:                        3.650                             NA
#>   3:                        3.805                             NA
#>   4:                        3.550                             NA
#>   5:                        3.590                             NA
#>  ---                                                            
#> 246:                        3.830                             NA
#> 247:                        3.675                             NA
#> 248:                        3.990                             NA
#> 249:                        3.930                             NA
#> 250:                        3.790                             NA
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
#>   2:         NA              NA               2.68        NA       NA
#>   3:         NA              NA               2.51        NA       NA
#>   4:         NA              NA               2.99        NA       NA
#>   5:         NA              NA               2.57        NA       NA
#>  ---                                                                 
#> 246:         NA              NA               3.33        NA       NA
#> 247:         NA              NA               3.01        NA       NA
#> 248:         NA              NA               2.71        NA       NA
#> 249:         NA              NA               2.76        NA       NA
#> 250:         NA              NA               3.06        NA       NA
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
#>   2:                    11:00 AM          87167597200                        3
#>   3:                    11:00 AM          75553221000                        3
#>   4:                    11:00 AM          62129655000                        3
#>   5:                    11:00 AM          72750295000                        3
#>  ---                                                                          
#> 246:                    11:00 AM          80020703900                        3
#> 247:                    11:00 AM          71577704200                        3
#> 248:                    11:00 AM          93723015300                        3
#> 249:                    11:00 AM          83661584000                        3
#> 250:                    11:00 AM          64453290000                        3
#>      competitive_tendered competitive_tenders_accepted corpus_cusip
#>                     <num>                       <char>        <num>
#>   1:                   NA                          Yes           NA
#>   2:         236816047200                          Yes           NA
#>   3:         191769576000                          Yes           NA
#>   4:         201702080000                          Yes           NA
#>   5:         190674820000                          Yes           NA
#>  ---                                                               
#> 246:         271133748600                          Yes           NA
#> 247:         218043642000                          Yes           NA
#> 248:         264394455500                          Yes           NA
#> 249:         233202894000                          Yes           NA
#> 250:         198226680000                          Yes           NA
#>      cpi_base_reference_period currently_outstanding direct_bidder_accepted
#>                          <num>                 <num>                  <num>
#>   1:                        NA           2.27914e+11                     NA
#>   2:                        NA           8.08100e+10             4237550000
#>   3:                        NA           5.22850e+10             3000000000
#>   4:                        NA           1.68182e+11             2014650000
#>   5:                        NA           6.95030e+10             2875000000
#>  ---                                                                       
#> 246:                        NA           1.19819e+11             5121616500
#> 247:                        NA                    NA             7205000000
#> 248:                        NA           1.45467e+11             6450000000
#> 249:                        NA           6.51930e+10             6276615000
#> 250:                        NA                    NA             4655000000
#>      direct_bidder_tendered
#>                       <num>
#>   1:                     NA
#>   2:             8.0500e+09
#>   3:             6.1750e+09
#>   4:             5.0000e+09
#>   5:             5.5750e+09
#>  ---                       
#> 246:             1.3265e+10
#> 247:             1.3105e+10
#> 248:             1.3550e+10
#> 249:             1.1875e+10
#> 250:             9.2550e+09
#>      estimated_amount_of_publicly_held_maturing_securities_by_type
#>                                                              <num>
#>   1:                                                   2.43102e+11
#>   2:                                                   2.43102e+11
#>   3:                                                   2.43102e+11
#>   4:                                                   2.35841e+11
#>   5:                                                   2.35841e+11
#>  ---                                                              
#> 246:                                                   2.28993e+11
#> 247:                                                   2.28993e+11
#> 248:                                                   3.04982e+11
#> 249:                                                   3.04982e+11
#> 250:                                                   3.04982e+11
#>      fima_included fima_noncompetitive_accepted fima_noncompetitive_tendered
#>             <char>                        <num>                        <num>
#>   1:           Yes                           NA                           NA
#>   2:           Yes                     1.00e+08                     1.00e+08
#>   3:           Yes                     2.84e+07                     2.84e+07
#>   4:           Yes                     2.00e+09                     2.00e+09
#>   5:           Yes                     1.00e+09                     1.00e+09
#>  ---                                                                        
#> 246:           Yes                     7.50e+07                     7.50e+07
#> 247:           Yes                     0.00e+00                     0.00e+00
#> 248:           Yes                     0.00e+00                     0.00e+00
#> 249:           Yes                     0.00e+00                     0.00e+00
#> 250:           Yes                     0.00e+00                     0.00e+00
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
#>   2:              3.695                3.782   99.06599                   NA
#>   3:              3.840                3.970   98.05867                   NA
#>   4:              3.580                3.640   99.72156                   NA
#>   5:              3.640                3.712   99.43378                   NA
#>  ---                                                                        
#> 246:              3.860                3.953   99.01356                   NA
#> 247:              3.705                3.828   98.12692                   NA
#> 248:              4.040                4.109   99.68578                   NA
#> 249:              3.965                4.045   99.38322                   NA
#> 250:              3.815                3.917   98.73893                   NA
#>      high_yield index_ratio_on_issue_date indirect_bidder_accepted
#>           <num>                     <num>                    <num>
#>   1:         NA                        NA                       NA
#>   2:         NA                        NA              52087422200
#>   3:         NA                        NA              40072576000
#>   4:         NA                        NA              44917130000
#>   5:         NA                        NA              37459070000
#>  ---                                                              
#> 246:         NA                        NA              59411973400
#> 247:         NA                        NA              46803564200
#> 248:         NA                        NA              56803115300
#> 249:         NA                        NA              48753319000
#> 250:         NA                        NA              39098655000
#>      indirect_bidder_tendered interest_payment_frequency low_discount_rate
#>                         <num>                     <char>             <num>
#>   1:                       NA                       None                NA
#>   2:              63042047200                       None             3.595
#>   3:              43322576000                       None             3.720
#>   4:              57882080000                       None             3.490
#>   5:              45359820000                       None             3.510
#>  ---                                                                      
#> 246:              96808748600                       None             3.780
#> 247:              59068642000                       None             3.620
#> 248:              69894455500                       None             3.930
#> 249:              62466894000                       None             3.850
#> 250:              55846680000                       None             3.710
#>      low_investment_rate low_price low_discount_margin low_yield maturing_date
#>                    <num>     <num>               <num>     <num>        <Date>
#>   1:                  NA        NA                  NA        NA    2026-06-25
#>   2:                  NA        NA                  NA        NA    2026-06-25
#>   3:                  NA        NA                  NA        NA    2026-06-25
#>   4:                  NA        NA                  NA        NA    2026-06-23
#>   5:                  NA        NA                  NA        NA    2026-06-23
#>  ---                                                                          
#> 246:                  NA        NA                  NA        NA    2025-09-25
#> 247:                  NA        NA                  NA        NA    2025-09-25
#> 248:                  NA        NA                  NA        NA    2025-09-23
#> 249:                  NA        NA                  NA        NA    2025-09-23
#> 250:                  NA        NA                  NA        NA    2025-09-23
#>      maximum_competitive_award maximum_noncompetitive_award maximum_single_bid
#>                          <num>                        <num>              <num>
#>   1:                 2.275e+10                        1e+07          2.275e+10
#>   2:                 3.115e+10                        1e+07          3.115e+10
#>   3:                 2.695e+10                        1e+07          2.695e+10
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
#>   1:                100             7.26e+10               2.275e+10
#>   2:                100             2.67e+10               3.115e+10
#>   3:                100             1.61e+10               2.695e+10
#>   4:                100             5.46e+10               2.450e+10
#>   5:                100             2.09e+10               2.625e+10
#>  ---                                                                
#> 246:                100             4.06e+10               2.870e+10
#> 247:                100             0.00e+00               2.555e+10
#> 248:                100             5.08e+10               3.500e+10
#> 249:                100             2.28e+10               2.975e+10
#> 250:                100             0.00e+00               2.275e+10
#>      noncompetitive_accepted noncompetitive_tenders_accepted offering_amount
#>                        <num>                          <char>           <num>
#>   1:                      NA                             Yes         6.5e+10
#>   2:              1732663700                             Yes         8.9e+10
#>   3:              1418582200                             Yes         7.7e+10
#>   4:              5870628400                             Yes         7.0e+10
#>   5:              1250072800                             Yes         7.5e+10
#>  ---                                                                        
#> 246:              1905090100                             Yes         8.2e+10
#> 247:              1422750700                             Yes         7.3e+10
#> 248:              6277751700                             Yes         1.0e+11
#> 249:              1338979500                             Yes         8.5e+10
#> 250:               546877400                             Yes         6.5e+10
#>      original_cusip original_dated_date original_issue_date
#>               <num>               <num>              <Date>
#>   1:             NA                  NA          2025-08-07
#>   2:             NA                  NA          2026-03-26
#>   3:             NA                  NA          2025-12-26
#>   4:             NA                  NA          2026-03-24
#>   5:             NA                  NA          2026-04-21
#>  ---                                                       
#> 246:             NA                  NA          2024-12-26
#> 247:             NA                  NA                <NA>
#> 248:             NA                  NA          2025-06-24
#> 249:             NA                  NA          2025-07-22
#> 250:             NA                  NA                <NA>
#>      original_security_term pdf_filename_announcement
#>                      <char>                    <char>
#>   1:                52-Week          A_20260618_1.pdf
#>   2:                26-Week          A_20260618_7.pdf
#>   3:                52-Week          A_20260618_3.pdf
#>   4:                17-Week          A_20260616_2.pdf
#>   5:                17-Week          A_20260616_3.pdf
#>  ---                                                 
#> 246:                52-Week          A_20250918_2.pdf
#> 247:                26-Week          A_20250918_7.pdf
#> 248:                17-Week          A_20250916_3.pdf
#> 249:                17-Week          A_20250916_2.pdf
#> 250:                17-Week          A_20250916_1.pdf
#>      pdf_filename_competitive_results pdf_filename_noncompetitive_results
#>                                <char>                              <char>
#>   1:                             <NA>                                <NA>
#>   2:                 R_20260622_2.pdf                  NCR_20260622_2.pdf
#>   3:                 R_20260622_1.pdf                  NCR_20260622_1.pdf
#>   4:                 R_20260618_2.pdf                  NCR_20260618_2.pdf
#>   5:                 R_20260618_1.pdf                  NCR_20260618_1.pdf
#>  ---                                                                     
#> 246:                 R_20250922_1.pdf                  NCR_20250922_2.pdf
#> 247:                 R_20250922_2.pdf                  NCR_20250922_1.pdf
#> 248:                 R_20250918_1.pdf                  NCR_20250918_2.pdf
#> 249:                 R_20250918_2.pdf                  NCR_20250918_1.pdf
#> 250:                 R_20250917_1.pdf                  NCR_20250917_1.pdf
#>      pdf_filename_special_announcement price_per100 primary_dealer_accepted
#>                                 <char>        <num>                   <num>
#>   1:                              <NA>           NA                      NA
#>   2:                              <NA>     99.06599             30842625000
#>   3:                              <NA>     98.05867             32480645000
#>   4:                              <NA>     99.72156             15197875000
#>   5:                              <NA>     99.43378             32416225000
#>  ---                                                                       
#> 246:                              <NA>     99.01356             15487114000
#> 247:                              <NA>     98.12692             17569140000
#> 248:                              <NA>     99.68578             30469900000
#> 249:                              <NA>     99.38322             28631650000
#> 250:                              <NA>     98.73893             20699635000
#>      primary_dealer_tendered reopening security_term_day_month
#>                        <num>    <char>                  <char>
#>   1:                      NA       Yes                  42-Day
#>   2:             1.65724e+11       Yes                  91-Day
#>   3:             1.42272e+11       Yes                 182-Day
#>   4:             1.38820e+11       Yes                  28-Day
#>   5:             1.39740e+11       Yes                  56-Day
#>  ---                                                          
#> 246:             1.61060e+11       Yes                  92-Day
#> 247:             1.45870e+11        No                 182-Day
#> 248:             1.80950e+11       Yes                  28-Day
#> 249:             1.58861e+11       Yes                  56-Day
#> 250:             1.33125e+11        No                 119-Day
#>      security_term_week_year series soma_accepted soma_holdings soma_included
#>                       <char>  <num>         <num>         <num>        <char>
#>   1:                  6-Week     NA            NA    1.5863e+10            No
#>   2:                 13-Week     NA    6111619200    1.5863e+10            No
#>   3:                 26-Week     NA    5287580700    1.5863e+10            No
#>   4:                  4-Week     NA    4332892700    1.3246e+10            No
#>   5:                  8-Week     NA    4642384900    1.3246e+10            No
#>  ---                                                                         
#> 246:                 13-Week     NA    3356537000    9.8240e+09            No
#> 247:                 26-Week     NA    2988136600    9.8240e+09            No
#> 248:                  4-Week     NA     282879300    7.0700e+08            No
#> 249:                  8-Week     NA     240447400    7.0700e+08            No
#> 250:                 17-Week     NA     183871500    7.0700e+08            No
#>      soma_tendered spread standard_interest_payment_per1000 strippable    term
#>              <num>  <num>                             <num>      <num>  <char>
#>   1:            NA     NA                                NA         NA  6-Week
#>   2:    6111619200     NA                                NA         NA 13-Week
#>   3:    5287580700     NA                                NA         NA 26-Week
#>   4:    4332892700     NA                                NA         NA  4-Week
#>   5:    4642384900     NA                                NA         NA  8-Week
#>  ---                                                                          
#> 246:    3356537000     NA                                NA         NA 13-Week
#> 247:    2988136600     NA                                NA         NA 26-Week
#> 248:     282879300     NA                                NA         NA  4-Week
#> 249:     240447400     NA                                NA         NA  8-Week
#> 250:     183871500     NA                                NA         NA 17-Week
#>      tiin_conversion_factor_per1000   tips total_accepted total_tendered
#>                               <num> <char>          <num>          <num>
#>   1:                             NA     No             NA             NA
#>   2:                             NA     No    95111880100   244760330100
#>   3:                             NA     No    82287783900   198504138900
#>   4:                             NA     No    74333176100   213905601100
#>   5:                             NA     No    79642752700   197567277700
#>  ---                                                                    
#> 246:                             NA     No    85357331000   276470375700
#> 247:                             NA     No    75988591500   222454529300
#> 248:                             NA     No   100283646300   270955086500
#> 249:                             NA     No    85241010900   234782320900
#> 250:                             NA     No    65184038900   198957428900
#>      treasury_retail_accepted treasury_retail_tenders_accepted   type
#>                         <num>                           <char> <char>
#>   1:                       NA                              Yes   Bill
#>   2:               1013461700                              Yes   Bill
#>   3:                723284400                              Yes   Bill
#>   4:               4699054900                              Yes   Bill
#>   5:                810738000                              Yes   Bill
#>  ---                                                                 
#> 246:               1096451100                              Yes   Bill
#> 247:                698529000                              Yes   Bill
#> 248:               5059509000                              Yes   Bill
#> 249:                952597200                              Yes   Bill
#> 250:                371079700                              Yes   Bill
#>      unadjusted_accrued_interest_per1000 unadjusted_price   updated_timestamp
#>                                    <num>            <num>              <char>
#>   1:                                  NA               NA 2026-06-18T11:02:34
#>   2:                                  NA               NA 2026-06-22T11:33:07
#>   3:                                  NA               NA 2026-06-22T11:33:06
#>   4:                                  NA               NA 2026-06-18T11:34:03
#>   5:                                  NA               NA 2026-06-18T11:34:04
#>  ---                                                                         
#> 246:                                  NA               NA 2025-09-22T11:34:49
#> 247:                                  NA               NA 2025-09-22T11:34:48
#> 248:                                  NA               NA 2025-09-18T11:34:56
#> 249:                                  NA               NA 2025-09-18T11:34:57
#> 250:                                  NA               NA 2025-09-17T11:34:46
#>      xml_filename_announcement xml_filename_competitive_results
#>                         <char>                           <char>
#>   1:          A_20260618_1.xml                             <NA>
#>   2:          A_20260618_7.xml                 R_20260622_2.xml
#>   3:          A_20260618_3.xml                 R_20260622_1.xml
#>   4:          A_20260616_2.xml                 R_20260618_2.xml
#>   5:          A_20260616_3.xml                 R_20260618_1.xml
#>  ---                                                           
#> 246:          A_20250918_2.xml                 R_20250922_1.xml
#> 247:          A_20250918_7.xml                 R_20250922_2.xml
#> 248:          A_20250916_3.xml                 R_20250918_1.xml
#> 249:          A_20250916_2.xml                 R_20250918_2.xml
#> 250:          A_20250916_1.xml                 R_20250917_1.xml
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
#>         cusip issue_date security_type   security_term maturity_date
#>        <char>     <Date>        <char>          <char>        <Date>
#>  1: 912797RG4 2026-06-25          Bill          6-Week    2026-08-06
#>  2: 91282CQY0 2026-06-30          Note          2-Year    2028-06-30
#>  3: 91282CQM6 2026-06-26          Note 1-Year 10-Month    2028-04-30
#>  4: 91282CQX2 2026-06-30          Note          5-Year    2031-06-30
#>  5: 91282CQW4 2026-06-30          Note          7-Year    2033-06-30
#>  6: 912797VN4 2026-06-30          Bill         17-Week          <NA>
#>  7: 912797UR6 2026-06-30          Bill          4-Week          <NA>
#>  8: 912797UV7 2026-06-30          Bill          8-Week          <NA>
#>  9: 912797SA6 2026-07-02          Bill         13-Week          <NA>
#> 10: 912797VJ3 2026-07-02          Bill         26-Week          <NA>
#> 11: 912797TW7 2026-07-02          Bill          6-Week          <NA>
#>     interest_rate ref_cpi_on_issue_date ref_cpi_on_dated_date announcement_date
#>             <num>                 <num>                 <num>            <Date>
#>  1:            NA                    NA                    NA        2026-06-18
#>  2:            NA                    NA                    NA        2026-06-18
#>  3:            NA                    NA                    NA        2026-06-18
#>  4:            NA                    NA                    NA        2026-06-18
#>  5:            NA                    NA                    NA        2026-06-18
#>  6:            NA                    NA                    NA        2026-06-23
#>  7:            NA                    NA                    NA        2026-06-23
#>  8:            NA                    NA                    NA        2026-06-23
#>  9:            NA                    NA                    NA        2026-06-25
#> 10:            NA                    NA                    NA        2026-06-25
#> 11:            NA                    NA                    NA        2026-06-25
#>     auction_date auction_date_year dated_date accrued_interest_per1000
#>           <Date>             <num>     <Date>                    <num>
#>  1:   2026-06-23              2026       <NA>                       NA
#>  2:   2026-06-23              2026 2026-06-30                       NA
#>  3:   2026-06-24              2026 2026-04-30                       NA
#>  4:   2026-06-24              2026 2026-06-30                       NA
#>  5:   2026-06-25              2026 2026-06-30                       NA
#>  6:   2026-06-24              2026       <NA>                       NA
#>  7:   2026-06-25              2026       <NA>                       NA
#>  8:   2026-06-25              2026       <NA>                       NA
#>  9:   2026-06-29              2026       <NA>                       NA
#> 10:   2026-06-29              2026       <NA>                       NA
#> 11:   2026-06-30              2026       <NA>                       NA
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
#>  2:                    NA                              2              NA
#>  3:                    NA                              2              NA
#>  4:                    NA                              2              NA
#>  5:                    NA                              2              NA
#>  6:                    NA                             NA              NA
#>  7:                    NA                             NA              NA
#>  8:                    NA                             NA              NA
#>  9:                    NA                             NA              NA
#> 10:                    NA                             NA              NA
#> 11:                    NA                             NA              NA
#>     auction_format average_median_discount_rate average_median_investment_rate
#>             <char>                        <num>                          <num>
#>  1:   Single-Price                           NA                             NA
#>  2:   Single-Price                           NA                             NA
#>  3:   Single-Price                           NA                             NA
#>  4:   Single-Price                           NA                             NA
#>  5:   Single-Price                           NA                             NA
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
#>         <char>          <Date>              <num>     <num>   <char>
#>  1:       <NA>            <NA>                 NA        NA     <NA>
#>  2:         No            <NA>                 NA        NA       No
#>  3:        Yes      2026-04-30                 NA        NA       No
#>  4:         No            <NA>                 NA        NA       No
#>  5:         No            <NA>                 NA        NA       No
#>  6:       <NA>            <NA>                 NA        NA     <NA>
#>  7:       <NA>            <NA>                 NA        NA     <NA>
#>  8:       <NA>            <NA>                 NA        NA     <NA>
#>  9:       <NA>            <NA>                 NA        NA     <NA>
#> 10:       <NA>            <NA>                 NA        NA     <NA>
#> 11:       <NA>            <NA>                 NA        NA     <NA>
#>     called_date cash_management_bill_cmb closing_time_competitive
#>           <num>                   <char>                   <char>
#>  1:          NA                       No                 11:30 AM
#>  2:          NA                       No                 01:00 PM
#>  3:          NA                       No                 11:30 AM
#>  4:          NA                       No                 01:00 PM
#>  5:          NA                       No                 01:00 PM
#>  6:          NA                       No                     <NA>
#>  7:          NA                       No                     <NA>
#>  8:          NA                       No                     <NA>
#>  9:          NA                       No                     <NA>
#> 10:          NA                       No                     <NA>
#> 11:          NA                       No                     <NA>
#>     closing_time_noncompetitive competitive_accepted competitive_bid_decimals
#>                          <char>                <num>                    <num>
#>  1:                    11:00 AM                   NA                        3
#>  2:                    12:00 PM                   NA                        3
#>  3:                    11:00 AM                   NA                        3
#>  4:                    12:00 PM                   NA                        3
#>  5:                    12:00 PM                   NA                        3
#>  6:                        <NA>                   NA                       NA
#>  7:                        <NA>                   NA                       NA
#>  8:                        <NA>                   NA                       NA
#>  9:                        <NA>                   NA                       NA
#> 10:                        <NA>                   NA                       NA
#> 11:                        <NA>                   NA                       NA
#>     competitive_tendered competitive_tenders_accepted corpus_cusip
#>                    <num>                       <char>       <char>
#>  1:                   NA                          Yes         <NA>
#>  2:                   NA                          Yes    912821UQ6
#>  3:                   NA                          Yes         <NA>
#>  4:                   NA                          Yes    912821UR4
#>  5:                   NA                          Yes    912821US2
#>  6:                   NA                         <NA>         <NA>
#>  7:                   NA                         <NA>         <NA>
#>  8:                   NA                         <NA>         <NA>
#>  9:                   NA                         <NA>         <NA>
#> 10:                   NA                         <NA>         <NA>
#> 11:                   NA                         <NA>         <NA>
#>     cpi_base_reference_period currently_outstanding direct_bidder_accepted
#>                         <num>                 <num>                  <num>
#>  1:                        NA           2.27914e+11                     NA
#>  2:                        NA                    NA                     NA
#>  3:                        NA           6.17710e+10                     NA
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
#>  1:                                                   2.43102e+11           Yes
#>  2:                                                   1.42819e+11           Yes
#>  3:                                                   0.00000e+00           Yes
#>  4:                                                   1.42819e+11           Yes
#>  5:                                                   1.42819e+11           Yes
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
#>                    <char>                      <Date>        <char>
#>  1:                  <NA>                        <NA>            No
#>  2:                Normal                  2026-12-31            No
#>  3:                Normal                  2026-07-31           Yes
#>  4:                Normal                  2026-12-31            No
#>  5:                Normal                  2026-12-31            No
#>  6:                  <NA>                        <NA>            No
#>  7:                  <NA>                        <NA>            No
#>  8:                  <NA>                        <NA>            No
#>  9:                  <NA>                        <NA>            No
#> 10:                  <NA>                        <NA>            No
#> 11:                  <NA>                        <NA>            No
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
#>  2:                       NA                Semi-Annual                NA
#>  3:                       NA                  Quarterly                NA
#>  4:                       NA                Semi-Annual                NA
#>  5:                       NA                Semi-Annual                NA
#>  6:                       NA                       <NA>                NA
#>  7:                       NA                       <NA>                NA
#>  8:                       NA                       <NA>                NA
#>  9:                       NA                       <NA>                NA
#> 10:                       NA                       <NA>                NA
#> 11:                       NA                       <NA>                NA
#>     low_investment_rate low_price low_discount_margin low_yield maturing_date
#>                   <num>     <num>               <num>     <num>        <Date>
#>  1:                  NA        NA                  NA        NA    2026-06-25
#>  2:                  NA        NA                  NA        NA    2026-06-30
#>  3:                  NA        NA                  NA        NA    2026-06-26
#>  4:                  NA        NA                  NA        NA    2026-06-30
#>  5:                  NA        NA                  NA        NA    2026-06-30
#>  6:                  NA        NA                  NA        NA          <NA>
#>  7:                  NA        NA                  NA        NA          <NA>
#>  8:                  NA        NA                  NA        NA          <NA>
#>  9:                  NA        NA                  NA        NA          <NA>
#> 10:                  NA        NA                  NA        NA          <NA>
#> 11:                  NA        NA                  NA        NA          <NA>
#>     maximum_competitive_award maximum_noncompetitive_award maximum_single_bid
#>                         <num>                        <num>              <num>
#>  1:                 2.275e+10                        1e+07          2.275e+10
#>  2:                 2.415e+10                        1e+07          2.415e+10
#>  3:                 9.800e+09                        1e+07          9.800e+09
#>  4:                 2.450e+10                        1e+07          2.450e+10
#>  5:                 1.540e+10                        1e+07          1.540e+10
#>  6:                        NA                           NA                 NA
#>  7:                        NA                           NA                 NA
#>  8:                        NA                           NA                 NA
#>  9:                        NA                           NA                 NA
#> 10:                        NA                           NA                 NA
#> 11:                        NA                           NA                 NA
#>     minimum_bid_amount minimum_strip_amount minimum_to_issue multiples_to_bid
#>                  <num>                <num>            <num>            <num>
#>  1:                100                   NA              100              100
#>  2:                100                  100              100              100
#>  3:                100                   NA              100              100
#>  4:                100                  100              100              100
#>  5:                100                  100              100              100
#>  6:                 NA                   NA               NA               NA
#>  7:                 NA                   NA               NA               NA
#>  8:                 NA                   NA               NA               NA
#>  9:                 NA                   NA               NA               NA
#> 10:                 NA                   NA               NA               NA
#> 11:                 NA                   NA               NA               NA
#>     multiples_to_issue nlp_exclusion_amount nlp_reporting_threshold
#>                  <num>                <num>                   <num>
#>  1:                100             7.26e+10               2.275e+10
#>  2:                100             0.00e+00               2.415e+10
#>  3:                100             2.03e+10               9.800e+09
#>  4:                100             0.00e+00               2.450e+10
#>  5:                100             0.00e+00               1.540e+10
#>  6:                 NA                   NA                      NA
#>  7:                 NA                   NA                      NA
#>  8:                 NA                   NA                      NA
#>  9:                 NA                   NA                      NA
#> 10:                 NA                   NA                      NA
#> 11:                 NA                   NA                      NA
#>     noncompetitive_accepted noncompetitive_tenders_accepted offering_amount
#>                       <num>                          <char>           <num>
#>  1:                      NA                             Yes         6.5e+10
#>  2:                      NA                             Yes         6.9e+10
#>  3:                      NA                             Yes         2.8e+10
#>  4:                      NA                             Yes         7.0e+10
#>  5:                      NA                             Yes         4.4e+10
#>  6:                      NA                            <NA>              NA
#>  7:                      NA                            <NA>              NA
#>  8:                      NA                            <NA>              NA
#>  9:                      NA                            <NA>              NA
#> 10:                      NA                            <NA>              NA
#> 11:                      NA                            <NA>              NA
#>     original_cusip original_dated_date original_issue_date
#>              <num>              <Date>              <Date>
#>  1:             NA                <NA>          2025-08-07
#>  2:             NA                <NA>                <NA>
#>  3:             NA          2026-04-30          2026-04-30
#>  4:             NA                <NA>                <NA>
#>  5:             NA                <NA>                <NA>
#>  6:             NA                <NA>                <NA>
#>  7:             NA                <NA>                <NA>
#>  8:             NA                <NA>                <NA>
#>  9:             NA                <NA>                <NA>
#> 10:             NA                <NA>                <NA>
#> 11:             NA                <NA>                <NA>
#>     original_security_term pdf_filename_announcement
#>                     <char>                    <char>
#>  1:                52-Week          A_20260618_1.pdf
#>  2:                 2-Year          A_20260618_5.pdf
#>  3:                 2-Year          A_20260618_4.pdf
#>  4:                 5-Year          A_20260618_2.pdf
#>  5:                 7-Year          A_20260618_6.pdf
#>  6:                17-Week                      <NA>
#>  7:                17-Week                      <NA>
#>  8:                17-Week                      <NA>
#>  9:                52-Week                      <NA>
#> 10:                26-Week                      <NA>
#> 11:                26-Week                      <NA>
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
#>                                <char>        <num>                   <num>
#>  1:                              <NA>           NA                      NA
#>  2:                SPL_20260618_1.pdf           NA                      NA
#>  3:                              <NA>           NA                      NA
#>  4:                SPL_20260618_2.pdf           NA                      NA
#>  5:                              <NA>           NA                      NA
#>  6:                              <NA>           NA                      NA
#>  7:                              <NA>           NA                      NA
#>  8:                              <NA>           NA                      NA
#>  9:                              <NA>           NA                      NA
#> 10:                              <NA>           NA                      NA
#> 11:                              <NA>           NA                      NA
#>     primary_dealer_tendered reopening security_term_day_month
#>                       <num>    <char>                  <char>
#>  1:                      NA       Yes                  42-Day
#>  2:                      NA        No                 0-Month
#>  3:                      NA       Yes                10-Month
#>  4:                      NA        No                 0-Month
#>  5:                      NA        No                 0-Month
#>  6:                      NA        No                 119-Day
#>  7:                      NA       Yes                  28-Day
#>  8:                      NA       Yes                  56-Day
#>  9:                      NA       Yes                  91-Day
#> 10:                      NA        No                 182-Day
#> 11:                      NA       Yes                  42-Day
#>     security_term_week_year  series soma_accepted soma_holdings soma_included
#>                      <char>  <char>         <num>         <num>        <char>
#>  1:                  6-Week    <NA>            NA    1.5863e+10            No
#>  2:                  2-Year BD-2028            NA    3.0986e+10            No
#>  3:                  1-Year BB-2028            NA    0.0000e+00            No
#>  4:                  5-Year AA-2031            NA    3.0986e+10            No
#>  5:                  7-Year  M-2033            NA    3.0986e+10            No
#>  6:                 17-Week    <NA>            NA            NA          <NA>
#>  7:                  4-Week    <NA>            NA            NA          <NA>
#>  8:                  8-Week    <NA>            NA            NA          <NA>
#>  9:                 13-Week    <NA>            NA            NA          <NA>
#> 10:                 26-Week    <NA>            NA            NA          <NA>
#> 11:                  6-Week    <NA>            NA            NA          <NA>
#>     soma_tendered spread standard_interest_payment_per1000 strippable    term
#>             <num>  <num>                             <num>     <char>  <char>
#>  1:            NA     NA                                NA       <NA>  6-Week
#>  2:            NA     NA                                NA        Yes  2-Year
#>  3:            NA  0.103                                NA         No  2-Year
#>  4:            NA     NA                                NA        Yes  5-Year
#>  5:            NA     NA                                NA        Yes  7-Year
#>  6:            NA     NA                                NA       <NA> 17-Week
#>  7:            NA     NA                                NA       <NA>  4-Week
#>  8:            NA     NA                                NA       <NA>  8-Week
#>  9:            NA     NA                                NA       <NA> 13-Week
#> 10:            NA     NA                                NA       <NA> 26-Week
#> 11:            NA     NA                                NA       <NA>  6-Week
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
#>  2:                       NA                              Yes   Note
#>  3:                       NA                              Yes    FRN
#>  4:                       NA                              Yes   Note
#>  5:                       NA                              Yes   Note
#>  6:                       NA                             <NA>   Bill
#>  7:                       NA                             <NA>   Bill
#>  8:                       NA                             <NA>   Bill
#>  9:                       NA                             <NA>   Bill
#> 10:                       NA                             <NA>   Bill
#> 11:                       NA                             <NA>   Bill
#>     unadjusted_accrued_interest_per1000 unadjusted_price   updated_timestamp
#>                                   <num>            <num>              <char>
#>  1:                                  NA               NA 2026-06-18T11:02:34
#>  2:                                  NA               NA 2026-06-18T11:04:51
#>  3:                                  NA               NA 2026-06-18T11:02:19
#>  4:                                  NA               NA 2026-06-18T11:06:59
#>  5:                                  NA               NA 2026-06-18T11:02:16
#>  6:                                  NA               NA 2026-06-18T10:17:36
#>  7:                                  NA               NA 2026-06-18T10:17:38
#>  8:                                  NA               NA 2026-06-18T10:17:37
#>  9:                                  NA               NA 2026-06-18T10:17:34
#> 10:                                  NA               NA 2026-06-18T10:17:33
#> 11:                                  NA               NA 2026-06-18T10:17:35
#>     xml_filename_announcement xml_filename_competitive_results
#>                        <char>                            <num>
#>  1:          A_20260618_1.xml                               NA
#>  2:          A_20260618_5.xml                               NA
#>  3:          A_20260618_4.xml                               NA
#>  4:          A_20260618_2.xml                               NA
#>  5:          A_20260618_6.xml                               NA
#>  6:                      <NA>                               NA
#>  7:                      <NA>                               NA
#>  8:                      <NA>                               NA
#>  9:                      <NA>                               NA
#> 10:                      <NA>                               NA
#> 11:                      <NA>                               NA
#>     xml_filename_special_announcement tint_cusip1 tint_cusip2
#>                                 <num>      <char>       <num>
#>  1:                                NA        <NA>          NA
#>  2:                                NA        <NA>          NA
#>  3:                                NA        <NA>          NA
#>  4:                                NA        <NA>          NA
#>  5:                                NA   912834K80          NA
#>  6:                                NA        <NA>          NA
#>  7:                                NA        <NA>          NA
#>  8:                                NA        <NA>          NA
#>  9:                                NA        <NA>          NA
#> 10:                                NA        <NA>          NA
#> 11:                                NA        <NA>          NA
#>     tint_cusip1_due_date tint_cusip2_due_date
#>                   <Date>                <num>
#>  1:                 <NA>                   NA
#>  2:                 <NA>                   NA
#>  3:                 <NA>                   NA
#>  4:                 <NA>                   NA
#>  5:           2033-06-30                   NA
#>  6:                 <NA>                   NA
#>  7:                 <NA>                   NA
#>  8:                 <NA>                   NA
#>  9:                 <NA>                   NA
#> 10:                 <NA>                   NA
#> 11:                 <NA>                   NA
# }
```
