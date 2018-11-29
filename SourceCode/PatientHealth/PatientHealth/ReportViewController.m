//
//  ReportViewController.m
//  PatientHealth
//
//  Created by VM on 9/22/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "ReportViewController.h"
#import "CorePlot-CocoaTouch.h"

@interface ReportViewController (){
    NSMutableArray *date;
    NSMutableArray *percentage;
}
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *scatterPlotView;
@property (nonatomic, readwrite, strong, nonnull) CPTXYGraph *graph;
@property (nonatomic,strong) BPReportGraphView *bpReportGraphView;
@property (nonatomic,weak) PedometerReportGraphView *pedometerReportView;
@property(nonatomic,weak) PillBoxReportGraphView *pillBoxReportView;
@end

#pragma mark -
@implementation ReportViewController
@synthesize dataForChart;
@synthesize dataForPlot;
@synthesize scatterPlotView;
//@synthesize graphContainerView;
//@synthesize bpReportGraphView;

#pragma mark -
#pragma mark Initialization and teardown

-(void)viewDidLoad
{
    [super viewDidLoad];
    SEL selector = @selector(backAction);
    [[Utilities sharedInstance] setCustomBackButton:self withSelector:selector];
    self.vitalArray = [NSMutableArray arrayWithObjects:@"Blood Pressure",@"Blood Glucose",@"Cholestrol" ,@"Pulse",@"Weight",nil];
    //    [self loadBPReportView];
    [self initVitalPicker];
    [self initMonthPicker];
    self.navigationItem.title = @"Reports";
    [self constructScatterPlot];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - code to load bpreport view might be used in future
-(void)loadBPReportView{
    self.bpReportGraphView = [[[UINib nibWithNibName:@"BPReportGraph" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    NSLog(@"frame of ContainerView : %@",NSStringFromCGSize(self.graphContainerView.frame.size));
    NSLog(@"frame of ContainerView : %@",NSStringFromCGSize(self.bpReportGraphView.frame.size));
    [self.graphContainerView addSubview:self.bpReportGraphView];
    [self initMonthPicker];
    //    [self beginingOfWeekOfDate];
    //    [self endOfWeekFromDate];
    //    [self setConstraints:self.bpReportGraphView];
}

#pragma mark - code to loadPedometerView might be used in future
-(void)loadPedometerView{
    self.pedometerReportView = [[[UINib nibWithNibName:@"PedometerReportGraph" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    NSLog(@"frame of ContainerView : %@",NSStringFromCGSize(self.graphContainerView.frame.size));
    NSLog(@"frame of ContainerView : %@",NSStringFromCGSize(self.pedometerReportView.frame.size));
    [self.graphContainerView addSubview:self.pedometerReportView];
}

#pragma mark - code to loadPedometerView might be used in future
-(void)loadPillBoxView{
    self.pillBoxReportView = [[[UINib nibWithNibName:@"PillBoxReportGraph" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    NSLog(@"frame of ContainerView : %@",NSStringFromCGSize(self.graphContainerView.frame.size));
    NSLog(@"frame of ContainerView : %@",NSStringFromCGSize(self.pillBoxReportView.frame.size));
    [self.graphContainerView addSubview:self.pillBoxReportView];
}

#pragma mark - code to set constraints programatically
-(void)setConstraints:(UIView *)viewName{
    viewName.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.graphContainerView  attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.graphContainerView  attribute:NSLayoutAttributeTop multiplier:1 constant:0];//300
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.graphContainerView  attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.graphContainerView  attribute:NSLayoutAttributeHeight multiplier:1 constant:0]; //420
    
    [self.graphContainerView addConstraints:@[leadingConstraint,topConstraint,widthConstraint,heightConstraint]];
    
    NSLog(@"ContainerView : %@ and %@ : %@",NSStringFromCGSize(self.graphContainerView .frame.size),viewName,NSStringFromCGSize(viewName.frame.size));
}

#pragma mark - segment button click function
- (IBAction)onClickReportSegmentControl:(id)sender {
    NSInteger selectedSegment = [sender selectedSegmentIndex];
    switch (selectedSegment) {
        case 0:
            //plot bp graph
            [self loadBPReportView];
            break;
        case 1:
            //plot pedometer graph
            [self loadPedometerView];
            break;
        case 2:
            //plot pill box graph
            [self loadPillBoxView];
            break;
        default:
            break;
    }
}

#pragma mark - code to init picker view data for month
-(void)initMonthPicker{
    [self setYearsArray];
    self.monthPicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    self.monthArray =[[NSMutableArray alloc]initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    self.monthPicker.dataSource = self;
    self.monthPicker.delegate = self;
    [self.txtYearMonth setInputView:self.monthPicker];
    self.monthPicker.tag = 999;
}

#pragma mark - code to init picker view data for year
-(void)initVitalPicker{
    self.vitalPicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    self.vitalPicker.dataSourceArrayForSimplePicker = self.vitalArray;
    self.vitalPicker.delegate = self;
    [self.txtChooseVital setInputView:self.vitalPicker];
    NSString *section = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedVital"];
    //    [self.vitalPicker setSelectedValue:[self.vitalArray objectAtIndex:[section intValue]]];
    if(section != nil){
        [self.txtChooseVital setText:[self.vitalArray objectAtIndex:[section intValue]]];
        [[Utilities sharedInstance]fetchDataForGraph:@"BPReport"];
        [self constructScatterPlot];
    }
}

#pragma mark - UIPickerViewDataSource methods
- (NSInteger)numberOfComponentsInCustomPicker:(CustomPicker *)customPicker
{
    NSInteger components = 0;
    if(customPicker.tag == 999){
        components = 2;
    }else{
        components = 1;
    }
    return components;
}

// returns the # of rows in each component..
- (NSInteger)numberofRowsInComponent:(NSInteger)component forPicker:(CustomPicker *)customPicker
{
    NSInteger rows = 0;
    if(customPicker.tag == 999){
        // ask delegate to return count or return array's count
        if (component == 0 ) {
            //set month array here
            rows = [self.monthArray count];
        }else{
            //set year array here
            rows = [self.yearArray count];
        }
    }else{
        rows = [self.vitalArray count];
    }
    return rows;
}

- (NSString *)titleForRow:(NSInteger)row inComponent:(NSInteger)component forPicker:(CustomPicker *)customPicker{
    NSString *title = nil;
    if(customPicker.tag == 999){
        if (component == 0 ) {
            //set month array here
            title = [_monthArray objectAtIndex:row];
        }
        else{
            //set year array here
            title = [self.yearArray objectAtIndex:row];
        }
    }else{
        title = [self.vitalArray objectAtIndex:row];
    }
    return title;
}

-(void)didSelectRow:(NSInteger)row inComponent:(NSInteger)component ofPicker:(CustomPicker *)picker{
    NSLog(@"row selected %lu" ,row);
    [self getEntityName:row];
    [self constructScatterPlot];
    
}

-(void)setYearsArray{
    NSInteger currentYear = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:1];
    [dateComponents setMonth:1];
    [dateComponents setYear:MIN_YEAR];
    NSUInteger yearCount = 1;
    self.yearArray = [[NSMutableArray alloc] init];
    
    while ([dateComponents year] <= currentYear) {
        [self.yearArray addObject:[[NSString alloc] initWithFormat:@"%ld",(long)[dateComponents year]]];
        [dateComponents setDay:1];
        [dateComponents setMonth:1];
        [dateComponents setYear:(MIN_YEAR + yearCount)];
        yearCount++;
    }
}

-(void)didTapOnDoneOf:(CustomPicker *)picker{
    if(picker.tag == 999){
        self.txtYearMonth.text = picker.selectedValue.text;
        [self.txtYearMonth resignFirstResponder];
        self.lblSelectedMonth.text = [self.txtYearMonth text];
    }else{
        self.txtChooseVital.text = picker.selectedValue.text;
        [self.txtChooseVital resignFirstResponder];
    }
}

#pragma mark - code to construct graph
-(void)constructScatterPlot{
    // Create graph from theme
    CPTXYGraph *newGraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    [self initGraph:newGraph];
    // Add some initial data
    [self getContentArrayForGraph];

    // AXES
    [self setUpXAxis:newGraph];
    
    // AXES
    [self setUpYAxis:newGraph];
    
    // Create a green plot area
    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.identifier = @"Third Plot";
    
    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth              = 1.0;
    lineStyle.lineColor              = [CPTColor greenColor];
    lineStyle.dashPattern            = @[@2.5f, @0.1f];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    //lineStyle.dashPattern=[NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:3],[NSDecimalNumber numberWithInt:3],nil];  //dashed line
    
    //lineStyle.lineWidth = 1;
    //lineStyle.lineColor = [CPTColor greenColor];
    //dataSourceLinePlot.dataLineStyle = lineStyle;
    
    dataSourceLinePlot.dataSource = self;
    
    //    Create a duplicate plot
    CPTScatterPlot *secondarySourceLinePlot = [[CPTScatterPlot alloc] init];
    secondarySourceLinePlot.identifier = @"First Plot";
    
    CPTMutableLineStyle *newLineStyle = [secondarySourceLinePlot.dataLineStyle mutableCopy];
    newLineStyle.lineWidth              = 1.0;
    newLineStyle.lineColor              = [CPTColor blueColor];
    newLineStyle.dashPattern            = @[@2.0f, @0.1f];
    secondarySourceLinePlot.dataLineStyle = newLineStyle;
    
    secondarySourceLinePlot.dataSource = self;
    
    dataSourceLinePlot.areaBaseValue = @1.75;
    
    
    
    // Create third plot
    
    CPTScatterPlot *primarySourceLinePlot = [[CPTScatterPlot alloc] init];
    primarySourceLinePlot.identifier = @"Second Plot";
    
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
    
    [dataSourceLinePlot addAnimation:[self animateGraphPlotting] forKey:@"animateOpacity"];
    [secondarySourceLinePlot addAnimation:[self animateGraphPlotting] forKey:@"animateOpacity1"];
    [primarySourceLinePlot addAnimation:[self animateGraphPlotting] forKey:@"animateOpacity2"];
    
    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor redColor];
    
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blackColor]];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(5.0, 5.0);
    
}

-(void)initGraph:(CPTXYGraph *)newGraph{
    
    //    [newGraph applyTheme:theme];
    self.scatterPlotView.hostedGraph = newGraph;
    self.graph                       = newGraph;
    self.graph.plotAreaFrame.masksToBorder = NO;
    //    self.scatterPlotView.backgroundColor = [UIColor purpleColor];
    
    newGraph.paddingLeft   = 30.0;
    newGraph.paddingTop    = 30.0;
    newGraph.paddingRight  = 30.0;
    newGraph.paddingBottom  = 50.0;
//    newGraph.masksToBorder = YES;
    
    // Setup plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)newGraph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.xRange   =     [CPTPlotRange plotRangeWithLocation:@0.0 length:@100.0];
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:@0.0  length:@100.0];
    plotSpace.yRange       = [CPTPlotRange plotRangeWithLocation:@0.0 length:@200.0];
    plotSpace.globalYRange = [CPTPlotRange plotRangeWithLocation:@0.0 length:@200.0];
}

-(CABasicAnimation *)animateGraphPlotting{
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.duration            = 1.0;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.fillMode            = kCAFillModeForwards;
    fadeInAnimation.toValue             = @1.0;
    return fadeInAnimation;
}

-(void)setUpXAxis:(CPTXYGraph *)newGraph{
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)newGraph.axisSet;
    CPTXYAxis *xAxis   = axisSet.xAxis;
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:10.0f];
    [textStyle setColor:[CPTColor colorWithCGColor:[[UIColor blackColor] CGColor]]];
    [xAxis setMajorIntervalLength:@(10)];
    [xAxis setMinorTickLineStyle:nil];
    [xAxis setLabelingPolicy:CPTAxisLabelingPolicyNone];
    [xAxis setLabelTextStyle:textStyle];
    [xAxis setLabelRotation:M_PI/3];
    
    NSArray *dateArray = [self getXlabels];
    
    [xAxis setAxisLabels:[NSSet setWithArray:dateArray]];
}

-(void)setUpYAxis:(CPTXYGraph *)newGraph{
    CPTXYAxisSet *axisYSet = (CPTXYAxisSet *)newGraph.axisSet;
    NSNumberFormatter *axisFormatter = [[NSNumberFormatter alloc] init];
    [axisFormatter setMinimumIntegerDigits:1];
    [axisFormatter setMaximumFractionDigits:0];
    CPTXYAxis *y  = axisYSet.yAxis;
    y.orthogonalPosition=@0.0;
    
    [y setMajorIntervalLength:@(40)];
    [y setMinorTickLineStyle:nil];
    [y setLabelingPolicy:CPTAxisLabelingPolicyFixedInterval];
    [y setLabelFormatter:axisFormatter];
    
    CPTMutableLineStyle *yGridLineStyle = [[CPTMutableLineStyle alloc] init];
    yGridLineStyle.lineColor = [[CPTColor blackColor]colorWithAlphaComponent:1.0] ;
    yGridLineStyle.lineWidth = 0.1;
    y.minorGridLineStyle = yGridLineStyle;
    y.majorGridLineStyle = yGridLineStyle;
    y.title = @"mmHg";
    y.titleOffset = 35;
}

-(NSArray*)getXlabels{
    NSMutableArray *labelArray = [NSMutableArray array];
    NSArray *titleStrings = [dataForPlot valueForKey: @"x"];
    
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:10];
    
    for (int i = 0; i < [dataForPlot count]; i++){
//        NSDictionary *dict = [titleStrings objectAtIndex:i];
        
        CPTAxisLabel *axisLabel = [[CPTAxisLabel alloc] initWithText:[[titleStrings objectAtIndex:i] stringValue ]textStyle:nil];//[[CPTAxisLabel alloc] initWithText:[titleStrings objectAtIndex:i] textStyle:textStyle];
        [axisLabel setTickLocation:[NSNumber numberWithInteger:(i + 1)]];
        [axisLabel setRotation:M_PI/4];
        [axisLabel setOffset:0.1];
        [labelArray addObject:axisLabel];
    }
    
    return [NSArray arrayWithArray:labelArray];
}

#pragma - function to prepare content array for graph.
-(void)getContentArrayForGraph{//:(NSArray*)dataArray{
    int length = [self.dataArray count];
    NSMutableArray<NSDictionary *> *contentArray = [NSMutableArray arrayWithCapacity:length];
    for(int counter = 0; counter < length ; counter++){
        
        if([[self.dataArray objectAtIndex:counter] isKindOfClass:[BPReport class]]){
            NSNumber *yVal = [[self.dataArray objectAtIndex:counter] valueForKey:@"diastolic"];
            NSNumber *xVal = [NSNumber numberWithInteger:(int)roundf(counter )];
            [contentArray addObject:@{@"x": xVal,  @"y": yVal }];
            NSLog(@"%@",@{@"x": xVal,@"y": yVal });
        }
    }
//    NSMutableArray<NSDictionary *> *contentArray = [NSMutableArray arrayWithCapacity:12];
//    for ( NSUInteger i = 0; i < 4; i++ )
//        
//    {
//        NSNumber *xVal = @(1 + i);
//        NSNumber *yVal = @(2.5 * arc4random() /  (double)UINT32_MAX + 2.5);
//        [contentArray addObject:@{@"x": xVal,  @"y": yVal }];
//        NSLog(@"%@",@{@"x": xVal,@"y": yVal });
//    }
    self.dataForPlot = contentArray;
}
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
    
    if ([[aPlot identifier] isEqual:@"Third Plot"])
    {
        [plotSymbol setFill:[CPTFill fillWithColor:[CPTColor greenColor]]];
    }
    else if ([[aPlot identifier] isEqual:@"First Plot"])
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
//    [[self.dataForPlot objectAtIndex:index] valueForKey:@"x"];
    
//    NSArray *yArray = [NSArray arrayWithObjects:@1,@2,@4,@7,nil];
//    NSArray *xArray = [NSArray arrayWithObjects:@2,@3,@1,@4,nil];
    switch (fieldEnum)
    {
        case CPTScatterPlotFieldX:
            NSLog(@"x value for %lu is %@", index, [[self.dataForPlot objectAtIndex:index] valueForKey:@"x"]);
            return [[self.dataForPlot objectAtIndex:index] valueForKey:@"x"];//[NSNumber numberWithInt:xArray];
            break;
        case CPTScatterPlotFieldY:
            NSLog(@"y value for %lu is %@",index, [[self.dataForPlot objectAtIndex:index] valueForKey:@"y"]);
            return [[self.dataForPlot objectAtIndex:index] valueForKey:@"y"];
            break;
            
        default:
            break;
    }
//    {
//        NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
//        num = self.dataForPlot[index][key];
//        // Green plot gets shifted above the blue
//        if ( [(NSString *) plot.identifier isEqualToString:@"Third Plot"] ) {
//            if ( fieldEnum == CPTScatterPlotFieldY ) {
//                num = @(num.doubleValue + 1.0);
//            }
//        }
//        else if ( [(NSString *) plot.identifier isEqualToString:@"First Plot"] )
//        {
//            if ( fieldEnum == CPTScatterPlotFieldY ) {
//                num = @(num.doubleValue + 2.0);
//            }
//        }
//        else ([(NSString *) plot.identifier isEqualToString:@"Second Plot"] );
//        {
//            if ( fieldEnum == CPTScatterPlotFieldY ) {
//                num = @( num.doubleValue +1.0);
//            }
//        }
//    }
    
    return num;
}

