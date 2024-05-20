#import "PaciolanSDKEventEmitter.h"

@implementation PaciolanSDKEventEmitter {
   bool hasListeners;
}

RCT_EXPORT_MODULE();

- (void) startObserving {
  hasListeners = YES;
}

- (void) stopObserving {
  hasListeners = NO;
}

- (bool) hasListeners {
  return hasListeners;
}

+ (BOOL)requiresMainQueueSetup {
    return YES; // Set to YES if your module requires main queue setup
}

+ (id)allocWithZone:(NSZone *)zone {
  static PaciolanSDKEventEmitter *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"navAwayEvent", @"AppLaunchedEvent"];
}

- (void)sendEventToJS:(NSString *)eventName callback:(void (^)(BOOL))callback {
    // Store the callback for later use
    self.storedCallback = callback;
    
    if(hasListeners){
      NSLog(@"eventName... %@", eventName);
     [self sendEventWithName:eventName body:nil];
    } else {
        NSLog(@"No listeners...");
    }
}

RCT_EXPORT_METHOD(receiveResponseFromJS:(BOOL)response) {
    if (self.storedCallback) {
        self.storedCallback(response);
        self.storedCallback = nil; // Reset the callback after use
    }
}

@end
