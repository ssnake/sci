require 'fileutils'
module SCI
	module Actions
		class CopyFile
			class << self
				def action param
					src = param['src']
					dst = param['dst']
					FileUtils.cp src, dst
				end

			end
		end
	end
end
