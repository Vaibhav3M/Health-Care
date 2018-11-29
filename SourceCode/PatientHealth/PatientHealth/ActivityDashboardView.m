//
//  ActivityDashboardView.m
//  PatientHealth
//
//  Created by VM on 8/24/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "ActivityDashboardView.h"
#import "Calender/CalenderViewController.h"


@implementation ActivityDashboardView

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recivingMethodOnListnerE:) name:@"ActivityNotification" object:nil];
    return context;
}



-(void)recivingMethodOnListnerE: (NSNotification*) n{
    
    indexDataActivityCalender=[NSMutableArray new];
        
    for(int i=0; i<n.userInfo.count ; i++)
    {
        NSString *index=[NSString stringWithFormat:@"%d",i];
        [indexDataActivityCalender addObject:[n.userInfo objectForKey:index]];

    }
    

    [self.activityProgressTableView reloadData];
}

- (void)drawRect:(CGRect)rect {
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Activity"];
    self.activityData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.activityProgressTableView reloadData];
    
    [self.activityProgressTableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"ActivityTableViewCell"];
    
    
    self.activityProgressTableView.dataSource=self;
    self.activityProgressTableView.delegate=self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityProgressTableView reloadData];
        
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return cell.count;
    
    
    if ([indexDataActivityCalender count]) {
        return [indexDataActivityCalender count];
    }else{
        
        return [self.activityData count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityTableViewCell" forIndexPath:indexPath];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Activity"];
    self.activityData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
     NSManagedObject *activity = [self.activityData objectAtIndex:indexPath.row];
    
    if ([indexDataActivityCalender count]) {
       
        NSString *indexValue=indexDataActivityCalender[indexPath.row];
        
        int aValue = [[indexValue stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
        activity = [self.activityData objectAtIndex:aValue];
    
    }else{
        
        activity = [self.activityData objectAtIndex:indexPath.row];
    }
        [cell.activitylbl setText:[NSString stringWithFormat:@"%@" ,[activity valueForKey:@"activity"]]];
        [cell.lblCurrentActivity setText:[NSString stringWithFormat:@"%@" ,[activity valueForKey:@"current"]]];
        [cell.lblTargetActivity setText:[NSString stringWithFormat:@"%@" ,[activity valueForKey:@"target"]]];
        [cell.sessionlbl setText:[NSString stringWithFormat:@"%@" ,[activity valueForKey:@"session"]]];
        
        
        NSArray*currentDataArray=[_activityData valueForKey:@"current"];
        NSString *currentdata = [currentDataArray objectAtIndex:indexPath.row];
        float currentdatafloat = [currentdata floatValue];
        //    CGFloat currentdatafloat = (CGFloat)[currentdata floatValue];
        // NSLog(@"float value is: %f", currentdatafloat);
        
        NSArray*targetdataArray=[_activityData valueForKey:@"target"];
        NSString *Targetdata = [targetdataArray objectAtIndex:indexPath.row];
        float Targetdatafloat = [Targetdata floatValue];
        //CGFloat Targetdatafloat = (CGFloat)[Targetdata floatValue];
        // NSLog(@"float value is: %f", Targetdatafloat);
        float progressBarPercentagefloat =(currentdatafloat/Targetdatafloat)*100;
        // NSLog(@"float value is: %f", progressBarPercentagefloat);
        
        cell.progressBarView.percentLabel.font = [UIFont systemFontOfSize:12];
        
        //[self.circleView startAnimation];
        [cell.progressBarView startAnimation];
        
        
        int i;
        if (indexPath.row%2==0) {
            i=0;
        }else
        {
            i=1;
        }
        
        
        switch (i)
        {
                //if(indexPath.row % 2 == 0)
                
            case 0:
                [cell.progressBarView drawCircleWithPercent:progressBarPercentagefloat duration:0 lineWidth:6 clockwise:YES lineCap:kCALineCapRound fillColor:[UIColor clearColor] strokeColor:[UIColor orangeColor]animatedColors:nil];
                cell.progressBarView.percentLabel.textColor = [UIColor orangeColor];
                break;
                
            case 1:
                [cell.progressBarView drawCircleWithPercent:progressBarPercentagefloat duration:0 lineWidth:6 clockwise:YES lineCap:kCALineCapRound fillColor:[UIColor clearColor] strokeColor:[UIColor blueColor]animatedColors:nil];
                cell.progressBarView.percentLabel.textColor = [UIColor blueColor];
                
                break;
        }
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self.activityProgressTableView reloadData];
    //
    //    });
    
    return cell;
    
    
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
