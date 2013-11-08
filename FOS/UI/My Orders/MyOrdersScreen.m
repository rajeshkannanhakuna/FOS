//
//  MyOrdersScreen.m

//
//  Created by segate on 19/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "MyOrdersScreen.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import "APIConstants.h"
#import "ServiceHandler.h"
#import "ResponseDTO.h"
@interface MyOrdersScreen ()<UIActionSheetDelegate>

{
    NSArray *_aryOrderList;
    ServiceHandler *ObjServiceHandler;
    IBOutlet UIButton *loginBtn;
    NSMutableDictionary *dicRestaurantDetail;
    NSMutableArray *aryCartDetail;
}
- (IBAction)loginAction:(UIButton *)sender;
@end

@implementation MyOrdersScreen
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
    // Do any additional setup after loading the view from its nib.
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){    
        [self ChangeLanguageToArabic];
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
        
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    NSLog(@"%@",[[UIConstants returnInstance] strFosUserID]);
    if (![[UIConstants returnInstance] strFosUserID]) {
        tblViewOrderHistory.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[UIConstants returnInstance] isItEnglish]?Alert_English:Alert_Arabic
                                            message:[[UIConstants returnInstance] isItEnglish]?Alert_MustLoginOrderHistory_English:Alert_MustLoginOrderHistory_Arabic
                                            delegate:self
                                            cancelButtonTitle:[[UIConstants returnInstance] isItEnglish]?Login_Eng:Login_Arabic
                                            otherButtonTitles:[[UIConstants returnInstance] isItEnglish]?Cancel_Eng:Cancel_Arabic, nil];
        alert.tag = 1;
        [alert show];
        [alert release];
    }else{
        ObjServiceHandler = [[ServiceHandler alloc] init];
        if ([ObjServiceHandler GetOrderHistoryAPI]) {
            _aryOrderList = [[[ResponseDTO sharedInstance] DTO_OrderHistory] objectForKey:key_Orders];
            if ([_aryOrderList count] > 0) {
                tblViewOrderHistory.hidden = NO;
                [tblViewOrderHistory reloadData];
            }else{
                [[UIConstants returnInstance] ShowAlert:[[UIConstants returnInstance] isItEnglish]?Alert_NoOrdersYet_English:Alert_NoOrdersYet_Arabic];
            }
        }else{
            if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
                [[UIConstants returnInstance] ShowNoNetworkAlert];
            }else{
                [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
            }
        }
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

- (void)dealloc {
    [btnUserMenu release];
    [btnGoBack release];
    [tblViewOrderHistory release];
    [super dealloc];
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
    
}
#pragma mark - Button action methods

- (IBAction)OnClickGoBackButton:(id)sender
{
    [self.delegate GoHome];
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
    [[UIConstants returnInstance]setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_LOGIN];
}

-(void)OnClickRegisterButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [self.delegate LoadNextScreen:VIEW_REGISTER];
}

