//
//  HomeDelivery&TakeAway.m
//  
//
//  Created by segate on 19/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "HomeDelivery&TakeAway.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import <QuartzCore/QuartzCore.h>
#import "ServiceHandler.h"

#define isempty(_x_)   _x_ != [NSNull null] && _x_ != Nil && ![_x_ isEqualToString:@""]

@interface HomeDelivery_TakeAway ()<ComboBoxDelegate,UIActionSheetDelegate>
{
    NSArray *aryAreaList;
    NSArray *aryCityList;
    NSArray *aryStateList;
    NSArray *aryCountryList;
    NSArray *aryAddressList;
    NSArray *aryDeliverySupportedArea;
    NSDictionary *dicAddress;
    ServiceHandler *ObjServiceHandler;
    NSString *strPaymentMode;
    NSString *strIsPrimary;
    NSString *strName;
    NSString *strEmail;
    NSString *strMobileNo;
    NSString *strAddressline1;
    NSString *strAddressLine2;
    NSString *strLandmark;
    NSString *strArea;
    NSString *strCity;
    NSString *strState;
    NSString *strCountry;
    NSString *strUserId;
     IBOutlet UIButton *loginBtn;
    
}
@end

@implementation HomeDelivery_TakeAway
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
    if(![[UIConstants returnInstance] isItEnglish]){
        [self ChangeLanguageToArabic];
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
    }
    aryCountryList = [[[UIConstants returnInstance] dicSupportedRegion] objectForKey:key_Countries];
    
    tblViewDropDownList = [[UITableView alloc]initWithFrame:CGRectMake(5, 0, 300, 80)];
    tblViewDropDownList.dataSource = self;
    tblViewDropDownList.delegate = self;
    
    tblViewDropDownList.layer.masksToBounds = YES;
    tblViewDropDownList.layer.cornerRadius = 5;
    tblViewDropDownList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tblViewDropDownList.layer.borderWidth = 2;
    
    btnCashOnDeliveryBtn.enabled = YES;
    btnOnLineRadioBtn.enabled = NO;
    imgViewOnlinePayRadioBtn.image =  [UIImage imageNamed:@"Selected_RadioButton_payoption.png"];
    imgViewCashOnDeliveryRadioBtn.image = [UIImage imageNamed:@"Nonselected_RadioButton_payoption.png"];
    strPaymentMode = @"2";
    
    [txtFldCountry loadNibName];
    txtFldCountry.placeHolder = [[UIConstants returnInstance] isItEnglish]?@"Select Country":SelectCountry_Arabic;
    txtFldCountry.arrDataCombo = aryCountryList;
    [txtFldState loadNibName];
    txtFldState.placeHolder = [[UIConstants returnInstance] isItEnglish]?@"Select State":SelectState_Arabic;
    [txtFldCity loadNibName];
    txtFldCity.placeHolder = [[UIConstants returnInstance] isItEnglish]?@"Select City":SelectCity_Arabic;
    [txtFldDeliverySupportedArea_EditView loadNibName];
    txtFldDeliverySupportedArea_EditView.placeHolder = [[UIConstants returnInstance] isItEnglish]?@"Select Area":SelectArea_Arabic;
    [txtFldDeliverySupportedArea loadNibName];
    txtFldDeliverySupportedArea.placeHolder = [[UIConstants returnInstance] isItEnglish]?@"Select Area":SelectArea_Arabic;
    [txtFldAddressType loadNibName];
    txtFldAddressType.placeHolder = [[UIConstants returnInstance] isItEnglish]?@"Address":SelectAddress_Arabic;
    txtFldAddressType.arrDataCombo = aryAddressList;
    
    
    txtFldAddressLine1.textAlignment = FOS_TEXTALIGNMENT;
    txtFldAddressLine2.textAlignment = FOS_TEXTALIGNMENT;
    txtFldEmailId.textAlignment = FOS_TEXTALIGNMENT;
    txtFldName.textAlignment = FOS_TEXTALIGNMENT;
    txtFldMobileNumber.textAlignment = FOS_TEXTALIGNMENT;
    txtFldLandMark.textAlignment = FOS_TEXTALIGNMENT;
    lblAddressText.textAlignment = FOS_TEXTALIGNMENT;
    lblPersonalInfo1.textAlignment = FOS_TEXTALIGNMENT;
    lblPersonalInfo2.textAlignment = FOS_TEXTALIGNMENT;
    lblAreaToBeDelivered.textAlignment = FOS_TEXTALIGNMENT;
    lblAreaTobeDeliveredText.textAlignment = FOS_TEXTALIGNMENT;
    lblPersonalInfo1.textAlignment = FOS_TEXTALIGNMENT;
    lblPersonalInfo2.textAlignment = FOS_TEXTALIGNMENT;
    lblPersonalInfo3.textAlignment = FOS_TEXTALIGNMENT;
   
    lblSelectYourAddress.textAlignment = FOS_TEXTALIGNMENT;
    lblAreaTobeDeliveredText.textAlignment = FOS_TEXTALIGNMENT;

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![[UIConstants returnInstance] IsBackFromPaymentOrMobileVerify]) {
        if ([[UIConstants returnInstance] strFosUserID]) {
            loginBtn.hidden = YES;
            btnUserMenu.hidden = NO;
            [btnUserMenu setImage:[UIImage imageNamed:@"User_loggedIn.png"] forState:UIControlStateNormal];
        }else{
            loginBtn.hidden = NO;
            btnUserMenu.hidden = YES;
            [btnUserMenu setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
        }
        for (UIView *view in [scrollViewCheckOut subviews]) {
            [view removeFromSuperview];
        }
        aryAddressList = [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_UserAddress];
        aryDeliverySupportedArea = [[UIConstants returnInstance] aryDeliverySupportedAreas];
        if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
            if ([[UIConstants returnInstance]strFosUserID]) {
                [self ScreenForHomeDeliveryWithLogin];
            }else{
                [self ScreenForHomeDelivery];
            }
        }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]){
            if ([[UIConstants returnInstance]strFosUserID]) {
                [self ScreenForTakeAwayWithLogin];
            }else{
                [self ScreenForTakeAway];
            }
        }
        
        
        txtFldDeliverySupportedArea.arrDataCombo = [[UIConstants returnInstance] aryDeliverySupportedAreas];
        txtFldDeliverySupportedArea_EditView.arrDataCombo = [[UIConstants returnInstance] aryDeliverySupportedAreas];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set Font

-(void)SetFont
{
    btnEditProfile.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnSignOut.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    loginBtn.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnRegister.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    lblPersonalInfo1.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblPersonalInfo2.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblMobileNumber.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblEmailId.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
    //lblAddress.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
    lblChoosePaymentMode.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblOnlinePayment.font = [[UIConstants returnInstance] returnArvoBold:13];
    lblCashOnDelivery.font = [[UIConstants returnInstance] returnArvoBold:13];
    
    lblUserName.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblUserMobileNo.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblUserEmailId.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblDeliveryAddressText.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblDeliveryAddress.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblLandMarkText.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblLandMark.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblAreaToBeDelivered.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblSelectYourAddress.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnEdit.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:14];
    
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    lblUserNameText.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblTakeAwayUserName.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblUserMobileNoText.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblTakeAwayUserMobileNo.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblUserEmailIdText.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblTakeAwayUserEmailID.font = [[UIConstants returnInstance] returnArvoRegular:13];
    
    btnPayment.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:15];
    btnClearTextFields.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:15];
    
    txtFldAddressLine1.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldAddressLine2.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldAddressType.font = [[UIConstants returnInstance] returnArvoRegular:13];
    txtFldArea.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldCity.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldCountry.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldEmailId.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldLandMark.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldMobileNumber.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldState.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldDeliverySupportedArea.font = [[UIConstants returnInstance] returnArvoRegular:13];
    txtFldDeliverySupportedArea_EditView.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblShareLocation.font = [[UIConstants returnInstance] returnArvoBold:13];
    lblAddressText.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblAreaTobeDeliveredText.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
}

