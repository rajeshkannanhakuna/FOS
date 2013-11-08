//
//  ComboBox.m
//  FOS
//
//  Created by hakuna on 02/10/13.
//  Copyright (c) 2013 HakunaMatata. All rights reserved.
//

#import "ComboBox.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
@interface ComboBox ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    IBOutlet UIImageView *_imgViewDropDown;
    IBOutlet UITextField *_txtFldCobo;
   IBOutlet  UIView *pickerView ;
    IBOutlet UIPickerView *picker;
    IBOutlet UIButton *btnDone;
    IBOutlet UIButton *btnCancel;
}
@property (retain, nonatomic) IBOutlet UIButton *btnComboSelection;

- (IBAction)onClickComboAction:(id)sender;
@end


@implementation ComboBox

@synthesize selectedText = _selectedText;
@synthesize delegate = _delegate;
@synthesize font = _font;
@synthesize placeHolder = _placeHolder;
@synthesize arrDataCombo  = _arrDataCombo;
@synthesize keyName = _keyName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isDataRefreshNeeded = NO; 
    }
    return self;
}


- (void) loadNibName
{
    [[[self subviews] lastObject] removeFromSuperview];
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"ComboBox" owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    [self addSubview:mainView];
    
    mainView.frame = self.bounds;
    _txtFldCobo.textAlignment = FOS_TEXTALIGNMENT;
    _txtFldCobo.font = [[UIConstants returnInstance] returnArvoRegular:14];
    _txtFldCobo.frame =[[UIConstants returnInstance] getFrameForLanguage:_txtFldCobo.frame withSuperViewRect:self.frame];
    
    _imgViewDropDown.frame = [[UIConstants returnInstance]  getFrameForLanguage:_imgViewDropDown.frame withSuperViewRect:self.frame];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_txtFldCobo release];
    [_btnComboSelection release];
    [_imgViewDropDown release];
    [super dealloc];
}
- (IBAction)onClickComboAction:(id)sender {
   // if([_delegate respondsToSelector:@selector(onClickComboAction:)]){
    
    //}
   
    if(!_arrDataCombo || [_arrDataCombo count] == 0 ||_isDataRefreshNeeded){
        if([_delegate respondsToSelector:@selector(selectionDataForCombo:)]){
            _arrDataCombo = [_delegate selectionDataForCombo:self];
        }
    }
    
    if([_arrDataCombo count] > 0){
        if([_delegate respondsToSelector:@selector(comboBoxShowing:)]){
          [_delegate comboBoxShowing:YES];
        }
        [self loadPicker];
    }
    
    
}

- (void) loadPicker
{
    btnCancel.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    btnDone.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    
    if ([[UIConstants returnInstance] isItEnglish]) {
        [btnDone setTitle:@"Done" forState:UIControlStateNormal];
        [btnCancel setTitle:Cancel_Eng forState:UIControlStateNormal];
    }else{
        [btnDone setTitle:@"أكملت" forState:UIControlStateNormal];
        [btnCancel setTitle:Cancel_Arabic forState:UIControlStateNormal];
    }
    [self showPicker];
}

- (void) showPicker
{
    CGRect pickerrect = pickerView.frame;
    pickerrect.origin.y = [UIScreen mainScreen].bounds.size.height;
    pickerView.frame = pickerrect;
    [[_delegate view] addSubview:pickerView];
    
    pickerrect.origin.y -= 196;
    [UIView animateWithDuration:0.3 animations:^{
        pickerView.frame = pickerrect;
        
    }];
    
    self.selectedRow = [picker selectedRowInComponent:0];
    self.selectedData =[self.arrDataCombo objectAtIndex:self.selectedRow];
    [picker reloadAllComponents];
}



- (void) hidePicker
{
    CGRect pickerrect = pickerView.frame;
  
    
      pickerrect.origin.y += 196;
    [UIView animateWithDuration:0.3 animations:^{
        pickerView.frame = pickerrect;
    }completion:^(BOOL finished) {
        [pickerView removeFromSuperview];
       
    }];

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_arrDataCombo count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([[_arrDataCombo objectAtIndex:row] isKindOfClass:[NSString class]]){
        return [_arrDataCombo objectAtIndex:row];
    }
    if(_keyName){
        return [[_arrDataCombo objectAtIndex:row] objectForKey:_keyName];
    }
    return [[_arrDataCombo objectAtIndex:row] objectForKey:key_Name];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRow = row;
    self.selectedData = [_arrDataCombo objectAtIndex:row];
    
}
-(void)setSelectedText:(NSString *)selectedText1
{
    if(selectedText1){
        _txtFldCobo.text = selectedText1;
        
    }
    [_selectedText release];
    _selectedText = [selectedText1 copy];
    
}

-(void)setFont:(UIFont *)font1
{
    if(_font){
        [_font release];
    }
    _font = font1;
    _txtFldCobo.font = _font;
}

-(void)setPlaceHolder:(NSString *)placeHolder1
{
    if(_placeHolder){
        [_placeHolder release];
    }
    _placeHolder = [placeHolder1 copy];
    _txtFldCobo.placeholder = _placeHolder;
}
- (IBAction)doneAction:(id)sender {
    [self hidePicker];
    
    if([self.selectedData isKindOfClass:[NSString class]]){
        self.selectedText = self.selectedData;
    }else{
        if(_keyName){
            self.selectedText = [self.selectedData objectForKey:_keyName];
        }else{
            self.selectedText = [self.selectedData objectForKey:key_Name];
        }
    }
    [_delegate onClickComboSelection:self];
}

- (IBAction)cancelAction:(id)sender {
    [self hidePicker];
}

@end
