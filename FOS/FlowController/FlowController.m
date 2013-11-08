//
//  FlowController.m
//  
//
//  Created by segate on 24/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "FlowController.h"
#import "ViewController.h"
#import "InfoScreen.h"
#import "LoginScreen.h"
#import "RegisterScreen.h"
#import "OrderSummary.h"
#import "MenuScreen.h"
#import "FilterOptions.h"
#import "RestaurantInfo.h"
#import "RestaurantList.h"
#import "EditProfile.h"
#import "MenuItemScreen.h"
#import "MyOrdersScreen.h"
#import "ItemDetailScreen.h"
#import "HomeDelivery&TakeAway.h"
#import "VerifyMobileNumberScreen.h"
#import "SettingsScreen.h"
#import "PaymentGateway.h"
#import "LanguageConstants.h"
#import "UIConstants.h"

int lastSelectedTab;
int selectedTab;

@implementation FlowController
@synthesize ctrlNavigator;
@synthesize ctrlTabbar;

+ (FlowController *) initObject {
    
	static FlowController *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[super allocWithZone:nil] init];
        });
    }
    
    return _sharedInstance;
    
}

-(void)LoadInitialScreen
{
    lastSelectedTab = -1;
    selectedTab = -1;
    
    ViewController *ObjViewController ;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        ObjViewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
    } else {
        ObjViewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
    }
    ObjViewController.delegate = self;
    self.ctrlNavigator = [[UINavigationController alloc] initWithRootViewController:ObjViewController];
    self.ctrlNavigator.navigationBarHidden = YES;
}

