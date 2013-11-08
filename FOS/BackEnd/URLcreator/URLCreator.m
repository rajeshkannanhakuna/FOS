//
//  URLCreator.m

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "URLCreator.h"

@implementation URLCreator

-(NSString *)GetMobileRegistrationURL
{
    return [NSString stringWithFormat:@"%@/mobile/register",BaseURL];
    
}
-(NSString *)GetFilterListforMobileURL
{
    return [NSString stringWithFormat:@"%@/search/filter",BaseURL];
}
-(NSString *)GetCityForMobileURL
{
    return [NSString stringWithFormat:@"%@/restaurant/branches",BaseURL];
}
-(NSString *)GetLocationBasedOnCityCodeForMobileURL
{
    return [NSString stringWithFormat:@"%@/web/arealist",BaseURL];
}
-(NSString *)GetWebUserRegistrationURL
{
    return [NSString stringWithFormat:@"%@/web/user/registration",BaseURL];
}
-(NSString *)GetWebUserUpdateProfileURL
{
    return [NSString stringWithFormat:@"%@/web/user/updateprofile",BaseURL];
}
-(NSString *)GetWebUserLogInURL
{
    return [NSString stringWithFormat:@"%@/web/user/login",BaseURL];
}
-(NSString *)GetWebUserChangePasswordURL
{
    return [NSString stringWithFormat:@"%@/web/user/changepassword",BaseURL];
}
-(NSString *)GetUserForgotPasswordURL
{
    return [NSString stringWithFormat:@"%@/web/user/forgotpassword",BaseURL];
}
-(NSString *)GetRestuarantSearchURL
{
    return [NSString stringWithFormat:@"%@/search/restaurant",BaseURL];
}
-(NSString *)GetRestaurantMenuListURL
{
    return [NSString stringWithFormat:@"%@/menu/categories",BaseURL];
}
-(NSString *)GetShowCartSummaryAndApplyCouponCodeURL
{
    return [NSString stringWithFormat:@"%@/restaurant/menu/order/validation",BaseURL];
}

-(NSString *)GetCheckOutURL
{
    return [NSString stringWithFormat:@"%@/restaurant/menu/order/checkout",BaseURL];
}

-(NSString *)GetRegisterGuestUserURL
{
    return [NSString stringWithFormat:@"%@/web/guestuser/register",BaseURL];
}
-(NSString *)GetRegisterFosUserInfoURL
{
    return [NSString stringWithFormat:@"%@/web/user/add/deliveryaddress",BaseURL];
}
-(NSString *)GetValidateOrderRequestURL
{
    return [NSString stringWithFormat:@"%@/restaurant/menu/order/update",BaseURL];
}
-(NSString *)GetCheckRestaurantTimingURL
{
    return [NSString stringWithFormat:@"%@/search/timings",BaseURL];
}
-(NSString *)GetRestaurantListURL
{
    return [NSString stringWithFormat:@"%@/search/restaurant",BaseURL];
}
-(NSString *)GetSupportedRegionURL
{
    return [NSString stringWithFormat:@"%@/web/supportedregions",BaseURL];
}
-(NSString *)GetAutoSuggestedDataURL
{
    return [NSString stringWithFormat:@"%@/web/supportedregions",BaseURL];
}
-(NSString *)GetMenuCategoryListURL
{
    return [NSString stringWithFormat:@"%@/menu/category/menus",BaseURL];
}
-(NSString *)GetMenuItemDetailURL
{
    return [NSString stringWithFormat:@"%@/menu/item",BaseURL];
}
-(NSString *)GetOrderHistoryURL
{
    return [NSString stringWithFormat:@"%@/restaurant/order/history",BaseURL];
}
-(NSString *)GetSendVerificationCodeURL
{
    return [NSString stringWithFormat:@"%@/web/send/otp",BaseURL];
}
-(NSString *)GetVerifyVerificationCodeURL
{
    return [NSString stringWithFormat:@"%@/web/verify/otp",BaseURL];
}
@end
