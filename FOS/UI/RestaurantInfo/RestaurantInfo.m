//
//  RestaurantInfo.m

//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "RestaurantInfo.h"
#import "UIConstants.h"
#import "APIConstants.h"
#import "ServiceHandler.h"
#import "LanguageConstants.h"

#define isempty(_x_)   _x_ != [NSNull null] && _x_ != Nil && ![_x_ isEqualToString:@""]

@interface RestaurantInfo ()
{
    ServiceHandler *ObjServiceHandler;
}
@end

@implementation RestaurantInfo
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
    // Do any additional setup after loading the view from its nib.
    //[lblRestaurantName sizeToFit];
    [self SetFont];
    if (![[UIConstants returnInstance] isItEnglish]) {
        [self ChangeLanguageToArabic];
    }
    [self SetRestaurantInfo];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - set font
-(void)SetFont
{
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    lblRestaurantName.font = [[UIConstants returnInstance] returnArvoBold:18];
    lblRestaurantArea.font = [[UIConstants returnInstance] returnArvoBold:18];
    lblOpeningHrs.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblCuisines.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblReviewRatings.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblOverallRating.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblExpensive.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblTImelyDelivery.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblTaste.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblRestaurantTiming.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblCuisineType.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblTakeAwayIn.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblTakeAwayTime.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblHomeDeliveryIn.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblHomeDeliveryTime.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblDeliverySupportedAreas.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblDeliverySupportedArea.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblCostForTwoText.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblCostForTwo.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblLanguagesSpokenText.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblLanguagesSpoken.font = [[UIConstants returnInstance] returnArvoRegular:14];
    lblFacilities.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblAddressText.font = [[UIConstants returnInstance] returnArvoBold:16];
    lblAddress.font = [[UIConstants returnInstance] returnArvoRegular:14];
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    
}

