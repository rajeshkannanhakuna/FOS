//
//  RegisterScreen.m

//
//  Created by segate on 04/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "RegisterScreen.h"
#import "ServiceHandler.h"
#import "ResponseDTO.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import <QuartzCore/QuartzCore.h>
ServiceHandler *ObjServicehandler;

@interface RegisterScreen () <ComboBoxDelegate>
{
    NSArray *aryCityList;
    NSArray *aryAreaList;
    NSArray *aryStateList;
    NSArray *aryCountryList;
    NSMutableArray *aryAddressList;
    IBOutlet UIImageView *_imgChooseDropdownArrow;
    NSString *strAddressName_Others;
}
@end

@implementation RegisterScreen
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
    
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
         [scrlViewRegister setContentSize:CGSizeMake(0, 1000)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
    tblViewDropDownList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, txtFldCountry_Other.frame.size.width, 80)];
    tblViewDropDownList.dataSource = self;
    tblViewDropDownList.delegate = self;
   // tblViewDropDownList.tag = 0;
    
    tblViewDropDownList.layer.masksToBounds = YES;
    tblViewDropDownList.layer.cornerRadius = 5;
    tblViewDropDownList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tblViewDropDownList.layer.borderWidth = 2;
    
    aryAddressList = [[NSMutableArray alloc] init];
    // Accept_Terms_Condition = YES;
    [self OnClickAgreeTermsButton:nil];
    // Do any additional setup after loading the view from its nib.
    
  
    
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
    
    rect = [constant getFrameForLanguage:_imgChooseDropdownArrow.frame withSuperViewRect:viewDropDownAddressTypeButton.frame];
    _imgChooseDropdownArrow.frame = rect;
    
    
    //arabic text alignment
    
    lblOther.textAlignment = FOS_TEXTALIGNMENT;
    lblOffice.textAlignment = FOS_TEXTALIGNMENT;
    lblHome.textAlignment = FOS_TEXTALIGNMENT;
    lblChoosePrimaryAddress.textAlignment = FOS_TEXTALIGNMENT;
    //txtFldDropDownAddressType.textAlignment = FOS_TEXTALIGNMENT;
    
    
    // home
    
    [txtFldCountry_Home loadNibName];
    txtFldCountry_Home.arrDataCombo =aryCountryList;
    txtFldCountry_Home.placeHolder = @"Select Country";
    [txtFldState_Home loadNibName];
    txtFldState_Home.placeHolder = @"Select State";
    [txtFldCity_Home loadNibName];
    txtFldCity_Home.placeHolder = @"Select City";
    [txtFldArea_Home loadNibName];
    txtFldArea_Home.placeHolder = @"Select Area";
    
    
    //office
    
    
    [txtFldCountry_Office loadNibName];
    txtFldCountry_Office.arrDataCombo = aryCountryList;
    txtFldCountry_Office.placeHolder = @"Select Country";
    [txtFldState_Office loadNibName];
    txtFldState_Office.placeHolder = @"Select State";
    [txtFldCity_Office loadNibName];
    txtFldCity_Office.placeHolder = @"Select City";
    [txtFldArea_Office loadNibName];
    txtFldArea_Office.placeHolder = @"Select Area";

    
    //other
    
    [txtFldCountry_Other loadNibName];
    txtFldCountry_Other.arrDataCombo = aryCountryList;
    txtFldCountry_Other.placeHolder = @"Select Country";
    [txtFldState_Other loadNibName];
    txtFldState_Other.placeHolder = @"Select State";
    [txtFldCity_Other loadNibName];
    txtFldCity_Other.placeHolder = @"Select City";
    [txtFldArea_Other loadNibName];
    txtFldArea_Other.placeHolder = @"Select Area";
    
    
    [txtFldDropDownAddressType loadNibName];
    txtFldDropDownAddressType.placeHolder = @"Address";
    txtFldDropDownAddressType.isDataRefreshNeeded = YES;
    
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
    
   
    if(![[UIConstants returnInstance] isItEnglish]){
        [self ChangeLanguageToArabic];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    if([[UIConstants returnInstance] isLoginViaHome]){
        btnGoBack.hidden = YES;
        btnGoHome.hidden = NO;
    }else {
        btnGoBack.hidden = NO;
        btnGoHome.hidden = YES;
    }}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set Font
-(void)SetFont
{
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    lblPersonalInfo.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblFirstName.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblLastName.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblAge.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblHomeCity.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblMobileNumber.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblLoginInfo.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblEmailID.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblPassword.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblConfirmPassword.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblShowChars.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblContactInfo.font = [[UIConstants returnInstance] returnArvoRegular:16];
    
    
    lblAgreeTermsConditions.font = [[UIConstants returnInstance] returnArvoRegular:15];
    lblChoosePrimaryAddress.font = [[UIConstants returnInstance] returnArvoRegular:15];
    
    lblHome.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblOffice.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblOther.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
    
    btnRegister.titleLabel.font  = [[UIConstants returnInstance] returnArvoBold:15];
    
    txtFldFirstName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldLastName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldAge.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldHomeCity.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldMobileNo.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldEmail.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldPassWord.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldConfirmPwd.font = [[UIConstants returnInstance] returnArvoRegular:14];
   
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
    
    btnSave_Home.titleLabel.font  = [[UIConstants returnInstance] returnArvoBold:14];
    btnSave_Office.titleLabel.font  = [[UIConstants returnInstance] returnArvoBold:14];
    btnSave_Other.titleLabel.font  = [[UIConstants returnInstance] returnArvoBold:14];
    
    lblRequired.font = [[UIConstants returnInstance] returnArvoRegular:16];
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
}

#pragma mark - Button Action Methods

-(void)OnClickGoHomeButton:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.delegate GoHome];
}
- (void) backBtnAction:(UIButton *) btn {
//    [self.delegate GoBack:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self performSelector:@selector(goBack) withObject:nil afterDelay:0];
   
}

- (void) goBack
{
    [self.delegate commonBack]; 
}

-(void)OnClickRegisterButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    int X = 150;
    if ([txtFldFirstName.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldFirstName.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewRegisterInfo addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:lblFirstName.frame.origin animated:YES];
        return;
    }else if ([txtFldFirstName.text length] < 2) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_NameMinimumChar_English:Alert_NameMinimumChar_Arabic];
        [txtFldFirstName becomeFirstResponder];
        return;
    }
    
    if ([txtFldLastName.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLastName.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewRegisterInfo addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:lblLastName.frame.origin animated:YES];
        return;
    }
//    }else if ([txtFldLastName.text length] < 2) {
//        [[UIConstants returnInstance] ShowAlert:@"First name must be atleast 2 characters"];
//        [txtFldLastName becomeFirstResponder];
//        return;
//    }
    
//    if ([txtFldAge.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldAge.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:lblAge.frame.origin animated:YES];
//        return;
//    }
    
