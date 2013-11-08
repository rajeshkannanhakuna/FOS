//
//  VerifyMobileNumberScreen.m

//
//  Created by segate on 24/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "VerifyMobileNumberScreen.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import "ServiceHandler.h"

@interface VerifyMobileNumberScreen ()
{
    ServiceHandler *ObjServiceHandler;
    NSString *strUserID;
    NSString *IsGuestUser;
    NSString *strOrderID;
    BOOL IsMobileNumberVerified;
}
@end

@implementation VerifyMobileNumberScreen
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
    if(![[UIConstants returnInstance] isItEnglish]){
        [self ChangeLanguageToArabic];
        [btnLogin setTitle:Login_Arabic forState:UIControlStateNormal];
            
    }
    
    lblMobileNumber.text = [[UIConstants returnInstance] strUserMobileNo];
    btnSendVerificationCode.hidden = NO;
    btnResend.hidden = YES;
    IsMobileNumberVerified = YES;
    imgViewTickMark.hidden = YES;
    if (![[UIConstants returnInstance] isMobileNumberVerfied] && [[[UIConstants returnInstance] strUserMobileNo] isEqualToString:[[[UIConstants returnInstance] dicUserDetails] objectForKey:key_MobileNo]]) {
        IsMobileNumberVerified = NO;
        btnSendVerificationCode.hidden = YES;
        btnResend.hidden = NO;
        viewCodeVerification.hidden = NO;
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[UIConstants returnInstance] strFosUserID]) {
        [btnUserMenu setImage:[UIImage imageNamed:@"User_loggedIn.png"] forState:UIControlStateNormal];
        strUserID = [[UIConstants returnInstance] strFosUserID];
        IsGuestUser = @"0";
        strOrderID = nil;
    }else{
        [btnUserMenu setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
        strUserID = [[UIConstants returnInstance] strGuestUserID];
        IsGuestUser = @"1";
        strOrderID = [[UIConstants returnInstance] strOrderID];
    }
    txtFldVerificationCode.text = @"";
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
    lblYourMobileNoText.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblVerificationCodeSent.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblMobileNumber.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnSendVerificationCode.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnResend.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    lblEnterVerificationCode.font = [[UIConstants returnInstance]returnArvoRegular:12];
    txtFldVerificationCode.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnVerify.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:15];
    btnEditProfile.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnChangePassword.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnSignOut.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnLogin.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnRegister.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
}

# pragma  mark - Button Action Methods
- (void)OnClickGoBackButton:(id)sender
{
    [[UIConstants returnInstance] setIsBackFromPaymentOrMobileVerify:YES];
    [self.delegate GoBack:YES];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"If you go Home, all your cart details will be cleared. Do you want to continue?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
//    [alert show];
//    [alert release];
}

-(void)OnClickChangePasswordButton:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadTabBar:4];
}

-(void)OnClickEditProfileButton:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadNextScreen:VIEW_EDITPROFILE];
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

