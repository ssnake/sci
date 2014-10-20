require 'fileutils'
module SCI
	module Actions
		class ReplaceStr
			class << self
				def action *params
					if params.count == 1 && params[0].is_a?(Hash)

					elsif params.count == 4
						filename = params[1]
						pattern = params[2]
						replacment = params[3]
					else
						raise "Wrong number of params. Expected 3 but #{params.count}"
					end
					pattern = Regexp.new pattern
					
					puts "pattern #{pattern.inspect}"
					puts "repl #{replacment}"
					File.open(filename, 'r+') do |f|
						out = ''
						f.each do |line|
							o = line.gsub(pattern, replacment)
							
							out << o
						end
						f.pos = 0
						f.print out
						f.truncate f.pos
						puts out
					end
				end
			end
		end
	end
end
