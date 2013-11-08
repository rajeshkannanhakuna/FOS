//
//  OrderSummary.m

//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "OrderSummary.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import "APIConstants.h"
#import "ServiceHandler.h"
#import <QuartzCore/QuartzCore.h>

#define isempty(_x_)   _x_ != [NSNull null] && _x_ != Nil && ![_x_ isEqualToString:@""]

@interface OrderSummary ()<UIActionSheetDelegate>
{
    ServiceHandler *ObjServiceHandler;
    NSMutableArray *aryCouponDetail;
      IBOutlet UIButton *loginBtn;
    IBOutlet UILabel *_lblTotalAmountValue;
}
- (IBAction)loginAction:(UIButton *)sender;
@end

@implementation OrderSummary
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetFont];
    aryCouponDetail = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        [self ChangeLanguageToArabic];
        
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
        
    }
    viewItemDetailBG.layer.masksToBounds = YES;
    viewItemDetailBG.layer.cornerRadius = 3;
    viewItemDetailBG.layer.borderColor = [UIColor lightGrayColor].CGColor;
    viewItemDetailBG.layer.borderWidth = 1;
    
    lblRestaurantName.font = [UIFont fontWithName:@"Arvo-Bold" size:14];
  //  viewFooter.hidden = YES;
    if ([[[UIConstants returnInstance]strServiceType] isEqual: @"H"]) {
        if(![[UIConstants returnInstance] isItEnglish]){
            lblDeliveryMode.text = HomeDelivery_Arabic;
             lblTotalAmount.text = TotalAmount_Arabic;
 		lblEstimatedTimeText.text = EstimatedTimeDelivery_Arabic;
            
        }else{
            lblDeliveryMode.text = @"Home Delivery";
             lblTotalAmount.text = TotalAmount_Eng;
            lblEstimatedTimeText.text = EstimatedTimeDelivery_English;
        }
      
        lblEstimatedTime.text = [[UIConstants returnInstance] strMaxDeliveryTime];
    }else{
        if(![[UIConstants returnInstance] isItEnglish]){
            lblDeliveryMode.text = TakeAway_Arabic;
            lblTotalAmount.text = TotalAmount_Arabic;
            lblEstimatedTimeText.text = MinimumPreparationTime_Arabic;
        }
        else{
            lblDeliveryMode.text = @"Take Away";
            lblTotalAmount.text = TotalAmount_Eng;
            lblEstimatedTimeText.text = MinimumPreparationTime_English;
        }
        lblEstimatedTime.text = [[UIConstants returnInstance] strMinPreparationTime];
    }
   // lblRestaurantName.text = [[[[UIConstants returnInstance] aryOrderedRestaurantsList] objectAtIndex:0] objectForKey:key_RestaurantName];
    
    
    // set the frame
    UIConstants *constant = [UIConstants returnInstance];
    lblRestaurantName.frame = [constant getFrameForLanguage:lblRestaurantName.frame withSuperViewRect:self.view.frame];
    btnEditOrder.frame = [constant getFrameForLanguage:btnEditOrder.frame withSuperViewRect:self.view.frame];
    txtFldCouponDetatil.frame = [constant getFrameForLanguage:txtFldCouponDetatil.frame withSuperViewRect:scrollViewCartSummary.frame];
    
    btnApplyCoupon.frame = [constant getFrameForLanguage:btnApplyCoupon.frame withSuperViewRect:scrollViewCartSummary.frame];
    
    lblDeliveryMethodText.frame = [constant getFrameForLanguage:lblDeliveryMethodText.frame withSuperViewRect:scrollViewCartSummary.frame];
    lblDeliveryMode.frame = [constant getFrameForLanguage:lblDeliveryMode.frame withSuperViewRect:scrollViewCartSummary.frame];
    lblEstimatedTimeText.frame = [constant getFrameForLanguage:lblEstimatedTimeText.frame withSuperViewRect:scrollViewCartSummary.frame];
    lblEstimatedTime.frame = [constant getFrameForLanguage:lblEstimatedTime.frame withSuperViewRect:scrollViewCartSummary.frame];
    lblTotalAmount.frame = [constant getFrameForLanguage:lblTotalAmount.frame withSuperViewRect:scrollViewCartSummary.frame];
    _lblTotalAmountValue.frame = [constant getFrameForLanguage:_lblTotalAmountValue.frame withSuperViewRect:scrollViewCartSummary.frame];
