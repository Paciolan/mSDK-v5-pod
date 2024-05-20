#import <React/RCTEventEmitter.h>

@interface PaciolanSDKEventEmitter : RCTEventEmitter
@property (nonatomic, copy) void (^storedCallback)(BOOL);

- (void)sendEventToJS:(NSString *)eventName callback:(void (^)(BOOL))callback;
- (void)receiveResponseFromJS:(BOOL)response;
- (bool) hasListeners;
@end