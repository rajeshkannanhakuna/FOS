//
//  EditProfile.m
//  
//
//  Created by segate on 26/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "EditProfile.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import "APIConstants.h"
#import <QuartzCore/QuartzCore.h>
#import "ServiceHandler.h"
#import "ResponseDTO.h"
@interface EditProfile () <ComboBoxDelegate>
{
    NSArray *aryAreaList;
    NSArray *aryCityList;
    NSArray *aryStateList;
    NSArray *aryCountryList;
    NSMutableArray *aryAddressList;
    ServiceHandler *ObjServiceHandler;
    IBOutlet UILabel *lblChoosePrimaryAddress;
}

@end

@implementation EditProfile
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetFont];
    // Do any additional setup after loading the view from its nib.
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    
//    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    aryAddressList = [[NSMutableArray alloc] initWithArray:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_UserAddress]];
    [scrollViewEditProfile setContentSize:CGSizeMake(0, 700)];
    viewHomeAddress.layer.masksToBounds = YES;
    viewHomeAddress.layer.cornerRadius = 3;
    viewHomeAddress.layer.borderColor = [UIColor lightGrayColor].CGColor;
    viewHomeAddress.layer.borderWidth = 1;
    
    viewOfficeAddress.layer.masksToBounds = YES;
    viewOfficeAddress.layer.cornerRadius = 3;
    viewOfficeAddress.layer.borderColor = [UIColor lightGrayColor].CGColor;
    viewOfficeAddress.layer.borderWidth = 1;
    
    viewOtherAddress.layer.masksToBounds = YES;
    viewOtherAddress.layer.cornerRadius = 3;
    viewOtherAddress.layer.borderColor = [UIColor lightGrayColor].CGColor;
    viewOtherAddress.layer.borderWidth = 1;
    
    aryCountryList = [[[UIConstants returnInstance] dicSupportedRegion] objectForKey:key_Countries];
   
    tblViewDropDownList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, txtFldCountry_Other.frame.size.width, 100)];
    tblViewDropDownList.dataSource = self;
    tblViewDropDownList.delegate = self;
    // tblViewDropDownList.tag = 0;
    
    tblViewDropDownList.layer.masksToBounds = YES;
    tblViewDropDownList.layer.cornerRadius = 5;
    tblViewDropDownList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tblViewDropDownList.layer.borderWidth = 2;
    
    
    
    //arabic
    
    UIConstants *constant = [UIConstants returnInstance];
    //home accordian
    CGRect rect = [constant getFrameForLanguage:lblHome.frame withSuperViewRect:viewButton_HomeAddress.frame];
    lblHome.frame = rect;
    
    rect = [constant getFrameForLanguage:imgViewArrow_Home.frame withSuperViewRect:viewButton_HomeAddress.frame];
    imgViewArrow_Home.frame = rect;
    
    // office accordian
    
    rect = [constant getFrameForLanguage:lblOffice.frame withSuperViewRect:viewButton_OfficeAddress.frame];
    lblOffice.frame = rect;
    
    rect = [constant getFrameForLanguage:imgViewArrow_Office.frame withSuperViewRect:viewButton_OfficeAddress.frame];
    imgViewArrow_Office.frame = rect;
    
    
    
    //other accordian
    rect = [constant getFrameForLanguage:lblOther.frame withSuperViewRect:viewButton_OtherAddress.frame];
    lblOther.frame = rect;
    
    
    rect = [constant getFrameForLanguage:imgViewArrow_Other.frame withSuperViewRect:viewButton_OtherAddress.frame];
    imgViewArrow_Other.frame = rect;
    
//    rect = [constant getFrameForLanguage:_imgChooseDropdownArrow.frame withSuperViewRect:viewDropDownAddressTypeButton.frame];
//    _imgChooseDropdownArrow.frame = rect;
//    
    
    //arabic text alignment
    
    lblOther.textAlignment = FOS_TEXTALIGNMENT;
    lblOffice.textAlignment = FOS_TEXTALIGNMENT;
    lblHome.textAlignment = FOS_TEXTALIGNMENT;
//    lblChoosePrimaryAddress.textAlignment = FOS_TEXTALIGNMENT;
//    txtFldDropDownAddressType.textAlignment = FOS_TEXTALIGNMENT;
    
    
    // home
    
    [txtFldCountry_Home loadNibName];
    txtFldCountry_Home.placeHolder = @"Select Country";
    [txtFldState_Home loadNibName];
    txtFldState_Home.placeHolder = @"Select State";
    [txtFldCity_Home loadNibName];
    txtFldCity_Home.placeHolder = @"Select City";
    [txtFldArea_Home loadNibName];
    txtFldArea_Home.placeHolder = @"Select Area";
    
    [txtFldDropDownAddressType loadNibName];
    txtFldDropDownAddressType.placeHolder = @"Address";
    txtFldDropDownAddressType.isDataRefreshNeeded = YES;
    
    
    [txtFldCountry_Office loadNibName];
    txtFldCountry_Office.placeHolder = @"Select Country";
    [txtFldState_Office loadNibName];
    txtFldState_Office.placeHolder = @"Select State";
    [txtFldCity_Office loadNibName];
    txtFldCity_Office.placeHolder = @"Select City";
    [txtFldArea_Office loadNibName];
    txtFldArea_Office.placeHolder = @"Select Area";
    
    //set data
    //other
    
    [txtFldCountry_Other loadNibName];
    txtFldCountry_Other.placeHolder = @"Select Country";
    [txtFldState_Other loadNibName];
    txtFldState_Other.placeHolder = @"Select State";
    [txtFldCity_Other loadNibName];
    txtFldCity_Other.placeHolder = @"Select City";
    [txtFldArea_Other loadNibName];
    txtFldArea_Other.placeHolder = @"Select Area";
    
    

    //load all dataa
    [self SetValuesToTextFields];
    
    //combo box arrary values added
    
    txtFldCountry_Home.arrDataCombo = aryCountryList;
    txtFldCountry_Office.arrDataCombo = aryCountryList;
    txtFldCountry_Other.arrDataCombo = aryCountryList;
    
    txtFldState_Home.arrDataCombo = [[[self getDetailsforArea:nil withCity:nil withState:nil withCountry:txtFldCountry_Home.selectedText]objectAtIndex:0] objectForKey:key_States];
    
    txtFldState_Office.arrDataCombo = [[[self getDetailsforArea:nil withCity:nil withState:nil withCountry:txtFldCountry_Office.selectedText]objectAtIndex:0] objectForKey:key_States];
    txtFldState_Other.arrDataCombo = [[[self getDetailsforArea:nil withCity:nil withState:nil withCountry:txtFldCountry_Other.selectedText] objectAtIndex:0] objectForKey:key_States];
    
    txtFldCity_Home.arrDataCombo = [[[self getDetailsforArea:nil withCity:nil withState:txtFldState_Home.selectedText withCountry:txtFldCountry_Home.selectedText]objectAtIndex:0] objectForKey:key_Cities];
    txtFldCity_Office.arrDataCombo = [[[self getDetailsforArea:nil withCity:nil withState:txtFldState_Office.selectedText withCountry:txtFldCountry_Office.selectedText]objectAtIndex:0] objectForKey:key_Cities];
    txtFldCity_Other.arrDataCombo = [[[self getDetailsforArea:nil withCity:nil withState:txtFldState_Other.selectedText withCountry:txtFldCountry_Other.selectedText]objectAtIndex:0] objectForKey:key_Cities];
    
    txtFldArea_Home.arrDataCombo = [[[self getDetailsforArea:nil withCity:txtFldCity_Home.selectedText withState:txtFldState_Home.selectedText withCountry:txtFldCountry_Home.selectedText] objectAtIndex:0] valueForKey:key_Areas];
     txtFldArea_Office.arrDataCombo =[[ [self getDetailsforArea:nil withCity:txtFldCity_Office.selectedText withState:txtFldState_Office.selectedText withCountry:txtFldCountry_Office.selectedText] objectAtIndex:0] valueForKey:key_Areas];
     txtFldArea_Other.arrDataCombo = [[[self getDetailsforArea:nil withCity:txtFldCity_Other.selectedText withState:txtFldState_Other.selectedText withCountry:txtFldCountry_Other.selectedText] objectAtIndex:0] valueForKey:key_Areas];
    
    //address
    txtFldAddressLine1_Home.textAlignment = FOS_TEXTALIGNMENT;
    txtFldAddressLine2_Home.textAlignment = FOS_TEXTALIGNMENT;
    txtFldAddressLine1_Office.textAlignment = FOS_TEXTALIGNMENT;
    txtFldAddressLine1_Other.textAlignment = FOS_TEXTALIGNMENT;
    txtFldAddressLine2_Office.textAlignment = FOS_TEXTALIGNMENT;
    txtFldAddressLine2_Other.textAlignment = FOS_TEXTALIGNMENT;
    txtFldLandMark_Home.textAlignment = FOS_TEXTALIGNMENT;
    txtFldLandMark_Office.textAlignment = FOS_TEXTALIGNMENT;
    txtFldLandMark_Other.textAlignment = FOS_TEXTALIGNMENT;
    
    if(![[UIConstants returnInstance] isItEnglish])
        [self ChangeLanguageToArabic];
    
}



-(void)viewWillAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)KeyBoardShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
       CGRect rect = viewFooter.frame;
    rect.origin.y -= keyboardSize.height; // keyboard height;
    viewFooter.frame = rect;
    
    
    rect = scrollViewEditProfile.frame;
    rect.size.height -=  216;//= keyboardSize.height;
    scrollViewEditProfile.frame = rect;
    
}


-(void)KeyBoardWillHide:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect rect = viewFooter.frame;
//    rect.origin.y += 216 ;
//    viewFooter.frame = rect;
    [self SetFooterFrame];
    //scrollview frame change
    rect = scrollViewEditProfile.frame;
    rect.size.height +=  216;
    scrollViewEditProfile.frame = rect;
}

