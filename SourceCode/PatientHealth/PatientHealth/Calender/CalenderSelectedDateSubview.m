//
//  CalenderSelectedDateSubview.m
//  PatientHealth
//
//  Created by VM  on 09/12/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "CalenderSelectedDateSubview.h"
#import "MedicineDetailViewController.h"
#import "ActivityDetailViewController.h"
#import "FoodDetailViewController.h"
#import "SlideNavigationController.h"

@implementation CalenderSelectedDateSubview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)btnAdd:(id)sender {
    if ([_strSelectedType isEqualToString:@"Activity"]) {
        ActivityDetailViewController *addActivity =[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ActivityDetailViewController"];
        addActivity.dateFromCalender=_strselectedDate;
        [[SlideNavigationController sharedInstance]presentViewController:addActivity animated:YES completion:nil];
    }
    else if ([_strSelectedType isEqualToString:@"Medicine"])
    {
        MedicineDetailViewController *addMed =[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MedicineDetailViewController"];
        addMed.dateFromCalender=_strselectedDate;
        [[SlideNavigationController sharedInstance]presentViewController:addMed animated:YES completion:nil];
       
    }
    else if ([_strSelectedType isEqualToString:@"Food"])
    {
        FoodDetailViewController *addFood =[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"FoodDetailViewController"];
        addFood.dateFromCalender=_strselectedDate;
        [[SlideNavigationController sharedInstance]presentViewController:addFood animated:YES completion:nil];
    }
    
}
@end
