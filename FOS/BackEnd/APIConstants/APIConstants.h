//
//  APIConstants.h

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#ifndef FOS_APIConstants_h
#define FOS_APIConstants_h


typedef enum {
    API_GET_MOBILEREGISTRATION,
    API_GET_FILTERLISTFORMOBILE,
    API_GET_CITYFORMOBILE,
    API_GET_LOCATIONBASEDONCITY,
    API_GET_USERRGISTRATION,
    API_GET_USERUPDATEPROFILE,
    API_GET_USERLOGIN,
    API_GET_USERCHANGEPASSWORD,
    API_GET_USERFORGOTPASSWORD,
    API_GET_RESTAURANTSEARCH,
    API_GET_RESTAURANTMENULIST,
    API_GET_SHOWCARTSUMMARY,
    API_GET_REGISTERGUESTUSER,
    API_GET_REGISTERFosUSER,
    API_GET_VALIDATEORDERREQUEST,
    API_GET_CHECKRESTAURANTTIMING,
    API_GET_RESTAURANTLIST,
    API_GET_AUTOSUGGESTDATA,
    API_GET_CITYLIST,
    API_GET_MENUCATEGORY,
    API_GET_MENUITEMDETAIL,
    API_GET_SUPPORTEDREGION,
    API_GET_CHECKOUT,
    API_GET_ORDERHISTORY,
    API_GET_SENDVERFICATIONCODE,
    API_GET_VERIFYCODE
}apistate;


static  NSString * const BaseURL         = @"http://54.229.122.177:8080/fosservice/tenant";
static  NSString * const HTTP            = @"http://";
static  NSString * const HOST             = @"175.41.174.82";
static  NSString * const PORT             = @"8080";
static  NSString * const MOBILE           = @"mobile";
static  NSString * const REGISTER         = @"register";
static  NSString * const SEARCH           = @"search";
static  NSString * const FILTER           = @"filter";
static  NSString * const WEB              = @"WEB";
static  NSString * const MOBILEAPP        = @"MAPP";
static  NSString * const SUPPORTEDCITIES  = @"supportedcities";
static  NSString * const AREALIST         = @"arealist";
static  NSString * const USER             = @"user";
static  NSString * const REGISTRATION     = @"registration";
static  NSString * const UPDATEPROFILE    = @"updateprofile";
static  NSString * const LOGIN            = @"login";
static  NSString * const CHANGEPASSWORD   = @"changepassword";
static  NSString * const FORGOTPASSWORD   = @"forgotpassword";
static  NSString * const RESTAURANT       = @"restaurant";
static  NSString * const CLIENT           = @"client";
static  NSString * const MENU             = @"menu";
static  NSString * const ORDER            = @"order";
static  NSString * const VALIDATION       = @"validation";
static  NSString * const GUESTUSER        = @"guestuser";
static  NSString * const ADD              = @"add";
static  NSString * const DELIVERYADDRESS  = @"deliveryaddress";
static  NSString * const UPDATE           = @"update";
static  NSString * const BULKORDER        = @"bulkorder";
static  NSString * const ORDERNO          = @"orderNo";
static  NSString * const TIMING           = @"timings";
static  NSString * const AUTOSUGGESTDATA  = @"autosuggestdata";
//Device registration
static  NSString * const key_IMEI                       = @"imei";
static  NSString * const key_IMSI                       = @"imsi";
static  NSString * const key_AppVersion                 = @"appVersion";
static  NSString * const key_DeviceType                 = @"deviceType";
static  NSString * const key_AppID                      = @"appId";
static  NSString * const key_SessionId                  = @"sessionId";

