 //
//  ViewController.m

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "UIConstants.h"
#import "LanguageConstants.h"

ServiceHandler *ObjServiceHandler;
@interface ViewController () <UIActionSheetDelegate,ComboBoxDelegate>
{
    NSMutableArray *_aryTempList;
    NSMutableArray *_aryAreaList;
    NSMutableArray *_aryHomeDeliverySupportedAreaList;
    NSMutableArray *_aryTakeAwaySupportedAreaList;
    IBOutlet UIButton *loginBtn;
}
- (IBAction)loginAction:(UIButton *)sender;
@end

@implementation ViewController
@synthesize delegate;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetFont];
    [[UIConstants returnInstance] ClearCart];
    btnUser.hidden = YES;
    //[[UIConstants returnInstance] setStrLanguage:(NSString *)lang_English];
    [[UIConstants returnInstance] setIsItEnglish:YES];
    
  //  BOOL  set =[[UIConstants returnInstance] isItEnglish];
    tblViewList = [[UITableView alloc]init];
    tblViewList.dataSource = self;
    tblViewList.delegate = self;
    tblViewList.tag = 1;
    
    tblViewAreaList = [[UITableView alloc]init]; //WithFrame:CGRectMake(imgViewSwitchBG.frame.origin.x, imgViewSwitchBG.frame.origin.y+btnHomeDelivery.frame.size.height, imgViewSwitchBG.frame.size.width, 170) style:UITableViewStylePlain];
    tblViewAreaList.dataSource = self;
    tblViewAreaList.delegate = self;
    tblViewAreaList.tag = 2;
    
    tblViewAreaList.layer.masksToBounds = YES;
    tblViewAreaList.layer.cornerRadius = 3;
    tblViewAreaList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tblViewAreaList.layer.borderWidth = 1;
    
    strCountryCode = @"";
    strStateCode = @"";
    strCityCode = @"";
    strAreaCode = @"";
    strSearchString= @"";
    strServiceType = @"H";

    _aryAreaList = [[NSMutableArray alloc] init];
    _aryHomeDeliverySupportedAreaList = [[NSMutableArray alloc] init];
    _aryTakeAwaySupportedAreaList = [[NSMutableArray alloc] init];
    _aryTempList = [[NSMutableArray alloc] init];

    if(![[UIConstants returnInstance] isItEnglish]){
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
    }
    [[UIConstants returnInstance] setStrServiceType:strServiceType];
    [[UIConstants returnInstance] setStrAreaName:strAreaCode];
    ObjServiceHandler = [[ServiceHandler alloc]init];
    if ([ObjServiceHandler GetCityForMobileAPI:[[UIConstants returnInstance] strAppID]]) {
        aryMenuList = [[ResponseDTO sharedInstance] DTO_SupportedCities];
        [[UIConstants returnInstance] setArySupportedCities:aryMenuList];
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    
//    if ([aryMenuList count] == 1) {
//        [[UIConstants returnInstance] setDicLocationDetails:[aryMenuList objectAtIndex:0]];
//        lblCityName.text = [[aryMenuList objectAtIndex:0] objectForKey:key_CityName];
//        strCityCode = [[aryMenuList objectAtIndex:0] objectForKey:key_CityName];
//        strCountryCode = [[aryMenuList objectAtIndex:0] objectForKey:key_CountryName];
//        strStateCode    = [[aryMenuList objectAtIndex:0] objectForKey:key_StateName];
//        [[UIConstants returnInstance] setStrCityCode:[[aryMenuList objectAtIndex:0] objectForKey:key_CityName]];
//        //[[UIConstants returnInstance] setArySupportedArea:[[aryMenuList objectAtIndex:0] objectForKey:key_Areas]];
//        [[UIConstants returnInstance] setStrCurrencyCode:[[aryMenuList objectAtIndex:0] objectForKey:key_CurrencyCode]];
//        [[UIConstants returnInstance] setDecimalPoint:[[[aryMenuList objectAtIndex:0] objectForKey:key_DecimalPoints] integerValue]];
//        [[UIConstants returnInstance] setStrDecimalPoints:[[aryMenuList objectAtIndex:0] objectForKey:key_DecimalPoints]];
//        [self SeparateAreaRestaurantList:[[aryMenuList objectAtIndex:0] objectForKey:key_Areas]];
//        //[[UIConstants returnInstance] setAryRestaurantsList:[[aryMenuList objectAtIndex:0] objectForKey:key_Restaurants]];
//    }
    [ObjServiceHandler release], ObjServiceHandler = nil;
    [self.view addSubview:tblViewAreaList];
    
    
    [lblCityName loadNibName];
    lblCityName.placeHolder = @"Select City";
    lblCityName.arrDataCombo = aryMenuList;
    lblCityName.keyName = key_CityName;
    
    lblCityName.frame =[[UIConstants returnInstance] getFrameForLanguage:lblCityName.frame withSuperViewRect:self.view.frame];
}

