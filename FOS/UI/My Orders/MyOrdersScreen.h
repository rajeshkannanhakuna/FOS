//
//  MyOrdersScreen.h
//  
//
//  Created by segate on 19/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"
@interface MyOrdersScreen : UIViewController<FlowLogicDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
    
    IBOutlet UIButton *btnUserMenu;
    IBOutlet UIButton *btnGoBack;
    IBOutlet UITableView *tblViewOrderHistory;
    
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
    
    IBOutlet UIView *viewLoginMenu;
    IBOutlet UIView *viewUserMenu;
    
}
@property(nonatomic, retain) id<FlowLogicDelegate>delegate;
- (IBAction)OnClickUserMenuButton:(id)sender;
- (IBAction)OnClickGoBackButton:(id)sender;
- (IBAction)OnClickLoignButton:(id)sender;
- (IBAction)OnClickRegisterButton:(id)sender;
- (IBAction)OnClickEditProfileButton:(id)sender;
- (IBAction)OnClickChangePasswordButton:(id)sender;
- (IBAction)OnClickSignOutButton:(id)sender;
- (void)SetFont;
-(void)ChangeLanguageToArabic;
- (void)SetTabbarBadgeValue;
- (void)SetRestaurantValues;
- (void)AddItemsToExistingCart;
@end