//    if ([txtFldHomeCity.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldHomeCity.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:lblHomeCity.frame.origin animated:YES];
//        return;
//    }
    
    if ([txtFldMobileNo.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldMobileNo.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewRegisterInfo addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:lblMobileNumber.frame.origin animated:YES];
        return;
    }
    
    if ([txtFldEmail.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldEmail.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewRegisterInfo addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:lblEmailID.frame.origin animated:YES];
        return;
    }
    
    if (![self validateEmail:txtFldEmail.text]) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_EmailInvalid_English:Alert_EmailInvalid_Arabic];
        //txtFldEmail.text = @"";
        [txtFldEmail becomeFirstResponder];
        return;
    }
    
    if ([txtFldPassWord.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldPassWord.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewRegisterInfo addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:lblPassword.frame.origin animated:YES];
        return;
    }
    
    if ([txtFldConfirmPwd.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldConfirmPwd.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewRegisterInfo addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:lblConfirmPassword.frame.origin animated:YES];
        return;
    }
    
    if ([txtFldPassWord.text length] < 8) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_PasswordMinchar_English:Alert_PasswordMinchar_Arabic];
        txtFldPassWord.text = @"";
        txtFldConfirmPwd.text = @"";
        [txtFldPassWord becomeFirstResponder];
        return;
    }
    
    if (![txtFldPassWord.text isEqualToString:txtFldConfirmPwd.text]) {
        NSLog(@"%@, %@", txtFldPassWord.text, txtFldConfirmPwd.text);
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_BothPasswordSame_English:Alert_BothPasswordSame_Arabic];
        txtFldPassWord.text = @"";
        txtFldConfirmPwd.text = @"";
        [txtFldPassWord becomeFirstResponder];
        return;
    }
//    if ([txtFldFlatDoorNo.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldFlatDoorNo.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:lblFlatNoDoorNo.frame.origin animated:YES];
//        return;
//    }
    
//    if ([txtFldBuildingName.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldBuildingName.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:txtFldBuildingName.frame.origin animated:YES];
//        return;
//    }
//    if ([txtFldAddressLine1.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldAddressLine1.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:lblAddressLine1.frame.origin animated:YES];
//        return;
//    }
    
//    if ([txtFldAddressLine2.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldAddressLine2.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:txtFldAddressLine2.frame.origin animated:YES];
//        return;
//    }
    
//    if ([txtFldLandMark.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldLandMark.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:lblAddressLine2.frame.origin animated:YES];
//        return;
//    }
    
//    if ([txtFldArea.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldArea.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:CGPointMake(0, lblArea.frame.origin.y) animated:YES];
//        return;
//    }
//    
//    if ([txtFldCity.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldCity.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:CGPointMake(0, txtFldCity.frame.origin.y) animated:YES];
//        return;
//    }
    
//    if ([txtFldState.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldState.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        return;
//    }
//    if ([txtFldCountry.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldCountry.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        return;
//    }
//    if ([txtFldPinCode.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldPinCode.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewRegisterInfo addSubview:viewPopUp];
//        [scrlViewRegister setContentOffset:lblPinCode.frame.origin animated:YES];
//        return;
//    }
    
    if ([aryAddressList count] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_IncompleteAddress_English:Alert_IncompleteAddress_Arabic];
        return;
    }
    
    if (Accept_Terms_Condition) {
        ObjServicehandler = [[ServiceHandler alloc] init];
        if ([ObjServicehandler GetWebUserRegistrationAPI :txtFldFirstName.text
                                                         :txtFldLastName.text
                                                         :txtFldEmail.text
                                                         :txtFldAge.text
                                                         :txtFldPassWord.text
                                                         :txtFldMobileNo.text :@"1"
                                                         :@""
                                                         :aryAddressList :@"" :@""]) {
            if ([[[[ResponseDTO sharedInstance] DTO_UserRegistrationResponse] objectForKey:key_StatusCode] integerValue] == 200) {
                [[UIConstants returnInstance] setStrFosUserID:[[[ResponseDTO sharedInstance] DTO_UserRegistrationResponse] objectForKey:key_IdUser]];
                [[UIConstants returnInstance] setDicUserDetails:[[ResponseDTO sharedInstance]DTO_UserRegistrationResponse]];
                //alert for successfull registration
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[UIConstants returnInstance] isItEnglish]?Alert_English:Alert_Arabic
                                                                message:[[[ResponseDTO sharedInstance] DTO_UserRegistrationResponse] objectForKey:key_StatusMessage]
                                                               delegate:self
                                                      cancelButtonTitle:[[UIConstants returnInstance] isItEnglish]?OK_English:OK_Arabic
                                                      otherButtonTitles: nil];
                [alert show];
                [alert release];
    
            }else{
                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_UserRegistrationResponse] objectForKey:key_StatusMessage]];
            }
        }else{
            if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
                [[UIConstants returnInstance] ShowNoNetworkAlert];
            }else{
                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
            }
        }
    }else{
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_AcceptTermsConditions_English:Alert_AcceptTermsConditions_Arabic];
    }
    [ObjServicehandler release], ObjServicehandler = nil;
}


- (void) showAlert
{
    [[UIConstants returnInstance] ShowMobileNumberVerifcationAlert];
}
-(void)OnClickGoBackButton:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self performSelector:@selector(goBack) withObject:nil afterDelay:0];
}
//-(void)OnClickClickHereButton:(id)sender
//{
//    if (viewReference.superview == nil) {
//        viewReference.frame = CGRectMake(0, btnClickHere.frame.origin.y + btnClickHere.frame.size.height, viewReference.frame.size.width, viewReference.frame.size.height);
//        viewRegisterInfo.frame = CGRectMake(viewRegisterInfo.frame.origin.x, viewReference.frame.origin.y+viewReference.frame.size.height, viewRegisterInfo.frame.size.width, viewRegisterInfo.frame.size.height);
//        [scrlViewRegister addSubview:viewReference];
//        [scrlViewRegister setContentSize:CGSizeMake(0, 1650)];
//    }else{
//        [viewReference removeFromSuperview];
//        viewRegisterInfo.frame = CGRectMake(viewRegisterInfo.frame.origin.x, btnClickHere.frame.origin.y+btnClickHere.frame.size.height, viewRegisterInfo.frame.size.width, viewRegisterInfo.frame.size.height);
//        [scrlViewRegister setContentSize:CGSizeMake(0, 1550)];
//    }
//}

