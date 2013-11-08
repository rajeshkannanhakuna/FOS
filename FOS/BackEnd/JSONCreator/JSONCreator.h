//
//  JSONCreator.h
//  
//
//  Created by segate on 14/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONCreator : NSObject

-(id)GetMobileRegistrationJSON:(NSString *)ImeiNo :(NSString *)ImsiNo :(NSString *)AppVersion :(NSString *)DeviceType;
-(id)GetFilterListforMobileJSON: (NSString *)AppId;
-(id)GetCityForMobileJSON: (NSString *)AppId;
-(id)GetLocationBasedOnCityCodeForMobileJSON: (NSString *)AppId :(NSString *)CityCode;
-(id)GetWebUserRegistrationJSON: (NSString *)FirstName
                                :(NSString *)LastName
                                :(NSString *)EmailId
                                :(NSString *)Age
                                :(NSString *)PassWord
                                :(NSString *)IsFBuser
                                :(NSString *)FBUniqueId
                                :(NSString *)MobileNumber
                                :(NSString *)HomePhone
                                :(NSString *)IsAddressAvailable
                                :(NSString *)HomeCity
                                :(NSMutableArray *)aryUserAddress
                                :(NSString *)Latitude
                                :(NSString *)Longitude;

-(id)GetWebUserUpdateProfileJSON :(NSString *)IDFosUser
                                 :(NSString *)FirstName
                                 :(NSString *)LastName
                                 :(NSString *)EmailId
                                 :(NSString *)Age
                                 :(NSString *)IsFBUser
                                 :(NSString *)MobileNumber
                                 :(NSString *)HomePhone
                                 :(NSString *)IsAddressAvailable
                                 :(NSString *)HomeCity
                                 :(NSMutableArray *)aryUserAddress
                                 :(NSString *)Latitude
                                 :(NSString *)Longitude;
-(id)GetWebUserLogInJSON   :(NSString *)EmailId
                            :(NSString *)PassWord;
-(id)GetWebUserChangePasswordJSON :(NSString *)IDFosUser
                                   :(NSString *)EmailId
                                   :(NSString *)OldPassword
                                   :(NSString *)NewPassword;
-(id)GetUserForgotPasswordPAI :(NSString *)EmailId;

-(id)GetRestuarantSearchJSON   :(NSString *)Country
                                :(NSString *)State
                                :(NSString *)City
                                :(NSString *)Area
                                :(NSMutableArray *)FilterGeneral
                                :(NSMutableArray *)FilterCuisineType;
-(id)GetRestaurantMenuListJSON :(NSString *)RestaurantID
                                :(NSString *)AppID;

-(id)GetShowCartSummaryAndApplyCouponCodeJSON :(NSArray *)Restaurants;
-(id)GetCheckOutJSON :(NSArray *)Restaurants PaymentMode: (NSString *)PaymentMode UserID :(NSString *)UserID;

//Proceed to CheckOut and Payment JSON

-(id)GetRegisterGuestUserJSON  :(NSString *)EmailID
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

-(id)GetRegisterFosUserInfoJSON :(NSString *)IDFosUser
                                    :(NSString *)AddressName
                                    :(NSString *)IsPrimary
                                    :(NSString *)StreetLine1
                                    :(NSString *)StreetLine2
                                    :(NSString *)Area
                                    :(NSString *)City
                                    :(NSString *)State
                                    :(NSString *)Country
                                    :(NSString *)LandMark1;

-(id)GetValidateOrderRequestJSON :(NSString *)DeliveryMode
                                  :(NSDictionary *)ActorDetails
                                  :(NSArray *)Restaurant;

-(id)GetCheckRestaurantTimingJSON :(NSString *)RestaurantID;

-(id)GetRestaurantListJSON :(NSString *)Country
                            :(NSString *)State
                            :(NSString *)City
                            :(NSString *)ServiceType
                            :(NSString *)SearchString
                            :(NSString *)Area;

- (id)GetMenuCategoryListJSON :(NSString *)AppID
                              :(NSString *)RestaurantID
                              :(NSString *)MenuCategoryIdentifier;

- (id)GetMenuItemDetailJSON   :(NSString *)AppID
                              :(NSString *)RestaurantID
                              :(NSString *)MenuIdentifier
                              :(NSString *)MenuCategoryIdentifier
                              :(int)isGroup;

- (id)GetSupportedRegionJSON;
- (id)GetOrderHistoryJSON;
- (id)GetSendVerificationCodeJSONwithUserID :(NSString *)UserId IsGuestUser :(NSString *)IsGuestUser OrderId :(NSString *)OrderID;
- (id)GetVerifyVerificationCodeJSONwithUserID :(NSString *)UserId IsGuestUser :(NSString *)IsGuestUser VerificationCode:(NSString *)VerificationCode;

- (NSArray *)RemoveUnnecessarykeyValuesForDictionary: (NSArray *)aryRestaurant;
@end    
