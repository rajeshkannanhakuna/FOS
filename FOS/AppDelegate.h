//
//  AppDelegate.h
//  FOS
//
//  Created by segate on 20/09/13.
//  Copyright (c) 2013 HakunaMatata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowController.h"
#import "FlowLogicDelegate.h"
#import "FileReadWrite.h"
#import <CoreLocation/CoreLocation.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
{
    FlowController *ctrlFlowLogic;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

-(void)LoadMainScreen;
-(void)ShowAlert :(NSString *)Title :(NSString *)Message;
@end
