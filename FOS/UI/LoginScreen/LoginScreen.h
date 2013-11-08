//
//  LoginScreen.h
//  
//
//  Created by segate on 04/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

@interface LoginScreen : UIViewController<UIAlertViewDelegate, UITextFieldDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblEmailID;
    IBOutlet UILabel *lblPassword;
    IBOutlet UILabel *lblShowChars;
    IBOutlet UILabel *lblKeepMeLoggedIn;
    IBOutlet UILabel *lblNewUser;
    IBOutlet UIButton *btnGoHome;
    IBOutlet UIButton *btnShowCharts;
    IBOutlet UIButton *btnKeepMeLoggedIn;
    IBOutlet UIButton *btnForgotPassword;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UITextField *txtFldUserName;
    IBOutlet UITextField *txtFldPassword;
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIImageView *imgViewShowPwd;
    IBOutlet UIImageView *imgViewKeepLoggedIn;
    BOOL KeepMeLoggedIn;
    
    IBOutlet UIView *viewPopUp;
    IBOutlet UILabel *lblRequired;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

#pragma mark - Button Action Methods

-(IBAction)OnClickGoHomeButton:(id)sender;
-(IBAction)OnClickShowCharsButton:(id)sender;
-(IBAction)OnClickKeepMeLoggedInButton:(id)sender;
-(IBAction)OnClickForgotPasswordButton:(id)sender;
-(IBAction)OnClickLogInButton:(id)sender;
-(IBAction)OnClickRegisterHereButton:(id)sender;
-(IBAction)OnClickGoBackButt:(id)sender;
-(void)ChangeLanguageToEnglish;
-(void)ChangeLanguageToArabic;
-(void)ShowAlert:(NSString *)Message;
-(void)SetFont;
@end
