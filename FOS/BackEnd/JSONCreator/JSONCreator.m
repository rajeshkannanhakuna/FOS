//
//  JSONCreator.m
//  
//
//  Created by segate on 14/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "JSONCreator.h"
#import "APIConstants.h"
#import "JSON.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
@implementation JSONCreator

-(id)GetMobileRegistrationJSON:(NSString *)ImeiNo :(NSString *)ImsiNo :(NSString *)AppVersion :(NSString *)DeviceType
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:ImeiNo forKey:key_IMEI];
    [dic setObject:ImsiNo forKey:key_IMSI];
    [dic setObject:AppVersion forKey:key_AppVersion];
    [dic setObject:DeviceType forKey:key_DeviceType];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    //[dic setObject:_strLanguage forKey:key_langCode];
    
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
    
}
-(id)GetFilterListforMobileJSON: (NSString *)AppId
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:AppId forKey:key_SessionId];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
-(id)GetCityForMobileJSON: (NSString *)AppId
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:AppId forKey:key_AppID];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
-(id)GetLocationBasedOnCityCodeForMobileJSON: (NSString *)AppId :(NSString *)CityCode
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:AppId forKey:key_AppID];
    [dic setObject:CityCode forKey:key_CityCode];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
-(id)GetWebUserRegistrationJSON :(NSString *)FirstName
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
                                :(NSString *)Longitude
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:FirstName forKey:key_FirstName];
    [dic setObject:LastName forKey:key_LastName];
    [dic setObject:EmailId forKey:key_EmailID];
    [dic setObject:Age forKey:key_Age];
    [dic setObject:PassWord forKey:key_PassWord];
    [dic setObject:IsFBuser forKey:key_IsFbUser];
    [dic setObject:FBUniqueId forKey:key_FBUniqueId];
    [dic setObject:MobileNumber forKey:key_MobileNo];
    [dic setObject:HomePhone forKey:key_HomePhone];
    [dic setObject:IsAddressAvailable forKey:key_IsAddressAvailable];
    if (HomeCity == nil) {
        HomeCity = @"";
    }
    [dic setObject:HomeCity forKey:key_HomeCity];
    [dic setObject:aryUserAddress forKey:key_UserAddress];

    [dic setObject:[NSDictionary dictionaryWithObjectsAndKeys:@"",key_IpAddress, @"MAPP", key_ClientType, @"", key_UserAgent, Latitude, key_Latitude, Longitude, key_Longitude, nil] forKey:key_ActorDetail];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
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
                                 :(NSString *)Longitude
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:IDFosUser forKey:key_IdUser];
    [dic setObject:FirstName forKey:key_FirstName];
    [dic setObject:LastName forKey:key_LastName];
    [dic setObject:EmailId forKey:key_EmailID];
    [dic setObject:Age forKey:key_Age];
    [dic setObject:IsFBUser forKey:key_IsFbUser];
    [dic setObject:MobileNumber forKey:key_MobileNo];
    [dic setObject:HomePhone forKey:key_HomePhone];
    [dic setObject:IsAddressAvailable forKey:key_IsAddressAvailable];
    if (HomeCity == nil) {
        HomeCity = @"";
    }
    [dic setObject:HomeCity forKey:key_HomeCity];
    [dic setObject:aryUserAddress forKey:key_UserAddress];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
-(id)GetWebUserLogInJSON   :(NSString *)EmailId
                           :(NSString *)PassWord
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:EmailId forKey:key_EmailID];
    [dic setObject:PassWord forKey:key_PassWord];
    [dic setObject:@"0" forKey:key_IsFbUser];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
-(id)GetWebUserChangePasswordJSON :(NSString *)IDFosUser
                                  :(NSString *)EmailId
                                  :(NSString *)OldPassword
                                  :(NSString *)NewPassword
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:IDFosUser forKey:key_IdUser];
    [dic setObject:EmailId forKey:key_Email];
    [dic setObject:OldPassword forKey:key_OldPassWord];
    [dic setObject:NewPassword forKey:key_NewPassword];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
