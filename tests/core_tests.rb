require_relative '../lib/core.rb'
require "test/unit"
class TestCore < Test::Unit::TestCase
	def setup
		
		File.delete "1.txt" if File.exist? "1.txt"
		File.delete "2.txt" if File.exist? "2.txt"

	end
	def create_file name
		File.open(name, "w+") { |file| file.write("boo!") }
	end
	def test_copy_file_action
		create_file "1.txt"
		SCI::Core.new 'test.yml'
		assert_equal 'boo!', File.read('2.txt')
	end
	def test_command_line_start
		create_file "1.txt"
		SCI::Core.new "CopyFile","1.txt", "2.txt"
		
		assert_equal 'boo!', File.read('2.txt')
	end
end