-(void)viewWillAppear:(BOOL)animated
{    
    if ([[UIConstants returnInstance] strFosUserID]) {
        loginBtn.hidden = YES;
        btnUser.hidden = NO;
        [btnUser setImage:[UIImage imageNamed:@"User_loggedIn.png"] forState:UIControlStateNormal];
    }else{
        loginBtn.hidden = NO;
        btnUser.hidden = YES;
        [btnUser setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    }
    
    [[UIConstants returnInstance] ClearFilterCache];
    
    if (viewLoginMenu.superview != nil) {
        [viewLoginMenu removeFromSuperview];
    }
    if(viewUserMenu.superview != nil){
        [viewUserMenu removeFromSuperview];
    }
    if (tblViewList.superview != nil) {
        [tblViewList removeFromSuperview];
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
    
    lblHome.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    btnChangeLanguage.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnHomeDelivery.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnTakeAway.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblCityName.font = [[UIConstants returnInstance] returnArvoRegular:16];
}

#pragma mark - Button action methods

-(void)OnClickChangeLanguageButton:(id)sender
{
//    if ([[UIConstants returnInstance] strLanguage] == lang_English) {
        if([[UIConstants returnInstance] isItEnglish]){
//        [[UIConstants returnInstance] setStrLanguage:(NSString *)lang_Arabic];
        [[UIConstants returnInstance] setIsItEnglish:NO];
        
        [btnChangeLanguage setTitle:@"English" forState:UIControlStateNormal];
        [self ChangeLanguageToArabic];
           [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];

    }else{
        //[[UIConstants returnInstance] setStrLanguage:(NSString *)lang_English];
        [[UIConstants returnInstance] setIsItEnglish:YES];
        [btnChangeLanguage setTitle:(NSString *)Arabic_LangName forState:UIControlStateNormal];
        [self ChangeLanguageToEnglish];
        [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    }
    tblViewAreaList.hidden = YES;
    
    [_aryAreaList removeAllObjects];
    [_aryHomeDeliverySupportedAreaList removeAllObjects];
    [_aryTakeAwaySupportedAreaList removeAllObjects];
    [_aryTempList removeAllObjects];
    
    ObjServiceHandler = [[ServiceHandler alloc]init];
    if ([ObjServiceHandler GetSupportedRegion]) {
        [[UIConstants returnInstance] setDicSupportedRegion:[[ResponseDTO sharedInstance] DTO_SupportedRegion]];
    }
     tblViewAreaList.hidden = YES;
    [ObjServiceHandler release], ObjServiceHandler = nil;
    [self OnClickDropDownButton:nil];
}

-(void)OnClickDropDownButton:(id)sender
{
    if (tblViewList.superview == nil) {
        [self GetSupportedCitiesList];
    }else{
        [tblViewList removeFromSuperview];
    }
}

-(void)OnClickHomeDeliveryOrTakeAwayButton:(id)sender
{
    [_aryAreaList removeAllObjects];
    if ([btnHomeDelivery isEnabled]) {
        strServiceType = @"H";
        btnHomeDelivery.enabled = NO;
        btnTakeAway.enabled = YES;
        [[UIConstants returnInstance] setStrServiceType:strServiceType];
        for (NSDictionary *dic in _aryTempList) {
            [_aryAreaList addObject:dic];
        }
        for (NSDictionary *dic in _aryHomeDeliverySupportedAreaList) {
            [_aryAreaList addObject:dic];
        }
        [self SetTableHight];
        [tblViewAreaList reloadData];
    }else if ([btnTakeAway isEnabled]){
        strServiceType = @"T";
        btnHomeDelivery.enabled = YES;
        btnTakeAway.enabled = NO;
        [[UIConstants returnInstance] setStrServiceType:strServiceType];
        for (NSDictionary *dic in _aryTempList) {
            [_aryAreaList addObject:dic];
        }
        for (NSDictionary *dic in _aryTakeAwaySupportedAreaList) {
            [_aryAreaList addObject:dic];
        }
        [self SetTableHight];
        [tblViewAreaList reloadData];
    }
}

-(void)OnClickLoginButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:YES];
    [self.delegate LoadNextScreen:VIEW_LOGIN];
}

-(void)OnClickRegisterButton:(id)sender
{
    [viewLoginMenu removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:YES];
    [self.delegate LoadNextScreen:VIEW_REGISTER];
}

-(void)OnClickSearchButton:(id)sender
{
//    [self.view endEditing:YES];
//    ObjServiceHandler = [[ServiceHandler alloc] init];
//    if ([ObjServiceHandler GetRestaurantListAPI :strCountryCode :strStateCode :strCityCode :strServiceType :txtFldRestaurant.text:strAreaCode])
//    {
//            [self.delegate LoadNextScreen:VIEW_RESTAURANTLIST];
//    }
    
}

-(void)OnClickInfoButton:(id)sender
{
    [self.delegate LoadNextScreen:VIEW_INFO];
}

-(void)OnClickUserButton:(id)sender
{
    if ([[UIConstants returnInstance] strFosUserID]) { // already loged in
        BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
        UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:(isArabic)? UserDetails_Arabic : UserDetails_Eng delegate:self cancelButtonTitle:(isArabic)? Cancel_Arabic : Cancel_Eng destructiveButtonTitle:nil otherButtonTitles:(isArabic)? EditProfile_Arabic : EditProfile_Eng ,(isArabic)? SignOut_Arabic : SignOut_Eng, nil];
        [sheet showInView:self.view];
        
//        if (viewUserMenu.superview == nil) {
//            viewUserMenu.frame = CGRectMake(self.view.frame.size.width - viewUserMenu.frame.size.width-5, btnUser.frame.origin.y + btnUser.frame.size.height + 8, viewUserMenu.frame.size.width, viewUserMenu.frame.size.height);
//            [self.view addSubview:viewUserMenu];
//        }else{
//            [viewUserMenu removeFromSuperview];
//        }
    }else{ // new user
//        if (viewLoginMenu.superview  == nil) {
//        viewLoginMenu.frame = CGRectMake(self.view.frame.size.width - viewLoginMenu.frame.size.width-5, btnUser.frame.origin.y + btnUser.frame.size.height + 8, viewLoginMenu.frame.size.width, viewLoginMenu.frame.size.height);
//            [self.view addSubview:viewLoginMenu];
//        }else {
//            [viewLoginMenu removeFromSuperview];
//        }
    }
}

