//
//  InfoScreen.m
//  
//
//  Created by segate on 04/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "InfoScreen.h"
#import "APIConstants.h"
#import "UIConstants.h"
#import "LanguageConstants.h"

@interface InfoScreen ()<UIActionSheetDelegate>
{
    IBOutlet UIButton *loginBtn;
}
- (IBAction)loginAction:(UIButton *)sender;
@end

@implementation InfoScreen
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
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[UIConstants returnInstance] strFosUserID]) {
        loginBtn.hidden = YES;
        btnList.hidden = NO;
        [btnList setImage:[UIImage imageNamed:@"User_loggedIn.png"] forState:UIControlStateNormal];
    }else{
        loginBtn.hidden = NO;
        btnList.hidden = YES;
        [btnList setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
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
    btnChangePassword.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnSignOut.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    loginBtn.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnRegister.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    
    btnBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnPayments.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnWorks.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnPrivacyPolicy.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnSiteTermOfUse.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnContactUs.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    
}

#pragma mark - Button Action methods

-(void)OnClickHomeButton:(id)sender
{
    [self.delegate GoHome];
}

-(void)OnClickListButton:(id)sender
{
    if ([[UIConstants returnInstance] strFosUserID]) {
        
        BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
        UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:(isArabic)? UserDetails_Arabic : UserDetails_Eng delegate:self cancelButtonTitle:(isArabic)? Cancel_Arabic : Cancel_Eng destructiveButtonTitle:nil otherButtonTitles:(isArabic)? EditProfile_Arabic : EditProfile_Eng ,(isArabic)? SignOut_Arabic : SignOut_Eng, nil];

        [sheet showInView:self.view];

//        viewUserMenu.frame = CGRectMake(self.view.frame.size.width - viewUserMenu.frame.size.width-5, btnList.frame.origin.y + btnList.frame.size.height + 8, viewUserMenu.frame.size.width, viewUserMenu.frame.size.height);
//        if (viewUserMenu.superview == nil) {
//            [self.view addSubview:viewUserMenu];
//        }else{
//            [viewUserMenu removeFromSuperview];
//        }
//    }else{
//        viewButtons.frame = CGRectMake(self.view.frame.size.width - viewButtons.frame.size.width-5, btnList.frame.origin.y + btnList.frame.size.height + 8, viewButtons.frame.size.width, viewButtons.frame.size.height);
//        if (viewButtons.superview  == nil) {
//            [self.view addSubview:viewButtons];
//        }else {
//            [viewButtons removeFromSuperview];
//        }
    }
}

-(void)OnClickContactUsButton:(id)sender
{
    if ([webViewInfo isHidden]) {
        btnHome.hidden = YES;
        btnBack.hidden = NO;
        webViewInfo.hidden = NO;
        NSString *urlAddress = [NSString stringWithFormat:@"%@%@", URL_Base,URL_ContactUs];
                NSLog(@"%@", urlAddress);
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webViewInfo loadRequest:requestObj];
        if (viewButtons.superview != nil) {
            [viewButtons removeFromSuperview];
        }
        if (viewUserMenu.superview != nil) {
            [viewUserMenu removeFromSuperview];
        }
    }
}

-(void)OnClickPaymentsButton:(id)sender
{
    if ([webViewInfo isHidden]) {
        btnHome.hidden = YES;
        btnBack.hidden = NO;
        webViewInfo.hidden = NO;
        NSString *urlAddress = [NSString stringWithFormat:@"%@%@", URL_Base,URL_AboutPayment];
                NSLog(@"%@", urlAddress);
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webViewInfo loadRequest:requestObj];
        if (viewButtons.superview != nil) {
            [viewButtons removeFromSuperview];
        }
        if (viewUserMenu.superview != nil) {
            [viewUserMenu removeFromSuperview];
        }
    }
}

