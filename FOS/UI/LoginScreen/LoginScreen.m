//
//  LoginScreen.m
//  
//
//  Created by segate on 04/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "LoginScreen.h"
#import "UIConstants.h"
#import "ServiceHandler.h"
#import "LanguageConstants.h"

ServiceHandler *ObjServicehandler;
@interface LoginScreen ()

@end

@implementation LoginScreen
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
    KeepMeLoggedIn = YES;
    
    // Back or Home button loading
    // Do any additional setup after loading the view from its nib.
    
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    
    NSString *model = [[UIDevice currentDevice] model];
    NSString *word = @"Simulator";
    if ([model rangeOfString:word].location != NSNotFound) {
        txtFldUserName.text = @"jeeva@hakunamatata.in";
        txtFldPassword.text = @"jeeva@hakunamatata.in";
        
    }

    BOOL set =[[UIConstants returnInstance] isItEnglish];
    if(set){
        [self ChangeLanguageToEnglish];
       
    }else {
         [self ChangeLanguageToArabic];
    }
    
    if([[UIConstants returnInstance] isItEnglish]){
        btnRegister.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }else{
         btnRegister.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[UIConstants returnInstance] isLoginViaHome]){
        btnGoHome.hidden = NO;
        btnGoBack.hidden = YES;
    }else {
        btnGoHome.hidden = YES;
        btnGoBack.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set Fonts

-(void)SetFont
{
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    lblEmailID.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblPassword.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblShowChars.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblKeepMeLoggedIn.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblNewUser.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnRegister.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnForgotPassword.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnLogin.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:14];
    txtFldPassword.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldUserName.font = [[UIConstants returnInstance] returnArvoRegular:14];
}

#pragma mark - Button Action Methods

-(void)OnClickGoHomeButton:(id)sender
{
    [self.delegate GoHome];

}

-(void)OnClickShowCharsButton:(id)sender
{
    if ([txtFldPassword isSecureTextEntry]) {
        if ([txtFldPassword isFirstResponder]) {
            [txtFldPassword resignFirstResponder];
            txtFldPassword.secureTextEntry = NO;
            [txtFldPassword becomeFirstResponder];
        }else{
            txtFldPassword.secureTextEntry = NO;
        }
        imgViewShowPwd.image = [UIImage imageNamed:@"tick_checked.png"];
    }else{
        if ([txtFldPassword isFirstResponder]) {
            [txtFldPassword resignFirstResponder];
            txtFldPassword.secureTextEntry = YES;
            [txtFldPassword becomeFirstResponder];
        }else{
            txtFldPassword.secureTextEntry = YES;
        }
        imgViewShowPwd.image = [UIImage imageNamed:@"tick_unchecked.png"];
    }
    
}

-(void)OnClickKeepMeLoggedInButton:(id)sender
{
    if (KeepMeLoggedIn) {
        KeepMeLoggedIn = NO;
        [[UIConstants returnInstance] setKeepMeLoggedIn:KeepMeLoggedIn];
        imgViewKeepLoggedIn.image = [UIImage imageNamed:@"tick_unchecked.png"];
    }else{
        KeepMeLoggedIn = YES;
        [[UIConstants returnInstance] setKeepMeLoggedIn:KeepMeLoggedIn];
        imgViewKeepLoggedIn.image = [UIImage imageNamed:@"tick_checked.png"];
    }
}

-(void)OnClickForgotPasswordButton:(id)sender
{
    BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:(isArabic)? ForGotPwd_Arabic :@"Forgot Password?" message:(isArabic)? PleaseEnterEmail_arabic : @"Please enter your email Id." delegate:self cancelButtonTitle:(isArabic)? Send_arabic : @"Send" otherButtonTitles: (isArabic)? Cancel_Arabic :@"Cancel", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *field = [alert textFieldAtIndex:0];
    field.keyboardType = UIKeyboardTypeEmailAddress;
    field.textAlignment = FOS_TEXTALIGNMENT;
    if ([txtFldUserName.text length]>0) {
        field.text = txtFldUserName.text;
    }
    alert.tag = 1;
    [alert show];
    [alert release];
    
}