//    
    lblRestaurantName.textAlignment = FOS_TEXTALIGNMENT;
    lblDeliveryMethodText.textAlignment = FOS_TEXTALIGNMENT;
    lblDeliveryMode.textAlignment = FOS_TEXTALIGNMENT;
    lblEstimatedTimeText.textAlignment = FOS_TEXTALIGNMENT;
    lblEstimatedTime.textAlignment = FOS_TEXTALIGNMENT;
    _lblTotalAmountValue.textAlignment = FOS_TEXTALIGNMENT;
    lblTotalAmount.textAlignment = FOS_TEXTALIGNMENT;

    
    //set text
    
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
//    for (UIView *_viewTemp in [viewItemDetailBG subviews]) {
//        if (_viewTemp.tag == 10 || _viewTemp.tag == 20) {
//            [_viewTemp removeFromSuperview];
//        }
//    }
    [[UIConstants returnInstance] setIsComingForEditing:NO];
    if ([[[UIConstants returnInstance] aryCartDetails] count] > 0) {
        [self InvokeAPI:[[UIConstants returnInstance] aryOrderedRestaurantsList]];
    }else{
        [self ShowEmptyCart];
    }
    
    if ([[UIConstants returnInstance] strFosUserID]) {
        loginBtn.hidden = YES;
        btnUserMenu.hidden = NO;
        [btnUserMenu setImage:[UIImage imageNamed:@"User_loggedIn.png"] forState:UIControlStateNormal];
    }else{
        loginBtn.hidden = NO;
        btnUserMenu.hidden = YES;
        [btnUserMenu setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set Font

-(void)SetFont
{
    btnEditProfile.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnChangePassword.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnSignOut.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    loginBtn.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnRegister.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    lblRestaurantName.font = [[UIConstants returnInstance] returnArvoBold:14];
    lblEmptyCart.font = [[UIConstants returnInstance] returnArvoRegular:15];
    lblEmptyAmount.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblTotalAmount.font = [[UIConstants returnInstance] returnArvoRegular:16];
    _lblTotalAmountValue.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblDeliveryMethodText.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblDeliveryMode.font = [[UIConstants returnInstance] returnArvoBold:14];
    lblEstimatedTime.font = [[UIConstants returnInstance] returnArvoBold:14];
    lblTaxDetail.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblEstimatedTimeText.font = [[UIConstants returnInstance] returnArvoRegular:12];
    
    txtFldCouponDetatil.font = [[UIConstants returnInstance] returnArvoRegular:16];
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnApplyCoupon.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnEditOrder.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnClearCart.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnNext.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
}

-(void)ModifyScreenBasedOnCartDetails
{
    for (UIView *_viewTemp in [viewItemDetailBG subviews]) {
        if (_viewTemp.tag == 10 || _viewTemp.tag == 20 || _viewTemp.tag == 30) {
            [_viewTemp removeFromSuperview];
        }
    }
    if ([[[UIConstants returnInstance] aryCartDetails] count] > 0) {
        viewFooter.hidden = NO;
        if (viewEmptyCart.superview != nil) {
            [viewEmptyCart removeFromSuperview];
        }
        scrollViewCartSummary.hidden = NO;
        if ([[UIConstants returnInstance] IsComingViaMyOrders]) {
            btnEditOrder.hidden = YES;
        }else{
            btnEditOrder.hidden = NO;
        }

        
        NSLog(@"Count: %i",[[[UIConstants returnInstance] aryCartDetails] count]);
        lblRestaurantName.text = [[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_RestaurantName];
        int lblCount = [[[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_RestaurantTaxes] count] + [[[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_CouponDiscount] count];
        NSLog(@"Count: %i , %i",[[[UIConstants returnInstance] aryCartDetails] count], lblCount);
//        CGRect rectItemDetailBG = viewItemDetailBG.frame;
//        rectItemDetailBG.size.height =
        
        viewItemDetailBG.frame = CGRectMake(viewItemDetailBG.frame.origin.x, viewItemDetailBG.frame.origin.y, viewItemDetailBG.frame.size.width, [[[UIConstants returnInstance] aryCartDetails] count]*50+lblCount*30+45);
        
        int y = 5;
        for (int i = 0; i < [[[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_OrderDetails] count] ; i++) {
            NSDictionary *dic = [[[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_OrderDetails] objectAtIndex:i];
            UIView *view = [self ReturnItemDetailView:dic withIndex:i];
            view.frame = CGRectMake(0, y, view.frame.size.width, view.frame.size.height);
            [viewItemDetailBG addSubview:view];
            y = y + view.frame.size.height;
            NSLog(@"%i", y);
        }
        NSLog(@"%f", imgViewDivider.frame.origin.y);
        
        imgViewDivider.frame = CGRectMake(imgViewDivider.frame.origin.x, y-5, imgViewDivider.frame.size.width, imgViewDivider.frame.size.height);
        
        y = imgViewDivider.frame.origin.y+1;
        for (NSDictionary *dicTaxDetails in [[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_RestaurantTaxes]) {
            UIView *_viewTaxDetail = [self ReturnTaxLabelView:dicTaxDetails withX:0 andY:y];
            [viewItemDetailBG addSubview:_viewTaxDetail];
            y = y + _viewTaxDetail.frame.size.height;
        }
        
        for (NSDictionary *dicCouponDetail in [[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_CouponDiscount]) {
            UIView *_viewCouponDetail = [self ReturnCouponView:dicCouponDetail withX:0 andY:y];
            [viewItemDetailBG addSubview:_viewCouponDetail];
            y = y + _viewCouponDetail.frame.size.height;
        }
        viewItemDetailBG.frame = CGRectMake(viewItemDetailBG.frame.origin.x, viewItemDetailBG.frame.origin.y, viewItemDetailBG.frame.size.width, y+45);
        viewOthers.frame = CGRectMake(viewOthers.frame.origin.x, viewItemDetailBG.frame.origin.y+viewItemDetailBG.frame.size.height + 5, viewOthers.frame.size.width, viewOthers.frame.size.height);
        [scrollViewCartSummary setContentSize:CGSizeMake(0, viewItemDetailBG.frame.size.height+viewOthers.frame.size.height+30)];
    }else{
        [self ShowEmptyCart];
    }
}

-(BOOL)InvokeAPI:(NSArray *)aryDetails
{
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if([ObjServiceHandler GetShowCartSummaryAndApplyCouponCodeAPI:aryDetails]) {
        //NSDictionary *dic1 = [[[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_RestaurantTaxes] objectAtIndex:0];
        //lblTaxDetail.text = [NSString stringWithFormat:@"%@: %@", [dic1 objectForKey:key_TaxName],[[UIConstants returnInstance] convertToDecimalValue:[[dic1 objectForKey:key_TaxValue] floatValue]]];
        _lblTotalAmountValue.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_NetAmount] floatValue]]];
        [self ModifyScreenBasedOnCartDetails];
        return YES;
    }else{
        [self ShowEmptyCart];
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
        return NO;
    }
    [ObjServiceHandler release], ObjServiceHandler = nil;
}

#pragma mark - Button Action Methods
-(void)OnClickGoHomeButton:(id)sender
{
    [self.delegate GoHome];
}

-(void)OnClickGoBackButton:(id)sender
{
    [self.delegate GoHome];
}

-(void)OnClickNextButton:(id)sender
{
    
    if (![[UIConstants returnInstance] strFosUserID]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[UIConstants returnInstance] isItEnglish]?Alert_English:Alert_Arabic
                                                       message:[[UIConstants returnInstance] isItEnglish]?Alert_DoYouWantToLogin_English:Alert_DoYouWantToLogin_Arabic
                                                      delegate:self
                                             cancelButtonTitle:[[UIConstants returnInstance] isItEnglish]?Login_Eng:Login_Arabic
                                             otherButtonTitles:[[UIConstants returnInstance] isItEnglish]?JustContinue_English:JustContinue_Arabic, nil];
        alert.tag = 1;
        [alert show];
        [alert release];
    }else{
        [[UIConstants returnInstance]setIsBackFromPaymentOrMobileVerify:NO];
        [self.delegate LoadNextScreen:VIEW_CHECKOUT];
    }
}

-(void)OnClickClearCartButton:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[UIConstants returnInstance] isItEnglish]?Alert_English:Alert_Arabic
                                                   message:[[UIConstants returnInstance] isItEnglish]?Alert_ClearCart_English:Alert_ClearCart_Arabic
                                                  delegate:self
                                         cancelButtonTitle:[[UIConstants returnInstance] isItEnglish]?Yes_English:Yes_Arabic
                                         otherButtonTitles:[[UIConstants returnInstance] isItEnglish]?No_English:No_Arabic, nil];
    alert.tag = 2;
    [alert show];
    [alert release];
}

