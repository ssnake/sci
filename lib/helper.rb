require 'logger.rb'

Dir["#{File.dirname(__FILE__)}/actions/*_action.rb"].each { |f| require(f) }

module SCI::Helper

	def self.included(receiver)
  	receiver.send :include, SCI::Logger
  end
	
	def find_action_class name
		log "Looking for #{name}" 

		SCI::Actions.constants.each do |pc|
			cl = SCI::Actions.const_get(pc)	
			cl_name = cl.to_s.split('::').last

			if Class === cl && cl_name == name	
			    log "found #{cl_name}"	
				return cl
			end
		end
		raise "Unable to find #{name} action"
		nil
	end	
end