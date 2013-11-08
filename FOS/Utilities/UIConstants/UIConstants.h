//
//  UIConstants.h

//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>


#define  FOS_TEXTALIGNMENT ([[UIConstants returnInstance] isItEnglish])? UITextAlignmentLeft : UITextAlignmentRight

#define  FOS_TEXTALIGNMENT_NEGATIVE ([[UIConstants returnInstance] isItEnglish])? UITextAlignmentRight : UITextAlignmentLeft

@interface UIConstants : NSObject<UIAlertViewDelegate>
{
    NSString *strLanguage;
    NSString *strAppID;
    NSString *strCityCode;
    NSString *strServiceType;
    NSString *strAreaName;
    NSString *strFosUserID;
    NSString *strFosUserName;
    NSString *strMenuCategoryName;
    NSString *strMenuItemName;
    NSString *strMenuCategoryIdentifier;
    NSString *strMenuIdentifier;
    NSString *strPassword;
    NSString *strCurrencyCode;
    NSString *strDecimalPoints;
    NSDictionary *dicLocationDetails;
    NSDictionary *dicRestaurantDetails;
    NSDictionary *dicUserDetails;
    NSMutableArray *arySelectedGeneralFilter;
    NSMutableArray *arySelectedFilters;
    NSMutableArray *aryRestaurantsList;
    NSMutableArray *arySupportedArea;
    NSMutableArray *arySupportedCities;
    NSMutableArray *aryCartDetails;
    NSMutableArray *aryOrderedRestaurantsList;
    NSArray *aryDeliverySupportedAreas;
    NSDictionary   *dicSupportedRegion;
    NSString *strMaxDeliveryTime;
    NSString *strMinPreparationTime;
    BOOL isLoginViaHome;
    BOOL KeepMeLoggedIn;
    NSString *strUserMobileNo;
    
    BOOL isItEnglish;
    BOOL isItemCleared;
    NSInteger decimalPoint;
    
    NSString *strMinOrderValue;
    NSString *strTax;
    BOOL isMobileNumberVerfied;
    NSMutableArray *aryCouponDetails;
    NSString *strOrderID;
    NSString *strOrderNumber;
    NSString *strGuestUserID;
    BOOL isAlertViewShowing;
    BOOL IsComingViaMyOrders;
    NSString* strLatitude;
    NSString* strLongitude;
    BOOL IsBackFromPaymentOrMobileVerify;
    BOOL IsComingForEditing;
    
    NSString *strIsGroup;
    NSDictionary *dicSelectedItemFromOrderSummary;
}
@property (nonatomic, readwrite) BOOL isItEnglish;
@property (nonatomic, readwrite) BOOL isItemCleared;
@property (nonatomic, readwrite) BOOL isMobileNumberVerfied;
@property (nonatomic, readwrite) BOOL isAlertViewShowing;
@property (nonatomic, readwrite) BOOL IsComingViaMyOrders;
@property (nonatomic, readwrite) BOOL IsBackFromPaymentOrMobileVerify;
@property (nonatomic, readwrite) BOOL IsComingForEditing;
@property (nonatomic) NSInteger decimalPoint;

@property(nonatomic, retain) NSString *strLanguage;
@property(nonatomic, retain) NSString *strAppID;
@property(nonatomic, retain) NSString *strCityCode;
@property(nonatomic, retain) NSDictionary *dicRestaurantDetails;
@property(nonatomic, retain) NSMutableArray *arySelectedGeneralFilter;
@property(nonatomic, retain) NSMutableArray *arySelectedFilters;
@property(nonatomic, retain) NSDictionary *dicLocationDetails;
@property(nonatomic, retain) NSString *strServiceType;
@property(nonatomic, retain) NSString *strAreaName;
@property(nonatomic, retain) NSString *strFosUserID;
@property(nonatomic, retain) NSString *strFosUserName;
@property(nonatomic, retain) NSMutableArray *aryRestaurantsList;
@property(nonatomic, retain) NSMutableArray *arySupportedArea;
@property(nonatomic, readwrite) BOOL isLoginViaHome;
@property(nonatomic, readwrite) BOOL KeepMeLoggedIn;
@property(nonatomic, retain) NSMutableArray *arySupportedCities;
@property(nonatomic, retain) NSDictionary *dicUserDetails;
@property(nonatomic, retain) NSString *strMenuItemName;
@property(nonatomic, retain) NSString *strMenuCategoryName;
@property(nonatomic, retain) NSString *strMenuCategoryIdentifier;
@property(nonatomic, retain) NSString *strMenuIdentifier;
@property(nonatomic, retain) NSString *strPassword;
@property(nonatomic, retain) NSMutableArray *aryCartDetails;
@property(nonatomic, retain) NSString *strCurrencyCode;
@property(nonatomic, retain) NSDictionary *dicSupportedRegion;
@property(nonatomic, retain) NSMutableArray *aryOrderedRestaurantsList;
@property(nonatomic, retain) NSArray *aryDeliverySupportedAreas;
@property(nonatomic, retain) NSString *strMaxDeliveryTime;
@property(nonatomic, retain) NSString *strDecimalPoints;
@property(nonatomic, retain) NSString *strUserMobileNo;
@property(nonatomic, retain) NSString *strMinOrderValue;
@property(nonatomic, retain) NSString *strTax;
@property(nonatomic, retain) NSMutableArray *aryCouponDetails;
@property(nonatomic, retain) NSString *strOrderID;
@property(nonatomic, retain) NSString *strOrderNumber;
@property(nonatomic, retain) NSString *strGuestUserID;
@property(nonatomic, retain) NSString *strMinPreparationTime;
@property(nonatomic, retain) NSString* strLatitude;
@property(nonatomic, retain) NSString* strLongitude;
@property(nonatomic, retain) NSString *strIsGroup;
@property(nonatomic, retain) NSDictionary *dicSelectedItemFromOrderSummary;

+(UIConstants *)returnInstance;
- (BOOL) connectedToNetwork;
-(void)ShowAlert: (NSString *)Message;
-(void)ClearFilterCache;
- (UIFont *) returnArvoBold :(int)size;
- (UIFont *) returnArvoRegular :(int)size;
- (UIFont *) returnCharcoalCY :(int)size;
- (NSString *) convertToDecimalValue :(float) val;
- (void)ShowNoNetworkAlert;
- (UIImage *)ReturnImageForURL :(NSString *)imageURL;
- (void)ShowMobileNumberVerifcationAlert;
- (void)RemoveAlertView;
- (void)ClearCart;
// send current view frame and its super view frame;
- (CGRect) getFrameForLanguage:(CGRect)rect withSuperViewRect:(CGRect)superviewRect;

-(int)GetQuantityForIdentifier :(NSString *)Identifier isForMenu: (BOOL)ForMenu;
@end
