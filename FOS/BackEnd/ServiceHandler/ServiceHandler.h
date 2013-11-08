//
//  ServiceHandler.h

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIConstants.h"
#import "JSONCreator.h"
#import "ResponseDTO.h"
#import "ResponseValidator.h"
#import "ServiceInvoker.h"
#import "URLCreator.h"

@interface ServiceHandler : NSObject

-(BOOL)GetMobileRegistrationAPI:(NSString *)ImeiNo :(NSString *)ImsiNo :(NSString *)AppVersion :(NSString *)DeviceType;

-(BOOL)GetFilterListforMobileAPI: (NSString *)AppId;

-(BOOL)GetCityForMobileAPI: (NSString *)AppId;

-(BOOL)GetLocationBasedOnCityCodeForMobileAPI: (NSString *)AppId :(NSString *)CityCode;

-(BOOL)GetWebUserRegistrationAPI: (NSString *)FirstName
                                :(NSString *)LastName
                                :(NSString *)EmailId
                                :(NSString *)Age
                                :(NSString *)PassWord
                                :(NSString *)MobileNumber
                                :(NSString *)IsAddressAvailable
                                :(NSString *)HomeCity
                                :(NSMutableArray *)aryUserAddress
                                :(NSString *)Latitude
                                :(NSString *)Longitude;

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
                                  :(NSString *)Longitude;

-(BOOL)GetWebUserLogInAPI   :(NSString *)EmailId
                            :(NSString *)PassWord;
-(BOOL)GetWebUserChangePasswordAPI :(NSString *)IDFosUser
                                   :(NSString *)EmailId
                                   :(NSString *)OldPassword
                                   :(NSString *)NewPassword;
-(BOOL)GetUserForgotPasswordPAI :(NSString *)EmailId;

-(BOOL)GetRestuarantSearchAPI   :(NSString *)Country
                                :(NSString *)State
                                :(NSString *)City
                                :(NSString *)Area
                                :(NSMutableArray *)FilterGeneral
                                :(NSMutableArray *)FilterCuisineType;
-(BOOL)GetRestaurantMenuListAPI :(NSString *)RestaurantID
                                :(NSString *)AppID;

-(BOOL)GetShowCartSummaryAndApplyCouponCodeAPI :(NSArray *)Restaurants;
-(BOOL)GetCheckOutAPI :(NSArray *)Restaurants PaymentMode: (NSString *)PaymentMode UserID :(NSString *)UserID;
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
                                :(NSString *)LandMark1;

-(BOOL)GetRegisterFosUserInfoAPI :(NSString *)IDFosUser
                                    :(NSString *)AddressName
                                    :(NSString *)IsPrimary
                                    :(NSString *)StreetLine1
                                    :(NSString *)StreetLine2
                                    :(NSString *)Area
                                    :(NSString *)City
                                    :(NSString *)State
                                    :(NSString *)Country
                                    :(NSString *)LandMark1;

-(BOOL)GetValidateOrderRequestAPI :(NSString *)DeliveryMode
                                  :(NSDictionary *)ActorDetails
                                  :(NSArray *)Restaurant;

-(BOOL)GetCheckRestaurantTimingAPI :(NSString *)RestaurantID;

-(BOOL)GetRestaurantListAPI :(NSString *)Country
                            :(NSString *)State
                            :(NSString *)City
                            :(NSString *)ServiceType
                            :(NSString *)SearchString
                            :(NSString *)Area;
-(BOOL)GetAutoSuggestDataAPI;
-(BOOL)GetSupportedRegion;
- (BOOL)GetMenuCategoryList :(NSString *)AppID
                            :(NSString *)RestaurantID
                            :(NSString *)MenuCategoryIdentifier;
- (BOOL)GetMenuItemDetail :(NSString *)AppID
                          :(NSString *)RestaurantID
                          :(NSString *)MenuIdentifier
                          :(NSString *)MenuCategoryIdentifier
                          :(int)isGroup;

- (BOOL)GetOrderHistoryAPI;
- (BOOL)GetSendVerificationCodeAPIwithUserID :(NSString *)UserId IsGuestUser :(NSString *)IsGuestUser OrderId :(NSString *)OrderID;
- (BOOL)GetVerifyVerificationCodeAPIwithUserID :(NSString *)UserId IsGuestUser :(NSString *)IsGuestUser VerificationCode: (NSString *)VerificationCode;
@end
