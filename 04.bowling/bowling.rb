# frozen_string_literal: true

# 引数を受け取る
score = ARGV[0]
# 受け取った引数を配列で格納する
scores = score.split(',')
# 点数を格納するための配列を用意
shots = []
# 点数を一つずつ配列に格納していく

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

# 2つずつ区切って配列にスコアを格納する
frames = []
shots.each_slice(2) do |s|
  frames << s
end
# framesに二投ずつのスコアが配列で格納されている状態

# 1~9フレームの処理
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

# 10フレームの処理
point += if frames[9][0] == 10 && frames[10][0] == 10 # 連続ストライクの場合
           frames[9].sum + frames[10].sum + frames[11].sum
         elsif (frames[9][0] == 10 && frames[10][0] != 10) || frames[9].sum == 10 # スペアの場合
           frames[9].sum + frames[10].sum
         else
           frames[9].sum
         end
# 点数の出力
puts point