-(void)LoadNextScreen:(views)ScreenName
{
    switch (ScreenName) {
        case VIEW_INFO:
        {
            InfoScreen *ObjInfoScreen ;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ObjInfoScreen = [[InfoScreen alloc]initWithNibName:@"InfoScreen" bundle:nil];
//            } else {
//                ObjInfoScreen = [[InfoScreen alloc]initWithNibName:@"InfoScreen~iPad" bundle:nil];
//            }
            ObjInfoScreen.delegate = self;
            [ctrlNavigator pushViewController:ObjInfoScreen animated:YES];
        }
            break;
        case VIEW_LOGIN:
        {
            LoginScreen *ObjLoginScreen;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                 ObjLoginScreen = [[LoginScreen alloc]initWithNibName:@"LoginScreen" bundle:nil];
//            } else {
//                ObjLoginScreen = [[LoginScreen alloc]initWithNibName:@"LoginScreen~iPad" bundle:nil];
//            }
            ObjLoginScreen.delegate = self;
            [ctrlNavigator pushViewController:ObjLoginScreen animated:YES];
        }
            break;
        case VIEW_REGISTER:
        {
            RegisterScreen *ObjRegisterScreen;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ObjRegisterScreen = [[RegisterScreen alloc]initWithNibName:@"RegisterScreen" bundle:nil];
//            } else {
//                ObjRegisterScreen = [[RegisterScreen alloc]initWithNibName:@"RegisterScreen~iPad" bundle:nil];
//            }
            ObjRegisterScreen.delegate = self;
            [ctrlNavigator pushViewController:ObjRegisterScreen animated:YES];
        }
            break;
        case VIEW_FILTEROPTION:
        {
            FilterOptions *ObjFilterOption;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ObjFilterOption  = [[FilterOptions alloc]initWithNibName:@"FilterOptions" bundle:nil];
//            } else {
//                ObjFilterOption  = [[FilterOptions alloc]initWithNibName:@"FilterOptions~iPad" bundle:nil];
//            }
            ObjFilterOption.delegate = self;
            [ctrlNavigator pushViewController:ObjFilterOption animated:YES];
        }
            break;
        case VIEW_MENUSCREEN:
        {
            MenuScreen *ObjMenuScreen;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ObjMenuScreen  = [[MenuScreen alloc] initWithNibName:@"MenuScreen" bundle:nil];
//           } else {
//               ObjMenuScreen  = [[MenuScreen alloc] initWithNibName:@"MenuScreen~iPad" bundle:nil];
//           }
            ObjMenuScreen.delegate = self;
            [ctrlNavigator pushViewController:ObjMenuScreen animated:YES];
        }
            break;
        case VIEW_ORDERSUMMARY:
        {
            OrderSummary *ObjOrderSummary;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ObjOrderSummary  = [[OrderSummary alloc] initWithNibName:@"OrderSummary" bundle:nil];
//            } else {
//                ObjOrderSummary  = [[OrderSummary alloc] initWithNibName:@"OrderSummary~iPad" bundle:nil];
//            }
            ObjOrderSummary.delegate = self;
            [ctrlNavigator pushViewController:ObjOrderSummary animated:YES];
        }
            break;
        case VIEW_RESTAURANTINFO:
        {
            RestaurantInfo *ObjRestaurantInfo;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ObjRestaurantInfo  = [[RestaurantInfo alloc] initWithNibName:@"RestaurantInfo" bundle:nil];
//            } else {
//                ObjRestaurantInfo  = [[RestaurantInfo alloc] initWithNibName:@"RestaurantInfo~iPad" bundle:nil];
//            }
            ObjRestaurantInfo.delegate = self;
            [ctrlNavigator pushViewController:ObjRestaurantInfo animated:YES];
        }
            break;
        case VIEW_RESTAURANTLIST:
        {
            RestaurantList *ObjRestaurantList;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ObjRestaurantList  = [[RestaurantList alloc] initWithNibName:@"RestaurantList" bundle:nil];
//            } else {
//                ObjRestaurantList  = [[RestaurantList alloc] initWithNibName:@"RestaurantList~iPad" bundle:nil];
//            }
            ObjRestaurantList.delegate = self;
            [ctrlNavigator pushViewController:ObjRestaurantList animated:YES];
        }
            break;
        case VIEW_EDITPROFILE:
        {
            EditProfile *ObjEditProfile;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ObjEditProfile = [[EditProfile alloc] initWithNibName:@"EditProfile" bundle:nil];
//            } else {
//                ObjEditProfile = [[EditProfile alloc] initWithNibName:@"EditProfile~iPad" bundle:nil];
//            }
            ObjEditProfile.delegate = self;
            [ctrlNavigator pushViewController:ObjEditProfile animated:YES];
        }
            break;
        case VIEW_MENUITEMSCREEN:
        {
            MenuItemScreen *ObjMenuItemScreen = [[MenuItemScreen alloc] init];
            ObjMenuItemScreen.delegate = self;
            [[self.ctrlTabbar.viewControllers objectAtIndex:self.ctrlTabbar.selectedIndex] pushViewController:ObjMenuItemScreen animated:YES];
        }
            break;
        case VIEW_ITEMDETAILS:
        {
            ItemDetailScreen *ObjItemDetail = [[ItemDetailScreen alloc] init];
            ObjItemDetail.delegate = self;
            [[self.ctrlTabbar.viewControllers objectAtIndex:self.ctrlTabbar.selectedIndex] pushViewController:ObjItemDetail animated:YES];
            
        }
            break;
        case VIEW_CHECKOUT:
        {
            HomeDelivery_TakeAway *ObjCheckOut = [[HomeDelivery_TakeAway alloc] initWithNibName:@"HomeDelivery&TakeAway" bundle:nil];
            ObjCheckOut.delegate = self;
//            [ctrlNavigator pushViewController:ObjCheckOut animated:YES];
            [[self.ctrlTabbar.viewControllers objectAtIndex:self.ctrlTabbar.selectedIndex] pushViewController:ObjCheckOut animated:YES];
        }
            break;
        case VIEW_VERIFYMOBILENO:
        {
            VerifyMobileNumberScreen *ObjVerifyMobileNo = [[VerifyMobileNumberScreen alloc] init];
            ObjVerifyMobileNo.delegate = self;
//            [ctrlNavigator pushViewController:ObjVerifyMobileNo animated:YES];
            [[self.ctrlTabbar.viewControllers objectAtIndex:self.ctrlTabbar.selectedIndex] pushViewController:ObjVerifyMobileNo animated:YES];
        }
            break;
        case VIEW_SETTINGS:
        {
            SettingsScreen *ObjSettingsScreen  = [[SettingsScreen alloc]init];
            ObjSettingsScreen.delegate = self;
            [ctrlNavigator pushViewController:ObjSettingsScreen animated:YES];
        }
            break;
        case VIEW_PAYMENTGATEWAY:
        {
            PaymentGateway *ObjePaymentGateway = [[PaymentGateway alloc]init];
            ObjePaymentGateway.delegate = self;
            [ctrlNavigator pushViewController:ObjePaymentGateway animated:YES];
        }
    }
}