-(void)OnClickEditProfileButton:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadNextScreen:VIEW_EDITPROFILE];
}

-(void)OnClickChangePassword:(id)sender
{
    [viewUserMenu removeFromSuperview];
    [self.delegate LoadTabBar:4];
}

-(void)OnClickSignOutButton:(id)sender
{
    [[UIConstants returnInstance] setStrFosUserID:nil];
    [btnUser setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    [viewUserMenu removeFromSuperview];
    btnUser.hidden = YES;
    loginBtn.hidden = NO;
}
#pragma mark - Other functional methods
-(void)GetSupportedCitiesList
{
    ObjServiceHandler = [[ServiceHandler alloc]init];
    if ([ObjServiceHandler GetCityForMobileAPI:[[UIConstants returnInstance] strAppID]]) {
        aryMenuList = [[ResponseDTO sharedInstance] DTO_SupportedCities];
        int hight;
        if ([aryMenuList count] > 2) {
            hight = 100;
        }else{
            hight = 40*[aryMenuList count];
        }
        tblViewList.frame = CGRectMake(imgViewDropDownBG.frame.origin.x+3, imgViewDropDownBG.frame.origin.y + imgViewDropDownBG.frame.size.height - 5, imgViewDropDownBG.frame.size.width - 10, hight);
        
        tblViewList.layer.masksToBounds = YES;
        tblViewList.layer.cornerRadius = 3;
        tblViewList.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tblViewList.layer.borderWidth = 1;

        [self.view addSubview:tblViewList];
        [tblViewList reloadData];
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    [ObjServiceHandler release],ObjServiceHandler = nil;
}

-(void)GetSupportedAreaList:(NSString *)AppId :(NSString *)CityId
{
    ObjServiceHandler = [[ServiceHandler alloc]init];
    if ([ObjServiceHandler GetLocationBasedOnCityCodeForMobileAPI:AppId :CityId]) {
        _aryAreaList = [[ResponseDTO sharedInstance] DTO_AreaList];
        NSLog(@"%i,%i",[arySupportedArea count], [_aryAreaList count]);
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    [tblViewAreaList reloadData];
    [ObjServiceHandler release],ObjServiceHandler = nil;
    
}

//separate Area and Restaurant List

-(void)SeparateAreaRestaurantList:(NSArray *)AryList
{
    BOOL isHomeDeliverySupported = NO;
    BOOL isTakeAwaySupported = NO;
    
    [_aryAreaList removeAllObjects];
    [_aryHomeDeliverySupportedAreaList removeAllObjects];
    [_aryTakeAwaySupportedAreaList removeAllObjects];
    [_aryTempList removeAllObjects];
    
    for (NSDictionary *dicArea in AryList) {
        for(NSDictionary *dicRestaurant in [dicArea objectForKey:key_Restaurants]){
            if ([[dicRestaurant valueForKey:key_isHomeDeliverySupport] integerValue] == 1 && [[dicRestaurant valueForKey:key_isTakeAwaySupport] integerValue] == 1) {
                isHomeDeliverySupported = YES;
                isTakeAwaySupported = YES;
                break;
            }else if([[dicRestaurant valueForKey:key_isHomeDeliverySupport] integerValue] == 0 && [[dicRestaurant valueForKey:key_isTakeAwaySupport] integerValue] == 1) {
                isTakeAwaySupported = YES;
            }else if([[dicRestaurant valueForKey:key_isHomeDeliverySupport] integerValue] == 1 && [[dicRestaurant valueForKey:key_isTakeAwaySupport] integerValue] == 0) {
                isHomeDeliverySupported = YES;
            }
        }
        if (isHomeDeliverySupported && isTakeAwaySupported) {
            [_aryTempList addObject:dicArea];
        }else if (isHomeDeliverySupported && !isTakeAwaySupported) {
            [_aryHomeDeliverySupportedAreaList addObject:dicArea];
        }else if (!isHomeDeliverySupported && isTakeAwaySupported) {
            [_aryTakeAwaySupportedAreaList addObject:dicArea];
        }
    }
    
    if ([strServiceType isEqual: @"H"]) {
        for (NSDictionary *dic in _aryTempList) {
            [_aryAreaList addObject:dic];
        }
        for (NSDictionary *dic in _aryHomeDeliverySupportedAreaList) {
            [_aryAreaList addObject:dic];
        }
    }else if([strServiceType isEqual:@"T"]){
        for (NSDictionary *dic in _aryTempList) {
            [_aryAreaList addObject:dic];
        }
        for (NSDictionary *dic in _aryTakeAwaySupportedAreaList) {
            [_aryAreaList addObject:dic];
        }
    }
    
    [self SetTableHight];
    [tblViewAreaList reloadData];
}

-(void)GetRestaurantMenuList:(NSString *)RestaurantIdentifier
{
    ObjServiceHandler = [[ServiceHandler alloc]init];
    
    if ([ObjServiceHandler GetRestaurantMenuListAPI:RestaurantIdentifier :[[UIConstants returnInstance] strAppID]]) {
        [self.delegate LoadTabBar:1];
    }else{
        if ([[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusCode] integerValue] == 2000) {
            [[UIConstants returnInstance] ShowNoNetworkAlert];
        }else{
            [[UIConstants returnInstance] ShowAlert:[[[ResponseDTO sharedInstance] DTO_ErrorMessage] objectForKey:key_StatusMessage]];
        }
    }
    
    [ObjServiceHandler release],ObjServiceHandler = nil;
}

-(void)SetTableHight
{
    
    if ([_aryAreaList count] == 0) {
        tblViewAreaList.hidden = YES;
    }else if ([_aryAreaList count] >= 4) {
        tblViewAreaList.hidden = NO;
        tblViewAreaList.frame = CGRectMake(imgViewSwitchBG.frame.origin.x, imgViewSwitchBG.frame.origin.y+btnHomeDelivery.frame.size.height, imgViewSwitchBG.frame.size.width, 170);
    }else{
        tblViewAreaList.hidden = NO;
        tblViewAreaList.frame = CGRectMake(imgViewSwitchBG.frame.origin.x, imgViewSwitchBG.frame.origin.y+btnHomeDelivery.frame.size.height, imgViewSwitchBG.frame.size.width, 40*[_aryAreaList count]);
    }
}

#pragma mark - Change Language Methods

-(void)ChangeLanguageToEnglish
{
   
    lblHome.text = (NSString *)Home_Eng;
    lblCityName.selectedText = SelectCity_Eng;
    [btnHomeDelivery setTitle:(NSString *)HomeDelivery_Eng forState:UIControlStateNormal];
    [btnTakeAway setTitle:(NSString *)TakeAway_Eng forState:UIControlStateNormal];
    
   // lblCityName.textAlignment = NSTextAlignmentLeft;
  //  lblCityName.frame = CGRectMake(imgViewDropDownBG.frame.origin.x + 10, lblCityName.frame.origin.y, lblCityName.frame.size.width, lblCityName.frame.size.height);
    viewDropDownBtn.frame = CGRectMake(lblCityName.frame.origin.x + lblCityName.frame.size.width+1, viewDropDownBtn.frame.origin.y, viewDropDownBtn.frame.size.width, viewDropDownBtn.frame.size.height);
    
    [btnLogin setTitle:(NSString *)Login_Eng forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Eng forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Eng forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Eng forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Eng forState:UIControlStateNormal];
    //lblCityName.text = @"";
    [self GetSupportedCitiesList];
    lblCityName.frame =[[UIConstants returnInstance] getFrameForLanguage:lblCityName.frame withSuperViewRect:self.view.frame];
    [lblCityName loadNibName];
      lblCityName.placeHolder= SelectCity_Eng;
    lblCityName.arrDataCombo = aryMenuList;
}

-(void)ChangeLanguageToArabic
{
   
    lblHome.text = (NSString *)Home_Arabic;
    lblCityName.selectedText = SelectCity_Arabic;
    [btnHomeDelivery setTitle:(NSString *)HomeDelivery_Arabic forState:UIControlStateNormal];
    [btnTakeAway setTitle:(NSString *)TakeAway_Arabic forState:UIControlStateNormal];
    
   // lblCityName.textAlignment = NSTextAlignmentRight;
    viewDropDownBtn.frame = CGRectMake(imgViewDropDownBG.frame.origin.x, viewDropDownBtn.frame.origin.y, viewDropDownBtn.frame.size.width, viewDropDownBtn.frame.size.height);
  //  lblCityName.frame = CGRectMake(viewDropDownBtn.frame.origin.x + viewDropDownBtn.frame.size.width+1, lblCityName.frame.origin.y, lblCityName.frame.size.width, lblCityName.frame.size.height);
    
    [btnLogin setTitle:(NSString *)Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];
    //lblCityName.text = @"";
    [self GetSupportedCitiesList];
    lblCityName.frame =[[UIConstants returnInstance] getFrameForLanguage:lblCityName.frame withSuperViewRect:self.view.frame];
    [lblCityName loadNibName];
     lblCityName.placeHolder = SelectCity_Arabic;
    lblCityName.arrDataCombo = aryMenuList;
}

#pragma mark - textfield delegate methods

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.25];
//    self.view.frame = CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height);
//    if (textField.tag == 1) {
//        if (tblViewAreaList.superview == nil && [arySupportedArea count] != 0) {
//            [self.view addSubview:tblViewAreaList];
//        }
//    }
//    [UIView commitAnimations];
//}
//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if ([string isEqualToString:@"\n"]) {
//        [textField resignFirstResponder];
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25];
//        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        if (tblViewAreaList.superview != nil) {
//            [tblViewAreaList removeFromSuperview];
//        }
//        [UIView commitAnimations];
//    }else{
//        if (textField.tag == 1){
//            if (tblViewAreaList.superview == nil && [arySupportedArea count] != 0) {
//                [self.view addSubview:tblViewAreaList];
//            }
//            [self GetSearchResultArray:[NSString stringWithFormat:@"%@%@", textField.text,string]];
//        }
//    }
//    return YES;
//}

#pragma mark - TableView delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1)
        return [aryMenuList count];
    else if (tableView.tag == 2)
        NSLog(@"%d", [_aryAreaList count]);
        return [_aryAreaList count];
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    _cell.textLabel.font = [[UIConstants returnInstance] returnArvoRegular:14];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView.tag == 1) {
        _cell.textLabel.text = [[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_CityName];
//        if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
            if(![[UIConstants returnInstance] isItEnglish]){
            _cell.textLabel.textAlignment = FOS_TEXTALIGNMENT;
        }
        NSLog(@"%@", [[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_CityName]);
    }else if (tableView.tag == 2){
         NSLog(@"%@", [[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_AreaName]);
        UILabel *_lblAreaName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, tableView.frame.size.width - 20, 30)];
        _lblAreaName.text = [[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_AreaName];
        _lblAreaName.font = [[UIConstants returnInstance] returnArvoRegular:14];
//        if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
            if(![[UIConstants returnInstance] isItEnglish]){
            _lblAreaName.textAlignment = NSTextAlignmentRight;
        }
        UIImageView *_imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 20, 15, 10, 10)];
        if(![[UIConstants returnInstance] isItEnglish]){
            _imgArrow.frame = CGRectMake( 10, 15, 10, 10);
            _imgArrow.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            
        }
        _imgArrow.image = [UIImage imageNamed:@"Homearrow.png"];
        [_cell addSubview:_lblAreaName];
        [_cell addSubview:_imgArrow];
        NSLog(@"%@", [[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_AreaName]);
    }
    return _cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        [[UIConstants returnInstance] setDicLocationDetails:[aryMenuList objectAtIndex:indexPath.row]];
        lblCityName.selectedText = [[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_CityName];
        strCityCode = [[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_CityName];
        strCountryCode = [[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_CountryName];
        strStateCode    = [[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_StateName];
        [tblViewList removeFromSuperview];
        [[UIConstants returnInstance] setStrCityCode:[[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_CityName]];
        //[[UIConstants returnInstance] setArySupportedArea:[[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_Areas]];
        [[UIConstants returnInstance] setStrCurrencyCode:[[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_CurrencyCode]];
        [[UIConstants returnInstance] setStrDecimalPoints:[[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_DecimalPoints]];
        [[UIConstants returnInstance] setDecimalPoint:[[[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_DecimalPoints] integerValue]];
        [self SeparateAreaRestaurantList:[[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_Areas]];
    }else if (tableView.tag == 2) {
       // txtFldArea.text = [[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_AreaName];
        strAreaCode = [[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_AreaName];
        [[UIConstants returnInstance] setStrAreaName:strAreaCode];
        [[UIConstants returnInstance] setAryRestaurantsList:[[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Restaurants]];
        
        if ([[[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Restaurants] count] == 1) {
            
            NSInteger vl = [[[[[UIConstants returnInstance] aryRestaurantsList] objectAtIndex:0] objectForKey:key_DecimalPoints] integerValue];
            [[UIConstants returnInstance] setDecimalPoint:vl];
            
            [self GetRestaurantMenuList:[[[[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Restaurants] objectAtIndex:0] objectForKey:key_Identifier]];
            
        }else if ([[[_aryAreaList objectAtIndex:indexPath.row] objectForKey:key_Restaurants] count] > 1) {
            
            [self.delegate LoadNextScreen:VIEW_RESTAURANTLIST];
        }
        
      //  [tableView removeFromSuperview];
    }
}

#pragma mark - array for drop down list
-(void)GetSearchResultArray:(NSString *)SearchString
{
    [_aryTempList removeAllObjects];
    NSString *upperString = [SearchString uppercaseString];

    for (NSDictionary *dic in arySupportedArea) {
        if (SearchString.length == 0) {
            if (tblViewAreaList.superview != nil)
                [tblViewAreaList removeFromSuperview];
            break;
        }
        NSRange range = [[[dic objectForKey:key_AreaName] uppercaseString] rangeOfString:upperString];
        if (range.location != NSNotFound) {
            [_aryTempList addObject:dic];
        }
    }
    [tblViewAreaList reloadData];
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
//    if (tblViewList.superview != nil) {
//        [tblViewList removeFromSuperview];
//    }
}
- (void)dealloc {
    [loginBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [loginBtn release];
    loginBtn = nil;
    [super viewDidUnload];
}

#pragma mark -
- (IBAction)loginAction:(UIButton *)sender {
    [self OnClickLoginButton:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){ //edit profile
        [self OnClickEditProfileButton:nil];
    }else if(buttonIndex == 1){ //sign out
        [self OnClickSignOutButton:nil];

    }
}

- (void)onClickComboSelection:(id)comboBox
{
    [[UIConstants returnInstance] setDicLocationDetails:[aryMenuList objectAtIndex:lblCityName.selectedRow]];
    lblCityName.selectedText = [[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_CityName];
    strCityCode = [[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_CityName];
    strCountryCode = [[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_CountryName];
    strStateCode    = [[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_StateName];
    [tblViewList removeFromSuperview];
    [[UIConstants returnInstance] setStrCityCode:[[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_CityName]];
    //[[UIConstants returnInstance] setArySupportedArea:[[aryMenuList objectAtIndex:indexPath.row] objectForKey:key_Areas]];
    [[UIConstants returnInstance] setStrCurrencyCode:[[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_CurrencyCode]];
    [[UIConstants returnInstance] setStrDecimalPoints:[[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_DecimalPoints]];
    [[UIConstants returnInstance] setDecimalPoint:[[[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_DecimalPoints] integerValue]];
    [self SeparateAreaRestaurantList:[[aryMenuList objectAtIndex:lblCityName.selectedRow] objectForKey:key_Areas]];
}
@end
