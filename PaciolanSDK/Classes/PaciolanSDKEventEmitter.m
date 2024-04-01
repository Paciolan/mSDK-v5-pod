#import "PaciolanSDKEventEmitter.h"

@implementation PaciolanSDKEventEmitter

RCT_EXPORT_MODULE();

+ (id)allocWithZone:(NSZone *)zone {
  static PaciolanSDKEventEmitter *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"navAwayEvent"];
}

- (void)sendEventToJS:(NSString *)eventName callback:(void (^)(BOOL))callback {
    // Store the callback for later use
    self.storedCallback = callback;
    [self sendEventWithName:eventName body:nil];
}

RCT_EXPORT_METHOD(receiveResponseFromJS:(BOOL)response) {
    if (self.storedCallback) {
        self.storedCallback(response);
        self.storedCallback = nil; // Reset the callback after use
    }
}

@end