-(void)ChangeLanguageToArabic
{
    [btnGoBack setTitle:Back_Arabic forState:UIControlStateNormal];
    
    lblScreenName.text = RestaurantInfo_Arabic;
    lblReviewRatings.text = ReviewRating_Arabic;
    lblOverallRating.text = OverallRating_Arabic;
    lblExpensive.text = Expensive_Arabic;
    lblTImelyDelivery.text = TimelyDelivery_Arabic;
    lblTaste.text = Taste_Arabic;
    lblRestaurantTiming.text = RestaurantTiming_Arabic;
    lblCuisineType.text = CuisineType_Arabic;
    lblTakeAwayIn.text = TakeAwayIn_Arabic;
    lblHomeDeliveryIn.text = HomeDeliveryIn_Arabic;
    lblDeliverySupportedAreas.text = DeliverySupportedAreas_Arabic;
    lblCostForTwoText.text = CostForTwo_Arabic;
    lblLanguagesSpokenText.text = LanguagesSpoken_Arabic;
    lblFacilities.text = Facilities_Arabic;
    lblAddressText.text = AddressNonStared_Arabic;
    
    lblAddress.textAlignment = FOS_TEXTALIGNMENT;
    lblAddressText.textAlignment = FOS_TEXTALIGNMENT;
    lblCostForTwo.textAlignment = FOS_TEXTALIGNMENT;
    lblCostForTwoText.textAlignment = FOS_TEXTALIGNMENT;
    lblCuisines.textAlignment = FOS_TEXTALIGNMENT;
    lblCuisineType.textAlignment = FOS_TEXTALIGNMENT;
    lblDeliverySupportedArea.textAlignment = FOS_TEXTALIGNMENT;
    lblDeliverySupportedAreas.textAlignment = FOS_TEXTALIGNMENT;
    lblExpensive.textAlignment = FOS_TEXTALIGNMENT;
    lblFacilities.textAlignment = FOS_TEXTALIGNMENT;
    lblHomeDeliveryIn.textAlignment = FOS_TEXTALIGNMENT;
    lblHomeDeliveryTime.textAlignment = FOS_TEXTALIGNMENT;
    lblLanguagesSpoken.textAlignment = FOS_TEXTALIGNMENT;
    lblLanguagesSpokenText.textAlignment = FOS_TEXTALIGNMENT;
    lblOpeningHrs.textAlignment = FOS_TEXTALIGNMENT;
    lblOverallRating.textAlignment = FOS_TEXTALIGNMENT;
    lblRestaurantArea.textAlignment = FOS_TEXTALIGNMENT;
    lblRestaurantName.textAlignment = FOS_TEXTALIGNMENT;
    lblRestaurantTiming.textAlignment = FOS_TEXTALIGNMENT;
    lblReviewRatings.textAlignment = FOS_TEXTALIGNMENT;
    lblScreenName.textAlignment = FOS_TEXTALIGNMENT;
    lblTakeAwayIn.textAlignment = FOS_TEXTALIGNMENT;
    lblTakeAwayTime.textAlignment = FOS_TEXTALIGNMENT;
    lblTaste.textAlignment = FOS_TEXTALIGNMENT;
    lblTImelyDelivery.textAlignment = FOS_TEXTALIGNMENT;
    
    lblAddress.frame = [[UIConstants returnInstance] getFrameForLanguage:lblAddress.frame withSuperViewRect:lblAddress.superview.frame];
    lblAddressText.frame = [[UIConstants returnInstance] getFrameForLanguage:lblAddressText.frame withSuperViewRect:lblAddressText.superview.frame];
    lblCostForTwo.frame = [[UIConstants returnInstance] getFrameForLanguage:lblCostForTwo.frame withSuperViewRect:lblCostForTwo.superview.frame];
    lblCostForTwoText.frame = [[UIConstants returnInstance] getFrameForLanguage:lblCostForTwoText.frame withSuperViewRect:lblCostForTwoText.superview.frame];
    lblCuisines.frame = [[UIConstants returnInstance] getFrameForLanguage:lblCuisines.frame withSuperViewRect:lblCuisines.superview.frame];
    lblCuisineType.frame = [[UIConstants returnInstance] getFrameForLanguage:lblCuisineType.frame withSuperViewRect:lblCuisineType.superview.frame];
    lblDeliverySupportedArea.frame = [[UIConstants returnInstance] getFrameForLanguage:lblDeliverySupportedArea.frame withSuperViewRect:lblDeliverySupportedArea.superview.frame];
    lblDeliverySupportedAreas.frame = [[UIConstants returnInstance] getFrameForLanguage:lblDeliverySupportedAreas.frame withSuperViewRect:lblDeliverySupportedAreas.superview.frame];
    lblExpensive.frame = [[UIConstants returnInstance] getFrameForLanguage:lblExpensive.frame withSuperViewRect:lblExpensive.superview.frame];
    lblFacilities.frame = [[UIConstants returnInstance] getFrameForLanguage:lblFacilities.frame withSuperViewRect:lblFacilities.superview.frame];
    lblHomeDeliveryIn.frame = [[UIConstants returnInstance] getFrameForLanguage:lblHomeDeliveryIn.frame withSuperViewRect:lblHomeDeliveryIn.superview.frame];
    lblHomeDeliveryTime.frame = [[UIConstants returnInstance] getFrameForLanguage:lblHomeDeliveryTime.frame withSuperViewRect:lblHomeDeliveryTime.superview.frame];
    lblLanguagesSpoken.frame = [[UIConstants returnInstance] getFrameForLanguage:lblLanguagesSpoken.frame withSuperViewRect:lblLanguagesSpoken.superview.frame];
    lblLanguagesSpokenText.frame = [[UIConstants returnInstance] getFrameForLanguage:lblLanguagesSpokenText.frame withSuperViewRect:lblLanguagesSpokenText.superview.frame];
    lblOpeningHrs.frame = [[UIConstants returnInstance] getFrameForLanguage:lblOpeningHrs.frame withSuperViewRect:lblOpeningHrs.superview.frame];
    lblOverallRating.frame = [[UIConstants returnInstance] getFrameForLanguage:lblOverallRating.frame withSuperViewRect:lblOverallRating.superview.frame];
    lblRestaurantArea.frame = [[UIConstants returnInstance] getFrameForLanguage:lblRestaurantArea.frame withSuperViewRect:lblRestaurantArea.superview.frame];
    lblRestaurantName.frame = [[UIConstants returnInstance] getFrameForLanguage:lblRestaurantName.frame withSuperViewRect:lblRestaurantName.superview.frame];
    lblRestaurantTiming.frame = [[UIConstants returnInstance] getFrameForLanguage:lblRestaurantTiming.frame withSuperViewRect:lblRestaurantTiming.superview.frame];
    lblReviewRatings.frame = [[UIConstants returnInstance] getFrameForLanguage:lblReviewRatings.frame withSuperViewRect:lblReviewRatings.superview.frame];
    lblTakeAwayIn.frame = [[UIConstants returnInstance] getFrameForLanguage:lblTakeAwayIn.frame withSuperViewRect:lblTakeAwayIn.superview.frame];
    lblTakeAwayTime.frame = [[UIConstants returnInstance] getFrameForLanguage:lblTakeAwayTime.frame withSuperViewRect:lblTakeAwayTime.superview.frame];
    lblTaste.frame = [[UIConstants returnInstance] getFrameForLanguage:lblTaste.frame withSuperViewRect:lblTaste.superview.frame];
    lblTImelyDelivery.frame = [[UIConstants returnInstance] getFrameForLanguage:lblTImelyDelivery.frame withSuperViewRect:lblTImelyDelivery.superview.frame];
    
    imgViewDelivery1.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewDelivery1.frame withSuperViewRect:imgViewDelivery1.superview.frame];
    imgViewDelivery2.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewDelivery2.frame withSuperViewRect:imgViewDelivery2.superview.frame];
    imgViewDelivery3.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewDelivery3.frame withSuperViewRect:imgViewDelivery3.superview.frame];
    imgViewDelivery4.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewDelivery4.frame withSuperViewRect:imgViewDelivery4.superview.frame];
    imgViewDelivery5.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewDelivery5.frame withSuperViewRect:imgViewDelivery5.superview.frame];
    
    imgViewExpensive1.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewExpensive1.frame withSuperViewRect:imgViewExpensive1.superview.frame];
    imgViewExpensive2.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewExpensive2.frame withSuperViewRect:imgViewExpensive2.superview.frame];
    imgViewExpensive3.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewExpensive3.frame withSuperViewRect:imgViewExpensive3.superview.frame];
    imgViewExpensive4.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewExpensive4.frame withSuperViewRect:imgViewExpensive4.superview.frame];
    imgViewExpensive5.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewExpensive5.frame withSuperViewRect:imgViewExpensive5.superview.frame];
    
    imgViewFacility_BuffetAvailable.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewFacility_BuffetAvailable.frame withSuperViewRect:imgViewFacility_BuffetAvailable.superview.frame];
    imgViewFacility_CarParking.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewFacility_CarParking.frame withSuperViewRect:imgViewFacility_CarParking.superview.frame];
    imgViewFacility_CreditCard.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewFacility_CreditCard.frame withSuperViewRect:imgViewFacility_CreditCard.superview.frame];
    imgViewFacility_MealPass.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewFacility_MealPass.frame withSuperViewRect:imgViewFacility_MealPass.superview.frame];
    imgViewFacility_ServeAlcocal.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewFacility_ServeAlcocal.frame withSuperViewRect:imgViewFacility_ServeAlcocal.superview.frame];
    imgViewFacility_ValetParking.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewFacility_ValetParking.frame withSuperViewRect:imgViewFacility_ValetParking.superview.frame];
    
    imgViewRating1.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewRating1.frame withSuperViewRect:imgViewRating1.superview.frame];
    imgViewRating2.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewRating2.frame withSuperViewRect:imgViewRating2.superview.frame];
    imgViewRating3.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewRating3.frame withSuperViewRect:imgViewRating3.superview.frame];
    imgViewRating4.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewRating4.frame withSuperViewRect:imgViewRating4.superview.frame];
    imgViewRating5.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewRating5.frame withSuperViewRect:imgViewRating5.superview.frame];
    
    imgViewTaste1.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewTaste1.frame withSuperViewRect:imgViewTaste1.superview.frame];
    imgViewTaste2.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewTaste2.frame withSuperViewRect:imgViewTaste2.superview.frame];
    imgViewTaste3.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewTaste3.frame withSuperViewRect:imgViewTaste3.superview.frame];
    imgViewTaste4.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewTaste4.frame withSuperViewRect:imgViewTaste4.superview.frame];
    imgViewTaste5.frame =[[UIConstants returnInstance] getFrameForLanguage:imgViewTaste5.frame withSuperViewRect:imgViewTaste5.superview.frame];
    
    
}

