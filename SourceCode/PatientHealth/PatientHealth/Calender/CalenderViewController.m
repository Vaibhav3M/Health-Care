//
//  CalenderViewController.m
//  PatientHealth
//
//  Created by VM  on 25/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "CalenderViewController.h"

@interface CalenderViewController ()

@end

@implementation CalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    self.fillDefaultColors = @{@"2016/11/08":[UIColor greenColor],
    //                               @"2016/11/06":[UIColor orangeColor],
    //                               @"2016/11/16":[UIColor redColor],
    //                               @"2016/11/22":[UIColor greenColor]};
    
    CGFloat screenWidth=[UIScreen mainScreen].bounds.size.width-40;
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(20,60,screenWidth,screenWidth-60)];
    
    [_segmentClickOutlet setFrame:CGRectMake(0, screenWidth, screenWidth, 30)];
    
  
    _calendar.dataSource = self;
    _calendar.delegate = self;
    
    [self.view addSubview:_calendar];
    self.calendar = _calendar;
    self.calendar.multipleTouchEnabled=YES;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    
    
    
    
    targetTotal=([_medicineData valueForKey:@"dosage"]);
    targetAchieved=([_medicineData valueForKey:@"fromdate"]);
    
    self.fillDefaultColors =[self indexKeyedDictionaryFromArray:activityArray];
    

}
-(void)viewDidAppear:(BOOL)animated
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequestmed = [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
    self.medicineData = [[managedObjectContext executeFetchRequest:fetchRequestmed error:nil] mutableCopy];
    NSFetchRequest *fetchRequestactivity = [[NSFetchRequest alloc] initWithEntityName:@"Activity"];
    self.activityData = [[managedObjectContext executeFetchRequest:fetchRequestactivity error:nil] mutableCopy];
    NSFetchRequest *fetchRequestfood = [[NSFetchRequest alloc] initWithEntityName:@"Food"];
    self.foodData = [[managedObjectContext executeFetchRequest:fetchRequestfood error:nil] mutableCopy];
    
    
    medicineDosageArray=([_medicineData valueForKey:@"fromdate"]);
    activityArray=([_activityData valueForKey:@"startDate"]);
    foodArray=([_foodData valueForKey:@"startdate"]);

    
    if (self.strAddMoreView) {
        
    }
    else{
    self.strAddMoreView=@"Activity";
    [self loadActivityDashboard];

    }
    [super viewDidAppear:animated];
    [_calendar removeFromSuperview];
    [self loadCalender];
    
    if ([self.strAddMoreView isEqualToString:@"Activity"]) {
        [self loadActivityDashboard];
       
        
    }else if ([self.strAddMoreView isEqualToString:@"Medicine"]){
        [self loadMedicineDashboard];
        
    }else if ([self.strAddMoreView isEqualToString:@"Food"]){
        [self loadFoodDashboard];
    }

}


-(void)loadCalender
{
    CGFloat screenWidth=[UIScreen mainScreen].bounds.size.width-40;
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(20,60,screenWidth,screenWidth-60)];
    
    
    _calendar.dataSource = self;
    _calendar.delegate = self;
    
    [self.view addSubview:_calendar];
    self.calendar = _calendar;
    self.calendar.multipleTouchEnabled=YES;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    
}
-(void)loadDetailsView:(NSString *)date
{
    
    NSLog(@"date is %@",date);
    NSString *match = date;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", match];
    NSMutableDictionary *indexDictionary=[NSMutableDictionary new];
    
    if ([self.strAddMoreView isEqualToString:@"Activity"]) {
        
    NSArray *results = [activityArray filteredArrayUsingPredicate:predicate];
        
        if ([results count]==0) {
            [self selectedDateView];
           _selectedDateView.lblMessage_.text=@"No Activity for this date";
            _selectedDateView.lblMessage.text=@"Add activity for this date";
            _selectedDateView.strSelectedType=@"Activity";
            _selectedDateView.strselectedDate=date;
        
        }
        else{

            
            [_selectedDateView removeFromSuperview];
        int count=0;
        for (i=0; i<activityArray.count; i++) {
          
            
            if ([activityArray[i] isEqualToString:match])
            {
                
            [indexDictionary setObject:[NSString stringWithFormat:@"%d",i]  forKey:[NSString stringWithFormat:@"%d",count]];
                count++;
            }
        
        }
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"ActivityNotification" object:self userInfo:indexDictionary];

        }
    }
    else if ([self.strAddMoreView isEqualToString:@"Medicine"])
    {
        NSArray *results = [medicineDosageArray filteredArrayUsingPredicate:predicate];
        if ([results count]==0) {
            [self selectedDateView];
            _selectedDateView.lblMessage_.text=@"No Medicine for this date";
            _selectedDateView.lblMessage.text=@"Add Medicine for this date";
            _selectedDateView.strSelectedType=@"Medicine";
            _selectedDateView.strselectedDate=date;
        }
        else{
             [_selectedDateView removeFromSuperview];
            int count=0;
            for (i=0; i<medicineDosageArray.count; i++) {
                
                if ([medicineDosageArray[i] isEqualToString:match])
                {
                    
                    [indexDictionary setObject:[NSString stringWithFormat:@"%d",i]  forKey:[NSString stringWithFormat:@"%d",count]];
                    count++;
                }
                
            }
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"MedicineNotification" object:self userInfo:indexDictionary];
            
        }

    }
    else if ([self.strAddMoreView isEqualToString:@"Food"])
    {
        NSArray *results = [foodArray filteredArrayUsingPredicate:predicate];
        if ([results count]==0) {
            [self selectedDateView];
            _selectedDateView.lblMessage_.text=@"No Food for this date";
            _selectedDateView.lblMessage.text=@"Add Food for this date";
            _selectedDateView.strSelectedType=@"Food";
            _selectedDateView.strselectedDate=date;

        }
        else{
             [_selectedDateView removeFromSuperview];
            int count=0;
            for (i=0; i<foodArray.count; i++) {
                
                if ([foodArray[i] isEqualToString:match])
                {
                    
                    [indexDictionary setObject:[NSString stringWithFormat:@"%d",i]  forKey:[NSString stringWithFormat:@"%d",count]];
                    count++;
                }
                
            }
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"FoodNotification" object:self userInfo:indexDictionary];
            
        }
    }
}