#pragma mark - set font

-(void)SetFont
{
    [lblScreenName setFont:[[UIConstants returnInstance] returnCharcoalCY:16]];
    [lblPersonalInfo setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
    [lblFirstName setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
    [lblLastName setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
    [lblAge setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
    [lblHomeCity setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
    [lblMobileNumber setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
    [lblContactInfo setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblFlatNoDoorNo setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblApartmentName setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblAddressLine1 setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblAddressLine2 setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblLandmark setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblArea setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblCity setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblState setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblCountry setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
//    [lblPinCode setFont:[[UIConstants returnInstance] returnArvoRegular:16]];
    
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnSave.titleLabel.font  = [[UIConstants returnInstance] returnArvoBold:15];

    btnSave_Home.titleLabel.font  = [[UIConstants returnInstance] returnArvoBold:14];
    btnSave_Office.titleLabel.font  = [[UIConstants returnInstance] returnArvoBold:14];
    btnSave_Other.titleLabel.font  = [[UIConstants returnInstance] returnArvoBold:14];
    
    [txtFldFirstName setFont:[[UIConstants returnInstance] returnArvoRegular:14]];
    [txtFldLastName setFont:[[UIConstants returnInstance] returnArvoRegular:14]];
    [txtFldAge setFont:[[UIConstants returnInstance] returnArvoRegular:14]];
    [txtFldHomeCity setFont:[[UIConstants returnInstance] returnArvoRegular:14]];
    [txtFldMobileNo setFont:[[UIConstants returnInstance] returnArvoRegular:14]];
    
    lblHome.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblOffice.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblOther.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
    txtFldAddressLine1_Home.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldAddressLine2_Home.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldLandMark_Home.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldArea_Home.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldCity_Home.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldState_Home.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldCountry_Home.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
    txtFldAddressLine1_Office.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldAddressLine2_Office.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldLandMark_Office.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldArea_Office.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldCity_Office.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldState_Office.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldCountry_Office.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
    txtFldAddressLine1_Other.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldAddressLine2_Other.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldLandMark_Other.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldArea_Other.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldCity_Other.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldState_Other.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldCountry_Other.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldDropDownAddressType.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
    lblChoosePrimaryAddress.font = [[UIConstants returnInstance] returnArvoRegular:15];
}

#pragma mark - Set Values to the TextFields

-(void)SetValuesToTextFields
{
    if ([[[UIConstants returnInstance] dicUserDetails] objectForKey:key_FirstName] != [NSNull null])
        txtFldFirstName.text = [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_FirstName];
    
    if ([[[UIConstants returnInstance] dicUserDetails] objectForKey:key_LastName] != [NSNull null])
        txtFldLastName.text = [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_LastName];
    
    if ([[[UIConstants returnInstance] dicUserDetails] objectForKey:key_Age] != [NSNull null])
        txtFldAge.text = [NSString stringWithFormat:@"%@",[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_Age]];
    
//    if ([[[UIConstants returnInstance] dicUserDetails] objectForKey:key_HomeCity] != [NSNull null])
//        txtFldHomeCity.text = [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_HomeCity];
    
    if ([[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo] != [NSNull null])
        txtFldMobileNo.text = [NSString stringWithFormat:@"%@",[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo]];
    
    
    for (NSDictionary *dic in aryAddressList) {
        if ([[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Home]) {
            [self SetHomeAddressValues:dic];
        }else if ([[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Office]) {
            [self SetOfficeAddressValues:dic];
        }else{// if ([[dic objectForKey:key_AddressName] isEqualToString: key_AddressName_Others]) {
            [self SetOtherAddressValues:dic];
        }
        if ([[dic objectForKey:key_IsPrimary] integerValue] == 1) {
            txtFldDropDownAddressType.selectedText = [dic objectForKey:key_AddressName];
        }
    }
}

-(void)SetHomeAddressValues:(NSDictionary *)dicHomeAddress
{
    if([dicHomeAddress objectForKey:key_StreetLine1] != [NSNull null])
        txtFldAddressLine1_Home.text = [dicHomeAddress objectForKey:key_StreetLine1];
    if([dicHomeAddress objectForKey:key_StreetLine2] != [NSNull null])
        txtFldAddressLine2_Home.text = [dicHomeAddress objectForKey:key_StreetLine2];
    if([dicHomeAddress objectForKey:key_Landmark] != [NSNull null])
        txtFldLandMark_Home.text = [dicHomeAddress objectForKey:key_LandMark1];
    if([dicHomeAddress objectForKey:key_Country] != [NSNull null])
        txtFldCountry_Home.selectedText = [dicHomeAddress objectForKey:key_Country];
    if([dicHomeAddress objectForKey:key_State] != [NSNull null])
        txtFldState_Home.selectedText = [dicHomeAddress objectForKey:key_State];
    if([dicHomeAddress objectForKey:key_City] != [NSNull null])
        txtFldCity_Home.selectedText = [dicHomeAddress objectForKey:key_City];
    if([dicHomeAddress objectForKey:key_Area] != [NSNull null])
        txtFldArea_Home.selectedText = [dicHomeAddress objectForKey:key_Area];
    
//    if ([[UIConstants returnInstance] isItEnglish]) {
//        [btnSave_Home setTitle:Update_English forState:UIControlStateNormal];
//    }else{
//        [btnSave_Home setTitle:Update_Arabic forState:UIControlStateNormal];
//    }
}

-(void)SetOfficeAddressValues:(NSDictionary *)dicOfficeAddress
{
    if([dicOfficeAddress objectForKey:key_StreetLine1] != [NSNull null])
        txtFldAddressLine1_Office.text = [dicOfficeAddress objectForKey:key_StreetLine1];
    if([dicOfficeAddress objectForKey:key_StreetLine2] != [NSNull null])
        txtFldAddressLine2_Office.text = [dicOfficeAddress objectForKey:key_StreetLine2];
    if([dicOfficeAddress objectForKey:key_LandMark1] != [NSNull null])
        txtFldLandMark_Office.text = [dicOfficeAddress objectForKey:key_LandMark1];
    if([dicOfficeAddress objectForKey:key_Country] != [NSNull null])
        txtFldCountry_Office.selectedText = [dicOfficeAddress objectForKey:key_Country];
    if([dicOfficeAddress objectForKey:key_State] != [NSNull null])
        txtFldState_Office.selectedText = [dicOfficeAddress objectForKey:key_State];
    if([dicOfficeAddress objectForKey:key_City] != [NSNull null])
        txtFldCity_Office.selectedText = [dicOfficeAddress objectForKey:key_City];
    if([dicOfficeAddress objectForKey:key_Area] != [NSNull null])
        txtFldArea_Office.selectedText = [dicOfficeAddress objectForKey:key_Area];
    
//    if ([[UIConstants returnInstance] isItEnglish]) {
//        [btnSave_Office setTitle:Update_English forState:UIControlStateNormal];
//    }else{
//        [btnSave_Office setTitle:Update_Arabic forState:UIControlStateNormal];
//    }
}

-(void)SetOtherAddressValues:(NSDictionary *)dicOtherAddress
{
    if([dicOtherAddress objectForKey:key_AddressName] != [NSNull null])
        txtFldAddressName_Other.text = [dicOtherAddress objectForKey:key_AddressName];
    if([dicOtherAddress objectForKey:key_StreetLine1] != [NSNull null])
        txtFldAddressLine1_Other.text = [dicOtherAddress objectForKey:key_StreetLine1];
    if([dicOtherAddress objectForKey:key_StreetLine2] != [NSNull null])
        txtFldAddressLine2_Other.text = [dicOtherAddress objectForKey:key_StreetLine2];
    if([dicOtherAddress objectForKey:key_LandMark1] != [NSNull null])
        txtFldLandMark_Other.text = [dicOtherAddress objectForKey:key_LandMark1];
    if([dicOtherAddress objectForKey:key_Country] != [NSNull null])
        txtFldCountry_Other.selectedText = [dicOtherAddress objectForKey:key_Country];
    if([dicOtherAddress objectForKey:key_State] != [NSNull null])
        txtFldState_Other.selectedText = [dicOtherAddress objectForKey:key_State];
    if([dicOtherAddress objectForKey:key_City] != [NSNull null])
        txtFldCity_Other.selectedText = [dicOtherAddress objectForKey:key_City];
    if([dicOtherAddress objectForKey:key_Area] != [NSNull null])
        txtFldArea_Other.selectedText = [dicOtherAddress objectForKey:key_Area];
    
//    if ([[UIConstants returnInstance] isItEnglish]) {
//        [btnSave_Other setTitle:Update_English forState:UIControlStateNormal];
//    }else{
//        [btnSave_Other setTitle:Update_Arabic forState:UIControlStateNormal];
//    }
}



#pragma mark - Button action methods

-(void)OnClickGoBackButton:(id)sender
{
//    [self.delegate GoBack:YES];
    [self.view endEditing:YES];
    [self.delegate commonBack];    
}

-(void)OnClickSaveButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    
    int X = 150;
    if ([txtFldFirstName.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldFirstName.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewEditProfile addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:txtFldFirstName.frame.origin animated:YES];
        return;
    }else if ([txtFldFirstName.text length] < 2) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_NameMinimumChar_English:Alert_NameMinimumChar_Arabic];
        // txtFldName.text = @"";
        [txtFldFirstName becomeFirstResponder];
        return;
    }
    
    if ([txtFldLastName.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLastName.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewEditProfile addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:txtFldLastName.frame.origin animated:YES];
        return;
    }

//    if ([txtFldHomeCity.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldHomeCity.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewEditProfile addSubview:viewPopUp];
//        [scrollViewEditProfile setContentOffset:txtFldHomeCity.frame.origin animated:YES];
//        return;
//    }
    if ([txtFldMobileNo.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldMobileNo.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewEditProfile addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:txtFldMobileNo.frame.origin animated:YES];
        return;
    }else if ([txtFldMobileNo.text length] != 10) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_MobileNumberInvalid_English:Alert_MobileNumberInvalid_Arabic];
        //txtFldMobileNumber.text = @"";
        [txtFldMobileNo becomeFirstResponder];
        return;
    }
    
    if (viewHomeAddress.superview != nil) {
        if([self CheckForCompleteHomeAddress] || [self CheckForEmptyHomeAddress]){
        }else{
            [self OnClickSave_HomeButton:nil];
            return;
        }
    }
    
    if (viewOfficeAddress.superview != nil) {
        if([self CheckForCompleteOfficeAddress] || [self CheckForEmptyOfficeAddress]){
        }else{
            [self OnClickSave_OfficeButton:nil];
            return;
        }
    }
    
    if (viewOtherAddress.superview != nil) {
        if([self CheckForCompleteOtherAddress] || [self CheckForEmptyOtherAddress]){
        }else{
            [self OnClickSave_OtherButton:nil];
            return;
        }
    }
    
    ObjServiceHandler = [[ServiceHandler alloc] init];
    
    if ([ObjServiceHandler GetWebUserUpdateProfileAPI:[[UIConstants returnInstance] strFosUserID] :txtFldFirstName.text :txtFldLastName.text :[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_EmailID] :txtFldAge.text :txtFldMobileNo.text :@"1" :@"" :aryAddressList :@"" :@""]) {
        if ([[[[ResponseDTO sharedInstance] DTO_UpdateProfileResponse] objectForKey:key_StatusCode] integerValue] == 200) {
            [[UIConstants returnInstance] setDicUserDetails:[[ResponseDTO sharedInstance] DTO_UpdateProfileResponse]];
            [[UIConstants returnInstance] setStrUserMobileNo:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo]];
            [self CheckMobileNumberVerfied];
            [self.delegate commonBack];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_UpdateProfileResponse] objectForKey:key_StatusMessage]];
        }
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    
    [ObjServiceHandler release], ObjServiceHandler = nil;
}

-(void)OnClickSelectAreaButton:(id)sender
{
    if ([[UIConstants returnInstance] arySupportedArea]) {
        aryAreaList = [[UIConstants returnInstance] arySupportedArea];
    }
    if ([aryAreaList count] >= 1) {
        if (tblViewAreaList.superview == nil) {
            [viewEditProfile addSubview:tblViewAreaList];
        }else{
            [tblViewAreaList removeFromSuperview];
        }
    }
}

-(void)OnClickSelectCityButton:(id)sender
{
    if ([[UIConstants returnInstance] arySupportedCities]) {
        aryCityList = [[UIConstants returnInstance] arySupportedCities];
    }
    if ([aryCityList count] >= 1) {
        if (tblViewCityList.superview == nil) {
            [viewEditProfile addSubview:tblViewCityList];
        }else{
            [tblViewCityList removeFromSuperview];
        }
    }
}

-(void)OnClickHome_AddressTypeButton:(id)sender
{
//    aryAreaList = nil;
//    aryCityList = nil;
//    aryStateList = nil;
   [self SetFooterFrame];
    [self.view endEditing:YES];
    if (viewHomeAddress.superview == nil) {
        
        if (viewOfficeAddress.superview != nil) {
            if ([self CheckForCompleteOfficeAddress] ||[self CheckForEmptyOfficeAddress]) {
                [viewOfficeAddress removeFromSuperview];
                imgViewArrow_Office.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewOfficeAddress.frame.size.height)];
            }else{
                [self OnClickSave_OfficeButton:nil];
                return;
            }
        }
        
        if (viewOtherAddress.superview != nil) {
            if([self CheckForCompleteOtherAddress] || [self CheckForEmptyOtherAddress]){
                [viewOtherAddress removeFromSuperview];
                imgViewArrow_Other.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewOtherAddress.frame.size.height)];
            }else{
                [self OnClickSave_OtherButton:nil];
                return;
            }
        }
        
        viewHomeAddress.frame = CGRectMake(0, viewButton_HomeAddress.frame.origin.y + viewButton_HomeAddress.frame.size.height, viewHomeAddress.frame.size.width, viewHomeAddress.frame.size.height);
        [viewEditProfile addSubview:viewHomeAddress];
        
        imgViewArrow_Home.image = [UIImage imageNamed:@"upArrow.png"];
        
        viewButton_OfficeAddress.frame = CGRectMake(0, viewHomeAddress.frame.origin.y + viewHomeAddress.frame.size.height + 7, viewButton_OfficeAddress.frame.size.width, viewButton_OfficeAddress.frame.size.height);
        
        
        viewButton_OtherAddress.frame = CGRectMake(0, viewButton_OfficeAddress.frame.origin.y + viewButton_OfficeAddress.frame.size.height + 7, viewButton_OtherAddress.frame.size.width, viewButton_OtherAddress.frame.size.height);
        
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        
        [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height+viewHomeAddress.frame.size.height)];
    }else{
        if([self CheckForCompleteHomeAddress] || [self CheckForEmptyHomeAddress]){
            [viewHomeAddress removeFromSuperview];
            if (viewPopUp.superview == viewHomeAddress) {
                [viewPopUp removeFromSuperview];
            }
        }else{
            [self OnClickSave_HomeButton:nil];
            return;
        }
        imgViewArrow_Home.image = [UIImage imageNamed:@"downArrow@2x.png"];
        
        viewButton_OfficeAddress.frame = CGRectMake(0, viewButton_HomeAddress.frame.origin.y + viewButton_HomeAddress.frame.size.height + 7, viewButton_OfficeAddress.frame.size.width, viewButton_OfficeAddress.frame.size.height);
        viewButton_OtherAddress.frame = CGRectMake(0, viewButton_OfficeAddress.frame.origin.y + viewButton_OfficeAddress.frame.size.height + 7, viewButton_OtherAddress.frame.size.width, viewButton_OtherAddress.frame.size.height);
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        
        [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewHomeAddress.frame.size.height)];
    }
}

