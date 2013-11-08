//
//  MenuItemScreen.h
//  
//
//  Created by segate on 19/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"
@interface MenuItemScreen : UIViewController<FlowLogicDelegate, UITableViewDataSource, UITableViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblTotalAmountName;
    
    
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnUserMenu;
    
    IBOutlet UILabel *lblAreaName;
    IBOutlet UILabel *lblMinOrderValue;
    IBOutlet UILabel *lblDeliveryCharge;
    IBOutlet UILabel *lblMinOrderValueText;
    IBOutlet UILabel *lblDeliveryChargeText;
    IBOutlet UILabel *lblAddress;
    IBOutlet UILabel *lblTotalAmount;
    IBOutlet UILabel *lblNoOfItem;
    IBOutlet UIButton *btnOrderSummary;
    
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
 
    IBOutlet UIView *viewLoginMenu;
    IBOutlet UIView *viewUserMenu;
    
    IBOutlet UITableView *tblViewItemList;
    IBOutlet UIView *viewCartSummary;
    
    IBOutlet UIButton *btnRestaurantInfo;
}
@property(nonatomic, retain) id<FlowLogicDelegate>delegate;
-(IBAction)OnClickGoBackButton:(id)sender;
- (IBAction)OnClickUserMenuButton:(id)sender;

- (IBAction)OnClickOrderSummaryButton:(id)sender;
- (IBAction)OnClickLoignButton:(id)sender;
- (IBAction)OnClickRegisterButton:(id)sender;
- (IBAction)OnClickEditProfileButton:(id)sender;
- (IBAction)OnClickChangePasswordButton:(id)sender;
- (IBAction)OnClickSignOutButton:(id)sender;
- (IBAction)OnClickRestaurantInfo:(id)sender;
- (void)SetFont;
-(void)ChangeLanguageToArabic;
- (void)ModifyScreenWithCorrespondingValues;
@end
