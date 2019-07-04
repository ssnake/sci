module Sci::Helper

	def self.included(receiver)
  	receiver.send :include, Sci::Logger
  end
	
	def find_action_class name
		log "Looking for #{name}" 

		Sci::Actions.constants.each do |pc|
			cl = Sci::Actions.const_get(pc)	
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