static  NSString * const key_Filters                    = @"filters";
static  NSString * const key_FilterOption               = @"filterOptions";
static  NSString * const key_FilterName                 = @"filterName";
static  NSString * const key_FilterCode                 = @"filterCode";
static  NSString * const key_Cities                     = @"cities";
static  NSString * const key_CityCode                   = @"cityCode";
static  NSString * const key_CityName                   = @"cityName";
static  NSString * const key_CountryCode                = @"countryCode";
static  NSString * const key_CountryName                = @"countryName";
static  NSString * const key_StateCode                  = @"stateCode";
static  NSString * const key_StateName                  = @"stateName";
static  NSString * const key_AreaCode                   = @"areaCode";
static  NSString * const key_AreaName                   = @"areaName";
static  NSString * const key_AreaDetails                = @"areaDetails";
static  NSString * const key_Areas                      = @"areas";
//user registration
static  NSString * const key_UserAddress                = @"userAddress";
static  NSString * const key_UserName                   = @"userName";
static  NSString * const key_FirstName                  = @"firstName";
static  NSString * const key_LastName                   = @"lastName";
static  NSString * const key_EmailID                    = @"emailID";
static  NSString * const key_Age                        = @"age";
static  NSString * const key_PassWord                   = @"password";
static  NSString * const key_IsFbUser                   = @"isFBUser";
static  NSString * const key_FBUniqueId                 = @"fbUniqueId";
static  NSString * const key_MobileNo                   = @"mobileNumber";
static  NSString * const key_HomePhone                  = @"homePhone";
static  NSString * const key_IsAddressAvailable         = @"isAddressAvailable";
static  NSString * const key_HomeCity                   = @"homeCity";
static  NSString * const key_DoorNo                     = @"doorNo";
static  NSString * const key_BuildingName               = @"buildingName";
static  NSString * const key_StreetLine1                = @"streetLine1";
static  NSString * const key_StreetLine2                = @"streetLine2";
static  NSString * const key_Area                       = @"area";
static  NSString * const key_City                       = @"city";
static  NSString * const key_State                      = @"state";
static  NSString * const key_States                      = @"states";
static  NSString * const key_Country                    = @"country";
static  NSString * const key_Countries                  = @"countries";
static  NSString * const key_PinCode                    = @"pinCode";
static  NSString * const key_Pin                    = @"pin";
static  NSString * const key_LandMark1                  = @"landMark1";
static  NSString * const key_LandMark2                  = @"landMark2";
static  NSString * const key_IpAddress                  = @"ipAddress";
static  NSString * const key_ClientType                 = @"clientType";
static  NSString * const key_UserAgent                  = @"userAgent";
static  NSString * const key_FilterGeneral              = @"filterGeneral";
static  NSString * const key_FilterCuisineType          = @"filterCuisineTypes";
static  NSString * const key_DisplayText                = @"displayText";
static  NSString * const key_ReferralID                 = @"referralId";
//Common keys
static  NSString * const key_StatusCode                 = @"statusCode";
static  NSString * const key_StatusMessage              = @"statusMessage";
static  NSString * const key_Message                    = @"message";
static  NSString * const key_StatusDescription          = @"statusDescription";
static  NSString * const key_ResponseMessage            = @"responseMessage";
//Web User Update Profile
static  NSString * const key_ActorDetail                = @"actorDetail";
static  NSString * const key_IdUser                     = @"idUser";
static  NSString * const key_OldPassWord                = @"oldPassword";
static  NSString * const key_NewPassword                = @"newPassword";
static  NSString * const key_Email                      = @"email";
static  NSString * const key_IsGuest                    = @"isGuest";
static  NSString * const key_IsGuestUser                = @"isGuestUser";
static  NSString * const key_VerificationCode           = @"verificationCode";
static  NSString * const key_UserId                     = @"userId";
static  NSString * const key_User                       = @"user";
static  NSString * const key_Id                         = @"id";


//Restaurant search

