# input validation works

    Code
      tr_auctions("foo")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "Bill", "Note", "Bond", "CMB", "TIPS", "FRN"

---

    Code
      tr_auctions(days = -1L)
    Condition
      Error in `securities()`:
      ! is_count(days, null_ok = TRUE) is not TRUE

---

    Code
      tr_announcements(days = 1.5)
    Condition
      Error in `securities()`:
      ! is_count(days, null_ok = TRUE) is not TRUE

---

    Code
      tr_upcoming("foo")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "Bill", "Note", "Bond", "CMB", "TIPS", "FRN"

