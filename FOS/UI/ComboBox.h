//
//  ComboBox.h
//  FOS
//
//  Created by hakuna on 02/10/13.
//  Copyright (c) 2013 HakunaMatata. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ComboBoxDelegate <NSObject>

- (void) onClickComboSelection:(id)comboBox;

@optional
- (NSArray *) selectionDataForCombo:(id) comboBox;
- (void) comboBoxShowing:(BOOL) isShowing;

@end

@interface ComboBox : UIView
{
   
}
@property (nonatomic,strong) NSString *keyName;
@property (nonatomic,strong) id selectedData;
@property (nonatomic) NSInteger selectedRow;
@property (nonatomic, strong) NSArray *arrDataCombo;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic,assign) IBOutlet id<ComboBoxDelegate> delegate;
@property (nonatomic,strong) NSString *selectedText;
@property (nonatomic,strong) NSString *placeHolder;

// whenever need to update the combo data from the parent view, Default is NO

@property (nonatomic) BOOL isDataRefreshNeeded;
- (void) loadNibName;

@end
