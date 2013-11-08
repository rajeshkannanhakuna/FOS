//
//  ResponseDTO.m

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "ResponseDTO.h"

@implementation ResponseDTO
@synthesize DTO_AreaList;
@synthesize DTO_GeneralResponse;
@synthesize DTO_RestaurantDetails;
@synthesize DTO_RestaurantList;
@synthesize DTO_AutoSuggestData;
@synthesize DTO_RestaurantTiming;
@synthesize DTO_SupportedCities;
@synthesize DTO_FilterListforMobile;
@synthesize DTO_RestaurantMenuList;
@synthesize DTO_ShowCartSummary;
@synthesize DTO_UserLoginResponse;
@synthesize DTO_UserRegistrationResponse;
@synthesize DTO_UpdateProfileResponse;
@synthesize DTO_ValidateOrderRequestResponse;
@synthesize DTO_ErrorMessage;
@synthesize DTO_MenuCategoryMenuItems;
@synthesize DTO_MenuItemDetail;
@synthesize DTO_SupportedRegion;
@synthesize DTO_CheckOutResponse;
@synthesize DTO_OrderHistory;
+(ResponseDTO *)sharedInstance
{
    static ResponseDTO *_sharedInstance;
    if(!_sharedInstance) {
        static dispatch_once_t  oncePredicate;
        dispatch_once (&oncePredicate, ^{
            _sharedInstance = [[super allocWithZone:nil]init];
        });
    }
    return _sharedInstance;
}

@end

