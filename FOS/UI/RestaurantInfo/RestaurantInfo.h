//
//  RestaurantInfo.h

//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"
#import <MapKit/MapKit.h>

@interface RestaurantInfo : UIViewController
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UIButton *btnGoHome;
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnMenu;
    
    IBOutlet UILabel *lblRestaurantName;
    IBOutlet UILabel *lblRestaurantArea;
    IBOutlet UILabel *lblOpeningHrs;
    IBOutlet UILabel *lblCuisines;
    IBOutlet UILabel *lblTakeAwayTime;
    IBOutlet UILabel *lblHomeDeliveryTime;
    IBOutlet UILabel *lblDeliverySupportedArea;
    IBOutlet UILabel *lblCostForTwo;
    IBOutlet UILabel *lblLanguagesSpoken;
    IBOutlet UILabel *lblAddress;
    
    IBOutlet UILabel *lblReviewRatings;
    IBOutlet UILabel *lblOverallRating;
    IBOutlet UILabel *lblExpensive;
    IBOutlet UILabel *lblTImelyDelivery;
    IBOutlet UILabel *lblTaste;
    IBOutlet UILabel *lblRestaurantTiming;
    IBOutlet UILabel *lblCuisineType;
    IBOutlet UILabel *lblTakeAwayIn;
    IBOutlet UILabel *lblHomeDeliveryIn;
    IBOutlet UILabel *lblDeliverySupportedAreas;
    IBOutlet UILabel *lblCostForTwoText;
    IBOutlet UILabel *lblLanguagesSpokenText;
    IBOutlet UILabel *lblFacilities;
    IBOutlet UILabel *lblAddressText;
    IBOutlet UILabel *lblScreenName;
    
    IBOutlet UIImageView *imgViewVegOrNonVeg;
    IBOutlet UIImageView *imgViewOpenOrClose;
    
    IBOutlet UIImageView *imgViewRating1;
    IBOutlet UIImageView *imgViewRating2;
    IBOutlet UIImageView *imgViewRating3;
    IBOutlet UIImageView *imgViewRating4;
    IBOutlet UIImageView *imgViewRating5;
    
    IBOutlet UIImageView *imgViewExpensive1;
    IBOutlet UIImageView *imgViewExpensive2;
    IBOutlet UIImageView *imgViewExpensive3;
    IBOutlet UIImageView *imgViewExpensive4;
    IBOutlet UIImageView *imgViewExpensive5;
    
    IBOutlet UIImageView *imgViewDelivery1;
    IBOutlet UIImageView *imgViewDelivery2;
    IBOutlet UIImageView *imgViewDelivery3;
    IBOutlet UIImageView *imgViewDelivery4;
    IBOutlet UIImageView *imgViewDelivery5;
    
    IBOutlet UIImageView *imgViewTaste1;
    IBOutlet UIImageView *imgViewTaste2;
    IBOutlet UIImageView *imgViewTaste3;
    IBOutlet UIImageView *imgViewTaste4;
    IBOutlet UIImageView *imgViewTaste5;
    
    IBOutlet UIImageView *imgViewFacility_ServeAlcocal;
    IBOutlet UIImageView *imgViewFacility_CarParking;
    IBOutlet UIImageView *imgViewFacility_ValetParking;
    IBOutlet UIImageView *imgViewFacility_CreditCard;
    IBOutlet UIImageView *imgViewFacility_MealPass;
    IBOutlet UIImageView *imgViewFacility_BuffetAvailable;
    
    IBOutlet MKMapView *mapRestaurantLocation;
    
    IBOutlet UIScrollView *scrollView;
    
    NSDictionary *dicRestaurantInfo;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;
-(IBAction)OnClickGoHomeButton:(id)sender;
-(IBAction)OnClickGoBackButton:(id)sender;
-(IBAction)OnClickMenuButton:(id)sender;

-(void)SetRestaurantInfo;
-(void)SetReviewInfo:(NSDictionary *)RatingInfo;
-(void)SetFacilities;
@end
