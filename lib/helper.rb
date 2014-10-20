
Dir["#{File.dirname(__FILE__)}/actions/*_action.rb"].each { |f| require(f) }
module Helper
	def find_action_class name
			puts "Looking for #{name}"

			SCI::Actions.constants.each do |pc|
				cl = SCI::Actions.const_get(pc)	
				cl_name = cl.to_s.split('::').last

				if Class === cl && cl_name == name	
				    puts "found #{cl_name}"	
					return cl
				end
			end
			nil
		end	
end