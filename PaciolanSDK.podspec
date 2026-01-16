require 'json'

pkg_version = lambda do |dir_from_root = '', version = 'version'|
  path = File.join(__dir__, dir_from_root, 'package.json')
  JSON.parse(File.read(path))[version]
end

paciolansdk_version = pkg_version.call('../')

node_modules_prefix = File.exist?(File.join(__dir__, 'node_modules')) ? 'node_modules' : '../node_modules'
react_native_path = File.expand_path("#{node_modules_prefix}/react-native", __dir__)
ENV['REACT_NATIVE_PATH'] = react_native_path
require File.join(react_native_path, 'scripts/react_native_pods.rb')

react_native_version = JSON.parse(File.read(File.join(react_native_path, 'package.json')))['version']
# Prefer a local Hermes tarball when present to avoid network fetches.
hermes_tarball_candidates = [
  File.join(__dir__, 'hermes-engine', "hermes-ios-#{react_native_version}-debug.tar.gz"),
  File.join(__dir__, 'hermes-engine', "hermes-ios-#{react_native_version}.tar.gz"),
  File.join(__dir__, 'hermes-engine', "hermes-ios-#{react_native_version}-release.tar.gz")
]
hermes_tarball = hermes_tarball_candidates.find { |path| File.exist?(path) }
ENV['HERMES_ENGINE_TARBALL_PATH'] = hermes_tarball if hermes_tarball


