Pod::Spec.new do |s|
  s.name                  = 'YelpKit'
  s.version               = '1.0.1'
  s.license               = 'MIT'
  s.summary               = 'TObjective-C library for iOS development.'
  s.homepage              = 'https://github.com/Yelp/YelpKit'
  s.author                = { 'John Boiles' => 'http://johnboiles.com',
                              'Gabriel Handford' => 'gabrielh@gmail.com' }
  s.source                = { :git => 'https://github.com/fblumenberg/YelpKit.git', :tag => '1.0.1' }
  s.requires_arc          = false
  s.platform              = :ios
  s.dependency            'GHKit'
  s.frameworks            = 'MapKit', 'QuartzCore'
  s.source_files          = 'Classes/*.{h,m}'
  s.ios.deployment_target     = '5.0'
  s.documentation         = {
    :html => 'http://yelp.github.com/YelpKit/'
  }
end