#pragma mark - Button action methods

//-(void)OnClickChangePasswordButton:(id)sender
//{
//    [viewUserMenu removeFromSuperview];
//    [self.delegate LoadTabBar:4];
//}

-(void)OnClickEditProfileButton:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadNextScreen:VIEW_EDITPROFILE];
}

-(void)OnClickGoBackButton:(id)sender
{
    [self.view endEditing:YES];
    [self.delegate GoBack:YES];
}

-(void)OnClickLoignButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [[UIConstants returnInstance] setIsBackFromPaymentOrMobileVerify:NO];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_LOGIN];
}

-(void)OnClickCheckOutButton:(id)sender
{
    
    if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
        if ([[UIConstants returnInstance]strFosUserID]) {
            [self ValidateForHomeDeliveryWithLogin];
        }else{
            [self ValidateForHomeDelivery];
        }
    }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]){
        if ([[UIConstants returnInstance]strFosUserID]) {
            [self ValidateForTakeAwayWithLogin];
        }else{
            [self ValidateForTakeAway];
        }
    }
}

-(void)OnClickRegisterButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_REGISTER];
}

-(void)OnClickSignOutButton:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [[UIConstants returnInstance] setStrFosUserID:nil];
    [btnUserMenu setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    loginBtn.hidden = NO;
    btnUserMenu.hidden = YES;
    for (UIView *view in [scrollViewCheckOut subviews]) {
        [view removeFromSuperview];
    }
    if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
        viewShareLocation.hidden = NO;
        [self ScreenForHomeDelivery];
    }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]){
        [self ScreenForTakeAway];
    }
}

-(void)OnClickUserMenuButton:(id)sender
{
    if ([[UIConstants returnInstance] strFosUserID]) {
        BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
        UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:(isArabic)? UserDetails_Arabic : UserDetails_Eng delegate:self cancelButtonTitle:(isArabic)? Cancel_Arabic : Cancel_Eng destructiveButtonTitle:nil otherButtonTitles:(isArabic)? EditProfile_Arabic : EditProfile_Eng ,(isArabic)? SignOut_Arabic : SignOut_Eng, nil];

        [sheet showInView:self.view];
//        if (viewUserMenu.superview == nil) {
//            viewUserMenu.frame = CGRectMake(self.view.frame.size.width - viewUserMenu.frame.size.width-5, btnUserMenu.frame.origin.y + btnUserMenu.frame.size.height + 8, viewUserMenu.frame.size.width, viewUserMenu.frame.size.height);
//            [self.view addSubview:viewUserMenu];
//        }else{
//            [viewUserMenu removeFromSuperview];
//        }
//    }else{
//        if (viewLoginMenu.superview  == nil) {
//            viewLoginMenu.frame = CGRectMake(self.view.frame.size.width - viewLoginMenu.frame.size.width-5, btnUserMenu.frame.origin.y + btnUserMenu.frame.size.height + 8, viewLoginMenu.frame.size.width, viewLoginMenu.frame.size.height);
//            [self.view addSubview:viewLoginMenu];
//        }else {
//            [viewLoginMenu removeFromSuperview];
//        }
    }
}

-(void)OnClickCashOnDeliveryButton:(id)sender
{
    btnCashOnDeliveryBtn.enabled = NO;
    btnOnLineRadioBtn.enabled = YES;
    imgViewCashOnDeliveryRadioBtn.image =  [UIImage imageNamed:@"Selected_RadioButton_payoption.png"];
    imgViewOnlinePayRadioBtn.image = [UIImage imageNamed:@"Nonselected_RadioButton_payoption.png"];
    strPaymentMode = @"0";
}

-(void)OnClickOnlinePaymentButton:(id)sender
{
    btnCashOnDeliveryBtn.enabled = YES;
    btnOnLineRadioBtn.enabled = NO;
    imgViewOnlinePayRadioBtn.image =  [UIImage imageNamed:@"Selected_RadioButton_payoption.png"];
    imgViewCashOnDeliveryRadioBtn.image = [UIImage imageNamed:@"Nonselected_RadioButton_payoption.png"];
    strPaymentMode = @"2";
}

-(void)OnClickShareLocationButton:(id)sender
{
    if (imgViewTickShareLocation.image == [UIImage imageNamed:@"checkmarkNonSelection.png"]) {
        [self GetLocationUpdate];
    }else{
        imgViewTickShareLocation.image = [UIImage imageNamed:@"checkmarkNonSelection.png"];
        [[UIConstants returnInstance] setStrLatitude:nil];
        [[UIConstants returnInstance] setStrLongitude:nil];
    }

}


-(void)OnClickEditButton:(id)sender
{
    [viewHomeDeliveryUserDetail removeFromSuperview];
    viewShareLocation.hidden = YES;
    btnClearTextFields.hidden = NO;
    [self setValuesForTextField];
    viewPersonalInfo.frame = CGRectMake(0, 0, viewPersonalInfo.frame.size.width, viewPersonalInfo.frame.size.height);
    viewPersonalInfo.userInteractionEnabled = NO;
    viewPersonalInfo.alpha = 0.5;
    viewAddress.frame= CGRectMake(0,viewPersonalInfo.frame.origin.y + viewPersonalInfo.frame.size.height, viewAddress.frame.size.width, viewAddress.frame.size.height );
    viewChoosePaymentMode.frame = CGRectMake(0, viewAddress.frame.origin.y + viewAddress.frame.size.height, viewChoosePaymentMode.frame.size.width, viewChoosePaymentMode.frame.size.height);
    [scrollViewCheckOut addSubview:viewPersonalInfo];
    [scrollViewCheckOut addSubview:viewAddress];
    [scrollViewCheckOut setContentSize:CGSizeMake(0, viewPersonalInfo.frame.size.height+viewAddress.frame.size.height+viewChoosePaymentMode.frame.size.height)];
}

