Gem::Specification.new do |s|
  s.name = 'chef-handler-sensu'
  s.version = '0.2.0'
  s.author = 'Simple Finance'
  s.email = 'ops@simple.com'
  s.homepage = 'http://github.com/SimpleFinance/chef-handler-sensu'
  s.summary = 'Cleans up old Sensu checks'
  s.description = 'Cleans up old Sensu checks during a Chef run'
  s.files = ::Dir.glob('**/*')
  s.require_paths = ['lib']
end

