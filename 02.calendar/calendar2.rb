require "date"
require 'optparse'

opt = OptionParser.new
params = ARGV.getopts("y:", "m:")
if params["y"] == nil && params["m"] == nil
  year = Date.today.year
  month = Date.today.month
elsif params["y"] == nil
  year = Date.today.year
  month = params["m"].to_i
elsif params["m"] == nil
  year = params["y"].to_i
  month = Date.today.month
else
  year = params["y"].to_i
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
  if date.wday == 6 && date.day.to_s.length == 1
    print " "
    print date.day
    puts ""
  elsif date.wday == 6
    print date.day
    puts ""
  elsif date.day.to_s.length == 1
    print " "
    print date.day
    print " "
  else
    print date.day
    print " "
  end
end
