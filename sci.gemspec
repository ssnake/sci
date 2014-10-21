Gem::Specification.new do |s|
  s.name    = 'sci'
  s.version = '0.1.0'
  s.date    = '2014-10-17'
  s.summary = 'simple continuous integrarion'
  s.author  = 'snake'
  s.email   = 'max@snakelab.cc'
  s.files   =  ['lib/core.rb','lib/helper.rb', 'lib/actions/copy_file_action.rb', 'lib/actions/zip_file_action.rb', 'lib/actions/replace_str_action.rb' ]
  s.executables << 'sci'
end                           