-(void)OnClickShowCharsButton:(id)sender
{
    if ([txtFldPassWord isSecureTextEntry] && [txtFldConfirmPwd isSecureTextEntry]) {
        if ([txtFldPassWord isFirstResponder]) {
            [txtFldPassWord resignFirstResponder];
            txtFldPassWord.secureTextEntry = NO;
            txtFldConfirmPwd.secureTextEntry = NO;
            [txtFldPassWord becomeFirstResponder];
        }else if([txtFldConfirmPwd isFirstResponder]){
            [txtFldConfirmPwd resignFirstResponder];
            txtFldPassWord.secureTextEntry = NO;
            txtFldConfirmPwd.secureTextEntry = NO;
            [txtFldConfirmPwd becomeFirstResponder];
        }else{
            txtFldPassWord.secureTextEntry = NO;
            txtFldConfirmPwd.secureTextEntry = NO;
        }
        imgTick.image = [UIImage imageNamed:@"tick_checked.png"];
    }else {
        if ([txtFldPassWord isFirstResponder]) {
            [txtFldPassWord resignFirstResponder];
            txtFldPassWord.secureTextEntry = YES;
            txtFldConfirmPwd.secureTextEntry = YES;
            [txtFldPassWord becomeFirstResponder];
        }else if([txtFldConfirmPwd isFirstResponder]){
            [txtFldConfirmPwd resignFirstResponder];
            txtFldPassWord.secureTextEntry = YES;
            txtFldConfirmPwd.secureTextEntry = YES;
            [txtFldConfirmPwd becomeFirstResponder];
        }else{
            txtFldPassWord.secureTextEntry = YES;
            txtFldConfirmPwd.secureTextEntry = YES;
        }
        imgTick.image = [UIImage imageNamed:@"tick_unchecked.png"];
    }
}

//-(void)OnClickSelectAreaButton:(id)sender
//{
//    if ([[UIConstants returnInstance] arySupportedArea]) {
//        aryAreaList = [[UIConstants returnInstance] arySupportedArea];
//    }
//    if ([aryAreaList count] >= 1) {
//        if (tblViewAreaList.superview == nil) {
//            [viewRegisterInfo addSubview:tblViewAreaList];
//        }else{
//            [tblViewAreaList removeFromSuperview];
//        }
//    }
//}
//
//-(void)OnClickSelectCityButton:(id)sender
//{
//    if ([[UIConstants returnInstance] arySupportedCities]) {
//        aryCityList = [[UIConstants returnInstance] arySupportedCities];
//    }
//    if ([aryCityList count] >= 1) {
//        if (tblViewCityList.superview == nil) {
//            [viewRegisterInfo addSubview:tblViewCityList];
//        }else{
//            [tblViewCityList removeFromSuperview];
//        }
//    }
//}

-(void)OnClickAgreeTermsButton:(id)sender
{
    if (Accept_Terms_Condition) {
        Accept_Terms_Condition = NO;
        imgTick_acceptTerms.image = [UIImage imageNamed:@"tick_unchecked.png"];
    }else{
        Accept_Terms_Condition = YES;
        imgTick_acceptTerms.image = [UIImage imageNamed:@"tick_checked.png"];
    }
}

-(void)OnClickHome_AddressTypeButton:(id)sender
{
    aryAreaList = nil;
    aryCityList = nil;
    aryStateList = nil;
    if (viewHomeAddress.superview == nil) {
        if (viewOfficeAddress.superview != nil) {
            if ([self CheckForCompleteOfficeAddress] ||[self CheckForEmptyOfficeAddress]) {
                [viewOfficeAddress removeFromSuperview];
                imgViewArrow_Office.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewOfficeAddress.frame.size.height)];
            }else{
                [self OnClickSave_OfficeButton:nil];
                return;
            }
        }
        
        if (viewOtherAddress.superview != nil) {
            if([self CheckForCompleteOtherAddress] || [self CheckForEmptyOtherAddress]){
                [viewOtherAddress removeFromSuperview];
                imgViewArrow_Other.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewOtherAddress.frame.size.height)];
            }else{
                [self OnClickSave_OtherButton:nil];
                return;
            }
        }
        
        viewHomeAddress.frame = CGRectMake(0, viewButton_HomeAddress.frame.origin.y + viewButton_HomeAddress.frame.size.height, viewHomeAddress.frame.size.width, viewHomeAddress.frame.size.height);
        [viewRegisterInfo addSubview:viewHomeAddress];
        
        imgViewArrow_Home.image = [UIImage imageNamed:@"upArrow.png"];
        
        viewButton_OfficeAddress.frame = CGRectMake(0, viewHomeAddress.frame.origin.y + viewHomeAddress.frame.size.height + 7, viewButton_OfficeAddress.frame.size.width, viewButton_OfficeAddress.frame.size.height);
        
        
        viewButton_OtherAddress.frame = CGRectMake(0, viewButton_OfficeAddress.frame.origin.y + viewButton_OfficeAddress.frame.size.height + 7, viewButton_OtherAddress.frame.size.width, viewButton_OtherAddress.frame.size.height);
        
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        
        [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height+viewHomeAddress.frame.size.height)];
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
        
        [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewHomeAddress.frame.size.height)];
    }
}

-(void)OnClickOffice_AddressTypeButton:(id)sender
{
    aryAreaList = nil;
    aryCityList = nil;
    aryStateList = nil;
    if (viewOfficeAddress.superview == nil) {
        if (viewHomeAddress.superview != nil) {
            if([self CheckForCompleteHomeAddress] || [self CheckForEmptyHomeAddress]){
                [viewHomeAddress removeFromSuperview];
                imgViewArrow_Home.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewHomeAddress.frame.size.height)];
            }else{
                [self OnClickSave_HomeButton:nil];
                return;
            }
        }
        
        if (viewOtherAddress.superview != nil) {
            if([self CheckForCompleteOtherAddress] || [self CheckForEmptyOtherAddress]){
                [viewOtherAddress removeFromSuperview];
                imgViewArrow_Other.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewOtherAddress.frame.size.height)];
            }else{
                [self OnClickSave_OtherButton:nil];
                return;
            }
        }
        
        viewButton_OfficeAddress.frame = CGRectMake(0, viewButton_HomeAddress.frame.origin.y + viewButton_HomeAddress.frame.size.height + 7, viewButton_OfficeAddress.frame.size.width, viewButton_OfficeAddress.frame.size.height);
        
        viewOfficeAddress.frame = CGRectMake(0, viewButton_OfficeAddress.frame.origin.y + viewButton_OfficeAddress.frame.size.height, viewOfficeAddress.frame.size.width, viewOfficeAddress.frame.size.height);
        [viewRegisterInfo addSubview:viewOfficeAddress];
        
        imgViewArrow_Office.image = [UIImage imageNamed:@"upArrow.png"];
        
        viewButton_OtherAddress.frame = CGRectMake(0, viewOfficeAddress.frame.origin.y + viewOfficeAddress.frame.size.height + 7, viewButton_OtherAddress.frame.size.width, viewButton_OtherAddress.frame.size.height);
        
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        
        [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height+viewOfficeAddress.frame.size.height)];
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
        
        [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewOfficeAddress.frame.size.height)];
    }
}

