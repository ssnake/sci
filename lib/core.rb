$LOAD_PATH << File.dirname(__FILE__)
require 'helper'
require 'yaml'

module SCI
	class Core
		include Helper
		def initialize file
			@cfg = YAML.load File.read(file)
		end
		def build
			@cfg.each do |action|
				name = action.keys[0]
				a = find_action_class name
				if a.nil?
					puts "unable to find #{name}" 
					next
				end
				a.action action[name]
			end
		end
	end
end

if __FILE__ == $0

	c = SCI::Core.new '..\tests\test.yml'
	c.build
end