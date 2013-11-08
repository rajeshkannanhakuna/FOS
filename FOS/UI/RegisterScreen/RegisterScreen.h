//
//  RegisterScreen.h

//
//  Created by segate on 04/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"
#import "ComboBox.h"

@interface RegisterScreen : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UIScrollView *scrlViewRegister;
    
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblPersonalInfo;
    IBOutlet UILabel *lblFirstName;
    IBOutlet UILabel *lblLastName;
    IBOutlet UILabel *lblAge;
    IBOutlet UILabel *lblHomeCity;
    IBOutlet UILabel *lblMobileNumber;
    IBOutlet UILabel *lblLoginInfo;
    IBOutlet UILabel *lblEmailID;
    IBOutlet UILabel *lblPassword;
    IBOutlet UILabel *lblConfirmPassword;
    IBOutlet UILabel *lblShowChars;
    IBOutlet UILabel *lblContactInfo;
    
    IBOutlet UILabel *lblAgreeTermsConditions;
    IBOutlet UILabel *lblChoosePrimaryAddress;
    
    IBOutlet UILabel *lblHome;
    IBOutlet UILabel *lblOffice;
    IBOutlet UILabel *lblOther;
    
    IBOutlet UIView *viewRegisterInfo;
    IBOutlet UIView *viewPopUp;
    
    IBOutlet UIButton *btnGoHome;
    IBOutlet UIButton *btnRegister;
    
    
    IBOutlet UIButton *btnShowChars;
   
    IBOutlet UIButton *btnSelectCity;
    IBOutlet UIButton *btnAgreeTerms;
    
    IBOutlet UITextField *txtFldFirstName;
    IBOutlet UITextField *txtFldLastName;
    IBOutlet UITextField *txtFldAge;
    IBOutlet UITextField *txtFldHomeCity;
    IBOutlet UITextField *txtFldMobileNo;
    IBOutlet UITextField *txtFldEmail;
    IBOutlet UITextField *txtFldPassWord;
    IBOutlet UITextField *txtFldConfirmPwd;
   
    
    IBOutlet UIImageView *imgTick;
    IBOutlet UIImageView *imgTick_acceptTerms;
    
    
    IBOutlet UIView *viewFooterBG;
    
    UITableView *tblViewCityList_Home;
    UITableView *tblViewAreaList_Home;
    UITableView *tblViewStateList_Home;
    UITableView *tblViewCountryList_Home;
    UITableView *tblViewCityList_Office;
    UITableView *tblViewAreaList_Office;
    UITableView *tblViewStateList_Office;
    UITableView *tblViewCountryList_Office;
    UITableView *tblViewCityList_Other;
    UITableView *tblViewAreaList_Other;
    UITableView *tblViewStateList_Other;
    UITableView *tblViewCountryList_Other;
    
    UITableView *tblViewDropDownList;
    
    IBOutlet UILabel *lblRequired;
    
    BOOL Accept_Terms_Condition;
    
    IBOutlet UIImageView *imgViewDropDownBG;
    
    IBOutlet UIButton *btnGoBack;
    
    IBOutlet UIButton *btnAddressType_Home;
    IBOutlet UIButton *btnAddressType_Office;
    IBOutlet UIButton *btnAddressType_Other;
    
    IBOutlet UIView *viewHomeAddress;
    IBOutlet UIView *viewOfficeAddress;
    IBOutlet UIView *viewOtherAddress;
    
    IBOutlet UIView *viewButton_HomeAddress;
    IBOutlet UIView *viewButton_OfficeAddress;
    IBOutlet UIView *viewButton_OtherAddress;
    
    IBOutlet UIView *viewAgreeTerms_ChooseAddress;
    
    IBOutlet UIImageView *imgViewArrow_Home;
    IBOutlet UIImageView *imgViewArrow_Office;
    IBOutlet UIImageView *imgViewArrow_Other;
    
    IBOutlet UITextField *txtFldAddressLine1_Home;
    IBOutlet UITextField *txtFldAddressLine2_Home;
    IBOutlet UITextField *txtFldLandMark_Home;
    IBOutlet ComboBox *txtFldArea_Home;
    IBOutlet ComboBox *txtFldCity_Home;
    IBOutlet ComboBox *txtFldState_Home;
    IBOutlet ComboBox *txtFldCountry_Home;
    
    IBOutlet UITextField *txtFldAddressLine1_Office;
    IBOutlet UITextField *txtFldAddressLine2_Office;
    IBOutlet UITextField *txtFldLandMark_Office;
    IBOutlet ComboBox *txtFldArea_Office;
    IBOutlet ComboBox *txtFldCity_Office;
    IBOutlet ComboBox *txtFldState_Office;
    IBOutlet ComboBox *txtFldCountry_Office;
    
    IBOutlet UITextField *txtFldAddressName_Other;
    IBOutlet UITextField *txtFldAddressLine1_Other;
    IBOutlet UITextField *txtFldAddressLine2_Other;
    IBOutlet UITextField *txtFldLandMark_Other;
    IBOutlet ComboBox *txtFldArea_Other;
    IBOutlet ComboBox *txtFldCity_Other;
    IBOutlet ComboBox *txtFldState_Other;
    IBOutlet ComboBox *txtFldCountry_Other;
    
    IBOutlet UIView *viewDropDown1_Home;
    IBOutlet UIView *viewDropDown2_Home;
    IBOutlet UIView *viewDropDown3_Home;
    IBOutlet UIView *viewDropDown4_Home;
    
    IBOutlet UIView *viewDropDown1_Office;
    IBOutlet UIView *viewDropDown2_Office;
    IBOutlet UIView *viewDropDown3_Office;
    IBOutlet UIView *viewDropDown4_Office;
    
    IBOutlet UIView *viewDropDown1_Other;
    IBOutlet UIView *viewDropDown2_Other;
    IBOutlet UIView *viewDropDown3_Other;
    IBOutlet UIView *viewDropDown4_Other;
    
    IBOutlet UIButton *btnSave_Home;
    IBOutlet UIButton *btnSave_Office;
    IBOutlet UIButton *btnSave_Other;
    
    IBOutlet UIButton *btnDropDown1_Home;
    IBOutlet UIButton *btnDropDown2_Home;
    IBOutlet UIButton *btnDropDown3_Home;
    IBOutlet UIButton *btnDropDown4_Home;
    
    IBOutlet UIButton *btnDropDown1_Office;
    IBOutlet UIButton *btnDropDown2_Office;
    IBOutlet UIButton *btnDropDown3_Office;
    IBOutlet UIButton *btnDropDown4_Office;
    
    IBOutlet UIButton *btnDropDown1_Other;
    IBOutlet UIButton *btnDropDown2_Other;
    IBOutlet UIButton *btnDropDown3_Other;
    IBOutlet UIButton *btnDropDown4_Other;
    
    IBOutlet UIButton *btnDropDownAddressType;
    IBOutlet ComboBox *txtFldDropDownAddressType;
    IBOutlet UIView *viewDropDownAddressTypeButton;
    
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

