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

- (IBAction)launchSDK:(UIButton *)sender {
    PaciolanSDKViewController *childViewController = [[PaciolanSDKViewController alloc] init];
    [self addChildViewController:childViewController];
    [self.view addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:self];
    self.paciolanSDKViewController = childViewController;

    childViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);

    // Create a button in the parentViewController
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Click Me!" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.backgroundColor = UIColor.systemBlueColor;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    CGFloat buttonWidth = self.view.bounds.size.width;
    CGFloat buttonHeight = 150;
    CGFloat buttonX = 0;
    CGFloat buttonY = CGRectGetMaxY(self.view.frame) - buttonHeight;
    button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
}

- (void)buttonClicked:(UIButton *)sender {
    NSLog(@"Button Clicked!");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Call the navAwayFromPac method without providing the response parameter
        [[PaciolanSDKViewController alloc] navAwayFromPac:nil resolver:^(id result) {
            NSLog(@"Parent App Success: %@", result);
        } rejecter:^(NSString *code, NSString *message, NSError *error) {
            NSLog(@"Parent App Error: %@ - %@", code, message);
        }];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
