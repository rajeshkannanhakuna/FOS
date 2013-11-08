//
//  ViewController.h

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHandler.h"
#import "ResponseDTO.h"
#import "FlowLogicDelegate.h"
#import "ComboBox.h"

@interface ViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    
    IBOutlet UILabel *lblHome;
    
    IBOutlet UIButton *btnChangeLanguage;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btnHomeDelivery;
    IBOutlet UIButton *btnTakeAway;
    IBOutlet UIButton *btnDropDown;
    IBOutlet UIButton *btnSearch;
    IBOutlet UIButton *btnInfo;
    IBOutlet UIButton *btnUser;
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
    
    IBOutlet UIImageView *imgViewDropDownBG;
    IBOutlet UIImageView *imgViewSwitchBG;
    IBOutlet UIView *viewDropDownBtn;
    IBOutlet UIView *viewLoginMenu;
    IBOutlet UIView *viewUserMenu;
    
    IBOutlet ComboBox  *lblCityName;
    IBOutlet UITextField *txtFldArea;
    IBOutlet UITextField *txtFldRestaurant;
    
    UITableView *tblViewList;
    UITableView *tblViewAreaList;
    NSMutableArray *aryMenuList;
    NSMutableArray *arySupportedArea;
    NSString *strCityCode;
    NSString *strAreaCode;
    NSString *strCountryCode;
    NSString *strServiceType;
    NSString *strStateCode;
    NSString *strSearchString;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;
#pragma mark - Button action methods
-(IBAction)OnClickChangeLanguageButton:(id)sender;
-(IBAction)OnClickLoginButton:(id)sender;
-(IBAction)OnClickRegisterButton:(id)sender;
-(IBAction)OnClickHomeDeliveryOrTakeAwayButton:(id)sender;
-(IBAction)OnClickDropDownButton:(id)sender;
-(IBAction)OnClickSearchButton:(id)sender;
-(IBAction)OnClickInfoButton:(id)sender;
-(IBAction)OnClickUserButton:(id)sender;
-(IBAction)OnClickChangePassword:(id)sender;
-(IBAction)OnClickEditProfileButton:(id)sender;
-(IBAction)OnClickSignOutButton:(id)sender;

#pragma mark - Other functional methods
-(void)GetSupportedCitiesList;
-(void)GetSupportedAreaList :(NSString *)AppId :(NSString *)CityId;
-(void)GetSearchResultArray:(NSString *)SearchString;
-(void)ChangeLanguageToEnglish;
-(void)ChangeLanguageToArabic;
- (void)SeparateAreaRestaurantList:(NSArray *)AryList;
- (void)SetFont;
- (void)GetRestaurantMenuList:(NSString *)RestaurantIdentifier;
- (void)SetTableHight;
@end
