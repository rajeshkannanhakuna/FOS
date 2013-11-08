//
//  MenuScreen.m
//  
//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "MenuScreen.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import "ResponseDTO.h"
#import "APIConstants.h"
#import "ServiceHandler.h"

@interface MenuScreen ()<UIActionSheetDelegate>
{
    NSMutableArray *_aryMenu;
    ServiceHandler *ObjServiceHandler;
    IBOutlet UIImageView *_imgViewCartFood;
     IBOutlet UIButton *loginBtn;
}
@end

@implementation MenuScreen
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
    [self ModifyScreenWithCorrespondingValues];
//    NSDictionary *temp1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"m1.png",@"img",
//                           @"Pizza",@"name",
//                           @"Pizza romana: tomato,mozzarella,anchovies,oregano,oil pizza viennese: tomato,",@"desc",nil];
//
//    NSDictionary *temp2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"m2.png",@"img",
//                           @"Rice",@"name",
//                           @"Hokkien or Fujian fried rice: This variation of chinese fried rice is from the Fujian region of china.",@"desc",nil];
//
//    NSDictionary *temp3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Appetizers",@"name",
//                           @"Annie's Fruit salsa and chinnamon chips oregano, oil pizza viennese: tomato.",@"desc",nil];
//    
//    NSDictionary *temp4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"m4.png",@"img",
//                           @"Noodles",@"name",
//                           @"Cellophane Noodles, Rice Noodles, Egg Noodles, Misoa Noodles.",@"desc",nil];
//
//    _aryMenu = [[NSMutableArray alloc] init];
//    [_aryMenu addObject:temp1];
//    [_aryMenu addObject:temp2];
//    [_aryMenu addObject:temp3];
//    [_aryMenu addObject:temp4];
    
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){    
        [self ChangeLanguageToArabic];
        
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
        
    }
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
    [tblViewMenu reloadData];
    if ([[[UIConstants returnInstance] aryCartDetails] count] > 0) {
        if ([viewCartSummary isHidden]) {
            viewCartSummary.hidden = NO;
            tblViewMenu.frame = CGRectMake(tblViewMenu.frame.origin.x, tblViewMenu.frame.origin.y, tblViewMenu.frame.size.width, tblViewMenu.frame.size.height-viewCartSummary.frame.size.height);
        }
        lblNoOfItems.text = [NSString stringWithFormat:@"%i",[[[UIConstants returnInstance] aryCartDetails] count]];
        float price = 0;
        for(NSDictionary *dic in [[UIConstants returnInstance] aryCartDetails]) {
            price = price + [[dic objectForKey:key_TotalPrice] floatValue];
        }
        lblTotalAmount.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:price]];
    }else {
        if (![viewCartSummary isHidden]) {
            viewCartSummary.hidden = YES;
            tblViewMenu.frame = CGRectMake(tblViewMenu.frame.origin.x, tblViewMenu.frame.origin.y, tblViewMenu.frame.size.width, tblViewMenu.frame.size.height+viewCartSummary.frame.size.height);
        }
        NSLog(@"%f", tblViewMenu.frame.size.height);
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
    lblAreaName.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblMinOrderValueText.font = [[UIConstants returnInstance] returnArvoRegular:11];
    lblDeliveryChargeText.font = [[UIConstants returnInstance] returnArvoRegular:11];
    lblMinOrderValue.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblDeliveryCharge.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblAddress.font = [[UIConstants returnInstance] returnArvoRegular:12];
    lblNoOfItems.font = [[UIConstants returnInstance] returnArvoRegular:15];
    lblTotalAmount.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblTotalAmountName.font = [[UIConstants returnInstance] returnArvoRegular:11];
    btnOrderSummary.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:11];
}

#pragma Custom Defined Methods

