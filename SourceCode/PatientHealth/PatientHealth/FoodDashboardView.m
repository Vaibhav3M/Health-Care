//
//  FoodDashboardView.m
//  PatientHealth
//
//  Created by VM on 8/24/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "FoodDashboardView.h"
@implementation FoodDashboardView

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recivingMethodOnListnerE:) name:@"FoodNotification" object:nil];
    
    return context;
}

-(void)recivingMethodOnListnerE: (NSNotification*) n{
    
    indexDataFoodCalender=[NSMutableArray new];
    
    for(int i=0; i<n.userInfo.count ; i++)
    {
        NSString *index=[NSString stringWithFormat:@"%d",i];
        [indexDataFoodCalender addObject:[n.userInfo objectForKey:index]];
        
    }
    
    
    [self.foodProgressViewTableView reloadData];
}



- (void)drawRect:(CGRect)rect {
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Food"];
    self.foodData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.foodProgressViewTableView reloadData];
    
    [self.foodProgressViewTableView registerNib:[UINib nibWithNibName:@"FoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"FoodTableViewCell"];
    
    
    self.foodProgressViewTableView.dataSource=self;
    self.foodProgressViewTableView.delegate=self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.foodProgressViewTableView reloadData];
        
    });
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([indexDataFoodCalender count]) {
        NSInteger a=[indexDataFoodCalender count];
        return [indexDataFoodCalender count];
    }else{
        
        return [self.foodData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FoodTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"FoodTableViewCell" forIndexPath:indexPath];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Food"];
    self.foodData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    NSManagedObject *food = [self.foodData objectAtIndex:indexPath.row];
    if ([indexDataFoodCalender count]) {
        
        //        NSString *indexValue=indexDataActivityCalender[indexPath.row];
        NSString *indexValue=indexDataFoodCalender[indexPath.row];
        
        int aValue = [[indexValue stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
        food = [self.foodData objectAtIndex:aValue];
        
        
    }else{
        
        food = [self.foodData objectAtIndex:indexPath.row];
    }
    
    [cell2.foodlbl setText:[NSString stringWithFormat:@"%@" ,[food valueForKey:@"foodname"]]];
    
    [cell2.intakelbl setText:[NSString stringWithFormat:@"%@" ,[food valueForKey:@"input"]]];

            if([cell2.intakelbl.text  isEqual: @"Morning"])
                {
                   cell2.foodprogressimageview.image =[UIImage imageNamed:@"Breakfast.png"];
                }
                else if([cell2.intakelbl.text  isEqual: @"Noon"])
                {
                    cell2.foodprogressimageview.image =[UIImage imageNamed:@"Afternoon.png"];
    
                }
                else if([cell2.intakelbl.text  isEqual: @"Evening"])
                {
                    cell2.foodprogressimageview.image =[UIImage imageNamed:@"Afternoon.png"];
    
                }
                else if([cell2.intakelbl.text  isEqual: @"Night"])
                {
                   cell2.foodprogressimageview.image =[UIImage imageNamed:@"Night-complete.png"];
                    
                }
            

    
    
//    NSArray*currentDataArray=[_activityData valueForKey:@"current"];
//    NSString *currentdata = [currentDataArray objectAtIndex:indexPath.row];
//    float currentdatafloat = [currentdata floatValue];
//    //    CGFloat currentdatafloat = (CGFloat)[currentdata floatValue];
//    // NSLog(@"float value is: %f", currentdatafloat);
//    
//    NSArray*targetdataArray=[_activityData valueForKey:@"target"];
//    NSString *Targetdata = [targetdataArray objectAtIndex:indexPath.row];
//    float Targetdatafloat = [Targetdata floatValue];
//    //CGFloat Targetdatafloat = (CGFloat)[Targetdata floatValue];
//    // NSLog(@"float value is: %f", Targetdatafloat);
//    float progressBarPercentagefloat =(currentdatafloat/Targetdatafloat)*100;
//    // NSLog(@"float value is: %f", progressBarPercentagefloat);
//    
//    cell.progressBarView.percentLabel.font = [UIFont systemFontOfSize:12];
//    
//    //[self.circleView startAnimation];
//    [cell.progressBarView startAnimation];
//    
    
//    int i;
//    if (indexPath.row%2==0) {
//        i=0;
//    }else
//    {
//        i=1;
//    }
//    
//    
//    switch (i)
//    {
//            //if(indexPath.row % 2 == 0)
//            
//        case 0:
//            [cell.progressBarView drawCircleWithPercent:progressBarPercentagefloat duration:0 lineWidth:6 clockwise:YES lineCap:kCALineCapRound fillColor:[UIColor clearColor] strokeColor:[UIColor orangeColor]animatedColors:nil];
//            cell.progressBarView.percentLabel.textColor = [UIColor orangeColor];
//            break;
//            
//        case 1:
//            [cell.progressBarView drawCircleWithPercent:progressBarPercentagefloat duration:0 lineWidth:6 clockwise:YES lineCap:kCALineCapRound fillColor:[UIColor clearColor] strokeColor:[UIColor blueColor]animatedColors:nil];
//            cell.progressBarView.percentLabel.textColor = [UIColor blueColor];
//            
//            break;
//    }
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self.activityProgressTableView reloadData];
    //
    //    });
    
    return cell2;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
}



-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupView];
    }
    
    return self;
}

-(void) setupView{
    //[self setDataForActivityView];
}

//-(void) setDataForActivityView{
//    self.lblCurrentWeight.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentWeight"];
//    self.lblTargetWeight.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TargetWeight"];
//    self.lblCurrentRunning.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentRunning"];
//    self.lblTagetRunning.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TagetRunning"];
//    self.lblCurrentSteps.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSteps"];
//    self.lblTargetSteps.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TargetSteps"];
//}
@end
