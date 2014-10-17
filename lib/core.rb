$LOAD_PATH << File.dirname(__FILE__)
require 'helper'
require 'yaml'

module SCI
	class Core
		include Helper
		def initialize *args
			
			if args.count == 1 && args[0].is_a?(String)
				@cfg = YAML.load File.read(args[0])
				build
			elsif args.count > 2
				action = args[0]
				a = find_action_class action
				return if a.nil?
				a.action *args
			else
			  raise "Wrong parameter format"
			end 
		end
	private
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

end