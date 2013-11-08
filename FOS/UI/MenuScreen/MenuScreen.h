//
//  MenuScreen.h
//  
//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

@interface MenuScreen : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblTotalAmountName;
  
    
    IBOutlet UIButton *btnGoHome;
    IBOutlet UIButton *btnUserMenu;
    IBOutlet UILabel *lblAreaName;
    IBOutlet UILabel *lblMinOrderValue;
    IBOutlet UILabel *lblDeliveryCharge;
    IBOutlet UILabel *lblMinOrderValueText;
    IBOutlet UILabel *lblDeliveryChargeText;
    IBOutlet UILabel *lblAddress;
    IBOutlet UILabel *lblNoOfItems;
    IBOutlet UILabel *lblTotalAmount;
    
    IBOutlet UIButton *btnOrderSummary;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
    
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UITableView *tblViewMenu;
    
    IBOutlet UIView *viewLoginMenu;
    IBOutlet UIView *viewUserMenu;
    
    IBOutlet UIView *viewCartSummary;
    
    IBOutlet UIButton *btnRestaurantInfo;
    
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;
- (IBAction)OnClickGoHomeButton:(id)sender;
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
//- (void)GetMenuCategory;
@end
