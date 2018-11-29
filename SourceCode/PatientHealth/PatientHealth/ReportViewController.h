//
//  ReportViewController.h
//  PatientHealth
//
//  Created by VM on 9/22/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CorePlot-CocoaTouch.h"
#import "BPReportGraphView.h"
#import "PedometerReportGraphView.h"
#import "PillBoxReportGraphView.h"
#import "CustomPicker.h"
#import "Utilities.h"
#import "AppDelegate.h"
#import "PulseReport+CoreDataProperties.h"
#import "BPReport+CoreDataProperties.h"
#import "BloodSugarReport+CoreDataProperties.h"
#import "CholestrolReport+CoreDataProperties.h"
#import "WeightReport+CoreDataProperties.h"
#define MIN_YEAR 2014

@interface ReportViewController:UIViewController<CustomPickerDelegate,CustomPickerDataSource,CPTBarPlotDataSource, CPTPieChartDataSource, CPTBarPlotDelegate>
@property (strong, nonatomic,nonnull) IBOutlet UISegmentedControl *segmentControlReport;
@property (strong, nonatomic,nonnull) IBOutlet UIView *graphContainerView;
@property (nonatomic, readwrite, strong, nonnull) CPTNumberArray *dataForChart;
@property (nonatomic, readwrite, strong, nonnull) NSArray<NSDictionary *> *dataForPlot;
@property (nonatomic, readwrite, strong, nonnull)NSArray *dataArray;
- (IBAction)onClickReportSegmentControl:(nullable id)sender;
@property(strong,nonatomic,nonnull)CustomPicker *monthPicker;
@property(strong,nonatomic,nonnull)CustomPicker *vitalPicker;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectedMonth;
@property (strong, nonatomic,nonnull) IBOutlet UITextField *txtYearMonth;
@property (strong,nonatomic,nonnull) NSMutableArray *yearArray;
@property (strong,nonatomic,nonnull)NSMutableArray *vitalArray;
@property (strong, nonatomic,nonnull) IBOutlet UITextField *txtChooseVital;
@property (strong,nonatomic,nonnull) NSMutableArray *monthArray;
@property (strong, nonatomic,nonnull) IBOutlet UILabel *indicatorLabel1;
@property (strong, nonatomic,nonnull) IBOutlet UIImageView *imgIndiciator1;
@property (strong, nonatomic,nonnull) IBOutlet UIImageView *imgIndiciator2;
@property (strong, nonatomic,nonnull) IBOutlet UIImageView *imgIndiciator3;
@property (strong, nonatomic,nonnull) IBOutlet UILabel *indicatorLabel2;
@property (strong, nonatomic,nonnull) IBOutlet UILabel *indicatorLabel3;

-(void)constructScatterPlot;
@end
