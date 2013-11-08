//
//  OrderSummary.h

//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

@interface OrderSummary : UIViewController<UIAlertViewDelegate, UITextFieldDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
    IBOutlet UILabel *lblRestaurantName;
    IBOutlet UILabel *lblTotalAmount;
    IBOutlet UILabel *lblDeliveryMethodText;
    IBOutlet UILabel *lblDeliveryMode;
    IBOutlet UITextField *txtFldCouponDetatil;
    IBOutlet UIButton *btnApplyCoupon;
    IBOutlet UIButton *btnEditOrder;
    
    IBOutlet UIButton *btnUserMenu;
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btnEditProfile;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnSignOut;
    IBOutlet UIButton *btnNext;
    IBOutlet UIButton *btnClearCart;

    IBOutlet UIView *viewLoginMenu;
    IBOutlet UIView *viewUserMenu;
    IBOutlet UIView *viewFooter;
    IBOutlet UIView *viewItemDetail;
    IBOutlet UIView *viewTotalAmount;
    IBOutlet UILabel *lblTaxDetail;
    IBOutlet UIView *viewItemDetailBG;
    IBOutlet UIScrollView *scrollViewCartSummary;
    IBOutlet UIView *viewOthers;
    IBOutlet UIView *viewEmptyCart;
    IBOutlet UILabel *lblEmptyCart;
    IBOutlet UILabel *lblEmptyAmount;
    IBOutlet UILabel *lblEstimatedTime;
    IBOutlet UILabel *lblEstimatedTimeText;
    IBOutlet UIImageView *imgViewDivider;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

- (IBAction)OnClickUserMenuButton:(id)sender;
- (IBAction)OnClickGoBackButton:(id)sender;
- (IBAction)OnClickNextButton:(id)sender;
- (IBAction)OnClickLoignButton:(id)sender;
- (IBAction)OnClickRegisterButton:(id)sender;
- (IBAction)OnClickEditProfileButton:(id)sender;
- (IBAction)OnClickChangePasswordButton:(id)sender;
- (IBAction)OnClickSignOutButton:(id)sender;
- (IBAction)OnClickClearCartButton:(id)sender;
- (void)OnClickTrashButton:(id)sender;
- (void)SetFont;
- (void)ChangeLanguageToArabic;
- (BOOL)InvokeAPI:(NSArray *)aryDetails;
- (IBAction)OnClickApplyCouponButton:(id)sender;
- (IBAction)OnClickEditOrderButton:(id)sender;
- (void)ModifyScreenBasedOnCartDetails;
- (UIView *)ReturnItemDetailView:(NSDictionary *)DicDetails withIndex :(int)Index;
- (UIView *)ReturnTaxLabelView :(NSDictionary *)DicTaxDetails withX :(int)positionX andY :(int)positionY;
- (UIView *)ReturnCouponView :(NSDictionary *)DicCouponDetail withX:(int)positionX andY:(int)positionY;
- (void)ClearCart;
- (void)ShowEmptyCart;
@end
