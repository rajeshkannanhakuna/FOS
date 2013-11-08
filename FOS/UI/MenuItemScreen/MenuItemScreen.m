//
//  MenuItemScreen.m
//  
//
//  Created by segate on 19/08/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "MenuItemScreen.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import "ResponseDTO.h"
#import "ServiceHandler.h"
@interface MenuItemScreen ()<UIActionSheetDelegate>
{
    NSMutableArray *_aryItemList;
    ServiceHandler *ObjServiceHandler;
      IBOutlet UIButton *loginBtn;
    IBOutlet UIImageView *_imgViewCartFood;
}
- (IBAction)loginAction:(UIButton *)sender;
@end

@implementation MenuItemScreen
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
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){    
        [self ChangeLanguageToArabic];
        
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
        
    }
    [self ModifyScreenWithCorrespondingValues];
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
    
    [tblViewItemList reloadData];
    
    if ([[[UIConstants returnInstance] aryCartDetails] count] > 0) {
        if ([viewCartSummary isHidden]) {
            viewCartSummary.hidden = NO;
            tblViewItemList.frame = CGRectMake(tblViewItemList.frame.origin.x, tblViewItemList.frame.origin.y, tblViewItemList.frame.size.width, tblViewItemList.frame.size.height-viewCartSummary.frame.size.height);
        }
        lblNoOfItem.text = [NSString stringWithFormat:@"%i",[[[UIConstants returnInstance] aryCartDetails] count]];
        float price = 0;
        for(NSDictionary *dic in [[UIConstants returnInstance] aryCartDetails]) {
            price = price + [[dic objectForKey:key_TotalPrice] floatValue];
        }
        lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:price]];
    }else {
        if (![viewCartSummary isHidden]) {
        viewCartSummary.hidden = YES;
        tblViewItemList.frame = CGRectMake(tblViewItemList.frame.origin.x, tblViewItemList.frame.origin.y, tblViewItemList.frame.size.width, tblViewItemList.frame.size.height+viewCartSummary.frame.size.height);
        }
        NSLog(@"%f", tblViewItemList.frame.size.height);
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
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    lblAreaName.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblAddress.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblMinOrderValue.font = [[UIConstants returnInstance]returnArvoRegular:12];
    lblDeliveryCharge.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblMinOrderValueText.font = [[UIConstants returnInstance] returnArvoRegular:11];
    lblDeliveryChargeText.font = [[UIConstants returnInstance] returnArvoRegular:11];
    lblNoOfItem.font = [[UIConstants returnInstance]returnArvoRegular:15];
    lblTotalAmount.font = [[UIConstants returnInstance] returnArvoRegular:13];
    lblTotalAmountName.font = [[UIConstants returnInstance] returnArvoRegular:11];
    btnOrderSummary.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:11];
    
}