-(void)OnClickOther_AddressTypeButton:(id)sender
{
    aryAreaList = nil;
    aryCityList = nil;
    aryStateList = nil;
    if (viewOtherAddress.superview == nil) {
        if (viewHomeAddress.superview != nil) {
            if([self CheckForCompleteHomeAddress] || [self CheckForEmptyHomeAddress]){
                [viewHomeAddress removeFromSuperview];
                imgViewArrow_Home.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewHomeAddress.frame.size.height)];
            }else{
                [self OnClickSave_HomeButton:nil];
                return;
            }
        }
        
        if (viewOfficeAddress.superview != nil) {
            if([self CheckForCompleteOfficeAddress] || [self CheckForEmptyOfficeAddress]){
                [viewOfficeAddress removeFromSuperview];
                imgViewArrow_Office.image = [UIImage imageNamed:@"downArrow@2x.png"];
                [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewOfficeAddress.frame.size.height)];
            }else{
                [self OnClickSave_OfficeButton:nil];
                return;
            }
        }
        
         viewButton_OfficeAddress.frame = CGRectMake(0, viewButton_HomeAddress.frame.origin.y + viewButton_HomeAddress.frame.size.height + 7, viewButton_OfficeAddress.frame.size.width, viewButton_OfficeAddress.frame.size.height);
        
        
        viewButton_OtherAddress.frame = CGRectMake(0, viewButton_OfficeAddress.frame.origin.y + viewButton_OfficeAddress.frame.size.height + 7, viewButton_OtherAddress.frame.size.width, viewButton_OtherAddress.frame.size.height);
        
        viewOtherAddress.frame = CGRectMake(0, viewButton_OtherAddress.frame.origin.y + viewButton_OtherAddress.frame.size.height, viewOtherAddress.frame.size.width, viewOtherAddress.frame.size.height);
        [viewRegisterInfo addSubview:viewOtherAddress];
        
        imgViewArrow_Other.image = [UIImage imageNamed:@"upArrow.png"];
        
        viewAgreeTerms_ChooseAddress.frame = CGRectMake(0, viewOtherAddress.frame.origin.y + viewOtherAddress.frame.size.height + 7, viewAgreeTerms_ChooseAddress.frame.size.width, viewAgreeTerms_ChooseAddress.frame.size.height);
        [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height+viewOtherAddress.frame.size.height)];
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
        [scrlViewRegister setContentSize:CGSizeMake(0, scrlViewRegister.contentSize.height-viewOtherAddress.frame.size.height)];
    }
}

-(BOOL)OnClickSave_HomeButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    int X = 150;
    
    if ([txtFldAddressLine1_Home.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressLine1_Home.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewHomeAddress addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:viewHomeAddress.frame.origin animated:YES];
        return NO;
    }
    if ([txtFldLandMark_Home.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLandMark_Home.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewHomeAddress addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:viewHomeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldCountry_Home.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCountry_English:Alert_SelectYourCountry_Arabic];
        [scrlViewRegister setContentOffset:viewHomeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldState_Home.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourState_English:Alert_SelectYourState_Arabic];
        [scrlViewRegister setContentOffset:viewHomeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldCity_Home.selectedText length] == 0) {
       [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCity_English:Alert_SelectYourCity_Arabic];
        [scrlViewRegister setContentOffset:viewHomeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldArea_Home.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourArea_English:Alert_SelectYourArea_Arabic];
        [scrlViewRegister setContentOffset:viewHomeAddress.frame.origin animated:YES];
        return NO;
    }
    
//    [self OnClickHome_AddressTypeButton:nil];
    
//    if ([aryAddressList count] > 0) {
//        for (NSDictionary *dic in aryAddressList) {
//            if ([dic objectForKey:key_AddressName] == key_AddressName_Home) {
//                [aryAddressList removeObject:dic];
//                break;
//            }
//        }
//    }
//    
//    [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Home.text, key_StreetLine1,txtFldAddressLine2_Home.text, key_StreetLine2,key_AddressName_Home,key_AddressName,@"0", key_IsPrimary, txtFldArea_Home.selectedText,key_Area,txtFldCity_Home.selectedText, key_City,txtFldState_Home.selectedText, key_State, txtFldCountry_Home.selectedText, key_Country, txtFldLandMark_Home.text, key_LandMark1, @"0", key_IsVerified, nil]];
    
//    if ([aryAddressList count] == 1) {
//        txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
//    }
    return YES;
}

-(BOOL)OnClickSave_OfficeButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    int X = 150;
    
    if ([txtFldAddressLine1_Office.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressLine1_Office.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOfficeAddress addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:viewOfficeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldLandMark_Office.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLandMark_Office.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOfficeAddress addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:viewOfficeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldCountry_Office.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCountry_English:Alert_SelectYourCountry_Arabic];
        [scrlViewRegister setContentOffset:viewOfficeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldState_Office.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourState_English:Alert_SelectYourState_Arabic];
        [scrlViewRegister setContentOffset:viewOfficeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldCity_Office.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCity_English:Alert_SelectYourCity_Arabic];
        [scrlViewRegister setContentOffset:viewOfficeAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldArea_Office.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourArea_English:Alert_SelectYourArea_Arabic];
        [scrlViewRegister setContentOffset:viewOfficeAddress.frame.origin animated:YES];
        return NO;
    }
    
    //[self OnClickOffice_AddressTypeButton:nil];
    
//    if ([aryAddressList count] > 0) {
//        for (NSDictionary *dic in aryAddressList) {
//            if ([dic objectForKey:key_AddressName] == key_AddressName_Office) {
//                [aryAddressList removeObject:dic];
//                break;
//            }
//        }
//    }
//    
//    [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Office.text, key_StreetLine1,txtFldAddressLine2_Office.text, key_StreetLine2,key_AddressName_Office,key_AddressName,@"0", key_IsPrimary, txtFldArea_Office.selectedText,key_Area,txtFldCity_Office.selectedText, key_City,txtFldState_Office.selectedText, key_State, txtFldCountry_Office.selectedText, key_Country, txtFldLandMark_Office.text, key_LandMark1, @"0", key_IsVerified, nil]];
//    
//    if ([aryAddressList count] == 1) {
//        txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
//    }
    return YES;
}
-(BOOL)OnClickSave_OtherButton:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    int X = 150;
    
    if ([txtFldAddressName_Other.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressName_Other.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOtherAddress addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return NO;
    }else{
        if(![self CheckForAddressName]){
            txtFldAddressName_Other.text = @"";
            [txtFldAddressName_Other becomeFirstResponder];
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_AddressNameNotMatch_English:Alert_AddressNameNotMatch_Arabic];
            return NO;
        }
    }

    
    if ([txtFldAddressLine1_Other.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressLine1_Other.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOtherAddress addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldLandMark_Other.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLandMark_Other.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewOtherAddress addSubview:viewPopUp];
        [scrlViewRegister setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldCountry_Other.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCountry_English:Alert_SelectYourCountry_Arabic];
        [scrlViewRegister setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldState_Other.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourState_English:Alert_SelectYourState_Arabic];
        [scrlViewRegister setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldCity_Other.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCity_English:Alert_SelectYourCity_Arabic];
        [scrlViewRegister setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return NO;
    }
    
    if ([txtFldArea_Other.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourArea_English:Alert_SelectYourArea_Arabic];
        [scrlViewRegister setContentOffset:viewOtherAddress.frame.origin animated:YES];
        return NO;
    }
    
    //[self OnClickOther_AddressTypeButton:nil];
    
//    if ([aryAddressList count] > 0) {
//        for (NSDictionary *dic in aryAddressList) {
//            if ([dic objectForKey:key_AddressName] == key_AddressName_Others) {
//                [aryAddressList removeObject:dic];
//                break;
//            }
//        }
//    }
//    
//    [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Other.text, key_StreetLine1,txtFldAddressLine2_Other.text, key_StreetLine2,key_AddressName_Others,key_AddressName,@"0", key_IsPrimary, txtFldArea_Other.selectedText,key_Area,txtFldCity_Other.selectedText, key_City,txtFldState_Other.selectedText, key_State, txtFldCountry_Other.selectedText, key_Country, txtFldLandMark_Other.text, key_LandMark1, @"0", key_IsVerified, nil]];
//    
//    if ([aryAddressList count] == 1) {
//        txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
//    }
    return YES;
}

