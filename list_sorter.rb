require 'pry'

class ListSorter

  def initialize
    @people = []
    @gender_hash = {F: "Female", M: "Male"}
  end

  def output_one
    iterate_through_folder
    women = people.select {|person| person[:gender] == "F"}.sort_by {|person| person[:last_name]}
    men = people.select {|person| person[:gender] == "M"}.sort_by {|person| person[:last_name]}
    combined = women.push(men).flatten
    combined.map {|person| person_hash_to_string(person)}.join
  end

  def output_two
    iterate_through_folder
    sorted_by_age = people.sort_by {|person| Date.strptime(person[:date_of_birth], '%m/%d/%Y')}
    sorted_by_age.map {|person| person_hash_to_string(person)}.join
  end

  def output_three
    iterate_through_folder
    sorted_by_name_descending = people.sort_by {|person| person[:last_name]}.reverse
    sorted_by_name_descending.map {|person| person_hash_to_string(person)}.join
  end

  def person_hash_to_string(person)
    "#{person[:last_name]} #{person[:first_name]} #{@gender_hash[person[:gender].to_sym]} #{person[:date_of_birth]} #{person[:favorite_color]}\n"
  end

  def iterate_through_folder
    @people = []
    Dir.foreach('input_files') do |file|
      next unless File.extname(file) == ".txt"
      read_file(file)
    end
  end

  def read_file(file_name)
    file = File.open("input_files/#{file_name}", "r")
    case file_name
    when "pipe.txt" then pipe_file(file)
    when "comma.txt" then comma_file(file)
    when "space.txt" then space_file(file)
    end
  end

  def pipe_file(file)
    file.each_line do |line|
      add_person(pipe_line(line))
    end
  end

  def comma_file(file)
    file.each_line do |line|
      add_person(comma_line(line))
    end
  end

  def space_file(file)
    file.each_line do |line|
      add_person(space_line(line))
    end
  end

  def pipe_line(line)
    data = line.split(" | ")
    {first_name: data[1], last_name: data[0], gender: data[3], favorite_color: data[4], date_of_birth: data[5].gsub("-","/").strip}
  end

  def comma_line(line)
    data = line.split(", ")
    {first_name: data[1], last_name: data[0], gender: data[2][0], favorite_color: data[3], date_of_birth: data[4].strip}
  end

  def space_line(line)
    data = line.split
    {first_name: data[1], last_name: data[0], gender: data[3], favorite_color: data[5], date_of_birth: data[4].gsub("-","/")}
  end

  def people
    @people
  end

  def add_person(person)
    @people << person
  end
end