# input validation works

    Code
      tr_yield_curve("20225")
    Condition
      Error:
      ! `date` must be a single value in format yyyy or yyyymm
    Code
      tr_yield_curve("202213")
    Condition
      Error:
      ! `date` must have a month between 01 and 12