-(id)GetUserForgotPasswordPAI :(NSString *)EmailId
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:EmailId forKey:key_Email];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetRestuarantSearchJSON   :(NSString *)Country
                               :(NSString *)State
                               :(NSString *)City
                               :(NSString *)Area
                               :(NSMutableArray *)FilterGeneral
                               :(NSMutableArray *)FilterCuisineType
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:Country forKey:key_Country];
    [dic setObject:State forKey:key_State];
    [dic setObject:City forKey:key_City];
    [dic setObject:Area forKey:key_Area];
    [dic setObject:FilterGeneral forKey:key_FilterGeneral];
    [dic setObject:FilterCuisineType forKey:key_FilterCuisineType];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
-(id)GetRestaurantMenuListJSON :(NSString *)RestaurantID
                               :(NSString *)AppID
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:RestaurantID forKey:key_RestaurantIdentifier];
    [dic setObject:AppID forKey:key_AppID];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetShowCartSummaryAndApplyCouponCodeJSON :(NSArray *)Restaurants
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[[UIConstants returnInstance] strServiceType] forKey:key_DeliveryMode];
    NSString *IsGuest = @"true";
    NSString* UserID = @"";
    if ([[UIConstants returnInstance] strFosUserID]) {
        IsGuest = @"false";
        UserID = [[UIConstants returnInstance] strFosUserID];
    }
    [dic setObject:[NSDictionary dictionaryWithObjectsAndKeys:IsGuest, key_IsGuest, UserID, key_UserId,@"ANDROID_APP", key_UserAgent, nil] forKey:key_ActorDetail];
    [dic setObject:[self RemoveUnnecessarykeyValuesForDictionary:Restaurants] forKey:key_Restaurants];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetCheckOutJSON:(NSArray *)Restaurants PaymentMode:(NSString *)PaymentMode UserID:(NSString *)UserID
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:PaymentMode forKey:key_PaymentMethod];
    [dic setObject:[[UIConstants returnInstance] strServiceType] forKey:key_DeliveryMode];
    NSString *IsGuest = @"true";
    if([[UIConstants returnInstance] strFosUserID]) {
        IsGuest = @"false";
    }
    [dic setObject:[NSDictionary dictionaryWithObjectsAndKeys:IsGuest, key_IsGuest, UserID, key_UserId,@"ANDROID_APP", key_UserAgent, nil] forKey:key_ActorDetail];
    [dic setObject:[self RemoveUnnecessarykeyValuesForDictionary:Restaurants] forKey:key_Restaurants];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}
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
                               :(NSString *)LandMark1
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:EmailID forKey:key_EmailID];
    [dic setObject:Name forKey:key_Name];
    [dic setObject:MobileNumber forKey:key_MobileNo];
    [dic setObject:IsAddressAvailable forKey:key_IsAddressAvailable];
    if ([IsAddressAvailable isEqual: @"1"]) {
        [dic setObject:StreetLine1 forKey:key_StreetLine1];
        [dic setObject:StreetLine2 forKey:key_StreetLine2];
        [dic setObject:Area forKey:key_Area];
        [dic setObject:City forKey:key_City];
        [dic setObject:State forKey:key_State];
        [dic setObject:Country forKey:key_Country];
        [dic setObject:LandMark1 forKey:key_LandMark1];
    }
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
#warning remove temp static values
    [dic setObject:@"" forKey:key_Pin];
    [dic setObject:@"" forKey:key_BuildingName];
    [dic setObject:@"" forKey:key_DoorNo];
    
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetRegisterFosUserInfoJSON:(NSString *)IDFosUser :(NSString *)AddressName :(NSString *)IsPrimary :(NSString *)StreetLine1 :(NSString *)StreetLine2 :(NSString *)Area :(NSString *)City :(NSString *)State :(NSString *)Country :(NSString *)LandMark1
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:IDFosUser forKey:key_IdUser];
    [dic setObject:AddressName forKey:key_AddressName];
    [dic setObject:IsPrimary forKey:key_IsPrimary];
    [dic setObject:StreetLine1 forKey:key_StreetLine1];
    [dic setObject:StreetLine2 forKey:key_StreetLine2];
    [dic setObject:Area forKey:key_Area];
    [dic setObject:City forKey:key_City];
    [dic setObject:State forKey:key_State];
    [dic setObject:Country forKey:key_Country];
    [dic setObject:LandMark1 forKey:key_Landmark1];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    
