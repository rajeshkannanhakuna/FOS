//
//  ItemDetailScreen.m
//  
//
//  Created by segate on 20/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "ItemDetailScreen.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import <QuartzCore/QuartzCore.h>
#import "ResponseDTO.h"
#import "APIConstants.h"

#define isempty(_x_)  _x_ != Nil && _x_ != [NSNull null] && ![_x_ isEqualToString:@""]
#define isemptyArray(_x_)  _x_ != Nil && [_x_ count] != 0

@interface ItemDetailScreen ()<UIActionSheetDelegate>
{
    NSDictionary *dicItemDetail;
    int SelectedButtonTag;
    int NoOfMenuItems;
    int _positionX ;
    int _positionY ;
    NSString *strTotalAmount;
    NSArray *aryMenuCustomize;
    NSMutableArray *arySelectedMenuCustomize;
    NSMutableDictionary *dicRestaurantDetails;
    NSDictionary *dicMenuItem;
    NSMutableArray *aryMenuGroup;
    NSMutableArray *aryMenuItem;
      IBOutlet UIButton *loginBtn;
    
    NSString *editMenuIdentifier;
    NSString *editMenuCategoryIdentifier;
   // int _selectedIndex;
}
- (IBAction)loginAction:(UIButton *)sender;

@end

@implementation ItemDetailScreen
@synthesize delegate;
//@synthesize txtFldQuantity;
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
    // Do any additional setup after loading the view from its nib.
    strTotalAmount = @"";
   [self SetFont];
    
    arySelectedMenuCustomize = [[NSMutableArray alloc] init];
    dicRestaurantDetails = [[NSMutableDictionary alloc] init];
    txtViewCustomizeDish.layer.masksToBounds = YES;
    txtViewCustomizeDish.layer.cornerRadius = 5;
    txtViewCustomizeDish.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtViewCustomizeDish.layer.borderWidth = 2;
    
    if(![[UIConstants returnInstance] isItEnglish]){
        [self ChangeLanguageToArabic];
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
        
    }
    
   
   // aryMenuGroup = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[UIConstants returnInstance] strFosUserID]) {
        loginBtn.hidden = YES;
        btnUserMenu.hidden = NO;
        [btnUserMenu setImage:[UIImage imageNamed:@"User_loggedIn.png"] forState:UIControlStateNormal];
    }else{
        loginBtn.hidden = NO;
        btnUserMenu.hidden = YES;
        [btnUserMenu setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    }
    
    [self ModifyScreen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)KeyBoardWillShow:(NSNotification *)notification
//{
//    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    doneButton.frame = CGRectMake(0, 163, 106, 53);
//    doneButton.adjustsImageWhenHighlighted = NO;
//    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
//    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
//    [doneButton addTarget:self action:@selector(OnClickDoneButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    // locate keyboard view
//    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
//    for( UIView* keyboard in [tempWindow subviews]){
//        // keyboard view found; add the custom button to it
//        if([[keyboard description] hasPrefix:@"UIKeyboard"] == YES)
//            [keyboard addSubview:doneButton];
//    }
//}

#pragma mark - Set Font 

-(void)SetFont
{
    btnEditProfile.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnChangePassword.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnSignOut.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    loginBtn.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnRegister.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    lblNameOfItem.font = [[UIConstants returnInstance] returnArvoRegular:16];
    lblRsName.font = [[UIConstants returnInstance] returnArvoRegular:11];
    lblAmountForQuantity.font = [[UIConstants returnInstance] returnArvoRegular:11];
    lblDetails.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblQuantityName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    txtFldQuantity.font = [[UIConstants returnInstance] returnArvoRegular:15];
    lblAmountName.font = [[UIConstants returnInstance] returnArvoBold:14];
    lblTotalAmount.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnAddToCart.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    txtViewCustomizeDish.font = [[UIConstants returnInstance] returnArvoRegular:14];
    
}

-(void)ModifyScreen
{
 
    dicItemDetail = [[ResponseDTO sharedInstance] DTO_MenuItemDetail];
    lblScreenName.text = [[UIConstants returnInstance] strMenuCategoryName];
    [dicRestaurantDetails setObject:[[dicItemDetail objectForKey:key_RestaurantDetail] objectForKey:key_Identifier] forKey:key_RestaurantID];
    [dicRestaurantDetails setObject:[[dicItemDetail objectForKey:key_RestaurantDetail] objectForKey:key_VendorIdentifier] forKey:key_VendorID];
    [dicRestaurantDetails setObject:[[dicItemDetail objectForKey:key_RestaurantDetail] objectForKey:key_Name] forKey:key_RestaurantName];
    [dicRestaurantDetails setObject:[[dicItemDetail objectForKey:key_RestaurantDetail] objectForKey:key_MenuMasterItemId] forKey:key_MenuMasterID];
    [[UIConstants returnInstance] setStrMaxDeliveryTime:[[dicItemDetail objectForKey:key_RestaurantDetail] objectForKey:key_MaxDeliveryTime]];
    [[UIConstants returnInstance] setStrMinPreparationTime:[[dicItemDetail objectForKey:key_RestaurantDetail] objectForKey:key_MinPrepTime]];
    if([txtFldQuantity.text integerValue] == 0) {
        viewFooter.hidden = YES;
    }else{
        viewFooter.hidden = NO;
    }
    
//    if ([viewFooter isHidden]) {
//       scrollViewItemDetails.frame = CGRectMake(scrollViewItemDetails.frame.origin.x, scrollViewItemDetails.frame.origin.y, scrollViewItemDetails.frame.size.width, scrollViewItemDetails.frame.size.height+viewFooter.frame.size.height); 
//    }else{
//        scrollViewItemDetails.frame = CGRectMake(scrollViewItemDetails.frame.origin.x, scrollViewItemDetails.frame.origin.y, scrollViewItemDetails.frame.size.width, scrollViewItemDetails.frame.size.height+viewFooter.frame.size.height);
//    }
    
    _positionX = 10;
    _positionY = 10;
    
    aryMenuGroup = [[NSMutableArray alloc] initWithArray:[self SortArrayBasedOnOrderByGroupforArray:[[dicItemDetail objectForKey:key_Menu] objectForKey:key_MenuItem]]];
    NSLog(@"%@", aryMenuGroup);
    
    int _selectedIndex = 0;
    if ([[UIConstants returnInstance] IsComingForEditing]) {
        [btnAddToCart setTitle:[[UIConstants returnInstance] isItEnglish]?Update_English:Update_Arabic forState:UIControlStateNormal];
/** Checking for already selected Item **/
        BOOL itemSeleceted = NO;
        //for (NSDictionary *dicExistingItem in [[UIConstants returnInstance] aryCartDetails]) {
        NSDictionary *dicExistingItem = [[UIConstants returnInstance] dicSelectedItemFromOrderSummary];
            for (_selectedIndex = 0; _selectedIndex < [aryMenuGroup count]; _selectedIndex++) {
                NSLog(@"%@ == %@", [[aryMenuGroup objectAtIndex:_selectedIndex] objectForKey:key_ItemCode], [dicExistingItem objectForKey:key_ItemID]);
                if ([[[aryMenuGroup objectAtIndex:_selectedIndex] objectForKey:key_ItemCode] isEqualToString:[dicExistingItem objectForKey:key_ItemID]]) {
                    [arySelectedMenuCustomize  addObjectsFromArray:[dicExistingItem objectForKey:key_CustomizationOptions]];
                    txtFldQuantity.text = [NSString stringWithFormat:@"%@",[dicExistingItem objectForKey:key_Quantity]];
                    lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@", [[UIConstants returnInstance] strCurrencyCode], [dicExistingItem objectForKey:key_TotalPrice]];
                    
                    //change by anu for the bug edit count increase the menu count wrong
                    editMenuIdentifier = [dicExistingItem objectForKey:key_MenuIdentifier];
                    editMenuCategoryIdentifier = [dicExistingItem objectForKey:key_MenuCategoryIdentifier];
                    //-----
                    
                    if (isempty([dicExistingItem objectForKey:key_Customization])) {
                        txtViewCustomizeDish.textColor = [UIColor blackColor];
                        txtViewCustomizeDish.text = [dicExistingItem objectForKey:key_Customization];
                    }
                    itemSeleceted = YES;
                    break;
                }
            }
//            if (itemSeleceted) {
//                break;
//            }else{
//                _selectedIndex = 0;
//            }
       // }
    }
    
    if ([aryMenuGroup count] > 1) {
       NSLog(@"Count: %i", [aryMenuGroup count]);
        int _width = 145;
        int _height = 30;
        
        int _noOfRows;
        if ([aryMenuGroup count] % 2 == 1) {
            _noOfRows = [aryMenuGroup count]/2 + 1;
        }else{
            _noOfRows = [aryMenuGroup count]/2;
        }
        NSLog(@"Rows: %i", _noOfRows);
        int _aryIndex = 0;
        for (int i = 0; i < _noOfRows; i++) {
            for (int j = 0; j < 2; j++) {
                NSLog(@"%i", _aryIndex);
                if (_aryIndex < [aryMenuGroup count]) {
                    UIView *_viewGroup = [self ReturnGroupView:[aryMenuGroup objectAtIndex:_aryIndex]];
                    if (_aryIndex == _selectedIndex) {
                        for (UIView *_view1 in [_viewGroup subviews]) {
                            if ([_view1 isKindOfClass:[UIButton class]]) {
                                UIButton *btn = (UIButton *)_view1;
                                btn.enabled = NO;
                                 SelectedButtonTag = btn.tag;
                            }else if([_view1 isKindOfClass:[UIImageView class]]){
                                UIImageView *imgView = (UIImageView *)_view1;
                                imgView.highlighted = YES;
                            }
                        }
                    }
                    _viewGroup.frame = [[UIConstants returnInstance]getFrameForLanguage:CGRectMake(_positionX, _positionY, _width, _height) withSuperViewRect:scrollViewItemDetails.frame] ;
                    [scrollViewItemDetails addSubview:_viewGroup];
                    _aryIndex = _aryIndex + 1;
                    _positionX = _positionX + _width + 10;
                }
            }
            _positionX = 10;
            _positionY = _positionY + _height + 10;
        }
    }
    [self SetLabelValues:[aryMenuGroup objectAtIndex:_selectedIndex]];
}

#pragma mark - Button action methods

- (void)OnClickGoBackButton:(id)sender
{
    [self.view endEditing:YES];
    [self.delegate GoBack:YES];
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

-(void)OnClickPlusQuantityButton:(id)sender
{
    if([txtFldQuantity.text integerValue] >= 99) {
        return;
    }
    txtFldQuantity.text = [NSString stringWithFormat:@"%i", [txtFldQuantity.text integerValue]+1];
//        viewFooter.hidden = YES;
//    }else{
//        viewFooter.hidden = NO;
//    }
    
    NSString *price = lblAmountForQuantity.text  ;
    if ([arySelectedMenuCustomize count] == 0) {
//        lblTotalAmount.text = [NSString stringWithFormat:@"%@ %.3f",[[UIConstants returnInstance] strCurrencyCode],[txtFldQuantity.text integerValue]* [price floatValue]];
        lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:([txtFldQuantity.text integerValue]* [price floatValue])]];
        
    }else{
        float priceForAddings = 0;
        for (NSMutableDictionary *dic in arySelectedMenuCustomize) {
            priceForAddings = priceForAddings + [[dic objectForKey:key_ItemCost] floatValue];
            [dic setObject:txtFldQuantity.text forKey:key_Qty];
//            [dic setObject:[NSString stringWithFormat:@"%.3f",[txtFldQuantity.text integerValue]*[[dic objectForKey:key_ItemCost] floatValue]] forKey:key_TotalCost];
            [dic setObject:[NSString stringWithFormat:@"%@",[[UIConstants returnInstance] convertToDecimalValue:([txtFldQuantity.text integerValue]*[[dic objectForKey:key_ItemCost] floatValue])]] forKey:key_TotalCost];

        }
//        lblTotalAmount.text = [NSString stringWithFormat:@"%@ %.3f",[[UIConstants returnInstance] strCurrencyCode],[txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue]];
        lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:([txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue])]];

    }
}

