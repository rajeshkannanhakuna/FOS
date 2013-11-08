//
//  PaymentGateway.h
//  FOS
//
//  Created by hakuna on 02/10/13.
//  Copyright (c) 2013 HakunaMatata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

@interface PaymentGateway : UIViewController<UIWebViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UIButton *btnGoBack;
    IBOutlet UIButton *btnGoHome;
    IBOutlet UIWebView *webViewPaymentGateway;
    IBOutlet UILabel *lblScreenName;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;

-(IBAction)OnClickGoBackButton:(id)sender;
-(IBAction)OnClickGoHomeButton:(id)sender;
@end
