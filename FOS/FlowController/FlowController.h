//
//  FlowController.h
//  
//
//  Created by segate on 24/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlowLogicDelegate.h"

@interface FlowController : NSObject<FlowLogicDelegate, UITabBarControllerDelegate>
{
    UINavigationController *ctrlNavigator;
    UITabBarController *ctrlTabbar;
}
@property(nonatomic, retain) UINavigationController *ctrlNavigator;
@property(nonatomic, retain) UITabBarController *ctrlTabbar;

+ (FlowController *) initObject;
@end
