//
//  medicineDashboard.h
//  dashboard1
//
//  Created by VM on 22/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCirclePercentView.h"
#import "MedicineTableViewCell.h"
#import "AppDelegate.h"
@import CoreData;

typedef NS_ENUM(NSInteger, Tablet){
    TAB0 = 0,
    TAB1,
    TAB2,
    TAB3
};

@interface MedicineDashboardView : UIView <UITableViewDataSource,UITableViewDelegate,MedicineTableViewCellProtocol>
{
  //  BOOL selected;
//    int i;
//    MedicineTableViewCell *cell1;
    
        
        NSMutableArray *indexDataMedicineCalender;
    
}


@property (nonatomic, retain) NSNumber * firsttabfselected;

@property (strong) NSMutableArray *medicineData;
@property (weak, nonatomic) IBOutlet UITableView *medicineTableView;
@property (nonatomic, strong) NSMutableArray *values;

@property (nonatomic) int intTabCounter;

//-(void)setupView;
//-(void) setDataForMedicineView;
//-(void) createProgressBar:(KNCirclePercentView *) currentProgressBar : (float) percentage : (UIColor *) textColor :(UIColor *) strokeColor;
//-(float) calculatePercentage:(NSString *) target :(UILabel *) label;
//-(void)tabpressed:(id)sender :(MedicineTableViewCell*)cell;
@end