#pragma mark - Other functional mehods
-(void)SetRestaurantInfo
{
    [scrollView setContentSize:CGSizeMake(320, 1050)];
    dicRestaurantInfo = [[UIConstants returnInstance] dicRestaurantDetails];
    NSLog(@"%@", dicRestaurantInfo);
    
    lblRestaurantName.text = [NSString stringWithFormat:@"%@",[dicRestaurantInfo objectForKey:key_Name]];
    
    if ([[dicRestaurantInfo objectForKey:key_IsVeg] integerValue]== 0) {
        imgViewVegOrNonVeg.image = [UIImage imageNamed:@"icon_non_veg.png"];
    }else{
        imgViewVegOrNonVeg.image = [UIImage imageNamed:@"icon_veg.png"];
    }
    
    if ([[dicRestaurantInfo objectForKey:key_IsOpened] integerValue] == true) {
        imgViewOpenOrClose.image = [UIImage imageNamed:@"icon_open.png"];
    }else{
        imgViewOpenOrClose.image = [UIImage imageNamed:@"icon_closed_now.png"];
    }
    
    lblRestaurantArea.text = [dicRestaurantInfo objectForKey:key_Area];
    
    [self SetReviewInfo:[dicRestaurantInfo objectForKey:key_ReviewRating]];
    
    NSMutableString *strTemp = [[NSMutableString alloc] init];
    for (NSString *string in [dicRestaurantInfo objectForKey:key_OpenTiming]) {
        if (![string isEqualToString:@" "] && string != nil && [string length]>1) {
            [strTemp appendString:string];
            [strTemp appendString:@", "];
        }
    }
    if([strTemp length] > 2)
        [strTemp deleteCharactersInRange:NSMakeRange([strTemp length]-2, 2)];
    lblOpeningHrs.text = strTemp;
    [strTemp release];
    
    NSMutableString *strtemp1 = [[NSMutableString alloc] init];
    for(NSString *string in [dicRestaurantInfo objectForKey:key_CuisineTypes]) {
        if (![string isEqualToString:@" "] && string != nil && [string length]>1) {
            [strtemp1 appendString:string];
            [strtemp1 appendString:@", "];
        }
    }
    if([strtemp1 length] > 2)
        [strtemp1 deleteCharactersInRange:NSMakeRange([strtemp1 length]-2, 2)];
    lblCuisines.text = strtemp1;
    [strtemp1 release];
    
    lblTakeAwayTime.text =  [dicRestaurantInfo objectForKey:key_MinPrepTime];
    lblHomeDeliveryTime.text = [NSString stringWithFormat:@"(+ %@ -) %@", [[UIConstants returnInstance] isItEnglish]?Or_English:Or_Arabic,[dicRestaurantInfo objectForKey:key_MaxDeliveryTime]];
    
    NSMutableString *strAreas = [[NSMutableString alloc] init];
    for (NSString *string  in [dicRestaurantInfo objectForKey:key_DeliverySupportAreas]) {
        if (![string isEqualToString:@" "] && string != nil && [string length]>1) {
            [strAreas appendString:string];
            [strAreas appendString:@", "];
        }
    }
    if([strAreas length] > 2)
        [strAreas deleteCharactersInRange:NSMakeRange([strAreas length]-2, 2)];
    lblDeliverySupportedArea.text = strAreas;
    [strAreas release];
    
    lblCostForTwo.text = [NSString stringWithFormat:@"%@ %@",[[UIConstants returnInstance] strCurrencyCode],[dicRestaurantInfo objectForKey:key_CostForTwo]];
    
    NSMutableString *strLanguages = [[NSMutableString alloc] init];
    for (NSString *string in [dicRestaurantInfo objectForKey:key_LanguagesSpoken]) {
        if (![string isEqualToString:@" "] && string != nil && [string length]>1) {
            [strLanguages appendString:string];
            [strLanguages appendString:@", "];
        }
    }
    if([strLanguages length] > 2)
     [strLanguages deleteCharactersInRange:NSMakeRange([strLanguages length]-2, 2)];
    lblLanguagesSpoken.text = strLanguages;
    [strLanguages release];

    [self SetFacilities];
    
    NSMutableString *strAddress = [[NSMutableString alloc] init];
    for (NSString *string in [dicRestaurantInfo objectForKey:key_Address]) {
        if (![string isEqualToString:@" "] && string != nil && [string length]>1) {
            [strAddress appendString:string];
            [strAddress appendString:@", "];
        }
    }
    if([strAddress length] > 2)
     [strAddress deleteCharactersInRange:NSMakeRange([strAddress length]-2, 2)];
    lblAddress.text = [NSString stringWithFormat:@"%@.", strAddress];
    [strAddress release];
    
    if (isempty([dicRestaurantInfo objectForKey:key_Latitude]) && isempty([dicRestaurantInfo objectForKey:key_Longitude])) {
        CLLocationCoordinate2D location;
        location.latitude   = [[dicRestaurantInfo objectForKey:key_Latitude] floatValue];
        location.longitude  = [[dicRestaurantInfo objectForKey:key_Longitude] floatValue];
        [mapRestaurantLocation setCenterCoordinate:location];
    }else{
        mapRestaurantLocation.hidden = YES;
        scrollView.contentSize = CGSizeMake(0, scrollView.contentSize.height-mapRestaurantLocation.frame.size.height);
        
    }
    
}


