//
//  InfoScreen.h
//  
//
//  Created by segate on 04/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

@interface InfoScreen : UIViewController
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
    
    IBOutlet UIButton *btnHome;
    IBOutlet UIButton *btnList;
    IBOutlet UIButton *btnPayments;
    IBOutlet UIButton *btnWorks;
    IBOutlet UIButton *btnPrivacyPolicy;
    IBOutlet UIButton *btnSiteTermOfUse;
    IBOutlet UIButton *btnContactUs;
    
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
    IBOutlet UIView *viewUserMenu;
    
    IBOutlet UIView     *viewButtons;
    IBOutlet UIButton   *btnLogin;
    IBOutlet UIButton   *btnRegister;
    
    IBOutlet UIButton *btnBack;
    
    IBOutlet UIWebView *webViewInfo;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

#pragma mark - Button action methods

-(IBAction)OnClickHomeButton:(id)sender;
-(IBAction)OnClickListButton:(id)sender;
-(IBAction)OnClickPaymentsButton:(id)sender;
-(IBAction)OnClickWorksButton:(id)sender;
-(IBAction)OnClickPrivacyPolicyButton:(id)sender;
-(IBAction)OnClickSiteTermOfUseButton:(id)sender;
-(IBAction)OnClickContactUsButton:(id)sender;

-(IBAction)OnClickLoginButton:(id)sender;
-(IBAction)OnClickRegisterButton:(id)sender;
-(IBAction)OnClickGoBackButton:(id)sender;

-(IBAction)OnClickChangePassword:(id)sender;
-(IBAction)OnClickEditProfileButton:(id)sender;
-(IBAction)OnClickSignOutButton:(id)sender;

-(void)ChangeLanguageToEnglish;
-(void)ChangeLanguageToArabic;
- (void)SetFont;

@end
