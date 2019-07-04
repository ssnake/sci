module SCI
  module Logger
    def log msg
      puts "Looking for #{name}" unless ENV['SCI_DEBUG'].nil?
    end   
  end
end