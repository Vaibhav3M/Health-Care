////
////  BPReportGraphView.m
////  PatientHealth
////
////  Created by VM on 11/3/16.
////  Copyright © 2016 Vaibhav. All rights reserved.
////
//
#import "CorePlot-CocoaTouch.h"
#import "BPReportGraphView.h"

@interface BPReportGraphView ()
{
    NSArray *date;
    NSArray *percentage;
}
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *scatterPlotView;

@property (nonatomic, readwrite, strong, nonnull) CPTXYGraph *graph;

@end

#pragma mark -

@implementation BPReportGraphView

@synthesize dataForChart;
@synthesize dataForPlot;

@synthesize scatterPlotView;

#pragma mark -
#pragma mark Initialization and teardown

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    return self;
}

#pragma mark -
#pragma mark Plot construction methods

-(void)drawRect:(CGRect)rect{
    [self constructScatterPlot];
}


-(void)constructScatterPlot
{
    // Create graph from theme
    CPTXYGraph *newGraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    // CPTTheme *theme      = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    //[newGraph applyTheme:theme];
    self.scatterPlotView.hostedGraph = newGraph;
    self.graph                       = newGraph;
    self.graph.plotAreaFrame.masksToBorder = NO;
    //self.scatterPlotView.backgroundColor = [UIColor purpleColor];
    
    newGraph.paddingLeft   = 30.0;
    newGraph.paddingTop    = 30.0;
    newGraph.paddingRight  = 30.0;
    newGraph.paddingBottom  = 100.0;
    
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
    x.minorTickLineStyle = nil;
    x.majorTickLineStyle = nil;
    
    int labelLocations = 0;
    NSMutableArray *customXLabels = [NSMutableArray array];
    NSArray *dates = [NSArray arrayWithObjects:@"", @"Sun", @"Mon", @"Tues", @"Wed", @"Thrus",@"Fri" ,@"Sat",nil];
    for (NSString *day in dates) {
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:day textStyle:axisSet.xAxis.labelTextStyle];
        newLabel.tickLocation   = [NSNumber numberWithInt:labelLocations] ;
        newLabel.offset         = axisSet.xAxis.labelOffset+20;// + axisSet.xAxis.majorTickLength;
        newLabel.rotation       = M_PI / 4;
        [customXLabels addObject:newLabel];
        labelLocations++;
    }
    
    NSSet *majorTickLocations = [NSSet setWithObjects:[NSDecimalNumber zero],
                                 [NSDecimalNumber numberWithUnsignedInteger:0],
                                 [NSDecimalNumber numberWithUnsignedInteger:1],
                                 [NSDecimalNumber numberWithUnsignedInteger:2],
                                 [NSDecimalNumber numberWithUnsignedInteger:3],
                                 [NSDecimalNumber numberWithUnsignedInteger:4],
                                 [NSDecimalNumber numberWithUnsignedInteger:5],
                                 [NSDecimalNumber numberWithUnsignedInteger:6],
                                 [NSDecimalNumber numberWithUnsignedInteger:7],
                                 [NSDecimalNumber numberWithUnsignedInteger:8],
                                 [NSDecimalNumber numberWithUnsignedInteger:9],
                                 [NSDecimalNumber numberWithUnsignedInteger:10],
                                 nil];
    
    axisSet.xAxis.axisLabels   = [NSSet setWithArray:customXLabels];
    x.majorTickLength = majorTickLocations.count;
    x.majorTickLocations = majorTickLocations;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    
    CPTMutableLineStyle *xGridLineStyle = [[CPTMutableLineStyle alloc] init];
    xGridLineStyle.lineColor = [[CPTColor blackColor]colorWithAlphaComponent:1.0] ;
    xGridLineStyle.lineWidth = 0.10;
    x.minorGridLineStyle = xGridLineStyle;
    x.majorGridLineStyle = xGridLineStyle;
    
    
    // AXES
    CPTXYAxisSet *axisYSet = (CPTXYAxisSet *)newGraph.axisSet;
    CPTXYAxis *y  = axisYSet.yAxis;
    y.majorIntervalLength   = @1.0;
    y.orthogonalPosition    = @0.0;
    y.minorTickLineStyle = nil;
    y.majorTickLineStyle = nil;
    
    int labelLocations1 = 0;
    NSMutableArray *customYLabels = [NSMutableArray array];
    NSArray *percentage= [NSArray arrayWithObjects:@"",@"20",@"40",@"60",@"80",@"100",@"120",@"140",@"160",@"180",@"200" , nil];
    
    for (NSString *day1 in percentage) {
        CPTAxisLabel *newLabel1 = [[CPTAxisLabel alloc] initWithText:day1 textStyle:axisSet.yAxis.labelTextStyle];
        
        newLabel1.tickLocation   = [NSNumber numberWithInt:labelLocations1] ;
        newLabel1.offset         = axisSet.yAxis.labelOffset+20;// + axisSet.xAxis.majorTickLength;
        //newLabel.rotation       = M_PI / 2;
        [customYLabels addObject:newLabel1];
        labelLocations1++;
    }
    
    NSSet *majorTickLocations1 = [NSSet setWithObjects:[NSDecimalNumber zero],
                                  [NSDecimalNumber numberWithUnsignedInteger:0],
                                  [NSDecimalNumber numberWithUnsignedInteger:1],
                                  [NSDecimalNumber numberWithUnsignedInteger:2],
                                  [NSDecimalNumber numberWithUnsignedInteger:3],
                                  [NSDecimalNumber numberWithUnsignedInteger:4],
                                  [NSDecimalNumber numberWithUnsignedInteger:5],
                                  [NSDecimalNumber numberWithUnsignedInteger:6],
                                  [NSDecimalNumber numberWithUnsignedInteger:7],
                                  [NSDecimalNumber numberWithUnsignedInteger:8],
                                  [NSDecimalNumber numberWithUnsignedInteger:9],
                                  [NSDecimalNumber numberWithUnsignedInteger:10],
                                  nil];
    
    axisSet.yAxis.axisLabels   = [NSSet setWithArray:customYLabels];
    y.majorTickLength = majorTickLocations1.count;
    y.majorTickLocations = majorTickLocations1;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    
    CPTMutableLineStyle *yGridLineStyle = [[CPTMutableLineStyle alloc] init];
    yGridLineStyle.lineColor = [[CPTColor blackColor]colorWithAlphaComponent:1.0] ;
    yGridLineStyle.lineWidth = 0.10;
    y.minorGridLineStyle = yGridLineStyle;
    y.majorGridLineStyle = yGridLineStyle;
    y.title = @"mmHg";
    y.titleOffset = 35;
     
    // Create a green plot area
    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.identifier = @"Green Plot";
    
    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth              = 1.0;
    lineStyle.lineColor              = [CPTColor greenColor];
    lineStyle.dashPattern            = @[@2.5f, @0.1f];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    
    dataSourceLinePlot.dataSource = self;
    
    //    Create a duplicate plot
    CPTScatterPlot *secondarySourceLinePlot = [[CPTScatterPlot alloc] init];
    secondarySourceLinePlot.identifier = @"Blue Plot";
    
    CPTMutableLineStyle *newLineStyle = [secondarySourceLinePlot.dataLineStyle mutableCopy];
    newLineStyle.lineWidth              = 1.0;
    newLineStyle.lineColor              = [CPTColor blueColor];
    newLineStyle.dashPattern            = @[@2.0f, @0.1f];
    secondarySourceLinePlot.dataLineStyle = newLineStyle;
    
    secondarySourceLinePlot.dataSource = self;
    
    dataSourceLinePlot.areaBaseValue = @1.75;
    
    
    
    // Create third plot
    
    CPTScatterPlot *primarySourceLinePlot = [[CPTScatterPlot alloc] init];
    primarySourceLinePlot.identifier = @"Red Plot";
    
    CPTMutableLineStyle *new1LineStyle = [primarySourceLinePlot.dataLineStyle mutableCopy];
    newLineStyle.lineWidth              = 1.0;
    newLineStyle.lineColor              = [CPTColor redColor];
    newLineStyle.dashPattern            = @[@2.0f, @0.1f];
    primarySourceLinePlot.dataLineStyle = new1LineStyle;
    
    primarySourceLinePlot.dataSource = self;
    
    primarySourceLinePlot.areaBaseValue = @1.75;
    
    
    // Animate in the new plot, as an example
    secondarySourceLinePlot.opacity        = 1.0;
    secondarySourceLinePlot.cachePrecision = CPTPlotCachePrecisionDecimal;
    [newGraph addPlot:secondarySourceLinePlot];
    
    secondarySourceLinePlot.areaBaseValue = @1;
    
    // Animate in the new plot, as an example
    dataSourceLinePlot.opacity        = 0.0;
    dataSourceLinePlot.cachePrecision = CPTPlotCachePrecisionDecimal;
    [newGraph addPlot:dataSourceLinePlot];
    
    //  Animate in the new plot, as an example
    
    primarySourceLinePlot.opacity        = 0.0;
    primarySourceLinePlot.cachePrecision = CPTPlotCachePrecisionDecimal;
    [newGraph addPlot:primarySourceLinePlot];
    
    
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.duration            = 1.0;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.fillMode            = kCAFillModeForwards;
    fadeInAnimation.toValue             = @1.0;
    [dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
    
    CABasicAnimation *fadeInAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation1.duration            = 1.0;
    fadeInAnimation1.removedOnCompletion = NO;
    fadeInAnimation1.fillMode            = kCAFillModeForwards;
    fadeInAnimation1.toValue             = @1.0;
    [secondarySourceLinePlot addAnimation:fadeInAnimation1 forKey:@"animateOpacity1"];
    
    
    
    CABasicAnimation *fadeInAnimation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation2.duration            = 1.0;
    fadeInAnimation2.removedOnCompletion = NO;
    fadeInAnimation2.fillMode            = kCAFillModeForwards;
    fadeInAnimation2.toValue             = @1.0;
    [primarySourceLinePlot addAnimation:fadeInAnimation2 forKey:@"animateOpacity2"];
    
    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor redColor];
    
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blackColor]];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(5.0, 5.0);
    //boundLinePlot.plotSymbol = plotSymbol;
    
    // Add some initial data
    NSMutableArray<NSDictionary *> *contentArray = [NSMutableArray arrayWithCapacity:12];
    for ( NSUInteger i = 0; i < 7; i++ )
        
    {
        NSNumber *xVal = @(1 + i);
        NSNumber *yVal = @(2.5 * arc4random() /  (double)UINT32_MAX + 2.5);
        [contentArray addObject:@{@"x": xVal,  @"y": yVal }];
        NSLog(@"%@",@{@"x": xVal,@"y": yVal });
    }
    self.dataForPlot = contentArray;
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(nonnull CPTPlot *)plot
{
    if ( [plot isKindOfClass:[CPTPieChart class]] ) {
        return self.dataForChart.count;
    }
    else if ( [plot isKindOfClass:[CPTBarPlot class]] ) {
        return 6;
    }
    else {
        return self.dataForPlot.count;
    }
}

