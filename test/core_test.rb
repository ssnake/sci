require_relative '../lib/core.rb'
require 'byebug'
require "minitest/autorun"

class CoreTest < Minitest::Test
	def setup
		Dir.chdir "#{File.dirname(__FILE__)}"
		
		FileUtils.mkdir 'output' unless File.exist? 'output'
		FileUtils.rm_r  Dir.glob("output/*")
		

	end
	def create_file name, text='boo!'

		File.open('output/'+name, "w+") { |file| file.write(text) }
	end
	def test_copy_file_action
		create_file "1.txt"
		Sci::Core.new 'test.yml'
		assert_equal 'boo!', File.read('output/2.txt')
	end
	def test_copy_existed_file
		create_file '1.txt'
		create_file '11.txt', 'gagaga'
		Sci::Core.new "CopyFile", "output/1.txt", "output/2.txt"
		Sci::Core.new "CopyFile", "output/11.txt", "output/2.txt"
		assert_equal 'gagaga', File.read('output/2.txt')
		
	end
	def test_command_line_start
		create_file "1.txt"
		Sci::Core.new "CopyFile", "output/1.txt", "output/2.txt"
		
		assert_equal 'boo!', File.read('output/2.txt')
	end
	def test_zip_file_action
		create_file "1.txt"
		Sci::Core.new 'test.yml'
		assert File.exist? "output/2.zip"
	end
	def test_zip_file_action2
		create_file "1.txt"
		Sci::Core.new 'ZipFile', "output/1.txt", "output/../output/222.zip"
		assert File.exist? "output/222.zip"
	end
	def test_zip_existed_file
		create_file '1.txt'
		Sci::Core.new 'ZipFile', "output/1.txt", "output/../output/222.zip"
		Sci::Core.new 'ZipFile', "output/1.txt", "output/../output/222.zip"
	end
	def test_replace_str

		create_file 'repl_test.txt', '
#define VER_COMPANYNAME_STR         "Mackenzie Laboratories, Inc\0"
#define VER_PRODUCTNAME_STR         "MNSS\0"


#define VER_FILEVERSION             3,10,349,0
#define VER_FILEVERSION_STR         "3.10.349.0\0"
'
		Sci::Core.new 'ReplaceStr', 'output/repl_test.txt', '(#define.*?VER_COMPANYNAME_STR.*?")(.*?)(\\\\0")', '\1 aaaaa \3'
		new_text = File.read('output/repl_test.txt')
		
		assert new_text =~ /#define VER_COMPANYNAME_STR         " aaaaa \\0"/m
	end
	def test_rename_file
		create_file '1.txt'
		Sci::Core.new 'RenameFile', 'output/1.txt', 'output/2.txt'
		assert File.exist? 'output/2.txt'
		assert !(File.exist? 'output/1.txt')
	end

	def test_changelog_gen_commit
		FileUtils.rm 'test_change.log' if File.exist? 'test_change.log'
		Sci::Core.new 'GenChangelog', 'HEAD~10', 'HEAD', 'test_change.log', "HEADER"
		assert File.exist? 'test_change.log'
	end

	def test_parse_features
logs = """
HEADER

feat: feature. feat: feature2
feat: feature3 : fakefeature
test: test1. test: test2
test: test3
fixed re #123
:::test
....

"""
		assert_equal '{"feat"=>["feature", "feature2", "feature3 : fakefeature"], "test"=>["test1", "test2", "test3"]}', Sci::Actions::GenChangelog.parse_features(logs).to_s
	end

	def test_decorate_features
		tags = {'feature': ['feat1', 'feat2'], 'test': ['test1', 'test2']}
		expected_str = 
""" Feature:

   * feat1
   * feat2

 Test:

   * test1
   * test2

"""
		
		str = Sci::Actions::GenChangelog.decorate_features(tags).to_s
		assert_equal expected_str.dump, str.dump
	end
end