-(void)OnClickMinusQuantityButton:(id)sender
{
    if ([txtFldQuantity.text integerValue] > 1) {
        txtFldQuantity.text = [NSString stringWithFormat:@"%i", [txtFldQuantity.text integerValue]-1];
        
//        if([txtFldQuantity.text integerValue] == 0) {
//            viewFooter.hidden = YES;
//        }else{
//            viewFooter.hidden = NO;
//        }
        
        NSNumber *price = nil;
        if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
            price = [[[[[[ResponseDTO sharedInstance] DTO_MenuItemDetail] objectForKey:key_Menu] objectForKey:key_MenuItem] objectAtIndex:0] objectForKey:key_DoorDeliveryItemPrice];
        }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]) {
            price = [[[[[[ResponseDTO sharedInstance] DTO_MenuItemDetail] objectForKey:key_Menu] objectForKey:key_MenuItem] objectAtIndex:0] objectForKey:key_TakeAwayItemPrice];
        }
        
        if ([arySelectedMenuCustomize count] == 0) {
//            lblTotalAmount.text = [NSString stringWithFormat:@"%@ %.3f",[[UIConstants returnInstance] strCurrencyCode],[txtFldQuantity.text integerValue]* [price floatValue]];
            lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:([txtFldQuantity.text integerValue]* [price floatValue])]];
        }else{
            float priceForAddings = 0;
            for (NSMutableDictionary *dic in arySelectedMenuCustomize) {
                priceForAddings = priceForAddings + [[dic objectForKey:key_ItemCost] floatValue];
                [dic setObject:txtFldQuantity.text forKey:key_Qty];
//                [dic setObject:[NSString stringWithFormat:@"%.3f",[txtFldQuantity.text integerValue]*[[dic objectForKey:key_ItemCost] floatValue]] forKey:key_TotalCost];
                [dic setObject:[NSString stringWithFormat:@"%@",[[UIConstants returnInstance] convertToDecimalValue:([txtFldQuantity.text integerValue]*[[dic objectForKey:key_ItemCost] floatValue])]] forKey:key_TotalCost];

            }
//            lblTotalAmount.text = [NSString stringWithFormat:@"%@ %.3f",[[UIConstants returnInstance] strCurrencyCode],[txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue]];
            lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance]convertToDecimalValue:([txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue])]];

        }
    }
}