static  NSString * const key_TotalRecords = @"totalRecords";
static  NSString * const key_CuisineTypes = @"cuisineTypes";
static  NSString * const key_RestaurantInfos = @"restaurantInfos";
static  NSString * const key_RestaurantIdentifier = @"restaurantIdentifier";
static  NSString * const key_RestaurantID = @"restaurantId";
static  NSString * const key_Identifier = @"identifier";
static  NSString * const key_Name = @"name";
static  NSString * const key_Description = @"description";
static  NSString * const key_VendorIdentifier = @"vendorIdentifier";
static  NSString * const key_MenuMasterItemId = @"menuMasterItemId";
static  NSString * const key_CuisineTypeIdentifiers = @"cuisineTypeIdentifiers";
static  NSString * const key_RestaurantType = @"restaurantType";
static  NSString * const key_VendorImageURL = @"vendorImageURL";
static  NSString * const key_RestaurantImageURL   = @"restaurantImageURL";
static  NSString * const key_IsVeg = @"isVeg";
static  NSString * const key_DoorDeliverySupported = @"doorDeliverySupported";
static  NSString * const key_DeliverySupportAreas = @"deliverySupportedAreas";
static  NSString * const key_TableReservationSupported = @"tableReservationSupported";
static  NSString * const key_TableReservationDaysOfWeek = @"tableReservationDaysOfWeek";
static  NSString * const key_MinPrepTime = @"minPrepTime";
static NSString * const key_PickUpTime = @"pickUpTime";
static  NSString * const key_MaxDeliveryTime = @"maxDeliveryTime";
static  NSString * const key_IsOrderLocked = @"isOrderLocked";
static  NSString * const key_ServeAlchocal = @"servesAlchol";
static  NSString * const key_LanguagesSpoken = @"langaguesSpoken";
static  NSString * const key_CarParkingAvailable = @"carParkingAvailable";
static  NSString * const key_ValetParkingAvailable = @"valetParkingAvailable";
static  NSString * const key_ValetParkingDaysOfWeek = @"valetParkingDaysOfWeek";
static  NSString * const key_CreditCardAccepted = @"creditCardAccepted";
static  NSString * const key_CardsAccepted = @"cardsAccepted";
static  NSString * const key_MealPassAccept = @"mealPassAccepted";
static  NSString * const key_PassDetails = @"passDetails";
static  NSString * const key_IsBuffetAvailable = @"isBuffetAvailable";
static  NSString * const key_BuffetDaysOfWeek = @"buffetDaysOfWeek";
static  NSString * const key_OpenDaysOfWeek = @"openDaysOfWeek";
static  NSString * const key_OpenTiming = @"openTimings";
static  NSString * const key_IsOpened = @"isOpened";
static  NSString * const key_IsClosingSoon = @"isClosingSoon";
static  NSString * const key_CostForTwo = @"costForTwo";
static  NSString * const key_Address = @"address";
static  NSString * const key_Landmark = @"landmark";
static  NSString * const key_Landmark1 = @"landmark1";
static  NSString * const key_IsRestaurantClosed = @"isRestaurantClosed";
static  NSString * const key_PhoneNos = @"phoneNumbers";
static  NSString * const key_Latitude = @"latitude";
static  NSString * const key_Longitude = @"longitude";
static  NSString * const key_ReviewRating = @"reviewRatings";
static  NSString * const key_OverallRating = @"overallRatings";
static  NSString * const key_Expensive = @"expensive";
static  NSString * const key_TimelyDelivery = @"timelyDelivery";
static  NSString * const key_Taste = @"taste";
//Restaurant menu list
static  NSString * const key_RestaurantDetail = @"restaurantDetail";
static  NSString * const key_RestaurantDetails = @"restaurantDetails";
static  NSString * const key_DineInSupport= @"dineInSupported";
static  NSString * const key_TakeAwaySupport= @"takeAwaySupported";
static  NSString * const key_IsAC= @"isAC";
static  NSString * const key_IsKidsChairAvail= @"isKidsChairAvailable";
static  NSString * const key_IsDisabledAccessAvail= @"isDisabledAccessAvailable";
static  NSString * const key_IsWifiAvail= @"isWiFiAvailable";
static  NSString * const key_OtherFacility= @"otherFacilities";
static  NSString * const key_IsAcceptForeignCrncy= @"acceptsForeignCurrency";
static  NSString * const key_AcceptedForeignCurrency= @"foriegnCurrenciesAccepted";
static  NSString * const key_ContactNumbers= @"contactNumbers";
static  NSString * const key_ConTactPersons= @"contactPersons";
static  NSString * const key_OnlineOrderMin= @"onlineOrderMinValue";
static  NSString * const key_DeliveryMinOrderValue= @"deliveryMinOrderValue";
static  NSString * const key_Tax1Name = @"tax1Name";
static  NSString * const key_Tax1Amount = @"tax1Amount";

