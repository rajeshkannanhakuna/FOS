//
//  FilterOptions.h
//  
//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

@interface FilterOptions : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    id<FlowLogicDelegate>delegate;
    IBOutlet UILabel *lblScreenName;
        
    IBOutlet UIButton *btnGoHome;
    IBOutlet UIButton *btnGoBack;
    IBOutlet UITableView *tblViewFilterOption;
    IBOutlet UIButton *btnOkay;
    NSMutableArray *aryFilterList;
    NSMutableArray *arySelectedFilterList;
    NSMutableArray *arySelectedGeneralFilter;
}
@property(nonatomic, retain)id<FlowLogicDelegate>delegate;
-(IBAction)OnClickGoHomeButton:(id)sender;
-(IBAction)OnClickGoBackButton:(id)sender;
-(IBAction)OnClickOkayButton:(id)sender;
-(void)OnClickSelectFilterButton: (id)Sender;
@end