-(void)OnClickAddToCartButton:(id)sender
{
    if ([txtFldQuantity.text integerValue] > 0) {
        
        
//#ifdef DEBUG
//        
//        // Something to log your sensitive data here
//        if ([[[dicItemDetail objectForKey: key_RestaurantDetail] objectForKey:key_IsOrderLocked] integerValue] == 1) {
//#else
//        
//        //
//#endif
        if ([[[dicItemDetail objectForKey: key_RestaurantDetail] objectForKey:key_IsOrderLocked] integerValue] == 1) {
            if(![[UIConstants returnInstance] isItEnglish]){
                [[UIConstants returnInstance] ShowAlert:Alert_IsOrderLocked_Arabic];
            }else {
                [[UIConstants returnInstance] ShowAlert:Alert_IsOrderLocked_English];
            }
        }else if ([[dicItemDetail objectForKey: key_RestaurantDetail] objectForKey:key_IsOpened] == false){
            if(![[UIConstants returnInstance] isItEnglish]){
                [[UIConstants returnInstance] ShowAlert:Alert_IsRestaurantOpen_Arabic];
            }else {
                [[UIConstants returnInstance] ShowAlert:Alert_IsRestaurantOpen_English];
            }
        }else  { // update cart
            if ([[dicMenuItem objectForKey:key_Status] integerValue] == true) {
                BOOL ItemAvailable = NO;
                for (NSDictionary *dic in aryMenuCustomize) {
                    if ([[dic objectForKey:key_IsCustomizationGroupMandatory] integerValue] == 1) {
                        for (NSDictionary *dic1 in [dic objectForKey:key_Options]) {
                            for (NSDictionary *dic2 in arySelectedMenuCustomize) {
                                if ([[dic1 objectForKey:key_IdCustomizationMaster] integerValue] == [[dic2 objectForKey:key_CustomizationId] integerValue]) {
                                    ItemAvailable = YES;
                                    break;
                                }else {
                                    ItemAvailable = NO;
                                }
                            }
                            if (ItemAvailable) {
                                break;
                            }
                        }
                        if(!ItemAvailable) {
                            if(![[UIConstants returnInstance] isItEnglish]){
                                [[UIConstants returnInstance] ShowAlert:[NSString stringWithFormat:Alert_MandatoryItemSelection_Arabic, [dic objectForKey:key_CustomizationGroupName]]];
                            }else {
                                [[UIConstants returnInstance] ShowAlert:[NSString stringWithFormat:Alert_MandatoryItemSelection_English, [dic objectForKey:key_CustomizationGroupName]]];
                            }
                            return;
                        }
                    }
                }
                NSScanner *scanner = [NSScanner scannerWithString:lblTotalAmount.text];
                NSString *match = [[UIConstants returnInstance] strCurrencyCode];
                [scanner scanString:match intoString:nil];
                strTotalAmount = [lblTotalAmount.text substringFromIndex:scanner.scanLocation];
                NSLog(@"%@", strTotalAmount);
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [dicMenuItem objectForKey:key_ItemName], key_ItemName,
                                    [dicMenuItem objectForKey:key_ItemCode], key_ItemID,
//                                    txtFldQuantity.text, key_Quantity,
//                                    strTotalAmount, key_TotalPrice,
//                                    [dicMenuItem objectForKey:key_DoorDeliveryItemPrice], key_DoorDeliveryItemPrice,
//                                    [dicMenuItem objectForKey:key_TakeAwayItemPrice], key_TakeAwayItemPrice,
                                    [dicMenuItem objectForKey:key_DineInItemPrice], key_DineInItemPrice,
                                    [dicMenuItem objectForKey:key_IsMenuCustomizable], key_IsMenuCustomizable,
                                            arySelectedMenuCustomize, key_CustomizationOptions,([[UIConstants returnInstance] IsComingForEditing])?editMenuCategoryIdentifier :
                                            [[UIConstants returnInstance] strMenuCategoryIdentifier], key_MenuCategoryIdentifier,([[UIConstants returnInstance] IsComingForEditing])? editMenuIdentifier :
                                    [[UIConstants returnInstance] strMenuIdentifier], key_MenuIdentifier,
                                    [[UIConstants returnInstance] strIsGroup],
                                            key_isGroup,
                                      nil];
                float priceForSingleItem = [strTotalAmount floatValue]/[txtFldQuantity.text integerValue];
                NSLog(@"Price for single item: %f", priceForSingleItem);
                
                [dic setObject:[NSString stringWithFormat:@"%f", priceForSingleItem]forKey:key_DoorDeliveryItemPrice];
                [dic setObject:[NSString stringWithFormat:@"%f", priceForSingleItem]forKey:key_TakeAwayItemPrice];
               
                if ([[dicMenuItem objectForKey:key_IsMenuCustomizable] integerValue] == 1) {
                    if (![txtViewCustomizeDish.text isEqual: @"Customize Your Dish"]) {
                        [dic setObject:txtViewCustomizeDish.text forKey:key_Customization];
                    }else{
                        [dic setObject:@"" forKey:key_Customization];
                    }
                }
                
                if ([[UIConstants returnInstance] IsComingForEditing]) {
                    [[[UIConstants returnInstance] aryCartDetails] removeObject:[[UIConstants returnInstance] dicSelectedItemFromOrderSummary]];
                }
                
                NSMutableArray *aryCartDetails = [[NSMutableArray alloc] initWithArray:[[UIConstants returnInstance] aryCartDetails]];
                int Quantity = [txtFldQuantity.text integerValue];
                for (NSDictionary *dicExistingItem in aryCartDetails) {
                    if ([[dic objectForKey:key_ItemID] isEqualToString:[dicExistingItem objectForKey:key_ItemID]]) {
                        BOOL IsBothSame = [self CompareExistingItem:dicExistingItem withNewOne:dic];
                        if (IsBothSame) {
                            Quantity = Quantity+[[dicExistingItem objectForKey:key_Quantity] integerValue];
                            [aryCartDetails removeObject:dicExistingItem];
                            break;
                        }
                    }
                }
                strTotalAmount =[NSString stringWithFormat:@"%f",priceForSingleItem*Quantity];
                [dic setObject:strTotalAmount forKey:key_TotalPrice];
                [dic setObject:[NSString stringWithFormat:@"%i",Quantity] forKey:key_Quantity];
                
                [aryCartDetails addObject:dic];
                [[UIConstants returnInstance] setAryCartDetails:aryCartDetails];
                NSMutableArray *_aryRestaurantOrderedList = [[NSMutableArray alloc] initWithArray:[[UIConstants returnInstance] aryOrderedRestaurantsList]];
                
                NSMutableDictionary *_dicOrederedRestaurant;
                if([_aryRestaurantOrderedList count] > 0){
                   _dicOrederedRestaurant =  [_aryRestaurantOrderedList objectAtIndex:0];
                    [_dicOrederedRestaurant setObject:aryCartDetails forKey:key_OrderDetails];
                    [_aryRestaurantOrderedList removeAllObjects];
                    [_aryRestaurantOrderedList addObject:_dicOrederedRestaurant];
                }else{
                    [dicRestaurantDetails setObject:[NSMutableArray arrayWithObjects:dic, nil] forKey:key_OrderDetails];
                    [_aryRestaurantOrderedList addObject:dicRestaurantDetails];
                }
                
                [[UIConstants returnInstance] setAryOrderedRestaurantsList:_aryRestaurantOrderedList];
                //BOOL IsRetaurantAdded = NO;
                
                // if([_aryRestaurantOrderedList count] > 0){
                   
                    //if ([_dicOrederedRestaurant objectForKey:key_RestaurantID] == [[dicItemDetail objectForKey:key_RestaurantDetail] objectForKey:key_Identifier]) {
                        
//                        IsRetaurantAdded = YES;
//                    }else{
//                        IsRetaurantAdded = NO;
//                    }
//                }
//                if (!IsRetaurantAdded) {
//                    [dicRestaurantDetails setObject:[NSMutableArray arrayWithObjects:dic, nil] forKey:key_OrderDetails];
//                    [_aryRestaurantOrderedList addObject:dicRestaurantDetails];
//                    [[UIConstants returnInstance] setAryOrderedRestaurantsList:_aryRestaurantOrderedList];
//                }
               // NSLog(@"%@", _aryRestaurantOrderedList);
                [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_ItemAddedToCart_English:Alert_ItemAddedToCart_Arabic];
                
                for (UIViewController *viewController in self.tabBarController.viewControllers) {
                    if (viewController.tabBarItem.tag == 2) {
                        viewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",[aryCartDetails count]];
                    }
                }
                //self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",[aryCartDetails count]];
                [aryCartDetails release], aryCartDetails = nil;
                [[UIConstants returnInstance] setIsComingForEditing:NO];
                [self.delegate GoBack:YES];
            }else {
//                if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
                if(![[UIConstants returnInstance] isItEnglish]){
                    [[UIConstants returnInstance] ShowAlert:Alert_MenuItemNotAvailable_Arabic];
                }else {
                    [[UIConstants returnInstance] ShowAlert:Alert_MenuItemNotAvailable_English];
                }
            }
        }
    }
}

