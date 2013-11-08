//
//  ResponseDTO.h

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseDTO : NSObject
{
    NSDictionary        *DTO_GeneralResponse;
    NSMutableArray      *DTO_AreaList;
    NSDictionary        *DTO_RestaurantList;
    NSDictionary        *DTO_RestaurantDetails;
    NSMutableArray      *DTO_AutoSuggestData;
    NSDictionary        *DTO_RestaurantTiming;
    NSMutableArray      *DTO_SupportedCities;
    NSMutableArray      *DTO_FilterListforMobile;
    NSDictionary        *DTO_RestaurantMenuList;
    NSDictionary        *DTO_ShowCartSummary;
    NSDictionary        *DTO_UserLoginResponse;
    NSDictionary        *DTO_UserRegistrationResponse;
    NSDictionary        *DTO_UpdateProfileResponse;
    NSDictionary        *DTO_ValidateOrderRequestResponse;
    NSDictionary        *DTO_ErrorMessage;
    NSDictionary        *DTO_MenuCategoryMenuItems;
    NSDictionary        *DTO_MenuItemDetail;
    NSDictionary        *DTO_SupportedRegion;
    NSDictionary        *DTO_CheckOutResponse;
    NSDictionary        *DTO_OrderHistory;
}
@property(nonatomic, retain) NSDictionary     *DTO_GeneralResponse;
@property(nonatomic, retain) NSMutableArray   *DTO_AreaList;
@property(nonatomic, retain) NSDictionary     *DTO_RestaurantList;
@property(nonatomic, retain) NSDictionary     *DTO_RestaurantDetails;
@property(nonatomic, retain) NSMutableArray   *DTO_AutoSuggestData;
@property(nonatomic, retain) NSDictionary     *DTO_RestaurantTiming;
@property(nonatomic, retain) NSMutableArray   *DTO_SupportedCities;
@property(nonatomic, retain) NSMutableArray   *DTO_FilterListforMobile;
@property(nonatomic, retain) NSDictionary     *DTO_RestaurantMenuList;
@property(nonatomic, retain) NSDictionary     *DTO_ShowCartSummary;
@property(nonatomic, retain) NSDictionary     *DTO_UserLoginResponse;
@property(nonatomic, retain) NSDictionary     *DTO_UserRegistrationResponse;
@property(nonatomic, retain) NSDictionary     *DTO_UpdateProfileResponse;
@property(nonatomic, retain) NSDictionary     *DTO_ValidateOrderRequestResponse;
@property(nonatomic, retain) NSDictionary     *DTO_ErrorMessage;
@property(nonatomic, retain) NSDictionary     *DTO_MenuCategoryMenuItems;
@property(nonatomic, retain) NSDictionary     *DTO_MenuItemDetail;
@property(nonatomic, retain) NSDictionary     *DTO_SupportedRegion;
@property(nonatomic, retain) NSDictionary     *DTO_CheckOutResponse;
@property(nonatomic, retain) NSDictionary     *DTO_OrderHistory;
+(ResponseDTO *)sharedInstance;
@end
