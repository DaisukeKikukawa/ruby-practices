require "date"
require 'optparse'

opt = OptionParser.new
params = ARGV.getopts("y:", "m:")
if params["y"] == nil
  year = Date.today.year
else
  year = params["y"].to_i
end

if params["m"] == nil
  month = Date.today.month
else
  month = params["m"].to_i
end

firstDate = Date.new(year,month,1)
lastDate = Date.new(year,month,-1)

month = firstDate.month
year = firstDate.year
print "#{month}月 #{year}年".center(20)

puts " "

wdays = ["日","月","火","水","木","金","土"].join(" ")
print wdays

puts " "

if firstDate.day == 1
  print " " * 3 * firstDate.wday
end

(firstDate..lastDate).each do |date|
  print "#{date.day.to_s.rjust(2)} "
  if date.wday == 6
    puts " "
  end
  if date.day == lastDate.day
    puts " "
  end
end
