//
//  FlowLogicDelegate.h
//  
//
//  Created by segate on 24/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    VIEW_INFO,
    VIEW_LOGIN,
    VIEW_REGISTER,
    VIEW_ORDERSUMMARY,
    VIEW_MENUSCREEN,
    VIEW_FILTEROPTION,
    VIEW_RESTAURANTINFO,
    VIEW_RESTAURANTLIST,
    VIEW_EDITPROFILE,
    VIEW_MENUITEMSCREEN,
    VIEW_ITEMDETAILS,
    VIEW_CHECKOUT,
    VIEW_VERIFYMOBILENO,
    VIEW_SETTINGS,
    VIEW_PAYMENTGATEWAY
}views;

@protocol FlowLogicDelegate <NSObject>
@optional

-(void)LoadInitialScreen;
-(void)LoadNextScreen:(views)ScreenName;
-(void)LoadTabBar:(int)SelectedTab;
-(void)GoBack :(BOOL)animation;
-(void)GoHome;
- (void) methodToSwitchTab;
- (void) commonBack;

- (void) loadPreviousTab;

@end
