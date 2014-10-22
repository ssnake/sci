require 'fileutils'
require 'zip'
module SCI
	module Actions
		class ZipFile
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
					if src.is_a? String
						src = [src]
					end
					#overwrite existed files in zip
					Zip.setup do |c|
					    c.on_exists_proc = true
					    c.continue_on_exists_proc = true
					    c.unicode_names = true
					    c.default_compression = Zlib::BEST_COMPRESSION
					end
					Zip::File.open(dst, Zip::File::CREATE) do |zipfile|
					  src.each do |filename|
					    # Two arguments:
					    # - The name of the file as it will appear in the archive
					    # - The original file, including the path to find it
					    zipfile.add(File.basename(filename), filename)
					  end
					  #zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
					end
					
				end

			end
		end
	end
end
