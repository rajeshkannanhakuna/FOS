//
//  ServiceHandler.m

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "ServiceHandler.h"

//APIValidator *ObjAPIValidator;
URLCreator *ObjURLCreator;
ServiceInvoker *ObjServiceInvoker;
ResponseValidator *ObjResponseValidator;

@implementation ServiceHandler

-(BOOL)GetMobileRegistrationAPI:(NSString *)ImeiNo :(NSString *)ImsiNo :(NSString *)AppVersion :(NSString *)DeviceType
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetMobileRegistrationJSON:ImeiNo :ImsiNo :AppVersion :DeviceType];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetMobileRegistrationURL] Parameters:JSONParameter] :API_GET_MOBILEREGISTRATION];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    
    return requeststate;
}
-(BOOL)GetFilterListforMobileAPI: (NSString *)AppId
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetFilterListforMobileJSON:AppId];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetFilterListforMobileURL] Parameters:JSONParameter] :API_GET_FILTERLISTFORMOBILE];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetCityForMobileAPI: (NSString *)AppId
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetCityForMobileJSON:AppId];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetCityForMobileURL] Parameters:JSONParameter] :API_GET_CITYFORMOBILE];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetLocationBasedOnCityCodeForMobileAPI: (NSString *)AppId :(NSString *)CityCode
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetLocationBasedOnCityCodeForMobileJSON: AppId: CityCode];
    NSLog(@"%@", JSONParameter);
   [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetLocationBasedOnCityCodeForMobileURL] Parameters:JSONParameter] :API_GET_LOCATIONBASEDONCITY];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetWebUserRegistrationAPI :(NSString *)FirstName
                                 :(NSString *)LastName
                                 :(NSString *)EmailId
                                 :(NSString *)Age
                                 :(NSString *)PassWord
                                 :(NSString *)MobileNumber
                                 :(NSString *)IsAddressAvailable
                                 :(NSString *)HomeCity
                                 :(NSMutableArray *)aryUserAddress
                                 :(NSString *)Latitude
                                 :(NSString *)Longitude

{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetWebUserRegistrationJSON:FirstName :LastName :EmailId :Age :PassWord :@"0" :@"" :MobileNumber :@"" :@"1" :HomeCity :aryUserAddress :Latitude :Longitude];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetWebUserRegistrationURL] Parameters:JSONParameter] :API_GET_USERRGISTRATION];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetWebUserUpdateProfileAPI :(NSString *)IDFosUser
                                  :(NSString *)FirstName
                                  :(NSString *)LastName
                                  :(NSString *)EmailId
                                  :(NSString *)Age
                                  :(NSString *)MobileNumber
                                  :(NSString *)IsAddressAvailable
                                  :(NSString *)HomeCity
                                  :(NSMutableArray *)aryUserAddress
                                  :(NSString *)Latitude
                                  :(NSString *)Longitude
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetWebUserUpdateProfileJSON:IDFosUser :FirstName :LastName :EmailId :Age :@"" :MobileNumber :@"" :IsAddressAvailable :HomeCity :aryUserAddress :Latitude :Longitude];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetWebUserUpdateProfileURL] Parameters:JSONParameter] :API_GET_USERUPDATEPROFILE];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetWebUserLogInAPI   :(NSString *)EmailId
                            :(NSString *)PassWord
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetWebUserLogInJSON:EmailId :PassWord];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetWebUserLogInURL] Parameters:JSONParameter] :API_GET_USERLOGIN];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetWebUserChangePasswordAPI :(NSString *)IDFosUser
                                   :(NSString *)EmailId
                                   :(NSString *)OldPassword
                                   :(NSString *)NewPassword
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetWebUserChangePasswordJSON:IDFosUser :EmailId :OldPassword :NewPassword];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetWebUserChangePasswordURL] Parameters:JSONParameter] :API_GET_USERCHANGEPASSWORD];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetUserForgotPasswordPAI :(NSString *)EmailId
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetUserForgotPasswordPAI:EmailId];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetUserForgotPasswordURL] Parameters:JSONParameter] :API_GET_USERFORGOTPASSWORD];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetRestuarantSearchAPI   :(NSString *)Country
                                :(NSString *)State
                                :(NSString *)City
                                :(NSString *)Area
                                :(NSMutableArray *)FilterGeneral
                                :(NSMutableArray *)FilterCuisineType
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetRestuarantSearchJSON:Country :State :City :Area :FilterGeneral :FilterCuisineType];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetRestuarantSearchURL] Parameters:JSONParameter] :API_GET_RESTAURANTSEARCH];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetRestaurantMenuListAPI:(NSString *)RestaurantID :(NSString *)AppID
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetRestaurantMenuListJSON:RestaurantID :AppID];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetRestaurantMenuListURL] Parameters:JSONParameter] :API_GET_RESTAURANTMENULIST];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetShowCartSummaryAndApplyCouponCodeAPI :(NSArray *)Restaurants
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetShowCartSummaryAndApplyCouponCodeJSON:Restaurants];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetShowCartSummaryAndApplyCouponCodeURL] Parameters:JSONParameter] :API_GET_SHOWCARTSUMMARY];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetCheckOutAPI:(NSArray *)Restaurants PaymentMode:(NSString *)PaymentMode UserID:(NSString *)UserID
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetCheckOutJSON:Restaurants PaymentMode:PaymentMode UserID:UserID];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetCheckOutURL] Parameters:JSONParameter] :API_GET_CHECKOUT];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
//Proceed to CheckOut and Payment API