-(IBAction)OnClickGoHomeButton:(id)sender;
-(IBAction)OnClickRegisterButton:(id)sender;

-(IBAction)OnClickGoBackButton:(id)sender;
-(IBAction)OnClickShowCharsButton:(id)sender;

-(IBAction)OnClickAgreeTermsButton:(id)sender;

-(IBAction)OnClickHome_AddressTypeButton:(id)sender;
-(IBAction)OnClickOffice_AddressTypeButton:(id)sender;
-(IBAction)OnClickOther_AddressTypeButton:(id)sender;

-(BOOL)OnClickSave_HomeButton:(id)sender;
-(BOOL)OnClickSave_OfficeButton:(id)sender;
-(BOOL)OnClickSave_OtherButton:(id)sender;

-(IBAction)OnClickDropDown1_Home:(id)sender;
-(IBAction)OnClickDropDown2_Home:(id)sender;
-(IBAction)OnClickDropDown3_Home:(id)sender;
-(IBAction)OnClickDropDown4_Home:(id)sender;

-(IBAction)OnClickDropDown1_Office:(id)sender;
-(IBAction)OnClickDropDown2_Office:(id)sender;
-(IBAction)OnClickDropDown3_Office:(id)sender;
-(IBAction)OnClickDropDown4_Office:(id)sender;

-(IBAction)OnClickDropDown1_Other:(id)sender;
-(IBAction)OnClickDropDown2_Other:(id)sender;
-(IBAction)OnClickDropDown3_Other:(id)sender;
-(IBAction)OnClickDropDown4_Other:(id)sender;

-(IBAction)OnClickDropDownAddressTypeButton:(id)sender;

-(void)KeyBoardShown:(NSNotification *)notification;
-(void)ChangeLanguageToArabic;
-(void)ChangeLanguageToEnglish;
- (void)SetFont;
//- (void)InitialiseTableViews;
//- (void)CheckMobileNumberVerfied;
-(void)SetTableHight:(NSArray *)aryData;

-(void)CheckForCompleteAddress;
-(BOOL)CheckForCompleteHomeAddress;
-(BOOL)CheckForCompleteOfficeAddress;
-(BOOL)CheckForCompleteOtherAddress;
-(BOOL)CheckForEmptyHomeAddress;
-(BOOL)CheckForEmptyOfficeAddress;
-(BOOL)CheckForEmptyOtherAddress;

@end