#warning remove temp static values
    [dic setObject:@"" forKey:key_PinCode];
    [dic setObject:@"" forKey:key_BuildingName];
    [dic setObject:@"" forKey:key_DoorNo];
    
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetValidateOrderRequestJSON :(NSString *)DeliveryMode
                                 :(NSDictionary *)ActorDetails
                                 :(NSArray *)Restaurant
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:DeliveryMode forKey:key_DeliveryMode];
    [dic setObject:ActorDetails forKey:key_ActorDetail];
    [dic setObject:[self RemoveUnnecessarykeyValuesForDictionary:Restaurant] forKey:key_Restaurants];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetCheckRestaurantTimingJSON :(NSString *)RestaurantID
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:RestaurantID forKey:key_RestaurantID];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetRestaurantListJSON :(NSString *)Country
                           :(NSString *)State
                           :(NSString *)City
                           :(NSString *)ServiceType
                           :(NSString *)SearchString
                           :(NSString *)Area
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:Country forKey:key_Country];
    [dic setObject:State forKey:key_State];
    [dic setObject:City forKey:key_City];
    [dic setObject:ServiceType forKey:key_ServiceType];
    [dic setObject:SearchString forKey:key_SearchString];
    [dic setObject:Area forKey:key_Area];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetMenuCategoryListJSON:(NSString *)AppID :(NSString *)RestaurantID :(NSString *)MenuCategoryIdentifier
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:AppID forKey:key_AppID];
    [dic setObject:RestaurantID forKey:key_RestaurantIdentifier];
    [dic setObject:MenuCategoryIdentifier forKey:key_MenuCategoryIdentifier];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

- (id)GetMenuItemDetailJSON:(NSString *)AppID :(NSString *)RestaurantID :(NSString *)MenuIdentifier :(NSString *)MenuCategoryIdentifier :(int)isGroup
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:AppID forKey:key_AppID];
    [dic setObject:RestaurantID forKey:key_RestaurantID];
    [dic setObject:MenuIdentifier forKey:key_MenuIdentifier];
    [dic setObject:MenuCategoryIdentifier forKey:key_MenuCategoryIdentifier];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    [dic setValue:[NSNumber numberWithInt:isGroup] forKey:key_isGroup];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetSupportedRegionJSON
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetOrderHistoryJSON
{
    NSString *_strLanguage = nil;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){    
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[[UIConstants returnInstance] strFosUserID] forKey:key_User];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetSendVerificationCodeJSONwithUserID:(NSString *)UserId IsGuestUser:(NSString *)IsGuestUser OrderId:(NSString *)OrderID
{
    NSString *_strLanguage = nil;
    if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:UserId forKey:key_UserId];
    [dic setObject:IsGuestUser forKey:key_IsGuestUser];
    if (OrderID != nil) {
        [dic setObject:OrderID forKey:key_OrderId];
    }
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

-(id)GetVerifyVerificationCodeJSONwithUserID:(NSString *)UserId IsGuestUser:(NSString *)IsGuestUser VerificationCode:(NSString *)VerificationCode
{
    NSString *_strLanguage = nil;
    if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
    }else{
        _strLanguage = code_lang_English;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:UserId forKey:key_UserId];
    [dic setObject:IsGuestUser forKey:key_IsGuestUser];
    [dic setObject:VerificationCode forKey:key_VerificationCode];
    [dic setObject:tenantCode forKey:key_TenantCode];
    [dic setObject:passKey forKey:key_PassKey];
    [dic setObject:accessKey forKey:key_AccessKey];
    [dic setObject:_strLanguage forKey:key_langCode];
    NSString *str = [dic JSONRepresentation];
    [dic release];
    return str;
}

#pragma mark - Removing Unnecessary Keys
-(NSArray *)RemoveUnnecessarykeyValuesForDictionary:(NSArray *)aryRestaurant
{
    NSMutableArray *array  = [[NSMutableArray alloc] init];
    NSArray *cartDetails = [[aryRestaurant objectAtIndex:0] objectForKey:key_OrderDetails];
    for(NSMutableDictionary *dic in cartDetails) {
        NSMutableDictionary *localdic = [dic mutableCopy];
        [localdic removeObjectForKey:key_MenuIdentifier];
        [localdic removeObjectForKey:key_MenuCategoryIdentifier];
        [localdic removeObjectForKey:key_isGroup];
        
        [array addObject:localdic];
        [localdic release];
    }
    
    NSMutableArray *restarray = [[aryRestaurant mutableCopy] autorelease];
    [[restarray objectAtIndex:0] setObject:array forKey:key_OrderDetails];
    [array release];
    
    return restarray;
}
@end
