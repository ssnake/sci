Gem::Specification.new do |s|
  s.name    = 'sci'
  s.version = '0.2.1'
  s.date    = '2019-07-04'
  s.summary = 'simple continuous integration system'
  s.description = 'SCI allows you to make simple scenarios. All scenarios have YML structure and they are easy-reading'
  s.author  = 'Max Nedelchev'
  s.email   = 'max.nedelchev@gmail.com'
  s.files = Dir['lib/**/*'].keep_if { |file| File.file?(file) }
  s.executables << 'sci'
  s.homepage    =
    'https://github.com/ssnake/sci'
  s.license       = 'MIT'

end                           