//
//  PACIOLANSDKVIEWCONTROLLERViewController.m
//  PaciolanSDK
//
//  Created by 55355294 on 02/12/2024.
//  Copyright (c) 2024 55355294. All rights reserved.
//

#import "PACIOLANSDKVIEWCONTROLLERViewController.h"
#import <PaciolanSDK/PaciolanSDKViewController.h>

@interface PACIOLANSDKVIEWCONTROLLERViewController ()
@property (nonatomic, strong) PaciolanSDKViewController *paciolanSDKViewController;
@end

@implementation PACIOLANSDKVIEWCONTROLLERViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)addViewAsChildViewController:(UIViewController *)viewController withFrame:(CGRect)frame {
    // Add the child view controller
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    
    // Set the child view's frame
    viewController.view.frame = frame;
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Notify the child view controller
    [viewController didMoveToParentViewController:self];
}


- (IBAction)manageTickets:(UIButton *)sender {
    // QFNQ
//    NSString* config = @"{\"applicationId\": \"\", \"channelCode\": \"qamanual72\", \"distributorCode\": \"AMTX\", \"organizationId\": \"129\", \"sdkKey\": \"test2\", \"route\": {\"name\": \"ticket-management\"}, \"uiOptions\": {\"logoImage\": \"https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Tulane_Green_Wave_logo.svg/1200px-Tulane_Green_Wave_logo.svg.png\", \"accentColor\": \"#cc0000\"}}";

    // PROD
     NSString* config = @"{\"applicationId\": \"\", \"channelCode\": \"msdk-sa\", \"distributorCode\": \"CICD80\", \"organizationId\": \"390\", \"sdkKey\": \"test2\", \"route\": {\"name\": \"ticket-management\"}, \"uiOptions\": {\"logoImage\": \"https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Tulane_Green_Wave_logo.svg/1200px-Tulane_Green_Wave_logo.svg.png\", \"accentColor\": \"#cc0000\"}}";
    
    PaciolanSDKViewController *viewController = [[PaciolanSDKViewController alloc] initWithString:config];
    [self presentModalViewController:viewController animated:YES];
    [self.paciolanSDKViewController setTokenListener:^(NSString *token) {
        NSLog(@"Token received from JS: %@", token);
    }];
}

- (IBAction)buyTickets:(UIButton *)sender {
    // QFNQ
//    NSString* config = @"{\"applicationId\": \"\", \"channelCode\": \"qamanual72\", \"distributorCode\": \"AMTX\", \"organizationId\": \"129\", \"sdkKey\": \"test2\", \"route\": {\"name\": \"event-list\"}, \"uiOptions\": {\"logoImage\": \"https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Tulane_Green_Wave_logo.svg/1200px-Tulane_Green_Wave_logo.svg.png\", \"accentColor\": \"#cc0000\"}}";

    // PROD
     NSString* config = @"{\"applicationId\": \"\", \"channelCode\": \"msdk-sa\", \"distributorCode\": \"CICD80\", \"organizationId\": \"390\", \"sdkKey\": \"test2\", \"route\": {\"name\": \"event-list\"}, \"uiOptions\": {\"logoImage\": \"https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Tulane_Green_Wave_logo.svg/1200px-Tulane_Green_Wave_logo.svg.png\", \"accentColor\": \"#cc0000\"}}";
    
    PaciolanSDKViewController *viewController = [[PaciolanSDKViewController alloc] initWithString:config];
    [self presentModalViewController:viewController animated:YES];
    [self.paciolanSDKViewController setTokenListener:^(NSString *token) {
        NSLog(@"Token received from JS: %@", token);
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