-(void)OnClickDropDown1_Home:(id)sender
{
    [self SetFooterFrame];
    [self.view endEditing:YES];
    if ([aryAreaList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Home.frame.origin.y+txtFldArea_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 11;
            [viewHomeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 11) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Home.frame.origin.y+txtFldArea_Home.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    if ([aryCityList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Home.frame.origin.y+txtFldCity_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 12;
            [viewHomeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 12) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Home.frame.origin.y+txtFldCity_Home.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    [self.view endEditing:YES];
    if ([txtFldCountry_Home.selectedText length] > 0) {
        if ([aryStateList count] > 0) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldState_Home.frame.origin.y+txtFldState_Home.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 13;
            [viewHomeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 13) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldState_Home.frame.origin.y+txtFldState_Home.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
                tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Home.frame.origin.y+txtFldCountry_Home.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    [self.view endEditing:YES];
    if ([aryAreaList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Office.frame.origin.y+txtFldArea_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 21;
            [viewOfficeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 21) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Office.frame.origin.y+txtFldArea_Office.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    [self.view endEditing:YES];
    if ([aryCityList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Office.frame.origin.y+txtFldCity_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 22;
            [viewOfficeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 22) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Office.frame.origin.y+txtFldCity_Office.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    [self.view endEditing:YES];
    if ([txtFldCountry_Office.selectedText length] > 0) {
        if ([aryStateList count] > 0) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldState_Office.frame.origin.y+txtFldState_Office.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 23;
            [viewOfficeAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 23) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldState_Office.frame.origin.y+txtFldState_Office.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
                tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Office.frame.origin.y+txtFldCountry_Office.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    [self.view endEditing:YES];
    if ([aryAreaList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Other.frame.origin.y+txtFldArea_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 31;
            [viewOtherAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 31) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldArea_Other.frame.origin.y+txtFldArea_Other.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    [self.view endEditing:YES];
    if ([aryCityList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Other.frame.origin.y+txtFldCity_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 32;
            [viewOtherAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 32) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldCity_Other.frame.origin.y+txtFldCity_Other.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    [self.view endEditing:YES];
    if ([txtFldCountry_Other.selectedText length] > 0) {
        if ([aryStateList count] > 0) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldState_Other.frame.origin.y+txtFldState_Other.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 33;
            [viewOtherAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 33) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldState_Other.frame.origin.y+txtFldState_Other.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
                tblViewDropDownList.frame =CGRectMake(5, txtFldCountry_Other.frame.origin.y+txtFldCountry_Other.frame.size.height+10,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
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
    [self.view endEditing:YES];
    if ([aryAddressList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(5, txtFldDropDownAddressType.frame.origin.y+txtFldDropDownAddressType.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 10;
            [viewAgreeTerms_ChooseAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
            
            // table view touch not detected
            CGRect rect = viewAgreeTerms_ChooseAddress.frame;
            rect.size.height += 100;
            viewAgreeTerms_ChooseAddress.frame = rect;
            
            CGSize size = scrlViewRegister.contentSize;
            size.height += 50;
            scrlViewRegister.contentSize = size;

            
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 10) {
                tblViewDropDownList.frame =CGRectMake(5, txtFldDropDownAddressType.frame.origin.y+txtFldDropDownAddressType.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 10;
                [viewAgreeTerms_ChooseAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
            
            //table view touch not detected
            CGRect rect = viewAgreeTerms_ChooseAddress.frame;
            rect.size.height -= 100;
            viewAgreeTerms_ChooseAddress.frame = rect;
            
            CGSize size = scrlViewRegister.contentSize;
            size.height -= 50;
            scrlViewRegister.contentSize = size;
        }
    }
}

#pragma mark - User defined method

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

-(void)KeyBoardShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    
    CGRect rect = viewFooterBG.frame;
    rect.origin.y -=  216;
    viewFooterBG.frame = rect;

    
    //scrollview frame change
    rect = scrlViewRegister.frame;
    rect.size.height -= 216; // 216 is keyboard height
    scrlViewRegister.frame = rect;
    
}

-(void)KeyBoardWillHide:(NSNotification *)notification
{
      CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
   CGRect rect = viewFooterBG.frame;
//    rect.origin.y += 216 ;
//    viewFooterBG.frame = rect;
    [self SetFooterFrame];
    
    //scrollview frame change
   rect = scrlViewRegister.frame;
    rect.size.height +=  216;
    scrlViewRegister.frame = rect;
}

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

#pragma mark - change language to Arabic

-(void)ChangeLanguageToArabic
{
    [btnGoBack setTitle:(NSString *)Back_Arabic forState:UIControlStateNormal];
    lblScreenName.text = (NSString *)Register_Arabic;
    lblPersonalInfo.text = (NSString *)PersonalInfo_Arabic;
    lblFirstName.text = (NSString *)FirstName_Arabic;
    lblLastName.text = (NSString *)LastName_Arabic;
    lblAge.text = (NSString *)Age_Arabic;
    lblHomeCity.text = (NSString *)HomeCity_Arabic;
    lblMobileNumber.text  = (NSString *)MobileNo_Arabic;
    lblLoginInfo.text = (NSString *)LoginInfo_Arabic;
    lblEmailID.text = EmailId_Arabic;
    lblPassword.text = (NSString *)Password_Arabic;
    lblConfirmPassword.text = (NSString *)ConfirmPassword_Arabic;
    lblShowChars.text = (NSString *)ShowChars_Arabic;
    lblContactInfo.text = (NSString *)ContactInfo_Arabic;
   
    lblAgreeTermsConditions.text = (NSString *)AgreeTerms_Arabic;
    lblRequired.text = (NSString *)Required_Arabic;
    
    lblPersonalInfo.textAlignment = NSTextAlignmentRight;
    lblFirstName.textAlignment = NSTextAlignmentRight;
    lblLastName.textAlignment = NSTextAlignmentRight;
    lblAge.textAlignment = NSTextAlignmentRight;
    lblHomeCity.textAlignment = NSTextAlignmentRight;
    lblMobileNumber.textAlignment = NSTextAlignmentRight;
    lblLoginInfo.textAlignment = NSTextAlignmentRight;
    lblEmailID.textAlignment = NSTextAlignmentRight;
    lblPassword.textAlignment = NSTextAlignmentRight;
    lblConfirmPassword.textAlignment = NSTextAlignmentRight;
    lblShowChars.textAlignment = NSTextAlignmentRight;
    lblContactInfo.textAlignment = NSTextAlignmentRight;
    lblAgreeTermsConditions.textAlignment = NSTextAlignmentRight;
    lblRequired.textAlignment = NSTextAlignmentRight;
    
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    
    btnShowChars.frame = CGRectMake(viewRegisterInfo.frame.size.width - btnShowChars.frame.origin.x - btnShowChars.frame.size.width, btnShowChars.frame.origin.y, btnShowChars.frame.size.width, btnShowChars.frame.size.height);
    lblShowChars.frame = CGRectMake(viewRegisterInfo.frame.size.width - lblShowChars.frame.origin.x - lblShowChars.frame.size.width, lblShowChars.frame.origin.y, lblShowChars.frame.size.width, lblShowChars.frame.size.height);
    imgTick.frame = CGRectMake(viewRegisterInfo.frame.size.width - imgTick.frame.origin.x - imgTick.frame.size.width, imgTick.frame.origin.y, imgTick.frame.size.width, imgTick.frame.size.height);
    
//    viewDropDown1.frame = CGRectMake(imgViewDropDownBG.frame.origin.x, viewDropDown1.frame.origin.y, viewDropDown1.frame.size.width, viewDropDown1.frame.size.height);
//    txtFldArea.frame = CGRectMake(viewDropDown1.frame.origin.x+viewDropDown1.frame.size.width, txtFldArea.frame.origin.y, txtFldArea.frame.size.width, txtFldArea.frame.size.height);
//    
//    viewDropDown2.frame = CGRectMake(imgViewDropDownBG.frame.origin.x, viewDropDown2.frame.origin.y, viewDropDown2.frame.size.width, viewDropDown2.frame.size.height);
//    txtFldCity.frame = CGRectMake(viewDropDown2.frame.origin.x+viewDropDown2.frame.size.width, txtFldCity.frame.origin.y, txtFldCity.frame.size.width, txtFldCity.frame.size.height);

    btnAgreeTerms.frame = CGRectMake(viewRegisterInfo.frame.size.width - btnAgreeTerms.frame.origin.x - btnAgreeTerms.frame.size.width, btnAgreeTerms.frame.origin.y, btnAgreeTerms.frame.size.width, btnAgreeTerms.frame.size.height);
    lblAgreeTermsConditions.frame = CGRectMake(viewRegisterInfo.frame.size.width - lblAgreeTermsConditions.frame.origin.x - lblAgreeTermsConditions.frame.size.width, lblAgreeTermsConditions.frame.origin.y, lblAgreeTermsConditions.frame.size.width, lblAgreeTermsConditions.frame.size.height);
    imgTick_acceptTerms.frame = CGRectMake(viewRegisterInfo.frame.size.width - imgTick_acceptTerms.frame.origin.x - imgTick_acceptTerms.frame.size.width, imgTick_acceptTerms.frame.origin.y, imgTick_acceptTerms.frame.size.width, imgTick_acceptTerms.frame.size.height);
    
    txtFldFirstName.textAlignment = NSTextAlignmentRight;
    txtFldLastName.textAlignment = NSTextAlignmentRight;
    txtFldAge.textAlignment = NSTextAlignmentRight;
    txtFldHomeCity.textAlignment = NSTextAlignmentRight;
    txtFldMobileNo.textAlignment = NSTextAlignmentRight;
    txtFldEmail.textAlignment = NSTextAlignmentRight;
    txtFldPassWord.textAlignment = NSTextAlignmentRight;
    txtFldConfirmPwd.textAlignment = NSTextAlignmentRight;
    
    
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
    txtFldDropDownAddressType.selectedText = Address_Arabic;
    
    [btnSave_Home setTitle:Save_Arabic forState:UIControlStateNormal];
    [btnSave_Office setTitle:Save_Arabic forState:UIControlStateNormal];
    [btnSave_Other setTitle:Save_Arabic forState:UIControlStateNormal];
    
    btnRegister.frame = [[UIConstants returnInstance] getFrameForLanguage:btnRegister.frame withSuperViewRect:btnRegister.superview.frame];
    
}

-(void)ChangeLanguageToEnglish
{
    [btnGoBack setTitle:(NSString *)Back_Eng forState:UIControlStateNormal];
    lblScreenName.text = (NSString *)Register_Eng;
    lblPersonalInfo.text = (NSString *)PersonalInfo_Eng;
    lblFirstName.text = (NSString *)FirstName_Eng;
    lblLastName.text = (NSString *)LastName_Eng;
    lblAge.text = (NSString *)Age_Eng;
    lblHomeCity.text = (NSString *)HomeCity_Eng;
    lblMobileNumber.text  = (NSString *)MobileNo_Eng;
    lblLoginInfo.text = (NSString *)LoginInfo_Eng;
    lblEmailID.text = (NSString *)Email_Eng;
    lblPassword.text = (NSString *)Password_Eng;
    lblConfirmPassword.text = (NSString *)ConfirmPassword_Eng;
    lblShowChars.text = (NSString *)ShowChars_Eng;
    lblContactInfo.text = (NSString *)ContactInfo_Eng;
    
    lblAgreeTermsConditions.text = (NSString *)AgreeTerms_Eng;
    lblRequired.text = (NSString *)Required_Eng;
    
    lblPersonalInfo.textAlignment = NSTextAlignmentLeft;
    lblFirstName.textAlignment = NSTextAlignmentLeft;
    lblLastName.textAlignment = NSTextAlignmentLeft;
    lblAge.textAlignment = NSTextAlignmentLeft;
    lblHomeCity.textAlignment = NSTextAlignmentLeft;
    lblMobileNumber.textAlignment = NSTextAlignmentLeft;
    lblLoginInfo.textAlignment = NSTextAlignmentLeft;
    lblEmailID.textAlignment = NSTextAlignmentLeft;
    lblPassword.textAlignment = NSTextAlignmentLeft;
    lblConfirmPassword.textAlignment = NSTextAlignmentLeft;
    lblShowChars.textAlignment = NSTextAlignmentLeft;
    lblContactInfo.textAlignment = NSTextAlignmentLeft;
    
    lblAgreeTermsConditions.textAlignment = NSTextAlignmentLeft;
    lblRequired.textAlignment = NSTextAlignmentLeft;
    
    [btnRegister setTitle:(NSString *)Register_Eng forState:UIControlStateNormal];
    
     imgTick.frame = CGRectMake(btnShowChars.frame.origin.x, imgTick.frame.origin.y, imgTick.frame.size.width, imgTick.frame.size.height);
    lblShowChars.frame = CGRectMake(imgTick.frame.origin.x + imgTick.frame.size.width, lblShowChars.frame.origin.y, lblShowChars.frame.size.width, lblShowChars.frame.size.height);
    
//    txtFldArea.frame = CGRectMake(imgViewDropDownBG.frame.origin.x + 10, txtFldArea.frame.origin.y, txtFldArea.frame.size.width, txtFldArea.frame.size.height);
//    viewDropDown1.frame = CGRectMake( txtFldArea.frame.origin.x + txtFldArea.frame.size.width, viewDropDown1.frame.origin.y, viewDropDown1.frame.size.width, viewDropDown1.frame.size.height);
    
//    txtFldCity.frame = CGRectMake(imgViewDropDownBG.frame.origin.x + 10, txtFldCity.frame.origin.y, txtFldCity.frame.size.width, txtFldCity.frame.size.height);
//    viewDropDown2.frame = CGRectMake( txtFldCity.frame.origin.x + txtFldCity.frame.size.width, viewDropDown2.frame.origin.y, viewDropDown2.frame.size.width, viewDropDown2.frame.size.height);
    
    imgTick_acceptTerms.frame = CGRectMake(btnAgreeTerms.frame.origin.x, imgTick_acceptTerms.frame.origin.y, imgTick_acceptTerms.frame.size.width, imgTick_acceptTerms.frame.size.height);
    lblAgreeTermsConditions.frame = CGRectMake(imgTick_acceptTerms.frame.origin.x + imgTick_acceptTerms.frame.size.width, lblAgreeTermsConditions.frame.origin.y, lblAgreeTermsConditions.frame.size.width, lblAgreeTermsConditions.frame.size.height);
    
    txtFldFirstName.textAlignment = NSTextAlignmentLeft;
    txtFldLastName.textAlignment = NSTextAlignmentLeft;
    txtFldAge.textAlignment = NSTextAlignmentLeft;
    txtFldHomeCity.textAlignment = NSTextAlignmentLeft;
    txtFldMobileNo.textAlignment = NSTextAlignmentLeft;
    txtFldEmail.textAlignment = NSTextAlignmentLeft;
    txtFldPassWord.textAlignment = NSTextAlignmentLeft;
    txtFldConfirmPwd.textAlignment = NSTextAlignmentLeft;

}

#pragma mark - textfield delegate methods



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrlViewRegister setContentOffset:CGPointMake(0, textField.frame.origin.y+textField.superview.frame.origin.y - 20) animated:YES];
}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if(textField.tag > 0)
//        [scrlViewRegister setContentOffset:CGPointMake(0, textField.frame.origin.y+textField.superview.frame.origin.y - 20) animated:YES];
//    return  YES;
//}
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
    }else if (textField == txtFldHomeCity){
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }else{
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM "] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }
    }else if (textField == txtFldMobileNo) {
        if ([textField.text length]+[string length] < 11){
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }else return NO;
        
    }else if (textField == txtFldEmail) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }else{
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM_@.%+-1234567890"] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }
    }else if (textField == txtFldPassWord) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldConfirmPwd) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
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
        CGRect rect =viewFooterBG.frame;
        if(rect.origin.y < 400){
            rect.origin.y += 216; // keyboard
            viewFooterBG.frame = rect;
        }

        
        [textField resignFirstResponder];
       // [scrlViewRegister setContentOffset:CGPointZero animated:YES];
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
//    if (tableView.tag == 1) {
//        txtFldCity.text = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_CityName];
////        txtFldCountry.text = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_CountryName];
////        txtFldState.text    = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_StateName];
//        //[tblViewCityList removeFromSuperview];
//    }else if (tableView.tag == 2) {
//        txtFldArea.text = [[aryAreaList objectAtIndex:indexPath.row] objectForKey:key_AreaName];
//        [tableView removeFromSuperview];
//    }
    
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
        
        CGSize size = scrlViewRegister.contentSize;
        size.height -= 50;
        scrlViewRegister.contentSize = size;
    }
    
    [tableView removeFromSuperview];
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
}


#pragma mark - Touch Method

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
}

//#pragma mark - Check Mobile Number
//
//- (void)CheckMobileNumberVerfied
//{
//    if ([[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_IsMobiileNoVerfied] integerValue] == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verify Mobile Number" message:@"Verification Code" delegate:self   cancelButtonTitle:@"Verify" otherButtonTitles:@"Skip", nil];
//        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//        [alert show];
//        [alert release];
//        
//    }else{
//        [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_UserRegistrationResponse] objectForKey:key_StatusMessage]];
//    }
//}

#pragma mark - Alert view delegate methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self performSelector:@selector(showAlert) withObject:nil afterDelay:0.6];
        [self.delegate GoHome];
    }
//        ObjServicehandler = [[ServiceHandler alloc] init];
//        if ([ObjServicehandler GetVerifyVerificationCodeAPIwithUserID:[[UIConstants returnInstance] strFosUserID] IsGuestUser:@"0" VerificationCode:[alertView textFieldAtIndex:0].text]) {
//            if([[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Status] integerValue] == 0)
//            [[UIConstants returnInstance] setIsMobileNumberVerfied:YES];
//            [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
//        }else{
//            if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
//                [[UIConstants returnInstance] ShowNoNetworkAlert];
//            }else{
//                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
//            }
//        }
//        [ObjServicehandler release], ObjServicehandler = nil;
//    }else if (buttonIndex == 1) {
//        [[UIConstants returnInstance] setIsMobileNumberVerfied:NO];
//    }
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
        int Y = [[UIScreen mainScreen] bounds].size.height - viewFooterBG.frame.size.height;
        viewFooterBG.frame = CGRectMake(0, Y, viewFooterBG.frame.size.width , viewFooterBG.frame.size.height);
    }else{
        int Y = [[UIScreen mainScreen] bounds].size.height - viewFooterBG.frame.size.height - 20 ;
        viewFooterBG.frame = CGRectMake(0, Y, viewFooterBG.frame.size.width , viewFooterBG.frame.size.height);
    }
}

- (void)dealloc {
    [_imgChooseDropdownArrow release];
    [super dealloc];
}
- (void)viewDidUnload {
    [_imgChooseDropdownArrow release];
    _imgChooseDropdownArrow = nil;
    [super viewDidUnload];
}


#pragma mark -
-(void)onClickComboSelection:(id)comboBox
{
    if(comboBox == txtFldCountry_Office){
    //[self OnClickDropDown4_Office:nil];
        txtFldState_Office.selectedText = @"";
        txtFldCity_Office.selectedText = @"";
        txtFldArea_Office.selectedText = @"";
        aryStateList = [[aryCountryList objectAtIndex:txtFldCountry_Office.selectedRow] objectForKey:key_States];
        txtFldState_Office.arrDataCombo = aryStateList;
    }else if(comboBox == txtFldState_Office){
        aryCityList = [[aryStateList objectAtIndex:txtFldState_Office.selectedRow] objectForKey:key_Cities];
        txtFldCity_Office.arrDataCombo = aryCityList;
        txtFldCity_Office.selectedText = @"";
        txtFldArea_Office.selectedText = @"";
    }else if(comboBox == txtFldCity_Office){
        aryAreaList = [[aryCityList objectAtIndex:txtFldCity_Office.selectedRow] objectForKey:key_Areas];
        txtFldArea_Office.arrDataCombo = aryAreaList;
        txtFldArea_Office.selectedText = @"";
    }else if(comboBox == txtFldArea_Office){
     //   [self OnClickDropDown1_Office:nil];
    }else if(comboBox == txtFldCountry_Home){
        aryStateList = [[aryCountryList objectAtIndex:txtFldCountry_Office.selectedRow] objectForKey:key_States];
        txtFldState_Home.arrDataCombo = aryStateList;
        txtFldState_Home.selectedText = @"";
        txtFldCity_Home.selectedText = @"";
        txtFldArea_Home.selectedText = @"";
    }else if(comboBox == txtFldState_Home){
        aryCityList = [[aryStateList objectAtIndex:txtFldState_Office.selectedRow] objectForKey:key_Cities];
        txtFldCity_Home.arrDataCombo = aryCityList;
        txtFldCity_Home.selectedText = @"";
        txtFldArea_Home.selectedText = @"";
    }else if(comboBox == txtFldCity_Home){
        aryAreaList = [[aryCityList objectAtIndex:txtFldCity_Home.selectedRow] objectForKey:key_Areas];
        txtFldArea_Home.arrDataCombo = aryAreaList;
        txtFldArea_Home.selectedText = @"";
    }else if(comboBox == txtFldArea_Home){
       // [self OnClickDropDown1_Home:nil];
    }else if(comboBox == txtFldCountry_Other){
        aryStateList = [[aryCountryList objectAtIndex:txtFldCountry_Office.selectedRow] objectForKey:key_States];
        txtFldState_Other.arrDataCombo = aryStateList;
        txtFldState_Other.selectedText = @"";
        txtFldCity_Other.selectedText = @"";
        txtFldArea_Other.selectedText = @"";
    }else if(comboBox == txtFldState_Other){
        aryCityList = [[aryStateList objectAtIndex:txtFldState_Office.selectedRow] objectForKey:key_Cities];
        txtFldCity_Other.arrDataCombo = aryCityList;
                txtFldCity_Other.selectedText = @"";
        txtFldArea_Other.selectedText = @"";
    }else if(comboBox == txtFldCity_Other){
        aryAreaList = [[aryCityList objectAtIndex:txtFldCity_Other.selectedRow] objectForKey:key_Areas];
        txtFldArea_Other.arrDataCombo = aryAreaList;
        
        txtFldArea_Other.selectedText = @"";

    }else if(comboBox == txtFldArea_Other){
       // [self OnClickDropDown1_Other:nil];
    }else if (comboBox == txtFldDropDownAddressType){
        for(NSMutableDictionary *dic in aryAddressList) {
            if (txtFldDropDownAddressType.selectedText == [dic objectForKey:key_AddressName]) {
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
    [aryAddressList removeAllObjects];
    [self CheckForCompleteHomeAddress];
    [self CheckForCompleteOfficeAddress];
    [self CheckForCompleteOtherAddress];
}

-(BOOL)CheckForCompleteHomeAddress
{
    if ([txtFldAddressLine1_Home.text length] != 0 && [txtFldLandMark_Home.text length] != 0 && [txtFldCountry_Home.selectedText length] != 0 && [txtFldState_Home.selectedText length] != 0 && [txtFldCity_Home.selectedText length] != 0 && [txtFldArea_Home.selectedText length] != 0 ) {
        if ([aryAddressList count] > 0) {
            for (NSDictionary *dic in aryAddressList) {
                if ([dic objectForKey:key_AddressName] == key_AddressName_Home) {
                    [aryAddressList removeObject:dic];
                    break;
                }
            }
        }
        NSString *isPrimary;
        if ([aryAddressList count] == 0) {
            isPrimary = @"1";
        }else{
            isPrimary = @"0";
        }
        
        [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Home.text, key_StreetLine1,txtFldAddressLine2_Home.text, key_StreetLine2,key_AddressName_Home,key_AddressName,isPrimary, key_IsPrimary, txtFldArea_Home.selectedText,key_Area,txtFldCity_Home.selectedText, key_City,txtFldState_Home.selectedText, key_State, txtFldCountry_Home.selectedText, key_Country, txtFldLandMark_Home.text, key_LandMark1, @"0", key_IsVerified, nil]];
        if ([aryAddressList count] == 1) {
            txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
        }
        return YES;
    }else
        return NO;
}

-(BOOL)CheckForCompleteOfficeAddress
{
    if ([txtFldAddressLine1_Office.text length] != 0 && [txtFldLandMark_Office.text length] != 0 && [txtFldCountry_Office.selectedText length] != 0 && [txtFldState_Office.selectedText length] != 0 && [txtFldCity_Office.selectedText length] != 0 && [txtFldArea_Office.selectedText length] != 0 ) {
        if ([aryAddressList count] > 0) {
            for (NSDictionary *dic in aryAddressList) {
                if ([dic objectForKey:key_AddressName] == key_AddressName_Office) {
                    [aryAddressList removeObject:dic];
                    break;
                }
            }
        }
        
        NSString *isPrimary;
        if ([aryAddressList count] == 0) {
            isPrimary = @"1";
        }else{
            isPrimary = @"0";
        }
        
        [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Office.text, key_StreetLine1,txtFldAddressLine2_Office.text, key_StreetLine2,key_AddressName_Office,key_AddressName,isPrimary, key_IsPrimary, txtFldArea_Office.selectedText,key_Area,txtFldCity_Office.selectedText, key_City,txtFldState_Office.selectedText, key_State, txtFldCountry_Office.selectedText, key_Country, txtFldLandMark_Office.text, key_LandMark1, @"0", key_IsVerified, nil]];
        if ([aryAddressList count] == 1) {
            txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
        }
        return YES;
    }else
        return NO;
}

-(BOOL)CheckForCompleteOtherAddress
{
    if ([self CheckForAddressName]) {
        if ([txtFldAddressLine1_Other.text length] != 0 && [txtFldLandMark_Other.text length] != 0 && [txtFldCountry_Other.selectedText length] != 0 && [txtFldState_Other.selectedText length] != 0 && [txtFldCity_Other.selectedText length] != 0 && [txtFldArea_Other.selectedText length] != 0 ) {
            if ([aryAddressList count] > 0) {
                for (NSDictionary *dic in aryAddressList) {
                    if (![[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Home] && ![[dic objectForKey:key_AddressName] isEqualToString:key_AddressName_Office]) {
                        [aryAddressList removeObject:dic];
                        break;
                    }
                }
            }
            
            NSString *isPrimary;
            if ([aryAddressList count] == 0) {
                isPrimary = @"1";
            }else{
                isPrimary = @"0";
            }
            
            [aryAddressList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:txtFldAddressLine1_Other.text, key_StreetLine1,txtFldAddressLine2_Other.text, key_StreetLine2,txtFldAddressName_Other.text,key_AddressName,isPrimary, key_IsPrimary, txtFldArea_Other.selectedText,key_Area,txtFldCity_Other.selectedText, key_City,txtFldState_Other.selectedText, key_State, txtFldCountry_Other.selectedText, key_Country, txtFldLandMark_Other.text, key_LandMark1, @"0", key_IsVerified, nil]];
            strAddressName_Others = txtFldAddressName_Other.text;
            if ([aryAddressList count] == 1) {
                txtFldDropDownAddressType.selectedText = [[aryAddressList objectAtIndex:0] objectForKey:key_AddressName];
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
@end
