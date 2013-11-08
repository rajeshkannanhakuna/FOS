//
//  SettingsScreen.m

//
//  Created by segate on 24/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "SettingsScreen.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import "ServiceHandler.h"

@interface SettingsScreen ()<UIActionSheetDelegate>
{
    ServiceHandler *objServiceHandler;
        IBOutlet UIButton *loginBtn;
}
- (IBAction)loginAction:(UIButton *)sender;
@end

@implementation SettingsScreen
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
    // Do any additional setup after loading the view from its nib.
    [self SetFont];
    [scrollViewSettings setContentSize:CGSizeMake(0, 480)];
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        [self ChangeLanguageToArabic];
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
            
    }
    
    btnResend.frame =[[UIConstants returnInstance] getFrameForLanguage:btnResend.frame withSuperViewRect:viewVerifyCode.frame];
    btnVerifyCode.frame = [[UIConstants returnInstance] getFrameForLanguage:btnVerifyCode.frame withSuperViewRect:viewVerifyCode.frame];
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[UIConstants returnInstance] strFosUserID]) {
        viewChangePassword.hidden = NO;
        loginBtn.hidden = YES;
        btnUser.hidden = NO;

        [btnUser setImage:[UIImage imageNamed:@"User_loggedIn.png"] forState:UIControlStateNormal];
        if ([[UIConstants returnInstance] isMobileNumberVerfied]) {
            viewVerifyCode.hidden = YES;
        }else{
            viewVerifyCode.hidden = NO;
        }
    }else{
        loginBtn.hidden = NO;
        btnUser.hidden = YES;
        viewChangePassword.hidden = YES;
        [btnUser setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[UIConstants returnInstance] isItEnglish]?Alert_English:Alert_Arabic message:[[UIConstants returnInstance] isItEnglish]?Alert_MustLoginSettingsScreen_English:Alert_MustLoginSettingsScreen_Arabic delegate:self cancelButtonTitle:[[UIConstants returnInstance] isItEnglish]?Login_Eng:Login_Arabic otherButtonTitles:[[UIConstants returnInstance] isItEnglish]?Cancel_Eng:Cancel_Arabic
                                  ,nil];
        [alertView show];
        [alertView release];
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
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    lblChangePassword.font = [[UIConstants returnInstance] returnArvoBold:16];
    txtFldOldPassword.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldNewPassword.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldConfirmPassword.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnSave.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:15];
    btnEditProfile.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnSignout.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    loginBtn.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
}

#pragma mark - Button Action Methods

-(void)OnClickUserButton:(id)sender
{
    if ([[UIConstants returnInstance] strFosUserID]) {
        BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
        UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:(isArabic)? UserDetails_Arabic : UserDetails_Eng delegate:self cancelButtonTitle:(isArabic)? Cancel_Arabic : Cancel_Eng destructiveButtonTitle:nil otherButtonTitles:(isArabic)? EditProfile_Arabic : EditProfile_Eng ,(isArabic)? SignOut_Arabic : SignOut_Eng, nil];

        [sheet showInView:self.view];
        
    }
}

-(void)OnClickEditProfileButton:(id)sender
{
    [self.delegate LoadNextScreen:VIEW_EDITPROFILE];
    [viewUserMenu removeFromSuperview];
}

-(void)OnClickGoHomeButton:(id)sender
{
    [self.delegate GoHome];
    [viewUserMenu removeFromSuperview];
}

-(void)OnClickSaveButton:(id)sender
{
    [self.view endEditing:YES];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    int X = 120;
    if ([txtFldOldPassword.text length] == 0){
        viewPopUp.frame = CGRectMake(X, txtFldOldPassword.frame.origin.y, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewChangePassword addSubview:viewPopUp];
        return;
    }
    
    if([txtFldNewPassword.text length] == 0){
        viewPopUp.frame = CGRectMake(X, txtFldNewPassword.frame.origin.y, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewChangePassword addSubview:viewPopUp];
        return;
    }
    
    if( [txtFldConfirmPassword.text length] == 0){
        viewPopUp.frame = CGRectMake(X, txtFldConfirmPassword.frame.origin.y, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewChangePassword addSubview:viewPopUp];
        return;
    }
    
    if ([txtFldNewPassword.text length] < 8) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_PasswordMinchar_English:Alert_PasswordMinchar_Arabic];
        txtFldNewPassword.text = @"";
        txtFldConfirmPassword.text = @"";
        [txtFldNewPassword becomeFirstResponder];
        return;
    }
        
    if (![txtFldNewPassword.text isEqualToString:txtFldConfirmPassword.text]) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_BothPasswordSame_English:Alert_BothPasswordSame_Arabic];
        txtFldNewPassword.text = @"";
        txtFldConfirmPassword.text = @"";
        [txtFldNewPassword becomeFirstResponder];
        return;
    }
    
    NSLog(@"newpassword: %@ Oldpassword: %@", txtFldOldPassword.text, [[UIConstants returnInstance] strPassword]);
    if ([txtFldOldPassword.text isEqualToString:[[UIConstants returnInstance] strPassword]]) {
        objServiceHandler = [[ServiceHandler alloc] init];
        if ([objServiceHandler GetWebUserChangePasswordAPI:[[UIConstants returnInstance] strFosUserID] :[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_EmailID] :txtFldOldPassword.text :txtFldNewPassword.text]) {
            
            [[UIConstants returnInstance] setStrPassword:txtFldNewPassword.text];
            [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_SuccessfullyUpdated_English:Alert_SuccessfullyUpdated_Arabic];
            [self.delegate commonBack];
        }else{
            if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
                [[UIConstants returnInstance] ShowNoNetworkAlert];
            }else{
                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
            }
        }
        [objServiceHandler release], objServiceHandler = nil;
    }else{
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_WrongOldPassword_English:Alert_WrongOldPassword_Arabic];
        txtFldOldPassword.text = @"";
        [txtFldOldPassword becomeFirstResponder];
    }
}