-(void)OnClickSelectItemTypeButton:(id)Sender
{
//    if (arySelectedMenuCustomize != nil) {
//        [arySelectedMenuCustomize release];
//    }
//    arySelectedMenuCustomize = [[NSMutableArray alloc] init];
    UIButton *_btnTemp = (UIButton *)Sender;
    //UIView *ViewSuperView = [_btnTemp superview];
    if (_btnTemp.tag != SelectedButtonTag) {
        for (NSDictionary *_dic in aryMenuGroup) {
            if (_btnTemp.tag == [[_dic objectForKey:key_OrderByGroup] integerValue]) {
                [self SetLabelValues:_dic];
                if ([[UIConstants returnInstance] IsComingForEditing]) {
                    NSDictionary *_dicExistingItem = [[UIConstants returnInstance] dicSelectedItemFromOrderSummary];
                    if ([[_dic objectForKey:key_ItemCode] isEqualToString:[_dicExistingItem objectForKey:key_ItemID]]) {
                        txtFldQuantity.text = [_dicExistingItem objectForKey:key_Quantity];
                        lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@", [[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[_dicExistingItem objectForKey:key_TotalPrice] floatValue]]];
                        [arySelectedMenuCustomize addObjectsFromArray:[_dicExistingItem objectForKey:key_CustomizationOptions]];
                        if (isempty([_dicExistingItem objectForKey:key_Customization])) {
                            txtViewCustomizeDish.textColor = [UIColor blackColor];
                            txtViewCustomizeDish.text = [_dicExistingItem objectForKey:key_Customization];
                        }
                    }else{
                        [arySelectedMenuCustomize removeAllObjects];
                    }
                }
                for (UIView *view in [scrollViewItemDetails subviews]) {
                    if (view.tag == SelectedButtonTag) {
                        for (UIView *view1 in [view subviews]) {
                            if ([view1 isKindOfClass:[UIButton class]]) {
                                UIButton *btn = (UIButton *)view1;
                                btn.enabled = YES;
                            }else if([view1 isKindOfClass:[UIImageView class]]){
                                UIImageView *imgView = (UIImageView *)view1;
                                imgView.highlighted = NO;
                            }
                        }
                        break;
                    }
                }
                SelectedButtonTag = _btnTemp.tag;
                _btnTemp.enabled = NO;
                for (UIImageView *_imgView in [_btnTemp.superview subviews]) {
                    _imgView.highlighted = YES;
                }
            }
        }
    }
}

-(void)OnClickDropDownMenuButton:(id)Sender
{
    UIButton *_btnTemp = (UIButton *)Sender;
    UIView *_viewTemp = [_btnTemp superview];
    for (UIImageView *_imgView in [_viewTemp subviews]) {
        if (_imgView.tag == 2) {
            if (_imgView.image == [UIImage imageNamed:@"downArrow.png"]) {
                _imgView.image = [UIImage imageNamed:@"upArrow.png"];
                for (UIImageView *_imgView1 in [_viewTemp subviews]) {
                    if (_imgView1.tag == 1) {
                        _imgView1.image = [UIImage imageNamed:@"toppings_selectionState.png"];
                        break;
                    }
                }
                
                BOOL isMultiSelect;
                if ([[[aryMenuCustomize objectAtIndex:_viewTemp.tag - 1000] objectForKey:key_IsMultiSelect] integerValue] == 0) {
                    isMultiSelect = NO;
                }else{
                    isMultiSelect = YES;
                }
                
                for (NSDictionary *_dic in aryMenuGroup) {
                    if (SelectedButtonTag == [[_dic objectForKey:key_OrderByGroup] integerValue]) {
                        UIView *_viewMenuItem = [self ReturnMenuItemView:[[[_dic objectForKey:key_MenuCustomize] objectAtIndex:_viewTemp.tag - 1000] objectForKey:key_Options]:_viewTemp.tag+1000 :isMultiSelect];
                        _viewMenuItem.frame = CGRectMake(_viewTemp.frame.origin.x, _viewTemp.frame.origin.y + _viewTemp.frame.size.height, _viewMenuItem.frame.size.width, _viewMenuItem.frame.size.height);
                        for (UIView *_subView in [scrollViewItemDetails subviews]) {                            
                            if (_subView.tag  > _viewTemp.tag) {
                                 NSLog(@"tag: %i", _subView.tag);
                                if (_subView.tag >= 2000) {
                                    if (_subView.tag - 1000 > _viewTemp.tag) {
                                        _subView.frame = CGRectMake(_subView.frame.origin.x, _subView.frame.origin.y + _viewMenuItem.frame.size.height, _subView.frame.size.width, _subView.frame.size.height);
                                    }
                                }else{
                                    _subView.frame = CGRectMake(_subView.frame.origin.x, _subView.frame.origin.y + _viewMenuItem.frame.size.height, _subView.frame.size.width, _subView.frame.size.height);
                                }
                            }
                        }
                        [scrollViewItemDetails addSubview:_viewMenuItem];
                        [scrollViewItemDetails setContentSize:CGSizeMake(0, scrollViewItemDetails.contentSize.height+_viewMenuItem.frame.size.height)];
                        break;
                    }
                }
                break;
            }else {
                _imgView.image = [UIImage imageNamed:@"downArrow.png"];
                for (UIImageView *_imgView1 in [_viewTemp subviews]) {
                    if (_imgView1.tag == 1) {
                        _imgView1.image = [UIImage imageNamed:@"toppings_nonselection.png"];
                        break;
                    }
                    
                }
                for (UIView *_viewMenuItem in [scrollViewItemDetails subviews]) {
                    if (_viewMenuItem.tag == _viewTemp.tag+1000) {
                        [_viewMenuItem removeFromSuperview];
                        for (UIView *_subView in [scrollViewItemDetails subviews]) {
                            if (_subView.tag > _viewTemp.tag) {
                                NSLog(@"tag: %i", _subView.tag);
                                if (_subView.tag >= 2000) {
                                    if (_subView.tag - 1000 > _viewTemp.tag) {
                                        _subView.frame = CGRectMake(_subView.frame.origin.x, _subView.frame.origin.y - _viewMenuItem.frame.size.height, _subView.frame.size.width, _subView.frame.size.height);
                                    }
                                }else{
                                    _subView.frame = CGRectMake(_subView.frame.origin.x, _subView.frame.origin.y - _viewMenuItem.frame.size.height, _subView.frame.size.width, _subView.frame.size.height);
                                }
                            }
                        }
                        [scrollViewItemDetails setContentSize:CGSizeMake(0, scrollViewItemDetails.contentSize.height-_viewMenuItem.frame.size.height)];
                        break;
                    }
                }
                break;
            }
        }
    }
    
}

