require "date"
require 'optparse'

opt = OptionParser.new
params = ARGV.getopts("y:", "m:")
year = params["y"].to_i
month = params["m"].to_i
firstDate = Date.new(year,month,1)
lastDate = Date.new(year,month,-1)

month = firstDate.month
year = firstDate.year
print "#{month}月 #{year}年"

puts " "

wdays = ["日","月","火","水","木","金","土"]
(0..6).each {|i|
  print wdays[i]
  print " "
}

puts " "

if firstDate.day == 1 && firstDate.wday == 0
    print ""
  elsif firstDate.day == 1 && firstDate.wday == 1
    print "   "
  elsif firstDate.day == 1 && firstDate.wday == 2
    print "      "
  elsif firstDate.day == 1 && firstDate.wday == 3
    print "         "
  elsif firstDate.day == 1 && firstDate.wday == 4
    print "            "
  elsif firstDate.day == 1 && firstDate.wday == 5
    print "               "
  elsif firstDate.day == 1 && firstDate.wday == 6
      print "                  "
  else
end


(firstDate .. lastDate).each { |date|

  if date.wday == 6
    print date.day
    puts ""

  elsif date.day.to_s.length == 1
    print date.day
    print "  "

  else
    print date.day
    print " "
  end

}