-(void)OnClickPrivacyPolicyButton:(id)sender
{
    if ([webViewInfo isHidden]) {
        btnHome.hidden = YES;
        btnBack.hidden = NO;
        webViewInfo.hidden = NO;
        NSString *urlAddress = [NSString stringWithFormat:@"%@%@", URL_Base,URL_Privacy];
                NSLog(@"%@", urlAddress);
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webViewInfo loadRequest:requestObj];
        if (viewButtons.superview != nil) {
            [viewButtons removeFromSuperview];
        }
        if (viewUserMenu.superview != nil) {
            [viewUserMenu removeFromSuperview];
        }
    }
}

-(void)OnClickSiteTermOfUseButton:(id)sender
{
    if ([webViewInfo isHidden]) {
        btnHome.hidden = YES;
        btnBack.hidden = NO;
        webViewInfo.hidden = NO;
        NSString *urlAddress = [NSString stringWithFormat:@"%@%@", URL_Base,URL_TermsOfUse];
        NSLog(@"%@", urlAddress);
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webViewInfo loadRequest:requestObj];
        if (viewButtons.superview != nil) {
            [viewButtons removeFromSuperview];
        }
        if (viewUserMenu.superview != nil) {
            [viewUserMenu removeFromSuperview];
        }
    }
}

-(void)OnClickWorksButton:(id)sender
{
    if ([webViewInfo isHidden]) {
        btnHome.hidden = YES;
        btnBack.hidden = NO;
        webViewInfo.hidden = NO;
        NSString *urlAddress = [NSString stringWithFormat:@"%@%@", URL_Base,URL_HowItWorks];
        NSLog(@"%@", urlAddress);
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webViewInfo loadRequest:requestObj];
        if (viewButtons.superview != nil) {
            [viewButtons removeFromSuperview];
        }
        if (viewUserMenu.superview != nil) {
            [viewUserMenu removeFromSuperview];
        }
    }
}

-(void)OnClickLoginButton:(id)sender
{
    [viewButtons removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_LOGIN];
}

-(void)OnClickRegisterButton:(id)sender
{
    [viewButtons removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_REGISTER];
}

-(void)OnClickGoBackButton:(id)sender
{
    if (![webViewInfo isHidden]) {
        NSURL *url = [NSURL URLWithString:@""];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webViewInfo loadRequest:requestObj];
        webViewInfo.hidden = YES;
        btnBack.hidden = YES;
        btnHome.hidden = NO;
        if (viewButtons.superview != nil) {
            [viewButtons removeFromSuperview];
        }
        if (viewUserMenu.superview != nil) {
            [viewUserMenu removeFromSuperview];
        }
    }
}

-(void)OnClickEditProfileButton:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadNextScreen:VIEW_EDITPROFILE];
}

-(void)OnClickChangePassword:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadTabBar:4];
}

