#
# Be sure to run `pod lib lint SIFloatingMenuViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SIFloatingMenuViewController"
  s.version          = "0.1.0"
  s.summary          = "A floating menu style navigation inspired by MailChimp's iOS menu navigation control."

  s.homepage         = "https://github.com/socaljoker/SIFloatingMenuViewController"
  s.screenshots     = "http://cl.ly/image/3p0e0R0O0225/ao0UT4k.gif"
  s.license          = 'GPL'
  s.author           = { "Shawn Irvin" => "sirvin@me.com" }
  s.source           = { :git => "https://github.com/socaljoker/SIFloatingMenuViewController.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'SIFloatingMenuViewController/Classes/*.{m,h}'

  s.dependency 'VBFPopFlatButton','~>0.0.6'
  s.dependency 'TDBadgedCell','~>3.0'
  s.dependency 'pop','~>1.0.6'
end
