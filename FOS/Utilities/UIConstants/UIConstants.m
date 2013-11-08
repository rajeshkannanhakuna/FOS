//
//  UIConstants.m

//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "UIConstants.h"
#import "Reachability.h"
#import "ServiceHandler.h"
#import "LanguageConstants.h"
#import <UIKit/UIKit.h>


@interface UIConstants ()
{
    NSCache *imageCache;
}

@end
UIAlertView *alert1;
UIConstants *ObjUIConstants;
@implementation UIConstants

@synthesize isItEnglish;
@synthesize isItemCleared;
@synthesize decimalPoint;

@synthesize strLanguage;
@synthesize strAppID;
@synthesize dicRestaurantDetails;
@synthesize arySelectedGeneralFilter;
@synthesize arySelectedFilters;
@synthesize dicLocationDetails;
@synthesize strServiceType;
@synthesize strAreaName;
@synthesize strFosUserID;
@synthesize strFosUserName;
@synthesize strCityCode;
@synthesize aryRestaurantsList;
@synthesize isLoginViaHome;
@synthesize arySupportedArea;
@synthesize arySupportedCities;
@synthesize KeepMeLoggedIn;
@synthesize dicUserDetails;
@synthesize strMenuItemName;
@synthesize strMenuCategoryName;
@synthesize strMenuCategoryIdentifier;
@synthesize strMenuIdentifier;
@synthesize strPassword;
@synthesize aryCartDetails;
@synthesize strCurrencyCode;
@synthesize dicSupportedRegion;
@synthesize aryOrderedRestaurantsList;
@synthesize aryDeliverySupportedAreas;
@synthesize strMaxDeliveryTime;
@synthesize strDecimalPoints;
@synthesize strUserMobileNo;
@synthesize strMinOrderValue;
@synthesize strTax;
@synthesize isMobileNumberVerfied;
@synthesize aryCouponDetails;
@synthesize strOrderID;
@synthesize strOrderNumber;
@synthesize strGuestUserID;
@synthesize strMinPreparationTime;
@synthesize isAlertViewShowing;
@synthesize IsComingViaMyOrders;
@synthesize strLatitude;
@synthesize strLongitude;
@synthesize IsBackFromPaymentOrMobileVerify;
@synthesize IsComingForEditing;
@synthesize strIsGroup;
@synthesize dicSelectedItemFromOrderSummary;
#pragma mark - Methods

+(UIConstants *)returnInstance
{
    if (nil == ObjUIConstants) {
        ObjUIConstants = [[UIConstants alloc]init];
    }
    return ObjUIConstants;
}

- (BOOL) connectedToNetwork
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
		internet = NO;
	} else {
		internet = YES;
	}
	return internet;
}

-(void)ShowAlert:(NSString *)Message
{
    NSString *_strTitle;
    NSString *_strOK;
    if (self.isItEnglish) {
        _strTitle = Alert_English;
        _strOK = OK_English;
    }else{
        _strTitle = Alert_Arabic;
        _strOK = OK_Arabic;
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_strTitle message:Message delegate:nil cancelButtonTitle:_strOK otherButtonTitles:nil];
    
    [alert show];
    [alert release];
}

-(void)ClearFilterCache
{
    [ObjUIConstants setArySelectedFilters:nil];
    [ObjUIConstants setArySelectedGeneralFilter:nil];
}
- (UIFont *) returnArvoBold :(int)size{
    UIFont *font = [UIFont fontWithName:@"Arvo-Bold" size:size];
    return font;
}
- (UIFont *) returnArvoRegular :(int)size{
    UIFont *font = [UIFont fontWithName:@"Arvo" size:size];
    return font;
}

-(UIFont *)returnCharcoalCY:(int)size
{
    return  [UIFont fontWithName:@"CharcoalCY" size:size];
}
- (NSString *) convertToDecimalValue :(float) val {
    if(decimalPoint == 2)
        return [NSString stringWithFormat:@"%.2f",val];
    else return [NSString stringWithFormat:@"%.3f",val];
}

-(void)ShowNoNetworkAlert
{
//    if (alert1) {
//        [alert1 release], alert1 = nil;
//    }
    NSString *_strTitle;
    NSString *_strMessage;
    if (self.isItEnglish) {
        _strTitle = NoNetworkConnection_English;
        _strMessage = Alert_NoNetworkConnection_English;
    }else{
        _strTitle = NoNetworkConnection_Arabic;
        _strMessage = Alert_NoNetworkConnection_Arabic;
    }
    alert1 = [[UIAlertView alloc] initWithTitle:_strTitle
                                        message:_strMessage
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil];
    [alert1 show];
    [alert1 release];
    self.isAlertViewShowing = YES;
}