//item
static  NSString * const key_Menu = @"menu";
static  NSString * const key_MenuCustomize = @"menuCustomize";
static  NSString * const key_MenuCategories= @"menuCategories";
static  NSString * const key_MenuCategoryIdentifier = @"menuCategoryIdentifier";
static  NSString * const key_MenuIdentifier = @"menuIdentifier";
static  NSString * const key_Category= @"category";
static  NSString * const key_Timings= @"timings";
static  NSString * const key_IsAvailableForOrder= @"isAvailableforOrder";
static  NSString * const key_ItemDetails= @"itemDetails";
static  NSString * const key_ItemCode= @"itemCode";
static  NSString * const key_ItemCost= @"itemCost";
static  NSString * const key_MenuID= @"menuId";
static  NSString * const key_MenuItem = @"menuItem";
static  NSString * const key_MenuItems = @"menuItems";
static  NSString * const key_ItemName= @"itemName";
static  NSString * const key_DineInPrice= @"dineinPrice";
static  NSString * const key_TakeAwayPrice= @"takeAwayPrice";
static  NSString * const key_DoorDeliveryPrice= @"doorDeliveryPrice";
static  NSString * const key_TakeAwayItemPrice= @"takeAwayItemPrice";
static  NSString * const key_DoorDeliveryItemPrice= @"doorDeliveryItemPrice";
static  NSString * const key_DineInItemPrice= @"dineinItemPrice";
static  NSString * const key_Status= @"status";
static  NSString * const key_StatusComments= @"statusComments";
static  NSString * const key_MenuDescription= @"menuDescription";
static  NSString * const key_CaloriValue= @"caloriValue";
static  NSString * const key_QtyNos= @"qtyNos";
static  NSString * const key_Qty= @"qty";
static  NSString * const key_QtyGrams= @"qtyGrams";
static  NSString * const key_SplMenuImgs= @"splMenuImages";
static  NSString * const key_IsMenuCustomizable= @"isMenucustomizable";
static  NSString * const key_ImageURL= @"imageURL";
static  NSString * const key_ImageURL1= @"imageUrl";
static  NSString * const key_MenuInventory= @"menuInventory";
static  NSString * const key_Options = @"options";
static  NSString * const key_IdCustomizationMaster = @"idcustomizationMaster";
static  NSString * const key_IsCustomizationOption = @"isCustomizeOptions";
//show cart summary

static  NSString * const key_DeliveryMode= @"deliveryMode";
static  NSString * const key_Restaurants= @"restaurants";
static  NSString * const key_RestaurantName= @"restaurantName";
static  NSString * const key_MenuMasterID= @"menuMasterId";
static  NSString * const key_CouponDiscount= @"couponDiscount";
static  NSString * const key_CouponCode= @"couponCode";
static  NSString * const key_OrderDetails= @"orderDetails";
static  NSString * const key_OrderDate = @"orderDate";
static  NSString * const key_ItemID= @"itemId";
static  NSString * const key_Quantity= @"quantity";
static  NSString * const key_TotalPrice= @"totalPrice";
static  NSString * const key_TotalCost= @"totalCost";
static  NSString * const key_Customization= @"customization";
static  NSString * const key_CustomizationOptions= @"customizationOptions";
static  NSString * const key_CustomizationName = @"customizationName";
static  NSString * const key_CustomizationId = @"cutomizationId";
static  NSString * const key_CustomizationIdentifier = @"customizationIdentifier";
static  NSString * const key_OrderValidationSource= @"orderValidationStatus";
static  NSString * const key_IsCheckOut= @"isCheckOut";
static  NSString * const key_RedeemAmount= @"redeemAmount";
static  NSString * const key_OrderValidationMessage= @"orderValidationMessage";
static  NSString * const key_OrderNumber= @"orderNumber";
static  NSString * const key_CurrencyCode = @"currencyCode";
static  NSString * const key_DecimalPoints = @"decimalPoints";
static  NSString * const key_BillTotal = @"billTotal";
static  NSString * const key_VendorID= @"vendorId";
static  NSString * const key_IsLocked= @"isLocked";
static  NSString * const key_IsPriceDiff= @"isPriceDiff";
static  NSString * const key_ActualPrice= @"actualPrice";
static  NSString * const key_ReConfirm= @"reconfirm";
static  NSString * const key_Price= @"price";
static  NSString * const key_ItemIsVeg= @"itemIsVeg";
static  NSString * const key_ParcelChrgInPercntg= @"parcelChargeinPercentage";
static  NSString * const key_ParcelCharge= @"parcelCharge";
static  NSString * const key_DeliveryCharge= @"deliveryCharge";
static  NSString * const key_HomeDeliveryCharge= @"homeDeliveryCharge";
static  NSString * const key_MinOrderDoorDelivValue = @"minOrderDoorDeliveryValue";
static  NSString * const key_Duration= @"duration";
static  NSString * const key_HomeCrncy= @"homeCurrency";
static  NSString * const key_AdditionalChrgs= @"additionalCharges";
static  NSString * const key_VatChrgsPrcntg= @"vatChargeinPercentage";
static  NSString * const key_VatAmount= @"vatAmount";
static  NSString * const key_GrossAmount= @"grossAmount";
static  NSString * const key_NetAmount= @"netAmount";
static  NSString * const key_RestaurantTaxes= @"restaurantTaxes";
static  NSString * const key_TaxName= @"taxName";
static  NSString * const key_IsPercentage= @"isPercentage";
static  NSString * const key_TaxValue= @"taxValue";
static  NSString * const key_TaxCalculated= @"taxCalulated";
static  NSString * const key_CampaignDiscount= @"campaignDiscount";
static  NSString * const key_CampaignName= @"campaignName";
static  NSString * const key_CampaignCode= @"campaignCode";
static  NSString * const key_CampaignAmount= @"campaignAmount";
static  NSString * const key_ForRegisteredUser= @"forRegisteredUser";
static  NSString * const key_CampaignValue= @"campaignValue";
static  NSString * const key_CouponID= @"couponId";
static  NSString * const key_CouponName= @"couponName";
static  NSString * const key_CouponValue= @"couponValue";
static  NSString * const key_CouponAmount= @"couponAmount";
static  NSString * const key_PrepTime= @"prepTime";
static  NSString * const key_DeliveryTime = @"deliveryTime";
static  NSString * const key_CampaignErrorMessage= @"campaignErrorMessage";
static  NSString * const key_AddressName= @"addressName";
static  NSString * const key_IsPrimary= @"isPrimary";
static  NSString * const key_IsVerified= @"isVerified";
static  NSString * const key_PaymentMethod = @"paymentMethod";
static  NSString * const key_BulkOrderStatus= @"bulkOrderStatus";
static  NSString * const key_BulkOrderErrorMessage= @"bulkOrderErrorMessage";
static  NSString * const key_IsKitchenLocked= @"isKitchenLocked";

