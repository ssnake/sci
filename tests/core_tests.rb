require_relative '../lib/core.rb'
require "test/unit"

class TestCore < Test::Unit::TestCase
	def setup
		FileUtils.mkdir 'output' unless File.exists? 'output'
		FileUtils.rm_r  Dir.glob("output/*")
		

	end
	def create_file name, text='boo!'
		File.open('output/'+name, "w+") { |file| file.write(text) }
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
	def test_replace_str

		create_file 'repl_test.txt', '
#define VER_COMPANYNAME_STR         "Mackenzie Laboratories, Inc\0"
#define VER_PRODUCTNAME_STR         "MNSS\0"


#define VER_FILEVERSION             3,10,349,0
#define VER_FILEVERSION_STR         "3.10.349.0\0"
'
		SCI::Core.new 'ReplaceStr', 'output/repl_test.txt', '(#define.*?VER_COMPANYNAME_STR.*?")(.*?)(\\\\0")', '\1 aaaaa \3'
		new_text = File.read('output/repl_test.txt')
		
		assert new_text =~ /#define VER_COMPANYNAME_STR         " aaaaa \\0"/m
	end
end