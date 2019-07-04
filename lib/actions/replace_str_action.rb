require 'fileutils'

module Sci
	module Actions
		class ReplaceStr < Basic
			class << self
				def action params
					if params.is_a?(Hash)

					elsif params.count == 4
						filename = params[1]
						pattern = params[2]
						replacment = params[3]
					else
						raise "Wrong params #{params}"
					end
					pattern = Regexp.new pattern
					
					log "pattern #{pattern}"
					log "replacement #{replacment}"
					File.open(filename, 'r+') do |f|
						out = ''
						f.each do |line|
							log "found pattern!" if line =~ pattern
							o = line.gsub(pattern, replacment)
							out << o
						end
						f.pos = 0
						f.print out
						f.truncate f.pos
						
					end
				end
			end
		end
	end
end
