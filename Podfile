# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'MPTally' do
  # Uncomment this line if you're using Swift or would like to use dynamic frameworks
   use_frameworks!

  # Pods for MPTally
pod 'Realm'
pod 'Masonry'
pod 'SVProgressHUD'
pod 'FSCalendar'
pod 'Charts'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
  target 'MPTallyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MPTallyUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
