//
//  RestaurantList.m

//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "RestaurantList.h"
#import "JSON.h"
#import "APIConstants.h"
#import "ServiceHandler.h"
#import "ResponseDTO.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
#import <QuartzCore/QuartzCore.h>

@interface RestaurantList ()<UIActionSheetDelegate>
{
    UIImage *imgStar_Sel;
    UIImage *imgStar_Unsel;
    ServiceHandler *ObjServiceHandler;
    IBOutlet UIButton *loginBtn;
    NSDictionary *DicRestaurantDetails;
    
    NSInteger selectedIndex;
}
- (IBAction)loginAction:(UIButton *)sender;
@end

@implementation RestaurantList
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
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic ) {
        if(![[UIConstants returnInstance] isItEnglish]){
        [self ChangeLanguageToArabic];
    }
    [self GetRestaurantList];
    imgStar_Sel = [UIImage imageNamed:@""];
    imgStar_Unsel = [UIImage imageNamed:@""];
//    lblScreenName.text = [NSString stringWithFormat:@"%@ | %@", [[UIConstants returnInstance] strCityCode], [[UIConstants returnInstance] strAreaName]];
    
    if(![[UIConstants returnInstance] isItEnglish]){
        [loginBtn setTitle:Login_Arabic forState:UIControlStateNormal];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    tblViewRestaurant.layer.masksToBounds = YES;
    tblViewRestaurant.layer.cornerRadius = 3;
    tblViewRestaurant.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tblViewRestaurant.layer.borderWidth = 1;
    
    if ([[UIConstants returnInstance] strFosUserID]) {
        loginBtn.hidden = YES;
        btnUser.hidden = NO;
        [btnUser setImage:[UIImage imageNamed:@"User_loggedIn.png"] forState:UIControlStateNormal];
    }else{
        loginBtn.hidden = NO;
        btnUser.hidden = YES;
        [btnUser setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    }
    
    //aryRestaurantList = [[UIConstants returnInstance]aryRestaurantsList];
    
    [tblViewRestaurant reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

-(void)GetRestaurantList
{
    aryRestaurantList = [[NSMutableArray alloc] init];
    if ([[[UIConstants returnInstance] strServiceType] isEqual: @"H"]) {
        for (NSDictionary *dicRestaurant in [[UIConstants returnInstance]aryRestaurantsList]) {
            if ([[dicRestaurant valueForKey:key_isHomeDeliverySupport] integerValue] == 1) {
                [aryRestaurantList addObject:dicRestaurant];
            }
        }
    } else if ([[[UIConstants returnInstance] strServiceType] isEqual: @"T"]) {
        for (NSDictionary *dicRestaurant in [[UIConstants returnInstance]aryRestaurantsList]) {
            if ([[dicRestaurant valueForKey:key_isTakeAwaySupport] integerValue] == 1) {
                [aryRestaurantList addObject:dicRestaurant];
            }
        }
    }
    
    if ([aryRestaurantList count] > 5) {
        tblViewRestaurant.frame = CGRectMake(tblViewRestaurant.frame.origin.x, tblViewRestaurant.frame.origin.y, tblViewRestaurant.frame.size.width, 230);
    }else{
        tblViewRestaurant.frame = CGRectMake(tblViewRestaurant.frame.origin.x, tblViewRestaurant.frame.origin.y, tblViewRestaurant.frame.size.width, 40*[aryRestaurantList count]);
    }
    
    [tblViewRestaurant reloadData];
}

-(void)SetStarRating:(UIView *)Subview :(NSDictionary *)Dic
{
    UIImageView *imgStar1  = [[UIImageView alloc]initWithFrame:CGRectMake(25,  20, 15, 15)];
    UIImageView *imgStar2  = [[UIImageView alloc]initWithFrame:CGRectMake(45,  20, 15, 15)];
    UIImageView *imgStar3  = [[UIImageView alloc]initWithFrame:CGRectMake(65,  20, 15, 15)];
    UIImageView *imgStar4  = [[UIImageView alloc]initWithFrame:CGRectMake(85,  20, 15, 15 )];
    UIImageView *imgStar5  = [[UIImageView alloc]initWithFrame:CGRectMake(105, 20, 15, 15)];
    
//    if ([[Dic valueForKey:key_Rating] integerValue] == 0) {
//        imgStar1.image = imgStar_Unsel;
//        imgStar2.image = imgStar_Unsel;
//        imgStar3.image = imgStar_Unsel;
//        imgStar4.image = imgStar_Unsel;
//        imgStar5.image = imgStar_Unsel;
//    }else{
//        if ([[Dic valueForKey:key_r] integerValue] == 1) {
//            imgStar1.image = imgStar_Sel;
//            imgStar2.image = imgStar_Unsel;
//            imgStar3.image = imgStar_Unsel;
//            imgStar4.image = imgStar_Unsel;
//            imgStar5.image = imgStar_Unsel;
//        }else if ([[Dic valueForKey:key_Rating] integerValue] == 2) {
//            imgStar1.image = imgStar_Sel;
//            imgStar2.image = imgStar_Sel;
//            imgStar3.image = imgStar_Unsel;
//            imgStar4.image = imgStar_Unsel;
//            imgStar5.image = imgStar_Unsel;
//        }else if ([[Dic valueForKey:key_Rating] integerValue] == 3) {
//            imgStar1.image = imgStar_Sel;
//            imgStar2.image = imgStar_Sel;
//            imgStar3.image = imgStar_Sel;
//            imgStar4.image = imgStar_Unsel;
//            imgStar5.image = imgStar_Unsel;
//        }else if ([[Dic valueForKey:key_Rating] integerValue] == 4) {
//            imgStar1.image = imgStar_Sel;
//            imgStar2.image = imgStar_Sel;
//            imgStar3.image = imgStar_Sel;
//            imgStar4.image = imgStar_Sel;
//            imgStar5.image = imgStar_Unsel;
//        }else if ([[Dic valueForKey:key_Rating] integerValue] == 5) {
//            imgStar1.image = imgStar_Sel;
//            imgStar2.image = imgStar_Sel;
//            imgStar3.image = imgStar_Sel;
//            imgStar4.image = imgStar_Sel;
//            imgStar5.image = imgStar_Sel;
//        }
//    }
    [Subview addSubview:imgStar1];
    [Subview addSubview:imgStar2];
    [Subview addSubview:imgStar3];
    [Subview addSubview:imgStar4];
    [Subview addSubview:imgStar5];
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

#pragma mark - Set Font

-(void)SetFont
{
    btnEditProfile.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnChangePassword.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnSignOut.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    loginBtn.titleLabel.font = [[UIConstants returnInstance] returnArvoRegular:15];
    btnRegister.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    lblServingRestaurants.font = [[UIConstants returnInstance] returnArvoBold:16];
    btnHome.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
}

#pragma mark - Button action methods

-(void)OnClickGoHomeButton:(id)sender
{
    [self.delegate GoHome];
}

//-(void)OnClickFilterButton:(id)sender
//{
//    ObjServiceHandler = [[ServiceHandler alloc] init];
//    if ([ObjServiceHandler GetFilterListforMobileAPI:@"session1"]) {
//        [self.delegate LoadNextScreen:VIEW_FILTEROPTION];
//    }else{
//        [[UIConstants returnInstance] ShowAlert:@"Filters are not available. Please try again later."];
//    }
//}

-(void)OnClickSearchButton:(id)sender
{
    
}

-(void)OnClickUserButton:(id)sender
{
    if ([[UIConstants returnInstance] strFosUserID]) {
//        viewUserMenu.frame = CGRectMake(self.view.frame.size.width - viewUserMenu.frame.size.width-5, btnUser.frame.origin.y + btnUser.frame.size.height + 8, viewUserMenu.frame.size.width, viewUserMenu.frame.size.height);
//        if (viewUserMenu.superview == nil) {
//            [self.view addSubview:viewUserMenu];
//        }else{
//            [viewUserMenu removeFromSuperview];
//        }
//    }else{
//        viewList.frame = CGRectMake(self.view.frame.size.width - viewList.frame.size.width-5, btnUser.frame.origin.y + btnUser.frame.size.height + 8, viewList.frame.size.width, viewList.frame.size.height);
//        if (viewList.superview  == nil) {
//            [self.view addSubview:viewList];
//        }else {
//            [viewList removeFromSuperview];
//        }
        
        BOOL isArabic =![[UIConstants returnInstance] isItEnglish];
        UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:(isArabic)? UserDetails_Arabic : UserDetails_Eng delegate:self cancelButtonTitle:(isArabic)? Cancel_Arabic : Cancel_Eng destructiveButtonTitle:nil otherButtonTitles:(isArabic)? EditProfile_Arabic : EditProfile_Eng ,(isArabic)? SignOut_Arabic : SignOut_Eng, nil];

        [sheet showInView:self.view];

    }

}

-(void)OnClickLoginbutton:(id)sender
{
    [viewList removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_LOGIN];
}

-(void)OnClickRegisterButton:(id)sender
{
    [viewList removeFromSuperview];
    [[UIConstants returnInstance] setIsLoginViaHome:NO];
    [self.delegate LoadNextScreen:VIEW_REGISTER];
    
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
    [btnUser setImage:[UIImage imageNamed:@"User_not_loggedIn.png"] forState:UIControlStateNormal];
    [[UIConstants returnInstance] setStrFosUserID:nil];
    [viewUserMenu removeFromSuperview];
    loginBtn.hidden = NO;
    btnUser.hidden = YES;
}

-(void)OnClickInfoButton:(id)sender
{
    [self.delegate LoadNextScreen:VIEW_INFO];
}

#pragma mark - TextField Delegate methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [aryRestaurantList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[aryRestaurantList objectAtIndex:indexPath.row] valueForKey:key_Identifier]];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *_lblBranchName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, tableView.frame.size.width - 20, 30)];
    _lblBranchName.text = [[aryRestaurantList objectAtIndex:indexPath.row] valueForKey:key_Name];
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
        if(![[UIConstants returnInstance] isItEnglish]){
        _lblBranchName.textAlignment = NSTextAlignmentRight;
    }
     _lblBranchName.font = [[UIConstants returnInstance] returnArvoRegular:14];
    CGRect rect = CGRectMake(tableView.frame.size.width - 25, 15, 10, 10);
   UIImageView *_imgArrow = [[UIImageView alloc] initWithFrame:rect];
    if(![[UIConstants returnInstance] isItEnglish]){
        _imgArrow.frame = CGRectMake( 15, 15, 10, 10);
        _imgArrow.transform = CGAffineTransformMakeScale(-1.0, 1.0);

    }
    
    _imgArrow.image = [UIImage imageNamed:@"Homearrow.png"];
    [_cell addSubview:_lblBranchName];
    [_cell addSubview:_imgArrow];
    
    return _cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[[[UIConstants returnInstance] dicRestaurantDetails] objectForKey:key_Identifier] isEqualToString:[[aryRestaurantList objectAtIndex:indexPath.row] objectForKey:key_Identifier]] && [[[UIConstants returnInstance] aryCartDetails]count] > 0) {
        selectedIndex = indexPath.row;
        [self ShowAlertForExistingRestaurant:[aryRestaurantList objectAtIndex:indexPath.row]];
    }else{
        [[UIConstants returnInstance] setDicRestaurantDetails:[aryRestaurantList objectAtIndex:indexPath.row]];
        [self GetRestaurantMenuList:[[aryRestaurantList objectAtIndex:indexPath.row] objectForKey:key_Identifier]];
    }
}

#pragma mark - Change Language Method
-(void)ChangeLanguageToArabic
{
    lblScreenName.text = (NSString *)Restaurants_Arabic;
    lblServingRestaurants.text = (NSString *)ServingRestaurants_Arabic;
    lblServingRestaurants.textAlignment = NSTextAlignmentRight;
    
    [btnLogin setTitle:(NSString *)Login_Arabic forState:UIControlStateNormal];
    [btnRegister setTitle:(NSString *)Register_Arabic forState:UIControlStateNormal];
    [btnEditProfile setTitle:(NSString *)EditProfile_Arabic forState:UIControlStateNormal];
    [btnChangePassword setTitle:(NSString *)ChangePassword_Arabic forState:UIControlStateNormal];
    [btnSignOut setTitle:(NSString *)SignOut_Arabic forState:UIControlStateNormal];
    [btnHome setTitle:(NSString *)Back_Arabic forState:UIControlStateNormal];
}

#pragma mark - touch recognition method

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (viewList.superview != nil) {
        [viewList removeFromSuperview];
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
        _strMessage = Alert_RestaurantChange_English;
        _strButton1 = Yes_English;
        _strButton2 = No_English;
    }else{
        _strTitle = Alert_Arabic;
        _strMessage = Alert_RestaurantChange_Arabic;
        _strButton1 = Yes_Arabic;
        _strButton2 = No_Arabic;
    }
    DicRestaurantDetails = RestaurantDetails;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_strTitle message:_strMessage delegate:self cancelButtonTitle:_strButton1 otherButtonTitles:_strButton2, nil];
    alert.tag = 101; //anu changes
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIConstants returnInstance] setDicRestaurantDetails:DicRestaurantDetails];
        [[UIConstants returnInstance] setAryCartDetails:nil];
        for (UIViewController *viewController in self.tabBarController.viewControllers) {
            if (viewController.tabBarItem.tag == 2) {
                viewController.tabBarItem.badgeValue = nil;
            }
        }
        
        [self GetRestaurantMenuList:[[aryRestaurantList objectAtIndex:selectedIndex] objectForKey:key_Identifier]];
    }
}

#pragma mark -
- (IBAction)loginAction:(UIButton *)sender {
    [self OnClickLoginbutton:nil];
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
