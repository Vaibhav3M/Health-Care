//
//  PillBoxReportGraphView.h
//  PatientHealth
//
//  Created by VM on 11/3/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface PillBoxReportGraphView : UIView<CPTBarPlotDataSource, CPTPieChartDataSource, CPTBarPlotDelegate>

@property (nonatomic, readwrite, strong, nonnull) CPTNumberArray *dataForChart;
@property (nonatomic, readwrite, strong, nonnull) NSArray<NSDictionary *> *dataForPlot;

// Plot construction methods
-(void)constructScatterPlot;

@end
