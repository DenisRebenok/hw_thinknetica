def is_leap_year?(year = 2015)
  (year%4==0 && year%100 != 0) || (year%400 == 0)
end

def days_in_february
  if is_leap_year?
    29
  else
    28
  end
end                                                                                                                   


print "Число: "
date = gets.to_i
print "Месяц: "
month = gets.to_i
print "Год: "
year = gets.to_i

monthes_days = [31, days_in_february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if month > 0
  total = 0
  monthes_days[0..month-2].each { |d| total += d }
  total += date
  puts "#{total} день в году."
else
  puts "Ошибка входных данных: Номер месяца должен быть не меньше 1!"
end