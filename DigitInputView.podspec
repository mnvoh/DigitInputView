Pod::Spec.new do |s|
  s.name             = 'DigitInputView'
  s.version          = '0.1.0'
  s.summary          = 'Character input field with separated underline.'

  s.description      = <<-DESC
This component will let you propmpt for a limited number of characters in
an elegant way, ex: Confirmation code input.
                       DESC

  s.homepage         = 'https://github.com/mnvoh/DigitInputView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mnvoh' => 'mnvoh90@gmail.com' }
  s.source           = { :git => 'https://github.com/mnvoh/DigitInputView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mnvoh'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DigitInputView/Classes/**/*'
end