-(void)OnClickOffice_AddressTypeButton:(id)sender
{
//    aryAreaList = nil;
//    aryCityList = nil;
//    aryStateList = nil;
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if (viewOfficeAddress.superview == nil) {
        if (viewHomeAddress.superview != nil) {
            if([self CheckForCompleteHomeAddress] || [self CheckForEmptyHomeAddress]){
                [viewHomeAddress removeFromSuperview];
                imgViewArrow_Home.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewHomeAddress.frame.size.height)];
            }else{
                [self OnClickSave_HomeButton:nil];
                return;
            }
        }
        
        if (viewOtherAddress.superview != nil) {
            if([self CheckForCompleteOtherAddress] || [self CheckForEmptyOtherAddress]){
                [viewOtherAddress removeFromSuperview];
                imgViewArrow_Other.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewOtherAddress.frame.size.height)];
            }else{
                [self OnClickSave_OtherButton:nil];
                return;
            }
        }
        
        viewButton_OfficeAddress.frame = CGRectMake(0, viewButton_HomeAddress.frame.origin.y + viewButton_HomeAddress.frame.size.height + 7, viewButton_OfficeAddress.frame.size.width, viewButton_OfficeAddress.frame.size.height);
        
        viewOfficeAddress.frame = CGRectMake(0, viewButton_OfficeAddress.frame.origin.y + viewButton_OfficeAddress.frame.size.height, viewOfficeAddress.frame.size.width, viewOfficeAddress.frame.size.height);
        [viewEditProfile addSubview:viewOfficeAddress];
        
        imgViewArrow_Office.image = [UIImage imageNamed:@"upArrow.png"];
        
        viewButton_OtherAddress.frame = CGRectMake(0, viewOfficeAddress.frame.origin.y + viewOfficeAddress.frame.size.height + 7, viewButton_OtherAddress.frame.size.width, viewButton_OtherAddress.frame.size.height);
        
        
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        
        [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height+viewOfficeAddress.frame.size.height)];
    }else{
        if([self CheckForCompleteOfficeAddress] || [self CheckForEmptyOfficeAddress]){
            [viewOfficeAddress removeFromSuperview];
            if (viewPopUp.superview == viewOfficeAddress) {
                [viewPopUp removeFromSuperview];
            }
        }else{
            [self OnClickSave_OfficeButton:nil];
            return;
        }
        imgViewArrow_Office.image = [UIImage imageNamed:@"downArrow@2x.png"];
        
        viewButton_OtherAddress.frame = CGRectMake(0, viewButton_OfficeAddress.frame.origin.y + viewButton_OfficeAddress.frame.size.height + 7, viewButton_OtherAddress.frame.size.width, viewButton_OtherAddress.frame.size.height);
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        
        [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewOfficeAddress.frame.size.height)];
    }
}