- (CPTPlotSymbol *)symbolForScatterPlot:(CPTScatterPlot *)aPlot recordIndex:(NSUInteger)index
{
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    [plotSymbol setSize:CGSizeMake(10, 10)];
    
    /* if ([[aPlot identifier] isEqual:@"Green Plot"])
     {
     [plotSymbol setFill:[CPTFill fillWithColor:[CPTColor greenColor]]];
     }
     else if ([[aPlot identifier] isEqual:@"Blue Plot"])
     {
     [plotSymbol setFill:[CPTFill fillWithColor:[CPTColor blueColor]]];
     }*/
    
    
    
    if ([[aPlot identifier] isEqual:@"Green Plot"])
    {
        [plotSymbol setFill:[CPTFill fillWithColor:[CPTColor greenColor]]];
    }
    else if ([[aPlot identifier] isEqual:@"Blue Plot"])
    {
        [plotSymbol setFill:[CPTFill fillWithColor:[CPTColor blueColor]]];
    }
    else {
        [plotSymbol setFill:[CPTFill fillWithColor:[CPTColor blackColor]]];
    }
    
    [plotSymbol setLineStyle:nil];
    [aPlot setPlotSymbol:plotSymbol];
    
    return plotSymbol;
}
// Functionality

-(nullable id)numberForPlot:(nonnull CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSNumber *num = nil;
    
    {
        NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
        num = self.dataForPlot[index][key];
        // Green plot gets shifted above the blue
        if ( [(NSString *) plot.identifier isEqualToString:@"Green Plot"] ) {
            if ( fieldEnum == CPTScatterPlotFieldY ) {
                num = @(num.doubleValue + 1.0);
            }
        }
        else if ( [(NSString *) plot.identifier isEqualToString:@"Blue Plot"] )
        {
            if ( fieldEnum == CPTScatterPlotFieldY ) {
                num = @(num.doubleValue + 2.0);
            }
        }
        else ([(NSString *) plot.identifier isEqualToString:@"Red Plot"] );
        {
            if ( fieldEnum == CPTScatterPlotFieldY ) {
                num = @( num.doubleValue +1.0);
            }
        }
    }
    
    return num;
}

