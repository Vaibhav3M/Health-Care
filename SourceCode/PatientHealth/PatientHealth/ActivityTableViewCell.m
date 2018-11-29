//
//  ActivityTableViewCell.m
//  PatientHealth
//
//  Created by VM  on 25/10/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell



- (void)awakeFromNib {
        [super awakeFromNib];
//    NSString *currentdata = [NSString stringWithFormat:@"%@" ,[_activityData valueForKey:@"current"]];
//    float currentdatafloat = [currentdata floatValue];
//    NSString *Targetdata = [NSString stringWithFormat:@"%@" ,[_activityData valueForKey:@"target"]];
//    float Targetdatafloat =[Targetdata floatValue];
//    float progressBarPercentagefloat =(Targetdatafloat/currentdatafloat)*100;
//    [self.progressBarView drawCircleWithPercent:progressBarPercentagefloat duration:0 lineWidth:6 clockwise:YES lineCap:kCALineCapRound fillColor:[UIColor clearColor] strokeColor:[UIColor orangeColor]animatedColors:nil];
//    self.progressBarView.percentLabel.font = [UIFont systemFontOfSize:12];
//    self.progressBarView.percentLabel.textColor = [UIColor orangeColor];
//    //[self.circleView startAnimation];
//    [self.progressBarView startAnimation];
//
    // Initialization code
}

+ (NSString *)reuseIdentifier {
    return @"ActivityTableViewCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