-(void)OnClickMenuItem:(id)Sender
{
    NSString *price = lblAmountForQuantity.text;
    UIButton *button = (UIButton *)Sender;
    UIImageView *_imgViewButton = Nil;
    for (UIView *view in [button.superview subviews]) {
        if([view isKindOfClass:[UIImageView class]]){
            _imgViewButton = (UIImageView *)view;
            
        }
    }
    
    if (_imgViewButton.isHighlighted == NO) {
        int NoOfSelectedItemFromThisMenu = 0;
        
        for (NSDictionary *dic in [[aryMenuCustomize objectAtIndex:button.superview.superview.tag-2000] objectForKey:key_Options]) {
            if ([arySelectedMenuCustomize count]>0) {
                for (NSDictionary *dic1 in [[arySelectedMenuCustomize copy] autorelease]) {
                    if ([[dic objectForKey:key_IdCustomizationMaster] integerValue] == [[dic1 objectForKey:key_CustomizationId] integerValue]) {
                        NoOfSelectedItemFromThisMenu = NoOfSelectedItemFromThisMenu + 1;
                        if ([[[aryMenuCustomize objectAtIndex:button.superview.superview.tag-2000] objectForKey:key_IsMultiSelect] integerValue] ==   0) {
                            [arySelectedMenuCustomize removeObject:dic1];
                            for (UIView *view in [button.superview.superview subviews]) {
                                for(UIView *Image in [view subviews]){
                                    if ([Image isKindOfClass:[UIImageView class]]) {
                                        NSLog(@"%i",view.tag);
                                        UIImageView *buttonImage = (UIImageView *)Image;
                                        buttonImage.highlighted = NO;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        NSLog(@"NoOfSelectedItemFromThisMenu: %i",NoOfSelectedItemFromThisMenu);
        
//        if ([[[aryMenuCustomize objectAtIndex:button.superview.superview.tag-2000] objectForKey:key_IsMultiSelect] integerValue] ==   0) {
//            if (NoOfSelectedItemFromThisMenu >= 1) {
////                if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
//                if(![[UIConstants returnInstance] isItEnglish]){
//                    [[UIConstants returnInstance] ShowAlert:Alert_NoMultipleSelection_Arabic];
//                }else{
//                    [[UIConstants returnInstance] ShowAlert:Alert_NoMultipleSelection_English];
//                }
//                return;
//            }
//        }else{
            if ([[[aryMenuCustomize objectAtIndex:button.superview.superview.tag-2000] objectForKey:key_MultiSelectLimit] integerValue] > 0) {
                if ([[[aryMenuCustomize objectAtIndex:button.superview.superview.tag-2000] objectForKey:key_MultiSelectLimit] integerValue] <= NoOfSelectedItemFromThisMenu) {
//                    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
                    if(![[UIConstants returnInstance] isItEnglish]){
                        [[UIConstants returnInstance] ShowAlert:[NSString stringWithFormat:Alert_MultiSelectionLimitExceeds_Arabic,NoOfSelectedItemFromThisMenu]];
                    }else{
                        [[UIConstants returnInstance] ShowAlert:[NSString stringWithFormat:Alert_MultiSelectionLimitExceeds_English,NoOfSelectedItemFromThisMenu]];
                    }
                    return;
                }
            }
//        }
        
        for (NSMutableDictionary *dic in [[aryMenuCustomize objectAtIndex:button.superview.superview.tag-2000] objectForKey:key_Options]) {
            if ([[dic objectForKey:key_IdCustomizationMaster] integerValue] == button.superview.tag) {
                NSString *_strPrice = nil;
                
                if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
                    _strPrice = [dic objectForKey:key_DoorDeliveryItemPrice];
                }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]) {
                    _strPrice = [dic objectForKey:key_TakeAwayItemPrice];
                }
//                NSString * totalPrice =[NSString stringWithFormat:@"%.3f",[_strPrice floatValue]*[txtFldQuantity.text integerValue]];
                NSString * totalPrice =[NSString stringWithFormat:@"%@",[[UIConstants returnInstance] convertToDecimalValue:([_strPrice floatValue]*[txtFldQuantity.text integerValue])]];
                NSLog(@"Price: %@", _strPrice);
                NSLog(@"dictionary: %@", [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [dic objectForKey:key_IdCustomizationMaster],key_CustomizationId,
                                          [dic objectForKey:key_ItemName], key_CustomizationName,
                                          [dic objectForKey:key_CustomizationGroupNameIdentifier],key_CustomizationIdentifier,
                                          txtFldQuantity.text,key_Qty,
                                          _strPrice, key_ItemCost,
                                          totalPrice, key_TotalCost,nil]);
                
                [arySelectedMenuCustomize addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                     [dic objectForKey:key_IdCustomizationMaster],key_CustomizationId,
                                                     [dic objectForKey:key_ItemName], key_CustomizationName,
                                                     [dic objectForKey:key_CustomizationGroupNameIdentifier],key_CustomizationIdentifier,
                                                     txtFldQuantity.text,key_Qty,
                                                     _strPrice, key_ItemCost,
                                                     totalPrice, key_TotalCost,nil]];
                
                if ([txtFldQuantity.text integerValue] > 0) {
                    float priceForAddings = 0;
                    for (NSDictionary *dic in arySelectedMenuCustomize) {
                        priceForAddings = priceForAddings + [[dic objectForKey:key_ItemCost] floatValue];
                    }
//                    lblTotalAmount.text = [NSString stringWithFormat:@"%@ %.3f",[[UIConstants returnInstance] strCurrencyCode],[txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue]];
                    
                lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:([txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue])]];

                    
//                    strTotalAmount = [NSString stringWithFormat:@"%.3f",[txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue]];
//                    NSLog(@"%@",strTotalAmount);
                }
                NSLog(@"%i", [arySelectedMenuCustomize count]);
                break;
            }
        }
        //[button setImage:[UIImage imageNamed:@"checkmarkSelection.png"] forState:UIControlStateNormal];
        _imgViewButton.highlighted = YES;
    }else{
        //[button setImage:[UIImage imageNamed:@"checkmarkNonSelection.png"] forState:UIControlStateNormal];
        _imgViewButton.highlighted = NO;
        for (NSMutableDictionary *dic in arySelectedMenuCustomize) {
            if ([[dic objectForKey:key_CustomizationId] integerValue] == button.superview.tag) {
                [arySelectedMenuCustomize removeObject:dic];
                if ([txtFldQuantity.text integerValue] > 0) {
                    float priceForAddings = 0;
                    for (NSDictionary *dic in arySelectedMenuCustomize) {
                        priceForAddings = priceForAddings + [[dic objectForKey:key_ItemCost] floatValue];
                    }
//                    lblTotalAmount.text = [NSString stringWithFormat:@"%@ %.3f",[[UIConstants returnInstance] strCurrencyCode],[txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue]];
                    
                    lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance]convertToDecimalValue:([txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue])]];

//                    strTotalAmount = [NSString stringWithFormat:@"%.3f",[txtFldQuantity.text integerValue]* [price floatValue]+priceForAddings*[txtFldQuantity.text integerValue]];
//                    NSLog(@"%@", strTotalAmount);
                }
                NSLog(@"%i", [arySelectedMenuCustomize count]);
                break;
            }
        }
    }
}

#pragma mark - Change Language to Arabic
    
-(void)ChangeLanguageToArabic
{
    [btnLogin setTitle:(NSString *)Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];
    
    [btnGoBack setTitle:(NSString *)Back_Arabic forState:UIControlStateNormal];
    
    [btnAddToCart setTitle:(NSString *)AddToCart_Arabic forState:UIControlStateNormal];
    
    UIConstants *constant = [UIConstants returnInstance];
    CGRect rect = self.view.frame;
   // imgViewItem.frame =[constant getFrameForLanguage:imgViewItem.frame withSuperViewRect:rect];
   // lblNameOfItem.frame = [constant getFrameForLanguage:lblNameOfItem.frame withSuperViewRect:rect];
    //lblDetails.frame = [constant getFrameForLanguage:lblDetails.frame withSuperViewRect:rect];
    
    lblNameOfItem.textAlignment = NSTextAlignmentRight;
    lblDetails.textAlignment = NSTextAlignmentRight;
    
    lblQuantityName.frame =[constant getFrameForLanguage:lblQuantityName.frame withSuperViewRect:rect];
    lblRsName.frame = [constant getFrameForLanguage:lblRsName.frame withSuperViewRect:rect];
    lblAmountForQuantity.frame = [constant getFrameForLanguage:lblAmountForQuantity.frame withSuperViewRect:rect];
    lblAmountName.frame = [constant getFrameForLanguage:lblAmountName.frame withSuperViewRect:rect];
    lblTotalAmount.frame = [constant getFrameForLanguage:lblTotalAmount.frame withSuperViewRect:rect];
    
    btnAddToCart.frame = [constant getFrameForLanguage:btnAddToCart.frame withSuperViewRect:rect];
   // lblQuantityName.textAlignment = NSTextAlignmentRight;
    lblRsName.textAlignment = NSTextAlignmentRight;
    lblAmountForQuantity.textAlignment = NSTextAlignmentRight;
 //   lblAmountName.textAlignment = FOS_TEXTALIGNMENT;
    lblTotalAmount.textAlignment = FOS_TEXTALIGNMENT;
    
    lblQuantityName.text = (NSString *)Quantity_Arabic;
    lblAmountName.text = (NSString *)Amount_Arabic;
    
    imgViewQuantityBG.frame = [constant getFrameForLanguage:imgViewQuantityBG.frame withSuperViewRect:rect];
    viewMinusButton.frame = [constant getFrameForLanguage:viewMinusButton.frame withSuperViewRect:rect];
    viewPlusButton.frame = [constant getFrameForLanguage:viewPlusButton.frame withSuperViewRect:rect];
    txtFldQuantity.frame = [constant getFrameForLanguage:txtFldQuantity.frame withSuperViewRect:rect];
    txtViewCustomizeDish.textAlignment = NSTextAlignmentRight;
    lblDetails.backgroundColor = [UIColor clearColor];
    if ([txtViewCustomizeDish.text isEqual: @"Customize Your Dish"]) {
        txtViewCustomizeDish.text = CustomizeDish_Arabic;
    }
    
    
    // convert it to arabic
    imgViewItem.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewItem.frame withSuperViewRect:self.view.frame];
    lblNameOfItem.frame = [[UIConstants returnInstance] getFrameForLanguage:lblNameOfItem.frame withSuperViewRect:self.view.frame];
    lblDetails.frame = [[UIConstants returnInstance] getFrameForLanguage:lblDetails.frame withSuperViewRect:self.view.frame];
    
}

