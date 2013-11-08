//
//  FilterOptions.m
//  
//
//  Created by segate on 10/07/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "FilterOptions.h"
#import "ServiceHandler.h"
#import "ResponseDTO.h"
#import "APIConstants.h"
#import "UIConstants.h"
@interface FilterOptions ()
{
    ServiceHandler *ObjServiceHandler;
}
@end

@implementation FilterOptions
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
    aryFilterList = [[ResponseDTO sharedInstance] DTO_FilterListforMobile];
    arySelectedFilterList = [[NSMutableArray alloc] initWithArray:[[UIConstants returnInstance] arySelectedFilters]];
    arySelectedGeneralFilter = [[NSMutableArray alloc] initWithArray:[[UIConstants returnInstance]arySelectedGeneralFilter]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)OnClickOkayButton:(id)sender
{
    [[UIConstants returnInstance] setArySelectedFilters:arySelectedFilterList];
    [[UIConstants returnInstance] setArySelectedGeneralFilter:arySelectedGeneralFilter];
    ObjServiceHandler = [[ServiceHandler alloc] init];
    [ObjServiceHandler GetRestuarantSearchAPI:[[[UIConstants returnInstance] dicLocationDetails] objectForKey:key_CountryName] :[[[UIConstants returnInstance] dicLocationDetails] objectForKey:key_StateName] :[[[UIConstants returnInstance] dicLocationDetails] objectForKey:key_CityName] :[[UIConstants returnInstance] strAreaName] :arySelectedGeneralFilter :arySelectedFilterList];
    [self.delegate GoBack:YES];
    [ObjServiceHandler release], ObjServiceHandler = nil;
}

-(void)OnClickSelectFilterButton:(id)Sender
{
    UIButton *btnFilter = (UIButton *)Sender;
    UITableViewCell *cell = (UITableViewCell *)[[btnFilter superview] superview];
    NSLog(@"%@, %d", cell.reuseIdentifier, [tblViewFilterOption indexPathForCell:cell].section);
    if (btnFilter.imageView.image == [UIImage imageNamed:@"tick_checked.png"]) {
        if ([tblViewFilterOption indexPathForCell:cell].section == 0) {
            [arySelectedGeneralFilter removeObject:cell.reuseIdentifier];
        }else{
            [arySelectedFilterList removeObject:cell.reuseIdentifier];
        }
        [btnFilter setImage:[UIImage imageNamed:@"tick_unchecked.png"] forState:UIControlStateNormal];
    }else if (btnFilter.imageView.image == [UIImage imageNamed:@"tick_unchecked.png"]){
        if ([tblViewFilterOption indexPathForCell:cell].section == 0) {
            [arySelectedGeneralFilter addObject:cell.reuseIdentifier];
        }else{
            [arySelectedFilterList addObject:cell.reuseIdentifier];
        }
        [btnFilter setImage:[UIImage imageNamed:@"tick_checked.png"] forState:UIControlStateNormal];
    }
}
#pragma mark - Table view delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [aryFilterList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [[aryFilterList objectAtIndex:section] objectForKey:key_DisplayText];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
//    [tableView headerViewForSection:section].textLabel.textColor = [UIColor colorWithRed:35.0/255.0 green:18.0/255.0 blue:10.0/255.0 alpha:1];
    [[((UITableViewHeaderFooterView*) view) textLabel] setTextColor : [UIColor colorWithRed:35.0/255.0 green:18.0/255.0 blue:10.0/255.0 alpha:1]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[aryFilterList objectAtIndex:section] objectForKey:key_FilterOption] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[[[aryFilterList objectAtIndex:indexPath.section] objectForKey:key_FilterOption] objectAtIndex:indexPath.row] objectForKey:key_FilterCode]];
   UITableViewCell *tblViewCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[[[aryFilterList objectAtIndex:indexPath.section] objectForKey:key_FilterOption] objectAtIndex:indexPath.row] objectForKey:key_FilterCode]];
    tblViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    tblViewCell.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:253.0/255.0 blue:134.0/255.0 alpha:1];
    tblViewCell.textLabel.text = [[[[aryFilterList objectAtIndex:indexPath.section] objectForKey:key_FilterOption] objectAtIndex:indexPath.row] objectForKey:key_FilterName];
   
    UIButton *btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(250, 9, 32, 32)];
    [btnSelect addTarget:self action:@selector(OnClickSelectFilterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([arySelectedFilterList count] == 0 && [arySelectedGeneralFilter count] == 0) {
        [btnSelect setImage:[UIImage imageNamed:@"tick_unchecked.png"] forState:UIControlStateNormal];
    }else{
        if (indexPath.section == 0) {
            for( NSString *string in arySelectedGeneralFilter) {
                NSLog(@"%@, %d",tblViewCell.reuseIdentifier, indexPath.section);
                if ([string isEqualToString:tblViewCell.reuseIdentifier]){
                    [btnSelect setImage:[UIImage imageNamed:@"tick_checked.png"] forState:UIControlStateNormal];
                    break;
                }else{
                    [btnSelect setImage:[UIImage imageNamed:@"tick_unchecked.png"] forState:UIControlStateNormal];
                }
            }
        }else {
            for( NSString *string in arySelectedFilterList) {
                NSLog(@"%@, %d",tblViewCell.reuseIdentifier, indexPath.section);
                if ([string isEqualToString:tblViewCell.reuseIdentifier]){
                    [btnSelect setImage:[UIImage imageNamed:@"tick_checked.png"] forState:UIControlStateNormal];
                    break;
                }else{
                    [btnSelect setImage:[UIImage imageNamed:@"tick_unchecked.png"] forState:UIControlStateNormal];
                }
            }
        }
    }
    
    [tblViewCell.contentView addSubview:btnSelect];
    return tblViewCell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"sec:%d, row:%d", indexPath.section, indexPath.row);
//    for(UIView *view in [tableView cellForRowAtIndexPath:indexPath].contentView.subviews) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            UIImageView *imgView = (UIImageView *)view;
//            if (imgView.image == [UIImage imageNamed:@"tick_checked.png"]) {
//                [arySelectedFilterList removeObject:[tableView cellForRowAtIndexPath:indexPath].reuseIdentifier];
//                imgView.image = [UIImage imageNamed:@"tick_unchecked.png"];
//            }else if (imgView.image == [UIImage imageNamed:@"tick_unchecked.png"]){
//                [arySelectedFilterList addObject:[tableView cellForRowAtIndexPath:indexPath].reuseIdentifier];
//                imgView.image = [UIImage imageNamed:@"tick_checked.png"];
//            }
//        }
//    }
}

@end