Pod::Spec.new do |s|
  s.name             = 'PaciolanSDK'
  s.version          = paciolansdk_version
  s.summary          = 'Pod Component for Paciolan Mobile SDK'
  s.description      = 'This pod allows us to install the Paciolan react native SDK ViewController into an iOS app.'
  s.homepage         = 'https://github.com/Paciolan/mSDK-v5-pod'
  s.license          = { type: 'No License' }
  s.author           = { 'Paciolan Mobile Team' => 'pacmobile@paciolan.com' }
  s.source           = { :git => 'https://github.com/Paciolan/mSDK-v5-pod.git', :tag => s.version.to_s } 
  s.source_files     = 'PaciolanSDK/Classes/**/*.{h,m,swift}'
  s.resources        = 'PaciolanSDK/Assets/{PaciolanSDK.js,assets}'
  s.ios.resource_bundles = { 'PaciolanSDK' => ['PaciolanSDK/Assets/{PaciolanSDK.js,assets}'] }
  s.platform         = :ios, '15.5'

  extra_dependencies = [
    'ReactCodegen'
  ]

  core = [
    "#{node_modules_prefix}/react-native/React.podspec",
    "#{node_modules_prefix}/react-native/React-Core.podspec",
    "#{node_modules_prefix}/react-native/React/CoreModules/React-CoreModules.podspec",
    "#{node_modules_prefix}/react-native/Libraries/Required/RCTRequired.podspec",
    "#{node_modules_prefix}/react-native/Libraries/AppDelegate/React-RCTAppDelegate.podspec",
    "#{node_modules_prefix}/react-native/Libraries/ActionSheetIOS/React-RCTActionSheet.podspec",
    "#{node_modules_prefix}/react-native/Libraries/NativeAnimation/React-RCTAnimation.podspec",
    "#{node_modules_prefix}/react-native/Libraries/Blob/React-RCTBlob.podspec",
    "#{node_modules_prefix}/react-native/Libraries/Image/React-RCTImage.podspec",
    "#{node_modules_prefix}/react-native/Libraries/LinkingIOS/React-RCTLinking.podspec",
    "#{node_modules_prefix}/react-native/Libraries/Network/React-RCTNetwork.podspec",
    "#{node_modules_prefix}/react-native/Libraries/Settings/React-RCTSettings.podspec",
    "#{node_modules_prefix}/react-native/Libraries/Text/React-RCTText.podspec",
    "#{node_modules_prefix}/react-native/Libraries/Vibration/React-RCTVibration.podspec",
    "#{node_modules_prefix}/react-native/React/React-RCTFBReactNativeSpec.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/React-rncore.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/React-FabricComponents.podspec"
  ]

  core_dependencies = [
    "#{node_modules_prefix}/react-native/ReactCommon/cxxreact/React-cxxreact.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/jsi/React-jsi.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/jsiexecutor/React-jsiexecutor.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/jserrorhandler/React-jserrorhandler.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/React-Mapbuffer.podspec",
    "#{node_modules_prefix}/react-native/Libraries/TypeSafety/RCTTypeSafety.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/ReactCommon.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/yoga/Yoga.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/renderer/graphics/React-graphics.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/featureflags/React-featureflags.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/renderer/consistency/React-rendererconsistency.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/React-Fabric.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/React-FabricImage.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/renderer/imagemanager/platform/ios/React-ImageManager.podspec",
    "#{node_modules_prefix}/react-native/React/React-RCTFabric.podspec",
    "#{node_modules_prefix}/react-native/ReactApple/Libraries/RCTFoundation/RCTDeprecation/RCTDeprecation.podspec"
  ]
  
  core_dependencies_dependencies = [
    "#{node_modules_prefix}/react-native/Libraries/FBLazyVector/FBLazyVector.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/jsinspector-modern/React-jsinspector.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/jsinspector-modern/tracing/React-jsinspectortracing.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/callinvoker/React-callinvoker.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/reactperflogger/React-perflogger.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/runtimeexecutor/React-runtimeexecutor.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/logger/React-logger.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/debug/React-debug.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/utils/React-utils.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/renderer/runtimescheduler/React-runtimescheduler.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/performance/timeline/React-performancetimeline.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/timing/React-timing.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/nativemodule/core/platform/ios/React-NativeModulesApple.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/renderer/debug/React-rendererdebug.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/runtime/React-RuntimeCore.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/runtime/platform/ios/React-RuntimeApple.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/runtime/React-RuntimeHermes.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/hermes/executor/React-jsitracing.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/nativemodule/featureflags/React-featureflagsnativemodule.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/nativemodule/microtasks/React-microtasksnativemodule.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/nativemodule/idlecallbacks/React-idlecallbacksnativemodule.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/nativemodule/dom/React-domnativemodule.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/react/nativemodule/defaults/React-defaultsnativemodule.podspec",
    "#{node_modules_prefix}/react-native/ReactCommon/hermes/React-hermes.podspec",
    "#{node_modules_prefix}/react-native/sdks/hermes-engine/hermes-engine.podspec",
  ]

  third_party_dependencies = [
    "#{node_modules_prefix}/react-native/third-party-podspecs/DoubleConversion.podspec",
    "#{node_modules_prefix}/react-native/third-party-podspecs/RCT-Folly.podspec",
    "#{node_modules_prefix}/react-native/third-party-podspecs/glog.podspec",
    "#{node_modules_prefix}/react-native/third-party-podspecs/boost.podspec",
    "#{node_modules_prefix}/react-native/third-party-podspecs/fast_float.podspec",
    "#{node_modules_prefix}/react-native/third-party-podspecs/fmt.podspec"
  ]

  msdk_dependencies = [
    "#{node_modules_prefix}/react-native-encrypted-storage/react-native-encrypted-storage.podspec",
    "#{node_modules_prefix}/@react-native-masked-view/masked-view/RNCMaskedView.podspec",
    "#{node_modules_prefix}/react-native-gesture-handler/RNGestureHandler.podspec",
    "#{node_modules_prefix}/react-native-safe-area-context/react-native-safe-area-context.podspec",
    "#{node_modules_prefix}/react-native-webview/react-native-webview.podspec",
    "#{node_modules_prefix}/react-native-code-push/CodePush.podspec",
    "#{node_modules_prefix}/@sentry/react-native/RNSentry.podspec",
    "#{node_modules_prefix}/@react-native-community/push-notification-ios/RNCPushNotificationIOS.podspec",
    "#{node_modules_prefix}/react-native-select-contact/react-native-select-contact.podspec",
    "#{node_modules_prefix}/@react-native-firebase/app/RNFBApp.podspec",
    "#{node_modules_prefix}/@react-native-firebase/messaging/RNFBMessaging.podspec",
    "#{node_modules_prefix}/react-native-wallet-manager/react-native-wallet-manager.podspec"
  ]

  podspecs = core + core_dependencies + core_dependencies_dependencies + third_party_dependencies + msdk_dependencies

  podspecs.each do |podspec_path|
    spec = Pod::Specification.from_file podspec_path
      s.dependency spec.name, "#{spec.version}"
  end

  s.dependency "Sentry/HybridSDK", "8.57.3"

end
