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

@interface PaciolanSDKViewController : UIViewController <RCTBridgeModule>

@property (strong, nonatomic) NSString* config;
@property RCTBridge *bridge;

- (void)navAwayFromPac:(NSString *)response resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject;

@end