//
//  PaciolanSDKViewController.h
//  Pods
//
//  Created by Joao victor Veronezi on 12/02/24.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridge.h>

typedef void (^TokenCallback)(NSString* token);

@interface PaciolanSDKViewController : UIViewController <RCTBridgeModule>

@property (strong, nonatomic) NSString* config;
- (void)navAwayFromPac:(NSString *)response resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject;

- (void)setTokenListener: (TokenCallback) finishBlock;
@end