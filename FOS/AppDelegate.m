//
//  AppDelegate.m
//
//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "AppDelegate.h"
#import "ServiceHandler.h"
#import "ResponseDTO.h"
#import "ViewController.h"
#import "UIConstants.h"
#import "MacandIPaddressFetchExampleViewController.h"
#import "LanguageConstants.h"
UIAlertView *alert;
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    ServiceHandler *ObjServiceHandler = [[ServiceHandler alloc]init];
    //   ResponseDTO    *ObjResponseDTO    = [[ResponseDTO alloc]init];
    NSMutableArray *aryAppID = [[NSMutableArray alloc]initWithArray:[FileReadWrite readFile:@"AppID"]];
    NSString *strAppID  = @"";
    if([aryAppID count] > 0)
        strAppID  = [aryAppID objectAtIndex:0];
    NSLog(@"AppId: %@", strAppID);
    if ([aryAppID count] > 1) {
        NSString *emailID = [aryAppID objectAtIndex:1];
        NSString *Password = [aryAppID objectAtIndex:2];
        if ([ObjServiceHandler GetWebUserLogInAPI:emailID :Password]) {
            [[UIConstants returnInstance] setStrFosUserID:[[[ResponseDTO sharedInstance] DTO_UserLoginResponse] objectForKey:key_IdUser]];
            [[UIConstants returnInstance] setStrFosUserName:[[[ResponseDTO sharedInstance] DTO_UserLoginResponse] objectForKey:key_FirstName]];
            [[UIConstants returnInstance] setDicUserDetails:[[ResponseDTO sharedInstance] DTO_UserLoginResponse]];
            [[UIConstants returnInstance] setStrPassword:Password];
        }else{
            if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
                [[UIConstants returnInstance] ShowNoNetworkAlert];
            }else{
                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
            }
        }
        NSLog(@"Email: %@, Password: %@", emailID, Password);
    }else{
        NSLog(@"No user details");
    }
    
    // NSString *strUserID = [aryAppID objectAtIndex:1];// valueForKey:key_IdUser];
    NSString *strDeviceID = [MacandIPaddressFetchExampleViewController getMacAddress];
    //[[UIConstants returnInstance] setStrLanguage:lang_English];
    [[UIConstants returnInstance] setIsItEnglish:YES];
    
    [[UIConstants returnInstance] setStrAppID: strAppID];
    
    //    if ([[UIConstants returnInstance] connectedToNetwork]) {
    if ([ObjServiceHandler GetSupportedRegion]) {
        [[UIConstants returnInstance] setDicSupportedRegion:[[ResponseDTO sharedInstance] DTO_SupportedRegion]];
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    if ([strAppID isEqualToString:@""] || strAppID == nil) {
        if ([ObjServiceHandler GetMobileRegistrationAPI:strDeviceID :strDeviceID :@"1.2" :@"Android Mobile"]) {
            if ([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 200) {
                [[UIConstants returnInstance] setStrAppID:[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_AppID]];
            [self LoadMainScreen];
            }else{
                NSString *_strTitle;
                if ([[UIConstants returnInstance] isItEnglish]) {
                    _strTitle = Alert_English;
                }else{
                    _strTitle = Alert_Arabic;
                }

                [self ShowAlert :_strTitle:[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusMessage]];
            }
        }else{
            if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
                [[UIConstants returnInstance] ShowNoNetworkAlert];
            }else{
                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
            }
        }
    }else{
        [[UIConstants returnInstance] setStrAppID: strAppID];
        [self LoadMainScreen];
    }
    
    CLLocationManager *ctrlLocationManager = [[CLLocationManager alloc]init];
    ctrlLocationManager.delegate = self;
    ctrlLocationManager.distanceFilter = kCLDistanceFilterNone;
    ctrlLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        [ctrlLocationManager startUpdatingLocation];
    }
    
    [ObjServiceHandler release],ObjServiceHandler = nil;
    NSLog(@"%@",[[UIConstants returnInstance]strAppID]);
    return YES;
    //    }else{
    //        [self ShowAlert :@"No Network Connection":@"No network connection found.Internet connection is required. Please enable your WiFi or 3G connection and retry."];
    //        return NO;
    //    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //    [FileReadWrite writeFile:@"AppID" data:[[NSArray alloc]initWithObjects:[[UIConstants returnInstance] strAppID], [[UIConstants returnInstance] strFosUserID], nil]];
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSArray *aryWritingDetail;
    if ([[UIConstants returnInstance] KeepMeLoggedIn] && [[UIConstants returnInstance] dicUserDetails] != nil) {
        //        [dic setObject:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_EmailID] forKey:key_EmailID];
        //        [dic setObject:[[UIConstants returnInstance] strPassword] forKey:key_PassWord];
        aryWritingDetail = [[NSArray alloc]initWithObjects:[[UIConstants returnInstance] strAppID], [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_EmailID], [[UIConstants returnInstance] strPassword],nil];
        
    }else{
        aryWritingDetail = [[NSArray alloc]initWithObjects:[[UIConstants returnInstance] strAppID],nil];
        //        dic = nil;
    }
    // [FileReadWrite writeFile:@"UserDetail" data:[[NSArray alloc]initWithObjects:dic,nil]];
    
    
    [FileReadWrite writeFile:@"AppID" data:aryWritingDetail];
    