- (NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array
{
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    
    for (i=0; i<array.count; i++) {
        
        [mutableDictionary setValue:[UIColor greenColor] forKey:array[i]];
    }
    return (NSDictionary *)mutableDictionary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    [self loadDetailsView:[self.dateFormatter stringFromDate:date]];
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    
}

- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    return self.images[dateString];
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter stringFromDate:date];
    if ([_fillDefaultColors.allKeys containsObject:key]) {
        return _fillDefaultColors[key];
    }
    return nil;
}


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
-(void)loadMedicineDashboard{
    _dashboardMedicine = [[[NSBundle mainBundle] loadNibNamed:@"MedicineDashboard" owner:self options:nil] lastObject];
    
    [self removeViewsIfAdded];
    [_containerView addSubview:_dashboardMedicine];
    //  [self setConstraints:_dashboardMedicine];
    // [self setDataForMedicineView];
    self.fillDefaultColors =[self indexKeyedDictionaryFromArray:medicineDosageArray];
    [_calendar removeFromSuperview];
    [self loadCalender];
    // [self setConstraints:_dashboardActivity];
    
}

-(void)loadActivityDashboard{
    _dashboardActivity = [[[NSBundle mainBundle] loadNibNamed:@"ActivityDashboard" owner:self options:nil] lastObject];
    
    [self removeViewsIfAdded];
    [_containerView addSubview:_dashboardActivity];
    // [self setConstraints:_dashboardActivity];
    
    self.fillDefaultColors =[self indexKeyedDictionaryFromArray:activityArray];
    [_calendar removeFromSuperview];
    [self loadCalender];
    //[self setConstraints:_dashboardActivity];
    //[self setDataForActivityView];
}

-(void)loadFoodDashboard{
    _dashboardFood = [[[NSBundle mainBundle] loadNibNamed:@"FoodDashboard" owner:self options:nil] lastObject];
    
    [self removeViewsIfAdded];
    [_containerView addSubview:_dashboardFood];
    //[self setConstraints:_dashboardFood];
    
    self.fillDefaultColors =[self indexKeyedDictionaryFromArray:foodArray];
    [_calendar removeFromSuperview];
    
    [self loadCalender];
    //   [self setConstraints:_dashboardFood];
}

-(void)selectedDateView
{
     [_selectedDateView removeFromSuperview];
    
   _selectedDateView = [[[NSBundle mainBundle] loadNibNamed:@"CalenderSelectedDateSubview" owner:self options:nil] lastObject];
    
    [_selectedDateView removeFromSuperview];
    [_containerView addSubview:_selectedDateView];
    //[self setConstraints:_dashboardFood];
    
       [self setConstraints:_selectedDateView];
}


-(void) removeAllSubviews{
    [_dashboardActivity removeFromSuperview];
    [_dashboardFood removeFromSuperview];
    [_dashboardMedicine removeFromSuperview];
    [_selectedDateView removeFromSuperview];
  
}


-(void) removeViewsIfAdded{
    [_dashboardActivity removeFromSuperview];
    [_dashboardFood removeFromSuperview];
    [_dashboardMedicine removeFromSuperview];
    [_selectedDateView removeFromSuperview];

}


- (IBAction)segmentClickCalender:(id)sender {
    NSInteger selectedSegment = [sender selectedSegmentIndex];
    if (selectedSegment == 0) {
        [self loadActivityDashboard];
        self.strAddMoreView=@"Activity";
        
    }else if (selectedSegment == 1){
        [self loadMedicineDashboard];
        self.strAddMoreView=@"Medicine";
        
    }else if (selectedSegment == 2){
        [self loadFoodDashboard];
        self.strAddMoreView=@"Food";
        
    }
}
-(void)setConstraints:(UIView *)viewName{
    viewName.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];//300
    
    //NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeWidth multiplier:1 constant:400];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    // NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeHeight multiplier:1 constant:420];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]; //420
    
    //    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [_containerView addConstraints:@[leadingConstraint,topConstraint,widthConstraint,heightConstraint]];
    
    NSLog(@"ContainerView : %@ and %@ : %@",NSStringFromCGSize(_containerView.frame.size),viewName,NSStringFromCGSize(viewName.frame.size));
    
}

@end
