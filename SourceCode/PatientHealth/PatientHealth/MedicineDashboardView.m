//
//  medicineDashboard.m
//  dashboard1
//
//  Created by VM on 22/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "MedicineDashboardView.h"

@implementation MedicineDashboardView 

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recivingMethodOnListnerE:) name:@"MedicineNotification" object:nil];
    
    
    return context;
}

- (void)drawRect:(CGRect)rect {
    self.intTabCounter = 0;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
    self.medicineData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
  
    [self.medicineTableView reloadData];
    [self.medicineTableView registerNib:[UINib nibWithNibName:@"MedicineTableViewCell" bundle:nil] forCellReuseIdentifier:@"MedicineTableViewCell"];
    self.medicineTableView.dataSource=self;
    self.medicineTableView.delegate=self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    //    self.medicineTableView.delegate=self;
    //    self.medicineTableView.dataSource=self;
    if (self) {
//        [self setupView];
    }
    
    return self;
}

-(void)recivingMethodOnListnerE: (NSNotification*) n{
    
    indexDataMedicineCalender=[NSMutableArray new];
    
    for(int i=0; i<n.userInfo.count ; i++)
    {
        NSString *index=[NSString stringWithFormat:@"%d",i];
        [indexDataMedicineCalender addObject:[n.userInfo objectForKey:index]];
        
    }
    
    
    [self.medicineTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return cell.count;
    if ([indexDataMedicineCalender count]) {
        return [indexDataMedicineCalender count];
    }else{

    return [self.medicineData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MedicineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MedicineTableViewCell" forIndexPath:indexPath];
        cell.delegate = self;
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
    self.medicineData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    Medicine *medicine = [self.medicineData objectAtIndex:indexPath.row];
    if ([indexDataMedicineCalender count]) {
        
//        NSString *indexValue=indexDataActivityCalender[indexPath.row];
        NSString *indexValue=indexDataMedicineCalender[indexPath.row];
        
        int aValue = [[indexValue stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
        medicine = [self.medicineData objectAtIndex:aValue];
    
        
    }else{
    
    
    medicine = [self.medicineData objectAtIndex:indexPath.row];
    }
    cell.medicine = medicine;
    [cell.dosageNaturelbl setText:[NSString stringWithFormat:@"%@" ,[medicine valueForKey:@"dosagenature"]]];

    NSArray *dosageArray=([_medicineData valueForKey:@"dosage"]);
    
    [cell setDosage:dosageArray forMedicine:medicine forIndexPath:indexPath];
    
    return cell;
    
}

-(void)didPressedTabButtonOnCell:(MedicineTableViewCell *)cell tabButton:(UIButton *)button medicine:(Medicine*)medicine{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[cell tag] inSection:0];
    UIButton *tab = (UIButton *)button;
    tab.selected = !tab.selected;
    [tab setBackgroundImage:[UIImage imageNamed:@"Not-active.png"] forState:UIControlStateNormal];
    [tab setBackgroundImage:[UIImage imageNamed:@"Active-1.png"] forState:UIControlStateSelected];
    NSArray *dosagedataArray=([_medicineData valueForKey:@"dosage"]);
    NSString *dosagedata = [dosagedataArray objectAtIndex:indexPath.row];
    float dosagedatafloat =[dosagedata floatValue];
    _firsttabfselected = [NSNumber numberWithBool:tab.isSelected];
    // BOOL isSelected ;
   // _intTabCounter=0;
    if(self.firsttabfselected.boolValue == YES)
    {
        _intTabCounter++;
        [cell.consumedlbl setText:[NSString stringWithFormat:@"%d", _intTabCounter]];
        NSString *consumeddata = cell.consumedlbl.text ;
        float consumeddatafloat = [consumeddata floatValue];
        float percentage =(consumeddatafloat/dosagedatafloat)*100;
        [self fillPercentageInProgress:cell :percentage :cell.progressBarView];
       // isSelected = YES;
    }
    else{
        _intTabCounter--;
        [cell.consumedlbl setText:[NSString stringWithFormat:@"%d", _intTabCounter]];
        NSString *consumeddata = cell.consumedlbl.text;
        float consumeddatafloat = [consumeddata floatValue];
        float percentage =(consumeddatafloat/dosagedatafloat)*100;
        [self fillPercentageInProgress:cell :percentage :cell.progressBarView];
        //isSelected = NO;
    }
    NSString *strMedId = [medicine valueForKey:@"medID"];
   //[self.firsttabfselected boolValue];
    [self saveTabSelectedData:[tab tag]: strMedId : self.firsttabfselected.boolValue];
}

-(void)fillPercentageInProgress: (MedicineTableViewCell *)cell : (float ) percentage : (KNCirclePercentView *)progressBar{
    [cell.progressBarView drawCircleWithPercent:percentage duration:0 lineWidth:6 clockwise:YES lineCap:kCALineCapRound fillColor:[UIColor clearColor] strokeColor:[UIColor greenColor]animatedColors:nil];
    cell.progressBarView.percentLabel.font = [UIFont systemFontOfSize:12];
    cell.progressBarView.percentLabel.textColor = [UIColor whiteColor];
    [cell.progressBarView startAnimation];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
}

-(void)saveTabSelectedData:(NSInteger )tab : (NSString *)medID : (BOOL)isSelected{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(medID == %@)", medID];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    Medicine *medObj;
    if([fetchedArray count] > 0){
        medObj = [fetchedArray objectAtIndex:0];
    }else{
        NSLog(@"Cannot load data");
    }
    switch (tab) {
        case TAB0:
           //add in
            [medObj setValue:[NSNumber numberWithBool:isSelected] forKey:@"firstTabIfSelected"];
            break;
        case TAB1:
            [medObj setValue:[NSNumber numberWithBool:isSelected] forKey:@"secondTabIfSelected"];
            break;
        case TAB2:
            [medObj setValue:[NSNumber numberWithBool:isSelected] forKey:@"thirdTabIfSelected"];
            break;
        case TAB3:
            [medObj setValue:[NSNumber numberWithBool:isSelected] forKey:@"fourthTabIfSelected"];
            break;
        default:
            break;
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"data Saved");
    }

}
@end
