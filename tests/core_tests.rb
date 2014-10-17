require_relative '../lib/core.rb'
require "test/unit"

class TestCore < Test::Unit::TestCase
	def setup
		#FileUtils.mkdir 'output'
		FileUtils.rm_r  Dir.glob("output/*")
		

	end
	def create_file name
		File.open('output/'+name, "w+") { |file| file.write("boo!") }
	end
	def test_copy_file_action
		create_file "1.txt"
		SCI::Core.new 'test.yml'
		assert_equal 'boo!', File.read('output/2.txt')
	end
	def test_command_line_start
		create_file "1.txt"
		SCI::Core.new "CopyFile", "output/1.txt", "output/2.txt"
		
		assert_equal 'boo!', File.read('output/2.txt')
	end
	def test_zip_file_action
		create_file "1.txt"
		SCI::Core.new 'test.yml'
		assert File.exist? "output/2.zip"
	end
	def test_zip_file_action2
		create_file "1.txt"
		SCI::Core.new 'ZipFile', "output/1.txt", "output/../output/222.zip"
		assert File.exist? "output/222.zip"
	end
end