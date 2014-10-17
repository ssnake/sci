require 'fileutils'
module SCI
	module Actions
		class CopyFile
			class << self
				def action *params
					if params.count == 1 && params[0].is_a?(Hash)

						src = params[0]['src']
						dst = params[0]['dst']
					elsif params.count == 3
						src = params[1]
						dst = params[2]
					else
						raise "Wrong number of params. Expected 3 but #{params.count}"
					end

					FileUtils.cp src, dst
				end

			end
		end
	end
end