-(void)OnClickChangePasswordButton:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadTabBar:4];
}

-(void)OnClickEditProfileButton:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadNextScreen:VIEW_EDITPROFILE];
}
-(void)OnClickLoignButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_LOGIN];
}

-(void)OnClickRegisterButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_REGISTER];
}

-(void)OnClickSignOutButton:(id)sender
{
    [[UIConstants returnInstance] setStrFosUserID:nil];
    [btnUserMenu setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    [viewUserMenu removeFromSuperview];
    loginBtn.hidden = NO;
    btnUserMenu.hidden = YES;
}


-(void)OnClickUserMenuButton:(id)sender
{
    if ([[UIConstants returnInstance] strFosUserID]) {
//        if (viewUserMenu.superview == nil) {
//            viewUserMenu.frame = CGRectMake(self.view.frame.size.width - viewUserMenu.frame.size.width-5, btnUserMenu.frame.origin.y + btnUserMenu.frame.size.height + 8, viewUserMenu.frame.size.width, viewUserMenu.frame.size.height);
//            [self.view addSubview:viewUserMenu];
//        }else{
//            [viewUserMenu removeFromSuperview];
//        }
//    }else{
//        if (viewLoginMenu.superview  == nil) {
//            viewLoginMenu.frame = CGRectMake(self.view.frame.size.width - viewLoginMenu.frame.size.width-5, btnUserMenu.frame.origin.y + btnUserMenu.frame.size.height + 8, viewLoginMenu.frame.size.width, viewLoginMenu.frame.size.height);
//            [self.view addSubview:viewLoginMenu];
//        }else {
//            [viewLoginMenu removeFromSuperview];
//        }
        
        BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
        UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:(isArabic)? UserDetails_Arabic : UserDetails_Eng delegate:self cancelButtonTitle:(isArabic)? Cancel_Arabic : Cancel_Eng destructiveButtonTitle:nil otherButtonTitles:(isArabic)? EditProfile_Arabic : EditProfile_Eng ,(isArabic)? SignOut_Arabic : SignOut_Eng, nil];

        [sheet showInView:self.view];
    }
}

