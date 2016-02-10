#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative '../list_sorter'

describe ListSorter do
  before do
    @sorter = ListSorter.new
    @person_hash = {first_name: "Steve", last_name: "Smith", gender: "M", favorite_color: "Red", date_of_birth: "3/3/1985"}

    @people_from_pipe = [{first_name: "Steve", last_name: "Smith", gender: "M", favorite_color: "Red", date_of_birth: "3/3/1985"}, {first_name: "Radek", last_name: "Bonk", gender: "M", favorite_color: "Green", date_of_birth: "6/3/1975"}, {first_name: "Francis", last_name: "Bouillon", gender: "M", favorite_color: "Blue", date_of_birth: "6/3/1975"}]
    @people_from_comma = [{first_name: "Neil", last_name: "Abercrombie", gender: "M", favorite_color: "Tan", date_of_birth: "2/13/1943"}, {first_name: "Timothy", last_name: "Bishop", gender: "M", favorite_color: "Yellow", date_of_birth: "4/23/1967"}, {first_name: "Sue", last_name: "Kelly", gender: "F", favorite_color: "Pink", date_of_birth: "7/12/1959"}]
    @people_from_space = [{first_name: "Anna", last_name: "Kournikova", gender: "F", favorite_color: "Red", date_of_birth: "6/3/1975"}, {first_name: "Martina", last_name: "Hingis", gender: "F", favorite_color: "Green", date_of_birth: "4/2/1979"}, {first_name: "Monica", last_name: "Seles", gender: "F", favorite_color: "Black", date_of_birth: "12/2/1973"}]
    @all_people = @people_from_pipe + @people_from_comma + @people_from_space

    @output_one = "Hingis Martina Female 4/2/1979 Green\nKelly Sue Female 7/12/1959 Pink\nKournikova Anna Female 6/3/1975 Red\nSeles Monica Female 12/2/1973 Black\nAbercrombie Neil Male 2/13/1943 Tan\nBishop Timothy Male 4/23/1967 Yellow\nBonk Radek Male 6/3/1975 Green\nBouillon Francis Male 6/3/1975 Blue\nSmith Steve Male 3/3/1985 Red\n"
  
    @output_two = "Abercrombie Neil Male 2/13/1943 Tan\nKelly Sue Female 7/12/1959 Pink\nBishop Timothy Male 4/23/1967 Yellow\nSeles Monica Female 12/2/1973 Black\nBonk Radek Male 6/3/1975 Green\nBouillon Francis Male 6/3/1975 Blue\nKournikova Anna Female 6/3/1975 Red\nHingis Martina Female 4/2/1979 Green\nSmith Steve Male 3/3/1985 Red\n"

    @output_three = "Smith Steve Male 3/3/1985 Red\nSeles Monica Female 12/2/1973 Black\nKournikova Anna Female 6/3/1975 Red\nKelly Sue Female 7/12/1959 Pink\nHingis Martina Female 4/2/1979 Green\nBouillon Francis Male 6/3/1975 Blue\nBonk Radek Male 6/3/1975 Green\nBishop Timothy Male 4/23/1967 Yellow\nAbercrombie Neil Male 2/13/1943 Tan\n"
  end

  describe "output one" do
    it "should be sorted by gender (females before males) then by last name ascending." do
      expect(@sorter.output_one).to eql(@output_one)
    end
  end

  describe "output two" do
    it "should be sorted by birth date, ascending" do
      expect(@sorter.output_two).to eql(@output_two)
    end
  end

  describe "output three" do
    it "should be sorted by last name, descending" do
      expect(@sorter.output_three).to eql(@output_three)
    end
  end

  describe "iterate through folder" do
    it "should return an array of nine people hashes" do
      @sorter.iterate_through_folder
      expect(@sorter.people).to match_array(@all_people)
    end
  end

  describe "file_with_pipes" do
    describe "pipe_file" do
      it "should return an array of three people hashes" do
        @sorter.pipe_file(File.open("input_files/pipe.txt", "r"))
        expect(@sorter.people).to match_array(@people_from_pipe)
      end
    end

    describe "pipe_line" do
      it "should return a hash of a person's attributes" do
        person = @sorter.pipe_line('Smith | Steve | D | M | Red | 3-3-1985')
        expect(person).to eql(@person_hash)
      end
    end
  end

  describe "file_with_commas" do
    describe "comma_file" do
      it "should return an array of three people hashes" do
        @sorter.comma_file(File.open("input_files/comma.txt", "r"))
        expect(@sorter.people).to match_array(@people_from_comma)
      end
    end

    describe "comma_line" do
      it "should return a hash of a person's attributes" do
        person = @sorter.comma_line('Smith, Steve, Male, Red, 3/3/1985')
        expect(person).to eql(@person_hash)
      end
    end
  end

  describe "file_with_spaces" do
    describe "space_file" do
      it "should return an array of three people hashes" do
        @sorter.space_file(File.open("input_files/space.txt", "r"))
        expect(@sorter.people).to match_array(@people_from_space)
      end
    end

    describe "space_line" do
      it "should return a hash of a person's attributes" do
        person = @sorter.space_line('Smith Steve D M 3-3-1985 Red')
        expect(person).to eql(@person_hash)
      end
    end
  end
end