-(void)LoadTabBar:(int)SelectedTab
{
    self.ctrlTabbar = [[UITabBarController alloc] init];
    self.ctrlTabbar.delegate = self;
//    [self.ctrlTabbar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                            [UIColor whiteColor], UITextAttributeTextColor,
//                                            [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                            [[UIConstants returnInstance] returnArvoRegular:12], UITextAttributeFont, nil]
//                                  forState:UIControlStateNormal];
    MenuScreen *ObjMenuScreen = [[MenuScreen alloc] init];
    ObjMenuScreen.delegate = self;
    UINavigationController *_ctrlMenuNavigator = [[UINavigationController alloc] initWithRootViewController:ObjMenuScreen];
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        _ctrlMenuNavigator.tabBarItem = [[UITabBarItem alloc] initWithTitle:(NSString *)Menu_Arabic image:[UIImage imageNamed:@"menuIcon.png"] tag: 1];
    }else{
        _ctrlMenuNavigator.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Menu" image:[UIImage imageNamed:@"menuIcon.png"] tag: 1];
    }
    _ctrlMenuNavigator.navigationBarHidden = YES;
    [ObjMenuScreen release];
    
    OrderSummary *ObjOrderSummary = [[OrderSummary alloc] init];
    ObjOrderSummary.delegate = self;
    UINavigationController *_ctrlOrderSummaryNavigator = [[UINavigationController alloc] initWithRootViewController:ObjOrderSummary];
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        _ctrlOrderSummaryNavigator.tabBarItem = [[UITabBarItem alloc] initWithTitle:(NSString *)Cart_Arabic image:[UIImage imageNamed:@"cartIcon.png"] tag:2];
    }else{
        _ctrlOrderSummaryNavigator.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Cart" image:[UIImage imageNamed:@"cartIcon.png"] tag:2];
    }
    if ([[[UIConstants returnInstance]  aryCartDetails] count] > 0) {
        _ctrlOrderSummaryNavigator.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",[[[UIConstants returnInstance] aryCartDetails] count]];
    }else{
        _ctrlOrderSummaryNavigator.tabBarItem.badgeValue = nil;
    }
    _ctrlOrderSummaryNavigator.navigationBarHidden = YES;
    [ObjOrderSummary release];
    
    MyOrdersScreen *ObjMyOrderScreen = [[MyOrdersScreen alloc] init];
    ObjMyOrderScreen.delegate = self;
    UINavigationController *_ctrlMyOrderScreen = [[UINavigationController alloc] initWithRootViewController:ObjMyOrderScreen];
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        _ctrlMyOrderScreen.tabBarItem = [[UITabBarItem alloc] initWithTitle:MyOrders_Arabic image:[UIImage imageNamed:@"myordersIcon.png"] tag:3];
    }else{
        _ctrlMyOrderScreen.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"My orders" image:[UIImage imageNamed:@"myordersIcon.png"] tag:3];
    }
    _ctrlMyOrderScreen.navigationBarHidden = YES;
    [ObjMyOrderScreen release];
    
    SettingsScreen *ObjSettingsScreen  = [[SettingsScreen alloc]init];
    ObjSettingsScreen.delegate = self;
    UINavigationController *_ctrlSettingsScreen = [[UINavigationController alloc] initWithRootViewController:ObjSettingsScreen];
    //_ctrlSettingsScreen.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:4];
    if (![[UIConstants returnInstance] isItEnglish]) {
        _ctrlSettingsScreen.tabBarItem = [[UITabBarItem alloc] initWithTitle:More_Arabic image:[UIImage imageNamed:@"more.png"] tag:4];
    }else{
        _ctrlSettingsScreen.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"More" image:[UIImage imageNamed:@"more.png"] tag:4];
    }
    
    _ctrlSettingsScreen.navigationBarHidden = YES;
    [ObjSettingsScreen release];
    
    self.ctrlTabbar.viewControllers = [[NSArray alloc] initWithObjects:_ctrlMenuNavigator, _ctrlOrderSummaryNavigator, _ctrlMyOrderScreen, _ctrlSettingsScreen, nil];
    
    if (SelectedTab == 1) {
        self.ctrlTabbar.selectedIndex = 0;
    }else if(SelectedTab == 2){
        self.ctrlTabbar.selectedIndex = 1;
    }else if(SelectedTab == 3){
        self.ctrlTabbar.selectedIndex = 2;
    }else if(SelectedTab == 4){
        self.ctrlTabbar.selectedIndex = 3;
    }
    
    lastSelectedTab = selectedTab = self.ctrlTabbar.selectedIndex;

    [self.ctrlNavigator pushViewController:self.ctrlTabbar animated:YES];
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"Tab pos : %@",[NSString stringWithFormat:@"%d",tabBarController.selectedIndex]);
    lastSelectedTab = selectedTab;
    selectedTab = tabBarController.selectedIndex;
    
}

-(void)GoBack :(BOOL)animation
{
    if(self.ctrlTabbar == nil)
        [ctrlNavigator popViewControllerAnimated:animation];
    else {
         [[self.ctrlTabbar.viewControllers objectAtIndex:self.ctrlTabbar.selectedIndex] popViewControllerAnimated:animation];
    }
}
- (void) commonBack {
    [ctrlNavigator popViewControllerAnimated:YES];
}
- (void) methodToSwitchTab {
    self.ctrlTabbar.selectedIndex = 0;
    if([[UIConstants returnInstance] isItemCleared]){
        [[self returnCurrentNavigationController] popToRootViewControllerAnimated:YES];
    }
}

-(void)GoHome
{
    [ctrlNavigator popToRootViewControllerAnimated:YES];
}

- (void) loadPreviousTab {
    self.ctrlTabbar.selectedIndex = lastSelectedTab;
    selectedTab = lastSelectedTab;
}


-(UINavigationController *)returnCurrentNavigationController{
    if(nil != ctrlTabbar)
        return (UINavigationController *)self.ctrlTabbar.selectedViewController;
    else return ctrlNavigator;
}

@end
