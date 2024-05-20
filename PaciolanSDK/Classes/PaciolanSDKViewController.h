#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridge.h>

typedef void (^TokenCallback)(NSString* token);

@interface PaciolanSDKViewController : UIViewController <RCTBridgeModule>

@property (strong, nonatomic) NSString* config;
- (void)navAwayFromPac:(NSString *)response resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject;

- (void)setTokenListener: (TokenCallback) finishBlock;

- (id) initWithString: (NSString*) initializationConfig;

- (void)appLaunched:(NSString *)response resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject;

@end
