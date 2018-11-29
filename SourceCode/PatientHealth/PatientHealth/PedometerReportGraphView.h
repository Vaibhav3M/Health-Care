//
//  PedometerReportGraphView.h
//  PatientHealth
//
//  Created by VM on 11/3/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface PedometerReportGraphView : UIView<CPTBarPlotDataSource, CPTPieChartDataSource, CPTBarPlotDelegate>
@property (strong, nonatomic,nonnull) IBOutlet CPTGraphHostingView *graphHostingView;
@property (nonatomic, readwrite, strong, nonnull) CPTXYGraph *graph;
@property (nonatomic, readwrite, strong, nonnull) CPTNumberArray *dataForChart;
@property (nonatomic, readwrite, strong, nonnull) NSArray<NSDictionary *> *dataForPlot;
-(void)constructBarChart;
- (float)getTotalSubjects;
- (float)getMaxEnrolled;
@end
