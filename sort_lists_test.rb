#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'sort_lists'

class ListSortTest < Minitest::Test
  def setup
    @person_hash = {first_name: "Steve", last_name: "Smith", middle_initial: "D", gender: "M", favorite_color: "Red", date_of_birth: "3-3-1985"}
    @person_hash_no_middle_initial = {first_name: "Steve", last_name: "Smith", middle_initial: nil, gender: "M", favorite_color: "Red", date_of_birth: "3-3-1985"}
  end

  def test_pipe_line
    assert_equal @person_hash, ListSorter.new.pipe_line('Smith | Steve | D | M | Red | 3-3-1985')
  end

  def test_comma_line
    assert_equal @person_hash_no_middle_initial, ListSorter.new.comma_line('Smith, Steve, Male, Red, 3/3/1985')
  end

  def test_space_line
    assert_equal @person_hash, ListSorter.new.space_line('Smith Steve D M 3-3-1985 Red')
  end

  def test_read_file_with_pipes

  end

  def test_read_file_with_commas

  end

  def test_read_file_with_spaces

  end
end