-(void)OnClickSignOutButton:(id)sender
{
    [[UIConstants returnInstance] setStrFosUserID:nil];
    [btnUserMenu setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    [viewUserMenu removeFromSuperview];
    [self.delegate GoHome];
    btnLogin.hidden = NO;
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

#pragma mark - Table view delegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_aryOrderList count];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[_aryOrderList objectAtIndex:indexPath.row] objectForKey:key_Timings]];
    _cell.backgroundColor = [UIColor clearColor];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGRect _frame = [tableView rectForRowAtIndexPath:indexPath];
    
    NSDictionary *_dic = [_aryOrderList objectAtIndex:indexPath.row];
    
    UIView *_viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
    
    UIConstants *constant =[UIConstants returnInstance];
    
    
    UIImageView *_imgViewCellBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, _viewCell.frame.size.width, _viewCell.frame.size.height-5)];
    if (indexPath.row%2 == 0) {
        _imgViewCellBG.image = [UIImage imageNamed:@"menuitemBG_darkcolor.png"];
    }else{
        _imgViewCellBG.image = [UIImage imageNamed:@"menuitemBG_lightcolor.png"];
    }
    

    UILabel *_lblNoOfItems = [[UILabel alloc]initWithFrame:CGRectMake(5, 35, 15, 15) ];
    
    _lblNoOfItems.text =[NSString stringWithFormat:@"%i" ,[[_dic objectForKey:key_OrderDetails] count]];
    _lblNoOfItems.backgroundColor = [UIColor clearColor];
    _lblNoOfItems.font = [[UIConstants returnInstance] returnArvoBold:15];
    _lblNoOfItems.textColor = [UIColor colorWithRed:41.0/255.0 green:25.0/255.0 blue:16.0/255.0 alpha:1];
    _lblNoOfItems.textAlignment =FOS_TEXTALIGNMENT;
    
 
    UIImageView *_imgViewFood = [[UIImageView alloc] initWithFrame:CGRectMake(_lblNoOfItems.frame.origin.x + _lblNoOfItems.frame.size.width, 30, 30, 25)];
    _imgViewFood.image = [UIImage imageNamed:@"food.png"];
    
    
   
    UILabel *_lblTotalAmountText = [[UILabel alloc] initWithFrame:CGRectMake(_imgViewFood.frame.origin.x+_imgViewFood.frame.size.width + 10,  15, 200, 20)];
    _lblTotalAmountText.text = [_dic objectForKey:key_RestaurantName];;
    
    _lblTotalAmountText.backgroundColor = [UIColor clearColor];
    _lblTotalAmountText.font = [[UIConstants returnInstance] returnArvoRegular:15];
    _lblTotalAmountText.textColor = [UIColor darkGrayColor];
    _lblTotalAmountText.textAlignment = FOS_TEXTALIGNMENT;
    
       UILabel *_lblTotalAmount = [[UILabel alloc] initWithFrame:CGRectMake(_lblTotalAmountText.frame.origin.x, _lblTotalAmountText.frame.origin.y+_lblTotalAmountText.frame.size.height, 200, 20)];
    _lblTotalAmount.text =[NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[_dic valueForKey:key_BillTotal] floatValue]]];
    _lblTotalAmount.backgroundColor = [UIColor clearColor];
    _lblTotalAmount.textAlignment = FOS_TEXTALIGNMENT;
    _lblTotalAmount.font = [[UIConstants returnInstance] returnArvoRegular:15];
    _lblTotalAmount.textColor = [UIColor colorWithRed:236.0/255.0 green:106.0/255.0 blue:25.0/255.0 alpha:1];
