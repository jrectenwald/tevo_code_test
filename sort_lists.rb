require_relative 'person'

class ListSorter

  def initialize
    iterate_through_folder
  end

  def output_one
  end

  def output_two
  end

  def output_three
  end

  def iterate_through_folder
    Dir.foreach('input_files') do |file|
      next unless File.extname(file) == ".txt"
      read_file(file)
    end
  end

  def read_file(file)
    File.open("input_files/#{file}", "r") do |file|
        case file
        when "pipe.txt" then pipe_file(file)
        when "comma.txt" then comma(file)
        when "space.txt" then sort_spaces(file)
        end
    end
  end

  def pipe_file(file)
    file.each_line do |line|
      puts line
    end
  end

  def comma_file(file)
    file.each_line do |line|
      puts line
    end
  end

  def space_file(file)
    file.each_line do |line|
      puts line
    end
  end

  def pipe_line(line)
    data = line.split(" | ")
    {first_name: data[1], last_name: data[0], middle_initial: data[2], gender: data[3], favorite_color: data[4], date_of_birth: data[5]}
  end

  def comma_line(line)
    data = line.split(", ")
    {first_name: data[1], last_name: data[0], middle_initial: nil, gender: data[2][0], favorite_color: data[3], date_of_birth: data[4].gsub("/","-")}
  end

  def space_line(line)
    data = line.split
    {first_name: data[1], last_name: data[0], middle_initial: data[2], gender: data[3], favorite_color: data[5], date_of_birth: data[4]}
  end

end