//
//  RestaurantList.h

//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

@interface RestaurantList : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblServingRestaurants;
    
    IBOutlet UIView *viewList;
    
    IBOutlet UIButton *btnHome;
    IBOutlet UIButton *btnUser;
    IBOutlet UIButton *btnInfo;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    
    IBOutlet UITableView *tblViewRestaurant;
    
    NSMutableArray *aryRestaurantList;
    
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
    IBOutlet UIView *viewUserMenu;
    
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

-(IBAction)OnClickGoHomeButton:(id)sender;
-(IBAction)OnClickUserButton:(id)sender;
-(IBAction)OnClickLoginbutton:(id)sender;
-(IBAction)OnClickRegisterButton:(id)sender;


-(IBAction)OnClickChangePassword:(id)sender;
-(IBAction)OnClickEditProfileButton:(id)sender;
-(IBAction)OnClickSignOutButton:(id)sender;
-(IBAction)OnClickInfoButton:(id)sender;

-(void)SetStarRating:(UIView *)Subview :(NSDictionary *)Dic;
-(void)ChangeLanguageToArabic;
- (void)SetFont;
- (void)GetRestaurantList;
- (void)ShowAlertForExistingRestaurant :(NSDictionary *)RestaurantDetails;
@end
