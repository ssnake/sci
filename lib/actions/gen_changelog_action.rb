module SCI::Actions
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
        #puts "#{from_commit} - #{to_commit}"
        %x( git log --pretty=format:" * %s" #{from_commit}..#{to_commit} >> #{output_fn})
      end

    end
  end
end
