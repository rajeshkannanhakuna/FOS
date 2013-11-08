//
//  EditProfile.h
//  
//
//  Created by segate on 26/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"
#import "ComboBox.h"

@interface EditProfile : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UIScrollView *scrollViewEditProfile;
    
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblPersonalInfo;
    IBOutlet UILabel *lblFirstName;
    IBOutlet UILabel *lblLastName;
    IBOutlet UILabel *lblAge;
    IBOutlet UILabel *lblHomeCity;
    IBOutlet UILabel *lblMobileNumber;
    IBOutlet UILabel *lblContactInfo;
//    IBOutlet UILabel *lblFlatNoDoorNo;
//    IBOutlet UILabel *lblApartmentName;
//    IBOutlet UILabel *lblAddressLine1;
//    IBOutlet UILabel *lblAddressLine2;
//    IBOutlet UILabel *lblLandmark;
//    IBOutlet UILabel *lblArea;
//    IBOutlet UILabel *lblCity;
    IBOutlet UILabel *lblHome;
    IBOutlet UILabel *lblOffice;
    IBOutlet UILabel *lblOther;
    
    
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnSave;
    
//    IBOutlet UIButton *btnSelectArea;
//    IBOutlet UIButton *btnSelectCity;
    
    IBOutlet UITextField *txtFldFirstName;
    IBOutlet UITextField *txtFldLastName;
    IBOutlet UITextField *txtFldAge;
    IBOutlet UITextField *txtFldHomeCity;
    IBOutlet UITextField *txtFldMobileNo;
    
    UITableView *tblViewCityList;
    UITableView *tblViewAreaList;
    
//    IBOutlet UIImageView *imgViewDropDownBG1;
//    IBOutlet UIImageView *imgViewDropDownBG2;
//    
//    IBOutlet UIView *viewDropDown1;
//    IBOutlet UIView *viewDropDown2;
    IBOutlet UIView *viewFooter;
    IBOutlet UIView *viewEditProfile;
    
    IBOutlet UIView *viewPopUp;
    IBOutlet UILabel *lblRequired;
    
    IBOutlet UIButton *btnAddressType_Home;
    IBOutlet UIButton *btnAddressType_Office;
    IBOutlet UIButton *btnAddressType_Other;
    
//    UITableView *tblViewCityList_Home;
//    UITableView *tblViewAreaList_Home;
//    UITableView *tblViewStateList_Home;
//    UITableView *tblViewCountryList_Home;
//    UITableView *tblViewCityList_Office;
//    UITableView *tblViewAreaList_Office;
//    UITableView *tblViewStateList_Office;
//    UITableView *tblViewCountryList_Office;
//    UITableView *tblViewCityList_Other;
//    UITableView *tblViewAreaList_Other;
//    UITableView *tblViewStateList_Other;
//    UITableView *tblViewCountryList_Other;
    
    UITableView *tblViewDropDownList;
 //   IBOutlet UIImageView *imgViewDropDownBG;
    
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
    
//    IBOutlet UIView *viewDropDown1_Home;
//    IBOutlet UIView *viewDropDown2_Home;
//    IBOutlet UIView *viewDropDown3_Home;
//    IBOutlet UIView *viewDropDown4_Home;
//    
//    IBOutlet UIView *viewDropDown1_Office;
//    IBOutlet UIView *viewDropDown2_Office;
//    IBOutlet UIView *viewDropDown3_Office;
//    IBOutlet UIView *viewDropDown4_Office;
//    
//    IBOutlet UIView *viewDropDown1_Other;
//    IBOutlet UIView *viewDropDown2_Other;
//    IBOutlet UIView *viewDropDown3_Other;
//    IBOutlet UIView *viewDropDown4_Other;
    
    IBOutlet UIButton *btnSave_Home;
    IBOutlet UIButton *btnSave_Office;
    IBOutlet UIButton *btnSave_Other;
    
//    IBOutlet UIButton *btnDropDown1_Home;
//    IBOutlet UIButton *btnDropDown2_Home;
//    IBOutlet UIButton *btnDropDown3_Home;
//    IBOutlet UIButton *btnDropDown4_Home;
//    
//    IBOutlet UIButton *btnDropDown1_Office;
//    IBOutlet UIButton *btnDropDown2_Office;
//    IBOutlet UIButton *btnDropDown3_Office;
//    IBOutlet UIButton *btnDropDown4_Office;
//    
//    IBOutlet UIButton *btnDropDown1_Other;
//    IBOutlet UIButton *btnDropDown2_Other;
//    IBOutlet UIButton *btnDropDown3_Other;
//    IBOutlet UIButton *btnDropDown4_Other;
//    
    IBOutlet UIButton *btnDropDownAddressType;
    IBOutlet ComboBox *txtFldDropDownAddressType;
//    IBOutlet UIView *viewDropDownAddressTypeButton;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

-(IBAction)OnClickGoBackButton:(id)sender;
-(IBAction)OnClickSaveButton:(id)sender;
-(IBAction)OnClickSelectAreaButton:(id)sender;
-(IBAction)OnClickSelectCityButton:(id)sender;


-(IBAction)OnClickHome_AddressTypeButton:(id)sender;
-(IBAction)OnClickOffice_AddressTypeButton:(id)sender;
-(IBAction)OnClickOther_AddressTypeButton:(id)sender;

-(IBAction)OnClickSave_HomeButton:(id)sender;
-(IBAction)OnClickSave_OfficeButton:(id)sender;
-(IBAction)OnClickSave_OtherButton:(id)sender;

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
- (void)ChangeLanguageToArabic;
- (void)SetFont;
- (void)SetValuesToTextFields;
- (void)SetHomeAddressValues :(NSDictionary *)dicHomeAddress;
- (void)SetOfficeAddressValues :(NSDictionary *)dicOfficeAddress;
- (void)SetOtherAddressValues :(NSDictionary *)dicOtherAddress;
- (void)CheckMobileNumberVerfied;
- (void)SetTableHight: (NSArray *)aryData;

-(void)CheckForCompleteAddress;
-(BOOL)CheckForCompleteHomeAddress;
-(BOOL)CheckForCompleteOfficeAddress;
-(BOOL)CheckForCompleteOtherAddress;
-(BOOL)CheckForEmptyHomeAddress;
-(BOOL)CheckForEmptyOfficeAddress;
-(BOOL)CheckForEmptyOtherAddress;

@end
