Pod::Spec.new do |s|
  s.name                      = 'CrcSwift'
  s.version                   = '0.0.3'
  s.summary                   = 'CRC-8, CRC-16, CRC-32 calculation with flexible settings and a set of tuning presets.'

  s.homepage                  = 'https://github.com/ivanesik/CrcSwift'
  s.license                   = 'MIT'
  s.author                    = { 'ivanesik' => 'https://github.com/ivanesik' }
  s.source                    = { :git => 'https://github.com/ivanesik/CrcSwift.git', :tag => s.version.to_s }

  s.swift_version             = '5.0'
  s.ios.deployment_target     = '11.0'
  s.osx.deployment_target     = '11.0'
  s.tvos.deployment_target    = '11.0'
  
  s.source_files              = 'Sources/CrcSwift/**/*'
end
