//
//  BPReportGraphView.h
//  PatientHealth
//
//  Created by VM on 11/3/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface BPReportGraphView : UIView<CPTBarPlotDataSource, CPTPieChartDataSource, CPTBarPlotDelegate,UITextFieldDelegate>

@property (nonatomic, readwrite, strong, nonnull) CPTNumberArray *dataForChart;
@property (nonatomic, readwrite, strong, nonnull) NSArray<NSDictionary *> *dataForPlot;
@property (strong, nonatomic,nonnull) IBOutlet UITextField *txtMonth;
@property (strong, nonatomic,nonnull) IBOutlet UIButton *btnMonth;
@property (strong, nonatomic,nonnull) IBOutlet UIButton *btnWeek;
@property (strong, nonatomic,nonnull) IBOutlet UILabel *lblSelectedMonth;
- (IBAction)onMonthClick:(nonnull id)sender;
- (IBAction)onWeekClick:(nonnull id)sender;
- (IBAction)onClickPrevBtn:(nonnull id)sender;
- (IBAction)onClickNextBtn:(nonnull id)sender;


// Plot construction methods
-(void)constructScatterPlot;
//-(void)constructBarChart;
//-(void)constructPieChart;
@end