-(void)OnClickLogInButton:(id)sender
{
    int X = 150;
    [self.view endEditing:YES];
    if ([txtFldUserName.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldUserName.frame.origin.y, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [self.view addSubview:viewPopUp];
        return;
    }
    
    if ([txtFldPassword.text length] == 0) {
        viewPopUp.frame = CGRectMake(X, txtFldPassword.frame.origin.y, viewPopUp.frame.size.width, viewPopUp.frame.size.height);
        [self.view addSubview:viewPopUp];
        return;
    }
    
    if (![self validateEmail:txtFldUserName.text]) {
        [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_EmailInvalid_English:Alert_EmailInvalid_Arabic];
        txtFldUserName.text = @"";
        [txtFldUserName becomeFirstResponder];
        return;
    }
    ObjServicehandler = [[ServiceHandler alloc]init];
    if ([ObjServicehandler GetWebUserLogInAPI:txtFldUserName.text :txtFldPassword.text]) {
        if ([[[[ResponseDTO sharedInstance] DTO_UserLoginResponse] objectForKey:key_StatusCode] integerValue] == 200 ) {
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_UserLoginResponse] objectForKey:key_StatusMessage]];
            [[UIConstants returnInstance] setStrFosUserID:[[[ResponseDTO sharedInstance] DTO_UserLoginResponse] objectForKey:key_IdUser]];
            [[UIConstants returnInstance] setStrFosUserName:[[[ResponseDTO sharedInstance] DTO_UserLoginResponse] objectForKey:key_FirstName]];
            [[UIConstants returnInstance] setDicUserDetails:[[ResponseDTO sharedInstance] DTO_UserLoginResponse]];
            [[UIConstants returnInstance] setStrPassword:txtFldPassword.text];
            
            if ([[[[ResponseDTO sharedInstance] DTO_UserLoginResponse] objectForKey:key_IsMobiileNoVerfied] integerValue] == 0 ) {
                [[UIConstants returnInstance] setIsMobileNumberVerfied:NO];
            }else{
                [[UIConstants returnInstance] setIsMobileNumberVerfied:YES];
            }
            
            [self.delegate commonBack];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_UserLoginResponse] objectForKey:key_StatusMessage]];
        }
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    [ObjServicehandler release], ObjServicehandler = nil;
}
-(IBAction)OnClickRegisterHereButton:(id)sender
{
    //[[UIConstants returnInstance] setIsLoginViaHome:YES];
    [self.delegate LoadNextScreen:VIEW_REGISTER];
}

// back button action
-(void)OnClickGoBackButt:(id)sender
{
    [self.delegate commonBack];    
}
#pragma mark - Text field delegate methods
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (viewPopUp.superview != nil) {
        [viewPopUp removeFromSuperview];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text length] == 0 && [string isEqual: @" "]) {
        return NO;
    }
    if (textField == txtFldUserName) {
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
    }else if (textField == txtFldPassword) {
        if ([textField.text length]+[string length] > 60 ) {
            return NO;
        }
    }
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return YES;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtFldUserName)
        [txtFldPassword becomeFirstResponder];
    else [textField resignFirstResponder];
    return YES;
}

#pragma mark - Alert view delegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [[alertView textFieldAtIndex:0] resignFirstResponder];
            if ([[alertView textFieldAtIndex:0].text length] > 0) {
                if ([self validateEmail:[alertView textFieldAtIndex:0].text]) {
                    ObjServicehandler = [[ServiceHandler alloc] init];
                    if ([ObjServicehandler GetUserForgotPasswordPAI:[alertView textFieldAtIndex:0].text]) {
                        if ([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 1) {
                            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusDescription]];
                        }else if ([[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusCode] integerValue] == 0) {
                            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_GeneralResponse] objectForKey:key_StatusMessage]];
                        }
                    }else{
                        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
                            [[UIConstants returnInstance] ShowNoNetworkAlert];
                        }else{
                            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
                        }
                    }
                }else{
                    [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_EmailInvalid_English:Alert_EmailInvalid_Arabic];
                }
            }else{
                [self ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_EnterEmailId_English:Alert_EnterEmailId_Arabic];
            }
        }
    }else if(alertView.tag == 2){
        [self OnClickForgotPasswordButton:nil];
    }
}

#pragma mark - Change language methods