-(void)OnClickSignoutButton:(id)sender
{
    [btnUser setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    [[UIConstants returnInstance] setStrFosUserID:nil];
    [viewUserMenu removeFromSuperview];
    btnLogin.hidden = NO;
    btnUser.hidden = YES;
    [self.delegate GoHome];
}

-(void)OnClickLoignButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_LOGIN];
}

-(void)OnClickRegisterButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_REGISTER];
}

-(void)OnClickVerifyCodeButton:(id)sender
{
    [self.view endEditing:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    int X = 120;
    if ([txtFldVerificationCode.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldVerificationCode.frame.origin.y, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [viewVerifyCode addSubview:viewPopUp];
        return;

    }
    objServiceHandler = [[ServiceHandler alloc] init];
    if ([objServiceHandler GetVerifyVerificationCodeAPIwithUserID:[[UIConstants returnInstance] strFosUserID] IsGuestUser:@"0" VerificationCode:txtFldVerificationCode.text]) {
        if([[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message] rangeOfString:@"Invalid"].location != NSNotFound){
            [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
        }else{
        [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
        [[UIConstants returnInstance] setIsMobileNumberVerfied:YES];
        viewVerifyCode.hidden = YES;
        }
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    [objServiceHandler release], objServiceHandler = nil;
}

-(void)OnClickResendButton:(id)sender
{
    [self.view endEditing:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    objServiceHandler = [[ServiceHandler alloc] init];
    if ([objServiceHandler GetSendVerificationCodeAPIwithUserID:[[UIConstants returnInstance] strFosUserID] IsGuestUser:@"0" OrderId:nil]) {
        [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    [objServiceHandler release], objServiceHandler = nil;
}

#pragma mark - Change Language To Arabic

-(void)ChangeLanguageToArabic
{
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnSignout setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];
    [btnSave setTitle:(NSString *)Save_Arabic forState:UIControlStateNormal];
    
    lblScreenName.text = (NSString *)Settings_Arabic;
    lblChangePassword.text = (NSString *)ChangePassword_Arabic;
    txtFldNewPassword.placeholder = (NSString *)NewPassword_Arabic;
    txtFldConfirmPassword.placeholder = (NSString *)ConfirmPassword_Arabic;
    txtFldOldPassword.placeholder = oldpassword_arabic;
    lblChangePassword.textAlignment = FOS_TEXTALIGNMENT;
    txtFldConfirmPassword.textAlignment = FOS_TEXTALIGNMENT;
    txtFldNewPassword.textAlignment = FOS_TEXTALIGNMENT;
    txtFldOldPassword.textAlignment = FOS_TEXTALIGNMENT;
    
    [btnVerifyCode setTitle:Verify_Arabic forState:UIControlStateNormal];
    [btnResend setTitle:Resend_Arabic forState:UIControlStateNormal];
    
    txtFldVerificationCode.textAlignment = FOS_TEXTALIGNMENT;
    txtFldVerificationCode.placeholder = VerificationCode_arabic;
    lblEnterVerificationCode.textAlignment = FOS_TEXTALIGNMENT;
    lblEnterVerificationCode.text = EnterVerificationCode_Arabic;
    lblRequired.text = Required_Arabic;
    
}

#pragma mark - TextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    if (textField == txtFldVerificationCode) {
        self.view.frame = CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height);
    }else{
//        self.view.frame = CGRectMake(0, -70, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if([string isEqualToString:@""]){
        return YES;
    }
    if ([textField.text length] == 0 && [string isEqual: @" "]) {
        return NO;
    }
    if (textField == txtFldOldPassword) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldNewPassword) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }else if (textField == txtFldConfirmPassword) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == txtFldOldPassword)
        [txtFldNewPassword becomeFirstResponder];
    else if(textField == txtFldNewPassword)
        [txtFldConfirmPassword becomeFirstResponder];
    else {
        [textField resignFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    return YES;
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIConstants returnInstance] setIsLoginViaHome:NO];
        [self.delegate LoadNextScreen:VIEW_LOGIN];
    }else{
        [self.delegate loadPreviousTab];
    }
}

#pragma mark - touches method

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
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
        [self OnClickSignoutButton:nil];
        
    }
}
@end
