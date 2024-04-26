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
#import <React/RCTUtils.h>
#import <React/RCTLog.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTEventEmitter.h>

@interface PaciolanSDKViewController () <RCTBridgeDelegate, RCTBridgeModule>
@end

@interface NativeModules : NSObject <RCTBridgeModule>
@end

@implementation PaciolanSDKViewController

static TokenCallback tokenCallback;

RCT_EXPORT_MODULE()

- (void)viewDidLoad {
   [super viewDidLoad];
    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:@{}];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"PaciolanSDK" initialProperties:nil];
    self.view = rootView;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"PaciolanSDK" withExtension:@"js"];
    return url;

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

@end