- (IBAction)OnClickApplyCouponButton:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    [txtFldCouponDetatil resignFirstResponder];
    if ([txtFldCouponDetatil.text length] > 0) {
        for (NSDictionary *DicCoupon in aryCouponDetail) {
            if ([[DicCoupon objectForKey:key_CouponCode] isEqualToString:txtFldCouponDetatil.text]) {
                [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_AlreadyEnteredCoupon_English:Alert_AlreadyEnteredCoupon_Arabic];
                return;
            }
        }
       [aryCouponDetail addObject:[NSDictionary dictionaryWithObjectsAndKeys:txtFldCouponDetatil.text, key_CouponCode, nil]];
        NSMutableArray *array = [[UIConstants returnInstance] aryOrderedRestaurantsList];
        [[array objectAtIndex:0] setObject:aryCouponDetail forKey:key_CouponDiscount];
        if([self InvokeAPI:array]) {
            if ([[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_CampaignErrorMessage] != [NSNull null]) {
                [aryCouponDetail removeLastObject];
                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_CampaignErrorMessage]];
            }else{
                [[UIConstants returnInstance] setAryCouponDetails:aryCouponDetail];
                txtFldCouponDetatil.text = @"";
            }
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[UIConstants returnInstance] isItEnglish]?Alert_English:Alert_Arabic message:[[UIConstants returnInstance] isItEnglish]?Alert_enterYourCoupon_English:Alert_enterYourCoupon_Arabic delegate:self cancelButtonTitle:[[UIConstants returnInstance] isItEnglish]?OK_English:OK_Arabic otherButtonTitles: nil];
        alert.tag = 3; //coupon alert
        [alert show];
        [alert release];
    }
}

- (IBAction)OnClickEditOrderButton:(id)sender
{
    [self.delegate LoadTabBar:1];
}

