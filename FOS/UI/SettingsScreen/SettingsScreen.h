//
//  SettingsScreen.h

//
//  Created by segate on 24/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"
@interface SettingsScreen : UIViewController<FlowLogicDelegate,UITextFieldDelegate, UIAlertViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UIView *viewChangePassword;
    IBOutlet UIButton *btnHome;
//    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnUser;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnEnglish;
    IBOutlet UIButton *btnArabic;
    
    IBOutlet UITextField *txtFldOldPassword;
    IBOutlet UITextField *txtFldNewPassword;
    IBOutlet UITextField *txtFldConfirmPassword;
    
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnSignout;
    
    IBOutlet UIView *viewUserMenu;
    
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblChangePassword;
    
    IBOutlet UIView *viewPopUp;
    IBOutlet UILabel *lblRequired;
    
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIView *viewLoginMenu;
    
    IBOutlet UIView         *viewVerifyCode;
    IBOutlet UILabel        *lblEnterVerificationCode;
    IBOutlet UITextField    *txtFldVerificationCode;
    IBOutlet UIButton       *btnVerifyCode;
    
    IBOutlet UIScrollView *scrollViewSettings;
    IBOutlet UIButton *btnResend;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;
- (IBAction)OnClickGoHomeButton:(id)sender;
- (IBAction)OnClickUserButton:(id)sender;
- (IBAction)OnClickSaveButton:(id)sender;
- (IBAction)OnClickEditProfileButton:(id)sender;
- (IBAction)OnClickSignoutButton:(id)sender;
- (IBAction)OnClickLoignButton:(id)sender;
- (IBAction)OnClickRegisterButton:(id)sender;
- (IBAction)OnClickVerifyCodeButton:(id)sender;
- (IBAction)OnClickResendButton:(id)sender;
- (void)SetFont;
- (void)ChangeLanguageToArabic;
@end
