//
//  ResponseValidator.m

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "ResponseValidator.h"
#import "ResponseDTO.h"
#import "APIConstants.h"
@implementation ResponseValidator

-(BOOL)validatingResponse:(NSDictionary *)dic :(apistate)apiType
{
    if (dic) {
        if ([[dic valueForKey:key_StatusCode] integerValue] != 1000 && [[dic valueForKey:key_StatusCode] integerValue] != 2000) {
            if (apiType == API_GET_AUTOSUGGESTDATA) {
                [[ResponseDTO sharedInstance]setDTO_AutoSuggestData:[dic objectForKey:key_AreaDetails]];
            }else if (apiType == API_GET_CHECKRESTAURANTTIMING) {
                [[ResponseDTO sharedInstance] setDTO_RestaurantTiming:dic];
            }else if (apiType == API_GET_CITYFORMOBILE) {
                [[ResponseDTO sharedInstance] setDTO_SupportedCities:[dic objectForKey:key_Cities]];
            }else if (apiType == API_GET_CITYLIST) {
                [[ResponseDTO sharedInstance] setDTO_SupportedCities:[dic objectForKey:key_Cities]];
            }else if (apiType == API_GET_FILTERLISTFORMOBILE) {
                [[ResponseDTO sharedInstance] setDTO_FilterListforMobile:[dic objectForKey:key_Filters]];
            }else if (apiType == API_GET_LOCATIONBASEDONCITY) {
                [[ResponseDTO sharedInstance] setDTO_AreaList:[dic objectForKey:key_Areas]];
            }else if (apiType == API_GET_MOBILEREGISTRATION) {
                [[ResponseDTO sharedInstance] setDTO_GeneralResponse:dic];
            }else if (apiType == API_GET_REGISTERFosUSER) {
                [[ResponseDTO sharedInstance] setDTO_GeneralResponse:dic];
            }else if (apiType == API_GET_REGISTERGUESTUSER) {
                [[ResponseDTO sharedInstance] setDTO_GeneralResponse:dic];
            }else if (apiType == API_GET_RESTAURANTLIST) {
                [[ResponseDTO sharedInstance] setDTO_RestaurantList:dic];
            }else if (apiType == API_GET_RESTAURANTMENULIST) {
                [[ResponseDTO sharedInstance] setDTO_RestaurantMenuList:dic];
            }else if (apiType == API_GET_RESTAURANTSEARCH) {
                [[ResponseDTO sharedInstance] setDTO_RestaurantList:dic];
            }else if (apiType == API_GET_SHOWCARTSUMMARY) {
                [[ResponseDTO sharedInstance] setDTO_ShowCartSummary:dic];
            }else if (apiType == API_GET_USERCHANGEPASSWORD) {
                [[ResponseDTO sharedInstance] setDTO_GeneralResponse:dic];
            }else if (apiType == API_GET_USERFORGOTPASSWORD) {
                [[ResponseDTO sharedInstance] setDTO_GeneralResponse:dic];
            }else if (apiType == API_GET_USERLOGIN) {
                [[ResponseDTO sharedInstance] setDTO_UserLoginResponse:dic];
            }else if (apiType == API_GET_USERRGISTRATION) {
                [[ResponseDTO sharedInstance] setDTO_UserRegistrationResponse:dic];
            }else if (apiType == API_GET_USERUPDATEPROFILE) {
                [[ResponseDTO sharedInstance] setDTO_UpdateProfileResponse:dic];
            }else if (apiType == API_GET_VALIDATEORDERREQUEST) {
                [[ResponseDTO sharedInstance] setDTO_ValidateOrderRequestResponse:dic];
            }else if (apiType == API_GET_MENUCATEGORY) {
                [[ResponseDTO sharedInstance] setDTO_MenuCategoryMenuItems:dic];
            }else if (apiType == API_GET_MENUITEMDETAIL) {
                [[ResponseDTO sharedInstance] setDTO_MenuItemDetail:dic];
            }else if (apiType == API_GET_SUPPORTEDREGION) {
                [[ResponseDTO sharedInstance] setDTO_SupportedRegion:dic];
            }else if (apiType == API_GET_CHECKOUT) {
                [[ResponseDTO sharedInstance] setDTO_CheckOutResponse:dic];
            }else if (apiType == API_GET_ORDERHISTORY) {
                [[ResponseDTO sharedInstance] setDTO_OrderHistory:dic];
            }else{
                [[ResponseDTO sharedInstance] setDTO_GeneralResponse:dic];
            }
            return YES;
        }else
            [[ResponseDTO sharedInstance] setDTO_ErrorMessage:dic];
        return NO;
    }
    return NO;
}
@end
