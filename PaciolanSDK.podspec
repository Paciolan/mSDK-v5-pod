require 'json'

pkg_version = lambda do |dir_from_root = '', version = 'version'|
  path = File.join(__dir__, dir_from_root, 'package.json')
  JSON.parse(File.read(path))[version]
end

paciolansdk_version = pkg_version.call('../')


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
  s.platform         = :ios, '13.4'

  # To run the example app locally, you need to change the yoga version to `1.14.0`
  yoga_version = '1.14.1'
  
  extra_dependencies = [
    'React-Codegen'
  ]

  core = [
    '../node_modules/react-native/React.podspec',
    '../node_modules/react-native/React-Core.podspec',
    '../node_modules/react-native/React/CoreModules/React-CoreModules.podspec',
    '../node_modules/react-native/Libraries/ActionSheetIOS/React-RCTActionSheet.podspec',
    '../node_modules/react-native/Libraries/NativeAnimation/React-RCTAnimation.podspec',
    '../node_modules/react-native/Libraries/Blob/React-RCTBlob.podspec',
    '../node_modules/react-native/Libraries/Image/React-RCTImage.podspec',
    '../node_modules/react-native/Libraries/LinkingIOS/React-RCTLinking.podspec',
    '../node_modules/react-native/Libraries/Network/React-RCTNetwork.podspec',
    '../node_modules/react-native/Libraries/Settings/React-RCTSettings.podspec',
    '../node_modules/react-native/Libraries/Text/React-RCTText.podspec',
    '../node_modules/react-native/Libraries/Vibration/React-RCTVibration.podspec',
    '../node_modules/react-native/ReactCommon/React-rncore.podspec'
  ]

  core_dependencies = [
    '../node_modules/react-native/ReactCommon/cxxreact/React-cxxreact.podspec',
    '../node_modules/react-native/ReactCommon/jsi/React-jsi.podspec',
    '../node_modules/react-native/ReactCommon/jsiexecutor/React-jsiexecutor.podspec',
    '../node_modules/react-native/React/FBReactNativeSpec/FBReactNativeSpec.podspec',
    '../node_modules/react-native/Libraries/TypeSafety/RCTTypeSafety.podspec',
    '../node_modules/react-native/ReactCommon/ReactCommon.podspec',
    '../node_modules/react-native/ReactCommon/yoga/Yoga.podspec',
  ]

  core_dependencies_dependencies = [
    '../node_modules/react-native/Libraries/RCTRequired/RCTRequired.podspec',
    '../node_modules/react-native/Libraries/FBLazyVector/FBLazyVector.podspec',
    '../node_modules/react-native/ReactCommon/jsinspector-modern/React-jsinspector.podspec',
    '../node_modules/react-native/ReactCommon/callinvoker/React-callinvoker.podspec',
    '../node_modules/react-native/ReactCommon/reactperflogger/React-perflogger.podspec',
    '../node_modules/react-native/ReactCommon/runtimeexecutor/React-runtimeexecutor.podspec',
    '../node_modules/react-native/ReactCommon/logger/React-logger.podspec',
    '../node_modules/react-native/ReactCommon/react/debug/React-debug.podspec',
    '../node_modules/react-native/ReactCommon/react/utils/React-utils.podspec',
    '../node_modules/react-native/ReactCommon/react/renderer/runtimescheduler/React-runtimescheduler.podspec',
    '../node_modules/react-native/ReactCommon/jsc/React-jsc.podspec',
    '../node_modules/react-native/ReactCommon/react/nativemodule/core/platform/ios/React-NativeModulesApple.podspec',
    '../node_modules/react-native/ReactCommon/react/renderer/debug/React-rendererdebug.podspec'
  ]

  third_party_dependencies = [
    '../node_modules/react-native/third-party-podspecs/DoubleConversion.podspec',
    '../node_modules/react-native/third-party-podspecs/RCT-Folly.podspec',
    '../node_modules/react-native/third-party-podspecs/glog.podspec',
    '../node_modules/react-native/third-party-podspecs/boost.podspec'
  ]

  msdk_dependencies = [
    '../node_modules/react-native-encrypted-storage/react-native-encrypted-storage.podspec',
    '../node_modules/@react-native-async-storage/async-storage/RNCAsyncStorage.podspec',
    '../node_modules/@react-native-masked-view/masked-view/RNCMaskedView.podspec',
    '../node_modules/react-native-gesture-handler/RNGestureHandler.podspec',
    '../node_modules/react-native-screens/RNScreens.podspec',
    '../node_modules/react-native-safe-area-context/react-native-safe-area-context.podspec',
    '../node_modules/react-native-webview/react-native-webview.podspec',
    '../node_modules/react-native-code-push/CodePush.podspec',
    '../node_modules/@sentry/react-native/RNSentry.podspec',
    '../node_modules/@react-native-community/push-notification-ios/RNCPushNotificationIOS.podspec',
    '../node_modules/react-native-select-contact/react-native-select-contact.podspec',
    '../node_modules/@react-native-firebase/app/RNFBApp.podspec',
    '../node_modules/@react-native-firebase/messaging/RNFBMessaging.podspec',
    '../node_modules/react-native-wallet-manager/react-native-wallet-manager.podspec'
  ]

  podspecs = core + core_dependencies + core_dependencies_dependencies + third_party_dependencies + msdk_dependencies

  podspecs.each do |podspec_path|
    # p podspec_path
    spec = Pod::Specification.from_file podspec_path
    if spec.name === "Yoga"
      s.dependency spec.name, yoga_version
    else
      s.dependency spec.name, "#{spec.version}"
    end
  end

  s.dependency "Sentry", "8.30.1"
end