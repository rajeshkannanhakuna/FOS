//
//  URLCreator.h

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIConstants.h"

@interface URLCreator : NSObject

-(NSString *)GetMobileRegistrationURL;
-(NSString *)GetFilterListforMobileURL;
-(NSString *)GetCityForMobileURL;
-(NSString *)GetLocationBasedOnCityCodeForMobileURL;
-(NSString *)GetWebUserRegistrationURL;
-(NSString *)GetWebUserUpdateProfileURL;
-(NSString *)GetWebUserLogInURL ;
-(NSString *)GetWebUserChangePasswordURL;
-(NSString *)GetUserForgotPasswordURL;
-(NSString *)GetRestuarantSearchURL ;
-(NSString *)GetRestaurantMenuListURL;
-(NSString *)GetShowCartSummaryAndApplyCouponCodeURL;
-(NSString *)GetRegisterGuestUserURL ;
-(NSString *)GetRegisterFosUserInfoURL;
-(NSString *)GetValidateOrderRequestURL;
-(NSString *)GetCheckRestaurantTimingURL;
-(NSString *)GetRestaurantListURL;
-(NSString *)GetSupportedRegionURL;
-(NSString *)GetAutoSuggestedDataURL;
-(NSString *)GetMenuCategoryListURL;
-(NSString *)GetMenuItemDetailURL;
-(NSString *)GetCheckOutURL;
-(NSString *)GetOrderHistoryURL;
-(NSString *)GetSendVerificationCodeURL;
-(NSString *)GetVerifyVerificationCodeURL;
@end
