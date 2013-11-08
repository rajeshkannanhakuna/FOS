//
//  ItemDetailScreen.h
//  
//
//  Created by segate on 20/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"
@interface ItemDetailScreen : UIViewController<UITextFieldDelegate, UITextViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblNameOfItem;
    IBOutlet UILabel *lblDetails;
    
    IBOutlet UIImageView *imgViewItem;
    IBOutlet UIImageView *imgViewQuantityBG;
    
    IBOutlet UILabel *lblQuantityName;
    IBOutlet UILabel *lblRsName;
    IBOutlet UILabel *lblAmountName;
    
    IBOutlet UIButton *btnUserMenu;
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
    
    IBOutlet UIView *viewLoginMenu;
    IBOutlet UIView *viewUserMenu;
    
    IBOutlet UIButton *btnPlusQuantity;
    IBOutlet UIButton *btnMinusQuantity;
    IBOutlet UITextField *txtFldQuantity;
    IBOutlet UILabel *lblAmountForQuantity;
    
    IBOutlet UIButton *btnAddToCart;
    IBOutlet UILabel *lblTotalAmount;
    
    IBOutlet UIView *viewMinusButton;
    IBOutlet UIView *viewPlusButton;
    IBOutlet UITextView *txtViewCustomizeDish;
    
    IBOutlet UIView *viewFooter;
    IBOutlet UIScrollView *scrollViewItemDetails;
    
}
@property (nonatomic, retain)id<FlowLogicDelegate>delegate;
//@property (nonatomic, retain)UITextField *txtFldQuantity;
- (IBAction)OnClickUserMenuButton:(id)sender;
- (IBAction)OnClickGoBackButton:(id)sender;
- (IBAction)OnClickLoignButton:(id)sender;
- (IBAction)OnClickRegisterButton:(id)sender;
- (IBAction)OnClickEditProfileButton:(id)sender;
- (IBAction)OnClickChangePasswordButton:(id)sender;
- (IBAction)OnClickSignOutButton:(id)sender;
- (IBAction)OnClickPlusQuantityButton:(id)sender;
- (IBAction)OnClickMinusQuantityButton:(id)sender;
- (IBAction)OnClickAddToCartButton:(id)sender;

-(void)SetFont;
-(void)ChangeLanguageToArabic;
- (void)ModifyScreen;
//-(void)KeyBoardWillShow:(NSNotification *)notification;
//-(void)OnClickDoneButton;

-(UIView *)ReturnGroupView :(NSDictionary *)_dicItemDetails;
- (void)OnClickSelectItemTypeButton:(id)Sender;
- (void)SetLabelValues :(NSDictionary *)_dicItemDetails;
- (UIView *)ReturnMenuView :(NSDictionary *)_dicCustomMenu :(int)Index;
- (UIView *)ReturnMenuItemView :(NSArray *)aryMenuItemList :(int)Index :(BOOL)IsItMultiSelect;
- (UIView *)ReturnMenuItem :(int)PositionX :(int)PositionY :(NSString *)NameOfItem :(BOOL)IsItMultiSelect :(NSString *)IdentifierItem;
- (void)OnClickDropDownMenuButton :(id)Sender;
- (void)OnClickMenuItem :(id)Sender;
- (NSMutableArray *)SortArrayBasedOnOrderByGroupforArray :(NSMutableArray *)aryForSorting;
- (BOOL)CompareExistingItem: (NSDictionary *)ExistingDic withNewOne :(NSDictionary *)NewDic;
@end