static  NSString * const key_ServiceType= @"serviceType";
static  NSString * const key_SearchString= @"searchString";


static  NSString * const URL_Base = @"http://gograb.in/gograbmobile";
static  NSString * const URL_AboutPayment = @"/Payments.do";
static  NSString * const URL_HowItWorks = @"/HowItWorks.do";
static  NSString * const URL_Privacy  = @"/PrivacyPolicy.do";
static  NSString * const URL_TermsOfUse = @"/SiteTermsOfUse.do";
static  NSString * const URL_ContactUs = @"/ContactUs.do";
static  NSString * const URL_Payment = @"/Mobile.do?fun=paymentDetails&orderNumber=";
static  NSString * const URL_OrderConfirmation = @"/Payment.do?fun=pgResponse";

//Http Headers

static  NSString * const code_lang_English = @"en_us";
static  NSString * const code_lang_Arabic  = @"ar_kw";

static  NSString * const key_TenantCode   = @"tenantCode";
static  NSString * const key_langCode     = @"langCode";
static  NSString * const key_AccessKey    = @"accessKey";
static  NSString * const key_PassKey      = @"passKey";
static  NSString * const key_isGroup = @"isGroup";

//static  NSString * const tenantCode = @"FOS";
//static  NSString * const accessKey = @"FCC-VEDNAR125487";
//static  NSString * const passKey = @"ADSB234CDJKKLRR112";

static  NSString * const tenantCode = @"DOMINO";
static  NSString * const accessKey = @"7f51ce07-e52a-462d-9786-2f0b92c7f521";
static  NSString * const passKey = @"e03afee1-6998-43a3-8867-93fe1d72dc4f";

static  NSString * const key_isHomeDeliverySupport = @"isHomeDelivery";
static  NSString * const key_isTakeAwaySupport = @"isPickUp";

static  NSString * const key_IsMobiileNoVerfied = @"isMobileNumberVerified";
static  NSString * const key_AddressName_Home = @"HOME";
static  NSString * const key_AddressName_Office = @"OFFICE";
static  NSString * const key_AddressName_Others = @"OTHERS";
static  NSString * const key_OrderByGroup = @"orderByGroup";
static  NSString * const key_Orders = @"orders";
static  NSString * const key_OrderId = @"orderId";
static NSString * const key_OtpVerification = @"otpVerification";
static  NSString * const key_GroupName = @"groupName";
static  NSString * const key_CustomizationGroupName = @"customizationGroupName";
static  NSString * const key_CustomizationGroupNameIdentifier = @"customizationGroupNameIdentifier";
static  NSString * const key_IsMultiSelect = @"isMultiSelect";
static  NSString * const key_MultiSelectLimit = @"multiSelectLimit";
static  NSString * const key_IsCustomizationGroupMandatory = @"isCustomizationGroupMandatory";
#endif
