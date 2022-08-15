class LsFile
  attr_reader :data

  def initialize(data)
    @data = data
    @file_stat = File.stat(data)
  end

  def build_data
    [
      file_type + stat_mode,
      hard_links,
      owner_id,
      owner_group,
      file_size,
      creation_time,
    ].join(' ')
  end

  private

  def file_type
    convert_to_ftype(@file_stat.ftype)
  end

  def stat_mode
    @file_stat.mode.to_s(8)[-3, 3].split('').map { |f| convert_to_mode(f) }.join
  end

  def hard_links
    @file_stat.nlink.to_s.rjust(2)
  end

  def owner_id
    Etc.getpwuid(@file_stat.uid).name
  end

  def owner_group
    Etc.getgrgid(@file_stat.gid).name.rjust(6)
  end

  def file_size
    @file_stat.size.to_s.rjust(5)
  end

  def creation_time
    @file_stat.mtime.strftime('%_m %_d %R')
  end

  def convert_to_ftype(ftype)
    {
      file: '-',
      directory: 'd',
      characterSpecial: 'c',
      blockSpecial: 'b',
      fifo: 'p',
      link: 'l',
      socket: 's'
    }[ftype.to_sym]
  end

  def convert_to_mode(mode)
    {
      '7': 'rwx',
      '6': 'rw-',
      '5': 'r-x',
      '4': 'r--',
      '3': '-wx',
      '2': '-w-',
      '1': '--x',
      '0': '---'
    }[mode.to_sym]
  end

end
