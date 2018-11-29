//
//  PedometerReportGraphView.m
//  PatientHealth
//
//  Created by VM on 11/3/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "PedometerReportGraphView.h"

@implementation PedometerReportGraphView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    return self;
}

#pragma mark -
#pragma mark Plot construction methods

-(void)drawRect:(CGRect)rect{
    [self constructBarChart];
}

-(void)constructBarChart{
    CPTXYGraph *newGraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    // CPTTheme *theme      = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    //[newGraph applyTheme:theme];
    self.graphHostingView.hostedGraph = newGraph;
    self.graph                       = newGraph;
    self.graph.plotAreaFrame.masksToBorder = NO;
//    self.graphHostingView.backgroundColor = [UIColor purpleColor];
    
    // Setup plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)newGraph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.xRange   =     [CPTPlotRange plotRangeWithLocation:@0.0 length:@10.0];
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:@0.0  length:@10.0];
    plotSpace.yRange       = [CPTPlotRange plotRangeWithLocation:@0.0 length:@10.0];
    plotSpace.globalYRange = [CPTPlotRange plotRangeWithLocation:@0.0 length:@10.0];
    
    // AXES
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)newGraph.axisSet;
    CPTXYAxis *x   = axisSet.xAxis;
    x.majorIntervalLength   = @1.0;
    x.orthogonalPosition    = @0.0;
    
    CPTBarPlot *subjectBarPlot = [[CPTBarPlot alloc] initWithFrame:[self.graph bounds]];
    [subjectBarPlot setIdentifier:@"subjectEnrollement"];
    [subjectBarPlot setDelegate:self];
    [subjectBarPlot setDataSource:self];
    
    [[self graph] addPlot:subjectBarPlot];
    
    [[self.graph plotAreaFrame] setPaddingLeft:40.0f];
    [[self.graph plotAreaFrame] setPaddingTop:10.0f];
    [[self.graph plotAreaFrame] setPaddingBottom:120.0f];
    [[self.graph plotAreaFrame] setPaddingRight:0.0f];
    [[self.graph plotAreaFrame] setBorderLineStyle:nil];
    
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:12.0f];
    [textStyle setColor:[CPTColor colorWithCGColor:[[UIColor grayColor] CGColor]]];
    
    CPTXYAxis *xAxis = [axisSet xAxis];
    [xAxis setMajorIntervalLength:@1.0];
    [xAxis setMinorTickLineStyle:nil];
    [xAxis setLabelingPolicy:CPTAxisLabelingPolicyFixedInterval];
    [xAxis setLabelTextStyle:textStyle];
    
    CPTXYAxis *yAxis = [axisSet yAxis];
    [yAxis setMajorIntervalLength:@1.0];
    [yAxis setMinorTickLineStyle:nil];
    [yAxis setLabelingPolicy:CPTAxisLabelingPolicyFixedInterval];
}

#pragma mark - Private Methods
- (float)getTotalSubjects
{
    
    return 10.0;
}

- (float)getMaxEnrolled
{
    float maxEnrolled = 0;
    
//    NSError *error = nil;
    
    for (int i = 0; i < 10; i++)
    {
        
        maxEnrolled = maxEnrolled + 0.5;
    }
    
    return maxEnrolled;
}
#pragma mark - CPTBarPlotDataSourceMethods
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self getTotalSubjects];
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    int x = (int)index++;
    int y = (int) index + 0.1;
    
    switch (fieldEnum)
    {
        case CPTScatterPlotFieldX:
            return [NSNumber numberWithInt:x];
            break;
        case CPTScatterPlotFieldY:
            return [NSNumber numberWithInt:y];
            break;
            
        default:
            break;
    }
    
    return nil;
}

#pragma fill bar with color
-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    CPTColor *areaColor = nil;
        
    switch (index)
    {
        case 0:
            areaColor = [CPTColor redColor];
            break;
            
        case 1:
            areaColor = [CPTColor blueColor];
            break;
            
        case 2:
            areaColor = [CPTColor orangeColor];
            break;
            
        case 3:
            areaColor = [CPTColor greenColor];
            break;
            
        default:
            areaColor = [CPTColor purpleColor];
            break;
    }
    
    CPTFill *barFill = [CPTFill fillWithColor:areaColor];
    
    return barFill;
}
@end
