module Sci::Actions
  class GenChangelog < Basic
    class << self
      def action params
        if params.is_a?(Hash)
          from_commit = params['from_commit']
          to_commit = params['to_commint']
          output_fn = params['output_fn']
        elsif params.count == 4
          from_commit = params[1]
          to_commit = params[2]
          output_fn = params[3]
        else
          raise "Wrong params #{params}"
        end
        logs = %x( git log --pretty=format:"%s" #{from_commit}..#{to_commit})
        tags =  parse_features(logs) 
        File.write(output_fn, decorate_features(tags), mode: 'a')
      end

      def parse_features logs
        tags = {}
        logs.split(/\n|\./).each do |l|
          parts = l.split(':', 2)
          next unless l =~ /(\w+?):(.*)?/
          
          tag_name = $~[1]
          tag_msg = $~[2]
          tag_list = tags.fetch tag_name, []
          tag_list << tag_msg.strip
          tags[tag_name] = tag_list


        end
        tags
      end

      def decorate_features tags
        output = ''
        tags.each_key  do |k|
          output << "#{k}:\n\n"
          tags[k].each { |v| output << "* #{v}\n" }
          
          output << "\n"
        end
        output
      end

    end

  end
end
