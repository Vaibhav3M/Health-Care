//
//  CustomPicker.m
//  MyLan
//
//  Created by VM on 19/07/16.
//  Copyright (c) 2016 Vaibhav . All rights reserved.
//

#import "CustomPicker.h"

@interface CustomPicker ()
{
    CustomPickerStyle style;
    
}

-(IBAction)doneAction:(id)sender;
-(IBAction)dateChanged:(id)sender;


@end

@implementation CustomPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CustomPicker *)instantiateWithStyle:(CustomPickerStyle)pickerStyle
{
    CustomPicker *customPickerInstance = nil;
    
    style = pickerStyle;
    
    if (style == CUSTOM_PICKER_SIMPLE) {
        
        UINib *nib = [UINib nibWithNibName:@"CustomPicker" bundle:[NSBundle mainBundle]];
        customPickerInstance = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:CUSTOM_PICKER_SIMPLE];
    }else{
        
        UINib *nib = [UINib nibWithNibName:@"CustomPicker" bundle:[NSBundle mainBundle]];
        customPickerInstance = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:CUSTOM_PICKER_DATE];
        customPickerInstance.datePicker.date = [NSDate date];
    }
    return customPickerInstance;
}

-(BOOL)validateDataSourceAndSelector:(SEL)aSelector
{
    if (self.dataSource != nil && [self.dataSource conformsToProtocol:@protocol(CustomPickerDataSource)] &&
        [self.dataSource respondsToSelector:aSelector])
    {
        return YES;
    }
    return NO;
}

-(BOOL)validateDelegateAndSelector:(SEL)aSelector
{
    if (self.delegate != nil && [self.delegate conformsToProtocol:@protocol(CustomPickerDelegate)] &&
        [self.delegate respondsToSelector:aSelector])
    {
        return YES;
    }
    return NO;
}

#pragma mark - Button actions

-(IBAction)doneAction:(id)sender
{
    if (![self.selectedValue.text isEqualToString:@"Select a value"]) {
        if([self validateDelegateAndSelector:@selector(didTapOnDoneOf:)]){
            [self.delegate didTapOnDoneOf:self];
        }
    }
    else{
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Please select a value."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [(UIViewController *)self.delegate presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];
        
        [alert addAction:okAction];
    }
    
}

-(IBAction)dateChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (self.dateFormat != nil) {
        [dateFormatter setDateFormat:self.dateFormat];
    }else{
        [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    }
    NSDate *date = self.datePicker.date;
    NSString *selectedDateString = [dateFormatter stringFromDate:date];
    
    self.selectedValue.text = selectedDateString;
}

#pragma mark - UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger components = 0;
    
    // ask delegate to return count or return array's count
    if (self.dataSourceArrayForSimplePicker != nil) {
        components = 1;
    }
    else{
        if([self validateDataSourceAndSelector:@selector(numberOfComponentsInCustomPicker:)]){
            components = [self.dataSource numberOfComponentsInCustomPicker:self];
        }
    }
    return components;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows = 0;
    
    // ask delegate to return count or return array's count
    if (self.dataSourceArrayForSimplePicker != nil) {
        rows = [self.dataSourceArrayForSimplePicker count];
    }
    else{
        if([self validateDataSourceAndSelector:@selector(numberofRowsInComponent:forPicker:)]){
            rows = [self.dataSource numberofRowsInComponent:component forPicker:self];
        }
    }

    return rows;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowTitle = @"";
    
    // ask delegate to return string or return object from array
    if (self.dataSourceArrayForSimplePicker != nil) {
        rowTitle = [self.dataSourceArrayForSimplePicker objectAtIndex:row];
    }
    else{
        if([self validateDataSourceAndSelector:@selector(titleForRow:inComponent:forPicker:)]){
            rowTitle = [self.dataSource titleForRow:row inComponent:component forPicker:self];
        }
    }
    
    return rowTitle;
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
//{
//    UIView *viewForRow = nil;
//    
//    if ([self validateDataSourceAndSelector:@selector(viewForRow:inComponent:reusingView:inPicker:)]) {
//        viewForRow = [self.dataSource viewForRow:row inComponent:component reusingView:view inPicker:self];
//    }
//    
//    return viewForRow;
//}

#pragma mark - UIPickerViewDelegate methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // set label text.
    if (self.dataSourceArrayForSimplePicker != nil) {
        self.selectedValue.text = [self.dataSourceArrayForSimplePicker objectAtIndex:row];
    }else{
        
        if (pickerView.numberOfComponents>1) {
            NSMutableString *selectedText = [[NSMutableString alloc] init];
            for (NSUInteger componentCount = 0; componentCount <pickerView.numberOfComponents; componentCount++) {
                [selectedText appendFormat:@" %@",[self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:componentCount] forComponent:componentCount]];
            }
            self.selectedValue.text = selectedText;
        }else{
            self.selectedValue.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }

    }
    
    // call delegate
    if([self validateDelegateAndSelector:@selector(didSelectRow:inComponent:ofPicker:)]){
        [self.delegate didSelectRow:row inComponent:component ofPicker:self];
    }
}

@end
