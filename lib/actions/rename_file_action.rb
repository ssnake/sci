require 'fileutils'
module Sci
	module Actions
		class RenameFile < Basic
			class << self
				def action params
					if params.is_a?(Hash)

						src = params['src']
						dst = params['dst']
					elsif params.count == 3
						src = params[1]
						dst = params[2]
					else
						raise "Wrong params #{params}"
					end

					File.rename src, dst
				end

			end
		end
	end
end
