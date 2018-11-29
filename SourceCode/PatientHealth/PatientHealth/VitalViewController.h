//
//  VitalViewController.h
//  dashboard1
//
//  Created by VM on 24/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PulseReport+CoreDataProperties.h"
#import "BPReport+CoreDataProperties.h"
#import "BloodSugarReport+CoreDataProperties.h"
#import "CholestrolReport+CoreDataProperties.h"
#import "WeightReport+CoreDataProperties.h"
#import "VitalSectionTableViewCell.h"
#import "VitalChildTableViewCell.h"
#import "Utilities.h"

typedef NS_ENUM(NSUInteger, VitalType){
    BLOOD_SUGAR = 1,
    BP,
    WEIGHT,
    CHOLESTROL,
    PULSE
};

@interface VitalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,VitalTableViewCellProtocol>

@property(strong,nonatomic)NSString *strValBloodGlucose;
@property(strong,nonatomic)NSString *strValBPSystolic;
@property(strong,nonatomic)NSString *strValBPDiastolic;
@property(strong,nonatomic)NSString *strValHeart;
@property(strong,nonatomic)NSString *strValHeight;
@property(strong,nonatomic)NSString *strValWeight;
@property(strong,nonatomic)NSString *strValCholestrol;

//labels to add last added data
@property (strong, nonatomic) IBOutlet UILabel *lblBloodGlucose;
@property (strong, nonatomic) IBOutlet UILabel *lblBloodPressure;
@property (strong, nonatomic) IBOutlet UILabel *lblCholestrol;
@property (strong, nonatomic) IBOutlet UILabel *lblPulse;
@property (strong, nonatomic) IBOutlet UILabel *lblWeight;
@property (strong, nonatomic) IBOutlet UITableView *tblView;


//functions to fetch and setdata
//-(void)setBPData;
//-(void)setPulseData;
//-(void)setBloodGlucoseData;
//-(void)setWeightData;
//-(void)setCholestrolData;

//function to setup view
-(void)setUpView;

//bool array
@property (strong,nonatomic)NSMutableArray *arrayForBool;
@end