-(void)SetReviewInfo:(NSDictionary *)RatingInfo
{
    UIImage *imgCoinEmpty = [[UIImage imageNamed:@"coin_empty.png"] retain];
    UIImage *imgCoin      = [[UIImage imageNamed:@"coin.png"] retain];
    UIImage *imgClockEmpty = [[UIImage imageNamed:@"clock_empty.png"] retain];
    UIImage *imgClock   = [[UIImage imageNamed:@"clock.png"] retain];
    UIImage *imgTaste  = [[UIImage imageNamed:@"taste.png"] retain];
    UIImage *imgTasteEmpty = [[UIImage imageNamed:@"taste_empty.png"] retain];
    UIImage *imgStarWhite = [[UIImage imageNamed:@"star_empty.png"] retain];
    UIImage *imgStarRed = [[UIImage imageNamed:@"star_red.png"] retain];
    UIImage *imgstarGreen = [[UIImage imageNamed:@"star_green.png"] retain];
    UIImage *imgStarYellow = [[UIImage imageNamed:@"star_yellow.png"] retain];
    
    if ([[RatingInfo objectForKey:key_OverallRating] integerValue] == 0) {
        imgViewRating1.image = imgStarWhite;
        imgViewRating2.image = imgStarWhite;
        imgViewRating3.image = imgStarWhite;
        imgViewRating4.image = imgStarWhite;
        imgViewRating5.image = imgStarWhite;
    }else if ([[RatingInfo objectForKey:key_OverallRating] integerValue] == 1) {
        imgViewRating1.image = imgStarRed;
        imgViewRating2.image = imgStarWhite;
        imgViewRating3.image = imgStarWhite;
        imgViewRating4.image = imgStarWhite;
        imgViewRating5.image = imgStarWhite;
    }else if ([[RatingInfo objectForKey:key_OverallRating] integerValue] == 2) {
        imgViewRating1.image = imgStarRed;
        imgViewRating2.image = imgStarRed;
        imgViewRating3.image = imgStarWhite;
        imgViewRating4.image = imgStarWhite;
        imgViewRating5.image = imgStarWhite;
    }else if ([[RatingInfo objectForKey:key_OverallRating] integerValue] == 3) {
        imgViewRating1.image = imgStarYellow;
        imgViewRating2.image = imgStarYellow;
        imgViewRating3.image = imgStarYellow;
        imgViewRating4.image = imgStarWhite;
        imgViewRating5.image = imgStarWhite;
    }else if ([[RatingInfo objectForKey:key_OverallRating] integerValue] == 4) {
        imgViewRating1.image = imgstarGreen;
        imgViewRating2.image = imgstarGreen;
        imgViewRating3.image = imgstarGreen;
        imgViewRating4.image = imgstarGreen;
        imgViewRating5.image = imgStarWhite;
    }else if ([[RatingInfo objectForKey:key_OverallRating] integerValue] == 5) {
        imgViewRating1.image = imgstarGreen;
        imgViewRating2.image = imgstarGreen;
        imgViewRating3.image = imgstarGreen;
        imgViewRating4.image = imgstarGreen;
        imgViewRating5.image = imgstarGreen;
    }
    
    if ([[RatingInfo objectForKey:key_Expensive] integerValue] == 0) {
        imgViewExpensive1.image = imgCoinEmpty;
        imgViewExpensive2.image = imgCoinEmpty;
        imgViewExpensive3.image = imgCoinEmpty;
        imgViewExpensive4.image = imgCoinEmpty;
        imgViewExpensive5.image = imgCoinEmpty;
    }else if ([[RatingInfo objectForKey:key_Expensive] integerValue] == 1) {
        imgViewExpensive1.image = imgCoin;
        imgViewExpensive2.image = imgCoinEmpty;
        imgViewExpensive3.image = imgCoinEmpty;
        imgViewExpensive4.image = imgCoinEmpty;
        imgViewExpensive5.image = imgCoinEmpty;
    }else if ([[RatingInfo objectForKey:key_Expensive] integerValue] == 2) {
        imgViewExpensive1.image = imgCoin;
        imgViewExpensive2.image = imgCoin;
        imgViewExpensive3.image = imgCoinEmpty;
        imgViewExpensive4.image = imgCoinEmpty;
        imgViewExpensive5.image = imgCoinEmpty;
    }else if ([[RatingInfo objectForKey:key_Expensive] integerValue] == 3) {
        imgViewExpensive1.image = imgCoin;
        imgViewExpensive2.image = imgCoin;
        imgViewExpensive3.image = imgCoin;
        imgViewExpensive4.image = imgCoinEmpty;
        imgViewExpensive5.image = imgCoinEmpty;
    }else if ([[RatingInfo objectForKey:key_Expensive] integerValue] == 4) {
        imgViewExpensive1.image = imgCoin;
        imgViewExpensive2.image = imgCoin;
        imgViewExpensive3.image = imgCoin;
        imgViewExpensive4.image = imgCoin;
        imgViewExpensive5.image = imgCoinEmpty;
    }else if ([[RatingInfo objectForKey:key_Expensive] integerValue] == 5) {
        imgViewExpensive1.image = imgCoin;
        imgViewExpensive2.image = imgCoin;
        imgViewExpensive3.image = imgCoin;
        imgViewExpensive4.image = imgCoin;
        imgViewExpensive5.image = imgCoin;
    }
    
    if ([[RatingInfo objectForKey:key_TimelyDelivery] integerValue] == 0) {
        imgViewDelivery1.image = imgClockEmpty;
        imgViewDelivery2.image = imgClockEmpty;
        imgViewDelivery3.image = imgClockEmpty;
        imgViewDelivery4.image = imgClockEmpty;
        imgViewDelivery5.image = imgClockEmpty;
    }else if ([[RatingInfo objectForKey:key_TimelyDelivery] integerValue] == 1) {
        imgViewDelivery1.image = imgClock;
        imgViewDelivery2.image = imgClockEmpty;
        imgViewDelivery3.image = imgClockEmpty;
        imgViewDelivery4.image = imgClockEmpty;
        imgViewDelivery5.image = imgClockEmpty;
    }else if ([[RatingInfo objectForKey:key_TimelyDelivery] integerValue] == 2) {
        imgViewDelivery1.image = imgClock;
        imgViewDelivery2.image = imgClock;
        imgViewDelivery3.image = imgClockEmpty;
        imgViewDelivery4.image = imgClockEmpty;
        imgViewDelivery5.image = imgClockEmpty;
    }else if ([[RatingInfo objectForKey:key_TimelyDelivery] integerValue] == 3) {
        imgViewDelivery1.image = imgClock;
        imgViewDelivery2.image = imgClock;
        imgViewDelivery3.image = imgClock;
        imgViewDelivery4.image = imgClockEmpty;
        imgViewDelivery5.image = imgClockEmpty;
    }else if ([[RatingInfo objectForKey:key_TimelyDelivery] integerValue] == 4) {
        imgViewDelivery1.image = imgClock;
        imgViewDelivery2.image = imgClock;
        imgViewDelivery3.image = imgClock;
        imgViewDelivery4.image = imgClock;
        imgViewDelivery5.image = imgClockEmpty;
    }else if ([[RatingInfo objectForKey:key_TimelyDelivery] integerValue] == 5) {
        imgViewDelivery1.image = imgClock;
        imgViewDelivery2.image = imgClock;
        imgViewDelivery3.image = imgClock;
        imgViewDelivery4.image = imgClock;
        imgViewDelivery5.image = imgClock;
    }
    
    if ([[RatingInfo objectForKey:key_Taste] integerValue] == 0) {
        imgViewTaste1.image = imgTasteEmpty;
        imgViewTaste2.image = imgTasteEmpty;
        imgViewTaste3.image = imgTasteEmpty;
        imgViewTaste4.image = imgTasteEmpty;
        imgViewTaste5.image = imgTasteEmpty;
    }else if ([[RatingInfo objectForKey:key_Taste] integerValue] == 1) {
        imgViewTaste1.image = imgTaste;
        imgViewTaste2.image = imgTasteEmpty;
        imgViewTaste3.image = imgTasteEmpty;
        imgViewTaste4.image = imgTasteEmpty;
        imgViewTaste5.image = imgTasteEmpty;
    }else if ([[RatingInfo objectForKey:key_Taste] integerValue] == 2) {
        imgViewTaste1.image = imgTaste;
        imgViewTaste2.image = imgTaste;
        imgViewTaste3.image = imgTasteEmpty;
        imgViewTaste4.image = imgTasteEmpty;
        imgViewTaste5.image = imgTasteEmpty;
    }else if ([[RatingInfo objectForKey:key_Taste] integerValue] == 3) {
        imgViewTaste1.image = imgTaste;
        imgViewTaste2.image = imgTaste;
        imgViewTaste3.image = imgTaste;
        imgViewTaste4.image = imgTasteEmpty;
        imgViewTaste5.image = imgTasteEmpty;
    }else if ([[RatingInfo objectForKey:key_Taste] integerValue] == 4) {
        imgViewTaste1.image = imgTaste;
        imgViewTaste2.image = imgTaste;
        imgViewTaste3.image = imgTaste;
        imgViewTaste4.image = imgTaste;
        imgViewTaste5.image = imgTasteEmpty;
    }else if ([[RatingInfo objectForKey:key_Taste] integerValue] == 5) {
        imgViewTaste1.image = imgTaste;
        imgViewTaste2.image = imgTaste;
        imgViewTaste3.image = imgTaste;
        imgViewTaste4.image = imgTaste;
        imgViewTaste5.image = imgTaste;
    }
}