#pragma mark - Text field delegate methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if([txtFldQuantity.text integerValue] == 0) {
//        scrollViewItemDetails.frame = CGRectMake(scrollViewItemDetails.frame.origin.x, scrollViewItemDetails.frame.origin.y, scrollViewItemDetails.frame.size.width, scrollViewItemDetails.frame.size.height+viewFooter.frame.size.height);
//        viewFooter.hidden = YES;
//    }else{
//        if([txtFldQuantity.text integerValue] == 1) {
//            scrollViewItemDetails.frame = CGRectMake(scrollViewItemDetails.frame.origin.x, scrollViewItemDetails.frame.origin.y, scrollViewItemDetails.frame.size.width, scrollViewItemDetails.frame.size.height-viewFooter.frame.size.height);
//        }
//        viewFooter.hidden = NO;
//    }
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - TextView Delegate Methods
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, -165, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    if ([textView.text isEqualToString:@"Customize Your Dish"] || [textView.text isEqualToString:(NSString *)CustomizeDish_Arabic]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@"\n"]) {
        if ([textView.text length] == 0 && [text isEqualToString:@" "]) {
            return NO;
        }else if ([textView.text length] > 0 && [text isEqualToString:@""]) {
            return YES;
        }
    }else if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        return NO;
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([textView.text length] == 0) {
//        if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
            if(![[UIConstants returnInstance] isItEnglish]){
            textView.text = CustomizeDish_Arabic;
        }else{
            textView.text = @"Customize Your Dish";
        }
        textView.textColor = [UIColor darkGrayColor];
    }
    return YES;
}

#pragma mark - Touch method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([txtFldQuantity isFirstResponder]) {
        [txtFldQuantity resignFirstResponder];
    }else if ([txtViewCustomizeDish isFirstResponder]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        [txtViewCustomizeDish resignFirstResponder];
    }
    if (viewLoginMenu.superview != nil) {
        [viewLoginMenu removeFromSuperview];
    }
    if (viewUserMenu.superview != nil) {
        [viewUserMenu removeFromSuperview];
    }
}

#pragma mark - Set Values for Label

-(void)HideImageView
{
    imgViewItem.hidden = YES;
    BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
    if(isArabic){
        // calculate the value
        lblNameOfItem.frame = CGRectMake(lblNameOfItem.frame.origin.x, lblNameOfItem.frame.origin.y, lblNameOfItem.frame.size.width+imgViewItem.frame.size.width+15, lblNameOfItem.frame.size.height);
        
        
        lblDetails.frame = CGRectMake(lblDetails.frame.origin.x, lblDetails.frame.origin.y, lblDetails.frame.size.width+imgViewItem.frame.size.width+15, lblDetails.frame.size.height);
        
    }else{
        // calculate the value
        lblNameOfItem.frame = CGRectMake(imgViewItem.frame.origin.x, lblNameOfItem.frame.origin.y, lblNameOfItem.frame.size.width+imgViewItem.frame.size.width+15, lblNameOfItem.frame.size.height);
        
        
        lblDetails.frame = CGRectMake(imgViewItem.frame.origin.x, lblDetails.frame.origin.y, lblDetails.frame.size.width+imgViewItem.frame.size.width+15, lblDetails.frame.size.height);

    }
    
    
   
}

-(void)SetLabelValues:(NSDictionary *)_dicItemDetails
{
    dicMenuItem = _dicItemDetails;
    if(![imgViewItem isHidden] && [_dicItemDetails objectForKey:key_ImageURL1] == [NSNull null]){
        [self HideImageView];
    }else{
        if ([_dicItemDetails objectForKey:key_ImageURL1] != [NSNull null]) {
            if ([[UIConstants returnInstance] ReturnImageForURL:[_dicItemDetails objectForKey:key_ImageURL1]] != nil) {
                imgViewItem.image = [[UIConstants returnInstance] ReturnImageForURL:[_dicItemDetails objectForKey:key_ImageURL1]];
                if ([imgViewItem isHidden]) {
                    imgViewItem.hidden = NO;
                    //calulate the value
                    lblNameOfItem.frame = CGRectMake(imgViewItem.frame.origin.x+imgViewItem.frame.size.width+15, lblNameOfItem.frame.origin.y, lblNameOfItem.frame.size.width-imgViewItem.frame.size.width, lblNameOfItem.frame.size.height);
                    
                  
                    lblDetails.frame = CGRectMake(imgViewItem.frame.origin.x+imgViewItem.frame.size.width+15, lblDetails.frame.origin.y, lblDetails.frame.size.width-imgViewItem.frame.size.width, lblDetails.frame.size.height);
                    
                    // convert it to arabic
                      lblNameOfItem.frame =[[UIConstants returnInstance] getFrameForLanguage:lblNameOfItem.frame withSuperViewRect:self.view.frame];
                    
                    lblDetails.frame = [[UIConstants returnInstance] getFrameForLanguage:lblDetails.frame withSuperViewRect:self.view.frame];
                }
            }else{
               // [self HideImageView];
            }
        }
    }
    lblNameOfItem.text = [_dicItemDetails objectForKey:key_ItemName];
    if ([_dicItemDetails objectForKey:key_MenuDescription] != [NSNull null]) {
        lblDetails.text = [_dicItemDetails objectForKey:key_MenuDescription];
    }
    
    lblRsName.text = [[UIConstants returnInstance] strCurrencyCode];
        
    
    if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
        //lblAmountForQuantity.text = [NSString stringWithFormat:@"%.3f",[[_dicItemDetails objectForKey:key_DoorDeliveryItemPrice] floatValue]];
        lblAmountForQuantity.text = [NSString stringWithFormat:@"%@",[[UIConstants returnInstance] convertToDecimalValue:[[_dicItemDetails objectForKey:key_DoorDeliveryItemPrice] floatValue]]];
    }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]) {
        lblAmountForQuantity.text = [NSString stringWithFormat:@"%@",[[UIConstants returnInstance] convertToDecimalValue:[[_dicItemDetails objectForKey:key_TakeAwayItemPrice] floatValue]]];
    }
    
    aryMenuCustomize = [_dicItemDetails objectForKey:key_MenuCustomize];
    NSString *price = lblAmountForQuantity.text  ;
    if ([txtFldQuantity.text integerValue] > 0) {
        if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
            lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:([txtFldQuantity.text integerValue]*[price floatValue])]];
//            strTotalAmount = [NSString stringWithFormat:@"%.3f",[txtFldQuantity.text integerValue]*[price floatValue]];
//            NSLog(@"%@", strTotalAmount);
        }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]) {
            lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:([txtFldQuantity.text integerValue]*[price floatValue])]];