-(void)ChangeLanguageToArabic
{
    lblScreenName.text = Login_Arabic;
    lblEmailID.text = EmailId_Arabic;
    lblPassword.text = Password_Arabic;
    [btnGoBack setTitle:Back_Arabic forState:UIControlStateNormal];
    lblRequired.text = Required_Arabic;
    
    lblEmailID.textAlignment = NSTextAlignmentRight;
    lblPassword.textAlignment = NSTextAlignmentRight;
    
    txtFldUserName.textAlignment = NSTextAlignmentRight;
    txtFldPassword.textAlignment = NSTextAlignmentRight;
    
    //lblRequired.textAlignment = NSTextAlignmentRight;
    
    btnShowCharts.frame =CGRectMake(self.view.frame.size.width - btnShowCharts.frame.size.width - 25, btnShowCharts.frame.origin.y, btnShowCharts.frame.size.width, btnShowCharts.frame.size.height);
    btnKeepMeLoggedIn.frame =CGRectMake(self.view.frame.size.width - btnKeepMeLoggedIn.frame.size.width - 25, btnKeepMeLoggedIn.frame.origin.y, btnKeepMeLoggedIn.frame.size.width, btnKeepMeLoggedIn.frame.size.height);
    
    lblShowChars.text = ShowChars_Arabic;
    lblKeepMeLoggedIn.text = KeepMeLogin_Arabic;
    
    lblShowChars.textAlignment = NSTextAlignmentRight;
    lblKeepMeLoggedIn.textAlignment = NSTextAlignmentRight;
    
    lblShowChars.frame = CGRectMake(btnShowCharts.frame.origin.x, lblShowChars.frame.origin.y, lblShowChars.frame.size.width, lblShowChars.frame.size.height);
    imgViewShowPwd.frame = CGRectMake(lblShowChars.frame.origin.x + lblShowChars.frame.size.width, imgViewShowPwd.frame.origin.y, imgViewShowPwd.frame.size.width, imgViewShowPwd.frame.size.height);
    
    lblKeepMeLoggedIn.frame = CGRectMake(btnKeepMeLoggedIn.frame.origin.x, lblKeepMeLoggedIn.frame.origin.y, lblKeepMeLoggedIn.frame.size.width, lblKeepMeLoggedIn.frame.size.height);
    imgViewKeepLoggedIn.frame = CGRectMake(lblKeepMeLoggedIn.frame.origin.x + lblKeepMeLoggedIn.frame.size.width, imgViewKeepLoggedIn.frame.origin.y, imgViewKeepLoggedIn.frame.size.width, imgViewKeepLoggedIn.frame.size.height);
    
    [btnForgotPassword setTitle:ForGotPwd_Arabic forState:UIControlStateNormal];
    btnForgotPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnForgotPassword.frame = CGRectMake(self.view.frame.size.width - btnForgotPassword.frame.size.width - 25, btnForgotPassword.frame.origin.y, btnForgotPassword.frame.size.width, btnForgotPassword.frame.size.height);
    
    [btnLogin setTitle:Login_Arabic forState:UIControlStateNormal];
    lblNewUser.text = NewUser_Arabic;
    [btnRegister setTitle:RegisterHere_Arabic forState:UIControlStateNormal];
    lblNewUser.frame = CGRectMake(self.view.frame.size.width - lblNewUser.frame.origin.x - lblNewUser.frame.size.width, lblNewUser.frame.origin.y, lblNewUser.frame.size.width, lblNewUser.frame.size.height);
    btnRegister.frame = CGRectMake(self.view.frame.size.width - btnRegister.frame.origin.x - btnRegister.frame.size.width, btnRegister.frame.origin.y, btnRegister.frame.size.width, btnRegister.frame.size.height);
}

-(void)ChangeLanguageToEnglish
{
//    [btnGoBack setTitle:Back_Eng forState:UIControlStateNormal];
//    lblScreenName.text = Login_Eng;
//    lblEmailID.text = EmailId_Eng;
//    lblPassword.text = Password_Eng;
//    
//    lblEmailID.textAlignment = NSTextAlignmentLeft;
//    lblPassword.textAlignment = NSTextAlignmentLeft;
}

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}


#pragma mark - Show Alert 
-(void)ShowAlert:(NSString *)Message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[UIConstants returnInstance] isItEnglish]?Alert_English:Alert_Arabic
                                                    message:Message
                                                   delegate:self
                                          cancelButtonTitle:[[UIConstants returnInstance] isItEnglish]?OK_English:OK_Arabic
                                          otherButtonTitles: nil];
    alert.tag = 2;
    [alert show];
    [alert release];
}
@end