-(void)SetFacilities
{
    if ([[dicRestaurantInfo objectForKey:key_CarParkingAvailable] integerValue] == 1) {
        imgViewFacility_CarParking.alpha = 1;
    }else{
        imgViewFacility_CarParking.alpha = 0.5;
    }
    
    if ([[dicRestaurantInfo objectForKey:key_CreditCardAccepted] integerValue] == 1) {
        imgViewFacility_CreditCard.alpha = 1;
    }else{
        imgViewFacility_CreditCard.alpha = 0.5;
    }
    
    if ([[dicRestaurantInfo objectForKey:key_ValetParkingAvailable] integerValue] == 1) {
        imgViewFacility_ValetParking.alpha = 1;
    }else{
        imgViewFacility_ValetParking.alpha = 0.5;
    }
    
    if ([[dicRestaurantInfo objectForKey:key_IsBuffetAvailable] integerValue] == 1) {
        imgViewFacility_BuffetAvailable.alpha = 1;
    }else{
        imgViewFacility_BuffetAvailable.alpha = 0.5;
    }
    
    if ([[dicRestaurantInfo objectForKey:key_MealPassAccept] integerValue] == 1) {
        imgViewFacility_MealPass.alpha = 1;
    }else{
        imgViewFacility_MealPass.alpha = 0.5;
    }
    
    if ([[dicRestaurantInfo objectForKey:key_ServeAlchocal] integerValue] == 1) {
        imgViewFacility_ServeAlcocal.alpha = 1;
    }else{
        imgViewFacility_ServeAlcocal.alpha = 0.5;
    }
}

#pragma mark - Button Action Methods
-(void)OnClickGoHomeButton:(id)sender
{
    [self.delegate GoHome];
}

-(void)OnClickGoBackButton:(id)sender
{
    [self.delegate commonBack];
}

-(void)OnClickMenuButton:(id)sender
{
    ObjServiceHandler = [[ServiceHandler alloc] init];
#warning used static username as per the document
    NSString *UserName = nil;
    if ([[UIConstants returnInstance] strFosUserName]) {
        UserName = [[UIConstants returnInstance] strFosUserName];
    }else{
        UserName = @"static";
    }
//    if ([ObjServiceHandler GetRestaurantMenuListAPI:UserName :[[[UIConstants returnInstance] dicRestaurantDetails] objectForKey:key_Identifier] :[[UIConstants returnInstance] strAppID] :@"session1"]) {
//        [self.delegate LoadNextScreen:VIEW_MENUSCREEN];
//    }
    [ObjServiceHandler release], ObjServiceHandler = nil;
}
@end
