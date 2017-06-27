# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'



target 'Budget' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # ignore all warnings from all pods
  inhibit_all_warnings!

  # Pods for Budget
  pod 'SWRevealViewController', '~> 2.3.0', :inhibit_warnings => true
  pod 'RealmSwift', '~> 2.7.0', :inhibit_warnings => true
  pod 'UICircularProgressRing', '~> 1.4.3', :inhibit_warnings => true
  pod 'TextFieldEffects', '~> 1.3.3', :inhibit_warnings => true
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end

end