- (IBAction)onMonthClick:(id)sender {
    NSLog(@"MonthButton Clicked");
    [self.btnMonth setSelected:YES];
    [self.btnWeek setSelected:NO];
    [self selectMonthOrWeek:self.btnMonth:self.btnWeek];
}

- (IBAction)onWeekClick:(UIButton *)sender {
    NSLog(@"Week Clicked");
    [self.btnMonth setSelected:NO];
    [self.btnWeek setSelected:YES];
    [self selectMonthOrWeek:self.btnWeek:self.btnMonth];
}

- (IBAction)onClickPrevBtn:(id)sender {
    [self weekDates];
    [self monthDates];
}

- (IBAction)onClickNextBtn:(id)sender {
}

-(void)selectMonthOrWeek:(UIButton *)selectedBtn :(UIButton *)deSelectedBtn{
    [selectedBtn.layer setBorderWidth:1.0];
    selectedBtn.layer.cornerRadius = 10; // this value vary as per your desire
    selectedBtn.clipsToBounds = YES;
    [selectedBtn.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [deSelectedBtn.layer setBorderWidth:1.0];
    [deSelectedBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

- (void) weekDates{
    NSDate *now = [NSDate date];
    NSDate *startDate;
    NSDate *endDate;
    NSTimeInterval weekInterval;
    NSCalendar *tmpCalendar = [NSCalendar currentCalendar];
    [tmpCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [tmpCalendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&startDate interval:&weekInterval forDate:now];
    endDate = [startDate dateByAddingTimeInterval:weekInterval];
    startDate = [startDate dateByAddingTimeInterval:60*60*24];
    NSString *weakDateRange ;
    weakDateRange =  [[NSString alloc] initWithFormat:@"%@ to %@ ",[self convertDateToString:startDate], [self convertDateToString:endDate]];
    self.lblSelectedMonth.text = weakDateRange;
}

-(void)monthDates{
    NSDate *now = [NSDate date];
    NSDate *startDate;
    NSDate *endDate;
    NSTimeInterval monthInterval;
    NSCalendar *tmpCalendar = [NSCalendar currentCalendar];
    [tmpCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [tmpCalendar rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:&monthInterval forDate:now];
    endDate = [startDate dateByAddingTimeInterval:monthInterval-1];
    
    NSRange dayRange = [tmpCalendar rangeOfUnit:NSCalendarUnitDay
                                             inUnit:NSCalendarUnitMonth
                                            forDate:now];
    NSDateComponents *dateComponents = [tmpCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [dateComponents setDay:dayRange.length];
    startDate = [tmpCalendar dateFromComponents:dateComponents];//[startDate dateByAddingTimeInterval:monthInterval-1];//[tmpCalendar dateByAddingComponents:monthInterval toDate:endDate options:0]
}

-(NSString *)convertDateToString:(NSDate*)inputDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormat stringFromDate:inputDate];
    return stringFromDate;
}
@end