-(UIImage *)ReturnImageForURL:(NSString *)imageURL
{
    if(!imageCache){
        imageCache = [[NSCache alloc] init];
    }
    NSLog(@"Image URL: %@", imageURL);
    UIImage *image = nil;
    imageURL = [imageURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(![imageURL isEqual:[NSNull null]] && nil != imageURL && ![imageURL isEqualToString:@""]) {
        
        if([imageCache objectForKey:imageURL]){
            return [imageCache objectForKey:imageURL];
        }
        NSURL *URL = [NSURL URLWithString:imageURL];
        NSData *imageData = [NSData dataWithContentsOfURL:URL];
        if (imageData != nil) {
            image = [UIImage imageWithData:imageData];
            [imageCache setObject:image forKey:imageURL];
            return image;
        }else{
            return nil;
        }
    }else return nil;
}

-(void)ShowMobileNumberVerifcationAlert
{
    NSString *_strTitle;
    NSString *_strMessage;
    NSString *_strVerify;
    NSString *_strSkip;
    if (self.isItEnglish) {
        _strTitle = VerifyMobileNumber_English;
        _strMessage = Alert_VerifyMobileNumber_English;
        _strVerify = Verify_Eng;
        _strSkip = Skip_English;
    }else{
        _strTitle = VerifyMobileNumber_Arabic;
        _strMessage = Alert_VerifyMobileNumber_Arabic;
        _strVerify = Verify_Arabic;
        _strSkip = Skip_Arabic;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_strTitle message:_strMessage delegate:self   cancelButtonTitle:_strVerify otherButtonTitles:_strSkip, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 2;
    [alert show];
    [alert release];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {
        ServiceHandler *ObjServicehandler = [[ServiceHandler alloc] init];
        if (buttonIndex == 0) {
            if ([ObjServicehandler GetVerifyVerificationCodeAPIwithUserID:[[UIConstants returnInstance] strFosUserID] IsGuestUser:@"0" VerificationCode:[alertView textFieldAtIndex:0].text]) {
                if([[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Status] integerValue] == 0){
                    [[UIConstants returnInstance] setIsMobileNumberVerfied:NO];
                    NSString *_strTitle;
                    NSString *_strOK;
                    if (self.isItEnglish) {
                        _strTitle = Alert_English;
                        _strOK = OK_English;
                    }else{
                        _strTitle = Alert_Arabic;
                        _strOK = OK_Arabic;
                    }
                    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:_strTitle message:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message] delegate:self cancelButtonTitle:_strOK otherButtonTitles:nil];
                    alert2.tag = 1;
                    [alert2 show];
                    [alert2 release];
                }else{
                    [[UIConstants returnInstance] setIsMobileNumberVerfied:YES];
                    [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
                }
            }else{
                if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
                    [[UIConstants returnInstance] ShowNoNetworkAlert];
                }else{
                    [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
                }
            }
            [ObjServicehandler release], ObjServicehandler = nil;
        }else if (buttonIndex == 1) {
            [[UIConstants returnInstance] setIsMobileNumberVerfied:NO];
        }
    }else{
        [self ShowMobileNumberVerifcationAlert];
    }
}

-(void)RemoveAlertView
{
    if (self.isAlertViewShowing) {
        [alert1 dismissWithClickedButtonIndex:[alert1 cancelButtonIndex] animated:YES];
        self.isAlertViewShowing = NO;
    }
}

- (CGRect) getFrameForLanguage:(CGRect)rect withSuperViewRect:(CGRect)superviewRect
{
    if([self isItEnglish]){
        return rect;
    }
    CGRect arabicRect = CGRectZero;
    arabicRect.origin.x = superviewRect.size.width - (rect.origin.x + rect.size.width);
    arabicRect.origin.y = rect.origin.y;
    arabicRect.size.width = rect.size.width;
    arabicRect.size.height = rect.size.height;
    
    return arabicRect;
    
    
}
-(void)ClearCart
{
    [ObjUIConstants setAryCartDetails:nil];
    [ObjUIConstants setAryOrderedRestaurantsList:nil];
    [ObjUIConstants setAryCouponDetails:nil];
    [ObjUIConstants setStrGuestUserID:nil];
    [ObjUIConstants setStrMaxDeliveryTime:nil];
    [ObjUIConstants setStrMenuCategoryIdentifier:nil];
    [ObjUIConstants setStrMenuCategoryName:nil];
    [ObjUIConstants setStrMenuIdentifier:nil];
    [ObjUIConstants setStrMenuItemName:nil];
    [ObjUIConstants setStrMinOrderValue:nil];
    [ObjUIConstants setStrMinPreparationTime:nil];
    [ObjUIConstants setStrOrderID:nil];
    [ObjUIConstants setStrOrderNumber:nil];
    [ObjUIConstants setStrTax:nil];
    [ObjUIConstants setStrUserMobileNo:nil];
}

- (NSDate *) dateFromString :(NSString *)datestr withFormat:(NSString *) format
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date =[formatter dateFromString:datestr];
    return date;
    
}

- (NSString *) stringFromDate:(NSDate *)date withFormat:(NSString *) format
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}


#pragma mark - Get Quantity Method

-(int)GetQuantityForIdentifier:(NSString *)Identifier isForMenu:(BOOL)ForMenu
{
    NSString *keyForIdentifier;
    if (ForMenu) {
        keyForIdentifier = key_MenuCategoryIdentifier;
    }else{
        keyForIdentifier = key_MenuIdentifier;
    }
    NSLog(@"Key For Identifier: %@", keyForIdentifier);
    int Quantity = 0;
    for (NSDictionary *dicItem in [[UIConstants returnInstance] aryCartDetails]) {
        NSLog(@"%@\n %@ isEqual %@",dicItem,[dicItem objectForKey:keyForIdentifier], Identifier);
        if ([[dicItem objectForKey:keyForIdentifier] isEqualToString:Identifier]) {
            Quantity = Quantity + [[dicItem objectForKey:key_Quantity] integerValue];
        }
    }
    return Quantity;
}


@end