//            strTotalAmount = [NSString stringWithFormat:@"%.3f",[txtFldQuantity.text integerValue]*[price floatValue]];
//            NSLog(@"%@", strTotalAmount);
        }
    }
    
    if ([[_dicItemDetails objectForKey:key_IsCustomizationOption] integerValue] == 1) {
        NoOfMenuItems = [[_dicItemDetails objectForKey:key_MenuCustomize] count];
        _positionX = 10;
        NSLog(@"Position Y: %i",_positionY);
       // for(int j = 0; j < NoOfMenuItems; j++) {
            for (UIView *_viewTemp in [scrollViewItemDetails subviews]) {
                if (_viewTemp.tag >= 1000 && _viewTemp.tag < 10000) {
                    NSLog(@"Removed View Tag: %i", _viewTemp.tag);
                    if (_viewTemp.tag<2000) {
                        _positionY = _positionY - _viewTemp.frame.size.height - 10;
                        [scrollViewItemDetails setContentSize:CGSizeMake(0, _positionY)];
                    }
                    [_viewTemp removeFromSuperview];
                }
            }
       // }
         NSLog(@"Position Y: %i",_positionY);
        for(int i = 0; i < NoOfMenuItems; i++) {
    //        for (UIView *_viewTemp in [scrollViewItemDetails subviews]) {
    //            if (_viewTemp.tag == i+1000) {
    //                _positionY = _positionY - _viewTemp.frame.size.height - 10;
    //                [_viewTemp removeFromSuperview];
    //            }
    //        }
            UIView *_viewMenuItem = [self ReturnMenuView:[[_dicItemDetails objectForKey:key_MenuCustomize] objectAtIndex:i]:i+1000];
            _viewMenuItem.frame = CGRectMake(_positionX, _positionY, _viewMenuItem.frame.size.width, _viewMenuItem.frame.size.height);
            [scrollViewItemDetails addSubview:_viewMenuItem];
            _positionY = _positionY + _viewMenuItem.frame.size.height + 10;
        }
        [scrollViewItemDetails setContentSize:CGSizeMake(0, _positionY)];
    }
    if ([[_dicItemDetails objectForKey:key_IsMenuCustomizable] integerValue] == 1) {
        txtViewCustomizeDish.frame = CGRectMake(txtViewCustomizeDish.frame.origin.x, _positionY, txtViewCustomizeDish.frame.size.width, txtViewCustomizeDish.frame.size.height);
        [scrollViewItemDetails setContentSize:CGSizeMake(0, _positionY+txtViewCustomizeDish.frame.size.height+30)];
    }else{
        txtViewCustomizeDish.hidden = YES;
    }
}

#pragma mark - Return View Methods

-(UIView *)ReturnGroupView:(NSDictionary *)_dicItemDetails
{
    int _width = 145;
    int _height = 30;
    
    UIView *_viewGroup = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    _viewGroup.tag = [[_dicItemDetails valueForKey:key_OrderByGroup] integerValue];
  
    UIConstants *constant = [UIConstants returnInstance];
    CGRect rect =[constant getFrameForLanguage:CGRectMake(5, 5, 20, 20) withSuperViewRect:_viewGroup.frame];
    
    UIImageView *_imgViewButton = [[UIImageView alloc] initWithFrame:rect];
    _imgViewButton.image = [UIImage imageNamed:@"RadioButton_NonSelected_MenuItem.png"];
    _imgViewButton.highlightedImage = [UIImage imageNamed:@"RadioButton_selected_MenuItem.png"];
    
     UIButton *_btnOption = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    _btnOption.tag = [[_dicItemDetails valueForKey:key_OrderByGroup] integerValue];
    
    [_btnOption addTarget:self action:@selector(OnClickSelectItemTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    rect =[constant getFrameForLanguage:CGRectMake(30, 5, 90, 20) withSuperViewRect:_viewGroup.frame];

    UILabel *_lblOptionName = [[UILabel alloc]initWithFrame:rect];
    _lblOptionName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    _lblOptionName.backgroundColor = [UIColor clearColor];
    _lblOptionName.textColor = [UIColor colorWithRed:41.0/255.0 green:25.0/255.0 blue:16.0/255.0 alpha:1];
    _lblOptionName.text = [_dicItemDetails valueForKey:key_GroupName];
    _lblOptionName.textAlignment = FOS_TEXTALIGNMENT;

 [_viewGroup addSubview:_imgViewButton];
  
    [_viewGroup addSubview:_lblOptionName];
  [_viewGroup addSubview:_btnOption];    
    [_btnOption release], _btnOption = nil;
    [_lblOptionName release], _lblOptionName = nil;
    
    return _viewGroup;
}

- (UIView *)ReturnMenuView:(NSDictionary *)_dicCustomMenu :(int)Index
{
    UIConstants *constant = [UIConstants returnInstance];
    int _width = 300;
    int _height = 40;
    
    UIView *_viewMenu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    _viewMenu.tag = Index;
    
    UIImageView *_imageViewMenu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    _imageViewMenu.image = [UIImage imageNamed:@"toppings_nonselection.png"];
    _imageViewMenu.tag = 1;
    
    UIButton *_btnDropDownMenu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    _btnDropDownMenu.tag = Index;
    [_btnDropDownMenu addTarget:self action:@selector(OnClickDropDownMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect rect =[constant getFrameForLanguage:CGRectMake(275, 13, 10, 14) withSuperViewRect:_viewMenu.frame];
    UIImageView *_imgViewDropDown = [[UIImageView alloc] initWithFrame:rect];
    _imgViewDropDown.tag = 2;
    _imgViewDropDown.image = [UIImage imageNamed:@"downArrow.png"];
    
    rect =[constant getFrameForLanguage:CGRectMake(10, 5, 260, 20) withSuperViewRect:_viewMenu.frame];
    UILabel *_lblMenuName = [[UILabel alloc]initWithFrame:rect];
    _lblMenuName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    _lblMenuName.textColor = [UIColor colorWithRed:65.0/255.0 green:77.0/255.0 blue:18.0/255.0 alpha:1];
    _lblMenuName.text = [_dicCustomMenu objectForKey:key_CustomizationGroupName];
    _lblMenuName.backgroundColor = [UIColor clearColor];
    _lblMenuName.textAlignment = FOS_TEXTALIGNMENT;
    
    rect =[constant getFrameForLanguage:CGRectMake(10, 25, 260, 15) withSuperViewRect:_viewMenu.frame];
    UILabel *_lblMinMax = [[UILabel alloc]initWithFrame:rect];
    _lblMinMax.font = [[UIConstants returnInstance] returnArvoRegular:10];
    _lblMinMax.backgroundColor = [UIColor clearColor];
    _lblMinMax.textAlignment = FOS_TEXTALIGNMENT;
    
    NSMutableString *strMinMax = [[NSMutableString alloc] init];
    
    if ([[_dicCustomMenu objectForKey:key_IsCustomizationGroupMandatory] integerValue] == 1) {
        [strMinMax appendString:[[UIConstants returnInstance] isItEnglish]?Minimum_English:Minimum_Arabic];
        [strMinMax appendString:@"1 - "];
    }
    [strMinMax appendString:[[UIConstants returnInstance] isItEnglish]?Maximum_English:Maximum_Arabic];
    if ([[_dicCustomMenu objectForKey:key_IsMultiSelect] integerValue] == 1) {
        [strMinMax appendString:[NSString stringWithFormat:@"%@",[_dicCustomMenu objectForKey:key_MultiSelectLimit]]];
    }else{
        [strMinMax appendString:@"1"];
    }

    
    _lblMinMax.text = [NSString stringWithFormat:@"(%@)", strMinMax];
    
    [_viewMenu addSubview:_imageViewMenu];
    [_viewMenu addSubview:_btnDropDownMenu];
    [_viewMenu addSubview:_imgViewDropDown];
    [_viewMenu addSubview:_lblMenuName];
    [_viewMenu addSubview:_lblMinMax];
    
    [_imageViewMenu release], _imageViewMenu = nil;
    [_btnDropDownMenu release], _btnDropDownMenu = nil;
    [_imgViewDropDown release], _imgViewDropDown = nil;
    [_lblMenuName release], _lblMenuName = nil;
    
    return _viewMenu;
}

-(UIView *)ReturnMenuItemView:(NSArray *)aryMenuItemList :(int)Index :(BOOL)IsItMultiSelect
{
    aryMenuItem = [[NSMutableArray alloc] initWithArray:[self SortArrayBasedOnOrderByGroupforArray:(NSMutableArray *)aryMenuItemList]];
    
    int _width = 300;
    
    int _noOfRows = [aryMenuItem count];
//    if ([aryMenuItem count] % 2 == 0) {
//        _noOfRows = [aryMenuItem count] / 2;
//    }else{
//        _noOfRows = [aryMenuItem count] / 2 + 1;
//    }
    int _hight = 35*_noOfRows+5;
    
    int X = 10;
    int Y = 5;
    
    UIView *_viewMenuItemList = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _hight)];
    _viewMenuItemList.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:247.0/255.0 blue:88.0/255.0 alpha:1];;
    _viewMenuItemList.tag = Index;
    
    _viewMenuItemList.layer.masksToBounds = YES;
    _viewMenuItemList.layer.cornerRadius = 3;
    _viewMenuItemList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _viewMenuItemList.layer.borderWidth = 1;
    
//    int _aryIndex = 0;
    
   // int _widthOfItem = 135;
    int _hightOfItem = 30;
    for (int i = 0; i < _noOfRows; i++) {
//        for (int j = 0; j < 2; j++) {
//            NSLog(@"%i", _aryIndex);
//            if (_aryIndex < [aryMenuItem count]) {
                NSString *_strPrice = 0;
                if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
                    _strPrice = [[aryMenuItem objectAtIndex:i] objectForKey:key_DoorDeliveryItemPrice];
                }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]) {
                    _strPrice = [[aryMenuItem objectAtIndex:i] objectForKey:key_TakeAwayItemPrice];
                }
                NSString *_strName;
                if ([_strPrice floatValue] > 0) {
                    _strName = [NSString stringWithFormat:@"%@ \n(%@ %@)",[[aryMenuItem objectAtIndex:i] objectForKey:key_ItemName],[[UIConstants returnInstance] strCurrencyCode],_strPrice];
                }else{
                    _strName = [[aryMenuItem objectAtIndex:i] objectForKey:key_ItemName];
                }
                UIView *_viewOfItem = [self ReturnMenuItem:X :Y :_strName :IsItMultiSelect :[[aryMenuItem objectAtIndex:i] objectForKey:key_IdCustomizationMaster]];
                _viewOfItem.tag = [[[aryMenuItem objectAtIndex:i] objectForKey:key_IdCustomizationMaster]  integerValue];
                [_viewMenuItemList addSubview:_viewOfItem];