- (void)ModifyScreenWithCorrespondingValues
{
    lblScreenName.text = [[UIConstants returnInstance] strMenuCategoryName];
    lblAreaName.text = [[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetails] objectForKey:key_Name];
//    [[UIConstants returnInstance] setDicRestaurantDetails:[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetail]];
    //[NSString stringWithFormat:@"%@ | %@", [[UIConstants returnInstance] strCityCode], [[UIConstants returnInstance] strAreaName]];
    NSMutableString *strAddress = [[NSMutableString alloc] init];
    for (NSString *string in [[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetails] objectForKey:key_Address]) {
        if (![string isEqualToString:@" "] && string != nil && [string length]>1) {
             NSLog(@"%@  == %@", string, strAddress);
            [strAddress appendString:string];
            [strAddress appendString:@", "];
        }
    }
    if ([strAddress length] > 2) {
        [strAddress deleteCharactersInRange:NSMakeRange([strAddress length] - 2, 2)];
    }
    
    lblAddress.text =[NSString stringWithFormat:@"%@.", strAddress];
    
//    if([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
//        lblMinOrderValue.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetail] objectForKey:key_DeliveryMinOrderValue] floatValue]]];
//    }else{
//        lblMinOrderValue.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetail] objectForKey:key_OnlineOrderMin] floatValue]]];
//    }
//
//    NSString *val = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetail] objectForKey:key_Tax1Amount] floatValue]]];
//    
//    lblDeliveryChargeText.text = [NSString stringWithFormat:@"%@: %@",[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_Tax1Name],val];
//    lblDeliveryCharge.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetail] objectForKey:key_Tax1Amount] floatValue]]];
    lblMinOrderValue.text = [[UIConstants returnInstance] strMinOrderValue];
    lblDeliveryChargeText.text = [[UIConstants returnInstance] strTax];
    
    NSLog(@"\n%@",[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetail]);
//    NSLog(@"%@", [[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetail] );

    
    _aryItemList = [[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_MenuItems];
    
}

#pragma mark - Button action methods

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

-(void)OnClickGoBackButton:(id)sender
{
    [self.delegate GoBack:YES];
}

-(void)OnClickOrderSummaryButton:(id)sender
{
    [self.delegate LoadTabBar:2];
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

-(void)OnClickRestaurantInfo:(id)sender
{
    [self.delegate LoadNextScreen:VIEW_RESTAURANTINFO];
}

#pragma mark - Table view delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_aryItemList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[_aryItemList objectAtIndex:indexPath.row] objectForKey:key_MenuIdentifier]];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell.backgroundColor = [UIColor clearColor];
    
    CGRect _frame = [tableView rectForRowAtIndexPath:indexPath];
    
    NSDictionary *dic = [_aryItemList objectAtIndex:indexPath.row];
    
    UIView *_viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
    
    UIImageView *_imgViewCellBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, _viewCell.frame.size.width, _viewCell.frame.size.height-5)];
    if (indexPath.row%2 == 0) {
        _imgViewCellBG.image = [UIImage imageNamed:@"menuitemBG_darkcolor.png"];
    }else{
        _imgViewCellBG.image = [UIImage imageNamed:@"menuitemBG_lightcolor.png"];
    }
    CGRect rect;
    int xpos = 5;
    UIImageView *img=nil;
    BOOL IsImageAvailable = NO;
    if([dic objectForKey:key_ImageURL] != [NSNull null]){
        UIImage *imgItem  = [[UIConstants returnInstance] ReturnImageForURL:[dic objectForKey:key_ImageURL]];
        if (imgItem) {
            IsImageAvailable = YES;
            // Item Image
            rect = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(xpos,10,65,65) withSuperViewRect:_viewCell.frame];
            img = [[UIImageView alloc] initWithFrame:rect];
            [img setImage:imgItem];
            xpos += 70;
        }
    }
    
    // Item Name
     rect = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(xpos, 10, 230, 20) withSuperViewRect:_viewCell.frame];
    if (IsImageAvailable) {
        rect.size.width = rect.size.width-70;
    }
    UILabel *_lblItemName = [[UILabel alloc] initWithFrame:rect];
    _lblItemName.backgroundColor = [UIColor clearColor];
    _lblItemName.text = [dic objectForKey:key_ItemName];
    _lblItemName.textAlignment = FOS_TEXTALIGNMENT;
    
    _lblItemName.font = [[UIConstants returnInstance] returnArvoRegular:16];
    
    // Item Price
    
     rect = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(240, 10, 70, 20) withSuperViewRect:_viewCell.frame];
    UILabel *_lblItemPrice = [[UILabel alloc] initWithFrame:rect];
    _lblItemPrice.backgroundColor = [UIColor clearColor];
    if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
        _lblItemPrice.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[dic objectForKey:key_DoorDeliveryPrice] floatValue]]];
    }else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]) {
        _lblItemPrice.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[dic objectForKey:key_TakeAwayPrice] floatValue]]];
    }
    _lblItemPrice.textAlignment = FOS_TEXTALIGNMENT;
    _lblItemPrice.font = [[UIConstants returnInstance] returnArvoRegular:10];
    
    // Arrow Icon
     rect = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(_viewCell.frame.size.width - 20, _viewCell.frame.size.height/2-5, 10, 10) withSuperViewRect:_viewCell.frame];
    UIImageView *_imgArrow = [[UIImageView alloc] initWithFrame:rect];
    _imgArrow.image = [UIImage imageNamed:@"Homearrow.png"];
    if(![[UIConstants returnInstance] isItEnglish]){
       
        _imgArrow.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        
    }
    // Description
     rect = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(xpos,30,260,40) withSuperViewRect:_viewCell.frame];
    if (IsImageAvailable) {
        rect.size.width = rect.size.width-70;
    }
    UILabel *descLbl = [[UILabel alloc] initWithFrame:rect];
    if ([dic objectForKey:key_MenuDescription] != [NSNull null]) {
        descLbl.text = [dic objectForKey:key_MenuDescription];
    }
    descLbl.numberOfLines = 0;
    descLbl.textAlignment = FOS_TEXTALIGNMENT;
    //descLbl.lineBreakMode = NSLineBreakByWordWrapping;
    descLbl.backgroundColor = [UIColor clearColor];
    descLbl.font = [[UIConstants returnInstance] returnArvoRegular:12];
    descLbl.textColor = [UIColor grayColor];
    
    [_viewCell addSubview:_imgViewCellBG];
    [_viewCell addSubview:_lblItemName];
    [_viewCell addSubview:descLbl];
    [_viewCell addSubview:_imgArrow];
    [_viewCell addSubview:img];
    [_viewCell addSubview:_lblItemPrice];
    int Quantity = [[UIConstants returnInstance] GetQuantityForIdentifier:[dic objectForKey:key_MenuIdentifier] isForMenu:NO];
    if(Quantity > 0){
        //Quantity BG
        int value = 30;
        rect = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(_viewCell.frame.size.width-value, _viewCell.frame.size.height-value, value, value) withSuperViewRect:_viewCell.frame];
        UIImageView *imgQuantityBG = [[UIImageView alloc] initWithFrame:rect];
        if (![[UIConstants returnInstance] isItEnglish]) {
            imgQuantityBG.image = [UIImage imageNamed:@"count_bg_arabic.png"];
        }else{
            imgQuantityBG.image = [UIImage imageNamed:@"count_bg.png"];
        }
        
        //Lbl Qunty
        value = 15;
        rect = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(_viewCell.frame.size.width-value, _viewCell.frame.size.height-value, value, value) withSuperViewRect:_viewCell.frame];
        
        UILabel *lblQnty = [[UILabel alloc] initWithFrame:rect];
        lblQnty.text = [NSString stringWithFormat:@"%i", Quantity];
        lblQnty.textAlignment = NSTextAlignmentCenter;
        lblQnty.backgroundColor = [UIColor clearColor];
        lblQnty.textColor = [UIColor whiteColor];
        lblQnty.font = [[UIConstants returnInstance] returnArvoBold:12];
        lblQnty.adjustsFontSizeToFitWidth = YES;
        lblQnty.minimumFontSize = 10.0;
        [_viewCell addSubview:imgQuantityBG];
        [_viewCell addSubview:lblQnty];
    }
    
    
    [_cell addSubview:_viewCell];
    
    [_imgViewCellBG release];
    [img release];
    [_lblItemName release];
    [descLbl release];
    [_viewCell release];
    [_lblItemPrice release];
    
    return _cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetMenuItemDetail:[[UIConstants returnInstance] strAppID]
                                            :[[[[ResponseDTO sharedInstance] DTO_MenuCategoryMenuItems] objectForKey:key_RestaurantDetails] objectForKey:key_Identifier]
                                            :[[_aryItemList objectAtIndex:indexPath.row] objectForKey:key_MenuIdentifier]
                                            :[[UIConstants returnInstance] strMenuCategoryIdentifier]
                                            :[[[_aryItemList objectAtIndex:indexPath.row] valueForKey:key_isGroup] integerValue]]) {
        [[UIConstants returnInstance] setStrMenuItemName:[[_aryItemList objectAtIndex:indexPath.row] objectForKey:key_ItemName]];
        [[UIConstants returnInstance] setStrMenuIdentifier:[[_aryItemList objectAtIndex:indexPath.row] objectForKey:key_MenuIdentifier]];
        [[UIConstants returnInstance] setStrIsGroup:[[_aryItemList objectAtIndex:indexPath.row] valueForKey:key_isGroup]];
        [[UIConstants returnInstance] setIsComingForEditing:NO];
        [self.delegate LoadNextScreen:VIEW_ITEMDETAILS];
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
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
    [btnOrderSummary setTitle:(NSString *)OrderSummary_Arabic forState:UIControlStateNormal];
    
//    lblAreaName.frame = CGRectMake(self.view.frame.size.width - lblAreaName.frame.size.width - lblAreaName.frame.origin.x, lblAreaName.frame.origin.y, lblAreaName.frame.size.width, lblAreaName.frame.size.height);
    lblAddress.frame = CGRectMake(self.view.frame.size.width - lblAddress.frame.size.width - lblAddress.frame.origin.x, lblAddress.frame.origin.y, lblAddress.frame.size.width, lblAddress.frame.size.height);
    lblMinOrderValue.frame = CGRectMake(self.view.frame.size.width - lblMinOrderValue.frame.size.width - lblMinOrderValue.frame.origin.x + 30, lblMinOrderValue.frame.origin.y, lblMinOrderValue.frame.size.width, lblMinOrderValue.frame.size.height);
    lblDeliveryCharge.frame = CGRectMake(self.view.frame.size.width - lblDeliveryCharge.frame.size.width - lblDeliveryCharge.frame.origin.x + 50, lblDeliveryCharge.frame.origin.y, lblDeliveryCharge.frame.size.width, lblDeliveryCharge.frame.size.height);
    
    lblDeliveryChargeText.frame = CGRectMake(self.view.frame.size.width - lblDeliveryChargeText.frame.size.width - lblDeliveryChargeText.frame.origin.x, lblDeliveryChargeText.frame.origin.y, lblDeliveryChargeText.frame.size.width, lblDeliveryChargeText.frame.size.height);
    lblMinOrderValueText.frame = CGRectMake(self.view.frame.size.width - lblMinOrderValueText.frame.size.width - lblMinOrderValueText.frame.origin.x , lblMinOrderValueText.frame.origin.y, lblMinOrderValueText.frame.size.width, lblMinOrderValueText.frame.size.height);
    
    lblMinOrderValueText.textAlignment = NSTextAlignmentRight;
    lblDeliveryChargeText.textAlignment = NSTextAlignmentRight;

    lblMinOrderValueText.text = (NSString *)MinOrderValue_Arabic;
    lblDeliveryChargeText.text = (NSString *)DeliveryCharge_Arabic;
    
    lblAreaName.textAlignment = NSTextAlignmentRight;
    lblAddress.textAlignment = NSTextAlignmentRight;
    lblMinOrderValue.textAlignment = NSTextAlignmentRight;
    lblDeliveryCharge.textAlignment = NSTextAlignmentRight;
    
    lblTotalAmountName.text = TotalAmount_Arabic;
    
    lblTotalAmountName.frame =[[UIConstants returnInstance] getFrameForLanguage:lblTotalAmountName.frame withSuperViewRect:viewCartSummary.frame];
    lblTotalAmount.frame = [[UIConstants returnInstance] getFrameForLanguage:lblTotalAmount.frame withSuperViewRect:viewCartSummary.frame];
    lblNoOfItem.frame = [[UIConstants returnInstance] getFrameForLanguage:lblNoOfItem.frame withSuperViewRect:viewCartSummary.frame];
    _imgViewCartFood.frame = [[UIConstants returnInstance] getFrameForLanguage:_imgViewCartFood.frame   withSuperViewRect:viewCartSummary.frame];
    
    lblTotalAmountName.textAlignment = FOS_TEXTALIGNMENT_NEGATIVE;
    lblTotalAmount.textAlignment = FOS_TEXTALIGNMENT;
    
    
    
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
    [_imgViewCartFood release];
    [super dealloc];
}
- (void)viewDidUnload {
    [_imgViewCartFood release];
    _imgViewCartFood = nil;
    [super viewDidUnload];
}
@end
