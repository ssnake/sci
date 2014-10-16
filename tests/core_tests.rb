require_relative '../lib/core.rb'
require "test/unit"
class TestCore < Test::Unit::TestCase
	def setup
		@sci = SCI::Core.new 'test.yml'
	end
	def test_copy_file_action
		File.open("1.txt", "w+") { |file| file.write("boo!") }
		@sci.build
		assert_equal 'boo!', File.read('2.txt')
	end
end