-(void)OnClickSignOutButton:(id)sender
{
    [[UIConstants returnInstance] setStrFosUserID:nil];
    [btnList setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    [viewUserMenu removeFromSuperview];
    loginBtn.hidden = NO;
    btnList.hidden = YES;
}

#pragma  mark - Change Language Methods

-(void)ChangeLanguageToArabic
{
    lblScreenName.text = (NSString *)About_Arabic;
    
    [btnLogin setTitle:(NSString *)Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];

    btnPayments.frame = CGRectMake(self.view.frame.size.width - btnPayments.frame.size.width - btnPayments.frame.origin.x, btnPayments.frame.origin.y, btnPayments.frame.size.width, btnPayments.frame.size.height);
    btnWorks.frame = CGRectMake(self.view.frame.size.width - btnWorks.frame.size.width - btnWorks.frame.origin.x, btnWorks.frame.origin.y, btnWorks.frame.size.width, btnWorks.frame.size.height);
    btnPrivacyPolicy.frame = CGRectMake(self.view.frame.size.width - btnPrivacyPolicy.frame.size.width - btnPrivacyPolicy.frame.origin.x, btnPrivacyPolicy.frame.origin.y, btnPrivacyPolicy.frame.size.width, btnPrivacyPolicy.frame.size.height);
    btnSiteTermOfUse.frame = CGRectMake(self.view.frame.size.width - btnSiteTermOfUse.frame.size.width - btnSiteTermOfUse.frame.origin.x, btnSiteTermOfUse.frame.origin.y, btnSiteTermOfUse.frame.size.width, btnSiteTermOfUse.frame.size.height);
    btnContactUs.frame = CGRectMake(self.view.frame.size.width - btnContactUs.frame.size.width - btnContactUs.frame.origin.x, btnContactUs.frame.origin.y, btnContactUs.frame.size.width, btnContactUs.frame.size.height);
    
    btnPayments.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnWorks.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnPrivacyPolicy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnSiteTermOfUse.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnContactUs.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    [btnPayments setTitle:(NSString *)AboutPayments_Arabic forState:UIControlStateNormal];
    [btnWorks setTitle:(NSString *)AboutWorks_Arabic forState:UIControlStateNormal];
    [btnPrivacyPolicy setTitle:(NSString *)AboutPrivacyPolicy_Arabic forState:UIControlStateNormal];
    [btnSiteTermOfUse setTitle:(NSString *)AboutTermsOfUse_Arabic forState:UIControlStateNormal];
    [btnContactUs setTitle:(NSString *)AboutContactUs_Arabic forState:UIControlStateNormal];
    [btnBack setTitle:(NSString *)Back_Arabic forState:UIControlStateNormal];
    
}

-(void)ChangeLanguageToEnglish
{
    [btnLogin setTitle:(NSString *)Login_Eng forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Eng forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Eng forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Eng forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Eng forState:UIControlStateNormal];
    
    btnPayments.frame = CGRectMake( 30, btnPayments.frame.origin.y, btnPayments.frame.size.width, btnPayments.frame.size.height);
    btnWorks.frame = CGRectMake( 30, btnWorks.frame.origin.y, btnWorks.frame.size.width, btnWorks.frame.size.height);
    btnPrivacyPolicy.frame = CGRectMake( 30, btnPrivacyPolicy.frame.origin.y, btnPrivacyPolicy.frame.size.width, btnPrivacyPolicy.frame.size.height);
    btnSiteTermOfUse.frame = CGRectMake( 30, btnSiteTermOfUse.frame.origin.y, btnSiteTermOfUse.frame.size.width, btnSiteTermOfUse.frame.size.height);
    btnContactUs.frame = CGRectMake(30, btnContactUs.frame.origin.y, btnContactUs.frame.size.width, btnContactUs.frame.size.height);
    
    btnPayments.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnWorks.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnPrivacyPolicy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnSiteTermOfUse.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnContactUs.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    [btnPayments setTitle:(NSString *)AboutPayments_Eng forState:UIControlStateNormal];
    [btnWorks setTitle:(NSString *)AboutWorks_Eng forState:UIControlStateNormal];
    [btnPrivacyPolicy setTitle:(NSString *)AboutPrivacyPolicy_Eng forState:UIControlStateNormal];
    [btnSiteTermOfUse setTitle:(NSString *)AboutTermsOfUse_Eng forState:UIControlStateNormal];
    [btnContactUs setTitle:(NSString *)AboutContactUs_Eng forState:UIControlStateNormal];
}

#pragma mark - touch recognition method

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (viewButtons.superview != nil) {
        [viewButtons removeFromSuperview];
    }
    if (viewUserMenu.superview != nil) {
        [viewUserMenu removeFromSuperview];
    }
}


#pragma mark -
- (IBAction)loginAction:(UIButton *)sender {
    [self OnClickLoginButton:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){ //edit profile
        [self OnClickEditProfileButton:nil];
    }else if(buttonIndex == 1){ //sign out
        [self OnClickSignOutButton:nil];
        
    }
}


@end
