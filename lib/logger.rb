module Sci
  module Logger
    def log msg
      puts msg unless ENV['SCI_DEBUG'].nil?
    end   
  end
end