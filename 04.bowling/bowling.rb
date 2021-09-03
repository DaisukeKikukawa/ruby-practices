# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == "X"
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
frames = shots.each_slice(2).to_a

point = 0
frames[0..8].each_with_index do |frame, i|
  point += if frame[0] == 10 && frames[i + 1][0] == 10
             10 + 10 + frames[i + 2][0]
           elsif frame[0] == 10 && frames[i + 1][0] != 10
             10 + frames[i + 1].sum
           elsif frames[i][0] != 10 && frames[i].sum == 10
             10 + frames[i + 1][0]
           else
             frame.sum
           end
end

frames[9..11].each_with_index do |frame, i|
  point += frame.sum
end

puts point