-(void)ModifyScreenWithCorrespondingValues
{
    lblAreaName.text = [[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_Name];//[NSString stringWithFormat:@"%@ | %@", [[UIConstants returnInstance] strCityCode], [[UIConstants returnInstance] strAreaName]];
    [[UIConstants returnInstance] setDicRestaurantDetails:[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail]];
    [[UIConstants returnInstance] setAryDeliverySupportedAreas:[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_DeliverySupportAreas]];
    
    NSMutableString *strAddress = [[NSMutableString alloc] init];
    for (NSString *string in [[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_Address]) {
        if (![string isEqualToString:@" "] && string != nil && [string length]>1) {
            NSLog(@"%@  == %@", string, strAddress);
            [strAddress appendString:string];
            [strAddress appendString:@", "];
        }
    }
    if ([strAddress length] > 2) {
        [strAddress deleteCharactersInRange:NSMakeRange([strAddress length] - 2, 2)];
    }
    lblAddress.text = [NSString stringWithFormat:@"%@.", strAddress];
    if([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
        [[UIConstants returnInstance] setStrMinOrderValue:[NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode], [[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_DeliveryMinOrderValue] floatValue]]]];
        
        //lblMinOrderValue.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode], [[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_DeliveryMinOrderValue] floatValue]]];
    }else{
        [[UIConstants returnInstance] setStrMinOrderValue: [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_OnlineOrderMin] floatValue]]]];
        //lblMinOrderValue.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_OnlineOrderMin] floatValue]]];
    }
    
    NSString *val = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_Tax1Amount] floatValue]]];
    [[UIConstants returnInstance] setStrTax:[NSString stringWithFormat:@"%@: %@",[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_Tax1Name],val]];
    
    lblMinOrderValue.text = [[UIConstants returnInstance] strMinOrderValue];
    lblDeliveryChargeText.text = [[UIConstants returnInstance] strTax];
    //lblDeliveryChargeText.text = [NSString stringWithFormat:@"%@: %@",[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_Tax1Name],val];
    
    
//    lblDeliveryCharge.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[[UIConstants returnInstance] convertToDecimalValue:[[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_Tax1Amount] floatValue]]];
    
    _aryMenu = [[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_MenuCategories];
    
}

#pragma mark - Button Action Methods
-(void)OnClickGoHomeButton:(id)sender
{
    [self.delegate GoHome];
}

-(void)OnClickGoBackButton:(id)sender
{
    [self.delegate GoBack:YES];
}

- (IBAction)OnClickOrderSummaryButton:(id)sender
{
    [self.delegate LoadTabBar:2];
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
        BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
        UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:(isArabic)? UserDetails_Arabic : UserDetails_Eng delegate:self cancelButtonTitle:(isArabic)? Cancel_Arabic : Cancel_Eng destructiveButtonTitle:nil otherButtonTitles:(isArabic)? EditProfile_Arabic : EditProfile_Eng ,(isArabic)? SignOut_Arabic : SignOut_Eng, nil];

        [sheet showInView:self.view];

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
    }
}

-(void)OnClickRestaurantInfo:(id)sender
{
    [self.delegate LoadNextScreen:VIEW_RESTAURANTINFO];
}

- (void)dealloc {
    [lblAreaName release];
    [lblAddress release];
    [lblMinOrderValue release];
    [lblDeliveryCharge release];
    [tblViewMenu release];
    [lblNoOfItems release];
    [lblTotalAmount release];
    [btnOrderSummary release];
    [btnLogin release];
    [btnRegister release];
    [btnEditProfile release];
    [btnChangePassword release];
    [btnSignOut release];
    [super dealloc];
}

#pragma mark - Table view delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_aryMenu count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[_aryMenu objectAtIndex:indexPath.row]];
    _cell.backgroundColor = [UIColor clearColor];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGRect _frame = [tableView rectForRowAtIndexPath:indexPath];
    
    
    NSDictionary *dic = [_aryMenu objectAtIndex:indexPath.row];
    
    UIView *_viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
    _viewCell.backgroundColor = [UIColor clearColor];
    UIImageView *_imgViewCellBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, _viewCell.frame.size.width, _viewCell.frame.size.height-5)];
    if (indexPath.row%2 == 0) {
        _imgViewCellBG.image = [UIImage imageNamed:@"menuitemBG_darkcolor.png"];
    }else{
        _imgViewCellBG.image = [UIImage imageNamed:@"menuitemBG_lightcolor.png"];
    }
    BOOL isArabic = ![[UIConstants returnInstance] isItEnglish];
    
    int xpos = 10;
    UIImageView *img=nil;
    
    CGRect rect;
