# tr_curve_rate works

    Code
      tr_curve_rate("trc", year = 1990L)
    Condition
      Error:
      ! `year` must be between 2003 and 2027 for "trc" data, not 1990
    Code
      tr_curve_rate("hqm", year = 2030L)
    Condition
      Error:
      ! `year` must be between 1984 and 2028 for "hqm" data, not 2030

