//
//  HomeDelivery&TakeAway.h
//  
//
//  Created by segate on 19/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "ComboBox.h"

@interface HomeDelivery_TakeAway : UIViewController<FlowLogicDelegate,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
    
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnUserMenu;
    IBOutlet UIButton *btnPayment;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnSignOut;
    
    IBOutlet UIView *viewLoginMenu;
    IBOutlet UIView *viewUserMenu;
    IBOutlet UIView *viewPersonalInfo;
    IBOutlet UIView *viewChoosePaymentMode;
    IBOutlet UIView *viewAddress;
    IBOutlet UIView *viewHomeDeliveryUserDetail;
    IBOutlet UIView *viewTakeAwayUserDetail;
    
    IBOutlet UILabel *lblPersonalInfo1;
    IBOutlet UILabel *lblPersonalInfo2;
    IBOutlet UILabel *lblPersonalInfo3;
    IBOutlet UILabel *lblName;
    IBOutlet UITextField *txtFldName;
    IBOutlet UILabel *lblMobileNumber;
    IBOutlet UITextField *txtFldMobileNumber;
    IBOutlet UILabel *lblEmailId;
    IBOutlet UITextField *txtFldEmailId;
    
    IBOutlet UITextField *txtFldAddressLine1;
    IBOutlet UITextField *txtFldAddressLine2;
    IBOutlet UITextField *txtFldLandMark;
    IBOutlet UITextField *txtFldArea;
    IBOutlet ComboBox *txtFldCity;
    IBOutlet ComboBox *txtFldState;
    IBOutlet ComboBox *txtFldCountry;
    
    IBOutlet ComboBox *txtFldAddressType;
    IBOutlet ComboBox *txtFldDeliverySupportedArea;
    IBOutlet ComboBox *txtFldDeliverySupportedArea_EditView;
    IBOutlet UIButton *btnSelectArea;
    IBOutlet UIButton *btnSelectCity;
    IBOutlet UIButton *btnSelectState;
    IBOutlet UIButton *btnSelectCountry;
    
    IBOutlet UIButton *btnShareLocation;
    IBOutlet UIImageView *imgViewTickShareLocation;
    IBOutlet UILabel *lblShareLocation;
    
    IBOutlet UILabel *lblChoosePaymentMode;
    IBOutlet UILabel *lblOnlinePayment;
    IBOutlet UILabel *lblCashOnDelivery;
    
    IBOutlet UIImageView *imgViewOnlinePayRadioBtn;
    IBOutlet UIImageView *imgViewCashOnDeliveryRadioBtn;
    
    IBOutlet UIButton *btnOnLineRadioBtn;
    IBOutlet UIButton *btnCashOnDeliveryBtn;
    IBOutlet UIButton *btnEdit;
    IBOutlet UILabel *lblUserName;
    IBOutlet UILabel *lblUserMobileNo;
    IBOutlet UILabel *lblUserEmailId;
    IBOutlet UILabel *lblDeliveryAddressText;
    IBOutlet UILabel *lblDeliveryAddress;
    IBOutlet UILabel *lblLandMarkText;
    IBOutlet UILabel *lblLandMark;
    IBOutlet UILabel *lblUserNameText;
    IBOutlet UILabel *lblUserMobileNoText;
    IBOutlet UILabel *lblUserEmailIdText;
    
    IBOutlet UILabel *lblTakeAwayUserName;
    IBOutlet UILabel *lblTakeAwayUserMobileNo;
    IBOutlet UILabel *lblTakeAwayUserEmailID;
    
    IBOutlet UIButton *btnSelectAddressType;
    IBOutlet UIButton *btnSelectSupportedArea;
    
    UITableView *tblViewDropDownList;
    IBOutlet UIImageView *imgViewDropDownBG;
    IBOutlet UIImageView *imgViewDropDownBG1;

    IBOutlet UIScrollView *scrollViewCheckOut;
    IBOutlet UIView *viewShareLocation;
    
    IBOutlet UILabel *lblSelectYourAddress;
    IBOutlet UILabel *lblAreaToBeDelivered;
    
//    IBOutlet UIView *viewDeliverySupportedAreas;
//    IBOutlet UIButton *btnSave;
    
    IBOutlet UIView *viewPopUp;
    IBOutlet UILabel *lblRequired;
    
    IBOutlet UILabel *lblAddressText;
    IBOutlet UILabel *lblAreaTobeDeliveredText;
    IBOutlet UIView *viewFooter;
    IBOutlet UIImageView *imgViewPhoneNumber;
    IBOutlet UIImageView *imgViewEmailId;
    
    IBOutlet UIButton *btnClearTextFields;
}

@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

- (IBAction)OnClickGoBackButton:(id)sender;
- (IBAction)OnClickUserMenuButton:(id)sender;
- (IBAction)OnClickCheckOutButton:(id)sender;
- (IBAction)OnClickLoignButton:(id)sender;
- (IBAction)OnClickRegisterButton:(id)sender;
- (IBAction)OnClickEditProfileButton:(id)sender;
- (IBAction)OnClickChangePasswordButton:(id)sender;
- (IBAction)OnClickSignOutButton:(id)sender;
- (IBAction)OnClickOnlinePaymentButton:(id)sender;
- (IBAction)OnClickCashOnDeliveryButton:(id)sender;
- (IBAction)OnClickShareLocationButton:(id)sender;
- (IBAction)OnClickEditButton:(id)sender;
- (IBAction)OnClickSelectAreaButton:(id)sender;
- (IBAction)OnClickSelectCityButton:(id)sender;
- (IBAction)OnClickSelectStateButton:(id)sender;
- (IBAction)OnClickSelectCountryButton:(id)sender;
- (IBAction)OnClickSelectAddressTypeButton:(id)sender;
- (IBAction)OnClickSelectSupportedAreaButton:(id)sender;
- (IBAction)OnClickSelectSupportedAreaButton_EditView:(id)sender;
- (IBAction)OnClickClearTextFieldButton:(id)sender;
//- (IBAction)OnClickSaveButton:(id)sender;

- (void)ChangeLanguageToArabic;
- (void)ScreenForHomeDelivery;
- (void)ScreenForTakeAway;
- (void)ScreenForHomeDeliveryWithLogin;
- (void)ScreenForTakeAwayWithLogin;
- (void)ValidateForHomeDelivery;
- (void)ValidateForTakeAway;
- (void)ValidateForHomeDeliveryWithLogin;
- (void)ValidateForTakeAwayWithLogin;
- (void)SetFont;
- (void)ShowAddress: (NSDictionary *)Dictionary;
- (BOOL)CheckOutMethod;
- (void)setValuesForTextField;
- (void)SetValuesForLabel:(NSString *)Name :(NSString *)MobileNo :(NSString *)EmailId;
- (void)SetTableHight:(NSArray *)aryData;
//- (void)setStateCityAreaValues;
- (void)GetLocationUpdate;
- (void)SetContentOffSet: (UITextField *)textfield;

@end