//    for (UIWindow* window in [UIApplication sharedApplication].windows) {
//        NSArray* subviews = window.subviews;
//        [self checkViews:subviews];
//    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //    if (![[UIConstants returnInstance] connectedToNetwork]) {
    //        [self ShowAlert :@"No Network Connection":@"No network connection found.Internet connection is required. Please enable your WiFi or 3G connection and reopen the application."];
    //        return;
    //    }
    //    NSMutableArray *aryAppID = [[NSMutableArray alloc]initWithArray:[FileReadWrite readFile:@"AppID"]];;
    //    NSString *strAppID  = [aryAppID objectAtIndex:0];
    //    if (![strAppID isEqualToString:@""] || strAppID != nil) {
    //        [[UIConstants returnInstance] setStrAppID: strAppID];
    //    }
    //    if ([aryAppID count] > 1) {
    //        NSString *emailID = [aryAppID objectAtIndex:1];
    //        NSString *Password = [aryAppID objectAtIndex:2];
    //        NSLog(@"Email: %@, Password: %@", emailID, Password);
    //    }else{
    //        NSLog(@"No user details");
    //    }
    [[UIConstants returnInstance] RemoveAlertView];
    if (![[UIConstants returnInstance] connectedToNetwork]) {
        [[UIConstants returnInstance] ShowNoNetworkAlert];
    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
//    if ([[UIConstants returnInstance] connectedToNetwork]) {
//        for (UIWindow* window in [UIApplication sharedApplication].windows) {
//            NSArray* subviews = window.subviews;
//            for (UIView *view in subviews) {
//                if ([view isKindOfClass:[UIAlertView class]])
//                    [(UIAlertView *)view dismissWithClickedButtonIndex:0 animated:YES];
//            }
//        }
//    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


#pragma mark - User defined methods

-(void)LoadMainScreen
{
    ctrlFlowLogic = [FlowController initObject];
    [ctrlFlowLogic LoadInitialScreen];
    self.window.rootViewController = ctrlFlowLogic.ctrlNavigator;
    [self.window makeKeyAndVisible];
}

-(void)ShowAlert:(NSString *)Title :(NSString *)Message
{
    alert = [[UIAlertView alloc] initWithTitle:Title message:Message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)checkViews:(NSArray *)subviews {
    Class AVClass = [UIAlertView class];
    Class ASClass = [UIActionSheet class];
    for (UIView * subview in subviews){
        NSLog(@"Class %@", [subview class]);
        if ([subview isKindOfClass:AVClass]){
            [(UIAlertView *)subview dismissWithClickedButtonIndex:[(UIAlertView *)subview cancelButtonIndex] animated:NO];
        } else if ([subview isKindOfClass:ASClass]){
            [(UIActionSheet *)subview dismissWithClickedButtonIndex:[(UIActionSheet *)subview cancelButtonIndex] animated:NO];
        } else {
            [self checkViews:subview.subviews];
        }
    }
}
@end
