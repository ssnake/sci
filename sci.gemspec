Gem::Specification.new do |s|
  s.name    = 'sci'
  s.version = '0.1.2'
  s.date    = '2014-10-17'
  s.summary = 'simple continuous intergration system'
  s.description = 'SCI allows you to make simple scenarios. All scenarios have YML structure and they are easy-reading'
  s.author  = 'Max Nedelchev'
  s.email   = 'max.nedelchev@gmail.com'
  s.files   =  ['lib/core.rb','lib/helper.rb', 
  	'lib/actions/copy_file_action.rb', 'lib/actions/zip_file_action.rb', 'lib/actions/replace_str_action.rb',
  	'lib/actions/rename_file_action.rb' ]
  s.executables << 'sci'
  s.homepage    =
    'https://github.com/ssnake/sci'
  s.license       = 'MIT'

end                           