- (void)OnClickEditItemButton:(id)sender
{
    UIButton *btnTemp = (UIButton *)sender;
    [self GetItemDetailsforItemIdentifier:[[[UIConstants returnInstance] aryCartDetails] objectAtIndex:btnTemp.tag-1000]];
}
- (void)OnClickTrashButton:(id)sender
{
    UIButton *btnTemp = (UIButton *)sender;
    NSMutableArray *aryTemp = [[UIConstants returnInstance] aryCartDetails];
    [aryTemp removeObjectAtIndex:btnTemp.tag-1000];
    [btnTemp.superview removeFromSuperview];
    for (UIView *_viewTemp in [viewItemDetailBG subviews]) {
        if (_viewTemp.tag == 10 || _viewTemp.tag == 20 || _viewTemp.tag == 30) {
            [_viewTemp removeFromSuperview];
        }
    }
    for (UIViewController *viewController in self.tabBarController.viewControllers) {
        if (viewController.tabBarItem.tag == 2) {
            viewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",[aryTemp count]];
        }
    }
    [[UIConstants returnInstance] setAryCartDetails:aryTemp];
    if ([[[UIConstants returnInstance] aryCartDetails] count] == 0) {
        [self ClearCart];
    }else{
        NSMutableArray *_aryOrderedRestaurantDetails = [[UIConstants returnInstance] aryOrderedRestaurantsList];
        [[_aryOrderedRestaurantDetails objectAtIndex:0] setObject:[[UIConstants returnInstance] aryCartDetails] forKey:key_OrderDetails];
        [[UIConstants returnInstance] setAryOrderedRestaurantsList:_aryOrderedRestaurantDetails];
        [self InvokeAPI:[[UIConstants returnInstance] aryOrderedRestaurantsList]];
       // [self ModifyScreenBasedOnCartDetails];
    }
    
}

- (void)dealloc {
    [btnLogin release];
    [btnRegister release];
    [btnEditProfile release];
    [btnChangePassword release];
    [btnSignOut release];
    [btnUserMenu release];
    [btnNext release];
    [btnClearCart release];
    [lblDeliveryMode release];
    [txtFldCouponDetatil release];
    [btnApplyCoupon release];
    [btnEditOrder release];
    [_lblTotalAmountValue release];
    [super dealloc];
}

#pragma mark - Get Item Details
-(void)GetItemDetailsforItemIdentifier: (NSDictionary *)ItemDetails
{
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetMenuItemDetail:[[UIConstants returnInstance] strAppID]
                                            :[[[[[ResponseDTO sharedInstance] DTO_ShowCartSummary] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_RestaurantID]
                                            :[ItemDetails objectForKey:key_MenuIdentifier]
                                            :[ItemDetails objectForKey:key_MenuCategoryIdentifier]
                                            :[[ItemDetails objectForKey:key_isGroup] integerValue]]) {
        [[UIConstants returnInstance] setIsComingForEditing:YES];
        [[UIConstants returnInstance] setDicSelectedItemFromOrderSummary:ItemDetails];
        [[UIConstants returnInstance] setStrIsGroup:[ItemDetails objectForKey:key_isGroup]];
        [self.delegate LoadNextScreen:VIEW_ITEMDETAILS];
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    [ObjServiceHandler  release], ObjServiceHandler = nil;
}

#pragma mark - Change language to Arabic

-(void)ChangeLanguageToArabic
{
    
    txtFldCouponDetatil.placeholder = CouponCode_Arabic;
    txtFldCouponDetatil.textAlignment = FOS_TEXTALIGNMENT;
    [btnLogin setTitle:Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:EditProfile_Arabic forState:UIControlStateNormal];
    [btnChangePassword setTitle:ChangePassword_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:SignOut_Arabic forState:UIControlStateNormal];
    
    lblScreenName.text = OrderSummary_Arabic;
    
    [btnNext setTitle:Next_Arabic forState:UIControlStateNormal];
    [btnClearCart setTitle:ClearCart_Arabic forState:UIControlStateNormal];
    lblEmptyCart.text = CartEmpty_Arabic;
    
//    btnNext.frame = CGRectMake(self.view.frame.size.width - btnNext.frame.origin.x - btnNext.frame.size.width, btnNext.frame.origin.y, btnNext.frame.size.width, btnNext.frame.size.height);
//    btnClearCart.frame = CGRectMake(self.view.frame.size.width - btnClearCart.frame.origin.x - btnClearCart.frame.size.width, btnClearCart.frame.origin.y, btnClearCart.frame.size.width, btnClearCart.frame.size.height);
    
    [btnEditOrder setTitle:Edit_Arabic forState:UIControlStateNormal];
    [btnApplyCoupon setTitle:ApplyCoupon_Arabic forState:UIControlStateNormal];
    lblDeliveryMethodText.text = DeliveryMethod_Arabic;
     lblEmptyAmount.text = [NSString stringWithFormat:@"%@  0",TotalAmount_Arabic];
    lblDeliveryMethodText.frame = CGRectMake(viewOthers.frame.size.width - lblDeliveryMethodText.frame.origin.x - lblDeliveryMethodText.frame.size.width, lblDeliveryMethodText.frame.origin.y, lblDeliveryMethodText.frame.size.width, lblDeliveryMethodText.frame.size.height);
    lblDeliveryMode.frame = CGRectMake(viewOthers.frame.size.width - lblDeliveryMode.frame.origin.x - lblDeliveryMode.frame.size.width, lblDeliveryMode.frame.origin.y, lblDeliveryMode.frame.size.width, lblDeliveryMode.frame.size.height);
    
}

#pragma mark - Alert view delegate methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [[UIConstants returnInstance]setIsLoginViaHome:NO];
            [self.delegate LoadNextScreen:VIEW_LOGIN];
        }else{
            [[UIConstants returnInstance]setIsBackFromPaymentOrMobileVerify:NO];
            [self.delegate LoadNextScreen:VIEW_CHECKOUT];
        }
    }else if (alertView.tag == 2){
        if (buttonIndex == 0) {
            [self ClearCart];
        }
    }else if(alertView.tag == 3){ // coupon
        [txtFldCouponDetatil becomeFirstResponder];
    }
}