//                _aryIndex = _aryIndex + 1;
//                X = X + _widthOfItem + 10;
//            }
//        }
//        X = 10;
        Y = Y + _hightOfItem + 5;
    }
    [aryMenuItem release], aryMenuItem = nil;
    return _viewMenuItemList;
}

-(UIView *)ReturnMenuItem:(int)PositionX :(int)PositionY :(NSString *)NameOfItem :(BOOL)IsItMultiSelect :(NSString *)IdentifierItem
{
    UIConstants *constant = [UIConstants returnInstance];
    CGRect rect; //[constant getFrameForLanguage:CGRectMake(275, 13, 10, 14) withSuperViewRect:_viewMenu.frame];
    int _width = 280;
    int _height = 30;
    
    UIView *_viewMenuItem = [[UIView alloc] initWithFrame:CGRectMake(PositionX, PositionY, _width, _height)];
    _viewMenuItem.backgroundColor = [UIColor clearColor];
  
    UIImage *imageSelected;
    UIImage *imageNonSelected;
    
    if (IsItMultiSelect) {
        imageSelected = [UIImage imageNamed:@"checkmarkSelection.png"];
        imageNonSelected = [UIImage imageNamed:@"checkmarkNonSelection.png"];
    }else{
        imageNonSelected = [UIImage imageNamed:@"RadioButton_NonSelected_MenuItem.png"];
        imageSelected  = [UIImage imageNamed:@"RadioButton_selected_MenuItem.png"];
    }
    
    rect = [constant getFrameForLanguage:CGRectMake(5, 5, 20, 20) withSuperViewRect:_viewMenuItem.frame];
    UIImageView *_imgViewButton = [[UIImageView alloc] initWithFrame:rect];
    _imgViewButton.image = imageNonSelected;
    _imgViewButton.highlightedImage = imageSelected;
    
    for(NSDictionary *_dicTemp in arySelectedMenuCustomize) {
        if ([[_dicTemp objectForKey:key_CustomizationId] isEqual:IdentifierItem]) {
            _imgViewButton.highlighted = YES;
            break;
        }
    }
    
    rect = [constant getFrameForLanguage:CGRectMake(30, 0, 240, 30) withSuperViewRect:_viewMenuItem.frame];
    UILabel *_lblOptionName = [[UILabel alloc]initWithFrame:rect];
    _lblOptionName.font = [[UIConstants returnInstance] returnArvoRegular:12];
    _lblOptionName.backgroundColor = [UIColor clearColor];
    _lblOptionName.textColor = [UIColor colorWithRed:65.0/255.0 green:77.0/255.0 blue:18.0/255.0 alpha:1];
    _lblOptionName.text = NameOfItem;
    _lblOptionName.adjustsFontSizeToFitWidth = YES;
    _lblOptionName.numberOfLines = 0;
    _lblOptionName.minimumFontSize = 10;
    _lblOptionName.textAlignment = FOS_TEXTALIGNMENT;
    
    UIButton *_btnOption = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    [_btnOption addTarget:self action:@selector(OnClickMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [_viewMenuItem addSubview:_imgViewButton];
    [_viewMenuItem addSubview:_lblOptionName];
    [_viewMenuItem addSubview:_btnOption];
    
    [_btnOption release], _btnOption = nil;
    [_lblOptionName release], _lblOptionName = nil;
    [_imgViewButton release], _imgViewButton = nil;
    
    return _viewMenuItem;
}

#pragma mark - Return Array by sorting based on order by group

-(NSMutableArray *)SortArrayBasedOnOrderByGroupforArray:(NSMutableArray *)aryForSorting
{
    
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc]initWithKey:key_OrderByGroup ascending:YES];
    return (NSMutableArray *)[aryForSorting sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
}

#pragma mark - Check The existing and new item details
-(BOOL)CompareExistingItem:(NSDictionary *)ExistingDic withNewOne:(NSDictionary *)NewDic
{
    if (![[ExistingDic objectForKey:key_Customization] isEqualToString:[NewDic objectForKey:key_Customization]]) {
        return NO;
    }
    NSArray *arrayCustomizeOption_Existing = [ExistingDic objectForKey:key_CustomizationOptions];
    NSArray *arrayCustomizeOption_New = [NewDic objectForKey:key_CustomizationOptions];
    
    NSLog(@"Arrays %@ == %@", arrayCustomizeOption_Existing, arrayCustomizeOption_New);
    
    if ([arrayCustomizeOption_Existing count] == [arrayCustomizeOption_New count]) {
        for (NSDictionary *dicExisting in arrayCustomizeOption_Existing) {
            BOOL IsAvailable = NO;
            for (NSDictionary *dicNew in arrayCustomizeOption_New) {
                NSLog(@"Dictionaries %@ == %@", dicExisting, dicNew);
                if ([[dicExisting objectForKey:key_CustomizationId] integerValue] == [[dicNew objectForKey:key_CustomizationId] integerValue]) {
                    IsAvailable = YES;
                    break;
                }
            }
            if (!IsAvailable) {
                return NO;
            }
        }
        return YES;
    }else{
        return NO;
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



- (void)dealloc {
    [txtViewCustomizeDish release];
    [super dealloc];
}
@end
