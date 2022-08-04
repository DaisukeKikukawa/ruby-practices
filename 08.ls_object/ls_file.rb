# frozen_string_literal: true

class LsFile
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def file_type
    case data[0][0..2]
    when %w[1 0 0]
      data[0][0..2] = '-'
    when [' ', '4', '0']
      data[0][0..2] = 'd'
    end
  end

  def permission
    table = {
      '7' => 'rwx',
      '6' => 'rw-',
      '5' => 'r-x',
      '4' => 'r--',
      '3' => '-wx',
      '2' => '-w-',
      '1' => '--x',
      '0' => '---'
    }
    permission = ''
    data[0][1..3].each do |c|
      permission += table[c]
    end
    permission
  end
end