-(void)OnClickSelectAreaButton:(id)sender
{
    [self.view endEditing:YES];
    if ([txtFldCity.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(15, txtFldArea.frame.origin.y+txtFldArea.frame.size.height,290,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 11;
            aryAreaList = [[self getDetailsforArea:nil withCity:txtFldCity.selectedText withState:txtFldState.selectedText withCountry:txtFldCountry.selectedText] objectForKey:key_Areas];
            [viewAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 11) {
                tblViewDropDownList.frame =CGRectMake(15, txtFldArea.frame.origin.y+txtFldArea.frame.size.height,290,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 11;
                [viewAddress addSubview:tblViewDropDownList];
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
-(void)OnClickSelectCityButton:(id)sender
{
    [self.view endEditing:YES];
    if ([txtFldState.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(15, txtFldCity.frame.origin.y+txtFldCity.frame.size.height,290,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 12;
            aryCityList =  [[self getDetailsforArea:nil withCity:nil withState:txtFldState.selectedText withCountry:txtFldCountry.selectedText] objectForKey:key_Cities];
            [viewAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 12) {
                tblViewDropDownList.frame =CGRectMake(15, txtFldCity.frame.origin.y+txtFldCity.frame.size.height+10,290,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 12;
                [viewAddress addSubview:tblViewDropDownList];
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
-(void)OnClickSelectStateButton:(id)sender
{
    [self.view endEditing:YES];
    if ([txtFldCountry.selectedText length] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(15, txtFldState.frame.origin.y+txtFldState.frame.size.height,290,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 13;
            
            aryStateList =[[self getDetailsforArea:nil withCity:nil withState:nil withCountry:txtFldCountry.selectedText] objectForKey:key_States];
            [viewAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 13) {
                tblViewDropDownList.frame =CGRectMake(15, txtFldState.frame.origin.y+txtFldState.frame.size.height,290,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 13;
                [viewAddress addSubview:tblViewDropDownList];
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
-(void)OnClickSelectCountryButton:(id)sender
{
    [self.view endEditing:YES];
    if ([aryCountryList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(15, txtFldCountry.frame.origin.y+txtFldCountry.frame.size.height,290,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 14;
            [viewAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 14) {
                tblViewDropDownList.frame =CGRectMake(15, txtFldCountry.frame.origin.y+txtFldCountry.frame.size.height,290,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 14;
                [viewAddress addSubview:tblViewDropDownList];
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

-(void)OnClickSelectAddressTypeButton:(id)sender
{
    [self.view endEditing:YES];
    if ([aryAddressList count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(10, txtFldAddressType.frame.origin.y+txtFldAddressType.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 10;
            [viewHomeDeliveryUserDetail addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 10) {
                tblViewDropDownList.frame =CGRectMake(15, txtFldAddressType.frame.origin.y+txtFldAddressType.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 10;
                [viewHomeDeliveryUserDetail addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
}

-(void)OnClickSelectSupportedAreaButton:(id)sender
{
    [self.view endEditing:YES];
    
    if ([aryDeliverySupportedArea count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(10, txtFldDeliverySupportedArea.frame.origin.y+txtFldDeliverySupportedArea.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 15;
            [viewHomeDeliveryUserDetail addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 15) {
                tblViewDropDownList.frame =CGRectMake(15, txtFldDeliverySupportedArea.frame.origin.y+txtFldDeliverySupportedArea.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 15;
                [viewHomeDeliveryUserDetail addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
}

-(void)OnClickSelectSupportedAreaButton_EditView:(id)sender
{
    [self.view endEditing:YES];
    if ([aryDeliverySupportedArea count] > 0) {
        if (tblViewDropDownList.superview == nil) {
            tblViewDropDownList.frame =CGRectMake(15, txtFldDeliverySupportedArea_EditView.frame.origin.y+txtFldDeliverySupportedArea_EditView.frame.size.height,290,tblViewDropDownList.frame.size.height);
            tblViewDropDownList.tag = 15;
            [viewAddress addSubview:tblViewDropDownList];
            [tblViewDropDownList reloadData];
        }else{
            [tblViewDropDownList removeFromSuperview];
            if (tblViewDropDownList.tag != 15) {
                tblViewDropDownList.frame =CGRectMake(15, txtFldDeliverySupportedArea_EditView.frame.origin.y+txtFldDeliverySupportedArea_EditView.frame.size.height,tblViewDropDownList.frame.size.width,tblViewDropDownList.frame.size.height);
                tblViewDropDownList.tag = 15;
                [viewAddress addSubview:tblViewDropDownList];
                [tblViewDropDownList reloadData];
            }
        }
    }
}

-(void)OnClickClearTextFieldButton:(id)sender
{
    txtFldAddressLine1.text = @"";
    txtFldAddressLine2.text = @"";
    txtFldLandMark.text = @"";
    txtFldCountry.selectedText = @"";
    txtFldState.selectedText = @"";
    txtFldCity.selectedText = @"";
    txtFldDeliverySupportedArea_EditView.selectedText = @"";
    txtFldDeliverySupportedArea_EditView.userInteractionEnabled = YES;
}

//-(void)OnClickSaveButton:(id)sender
//{
//    [self SetValuesForLabel:txtFldName.text :txtFldMobileNumber.text :txtFldEmailId.text];
//    [self ShowAddress:[NSDictionary dictionaryWithObjectsAndKeys:
//                  txtFldAddressLine1.text, key_StreetLine1,
//                  txtFldAddressLine2.text, key_StreetLine2,
//                  txtFldLandMark.text, key_LandMark1,
//                  txtFldArea.text, key_Area,
//                  txtFldCity.text, key_City,
//                  txtFldState.text, key_State,
//                  txtFldCountry.text,key_Country, nil]];
//    
//    viewHomeDeliveryUserDetail.hidden = NO;
//    viewChoosePaymentMode.hidden = NO;
//    [viewDeliverySupportedAreas removeFromSuperview];
//    [viewPersonalInfo removeFromSuperview];
//    viewAddress.frame= CGRectMake(0,viewPersonalInfo.frame.origin.y + viewPersonalInfo.frame.size.height, viewAddress.frame.size.width, viewAddress.frame.size.height-50);
//    [viewAddress removeFromSuperview];
//    viewShareLocation.hidden = NO;
//    
//    [scrollViewCheckOut setContentSize:CGSizeMake(0, viewHomeDeliveryUserDetail.frame.size.height+viewChoosePaymentMode.frame.size.height)];
//    
//}

#pragma mark - Change Language to Arabic
-(void)ChangeLanguageToArabic
{
    txtFldAddressType.placeHolder = Address_Arabic;
    txtFldDeliverySupportedArea.placeHolder = Area_Arabic;
    
    txtFldCountry.placeHolder = Country_Arabic;
    txtFldState.placeHolder = State_Arabic;
    txtFldCity.placeHolder = City_Arabic;
    txtFldArea.placeholder = Area_Arabic;
    
    txtFldDeliverySupportedArea.placeHolder = Area_Arabic;
    txtFldDeliverySupportedArea_EditView.placeHolder = Area_Arabic;
    
    [btnGoBack setTitle:(NSString *)Back_Arabic forState:UIControlStateNormal];
    [btnLogin setTitle:(NSString *)Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];
    

    lblPersonalInfo1.text = PersonalInfo_Arabic;
    lblPersonalInfo2.text = PersonalInfo_Arabic;
    lblPersonalInfo3.text = PersonalInfo_Arabic;
    lblName.text = Name_Stared_Arabic;
    lblMobileNumber.text = MobileNo_Arabic;
    lblEmailId.text = EmailId_Arabic;
    lblAddressText.text = Address_Arabic;
    lblSelectYourAddress.text = Address_Arabic;
    lblAreaTobeDeliveredText.text = Areatobedeliver_arabic;
    lblAreaToBeDelivered.text = Areatobedeliver_arabic;
    lblShareLocation.text = ShareYourLocation_Arabic;
    lblChoosePaymentMode.text = ChoosePaymentMethod_Arabic;
    lblOnlinePayment.text = OnlinePayment_Arabic;
    lblCashOnDelivery.text = CashOnDelivery_Arabic;
    lblLandMarkText.text = Landmark_NonStared_Arabic;
    
    lblRequired.text = Required_Arabic;
    
    txtFldDeliverySupportedArea_EditView.placeHolder = SelectArea_Arabic;
    txtFldState.placeHolder = SelectState_Arabic;
    txtFldCity.placeHolder = SelectCity_Arabic;
    txtFldCountry.placeHolder = SelectCountry_Arabic;
    txtFldLandMark.placeholder = Landmark_Arabic;
    
    
    lblPersonalInfo1.textAlignment = NSTextAlignmentRight;
    lblPersonalInfo2.textAlignment = NSTextAlignmentRight;
    lblName.textAlignment = NSTextAlignmentRight;
    lblMobileNumber.textAlignment = NSTextAlignmentRight;
    lblEmailId.textAlignment = NSTextAlignmentRight;
    //lblAddress.textAlignment = NSTextAlignmentRight;
    lblShareLocation.textAlignment = NSTextAlignmentRight;
    lblChoosePaymentMode.textAlignment = NSTextAlignmentRight;
    lblOnlinePayment.textAlignment = NSTextAlignmentRight;
    lblCashOnDelivery.textAlignment = NSTextAlignmentRight;
    lblLandMarkText.textAlignment = NSTextAlignmentRight;
    lblLandMark.textAlignment = NSTextAlignmentRight;
    
    
    txtFldAddressLine1.placeholder = Line1Address_Arabic;
    txtFldAddressLine2.placeholder = Line2Address_Arabic;
    //txtFldAddressLine3.placeholder = Line3Address_Arabic;
    
    txtFldAddressLine1.textAlignment = NSTextAlignmentRight;
    txtFldAddressLine2.textAlignment = NSTextAlignmentRight;
    //txtFldAddressLine3.textAlignment = NSTextAlignmentRight;
    
    btnOnLineRadioBtn.frame = CGRectMake(viewChoosePaymentMode.frame.size.width - btnOnLineRadioBtn.frame.origin.x - btnOnLineRadioBtn.frame.size.width, btnOnLineRadioBtn.frame.origin.y, btnOnLineRadioBtn.frame.size.width, btnOnLineRadioBtn.frame.size.height);
    lblOnlinePayment.frame = CGRectMake(btnOnLineRadioBtn.frame.origin.x, lblOnlinePayment.frame.origin.y, lblOnlinePayment.frame.size.width, lblOnlinePayment.frame.size.height);
    imgViewOnlinePayRadioBtn.frame = CGRectMake(lblOnlinePayment.frame.origin.x + lblOnlinePayment.frame.size.width + 5, imgViewOnlinePayRadioBtn.frame.origin.y, imgViewOnlinePayRadioBtn.frame.size.width, imgViewOnlinePayRadioBtn.frame.size.height);
    
    btnCashOnDeliveryBtn.frame = CGRectMake(viewChoosePaymentMode.frame.size.width - btnCashOnDeliveryBtn.frame.origin.x - btnCashOnDeliveryBtn.frame.size.width, btnCashOnDeliveryBtn.frame.origin.y, btnCashOnDeliveryBtn.frame.size.width, btnCashOnDeliveryBtn.frame.size.height);
    lblCashOnDelivery.frame = CGRectMake(btnCashOnDeliveryBtn.frame.origin.x, lblCashOnDelivery.frame.origin.y, lblCashOnDelivery.frame.size.width, lblCashOnDelivery.frame.size.height);
    imgViewCashOnDeliveryRadioBtn.frame = CGRectMake(lblCashOnDelivery.frame.origin.x + lblCashOnDelivery.frame.size.width + 5, imgViewCashOnDeliveryRadioBtn.frame.origin.y, imgViewCashOnDeliveryRadioBtn.frame.size.width, imgViewCashOnDeliveryRadioBtn.frame.size.height);
    
    [btnEdit setTitle:Edit_Arabic forState:UIControlStateNormal];
    btnEdit.frame = CGRectMake(self.view.frame.size.width - btnEdit.frame.origin.x - btnEdit.frame.size.width, btnEdit.frame.origin.y, btnEdit.frame.size.width, btnEdit.frame.size.height);
    
    lblDeliveryAddressText.text = DeliveryAddress_Arabic;
    //lblLandMark.text = Landmark_Arabic;
    lblUserNameText.text = Name_Arabic;
    lblUserMobileNoText.text = MobileNo_NonStared_Arabic;
    lblUserEmailIdText.text = Email_NonStared_Arabic;
    
    lblDeliveryAddressText.textAlignment = NSTextAlignmentRight;
    lblLandMark.textAlignment = NSTextAlignmentRight;
    lblUserNameText.textAlignment = NSTextAlignmentRight;
    lblUserMobileNoText.textAlignment = NSTextAlignmentRight;
    lblUserEmailIdText.textAlignment = NSTextAlignmentRight;
    
    lblUserName.textAlignment =NSTextAlignmentRight;
    lblUserMobileNo.textAlignment =NSTextAlignmentRight;
    lblUserEmailId.textAlignment =NSTextAlignmentRight;
    lblDeliveryAddress.textAlignment =NSTextAlignmentRight;
    lblLandMark.textAlignment =NSTextAlignmentRight;
    lblTakeAwayUserName.textAlignment =NSTextAlignmentRight;
    lblTakeAwayUserMobileNo.textAlignment =NSTextAlignmentRight;
    lblTakeAwayUserEmailID.textAlignment =NSTextAlignmentRight;
    
    [btnPayment setTitle:CheckOut_Arabic forState:UIControlStateNormal];
    [btnClearTextFields setTitle:Clear_Arabic forState:UIControlStateNormal];
//    btnPayment.frame = CGRectMake(self.view.frame.size.width - btnPayment.frame.origin.x - btnPayment.frame.size.width, btnPayment.frame.origin.y, btnPayment.frame.size.width, btnPayment.frame.size.height);
    
    imgViewEmailId.frame = [[UIConstants returnInstance] getFrameForLanguage:imgViewEmailId.frame withSuperViewRect:imgViewEmailId.superview.frame];
    imgViewPhoneNumber.frame = [[UIConstants returnInstance] getFrameForLanguage:imgViewPhoneNumber.frame withSuperViewRect:imgViewPhoneNumber.superview.frame];
    lblUserMobileNo.frame = [[UIConstants returnInstance] getFrameForLanguage:lblUserMobileNo.frame withSuperViewRect:lblUserMobileNo.superview.frame];
    lblUserEmailId.frame = [[UIConstants returnInstance] getFrameForLanguage:lblUserEmailId.frame withSuperViewRect:lblUserEmailId.superview.frame];
    
    btnShareLocation.frame = [[UIConstants returnInstance] getFrameForLanguage:btnShareLocation.frame withSuperViewRect:btnShareLocation.superview.frame];
    lblShareLocation.frame = [[UIConstants returnInstance] getFrameForLanguage:lblShareLocation.frame withSuperViewRect:lblShareLocation.superview.frame];
    imgViewTickShareLocation.frame = [[UIConstants returnInstance] getFrameForLanguage:imgViewTickShareLocation.frame withSuperViewRect:imgViewTickShareLocation.superview.frame];
    
    
}

#pragma mark - Set the screen

-(void)ScreenForHomeDelivery
{
    btnClearTextFields.hidden = YES;
    lblScreenName.text = [[UIConstants returnInstance] isItEnglish]?@"Home Delivery Info":HomeDelivery_Arabic;
    viewPersonalInfo.frame = CGRectMake(0, 0, viewPersonalInfo.frame.size.width, viewPersonalInfo.frame.size.height);
    viewAddress.frame= CGRectMake(0,viewPersonalInfo.frame.origin.y + viewPersonalInfo.frame.size.height, viewAddress.frame.size.width, viewAddress.frame.size.height);
    viewChoosePaymentMode.frame = CGRectMake(0, viewAddress.frame.origin.y + viewAddress.frame.size.height, viewChoosePaymentMode.frame.size.width, viewChoosePaymentMode.frame.size.height);
    
    [scrollViewCheckOut addSubview:viewPersonalInfo];
    [scrollViewCheckOut addSubview:viewAddress];
    [scrollViewCheckOut addSubview:viewChoosePaymentMode];
    
    [scrollViewCheckOut setContentSize:CGSizeMake(0, viewPersonalInfo.frame.size.height+viewAddress.frame.size.height+viewChoosePaymentMode.frame.size.height)];
}

-(void)ScreenForTakeAway
{
    btnClearTextFields.hidden = YES;
    lblScreenName.text = [[UIConstants returnInstance] isItEnglish]?@"Take Away Info":TakeAway_Arabic;
    viewPersonalInfo.frame = CGRectMake(0, 0, viewPersonalInfo.frame.size.width, viewPersonalInfo.frame.size.height);
    viewChoosePaymentMode.frame = CGRectMake(0, viewPersonalInfo.frame.origin.y + viewPersonalInfo.frame.size.height, viewChoosePaymentMode.frame.size.width, viewChoosePaymentMode.frame.size.height);
    
    [scrollViewCheckOut addSubview:viewPersonalInfo];
    [scrollViewCheckOut addSubview:viewChoosePaymentMode];
    [scrollViewCheckOut setContentSize:CGSizeMake(0, viewPersonalInfo.frame.size.height+viewChoosePaymentMode.frame.size.height)];
}

- (void)ScreenForHomeDeliveryWithLogin
{
    btnClearTextFields.hidden = YES;
    lblScreenName.text = [[UIConstants returnInstance] isItEnglish]?@"Home Delivery Info":HomeDelivery_Arabic;
    viewHomeDeliveryUserDetail.frame = CGRectMake(0, 0, viewHomeDeliveryUserDetail.frame.size.width, viewHomeDeliveryUserDetail.frame.size.height);
    viewChoosePaymentMode.frame  = CGRectMake(0, viewHomeDeliveryUserDetail.frame.size.height, viewChoosePaymentMode.frame.size.width, viewChoosePaymentMode.frame.size.height);
    NSString *_strName = [NSString stringWithFormat:@"%@ %@", [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_FirstName],[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_LastName]];
    [self SetValuesForLabel:_strName :[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo] :[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_EmailID]];
    
    [[UIConstants returnInstance] setStrUserMobileNo:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo]];
    
    for (NSDictionary *dictionary in aryAddressList) {
        if ([[dictionary objectForKey:key_IsPrimary] integerValue] == 1 ) {
            txtFldAddressType.selectedText = ([dictionary objectForKey:key_AddressName])?[dictionary objectForKey:key_AddressName]:@"";
            strIsPrimary = ([dictionary objectForKey:key_IsPrimary])?[dictionary objectForKey:key_IsPrimary]:@"";
            lblLandMark.text = [dictionary objectForKey:key_LandMark1];
            [self ShowAddress:dictionary];
            break;
        }
    }
    
    [scrollViewCheckOut addSubview:viewHomeDeliveryUserDetail];
    [scrollViewCheckOut addSubview:viewChoosePaymentMode];
    [scrollViewCheckOut setContentSize:CGSizeMake(0, viewHomeDeliveryUserDetail.frame.size.height+viewChoosePaymentMode.frame.size.height)];
}

-(void)ScreenForTakeAwayWithLogin
{
    btnClearTextFields.hidden = YES;
    lblScreenName.text = [[UIConstants returnInstance] isItEnglish]?@"Take Away Info":TakeAway_Arabic;
    viewTakeAwayUserDetail.frame = CGRectMake(0, 0, viewTakeAwayUserDetail.frame.size.width, viewTakeAwayUserDetail.frame.size.height);
    viewChoosePaymentMode.frame = CGRectMake(0, viewTakeAwayUserDetail.frame.origin.y + viewTakeAwayUserDetail.frame.size.height, viewChoosePaymentMode.frame.size.width, viewChoosePaymentMode.frame.size.height);
    
    lblTakeAwayUserName.text = [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_FirstName];
    lblTakeAwayUserMobileNo.text = [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo];
    lblTakeAwayUserEmailID.text =  [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_EmailID];
    
    [[UIConstants returnInstance] setStrUserMobileNo:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo]];
    
    [scrollViewCheckOut addSubview:viewTakeAwayUserDetail];
    [scrollViewCheckOut addSubview:viewChoosePaymentMode];
    [scrollViewCheckOut setContentSize:CGSizeMake(0, viewTakeAwayUserDetail.frame.size.height+viewChoosePaymentMode.frame.size.height)];
}


#pragma mark - Validation Methods

-(void)ValidateForHomeDelivery
{
    int X = 150;
    
    if ([txtFldName.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldName.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewPersonalInfo addSubview:viewPopUp];
        [self SetContentOffSet:txtFldName];
        return;
    }else if ([txtFldName.text length] < 2) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_NameMinimumChar_English:Alert_NameMinimumChar_Arabic];
        //txtFldName.text = @"";
        [txtFldName becomeFirstResponder];
        return;
    }
    
    if ([txtFldMobileNumber.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldMobileNumber.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewPersonalInfo addSubview:viewPopUp];
        [self SetContentOffSet:txtFldMobileNumber];
        return;
    }else if ([txtFldMobileNumber.text length] != 10) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_MobileNumberInvalid_English:Alert_MobileNumberInvalid_Arabic];
        [txtFldMobileNumber becomeFirstResponder];
        return;
    }
    
    if ([txtFldEmailId.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldEmailId.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewPersonalInfo addSubview:viewPopUp];
        [self SetContentOffSet:txtFldEmailId];
        return;
    }else if (![self validateEmail:txtFldEmailId.text]) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_EmailInvalid_English:Alert_EmailInvalid_Arabic];
        [txtFldEmailId becomeFirstResponder];
        return;
    }
    
    if ([txtFldDeliverySupportedArea_EditView.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectAreaToBeDelivered_English:Alert_SelectAreaToBeDelivered_Arabic];
        return;
    }
    
    if ([txtFldAddressLine1.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldAddressLine1.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewAddress addSubview:viewPopUp];
        [self SetContentOffSet:txtFldAddressLine1];
        return;
    }
    
//    if ([txtFldAddressLine2.text length] == 0) {
//        viewPopUp.frame = CGRectMake(X, txtFldAddressLine2.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//        [viewAddress addSubview:viewPopUp];
//        return;
//    }
    
    if ([txtFldLandMark.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldLandMark.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewAddress addSubview:viewPopUp];
        [self SetContentOffSet:txtFldLandMark];
        return;
    }
    
    if ([txtFldCountry.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCountry_English:Alert_SelectYourCountry_Arabic];
        return;
    }
    
    if ([txtFldState.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourState_English:Alert_SelectYourState_Arabic];
        return;
    }
    
    if ([txtFldCity.selectedText length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCity_English:Alert_SelectYourCity_Arabic];
        return;
    }
    
//    if ([txtFldArea.text length] == 0) {
//        [[UIConstants returnInstance] ShowAlert:@"Please Select Your Area"];
//        return;
//    }
    
    
//    if (![txtFldDeliverySupportedArea_EditView.text isEqualToString:txtFldArea.text]) {
//        [[UIConstants returnInstance] ShowAlert:@"Delivery area should be same as the area in address."];
//        return;
//    }
    
//    if (strPaymentMode == nil) {
//        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourArea_Arabic:Alert_EmailInvalid_Arabic];
//        return;
//    }
    
    [[UIConstants returnInstance] setStrUserMobileNo:txtFldMobileNumber.text];
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetRegisterGuestUserAPI:txtFldEmailId.text :txtFldName.text :txtFldMobileNumber.text :@"1" :txtFldAddressLine1.text :txtFldAddressLine2.text :txtFldDeliverySupportedArea_EditView.selectedText :txtFldCity.selectedText :txtFldState.selectedText :txtFldCountry.selectedText :txtFldLandMark.text]) {
        if([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 200) {
            strUserId = [[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_Id];
            [[UIConstants returnInstance] setStrGuestUserID:strUserId];
            if([self CheckOutMethod]){
                if ([btnOnLineRadioBtn isEnabled]) {
                    [self.delegate LoadNextScreen:VIEW_VERIFYMOBILENO];
                }else{
                    //[[UIConstants returnInstance] ShowAlert:@"Payment Gateway yet to implement"];
                    [self.delegate LoadNextScreen:VIEW_PAYMENTGATEWAY];
                }
            }
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusMessage]];
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

-(void)ValidateForHomeDeliveryWithLogin
{
    if (viewHomeDeliveryUserDetail.superview != nil) {
        if ([txtFldDeliverySupportedArea.selectedText length] == 0) {
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectAreaToBeDelivered_English:Alert_SelectAreaToBeDelivered_Arabic];
            return;
        }
        for (NSDictionary *dictionary in aryAddressList) {
            if ([txtFldAddressType.selectedText isEqualToString:[dictionary objectForKey:key_AddressName]]) {
                NSLog(@"%@ = %@", txtFldDeliverySupportedArea.selectedText, [dictionary objectForKey:key_Area]);
                if (![txtFldDeliverySupportedArea.selectedText isEqualToString:[dictionary objectForKey:key_Area]]) {
                    [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_DeliveryAreaShouldbeSame_English:Alert_DeliveryAreaShouldbeSame_Arabic];
                    [self OnClickEditButton:nil];
                    return;
                }
            }
        }
        
        
    }else{
        int X = 150;
//        if ([txtFldName.text length] == 0) {
//            viewPopUp.frame = CGRectMake(X, txtFldName.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//            [viewPersonalInfo addSubview:viewPopUp];
//            [self SetContentOffSet:txtFldName];
//            return;
//        }else if ([txtFldName.text length] < 2) {
//            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_NameMinimumChar_English:Alert_NameMinimumChar_Arabic];
//           // txtFldName.text = @"";
//            [txtFldName becomeFirstResponder];
//            return;
//        }
//        
//        if ([txtFldMobileNumber.text length] == 0) {
//            viewPopUp.frame = CGRectMake(X, txtFldMobileNumber.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//            [viewPersonalInfo addSubview:viewPopUp];
//            [self SetContentOffSet:txtFldMobileNumber];
//            return;
//        }else if ([txtFldMobileNumber.text length] != 10) {
//            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_MobileNumberInvalid_English:Alert_MobileNumberInvalid_Arabic];
//            //txtFldMobileNumber.text = @"";
//            [txtFldMobileNumber becomeFirstResponder];
//            return;
//        }
        
        if ([txtFldEmailId.text length] == 0) {
            viewPopUp.frame = CGRectMake(X, txtFldEmailId.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
            [viewPersonalInfo addSubview:viewPopUp];
            [self SetContentOffSet:txtFldEmailId];
            return;
        }else if (![self validateEmail:txtFldEmailId.text]) {
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_EmailInvalid_English:Alert_EmailInvalid_Arabic];
            //txtFldEmailId.text = @"";
            [txtFldEmailId becomeFirstResponder];
            return;
        }
        
        if ([txtFldDeliverySupportedArea_EditView.selectedText length] == 0) {
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectAreaToBeDelivered_English:Alert_SelectAreaToBeDelivered_Arabic];
            return;
        }
        
        if ([txtFldAddressLine1.text length] == 0) {
            viewPopUp.frame = CGRectMake(X, txtFldAddressLine1.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
            [viewAddress addSubview:viewPopUp];
            [self SetContentOffSet:txtFldAddressLine1];
            return;
        }
//        if ([txtFldAddressLine2.text length] == 0) {
//            viewPopUp.frame = CGRectMake(X, txtFldAddressLine2.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
//            [viewAddress addSubview:viewPopUp];
//            return;
//        }
        if ([txtFldLandMark.text length] == 0) {
            viewPopUp.frame = CGRectMake(X, txtFldLandMark.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
            [viewAddress addSubview:viewPopUp];
            [self SetContentOffSet:txtFldLandMark];
            return;
        }
        if ([txtFldCountry.selectedText length] == 0) {
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCountry_English:Alert_SelectYourCountry_Arabic];
            return;
        }
        
        if ([txtFldState.selectedText length] == 0) {
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourState_English:Alert_SelectYourState_Arabic];
            return;
        }
        
        if ([txtFldCity.selectedText length] == 0) {
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SelectYourCity_English:Alert_SelectYourCity_Arabic];
            return;
        }
        
//        if ([txtFldArea.text length] == 0) {
//            [[UIConstants returnInstance] ShowAlert:@"Please Select Area to be delivered"];
//            return;
//        }
        
//        if (txtFldDeliverySupportedArea_EditView.text != txtFldArea.text) {
//            [[UIConstants returnInstance] ShowAlert:@"Delivery area should be same as the area in address."];
//            return;
//        }
        [[UIConstants returnInstance] setStrUserMobileNo:txtFldMobileNumber.text];
        strName = lblTakeAwayUserName.text;
        strEmail = lblTakeAwayUserEmailID.text;
        strMobileNo = lblTakeAwayUserMobileNo.text;
        strAddressline1 = txtFldAddressLine1.text;
        strAddressLine2 = txtFldAddressLine2.text;
        strLandmark = txtFldLandMark.text;
        strArea = txtFldDeliverySupportedArea_EditView.selectedText;
        strCity = txtFldCity.selectedText;
        strState = txtFldState.selectedText;
        strCountry = txtFldCountry.selectedText;
    }
    
    if (strPaymentMode == nil) {
        [[UIConstants returnInstance] ShowAlert:@"Please select payment mode."];
        return;
    }
    strUserId = [[UIConstants returnInstance] strFosUserID];
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetRegisterFosUserInfoAPI:[[UIConstants returnInstance] strFosUserID] :txtFldAddressType.selectedText :strIsPrimary :strAddressline1 :strAddressLine2 :strArea :strCity :strState :strCity :strLandmark]) {
        if([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 200) {
            if([self CheckOutMethod]){
                if ([btnOnLineRadioBtn isEnabled]) {
//                    if ([[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_IsMobiileNoVerfied] integerValue] == 0 || ![[[UIConstants returnInstance] strUserMobileNo] isEqualToString:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo]]) {
                    if(![[UIConstants returnInstance] isMobileNumberVerfied]){
                        [self.delegate LoadNextScreen:VIEW_VERIFYMOBILENO];
                    }else{
                        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_MobileNumberAlreadyVerified_English:Alert_MobileNumberAlreadyVerified_Arabic];
                        [self.delegate LoadNextScreen:VIEW_PAYMENTGATEWAY];
                    }
                }else{
                   //[[UIConstants returnInstance] ShowAlert:@"Payment Gateway yet to implement"];
                    [self.delegate LoadNextScreen:VIEW_PAYMENTGATEWAY];
                }
            }
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusMessage]];
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

-(void)ValidateForTakeAway
{
    int X = 150;
    if ([txtFldName.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldName.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewPersonalInfo addSubview:viewPopUp];
        [self SetContentOffSet:txtFldName];
        return;
    }else if ([txtFldName.text length] < 2) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_NameMinimumChar_English:Alert_NameMinimumChar_Arabic];
        //txtFldName.text = @"";
        [txtFldName becomeFirstResponder];
        return;
    }
    
    if ([txtFldMobileNumber.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldMobileNumber.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewPersonalInfo addSubview:viewPopUp];
        [self SetContentOffSet:txtFldMobileNumber];
        return;
    }else if ([txtFldMobileNumber.text length] != 10) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_MobileNumberInvalid_English:Alert_MobileNumberInvalid_Arabic];
        //txtFldMobileNumber.text = @"";
        [txtFldMobileNumber becomeFirstResponder];
        return;
    }
    
    if ([txtFldEmailId.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldEmailId.frame.origin.y + 5, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewPersonalInfo addSubview:viewPopUp];
        [self SetContentOffSet:txtFldEmailId];
        return;
    }else if (![self validateEmail:txtFldEmailId.text]) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_EmailInvalid_English:Alert_EmailInvalid_Arabic];
        //txtFldEmailId.text = @"";
        [txtFldEmailId becomeFirstResponder];
        return;
    }
    
    
    if (strPaymentMode == nil) {
        [[UIConstants returnInstance] ShowAlert:@"Please select payment mode."];
        return;
    }
    
    [[UIConstants returnInstance] setStrUserMobileNo:txtFldMobileNumber.text];
    
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetRegisterGuestUserAPI:txtFldEmailId.text :txtFldName.text :txtFldMobileNumber.text :@"0" :@"" :@"" :@"" :@"" :@"" :@"" :@"" ]) {
        if([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 200) {
            strUserId = [[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_Id];
            [[UIConstants returnInstance] setStrGuestUserID:strUserId];
            if([self CheckOutMethod]){
                if ([btnOnLineRadioBtn isEnabled]) {
                    [self.delegate LoadNextScreen:VIEW_VERIFYMOBILENO];
                }else{
//                   [[UIConstants returnInstance] ShowAlert:@"Payment Gateway yet to implement"];
                    [self.delegate LoadNextScreen:VIEW_PAYMENTGATEWAY];
                }
            }
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusMessage]];
        }
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
}

-(void)ValidateForTakeAwayWithLogin
{
    if (strPaymentMode == nil) {
        [[UIConstants returnInstance] ShowAlert:@"Please select payment mode."];
        return;
    }
    strUserId = [[UIConstants returnInstance] strFosUserID];
    if([self CheckOutMethod]){
        if ([btnOnLineRadioBtn isEnabled]) {
//            if ([[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_IsMobiileNoVerfied] integerValue] == 0 || ![[[UIConstants returnInstance] strUserMobileNo] isEqualToString:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo]]) {
            if(![[UIConstants returnInstance] isMobileNumberVerfied]){
                [self.delegate LoadNextScreen:VIEW_VERIFYMOBILENO];
            }else{
                [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_MobileNumberAlreadyVerified_English:Alert_MobileNumberAlreadyVerified_Arabic];
                [self.delegate LoadNextScreen:VIEW_PAYMENTGATEWAY];
            }
        }else{
           // [[UIConstants returnInstance] ShowAlert:@"Payment Gateway yet to implement"];
            [self.delegate LoadNextScreen:VIEW_PAYMENTGATEWAY];
        }
    }
}

#pragma mark - CheckOut Method

-(BOOL)CheckOutMethod
{
//    NSMutableArray *_aryCouponDetails = [[NSMutableArray alloc] init];
//    for (NSString *_strCouponCode in [[UIConstants returnInstance] aryCouponDetails]) {
//        [_aryCouponDetails addObject:[NSDictionary dictionaryWithObjectsAndKeys:_strCouponCode,key_CouponCode, nil]];
//    }
//    NSMutableArray *_aryOrderDetails = [[UIConstants returnInstance] aryOrderedRestaurantsList];
//    [[_aryOrderDetails objectAtIndex:0] setObject:_aryCouponDetails forKey:key_CouponDiscount];
    
    ObjServiceHandler = [[ServiceHandler alloc] init];
    
    if ([ObjServiceHandler GetCheckOutAPI:[[UIConstants returnInstance] aryOrderedRestaurantsList] PaymentMode:strPaymentMode UserID:strUserId]) {
        if([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 200) {
            [[UIConstants returnInstance] setStrOrderID:[[[ResponseDTO sharedInstance] DTO_CheckOutResponse] objectForKey:key_OrderId]];
            [[UIConstants returnInstance] setStrOrderNumber:[[[ResponseDTO sharedInstance] DTO_CheckOutResponse] objectForKey:key_OrderNumber]];
            return YES;
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusMessage]];
            return NO;
        }
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
        return NO;
    }
}

#pragma mark - Textfield Delegate methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
    //if (textField == txtFldMobileNumber) {
    [self SetContentOffSet:textField];
   // }

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
    if ([textField.text length] == 0 && [string isEqual: @" "]) {
        return NO;
    }
    if (textField == txtFldName) {
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
    }else if (textField == txtFldMobileNumber) {
        if ([textField.text length]+[string length] < 11){
            static NSCharacterSet *charSet = nil;
            if(!charSet) {
                charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet] retain];
            }
            NSRange location = [string rangeOfCharacterFromSet:charSet];
            return (location.location == NSNotFound);
        }else return NO;
    }else if (textField == txtFldEmailId) {
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
    }else if (textField == txtFldAddressLine1) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldAddressLine2) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldLandMark) {
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - TableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag % 10 == 1){
        [self SetTableHight:aryAreaList];
        return [aryAreaList count];
    }else if (tableView.tag % 10 == 2){
        [self SetTableHight:aryCityList];
        return [aryCityList count];
    }else if (tableView.tag % 10 == 3){
        [self SetTableHight:aryStateList];
        return [aryStateList count];
    }else if (tableView.tag % 10 == 4){
        [self SetTableHight:aryCountryList];
        return [aryCountryList count];
    }else if (tableView.tag % 10 == 0){
        [self SetTableHight:aryAddressList];
        return [aryAddressList count];
    }else if (tableView.tag % 10 == 5){
        [self SetTableHight:aryDeliverySupportedArea];
        return [aryDeliverySupportedArea count];
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
    }else if (tableView.tag % 10 == 5) {
        cell.textLabel.text = [aryDeliverySupportedArea objectAtIndex:indexPath.row];
       // NSLog(@"%@", [[aryDeliverySupportedArea objectAtIndex:indexPath.row] objectForKey:key_AddressName]);
    }
    
    cell.textLabel.textAlignment = FOS_TEXTALIGNMENT;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag % 10 == 1) {
        txtFldArea.text = [[aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Name];
    }else if (tableView.tag % 10 == 2) {
        aryAreaList = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_Areas];
        txtFldCity.selectedText = [[aryCityList objectAtIndex:indexPath.row] objectForKey:key_Name];
    }else if (tableView.tag % 10 == 3) {
        aryCityList = [[aryStateList objectAtIndex:indexPath.row] objectForKey:key_Cities];
        txtFldState.selectedText = [[aryStateList objectAtIndex:indexPath.row] objectForKey:key_Name];
    }else if (tableView.tag % 10 == 4) {
        aryStateList = [[aryCountryList objectAtIndex:indexPath.row] objectForKey:key_States];
        txtFldCountry.selectedText = [[aryCountryList objectAtIndex:indexPath.row] objectForKey:key_Name];
        if (aryCountryList.count > 1) {
            txtFldState.selectedText = @"";
            txtFldCity.selectedText = @"";
            txtFldArea.text = @"";
        }
    }else if (tableView.tag % 10 == 0) {
        txtFldAddressType.selectedText = [[aryAddressList objectAtIndex:indexPath.row] objectForKey:key_AddressName];
        strIsPrimary = [[aryAddressList objectAtIndex:indexPath.row] objectForKey:key_IsPrimary];
        [self ShowAddress:[aryAddressList objectAtIndex:indexPath.row]];
    }else if (tableView.tag % 10 == 5) {
        txtFldDeliverySupportedArea_EditView.selectedText = [aryDeliverySupportedArea objectAtIndex:indexPath.row];
        txtFldDeliverySupportedArea.selectedText = [aryDeliverySupportedArea objectAtIndex:indexPath.row];
        NSLog(@"%@", [aryDeliverySupportedArea objectAtIndex:indexPath.row]);
    }
    [tableView removeFromSuperview];
}

#pragma mark - Show Address methods
-(void)ShowAddress:(NSDictionary *)Dictionary
{
    dicAddress = Dictionary;
    NSMutableString *strAddress = [[NSMutableString alloc] init];

    txtFldAddressType.selectedText = [Dictionary objectForKey:key_AddressName];
    if(isempty([Dictionary objectForKey:key_StreetLine1])){
        [strAddress appendString:[Dictionary objectForKey:key_StreetLine1]];
        [strAddress appendString:@", "];
    }
    if(isempty([Dictionary objectForKey:key_StreetLine2])){
        [strAddress appendString:[Dictionary objectForKey:key_StreetLine2]];
        [strAddress appendString:@", "];
    }
//    if(isempty([Dictionary objectForKey:key_LandMark1])){
//        [strAddress appendString:[Dictionary objectForKey:key_LandMark1]];
//        [strAddress appendString:@", "];
//    }
    if(isempty([Dictionary objectForKey:key_Area])){
        [strAddress appendString:[Dictionary objectForKey:key_Area]];
        [strAddress appendString:@", "];
    }
    if(isempty([Dictionary objectForKey:key_City])){
        [strAddress appendString:[Dictionary objectForKey:key_City]];
        [strAddress appendString:@", "];
    }
    if(isempty([Dictionary objectForKey:key_State])){
        [strAddress appendString:[Dictionary objectForKey:key_State]];
        [strAddress appendString:@", "];
    }
    if(isempty([Dictionary objectForKey:key_Country]))
        [strAddress appendString:[Dictionary objectForKey:key_Country]];
    
    lblDeliveryAddress.text =[NSString stringWithFormat:@"%@.",strAddress];
    
    strAddressline1 = [Dictionary objectForKey:key_StreetLine1];
    strAddressLine2 = isempty([Dictionary objectForKey:key_StreetLine2])?[Dictionary objectForKey:key_StreetLine2]:@"";
    strLandmark = [Dictionary objectForKey:key_LandMark1];
    NSLog(@"%@",strLandmark);
    lblLandMark.text = strLandmark;
    strArea =  [Dictionary objectForKey:key_Area];
    strCity = [Dictionary objectForKey:key_City];
    strState = [Dictionary objectForKey:key_State];
    strCountry = [Dictionary objectForKey:key_Country];
    
    BOOL AreBothAreasSame = NO;
    for (NSString *DeliverySupportedArea in aryDeliverySupportedArea) {
        if ([DeliverySupportedArea isEqualToString:strArea]) {
            txtFldDeliverySupportedArea.selectedText = DeliverySupportedArea;
            AreBothAreasSame = YES;
            break;
        }
    }
    if (!AreBothAreasSame) {
        txtFldDeliverySupportedArea.selectedText = @"";
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_DeliveryAreaShouldbeSame_English:Alert_DeliveryAreaShouldbeSame_Arabic];
    }
}

-(void)SetValuesForLabel:(NSString *)Name :(NSString *)MobileNo :(NSString *)EmailId
{
    lblUserName.text = Name;
    lblUserEmailId.text = EmailId;
    lblUserMobileNo.text = MobileNo;
    strName = Name;
    strMobileNo = MobileNo;
    strEmail = EmailId;
}

-(void)setValuesForTextField
{
    txtFldName.text = [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_FirstName];
    txtFldMobileNumber.text = [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo];
    txtFldEmailId.text =  [[[UIConstants returnInstance] dicUserDetails] objectForKey:key_EmailID];
    
    txtFldAddressLine1.text = isempty([dicAddress objectForKey:key_StreetLine1])?[dicAddress objectForKey:key_StreetLine1]:@"";
    txtFldAddressLine2.text = isempty([dicAddress objectForKey:key_StreetLine2])?[dicAddress objectForKey:key_StreetLine2]:@"";
    txtFldLandMark.text = [dicAddress objectForKey:key_LandMark1];
    //txtFldArea.text = [dicAddress objectForKey:key_Area];
    txtFldCity.selectedText = [dicAddress objectForKey:key_City];
    txtFldState.selectedText = [dicAddress objectForKey:key_State];
    txtFldCountry.selectedText = [dicAddress objectForKey:key_Country];
    txtFldDeliverySupportedArea_EditView.selectedText = txtFldDeliverySupportedArea.selectedText;
    
}

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

#pragma mark - touch recognition method

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (viewLoginMenu.superview != nil) {
        [viewLoginMenu removeFromSuperview];
    }
    if (viewUserMenu.superview != nil) {
        [viewUserMenu removeFromSuperview];
    }
}

#pragma mark - Set table hight

-(void)SetTableHight:(NSArray *)aryData
{
    if ([aryData count] > 3) {
        tblViewDropDownList.frame = CGRectMake(tblViewDropDownList.frame.origin.x, tblViewDropDownList.frame.origin.y, tblViewDropDownList.frame.size.width, 100);
    }else{
        tblViewDropDownList.frame =  CGRectMake(tblViewDropDownList.frame.origin.x, tblViewDropDownList.frame.origin.y, tblViewDropDownList.frame.size.width, 30*[aryData count]);
    }
    
}

-(void)SetContentOffSet:(UITextField *)textfield
{
    [scrollViewCheckOut setContentOffset:CGPointMake(0, [textfield superview].frame.origin.y +textfield.frame.origin.y-10)];
}

#pragma mark -
- (IBAction)loginAction:(UIButton *)sender {
    [self OnClickLoignButton:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){ //edit profile
        [self OnClickEditProfileButton:nil];
    }else if(buttonIndex == 1){ //sign out
        [self OnClickSignOutButton:nil];
        
    }
}


- (id) getDetailsforArea:(NSString *)area withCity:(NSString *)city withState:(NSString *)state withCountry:(NSString *)country
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
    return [temparray objectAtIndex:0];
}

#pragma mark - Location Tracking Delegate Methods

-(void)GetLocationUpdate
{
    CLLocationManager *ObjLocationManager = [[[CLLocationManager alloc] init] autorelease];
    ObjLocationManager = [[CLLocationManager alloc]init];
    ObjLocationManager.delegate = self;
    ObjLocationManager.distanceFilter = kCLDistanceFilterNone;
    ObjLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([CLLocationManager locationServicesEnabled]){ 
        [ObjLocationManager startUpdatingLocation];
    }else{
        if ([[UIConstants returnInstance] isItEnglish]) {
            [[UIConstants returnInstance] ShowAlert:Alert_EnableGPS_English];
        }else{
            [[UIConstants returnInstance] ShowAlert:Alert_EnableGPS_Arabic];
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coordinates = [newLocation coordinate];
    NSLog(@"Latitude:%@, Longitude: %@", [NSString stringWithFormat:@"%f",coordinates.latitude],[NSString stringWithFormat:@"%f",coordinates.longitude]);
    imgViewTickShareLocation.image =[UIImage imageNamed:@"checkmarkSelection.png"];
    [[UIConstants returnInstance] setStrLatitude:[NSString stringWithFormat:@"%f",coordinates.latitude]];
    [[UIConstants returnInstance] setStrLongitude:[NSString stringWithFormat:@"%f",coordinates.longitude]];
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([[UIConstants returnInstance] isItEnglish]) {
        [[UIConstants returnInstance] ShowAlert:Alert_CannotTrackLocation_English];
    }else{
        [[UIConstants returnInstance] ShowAlert:Alert_CannotTrackLocation_Arabic];
    }
}

#pragma mark -
-(void)onClickComboSelection:(id)comboBox
{
    if(comboBox == txtFldCountry){
       aryStateList = [[aryCountryList objectAtIndex:txtFldCountry.selectedRow] objectForKey:key_States];
         txtFldState.arrDataCombo = aryStateList;
        txtFldState.selectedText = @"";
        txtFldCity.selectedText = @"";
       
    }else if(comboBox == txtFldState){
        aryCityList = [[aryStateList objectAtIndex:txtFldState.selectedRow] objectForKey:key_Cities];
        txtFldCity.arrDataCombo = aryCityList;
        txtFldCity.selectedText = @"";
        
    }else if(comboBox == txtFldCity){
        

    }else if(comboBox == txtFldDeliverySupportedArea_EditView){
        //[self OnClickSelectSupportedAreaButton_EditView:nil];
        
    }else if( comboBox == txtFldAddressType){
        //[self OnClickSelectAddressTypeButton:nil];
//        txtFldAddressType.selectedText = [[aryAddressList objectAtIndex:txtFldAddressType.selectedRow] objectForKey:key_AddressName];
        strIsPrimary = [[aryAddressList objectAtIndex:txtFldAddressType.selectedRow] objectForKey:key_IsPrimary];
        [self ShowAddress:[aryAddressList objectAtIndex:txtFldAddressType.selectedRow]];
    }else if( comboBox == txtFldDeliverySupportedArea){
        //[self OnClickSelectSupportedAreaButton:nil];
        if (![txtFldDeliverySupportedArea.selectedText isEqualToString:strArea]) {
            BOOL IsAreaAvailable = NO;
            for (NSDictionary *dic in aryAddressList) {
                if ([[dic objectForKey:key_Area] isEqualToString:txtFldDeliverySupportedArea.selectedText]) {
                    txtFldAddressType.selectedText = [dic objectForKey:key_AddressName];
                    [self ShowAddress:dic];
                    IsAreaAvailable = YES;
                    break;
                }
            }
            if (!IsAreaAvailable) {
                [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_DeliveryAreaShouldbeSameAsSelectedAddress_English:Alert_DeliveryAreaShouldbeSameAsSelectedAddress_Arabic];
                txtFldDeliverySupportedArea_EditView.selectedText = txtFldDeliverySupportedArea.selectedText;
                txtFldDeliverySupportedArea_EditView.userInteractionEnabled = NO;
                [self OnClickEditButton:nil];
            }
        }
    }
}

- (NSArray *) selectionDataForCombo:(id) comboBox
{
    if(comboBox == txtFldAddressType){
        txtFldAddressType.keyName = key_AddressName;
        return aryAddressList;
    }
    return nil;
}



@end