-(void)OnClickOther_AddressTypeButton:(id)sender
{
//    aryAreaList = nil;
//    aryCityList = nil;
//    aryStateList = nil;
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if (viewOtherAddress.superview == nil) {
        if (viewHomeAddress.superview != nil) {
            if([self CheckForCompleteHomeAddress] || [self CheckForEmptyHomeAddress]){
                [viewHomeAddress removeFromSuperview];
                imgViewArrow_Home.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewHomeAddress.frame.size.height)];
            }else{
                [self OnClickSave_HomeButton:nil];
                return;
            }
        }
        
        if (viewOfficeAddress.superview != nil) {
            if([self CheckForCompleteOfficeAddress] || [self CheckForEmptyOfficeAddress]){
                [viewOfficeAddress removeFromSuperview];
                imgViewArrow_Office.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewOfficeAddress.frame.size.height)];
            }else{
                [self OnClickSave_OfficeButton:nil];
                return;
            }
        }
        
        viewButton_OfficeAddress.frame = CGRectMake(0, viewButton_HomeAddress.frame.origin.y + viewButton_HomeAddress.frame.size.height + 7, viewButton_OfficeAddress.frame.size.width, viewButton_OfficeAddress.frame.size.height);
        
        
        viewButton_OtherAddress.frame = CGRectMake(0, viewButton_OfficeAddress.frame.origin.y + viewButton_OfficeAddress.frame.size.height + 7, viewButton_OtherAddress.frame.size.width, viewButton_OtherAddress.frame.size.height);
        
        viewOtherAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height, viewOtherAddress.frame.size.width, viewOtherAddress.frame.size.height);
        [viewEditProfile addSubview:viewOtherAddress];
        
        imgViewArrow_Other.image = [UIImage imageNamed:@"upArrow.png"];
        
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewOtherAddress.frame.origin.y + viewOtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height+viewOtherAddress.frame.size.height)];
    }else{
        if([self CheckForCompleteOtherAddress] || [self CheckForEmptyOtherAddress]){
            [viewOtherAddress removeFromSuperview];
            if (viewPopUp.superview == viewOtherAddress) {
                [viewPopUp removeFromSuperview];
            }
        }else{
            [self OnClickSave_OtherButton:nil];
            return;
        }
        imgViewArrow_Other.image = [UIImage imageNamed:@"downArrow@2x.png"];
        
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        [scrollViewEditProfile setContentSize:CGSizeMake(0, scrollViewEditProfile.contentSize.height-viewOtherAddress.frame.size.height)];
    }
}

-(void)OnClickSave_HomeButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    int X = 150;
    
    if ([txtFldAddressLine1_Home.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressLine1_Home.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewHomeAddress addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:viewHomeAddress.frame.origin animated:YES];
        return;
    }
    
//    if ([txtFldAddressLine2_Home.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldAddressLine2_Home.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewHomeAddress addSubview:viewPopUp];
//        [scrollViewEditProfile setContentOffset:viewHomeAddress.frame.origin animated:YES];
//        return;
//    }
    
    if ([txtFldLandMark_Home.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLandMark_Home.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewHomeAddress addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:viewHomeAddress.frame.origin animated:YES];
        return;
    }
    
    if ([txtFldCountry_Home.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCountry_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCountry_Arabic];
        }
        return;
    }
    
    if ([txtFldState_Home.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourState_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourState_Arabic];
        }
        return;
    }
    
    if ([txtFldCity_Home.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCity_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCity_Arabic];
        }
        return;
    }
    
    if ([txtFldArea_Home.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourArea_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourArea_Arabic];
        }
        return;
    }
    
    //[self OnClickHome_AddressTypeButton:nil];
    
//     BOOL alreadyPresent = NO;
//    for (NSMutableDictionary *dic in aryAddressList) {
//        if ([[dic objectForKey:key_AddressName] isEqualToString: key_AddressName_Home]) {
//            alreadyPresent = YES;
//            [dic setObject:txtFldAddressLine1_Home.text forKey:key_StreetLine1];
//            [dic setObject:txtFldAddressLine2_Home.text forKey:key_StreetLine2];
//            [dic setObject:txtFldLandMark_Home.text forKey:key_LandMark1];
//            [dic setObject:txtFldCountry_Home.selectedText forKey:key_Country];
//            [dic setObject:txtFldState_Home.selectedText forKey:key_State];
//            [dic setObject:txtFldArea_Home.selectedText forKey:key_Area];
//            [dic setObject:txtFldCity_Home.selectedText forKey:key_City];
//            break;
//        }
//    }
//    
//    if(!alreadyPresent){
//        [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Home.text, key_StreetLine1,txtFldAddressLine2_Home.text, key_StreetLine2,key_AddressName_Home,key_AddressName,@"0", key_IsPrimary, txtFldArea_Home.selectedText,key_Area,txtFldCity_Home.selectedText, key_City,txtFldState_Home.selectedText, key_State, txtFldCountry_Home.selectedText, key_Country, txtFldLandMark_Home.text, key_LandMark1, @"0", key_IsVerified, nil]];
//    }
//    
//    if ([aryAddressList count] == 1) {
//        txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
//    }
    
}
-(void)OnClickSave_OfficeButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    int X = 150;
    
    if ([txtFldAddressLine1_Office.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressLine1_Office.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOfficeAddress addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:viewOfficeAddress.frame.origin animated:YES];
        return;
    }
//    if ([txtFldAddressLine2_Office.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldAddressLine2_Office.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewOfficeAddress addSubview:viewPopUp];
//        [scrollViewEditProfile setContentOffset:viewOfficeAddress.frame.origin animated:YES];
//        return;
//    }
    
    if ([txtFldLandMark_Office.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLandMark_Office.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOfficeAddress addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:viewOfficeAddress.frame.origin animated:YES];
        return;
    }
    
    if ([txtFldCountry_Office.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCountry_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCountry_Arabic];
        }
        return;
    }
    
    if ([txtFldState_Office.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourState_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourState_Arabic];
        }
        return;
    }
    
    if ([txtFldCity_Office.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCity_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCity_Arabic];
        }
        return;
    }
    
    if ([txtFldArea_Office.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourArea_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourArea_Arabic];
        }
        return;
    }
    
//    [self OnClickOffice_AddressTypeButton:nil];
//    
//    BOOL alreadyPresent = NO; // check office address already there
//    for (NSMutableDictionary *dic in aryAddressList) {
//        if ([[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Office]) {
//             alreadyPresent = YES;
//            [dic setObject:txtFldAddressLine1_Office.text forKey:key_StreetLine1];
//            [dic setObject:txtFldAddressLine2_Office.text forKey:key_StreetLine2];
//            [dic setObject:txtFldLandMark_Office.text forKey:key_LandMark1];
//            [dic setObject:txtFldCountry_Office.selectedText forKey:key_Country];
//            [dic setObject:txtFldState_Office.selectedText forKey:key_State];
//            [dic setObject:txtFldArea_Office.selectedText forKey:key_Area];
//            [dic setObject:txtFldCity_Office.selectedText forKey:key_City];
//            break;
//        }
//    }
//    
//    if(!alreadyPresent){
//       [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Office.text, key_StreetLine1,txtFldAddressLine2_Office.text, key_StreetLine2,key_AddressName_Office,key_AddressName,@"0", key_IsPrimary, txtFldArea_Office.selectedText,key_Area,txtFldCity_Office.selectedText, key_City,txtFldState_Office.selectedText, key_State, txtFldCountry_Office.selectedText, key_Country, txtFldLandMark_Office.text, key_LandMark1, @"0", key_IsVerified, nil]];
//    }
//
//    if ([aryAddressList count] == 1) {
//        txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
//    }
}
-(void)OnClickSave_OtherButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    int X = 150;
    
    if ([txtFldAddressName_Other.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressName_Other.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOtherAddress addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return;
    }else{
        if(![self CheckForAddressName]){
            txtFldAddressName_Other.text = @"";
            [txtFldAddressName_Other becomeFirstResponder];
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_AddressNameNotMatch_English:Alert_AddressNameNotMatch_Arabic];
            return;
        }
    }
    
    if ([txtFldAddressLine1_Other.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressLine1_Other.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOtherAddress addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return;
    }
    
//    if ([txtFldAddressLine2_Other.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldAddressLine2_Other.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewOtherAddress addSubview:viewPopUp];
//        [scrollViewEditProfile setContentOffset:viewOtherAddress.frame.origin animated:YES];
//        return;
//    }
    
    if ([txtFldLandMark_Other.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLandMark_Other.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOtherAddress addSubview:viewPopUp];
        [scrollViewEditProfile setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return;
    }
    
    if ([txtFldCountry_Other.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCountry_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCountry_Arabic];
        }
        return;
    }
    
    if ([txtFldState_Other.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourState_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourState_Arabic];
        }
        return;
    }
    
    if ([txtFldCity_Other.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCity_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourCity_Arabic];
        }
        return;
    }
    
    if ([txtFldArea_Other.selectedText length] == 0) {
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourArea_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_SelectYourArea_Arabic];
        }
        return;
    }
    
//    [self OnClickOther_AddressTypeButton:nil];
//    
//    BOOL alreadyPresent = NO; // check office address already there
//    for (NSMutableDictionary *dic in aryAddressList) {
//        if ([[dic objectForKey:key_AddressName] isEqualToString: key_AddressName_Others]) {
//            alreadyPresent = YES;
//            [dic setObject:txtFldAddressLine1_Other.text forKey:key_StreetLine1];
//            [dic setObject:txtFldAddressLine2_Other.text forKey:key_StreetLine2];
//            [dic setObject:txtFldLandMark_Other.text forKey:key_LandMark1];
//            [dic setObject:txtFldCountry_Other.selectedText forKey:key_Country];
//            [dic setObject:txtFldState_Other.selectedText forKey:key_State];
//            [dic setObject:txtFldArea_Other.selectedText forKey:key_Area];
//            [dic setObject:txtFldCity_Other.selectedText forKey:key_City];
//            break;
//        }
//    }
//    if(!alreadyPresent){
//        [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Other.text, key_StreetLine1,txtFldAddressLine2_Other.text, key_StreetLine2,key_AddressName_Others,key_AddressName,@"0", key_IsPrimary, txtFldArea_Other.selectedText,key_Area,txtFldCity_Other.selectedText, key_City,txtFldState_Other.selectedText, key_State, txtFldCountry_Other.selectedText, key_Country, txtFldLandMark_Other.text, key_LandMark1, @"0", key_IsVerified, nil]];
//    }
//
// if ([aryAddressList count] == 1) {
//        txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
//    }
}