-(void)OnClickSignOutButton:(id)sender
{
     [[UIConstants returnInstance] setStrFosUserID:nil];
    [btnUserMenu setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    [viewUserMenu removeFromSuperview];
}

-(void)OnClickUserMenuButton:(id)sender
{
    if ([[UIConstants returnInstance] strFosUserID]) {
        if (viewUserMenu.superview == nil) {
            viewUserMenu.frame = CGRectMake(self.view.frame.size.width - viewUserMenu.frame.size.width-5, btnUserMenu.frame.origin.y + btnUserMenu.frame.size.height + 8, viewUserMenu.frame.size.width, viewUserMenu.frame.size.height);
            [self.view addSubview:viewUserMenu];
        }else{
            [viewUserMenu removeFromSuperview];
        }
    }else{
        if (viewLoginMenu.superview  == nil) {
            viewLoginMenu.frame = CGRectMake(self.view.frame.size.width - viewLoginMenu.frame.size.width-5, btnUserMenu.frame.origin.y + btnUserMenu.frame.size.height + 8, viewLoginMenu.frame.size.width, viewLoginMenu.frame.size.height);
            [self.view addSubview:viewLoginMenu];
        }else {
            [viewLoginMenu removeFromSuperview];
        }
    }
}

-(void)OnClickSendVerificationCodeButton:(id)sender
{
    [self.view endEditing:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetSendVerificationCodeAPIwithUserID:strUserID IsGuestUser:IsGuestUser OrderId:strOrderID]) {
        if([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 200) {
            viewCodeVerification.hidden = NO;
            lblVerificationCodeSent.text = [[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message];
            imgViewTickMark.hidden = NO;
            btnSendVerificationCode.hidden = YES;
            btnResend.hidden = NO;
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
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

-(void)OnClickResendButton:(id)sender
{
    [self.view endEditing:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetSendVerificationCodeAPIwithUserID:strUserID IsGuestUser:IsGuestUser OrderId:strOrderID]) {
        if([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 200) {
            lblVerificationCodeSent.text = [[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message];
            imgViewTickMark.hidden = NO;
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
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

-(void)OnClickVerifyButton:(id)sender
{
    [self.view endEditing:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    if ([txtFldVerificationCode.text length] == 0) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance]isItEnglish]?@"Please enter verfication code.":EnterVerificationCode_Arabic];
        return;
    }
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetVerifyVerificationCodeAPIwithUserID:strUserID IsGuestUser:IsGuestUser VerificationCode:txtFldVerificationCode.text]) {
        if([[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Status] integerValue] == 0){
            [[UIConstants returnInstance] ShowAlert:[[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_OtpVerification] objectForKey:key_Message]];
        }else{
            if (!IsMobileNumberVerified) {
                [[UIConstants returnInstance] setIsMobileNumberVerfied:YES];
            }
            [self.delegate LoadNextScreen:VIEW_PAYMENTGATEWAY];
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
#pragma mark - Text field delegate methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text length] == 0 && [string isEqual: @" "]) {
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Change Language To Arabic
-(void)ChangeLanguageToArabic
{
    //[btnGoBack setTitle:(NSString *)Back_Arabic forState:UIControlStateNormal];
    [btnLogin setTitle:(NSString *)Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];
    
    lblScreenName.text = (NSString *)VerifyMobileNumber_Arabic;
    
    lblYourMobileNoText.text = (NSString *)YourMobileNumber_Arabic;
    [btnSendVerificationCode setTitle:(NSString *)SendVerificationCode_Arabic forState:UIControlStateNormal];
    [btnResend setTitle:(NSString *)Resend_Arabic forState:UIControlStateNormal];
//    [btnResendText setTitle:(NSString *)Resend_Arabic forState:UIControlStateNormal];
//    lblNotYetReceivedText.text = (NSString *)NotYetReceived_Arabic;
    
    lblYourMobileNoText.textAlignment = NSTextAlignmentRight;
    lblMobileNumber.textAlignment = NSTextAlignmentRight;
//    lblNotYetReceivedText.textAlignment = NSTextAlignmentRight;
//    btnResendText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    btnSendVerificationCode.frame = CGRectMake(self.view.frame.size.width - btnSendVerificationCode.frame.origin.x - btnSendVerificationCode.frame.size.width, btnSendVerificationCode.frame.origin.y, btnSendVerificationCode.frame.size.width, btnSendVerificationCode.frame.size.height);
    btnResend.frame = CGRectMake(self.view.frame.size.width - btnResend.frame.origin.x - btnResend.frame.size.width, btnResend.frame.origin.y, btnResend.frame.size.width, btnResend.frame.size.height);
//    lblNotYetReceivedText.frame = CGRectMake(self.view.frame.size.width - lblNotYetReceivedText.frame.origin.x - lblNotYetReceivedText.frame.size.width, lblNotYetReceivedText.frame.origin.y, lblNotYetReceivedText.frame.size.width, lblNotYetReceivedText.frame.size.height);
//    btnResendText.frame = CGRectMake(self.view.frame.size.width - btnResendText.frame.origin.x - btnResendText.frame.size.width, btnResendText.frame.origin.y, btnResendText.frame.size.width, btnResendText.frame.size.height);
//    
    lblVerificationCodeSent.text = (NSString *)VerificationCodeSentSuccess_Arabic;
    lblEnterVerificationCode.text = (NSString *)EnterVerificationCode_Arabic;
    [btnVerify setTitle:(NSString *)Verify_Arabic forState:UIControlStateNormal];
    
    lblVerificationCodeSent.frame = CGRectMake(self.view.frame.size.width - lblVerificationCodeSent.frame.origin.x - lblVerificationCodeSent.frame.size.width, lblVerificationCodeSent.frame.origin.y, lblVerificationCodeSent.frame.size.width, lblVerificationCodeSent.frame.size.height);
    
    imgViewTickMark.frame = CGRectMake(self.view.frame.size.width - imgViewTickMark.frame.origin.x - imgViewTickMark.frame.size.width, imgViewTickMark.frame.origin.y, imgViewTickMark.frame.size.width, imgViewTickMark.frame.size.height);
    
    lblVerificationCodeSent.textAlignment = NSTextAlignmentRight;
    lblEnterVerificationCode.textAlignment = NSTextAlignmentRight;
    txtFldVerificationCode.textAlignment = NSTextAlignmentRight;
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

#pragma mark - Alert View delegate Methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIConstants returnInstance] setAryCartDetails:nil];
        [self.delegate GoHome];
    }
}


@end
