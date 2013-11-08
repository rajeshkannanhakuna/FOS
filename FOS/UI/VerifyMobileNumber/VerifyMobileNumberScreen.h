//
//  VerifyMobileNumberScreen.h

//
//  Created by segate on 24/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

@interface VerifyMobileNumberScreen : UIViewController <FlowLogicDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    
    IBOutlet UIButton *btnUserMenu;
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
    
    IBOutlet UIView *viewLoginMenu;
    IBOutlet UIView *viewUserMenu;
    
    IBOutlet UIView *viewCodeVerification;
    
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblYourMobileNoText;
    IBOutlet UILabel *lblMobileNumber;
//    IBOutlet UILabel *lblNotYetReceivedText;
    IBOutlet UILabel *lblVerificationCodeSent;
    IBOutlet UILabel *lblEnterVerificationCode;
    
    IBOutlet UIButton *btnSendVerificationCode;
    IBOutlet UIButton *btnResend;
    IBOutlet UIButton *btnVerify;
//    IBOutlet UIButton *btnResendText;
    IBOutlet UITextField *txtFldVerificationCode;
    
    IBOutlet UIImageView *imgViewTickMark;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

- (IBAction)OnClickUserMenuButton:(id)sender;
- (IBAction)OnClickGoBackButton:(id)sender;
- (IBAction)OnClickLoignButton:(id)sender;
- (IBAction)OnClickRegisterButton:(id)sender;
- (IBAction)OnClickEditProfileButton:(id)sender;
//- (IBAction)OnClickChangePasswordButton:(id)sender;
- (IBAction)OnClickSignOutButton:(id)sender;
- (IBAction)OnClickSendVerificationCodeButton:(id)sender;
- (IBAction)OnClickResendButton:(id)sender;
- (IBAction)OnClickVerifyButton:(id)sender;
//- (IBAction)OnClickResendText:(id)sender;

-(void)ChangeLanguageToArabic;

- (void)SetFont;
@end
