//
//  CustomPicker.h
//  MyLan
//
//  Created by VM on 19/07/16.
//  Copyright (c) 2016 Vaibhav . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomPickerStyle){
    CUSTOM_PICKER_SIMPLE = 0,
    CUSTOM_PICKER_DATE
};

@class CustomPicker;

@protocol CustomPickerDataSource <NSObject>

@optional

- (NSInteger)numberOfComponentsInCustomPicker:(CustomPicker *)customPicker;
- (NSInteger)numberofRowsInComponent:(NSInteger)component forPicker:(CustomPicker *)customPicker;
- (NSString *)titleForRow:(NSInteger)row inComponent:(NSInteger)component forPicker:(CustomPicker *)customPicker;
-(UIView *)viewForRow:(NSInteger)row inComponent:(NSInteger)component reusingView:(UIView *)view inPicker:(CustomPicker *)picker;

@end


@protocol CustomPickerDelegate <NSObject>

@optional
-(void)didTapOnDoneOf:(CustomPicker *)picker;
-(void)didSelectRow:(NSInteger)row inComponent:(NSInteger)component ofPicker:(CustomPicker *)picker;

@end


@interface CustomPicker : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,weak)IBOutlet UILabel *selectedValue;
@property(nonatomic,weak)IBOutlet UIPickerView *simplePicker;
@property(nonatomic,weak)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,weak)IBOutlet UIButton *doneButton;
@property(nonatomic,assign)id<CustomPickerDataSource> dataSource;
@property(nonatomic,assign)id<CustomPickerDelegate> delegate;
@property(nonatomic,strong)NSString *dateFormat;

// set this array as data source for simple picker
@property(nonatomic,strong)NSMutableArray *dataSourceArrayForSimplePicker;

// Initializer
-(CustomPicker *)instantiateWithStyle:(CustomPickerStyle)pickerStyle;

@end