//    236,106,25
    
    
    UILabel *_lblDateAndTime = [[UILabel alloc]initWithFrame:CGRectMake(90,_lblTotalAmount.frame.origin.y +_lblTotalAmount.frame.size.height, 200, 20)];
    _lblDateAndTime.text =[NSString stringWithFormat:@"%@", [_dic valueForKey:key_OrderDate]];
    _lblDateAndTime.backgroundColor = [UIColor clearColor];
    //_lblDateAndTime.textAlignment = NSTextAlignmentRight;
    _lblDateAndTime.textColor = [UIColor darkGrayColor];
    _lblDateAndTime.font = [[UIConstants returnInstance] returnArvoRegular:15];
    _lblDateAndTime.textAlignment = FOS_TEXTALIGNMENT_NEGATIVE;
    
    UIImageView *_imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(280 , _viewCell.frame.size.height/2 - 10, 10, 10)];
    _imgArrow.image = [UIImage imageNamed:@"Homearrow.png"];
    
    if(![[UIConstants returnInstance] isItEnglish]){
        _lblTotalAmountText.text = TotalAmount_Arabic;
        _imgArrow.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        
    }
    
    _lblNoOfItems.frame = [constant getFrameForLanguage:_lblNoOfItems.frame withSuperViewRect:_viewCell.frame];
     _imgViewFood.frame = [constant getFrameForLanguage:_imgViewFood.frame withSuperViewRect:_viewCell.frame];
     _lblTotalAmountText.frame = [constant getFrameForLanguage:_lblTotalAmountText.frame withSuperViewRect:_viewCell.frame];
     _lblTotalAmount.frame = [constant getFrameForLanguage:_lblTotalAmount.frame withSuperViewRect:_viewCell.frame];
     _lblDateAndTime.frame = [constant getFrameForLanguage:_lblDateAndTime.frame withSuperViewRect:_viewCell.frame];
     _imgArrow.frame = [constant getFrameForLanguage:_imgArrow.frame withSuperViewRect:_viewCell.frame];
    
    [_viewCell addSubview:_imgViewCellBG];
    [_viewCell addSubview:_lblNoOfItems];
    [_viewCell addSubview:_imgViewFood];
    [_viewCell addSubview:_lblTotalAmountText];
    [_viewCell addSubview:_lblTotalAmount];
    [_viewCell addSubview:_lblDateAndTime];
    [_viewCell addSubview:_imgArrow];
    
    [_cell addSubview:_viewCell];
    return _cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dicRestaurantDetail = [_aryOrderList objectAtIndex:indexPath.row];
    aryCartDetail = [[_aryOrderList objectAtIndex:indexPath.row] objectForKey:key_OrderDetails];
    if ([[dicRestaurantDetail objectForKey:key_IsOrderLocked] integerValue] == 1) {
        if(![[UIConstants returnInstance] isItEnglish]){
            [[UIConstants returnInstance] ShowAlert:Alert_IsOrderLocked_Arabic];
        }else {
            [[UIConstants returnInstance] ShowAlert:Alert_IsOrderLocked_English];
        }
    }else if ([dicRestaurantDetail objectForKey:key_IsRestaurantClosed] == false){
        if(![[UIConstants returnInstance] isItEnglish]){
            [[UIConstants returnInstance] ShowAlert:Alert_IsRestaurantOpen_Arabic];
        }else {
            [[UIConstants returnInstance] ShowAlert:Alert_IsRestaurantOpen_English];
        }
    }else  {
        if ([[[UIConstants returnInstance] aryCartDetails] count] > 0 && [[[UIConstants returnInstance] aryOrderedRestaurantsList] count] > 0) {
            NSLog(@"%@ : %@",[dicRestaurantDetail objectForKey:key_RestaurantID],[[[[UIConstants returnInstance] aryOrderedRestaurantsList] objectAtIndex:0] objectForKey:key_RestaurantID] );
            if ([[[[[UIConstants returnInstance] aryOrderedRestaurantsList] objectAtIndex:0] objectForKey:key_RestaurantID] isEqualToString:[dicRestaurantDetail objectForKey:key_RestaurantID]]) {
                [[UIConstants returnInstance] setIsComingViaMyOrders:NO];
                [self AddItemsToExistingCart];
                [self SetTabbarBadgeValue];
                [self.delegate LoadTabBar:2];
            }else{
                [self ShowAlertForExistingRestaurant:[_aryOrderList objectAtIndex:indexPath.row]];
            }
        }else{
            [[UIConstants returnInstance] setIsComingViaMyOrders:YES];
            [self SetRestaurantValues];
            [self SetTabbarBadgeValue];
            [self.delegate LoadTabBar:2];
        }
    }
}

#pragma mark - Alert view delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
        if (buttonIndex == 0) {
            [[UIConstants returnInstance] setIsLoginViaHome:NO];
            [self.delegate LoadNextScreen:VIEW_LOGIN];
        }else{
            [self.delegate loadPreviousTab];
        }
    }else if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            [[UIConstants returnInstance] setIsComingViaMyOrders:YES];
            [self SetRestaurantValues];
            [self SetTabbarBadgeValue];
            [self.delegate LoadTabBar:2];
        }
    }
}

- (void)SetRestaurantValues
{
    [[UIConstants returnInstance] setAryOrderedRestaurantsList:nil];
    [[UIConstants returnInstance] setAryCartDetails:nil];
    
    NSMutableDictionary *dicRestaurant = [[NSMutableDictionary alloc] init];
    
    [dicRestaurant setObject:[dicRestaurantDetail objectForKey:key_RestaurantID] forKey:key_RestaurantID];
    [dicRestaurant setObject:[dicRestaurantDetail objectForKey:key_VendorID] forKey:key_VendorID];
    [dicRestaurant setObject:[dicRestaurantDetail objectForKey:key_RestaurantName] forKey:key_RestaurantName];
    [dicRestaurant setObject:[dicRestaurantDetail objectForKey:key_MenuMasterID] forKey:key_MenuMasterID];
    [dicRestaurant setObject:aryCartDetail forKey:key_OrderDetails];
    
    [[UIConstants returnInstance] setStrMaxDeliveryTime:[dicRestaurantDetail objectForKey:key_DeliveryTime]];
    [[UIConstants returnInstance] setStrMinPreparationTime:[dicRestaurantDetail objectForKey:key_PickUpTime]];
    
    NSLog(@"my order history: %@", dicRestaurant);
    NSMutableArray *aryRestaurantDetail = [[NSMutableArray alloc] initWithObjects:dicRestaurant, nil];
    [[UIConstants returnInstance] setAryOrderedRestaurantsList:aryRestaurantDetail];
    [[UIConstants returnInstance] setAryCartDetails:aryCartDetail];
}

