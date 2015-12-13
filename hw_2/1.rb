def is_leap_year?(year = 2015)
  (year%4==0 and year%100 != 0) or (year%400 == 0)
end

days_in_february = if is_leap_year?
                                29
                              else
                                28
                              end

months = { january: 31, february: days_in_february, march: 31, april: 30, may: 31, june: 30, july: 31, august: 31, september: 30, october: 31, november: 30, december: 31 }

months.each { |month, days| puts month if days == 30 }