-(void)OnClickDropDown1_Home:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([txtFldCity_Home.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Home.frame.origin.y+txtFldArea_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 11;
            
            aryAreaList = [self getDetailsforArea:nil withCity:txtFldCity_Home.selectedText withState:txtFldState_Home.selectedText withCountry:txtFldCountry_Home.selectedText];
           
            if([aryAreaList count] > 0){
                aryAreaList =[[aryAreaList objectAtIndex:0] objectForKey:key_Areas];
            }
            
            
            [viewHomeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 11) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Home.frame.origin.y+txtFldArea_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 11;
                [viewHomeAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
            
        }
    }
    
    //    if (tblViewAreaList_Home.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewAreaList_Home];
    //    }else{
    //        [tblViewAreaList_Home removeFromSuperview];
    //    }
}
-(void)OnClickDropDown2_Home:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([txtFldState_Home.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Home.frame.origin.y+txtFldCity_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 12;
            
           aryCityList = [self getDetailsforArea:nil withCity:nil withState:txtFldState_Home.selectedText withCountry:txtFldCountry_Home.selectedText];
            if([aryCityList count] > 0){
                aryCityList =[[aryCityList objectAtIndex:0] objectForKey:key_Cities];
            }

            [viewHomeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 12) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Home.frame.origin.y+txtFldCity_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 12;
                [viewHomeAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewCityList_Home.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewCityList_Home];
    //    }else{
    //        [tblViewCityList_Home removeFromSuperview];
    //    }
}



-(void)OnClickDropDown3_Home:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    NSLog(@"%@",txtFldCountry_Home.selectedText);
    if ([txtFldCountry_Home.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldState_Home.frame.origin.y+txtFldState_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
              tblViewDropDownList.tag = 13;
            aryStateList = [self getDetailsforArea:nil withCity:nil withState:nil withCountry:txtFldCountry_Home.selectedText];
            aryStateList =[[aryStateList objectAtIndex:0] objectForKey:key_States];
            [viewHomeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 13) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldState_Home.frame.origin.y+txtFldState_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 13;
                [viewHomeAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewStateList_Home.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewStateList_Home];
    //    }else{
    //        [tblViewStateList_Home removeFromSuperview];
    //    }
    
}



-(void)OnClickDropDown4_Home:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([aryCountryList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Home.frame.origin.y+txtFldCountry_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 14;
            [viewHomeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 14) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Home.frame.origin.y+txtFldCountry_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 14;
                [viewHomeAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewCountryList_Home.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewCountryList_Home];
    //    }else{
    //        [tblViewCountryList_Home removeFromSuperview];
    //    }
    
}

-(void)OnClickDropDown1_Office:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([txtFldCity_Office.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Office.frame.origin.y+txtFldArea_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 21;
            
           aryAreaList = [self getDetailsforArea:nil withCity:txtFldCity_Office.selectedText withState:txtFldState_Office.selectedText withCountry:txtFldCountry_Office.selectedText];
            if([aryAreaList count] > 0){
                aryAreaList =[[aryAreaList objectAtIndex:0] objectForKey:key_Areas];
            }

            
            [viewOfficeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 21) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Office.frame.origin.y+txtFldArea_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 21;
                [viewOfficeAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewAreaList_Office.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewAreaList_Office];
    //    }else{
    //        [tblViewAreaList_Office removeFromSuperview];
    //    }
}
-(void)OnClickDropDown2_Office:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([txtFldState_Office.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Office.frame.origin.y+txtFldCity_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 22;
            
            aryCityList = [self getDetailsforArea:nil withCity:nil withState:txtFldState_Office.selectedText withCountry:txtFldCountry_Office.selectedText];
            if([aryCityList count] > 0){
                aryCityList =[[aryCityList objectAtIndex:0] objectForKey:key_Cities];
            }
            [viewOfficeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 22) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Office.frame.origin.y+txtFldCity_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 22;
                [viewOfficeAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewCityList_Office.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewCityList_Office];
    //    }else{
    //        [tblViewCityList_Office removeFromSuperview];
    //    }
}
-(void)OnClickDropDown3_Office:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([txtFldCountry_Office.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldState_Office.frame.origin.y+txtFldState_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 23;
            
            aryStateList = [self getDetailsforArea:nil withCity:nil withState:nil withCountry:txtFldCountry_Office.selectedText];
            if([aryStateList count] > 0){
                aryStateList =[[aryStateList objectAtIndex:0] objectForKey:key_States];
            }

            
            [viewOfficeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 23) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldState_Office.frame.origin.y+txtFldState_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 23;
                [viewOfficeAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewStateList_Office.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewStateList_Office];
    //    }else{
    //        [tblViewStateList_Office removeFromSuperview];
    //    }
}
-(void)OnClickDropDown4_Office:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([aryCountryList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Office.frame.origin.y+txtFldCountry_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 24;
            [viewOfficeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 24) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Office.frame.origin.y+txtFldCountry_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 24;
                [viewOfficeAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewCountryList_Office.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewCountryList_Office];
    //    }else{
    //        [tblViewCountryList_Office removeFromSuperview];
    //    }
}

-(void)OnClickDropDown1_Other:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([txtFldCity_Other.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Other.frame.origin.y+txtFldArea_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 31;
            
            aryAreaList = [self getDetailsforArea:nil withCity:txtFldCity_Other.selectedText withState:txtFldState_Other.selectedText withCountry:txtFldCountry_Other.selectedText];
            if([aryAreaList count] > 0){
                aryAreaList =[[aryAreaList objectAtIndex:0] objectForKey:key_Areas];
            }

            
            [viewOtherAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 31) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Other.frame.origin.y+txtFldArea_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 31;
                [viewOtherAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewAreaList_Other.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewAreaList_Other];
    //    }else{
    //        [tblViewAreaList_Other removeFromSuperview];
    //    }
}
-(void)OnClickDropDown2_Other:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([txtFldState_Other.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Other.frame.origin.y+txtFldCity_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 32;
            
           aryCityList = [self getDetailsforArea:nil withCity:nil withState:txtFldState_Other.selectedText withCountry:txtFldCountry_Other.selectedText];
            if([aryCityList count] > 0){
                aryCityList =[[aryCityList objectAtIndex:0] objectForKey:key_Cities];
            }
            

            
            
            [viewOtherAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 32) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Other.frame.origin.y+txtFldCity_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 32;
                [viewOtherAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewCityList_Other.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewCityList_Other];
    //    }else{
    //        [tblViewCityList_Other removeFromSuperview];
    //    }
    
}
-(void)OnClickDropDown3_Other:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([txtFldCountry_Other.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldState_Other.frame.origin.y+txtFldState_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 33;
            
            aryStateList = [self getDetailsforArea:nil withCity:nil withState:nil withCountry:txtFldCountry_Other.selectedText];
            if([aryStateList count] > 0){
                aryStateList =[[aryStateList objectAtIndex:0] objectForKey:key_States];
            }

            
            [viewOtherAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 33) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldState_Other.frame.origin.y+txtFldState_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 33;
                [viewOtherAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewStateList_Other.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewStateList_Other];
    //    }else{
    //        [tblViewStateList_Other removeFromSuperview];
    //    }
}
-(void)OnClickDropDown4_Other:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([aryCountryList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Other.frame.origin.y+txtFldCountry_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 34;
            [viewOtherAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 34) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Other.frame.origin.y+txtFldCountry_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 34;
                [viewOtherAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
    //    if (tblViewCountryList_Other.superview == nil) {
    //        [viewRegisterInfo addSubview:tblViewCountryList_Other];
    //    }else{
    //        [tblViewCountryList_Other removeFromSuperview];
    //    }
}

-(void)OnClickDropDownAddressTypeButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([aryAddressList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldDropDownAddressType.frame.origin.y+txtFldDropDownAddressType.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 10;
            [viewAgreeTerms_ChooseAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
            
            // table view touch not detected
            CGRect rect = viewAgreeTerms_ChooseAddress.frame;
            rect.size.height += 100;
            viewAgreeTerms_ChooseAddress.frame = rect;
            
            CGSize size = scrollViewEditProfile.contentSize;
            size.height += 50;
            scrollViewEditProfile.contentSize = size;
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 10) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldDropDownAddressType.frame.origin.y+txtFldDropDownAddressType.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 10;
                [viewAgreeTerms_ChooseAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
            
            //table view touch not detected
            CGRect rect = viewAgreeTerms_ChooseAddress.frame;
            rect.size.height -= 100;
            viewAgreeTerms_ChooseAddress.frame = rect;
            
            CGSize size = scrollViewEditProfile.contentSize;
            size.height -= 50;
            scrollViewEditProfile.contentSize = size;
        }
    }
}


#pragma mark - Text View Delegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    //[scrollViewEditProfile setContentOffset:CGPointMake(0, textField.frame.origin.y ) animated:YES];
    return  YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
    
    if ([textField.text length] == 0 && [string isEqual: @" "]) {
        return NO;
    }
    
    if (textField == txtFldFirstName) {
        if ([textField.text length]+[string length] > 50 ) {
            return NO;
        }else{
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM "] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }
    }else if (textField == txtFldLastName) {
        if ([textField.text length]+[string length] > 50 ) {
            return NO;
        }else{
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM "] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }
    }else if (textField == txtFldAge) {
        if ([textField.text length]+[string length] > 2 ) {
            return NO;
        }
        static NSCharacterSet *charSet = nil;
        if(!charSet) {
            charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet] retain];
        }
        NSRange location = [string rangeOfCharacterFromSet:charSet];
        return (location.location == NSNotFound);
    }else if (textField == txtFldMobileNo) {
        if ([textField.text length]+[string length] < 11){
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }else return NO;
        
    }else if (textField == txtFldAddressLine1_Home) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldAddressLine2_Home) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldLandMark_Home) {
        if ([textField.text length]+[string length] > 100 ) {
            return NO;
        }else{
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM "] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }
    }else if (textField == txtFldAddressLine1_Office) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldAddressLine2_Office) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldLandMark_Office) {
        if ([textField.text length]+[string length] > 100 ) {
            return NO;
        }else{
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM "] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }
    }else if (textField == txtFldAddressLine1_Other) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldAddressLine2_Other) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldLandMark_Other) {
        if ([textField.text length]+[string length] > 100 ) {
            return NO;
        }else{
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM "] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    NSLog(@"%i", nextTag);
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        
        CGRect rect =viewFooter.frame;
        if(rect.origin.y < 400){
        rect.origin.y += 216; // keyboard
        viewFooter.frame = rect;
        }
        [textField resignFirstResponder];
    }
    return NO;
}


#pragma mark - Table view delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag % 10 == 1) {
        [self SetTableHight:aryAreaList];
        return [aryAreaList count];
    }else if (tableView.tag % 10 == 2) {
        [self SetTableHight:aryCityList];
        return [aryCityList count];
    }else if (tableView.tag % 10 == 3) {
        [self SetTableHight:aryStateList];
        return [aryStateList count];
    }else if (tableView.tag % 10 == 4) {
        [self SetTableHight:aryCountryList];
        return [aryCountryList count];
    }else if (tableView.tag % 10 == 0) {
        [self SetTableHight:aryAddressList];
        return [aryAddressList count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = [[UIConstants returnInstance] returnArvoRegular:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView.tag % 10 == 1) {
        cell.textLabel.text = [[aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Name];
        NSLog(@"%@", [[aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Name]);
    }else if (tableView.tag % 10 == 2) {
        cell.textLabel.text = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_Name];
        NSLog(@"%@", [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_Name]);
    }else if (tableView.tag % 10 == 3) {
        cell.textLabel.text = [[aryStateList objectAtIndex:indexPath.row] objectForKey:key_Name];
        NSLog(@"%@", [[aryStateList objectAtIndex:indexPath.row] objectForKey:key_Name]);
    }else if (tableView.tag % 10 == 4) {
        cell.textLabel.text = [[aryCountryList objectAtIndex:indexPath.row] objectForKey:key_Name];
        NSLog(@"%@", [[aryCountryList objectAtIndex:indexPath.row] objectForKey:key_Name]);
    }else if (tableView.tag % 10 == 0) {
        cell.textLabel.text = [[aryAddressList objectAtIndex:indexPath.row] objectForKey:key_AddressName];
        NSLog(@"%@", [[aryAddressList objectAtIndex:indexPath.row] objectForKey:key_AddressName]);
    }
    
    cell.textLabel.textAlignment = FOS_TEXTALIGNMENT;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag % 10 == 1) {
        if (tableView.superview.tag == 10) {
            txtFldArea_Home.selectedText = [[aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }else if (tableView.superview.tag == 20) {
            txtFldArea_Office.selectedText = [[aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }else if (tableView.superview.tag == 30) {
            txtFldArea_Other.selectedText = [[aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }
    }else if (tableView.tag % 10 == 2) {
        aryAreaList = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_Areas];
        if (tableView.superview.tag == 10) {
            txtFldCity_Home.selectedText = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }else if (tableView.superview.tag == 20) {
            txtFldCity_Office.selectedText = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }else if (tableView.superview.tag == 30) {
            txtFldCity_Other.selectedText = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }
    }else if (tableView.tag % 10 == 3) {
        aryCityList = [[aryStateList objectAtIndex:indexPath.row] objectForKey:key_Cities];
        if (tableView.superview.tag == 10) {
            txtFldState_Home.selectedText = [[aryStateList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }else if (tableView.superview.tag == 20) {
            txtFldState_Office.selectedText = [[aryStateList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }else if (tableView.superview.tag == 30) {
            txtFldState_Other.selectedText = [[aryStateList objectAtIndex:indexPath.row] objectForKey:key_Name];
        }
    }else if (tableView.tag % 10 == 4) {
        aryStateList = [[aryCountryList objectAtIndex:indexPath.row] objectForKey:key_States];
        if (tableView.superview.tag == 10) {
            txtFldCountry_Home.selectedText = [[aryCountryList objectAtIndex:indexPath.row] objectForKey:key_Name];
            if (aryCountryList.count > 1) {
                txtFldState_Home.selectedText = @"";
                txtFldCity_Home.selectedText = @"";
                txtFldArea_Home.selectedText = @"";
            }
        }else if (tableView.superview.tag == 20) {
            txtFldCountry_Office.selectedText = [[aryCountryList objectAtIndex:indexPath.row] objectForKey:key_Name];
            if (aryCountryList.count > 1) {
                txtFldState_Office.selectedText = @"";
                txtFldCity_Office.selectedText = @"";
                txtFldArea_Office.selectedText = @"";
            }
        }else if (tableView.superview.tag == 30) {
            txtFldCountry_Other.selectedText = [[aryCountryList objectAtIndex:indexPath.row] objectForKey:key_Name];
            if (aryCountryList.count > 1) {
                txtFldState_Other.selectedText = @"";
                txtFldCity_Other.selectedText = @"";
                txtFldArea_Other.selectedText = @"";
            }
        }
    }else if (tableView.tag % 10 == 0) {
        for(NSMutableDictionary *dic in aryAddressList) {
            txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:indexPath.row] objectForKey:key_AddressName];
            if ([[aryAddressList objectAtIndex:indexPath.row] objectForKey:key_AddressName] == [dic objectForKey:key_AddressName]) {
                [dic setObject:@"1" forKey:key_IsPrimary];
            }else {
                [dic setObject:@"0" forKey:key_IsPrimary];
            }
        }
        //table view touch not detected
        CGRect rect = viewAgreeTerms_ChooseAddress.frame;
        rect.size.height -= 100;
        viewAgreeTerms_ChooseAddress.frame = rect;
        
        CGSize size = scrollViewEditProfile.contentSize;
        size.height -= 50;
        scrollViewEditProfile.contentSize = size;
    }
    
    [tableView removeFromSuperview];
}


#pragma mark - Change Language Method

-(void)ChangeLanguageToArabic
{
    btnGoBack.titleLabel.text = (NSString *) Back_Arabic;
    lblScreenName.text = (NSString *)EditProfile_Arabic;

    lblScreenName.text = (NSString *)Register_Arabic;
    lblPersonalInfo.text = (NSString *)PersonalInfo_Arabic;
    lblFirstName.text = (NSString *)FirstName_Arabic;
    lblLastName.text = (NSString *)LastName_Arabic;
    lblAge.text = (NSString *)Age_Arabic;
    lblHomeCity.text = (NSString *)HomeCity_Arabic;
    lblMobileNumber.text  = (NSString *)MobileNo_Arabic;
    lblContactInfo.text = (NSString *)ContactInfo_Arabic;
//    lblFlatNoDoorNo.text = (NSString *)FlatNoDoorNo_Arabic;
//    lblApartmentName.text = (NSString *)BuildingName_Arabic;
//    lblAddressLine1.text = (NSString *)AddressLine1_Arabic;
//    lblAddressLine2.text = (NSString *)AddressLine2_Arabic;
//    lblLandmark.text = (NSString *)LandMarkReg_Arabic;
//    lblArea.text = (NSString *)Area_Arabic;
//    lblCity.text = (NSString *)City_Arabic;
//    lblState.text = (NSString *)State_Arabic;
//    lblCountry.text = (NSString *)Country_Arabic;
//    lblPinCode.text = (NSString *)PinCode_Arabic;
    
    lblPersonalInfo.textAlignment = NSTextAlignmentRight;
    lblFirstName.textAlignment = NSTextAlignmentRight;
    lblLastName.textAlignment = NSTextAlignmentRight;
    lblAge.textAlignment = NSTextAlignmentRight;
    lblHomeCity.textAlignment = NSTextAlignmentRight;
    lblMobileNumber.textAlignment = NSTextAlignmentRight;
    lblContactInfo.textAlignment = NSTextAlignmentRight;
//    lblFlatNoDoorNo.textAlignment = NSTextAlignmentRight;
//    lblApartmentName.textAlignment = NSTextAlignmentRight;
//    lblAddressLine1.textAlignment = NSTextAlignmentRight;
//    lblAddressLine2.textAlignment = NSTextAlignmentRight;
//    lblLandmark.textAlignment = NSTextAlignmentRight;
//    lblArea.textAlignment = NSTextAlignmentRight;
//    lblCity.textAlignment = NSTextAlignmentRight;
//    lblState.textAlignment = NSTextAlignmentRight;
//    lblCountry.textAlignment = NSTextAlignmentRight;
//    lblPinCode.textAlignment = NSTextAlignmentRight;
    
    
    
    txtFldFirstName.textAlignment = NSTextAlignmentRight;
    txtFldLastName.textAlignment = NSTextAlignmentRight;
    txtFldAge.textAlignment = NSTextAlignmentRight;
    txtFldHomeCity.textAlignment = NSTextAlignmentRight;
    txtFldMobileNo.textAlignment = NSTextAlignmentRight;
    
    [btnSave setTitle:Save_Arabic forState:UIControlStateNormal];
    [btnSave_Home setTitle:Save_Arabic forState:UIControlStateNormal];
    [btnSave_Office setTitle:Save_Arabic forState:UIControlStateNormal];
    [btnSave_Other setTitle:Save_Arabic forState:UIControlStateNormal];
    
    //placeholder
    txtFldAddressLine1_Home.placeholder = AddressLine1_Arabic;
    txtFldAddressLine1_Office.placeholder = AddressLine1_Arabic;
    txtFldAddressLine1_Other.placeholder =AddressLine1_Arabic;
    
    txtFldAddressLine2_Home.placeholder = AddressLine2_Arabic;
    txtFldAddressLine2_Other.placeholder = AddressLine2_Arabic;
    txtFldAddressLine2_Office.placeholder = AddressLine2_Arabic;
    
    txtFldLandMark_Home.placeholder = Landmark_Arabic;
    txtFldLandMark_Office.placeholder = Landmark_Arabic;
    txtFldLandMark_Other.placeholder = Landmark_Arabic;
    
    txtFldCountry_Home.placeHolder = Country_Arabic;
    txtFldCountry_Office.placeHolder = Country_Arabic;
    txtFldCountry_Other.placeHolder = Country_Arabic;
    
    txtFldState_Home.placeHolder = State_Arabic;
    txtFldState_Office.placeHolder = State_Arabic;
    txtFldState_Other.placeHolder = State_Arabic;
    
    txtFldCity_Home.placeHolder = City_Arabic;
    txtFldCity_Office.placeHolder = City_Arabic;
    txtFldCity_Other.placeHolder = City_Arabic;
    
    txtFldArea_Home.placeHolder =Area_Arabic;
    txtFldArea_Office.placeHolder = Area_Arabic;
    txtFldArea_Other.placeHolder = Area_Arabic;
    
    lblHome.text = Home_Arabic;
    lblOffice.text = Office_Arabic;
    lblOther.text = Other_Arabic;
    
    lblChoosePrimaryAddress.text = ChoosePrimaryAddress_Arabic;
    lblChoosePrimaryAddress.textAlignment = FOS_TEXTALIGNMENT;
    txtFldDropDownAddressType.selectedText = Address_Arabic;
    btnSave.frame = [[UIConstants returnInstance] getFrameForLanguage:btnSave.frame withSuperViewRect:btnSave.superview.frame];
    lblRequired.text = Required_Arabic;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
#pragma mark - Touch Method

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
    if (tblViewAreaList.superview != nil) {
        [tblViewAreaList removeFromSuperview];
    }
    if (tblViewCityList.superview != nil) {
        [tblViewCityList removeFromSuperview];
    }
}

- (void) showAlert
{
    [[UIConstants returnInstance] ShowMobileNumberVerifcationAlert];
}

#pragma mark - Check Mobile Number

- (void)CheckMobileNumberVerfied
{
    if ([[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_IsMobiileNoVerfied] integerValue] == 0){
        [[UIConstants returnInstance] setIsMobileNumberVerfied:NO];
        //&& ![[[UIConstants returnInstance] strUserMobileNo] isEqualToString:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo]]) {
       //[self performSelector:@selector(showAlert) withObject:nil afterDelay:0.6];
    }else{
        [[UIConstants returnInstance] setIsMobileNumberVerfied:YES];
    }
    [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_UpdateProfileResponse] objectForKey:key_StatusMessage]];
//        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SuccessfullyUpdated_English:Alert_SuccessfullyUpdated_Arabic];
}

#pragma mark - Alert view delegate methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        ObjServiceHandler = [[ServiceHandler alloc] init];
        if ([ObjServiceHandler GetVerifyVerificationCodeAPIwithUserID:[[UIConstants returnInstance] strFosUserID] IsGuestUser:@"0" VerificationCode:[alertView textFieldAtIndex:0].text]) {
            [[UIConstants returnInstance] setIsMobileNumberVerfied:YES];
            [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
        }else{
            if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
                [[UIConstants returnInstance] ShowNoNetworkAlert];
            }else{
                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
            }
        }
        [ObjServiceHandler release], ObjServiceHandler = nil;
    }else if (buttonIndex == 1) {
        [[UIConstants returnInstance] setIsMobileNumberVerfied:NO];
    }
}

#pragma mark -Set table hight

-(void)SetTableHight:(NSArray *)aryData
{
    if ([aryData count] > 3) {
        tblViewDropDownList.frame = CGRectMake(tblViewDropDownList.frame.origin.x, tblViewDropDownList.frame.origin.y, tblViewDropDownList.frame.size.width, 100);
    }else{
       tblViewDropDownList.frame =  CGRectMake(tblViewDropDownList.frame.origin.x, tblViewDropDownList.frame.origin.y, tblViewDropDownList.frame.size.width, 30*[aryData count]);
    }
    
}

-(void)SetFooterFrame
{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        int Y = [[UIScreen mainScreen] bounds].size.height - viewFooter.frame.size.height ;
        viewFooter.frame = CGRectMake(0, Y, viewFooter.frame.size.width , viewFooter.frame.size.height);
    }else{
        int Y = [[UIScreen mainScreen] bounds].size.height - viewFooter.frame.size.height - 20 ;
        viewFooter.frame = CGRectMake(0, Y, viewFooter.frame.size.width , viewFooter.frame.size.height);
    }
}

- (NSArray *) getDetailsforArea:(NSString *)area withCity:(NSString *)city withState:(NSString *)state withCountry:(NSString *)country
{
    NSArray *temparray = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",@"name",country];
    if(country){
        
        temparray = [aryCountryList filteredArrayUsingPredicate:predicate];

    }
    if(state){
        if([temparray count] > 0){
            temparray =[[temparray objectAtIndex:0] objectForKey:key_States];
        }
        predicate = [NSPredicate predicateWithFormat:@"%K == %@",@"name",state];
        temparray =[temparray filteredArrayUsingPredicate:predicate];
    }
    if(city){
        if([temparray count] > 0){
            temparray =[[temparray objectAtIndex:0] objectForKey:key_Cities];
        }
        predicate = [NSPredicate predicateWithFormat:@"%K == %@",@"name",city];
        temparray =[temparray filteredArrayUsingPredicate:predicate];
    }
    if(area){
        if([temparray count] > 0){
            temparray =[[temparray objectAtIndex:0] objectForKey:key_Areas];
        }
        predicate = [NSPredicate predicateWithFormat:@"%K == %@",@"name",area];
        temparray =[temparray filteredArrayUsingPredicate:predicate];
 
    }
    return temparray;
}


#pragma mark -
-(void)onClickComboSelection:(id)comboBox
{
    if(comboBox == txtFldCountry_Office){
        //[self OnClickDropDown4_Office:nil];
        txtFldState_Office.selectedText = @"";
        txtFldCity_Office.selectedText = @"";
        txtFldArea_Office.selectedText = @"";
        aryStateList = [[txtFldCountry_Office.arrDataCombo objectAtIndex:txtFldCountry_Office.selectedRow] objectForKey:key_States];
        txtFldState_Office.arrDataCombo = aryStateList;
    }else if(comboBox == txtFldState_Office){
        aryCityList = [[txtFldState_Office.arrDataCombo objectAtIndex:txtFldState_Office.selectedRow] objectForKey:key_Cities];
        txtFldCity_Office.arrDataCombo = aryCityList;
        txtFldCity_Office.selectedText = @"";
        txtFldArea_Office.selectedText = @"";
    }else if(comboBox == txtFldCity_Office){
        aryAreaList = [[txtFldCity_Office.arrDataCombo objectAtIndex:txtFldCity_Office.selectedRow] objectForKey:key_Areas];
        txtFldArea_Office.arrDataCombo = aryAreaList;
        
        txtFldArea_Office.selectedText = @"";
    }else if(comboBox == txtFldArea_Office){
        //   [self OnClickDropDown1_Office:nil];
    }else if(comboBox == txtFldCountry_Home){
        aryStateList = [[txtFldCountry_Home.arrDataCombo objectAtIndex:txtFldCountry_Office.selectedRow] objectForKey:key_States];
        txtFldState_Home.arrDataCombo = aryStateList;
        txtFldState_Home.selectedText = @"";
        txtFldCity_Home.selectedText = @"";
        txtFldArea_Home.selectedText = @"";
    }else if(comboBox == txtFldState_Home){
        aryCityList = [[txtFldState_Home.arrDataCombo objectAtIndex:txtFldState_Office.selectedRow] objectForKey:key_Cities];
        txtFldCity_Home.arrDataCombo = aryCityList;
        
        txtFldCity_Home.selectedText = @"";
        txtFldArea_Home.selectedText = @"";
    }else if(comboBox == txtFldCity_Home){
        aryAreaList = [[txtFldCity_Home.arrDataCombo objectAtIndex:txtFldCity_Home.selectedRow] objectForKey:key_Areas];
        txtFldArea_Home.arrDataCombo = aryAreaList;
        
        txtFldArea_Home.selectedText = @"";
    }else if(comboBox == txtFldArea_Home){
        
        // [self OnClickDropDown1_Home:nil];
    }else if(comboBox == txtFldCountry_Other){
        aryStateList = [[txtFldCountry_Other.arrDataCombo objectAtIndex:txtFldCountry_Office.selectedRow] objectForKey:key_States];
        txtFldState_Other.arrDataCombo = aryStateList;
        txtFldState_Other.selectedText = @"";
        txtFldCity_Other.selectedText = @"";
        txtFldArea_Other.selectedText = @"";
    }else if(comboBox == txtFldState_Other){
        aryCityList = [[txtFldState_Other.arrDataCombo objectAtIndex:txtFldState_Office.selectedRow] objectForKey:key_Cities];
        txtFldCity_Other.arrDataCombo = aryCityList;
        txtFldCity_Other.selectedText = @"";
        txtFldArea_Other.selectedText = @"";
    }else if(comboBox == txtFldCity_Other){
        aryAreaList = [[txtFldCity_Other.arrDataCombo objectAtIndex:txtFldCity_Other.selectedRow] objectForKey:key_Areas];
        txtFldArea_Other.arrDataCombo = aryAreaList;
        
        txtFldArea_Other.selectedText = @"";
        
    }else if(comboBox == txtFldArea_Other){
        // [self OnClickDropDown1_Other:nil];
    }else if (comboBox == txtFldDropDownAddressType){
        for(NSMutableDictionary *dic in aryAddressList) {
            NSLog(@"%@",dic);
            if ([txtFldDropDownAddressType.selectedText isEqualToString:[dic objectForKey:key_AddressName]]) {
                [dic setObject:@"1" forKey:key_IsPrimary];
            }else {
                [dic setObject:@"0" forKey:key_IsPrimary];
            }
        }
    }
}

- (NSArray *) selectionDataForCombo:(id) comboBox
{
    if(comboBox == txtFldDropDownAddressType){
        txtFldDropDownAddressType.keyName = key_AddressName;
        [self CheckForCompleteAddress];
        return aryAddressList;
    }
    return nil;
}


- (void) comboBoxShowing:(BOOL) isShowing
{
    [self textFieldShouldReturn:nil];
    [self.view endEditing:YES];
}

-(void)CheckForCompleteAddress
{
   // [aryAddressList removeAllObjects];
    [self CheckForCompleteHomeAddress];
    [self CheckForCompleteOfficeAddress];
    [self CheckForCompleteOtherAddress];
}

-(BOOL)CheckForCompleteHomeAddress
{
    if ([txtFldAddressLine1_Home.text length] != 0 && [txtFldLandMark_Home.text length] != 0 && [txtFldCountry_Home.selectedText length] != 0 && [txtFldState_Home.selectedText length] != 0 && [txtFldCity_Home.selectedText length] != 0 && [txtFldArea_Home.selectedText length] != 0 ) {
        BOOL alreadyPresent = NO;
        for (NSMutableDictionary *dic in aryAddressList) {
            if ([[dic objectForKey:key_AddressName] isEqualToString: key_AddressName_Home]) {
                alreadyPresent = YES;
                [dic setObject:txtFldAddressLine1_Home.text forKey:key_StreetLine1];
                [dic setObject:txtFldAddressLine2_Home.text forKey:key_StreetLine2];
                [dic setObject:txtFldLandMark_Home.text forKey:key_LandMark1];
                [dic setObject:txtFldCountry_Home.selectedText forKey:key_Country];
                [dic setObject:txtFldState_Home.selectedText forKey:key_State];
                [dic setObject:txtFldArea_Home.selectedText forKey:key_Area];
                [dic setObject:txtFldCity_Home.selectedText forKey:key_City];
                break;
            }
        }
        
        NSString *isPrimary;
        if ([aryAddressList count] == 0) {
            isPrimary = @"1";
        }else{
            isPrimary = @"0";
        }
        
        if(!alreadyPresent){
            [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Home.text, key_StreetLine1,txtFldAddressLine2_Home.text, key_StreetLine2,key_AddressName_Home,key_AddressName,isPrimary, key_IsPrimary, txtFldArea_Home.selectedText,key_Area,txtFldCity_Home.selectedText, key_City,txtFldState_Home.selectedText, key_State, txtFldCountry_Home.selectedText, key_Country, txtFldLandMark_Home.text, key_LandMark1, @"0", key_IsVerified, nil]];
        }
        return YES;
    }else
        return NO;
}

-(BOOL)CheckForCompleteOfficeAddress
{
    if ([txtFldAddressLine1_Office.text length] != 0 && [txtFldLandMark_Office.text length] != 0 && [txtFldCountry_Office.selectedText length] != 0 && [txtFldState_Office.selectedText length] != 0 && [txtFldCity_Office.selectedText length] != 0 && [txtFldArea_Office.selectedText length] != 0 ) {
        BOOL alreadyPresent = NO; // check office address already there
        for (NSMutableDictionary *dic in aryAddressList) {
            if ([[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Office]) {
                alreadyPresent = YES;
                [dic setObject:txtFldAddressLine1_Office.text forKey:key_StreetLine1];
                [dic setObject:txtFldAddressLine2_Office.text forKey:key_StreetLine2];
                [dic setObject:txtFldLandMark_Office.text forKey:key_LandMark1];
                [dic setObject:txtFldCountry_Office.selectedText forKey:key_Country];
                [dic setObject:txtFldState_Office.selectedText forKey:key_State];
                [dic setObject:txtFldArea_Office.selectedText forKey:key_Area];
                [dic setObject:txtFldCity_Office.selectedText forKey:key_City];
                break;
            }
        }
        
        NSString *isPrimary;
        if ([aryAddressList count] == 0) {
            isPrimary = @"1";
        }else{
            isPrimary = @"0";
        }
        
        if(!alreadyPresent){
            [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Office.text, key_StreetLine1,txtFldAddressLine2_Office.text, key_StreetLine2,key_AddressName_Office,key_AddressName,isPrimary, key_IsPrimary, txtFldArea_Office.selectedText,key_Area,txtFldCity_Office.selectedText, key_City,txtFldState_Office.selectedText, key_State, txtFldCountry_Office.selectedText, key_Country, txtFldLandMark_Office.text, key_LandMark1, @"0", key_IsVerified, nil]];
        }
        return YES;
    }else
        return NO;
}

-(BOOL)CheckForCompleteOtherAddress
{
    if([self CheckForAddressName]){
        if ([txtFldAddressLine1_Other.text length] != 0 && [txtFldLandMark_Other.text length] != 0 && [txtFldCountry_Other.selectedText length] != 0 && [txtFldState_Other.selectedText length] != 0 && [txtFldCity_Other.selectedText length] != 0 && [txtFldArea_Other.selectedText length] != 0 ) {
            BOOL alreadyPresent = NO; // check office address already there
            for (NSMutableDictionary *dic in aryAddressList) {
                if (![[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Home] && ![[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Office]) {
                    alreadyPresent = YES;
                    [dic setObject:txtFldAddressName_Other.text forKey:key_AddressName];
                    [dic setObject:txtFldAddressLine1_Other.text forKey:key_StreetLine1];
                    [dic setObject:txtFldAddressLine2_Other.text forKey:key_StreetLine2];
                    [dic setObject:txtFldLandMark_Other.text forKey:key_LandMark1];
                    [dic setObject:txtFldCountry_Other.selectedText forKey:key_Country];
                    [dic setObject:txtFldState_Other.selectedText forKey:key_State];
                    [dic setObject:txtFldArea_Other.selectedText forKey:key_Area];
                    [dic setObject:txtFldCity_Other.selectedText forKey:key_City];
                    break;
                }
            }
            
            NSString *isPrimary;
            if ([aryAddressList count] == 0) {
                isPrimary = @"1";
            }else{
                isPrimary = @"0";
            }
            
            if(!alreadyPresent){
                [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Other.text, key_StreetLine1,txtFldAddressLine2_Other.text, key_StreetLine2,txtFldAddressName_Other.text,key_AddressName,isPrimary, key_IsPrimary, txtFldArea_Other.selectedText,key_Area,txtFldCity_Other.selectedText, key_City,txtFldState_Other.selectedText, key_State, txtFldCountry_Other.selectedText, key_Country, txtFldLandMark_Other.text, key_LandMark1, @"0", key_IsVerified, nil]];
            }
            return YES;
        }else
            return NO;
    }else{
        return NO;
    }
}

-(BOOL)CheckForEmptyHomeAddress
{
    if ([txtFldAddressLine1_Home.text length] == 0 && [txtFldLandMark_Home.text length] == 0 && [txtFldCountry_Home.selectedText length] == 0 && [txtFldState_Home.selectedText length] == 0 && [txtFldCity_Home.selectedText length] == 0 && [txtFldArea_Home.selectedText length] == 0 ) {
        if ([aryAddressList count] > 0) {
            for (NSDictionary *dic in aryAddressList) {
                if ([dic objectForKey:key_AddressName] == key_AddressName_Home) {
                    [aryAddressList removeObject:dic];
                    break;
                }
            }
        }
        
        if ([aryAddressList count] == 1) {
            txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
            [[aryAddressList objectAtIndex:0] setObject:@"1" forKey:key_IsPrimary];
        }
        
        return YES;
    }else
        return NO;
}

-(BOOL)CheckForEmptyOfficeAddress
{
    if ([txtFldAddressLine1_Office.text length] == 0 && [txtFldLandMark_Office.text length] == 0 && [txtFldCountry_Office.selectedText length] == 0 && [txtFldState_Office.selectedText length] == 0 && [txtFldCity_Office.selectedText length] == 0 && [txtFldArea_Office.selectedText length] == 0 ) {
        if ([aryAddressList count] > 0) {
            for (NSDictionary *dic in aryAddressList) {
                if ([dic objectForKey:key_AddressName] == key_AddressName_Office) {
                    [aryAddressList removeObject:dic];
                    break;
                }
            }
        }
        
        if ([aryAddressList count] == 1) {
            txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
            [[aryAddressList objectAtIndex:0] setObject:@"1" forKey:key_IsPrimary];
        }
        
        return YES;
    }else
        return NO;
}

-(BOOL)CheckForEmptyOtherAddress
{
    if ([txtFldAddressName_Other.text length] == 0 && [txtFldAddressLine1_Other.text length] == 0 && [txtFldLandMark_Other.text length] == 0 && [txtFldCountry_Other.selectedText length] == 0 && [txtFldState_Other.selectedText length] == 0 && [txtFldCity_Other.selectedText length] == 0 && [txtFldArea_Other.selectedText length] == 0 ) {
        if ([aryAddressList count] > 0) {
            for (NSDictionary *dic in aryAddressList) {
                if (![[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Home] && ![[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Office]) {
                    [aryAddressList removeObject:dic];
                    break;
                }
            }
        }
        
        if ([aryAddressList count] == 1) {
            txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
            [[aryAddressList objectAtIndex:0] setObject:@"1" forKey:key_IsPrimary];
        }
        
        return YES;
    }else
        return NO;
}

#pragma mark - check address name
-(BOOL)CheckForAddressName
{
    if ([txtFldAddressName_Other.text length] == 0) {
        return NO;
    }
    if([txtFldAddressName_Other.text compare:key_AddressName_Home options:NSCaseInsensitiveSearch] == NSOrderedSame|| [txtFldAddressName_Other.text compare:key_AddressName_Office options:NSCaseInsensitiveSearch] == NSOrderedSame){
        return NO;
    }
    return YES;
}

@end