-(void)AddItemsToExistingCart
{
    NSMutableArray *aryCart = [[NSMutableArray alloc]initWithArray:[[UIConstants returnInstance] aryCartDetails]];
    for( NSMutableDictionary *dicItem1 in aryCartDetail ) {
        BOOL isItemExisting = NO;
        for (NSMutableDictionary *dicItem2 in aryCart) {
            int Quantity = [[dicItem2 objectForKey:key_Quantity] integerValue];
            float PriceforSingleItem = [[dicItem2 objectForKey:key_TotalPrice] floatValue]/Quantity;
            NSLog(@"compare %@ == %@",[dicItem1 objectForKey:key_ItemID], [dicItem2 objectForKey:key_ItemID]);
            if ([[dicItem1 objectForKey:key_ItemID] isEqualToString:[dicItem2 objectForKey:key_ItemID]]) {
                isItemExisting = [self CompareExistingItem:dicItem2 withNewOne:dicItem1];
                if (isItemExisting) {
                    Quantity = Quantity + [[dicItem1 objectForKey:key_Quantity] integerValue];
                    NSString *strTotalPrice = [NSString stringWithFormat:@"%f", PriceforSingleItem*Quantity];
                    [dicItem2 setObject:[NSString stringWithFormat:@"%i",Quantity] forKey:key_Quantity];
                    [dicItem2 setObject:strTotalPrice forKey:key_TotalPrice];
                    //[aryCart removeObject:dicItem2];
                    break;
                }
            }else{
                isItemExisting = NO;
            }
        }
        if (!isItemExisting) {
            [aryCart addObject:dicItem1];
        }
    }
    [[UIConstants returnInstance] setAryCartDetails:aryCart];
    NSMutableArray *aryOrderedRestaurants = [[NSMutableArray alloc] initWithArray:[[UIConstants returnInstance] aryOrderedRestaurantsList]];
    [[aryOrderedRestaurants objectAtIndex:0] setObject:aryCart forKey:key_OrderDetails];
    [[UIConstants returnInstance] setAryOrderedRestaurantsList:aryOrderedRestaurants];
}

#pragma mark - Check The existing and new item details
-(BOOL)CompareExistingItem:(NSDictionary *)ExistingDic withNewOne:(NSDictionary *)NewDic
{
    if (![[ExistingDic objectForKey:key_Customization] isEqualToString:[NewDic objectForKey:key_Customization]]) {
        return NO;
    }
    
    NSArray *arrayCustomizeOption_Existing = [ExistingDic objectForKey:key_CustomizationOptions];
    NSArray *arrayCustomizeOption_New = [NewDic objectForKey:key_CustomizationOptions];
    
    if ([arrayCustomizeOption_Existing count] == [arrayCustomizeOption_New count]) {
        NSLog(@"%@ ::: %@", arrayCustomizeOption_Existing,arrayCustomizeOption_New);
        for (NSDictionary *dicExisting in arrayCustomizeOption_Existing) {
            BOOL IsAvailable = NO;
            for (NSDictionary *dicNew in arrayCustomizeOption_New) {
                NSLog(@"%i  == %i", [[dicExisting objectForKey:key_CustomizationId] integerValue], [[dicNew objectForKey:key_CustomizationId] integerValue]);
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


#pragma mark - Change Language to Arabic
-(void)ChangeLanguageToArabic
{
    [btnLogin setTitle:(NSString *)Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];
    
    lblScreenName.text = (NSString *)MyOrders_Arabic;
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

#pragma mark - Show alert method

-(void)ShowAlertForExistingRestaurant :(NSDictionary *)RestaurantDetails
{
    NSString *_strTitle;
    NSString *_strMessage;
    NSString *_strButton1;
    NSString *_strButton2;
    if ([[UIConstants returnInstance] isItEnglish]) {
        _strTitle = Alert_English;
        _strMessage = Alert_CartContainsItem_English;
        _strButton1 = Yes_English;
        _strButton2 = No_English;
    }else{
        _strTitle = Alert_Arabic;
        _strMessage = Alert_CartContainsItem_Arabic;
        _strButton1 = Yes_Arabic;
        _strButton2 = No_Arabic;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_strTitle message:_strMessage delegate:self cancelButtonTitle:_strButton1 otherButtonTitles:_strButton2, nil];
    alert.tag = 2;
    [alert show];
    [alert release];
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
@end