#pragma mark - touch recognition method

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (viewLoginMenu.superview != nil) {
        [viewLoginMenu removeFromSuperview];
    }
    if (viewUserMenu.superview != nil) {
        [viewUserMenu removeFromSuperview];
    }
}

#pragma mark - Return Details view method
-(UIView *)ReturnItemDetailView:(NSDictionary *)DicDetails withIndex:(int)Index
{
    int width = 130;
    if (isempty([DicDetails objectForKey:key_Customization]) && [[DicDetails objectForKey:key_Customization] length]>0) {
        width = 120;
    }
    int hight = [self returnHeightfortheContent:width :[DicDetails objectForKey:key_ItemName] :[[UIConstants returnInstance] returnArvoRegular:14]];
    if (hight<40) {
        hight = 40;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, hight+10)];
    view.tag = 10;
    
    UIConstants *constant = [UIConstants returnInstance];
    CGRect rect = [constant getFrameForLanguage:CGRectMake(7, 5, width, hight) withSuperViewRect:view.frame];
    UILabel *lblItemName = [[UILabel alloc] initWithFrame:rect];
    
    if (isempty([DicDetails objectForKey:key_Customization]) && [[DicDetails objectForKey:key_Customization] length]>0) {
        rect = [constant getFrameForLanguage:CGRectMake(width+10, 20, 10, 10) withSuperViewRect:view.frame];
        UIImageView *imgViewCustomization = [[UIImageView alloc] initWithFrame:rect];
        imgViewCustomization.image = [UIImage imageNamed:@"CustomTextIndicator.png"];
        [view addSubview:imgViewCustomization];
        [imgViewCustomization release], imgViewCustomization = nil;
    }
    
    
    rect = [constant getFrameForLanguage:CGRectMake(145, 9, 35, 27) withSuperViewRect:view.frame];
    UIImageView *imgQuantityBg = [[UIImageView alloc] initWithFrame:rect];
    
    rect = [constant getFrameForLanguage:CGRectMake(145, 9, 35, 27) withSuperViewRect:view.frame];
    UILabel *lblQuantity = [[UILabel alloc] initWithFrame:rect];
    
    rect = [constant getFrameForLanguage:CGRectMake(185, 9, 90, 27) withSuperViewRect:view.frame];
    UILabel *lblAmount = [[UILabel alloc] initWithFrame:rect];
    
    rect = [constant getFrameForLanguage:CGRectMake(278, 14, 15, 17) withSuperViewRect:view.frame];
    UIButton *btnTrash = [[UIButton alloc] initWithFrame:rect];
    
    rect = [constant getFrameForLanguage:CGRectMake(0, 0, 270, hight) withSuperViewRect:view.frame];
    UIButton *btnEditItem = [[UIButton alloc] initWithFrame:rect];
    
    lblItemName.backgroundColor = [UIColor clearColor];
    lblItemName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblItemName.text = [DicDetails objectForKey:key_ItemName];
    lblItemName.adjustsFontSizeToFitWidth = YES;
    lblItemName.textAlignment = FOS_TEXTALIGNMENT;
    lblItemName.minimumFontSize = 10.0;
    lblItemName.numberOfLines = 0;
    
    imgQuantityBg.image = [UIImage imageNamed:@"item_qty_box.png"];
    
    lblQuantity.backgroundColor = [UIColor clearColor];
    lblQuantity.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblQuantity.textAlignment = NSTextAlignmentCenter;
    lblQuantity.text = [NSString stringWithFormat:@"%@",[DicDetails objectForKey:key_Quantity]];

    lblAmount.textAlignment = FOS_TEXTALIGNMENT;
    lblAmount.backgroundColor = [UIColor clearColor];
    lblAmount.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[DicDetails objectForKey:key_TotalPrice] floatValue]]];
    
    btnTrash.tag = Index+1000;
    [btnTrash setImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
    [btnTrash addTarget:self action:@selector(OnClickTrashButton:) forControlEvents:UIControlEventTouchUpInside];
    
    btnEditItem.tag = Index+1000;
    [btnEditItem addTarget:self action:@selector(OnClickEditItemButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:lblItemName];
    [view addSubview:imgQuantityBg];
    [view addSubview:lblQuantity];
    [view addSubview:lblAmount];
    [view addSubview:btnTrash];
    [view addSubview:btnEditItem];
    
    
    [lblItemName release], lblItemName = nil;
    [imgQuantityBg release], imgQuantityBg = nil;
    [lblQuantity release], lblQuantity = nil;
    [lblAmount release], lblAmount = nil;
    [btnTrash release], btnTrash = nil;
    
    return view;
}

-(UIView *)ReturnTaxLabelView:(NSDictionary *)DicTaxDetails withX:(int)positionX andY:(int)positionY
{
    UIView *viewTaxLabelView = [[UIView alloc] initWithFrame:CGRectMake(positionX, positionY, 300, 30)];
    viewTaxLabelView.tag = 20;
    UILabel *_lblTaxName = [[UILabel alloc] init];
    UILabel *_lblTaxValue = [[UILabel alloc] init];
    _lblTaxName.font = [[UIConstants returnInstance] returnArvoRegular:12];
    _lblTaxValue.font = [[UIConstants returnInstance] returnArvoRegular:12];
    _lblTaxName.textAlignment = FOS_TEXTALIGNMENT;
    _lblTaxValue.textAlignment = FOS_TEXTALIGNMENT;
    
    _lblTaxName.backgroundColor = [UIColor clearColor];
    _lblTaxValue.backgroundColor = [UIColor clearColor];

    _lblTaxName.frame = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(10, 5, 135, 20) withSuperViewRect:viewTaxLabelView.frame];
    _lblTaxValue.frame = [[UIConstants returnInstance] getFrameForLanguage: CGRectMake(185, 5, 135, 20) withSuperViewRect:viewTaxLabelView.frame];
    _lblTaxName.adjustsFontSizeToFitWidth = YES;
    _lblTaxName.minimumFontSize = 10.0;
    _lblTaxName.numberOfLines = 2;
    _lblTaxValue.adjustsFontSizeToFitWidth = YES;
    _lblTaxValue.minimumFontSize = 10.0;
    _lblTaxValue.numberOfLines = 2;
    
    _lblTaxName.text = [DicTaxDetails objectForKey:key_TaxName];
    _lblTaxValue.text = [NSString stringWithFormat:@"%@ %@", [[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[DicTaxDetails objectForKey:key_TaxValue] floatValue]]];
    [viewTaxLabelView addSubview:_lblTaxName];
    [viewTaxLabelView addSubview:_lblTaxValue];
    
    return viewTaxLabelView;
}