//#ifdef DEBUG
//    
//    // Something to log your sensitive data here
//   
//        // Item Image
//       rect =CGRectMake(xpos,10,65,65);
//    
//        img = [[UIImageView alloc] initWithFrame:[[UIConstants returnInstance] getFrameForLanguage:rect withSuperViewRect:_viewCell.frame]];
//
//        [img setImage:[UIImage imageNamed:@"p1.png"]];
//    xpos += 70;
//
//    
//#else
    BOOL IsImageAvailable = NO;
    if([dic objectForKey:key_ImageURL] != [NSNull null]){
        UIImage *imgItem  = [[UIConstants returnInstance] ReturnImageForURL:[dic objectForKey:key_ImageURL]];
        if (imgItem) {
    // Item Image
            IsImageAvailable = YES;
            rect =CGRectMake(xpos,10,65,65);
            img = [[UIImageView alloc] initWithFrame:[[UIConstants returnInstance] getFrameForLanguage:rect withSuperViewRect:_viewCell.frame]];
            [img setImage:imgItem];
            xpos += 70;
        }
    }


//#endif

 
  rect =[[UIConstants returnInstance] getFrameForLanguage:CGRectMake(xpos, 10, 200, 20) withSuperViewRect:_viewCell.frame] ;
    if (IsImageAvailable) {
        rect.size.width = rect.size.width-70;
    }
    //float width = (isArabic)? (xpos + (280 - img.frame.size.width - 25)):200;
    UILabel *_lblItemName = [[UILabel alloc] initWithFrame:rect];
    _lblItemName.backgroundColor = [UIColor clearColor];
    _lblItemName.text = [dic objectForKey:key_Name];
    _lblItemName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    if(![[UIConstants returnInstance] isItEnglish]){
        _lblItemName.textAlignment = UITextAlignmentRight;
    }
    

    // Arrow Icon
    rect =[[UIConstants returnInstance] getFrameForLanguage:CGRectMake(_viewCell.frame.size.width - 25, _viewCell.frame.size.height/2-5, 10, 10) withSuperViewRect:_viewCell.frame] ;
    UIImageView *_imgArrow = [[UIImageView alloc] initWithFrame:rect];
    _imgArrow.image = [UIImage imageNamed:@"Homearrow.png"];
    if(![[UIConstants returnInstance] isItEnglish]){
       // CGRect rect = _imgArrow.frame;
       // rect.origin.x = 10;
       // _imgArrow.frame = rect;
        _imgArrow.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        
    }
    // Description
     rect =[[UIConstants returnInstance] getFrameForLanguage:CGRectMake(xpos,30,250,40) withSuperViewRect:_viewCell.frame] ;
    if (IsImageAvailable) {
        rect.size.width = rect.size.width-70;
    }
    UILabel *descLbl = [[UILabel alloc] initWithFrame:rect];
    if ([dic objectForKey:key_Description] != [NSNull null]) {
        descLbl.text = [dic objectForKey:key_Description];
    }
    descLbl.numberOfLines = 0;
    //descLbl.lineBreakMode = NSLineBreakByWordWrapping;
    descLbl.backgroundColor = [UIColor clearColor];
    descLbl.font = [[UIConstants returnInstance] returnArvoRegular:12];
    descLbl.textColor = [UIColor grayColor];

    [_viewCell addSubview:_imgViewCellBG];
    [_viewCell addSubview:descLbl];
    [_viewCell addSubview:_imgArrow];
    [_viewCell addSubview:img];
    [_viewCell addSubview:_lblItemName];
    
    int Quantity = [[UIConstants returnInstance] GetQuantityForIdentifier:[dic objectForKey:key_Identifier] isForMenu:YES];
    if(Quantity > 0){
        //Quantity BG
        int value = 30;
        rect = [[UIConstants returnInstance] getFrameForLanguage:CGRectMake(_viewCell.frame.size.width-value, _viewCell.frame.size.height-value, value, value) withSuperViewRect:_viewCell.frame];
        UIImageView *imgQuantityBG = [[UIImageView alloc] initWithFrame:rect];
        if (isArabic) {
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

    return _cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ObjServiceHandler = [[ServiceHandler alloc] init];
    if ([ObjServiceHandler GetMenuCategoryList:[[UIConstants returnInstance] strAppID] :[[[[ResponseDTO sharedInstance] DTO_RestaurantMenuList] objectForKey:key_RestaurantDetail] objectForKey:key_Identifier] :[[_aryMenu objectAtIndex:indexPath.row] objectForKey:key_Identifier]]) {
        [[UIConstants returnInstance] setStrMenuCategoryIdentifier:[[_aryMenu objectAtIndex:indexPath.row] objectForKey:key_Identifier]];
        [[UIConstants returnInstance] setStrMenuCategoryName:[[_aryMenu objectAtIndex:indexPath.row] objectForKey:key_Name]];
        [self.delegate LoadNextScreen:VIEW_MENUITEMSCREEN];
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    
    [ObjServiceHandler release], ObjServiceHandler = nil;
}

#pragma mark - Change Language to Arabic

-(void)ChangeLanguageToArabic
{
    [btnLogin setTitle:(NSString *)Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];
    
    lblScreenName.text = (NSString *)Menu_Arabic;
    [btnOrderSummary setTitle:(NSString *)OrderSummary_Arabic forState:UIControlStateNormal];
    
//    lblAreaName.frame = CGRectMake(self.view.frame.size.width - lblAreaName.frame.size.width - lblAreaName.frame.origin.x, lblAreaName.frame.origin.y, lblAreaName.frame.size.width, lblAreaName.frame.size.height);
    lblAddress.frame = CGRectMake(self.view.frame.size.width - lblAddress.frame.size.width - lblAddress.frame.origin.x, lblAddress.frame.origin.y, lblAddress.frame.size.width, lblAddress.frame.size.height);
    lblMinOrderValue.frame = CGRectMake(self.view.frame.size.width - lblMinOrderValue.frame.size.width - lblMinOrderValue.frame.origin.x + 30, lblMinOrderValue.frame.origin.y, lblMinOrderValue.frame.size.width, lblMinOrderValue.frame.size.height);
    lblDeliveryCharge.frame = CGRectMake(self.view.frame.size.width - lblDeliveryCharge.frame.size.width - lblDeliveryCharge.frame.origin.x + 50, lblDeliveryCharge.frame.origin.y, lblDeliveryCharge.frame.size.width, lblDeliveryCharge.frame.size.height);
    lblDeliveryChargeText.frame = CGRectMake(self.view.frame.size.width - lblDeliveryChargeText.frame.size.width - lblDeliveryChargeText.frame.origin.x, lblDeliveryChargeText.frame.origin.y, lblDeliveryChargeText.frame.size.width, lblDeliveryChargeText.frame.size.height);
    lblMinOrderValueText.frame = CGRectMake(self.view.frame.size.width - lblMinOrderValueText.frame.size.width - lblMinOrderValueText.frame.origin.x, lblMinOrderValueText.frame.origin.y, lblMinOrderValueText.frame.size.width, lblMinOrderValueText.frame.size.height);
    
    lblMinOrderValueText.text = MinOrderValue_Arabic;
    //lblDeliveryChargeText.text = (NSString *)DeliveryCharge_Arabic;
    lblAreaName.textAlignment = NSTextAlignmentRight;
    lblAddress.textAlignment = NSTextAlignmentRight;
    lblMinOrderValue.textAlignment = NSTextAlignmentRight;
    lblDeliveryCharge.textAlignment = NSTextAlignmentRight;
    lblMinOrderValueText.textAlignment = NSTextAlignmentRight;
    lblDeliveryChargeText.textAlignment = NSTextAlignmentRight;
    
    
    lblTotalAmountName.text = TotalAmount_Arabic;
    
    lblTotalAmountName.frame =[[UIConstants returnInstance] getFrameForLanguage:lblTotalAmountName.frame withSuperViewRect:viewCartSummary.frame];
    lblTotalAmount.frame = [[UIConstants returnInstance] getFrameForLanguage:lblTotalAmount.frame withSuperViewRect:viewCartSummary.frame];
    lblNoOfItems.frame = [[UIConstants returnInstance] getFrameForLanguage:lblNoOfItems.frame withSuperViewRect:viewCartSummary.frame];
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

- (CGRect) getFrameForLanguage:(CGRect)rect withSuperViewRect:(CGRect)superviewRect
{
    if([[UIConstants returnInstance] isItEnglish]){
        return rect;
    }
    CGRect arabicRect = CGRectZero;
    arabicRect.origin.x = superviewRect.size.width - (rect.origin.x + rect.size.width);
    arabicRect.origin.y = rect.origin.y;
    arabicRect.size.width = rect.size.width;
    arabicRect.size.height = rect.size.height;
    
    return arabicRect;
    
    
}
@end