-(BOOL)GetRegisterGuestUserAPI  :(NSString *)EmailID
                                :(NSString *)Name
                                :(NSString *)MobileNumber
                                :(NSString *)IsAddressAvailable
                                :(NSString *)StreetLine1
                                :(NSString *)StreetLine2
                                :(NSString *)Area
                                :(NSString *)City
                                :(NSString *)State
                                :(NSString *)Country
                                :(NSString *)LandMark1
                                
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetRegisterGuestUserJSON:EmailID :Name :MobileNumber :IsAddressAvailable  :StreetLine1 :StreetLine2 :Area :City :State :Country :LandMark1  ];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetRegisterGuestUserURL] Parameters:JSONParameter] :API_GET_REGISTERGUESTUSER];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetRegisterFosUserInfoAPI:(NSString *)IDFosUser :(NSString *)AddressName :(NSString *)IsPrimary :(NSString *)StreetLine1 :(NSString *)StreetLine2 :(NSString *)Area :(NSString *)City :(NSString *)State :(NSString *)Country :(NSString *)LandMark1
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetRegisterFosUserInfoJSON :IDFosUser :AddressName :IsPrimary   :StreetLine1 :StreetLine2 :Area :City :State :Country  :LandMark1 ];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetRegisterFosUserInfoURL] Parameters:JSONParameter] :API_GET_REGISTERFosUSER];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetValidateOrderRequestAPI :(NSString *)DeliveryMode
                                  :(NSDictionary *)ActorDetails
                                  :(NSArray *)Restaurant
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetValidateOrderRequestJSON:DeliveryMode :ActorDetails :Restaurant];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetValidateOrderRequestURL] Parameters:JSONParameter] :API_GET_VALIDATEORDERREQUEST];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetCheckRestaurantTimingAPI :(NSString *)RestaurantID
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetCheckRestaurantTimingJSON:RestaurantID];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetCheckRestaurantTimingURL] Parameters:JSONParameter] :API_GET_CHECKRESTAURANTTIMING];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetRestaurantListAPI :(NSString *)Country
                            :(NSString *)State
                            :(NSString *)City
                            :(NSString *)ServiceType
                            :(NSString *)SearchString
                            :(NSString *)Area
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetRestaurantListJSON:Country :State :City :ServiceType :SearchString :Area];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetRestaurantListURL] Parameters:JSONParameter] :API_GET_RESTAURANTLIST];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
-(BOOL)GetAutoSuggestDataAPI
{
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetAutoSuggestedDataURL] Parameters:nil] :API_GET_AUTOSUGGESTDATA];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;

}
-(BOOL)GetSupportedRegion
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetSupportedRegionJSON];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetSupportedRegionURL] Parameters:JSONParameter] :API_GET_SUPPORTEDREGION];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;

}


- (BOOL)GetMenuCategoryList:(NSString *)AppID :(NSString *)RestaurantID :(NSString *)MenuCategoryIdentifier
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetMenuCategoryListJSON:AppID :RestaurantID :MenuCategoryIdentifier];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetMenuCategoryListURL] Parameters:JSONParameter] :API_GET_MENUCATEGORY];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

- (BOOL)GetMenuItemDetail:(NSString *)AppID :(NSString *)RestaurantID :(NSString *)MenuIdentifier :(NSString *)MenuCategoryIdentifier :(int)isGroup
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetMenuItemDetailJSON:AppID :RestaurantID :MenuIdentifier :MenuCategoryIdentifier :isGroup];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetMenuItemDetailURL] Parameters:JSONParameter] :API_GET_MENUITEMDETAIL];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetOrderHistoryAPI
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetOrderHistoryJSON];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetOrderHistoryURL] Parameters:JSONParameter] :API_GET_ORDERHISTORY];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetSendVerificationCodeAPIwithUserID:(NSString *)UserId IsGuestUser:(NSString *)IsGuestUser OrderId:(NSString *)OrderID
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetSendVerificationCodeJSONwithUserID:UserId IsGuestUser:IsGuestUser OrderId:OrderID];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetSendVerificationCodeURL] Parameters:JSONParameter] :API_GET_SENDVERFICATIONCODE];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}

-(BOOL)GetVerifyVerificationCodeAPIwithUserID:(NSString *)UserId IsGuestUser:(NSString *)IsGuestUser VerificationCode:(NSString *)VerificationCode
{
    JSONCreator *objJsonCreator = [[JSONCreator alloc]init];
    NSString *JSONParameter = [objJsonCreator GetVerifyVerificationCodeJSONwithUserID:UserId IsGuestUser:IsGuestUser VerificationCode:VerificationCode];
    NSLog(@"%@", JSONParameter);
    [objJsonCreator release], objJsonCreator = nil;
    
    BOOL requeststate;
    ObjServiceInvoker = [[ServiceInvoker alloc] init];
    ObjResponseValidator = [[ResponseValidator alloc] init];
    ObjURLCreator        = [[URLCreator alloc] init];
    
    requeststate = [ObjResponseValidator validatingResponse:[ObjServiceInvoker InvokingAPI:[ObjURLCreator GetVerifyVerificationCodeURL] Parameters:JSONParameter] :API_GET_VERIFYCODE];
    
    [ObjResponseValidator release],ObjResponseValidator = nil;
    [ObjServiceInvoker release],ObjServiceInvoker = nil;
    [ObjURLCreator release], ObjURLCreator = nil;
    return requeststate;
}
@end