#pragma function to refresh graph on selection change of pickerview
-(void)loadGraphOnPickerSelection:(NSString*)selectedValue{
    if([selectedValue isEqualToString:@"Blood Pressure"]){
        //loadBPGraph
    }else if([selectedValue isEqualToString:@"Blood Glucose"]){
        //loadGlucoseGraph
    }else if([selectedValue isEqualToString:@"Cholestrol"]){
        //loadCholestrolGraph
    }else if([selectedValue isEqualToString:@"Pulse"]){
        //loadPulseGraph
    }else if([selectedValue isEqualToString:@"Weight"]){
        //loadWeightGraph
    }
    
}

#pragma function to load data from core data
-(void)fetchDataFromCoreData:(NSInteger) selectedRowOfPicker{
    //    set value of percentage and date here
    
    
    switch (selectedRowOfPicker) {
        case 0:
            //fetch bp
            break;
        case 1:
            //fetch blood glucose
            break;
            case 2:
            //fetch cholestrol
            break;
        case 3:
            //pulse
            break;
        case 4:
            //fetch weight
            break;
        default:
            break;
    }
}

#pragma mark - function for custom back button
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - return Entity name
-(void)getEntityName:(NSInteger) strEntityName{
    NSString* coreDataEntityName;
    switch (strEntityName) {
        case 0:{
            coreDataEntityName = BpEntity;
            break;
        }
        case 1:{
            coreDataEntityName = BloodSugarEntity;
            break;
        }
        case 2:{
            coreDataEntityName = CholestrolEntity;
            break;
        }
        case 3:{
            coreDataEntityName = PulseEntity;
            break;
        }
        case 4:{
            coreDataEntityName = WeightEntity;
            break;
        }
          default:
            break;
    }
    self.dataArray = [[Utilities sharedInstance] fetchDataForGraph:coreDataEntityName];
    NSManagedObject *obj = [self.dataArray objectAtIndex:0];
//    [self getContentArrayForGraph:dataArray];
//    NSNumber *value = [[NSNumber alloc] initWithLong:(long)[obj valueForKey:@"diastolic"]];
    [self constructScatterPlot];
}
@end
