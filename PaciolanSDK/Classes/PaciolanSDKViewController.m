//
//  PaciolanSDKViewController.m
//  Pods
//
//  Created by Joao victor Veronezi on 12/02/24.
//

#import "PaciolanSDKViewController.h"
#import "PaciolanSDKEventEmitter.h"
#import <React/RCTRootView.h>
#import <React/RCTBridge.h>
#import <React/RCTBridgeDelegate.h>
#import <React/RCTBridgeModule.h>
#import <React-RCTAppDelegate/RCTAppSetupUtils.h>
#import <React/RCTUtils.h>
#import <React/RCTLog.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTEventEmitter.h>
#import <CodePush/CodePush.h>

#ifndef RCT_NEW_ARCH_ENABLED
#define RCT_NEW_ARCH_ENABLED 0
#endif


@import Sentry;

@interface PaciolanSDKViewController () <RCTBridgeDelegate, RCTBridgeModule>
@end

@interface NativeModules : NSObject <RCTBridgeModule>
@end

@implementation PaciolanSDKViewController
@synthesize config;
static NSString *INSTALLED_VERSION = @"5.105.2602053878848";
static TokenCallback tokenCallback;

RCT_EXPORT_MODULE()


+ (BOOL)requiresMainQueueSetup {
    return YES; // Set to YES if your module requires main queue setup
}

- (void)viewDidLoad {
   [super viewDidLoad];
#if RCT_NEW_ARCH_ENABLED
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RCTAppSetupPrepareApp(UIApplication.sharedApplication, YES);
    });
#endif
    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:@{}];
    NSLog(@"installed versioon: %@", INSTALLED_VERSION);
    NSDictionary *initialProps = @{@"configString": config, @"installedVersion": INSTALLED_VERSION};
    UIView *rootView = RCTAppSetupDefaultRootView(bridge, @"PaciolanSDK", initialProps, RCT_NEW_ARCH_ENABLED);
    self.view = rootView;

    // Sentry config initialization.
    [SentrySDK startWithConfigureOptions:^(SentryOptions *options) {
        options.dsn = @"https://ba958772038a40ff97d7a79d9e4d0e07@o361452.ingest.us.sentry.io/3858620";
        options.enableTracing = YES;
    }];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
    [CodePush overrideAppVersion: @"5.105"];

    // set codepush custom server url
    NSString *serverUrl = @"https://pkg.paciolan.io/codepush/msdk/";
    [[CodePushConfig current] setServerURL:serverUrl];
    return [CodePush bundleURLForResource:@"PaciolanSDK"
                                    withExtension:@"js"
                                     subdirectory:nil
                                           bundle:[NSBundle bundleForClass:[self class]]];
}

- (id) initWithString: (NSString*) initializationConfig {
    self = [super init];
    if (self) {
        config = initializationConfig;
    }
    return self;
}

RCT_EXPORT_METHOD(navAwayFromPac:(NSString *)response resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    // Define a callback block to handle the response from JavaScript
    void (^jsResponseHandler)(BOOL) = ^(BOOL jsResponse) {
        NSLog(@"Received response from JavaScript: %d", jsResponse);

        // Resolve the promise with the boolean response
        resolve(@(jsResponse));
    };

    // Send event to JavaScript with the callback block
    [[PaciolanSDKEventEmitter allocWithZone: NULL] sendEventToJS:@"navAwayEvent" callback:jsResponseHandler];
}

- (void) setTokenListener: (void(^)(NSString* token))callback
{
    tokenCallback = callback;
}

RCT_EXPORT_METHOD(storeToken:(NSString *)token)
{
    if (tokenCallback) {
        tokenCallback(token);
    }
};

RCT_EXPORT_METHOD(exitApp)
{
    printf("Leaving the App");
    dispatch_sync(dispatch_get_main_queue(), ^{
        [RCTPresentedViewController() dismissViewControllerAnimated:false completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitAppNotification" object:nil userInfo:@{@"message": @"Exiting the app"}];
    });
};

RCT_EXPORT_METHOD(appLaunched:(NSString *)response resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    // Define a callback block to handle the response from JavaScript
    void (^jsResponseHandler)(BOOL) = ^(BOOL jsResponse) {
        NSLog(@"Received response from JavaScript: %d", jsResponse);
        resolve(@YES);
    };

    // Send event to JavaScript
    [[PaciolanSDKEventEmitter allocWithZone: NULL] sendEventToJS:@"AppLaunchedEvent" callback:jsResponseHandler];
}

@end
