# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  case s
  when 'X'
    shots << 10
    shots << 0
  when 'S'
    shots << 10
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames[0..8].each_with_index do |frame, i|
  point += if frame[0] == 10 && frames[i + 1][0] == 10 # 連続ストライクの場合
             10 + 10 + frames[i + 2][0]
           elsif frame[0] == 10 && frames[i + 1][0] != 10 # ストライクの場合
             10 + frames[i + 1].sum
           elsif frames[i][0] != 10 && frames[i].sum == 10 # スペアの場合
             10 + frames[i + 1][0]
           else
             frame.sum
           end
end

point += if frames[9][0] == 10 && frames[10][0] == 10
           frames[9].sum + frames[10].sum + frames[11].sum
         elsif (frames[9][0] == 10 && frames[10][0] != 10) || frames[9].sum == 10
           frames[9].sum + frames[10].sum
         else
           frames[9].sum
         end
puts point
