//
//  MedicineTableViewCell.m
//  PatientHealth
//
//  Created by VM  on 02/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "MedicineTableViewCell.h"

@implementation MedicineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (NSString *)reuseIdentifier {
    return @"MedicineTableViewCell";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setDosage:(NSArray*)dosageAry forMedicine:(Medicine*)medicine forIndexPath:(NSIndexPath*)indexPath{
    
    [self.tabletNamelbl setText:[NSString stringWithFormat:@"%@" ,[medicine valueForKey:@"medicinename"]]];
    [self.diseaseNamelbl setText:[NSString stringWithFormat:@"%@" ,[medicine valueForKey:@"diseasename"]]];
    [self.dosagelbl setText:[NSString stringWithFormat:@"%@" ,[medicine valueForKey:@"dosage"]]];
    if([self.dosagelbl.text  isEqual: @"Once a day"])
    {
        self.dosagelbl.text =@"1";
    }
    else if([ self.dosagelbl.text  isEqual: @"Twice daily"])
    {
        self.dosagelbl.text =@"2";
    }
    else if([ self.dosagelbl.text  isEqual: @"Thrice Daily"])
    {
        self.dosagelbl.text =@"3";
        
    }
    else if([ self.dosagelbl.text  isEqual: @"4 times a Day"])
    {
        self.dosagelbl.text =@"4";
        
    }

    [self.consumedlbl setText:@"0"];
    int x =150;
    NSString *title =@"";
    BOOL isTab0Selected = [medicine valueForKey:@"firstTabIfSelected"];
    BOOL isTab1Selected = [medicine valueForKey:@"secondTabIfSelected"];
    BOOL isTab2Selected = [medicine valueForKey:@"thirdTabIfSelected"];
    BOOL isTab3Selected = [medicine valueForKey:@"fourthTabIfSelected"];
    NSString *dosagedata = [dosageAry objectAtIndex:indexPath.row];
    int dosage = [dosagedata intValue];
    
    [self setTag:indexPath.row];
    for (int j=0; j < dosage; j++) {
        UIButton *tab =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        tab.frame = CGRectMake(x, 50 , 15, 40);
        if(j == 0){
            tab = [self setUpButtonSelection:isTab0Selected :tab];
        }else if(j == 1){
            tab = [self setUpButtonSelection:isTab1Selected :tab];
        }else if(j==2){
            tab = [self setUpButtonSelection:isTab2Selected :tab];
        }else if(j==3){
            tab = [self setUpButtonSelection:isTab3Selected :tab];
        }
        [tab setTitle:title forState:normal];
        [tab addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [tab setTag:j];
        [self.contentView addSubview:tab ];
        x=x+15;
    }
}

-(UIButton*)setUpButtonSelection:(BOOL)isSelected : (UIButton *)button{
    [button setBackgroundColor:[UIColor clearColor]];
    [button setSelected:isSelected];
    if(isSelected){
        [button setBackgroundImage:[UIImage imageNamed:@"Active-1.png"] forState:UIControlStateSelected];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"Not-active.png"] forState:UIControlStateNormal];
    }
    return button;
}

-(void)tabButtonPressed:(id)sender{
    [self.delegate didPressedTabButtonOnCell:self tabButton:(UIButton*)sender medicine:_medicine];
}

@end
