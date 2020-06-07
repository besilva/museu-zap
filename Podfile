platform :ios, '11.0'
target "MuseuZap" do
  pod 'Firebase/Analytics', '6.5.0'
  pod 'Crashlytics'
  pod 'Fabric'

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
end
end

target "MuseuZapTests" do
  pod 'SnapshotTesting', '~> 1.7.2'
end