-(UIView *)ReturnCouponView:(NSDictionary *)DicCouponDetail withX:(int)positionX andY:(int)positionY
{
    UIView *_viewCouponName = [[UIView alloc] initWithFrame:CGRectMake(positionX, positionY, 300, 30)];
    _viewCouponName.tag = 30;
    
    UILabel *_lblCouponName = [[UILabel alloc] init];
    UILabel *_lblCouponValue = [[UILabel alloc] init];
    _lblCouponName.font = [[UIConstants returnInstance] returnArvoRegular:12];
    _lblCouponValue.font = [[UIConstants returnInstance] returnArvoRegular:12];
    _lblCouponName.textAlignment = FOS_TEXTALIGNMENT;
    _lblCouponValue.textAlignment = FOS_TEXTALIGNMENT;
    
    _lblCouponName.backgroundColor = [UIColor clearColor];
    _lblCouponValue.backgroundColor = [UIColor clearColor];
    
    _lblCouponName.frame = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(10, 5, 135, 20) withSuperViewRect:_viewCouponName.frame];
    _lblCouponValue.frame = [[UIConstants returnInstance] getFrameForLanguage: CGRectMake(185, 5, 135, 20) withSuperViewRect:_viewCouponName.frame];
    
    _lblCouponName.adjustsFontSizeToFitWidth = YES;
    _lblCouponName.minimumFontSize = 10.0;
    _lblCouponName.numberOfLines = 2;
    _lblCouponValue.adjustsFontSizeToFitWidth = YES;
    _lblCouponValue.minimumFontSize = 10.0;
    _lblCouponValue.numberOfLines = 2;
    
    _lblCouponName.text = [DicCouponDetail objectForKey:key_CouponName];
    _lblCouponValue.text = [NSString stringWithFormat:@"%@ %@", [[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[DicCouponDetail objectForKey:key_CouponAmount] floatValue]]];
    
    [_viewCouponName addSubview:_lblCouponName];
    [_viewCouponName addSubview:_lblCouponValue];
    
    return _viewCouponName;
}

