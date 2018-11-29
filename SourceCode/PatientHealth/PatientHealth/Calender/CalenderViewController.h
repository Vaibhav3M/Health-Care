//
//  CalenderViewController.h
//  PatientHealth
//
//  Created by VM  on 25/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendarDelegateProxy.h"
#import "FSCalendar.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarExtensions.h"
#import "ActivityDashboardView.h"
#import "MedicineDashboardView.h"
#import "FoodDashboardView.h"
#import "CalenderSelectedDateSubview.h"

@import CoreData;
@interface CalenderViewController : UIViewController <FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
{
    NSArray *medicineDosageArray;
    NSArray *activityArray;
    NSArray *foodArray;
    NSArray *targetTotal;
    NSArray *targetAchieved;
    int i;
    
}
@property (weak, nonatomic) IBOutlet UILabel *lblContainerView;
@property (weak, nonatomic) IBOutlet FSCalendar *calenderView;
@property (strong , nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDictionary<NSString *, UIImage *> *images;

@property (strong, nonatomic) NSDictionary *fillSelectionColors;
@property (strong, nonatomic) NSDictionary *fillDefaultColors;



- (IBAction)segmentClickCalender:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentClickOutlet;

@property (copy, nonatomic) NSString *strAddMoreView;
@property (nonatomic ,weak) ActivityDashboardView *dashboardActivity;
@property (nonatomic ,weak) MedicineDashboardView *dashboardMedicine;
@property (nonatomic ,weak) FoodDashboardView *dashboardFood;
@property (nonatomic ,weak) CalenderSelectedDateSubview *selectedDateView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong) NSMutableArray *medicineData;
@property (strong) NSMutableArray *activityData;
@property (strong) NSMutableArray *foodData;

@property (nonatomic,copy) NSString *index;

@end