#pragma mark - Return Hight for the text fields
-(int) returnHeightfortheContent:(int) width :(NSString *)str :(UIFont *)font
{
	int result  = 0;
	if(nil!=str){
		CGSize		textSize = {width, 10000 };
		CGSize		size = [str sizeWithFont:font constrainedToSize:textSize lineBreakMode:NSLineBreakByTruncatingTail];
		size.height += 0.f;
		result =size.height;
	}
    NSLog(@"hight: %i", result);
	return result;
}

#pragma mark - Textfield Delegate methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, -70, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text length] == 0 && [string isEqual: @" "]) {
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - clear cart methods
-(void)ClearCart
{
    [[UIConstants returnInstance] setAryCartDetails:nil];
    [[UIConstants returnInstance] setAryOrderedRestaurantsList:nil];
    [[UIConstants returnInstance] setAryCouponDetails:nil];
    btnEditOrder.hidden = YES;
    scrollViewCartSummary.hidden = YES;
    for (UIView *view in [viewItemDetailBG subviews]) {
        if (view.tag == 10) {
            [view removeFromSuperview];
        }
    }
    for (UIViewController *viewController in self.tabBarController.viewControllers) {
        if (viewController.tabBarItem.tag == 2) {
            viewController.tabBarItem.badgeValue = nil;
        }
    }
    viewEmptyCart.frame = CGRectMake(10, lblRestaurantName.frame.origin.y+lblRestaurantName.frame.size.height + 5, viewEmptyCart.frame.size.width, viewEmptyCart.frame.size.height);
    [self.view addSubview:viewEmptyCart];
    
    // Functionality to revert to the menu screen once the user cleared the Order summary.
    [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_orderClear_English:Alert_orderClear_Arabic]; // Alert
    [[UIConstants returnInstance] setIsItemCleared:YES]; // boolean to identify the cart cleared
    [delegate methodToSwitchTab]; // redirect tab to load menu items.
}

-(void)ShowEmptyCart
{
    scrollViewCartSummary.hidden = YES;
    btnEditOrder.hidden = YES;
    viewFooter.hidden = YES;
    viewEmptyCart.frame = CGRectMake(10, lblRestaurantName.frame.origin.y+lblRestaurantName.frame.size.height + 5, viewEmptyCart.frame.size.width, viewEmptyCart.frame.size.height);
    [[UIConstants returnInstance] setAryCartDetails:nil];
    [[UIConstants returnInstance] setAryOrderedRestaurantsList:nil];
    [[UIConstants returnInstance] setAryCouponDetails:nil];
    [self.view addSubview:viewEmptyCart];
    [self SetTabbarBadgeValue];
}

-(void)SetTabbarBadgeValue
{
    for (UIViewController *viewController in self.tabBarController.viewControllers) {
        if (viewController.tabBarItem.tag == 2) {
            if ([[[UIConstants returnInstance] aryCartDetails] count] > 0){
                viewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",[[[UIConstants returnInstance] aryCartDetails] count]];
            }else{
                viewController.tabBarItem.badgeValue = nil;
            }
        }
    }
}

#pragma mark -
- (IBAction)loginAction:(UIButton *)sender {
    [self OnClickLoignButton:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){ //edit profile
        [self OnClickEditProfileButton:nil];
    }else if(buttonIndex == 1){ //sign out
        [self OnClickSignOutButton:nil];
        
    }
}

- (void)viewDidUnload {
    [_lblTotalAmountValue release];
    _lblTotalAmountValue = nil;
    [super viewDidUnload];
}
@end
