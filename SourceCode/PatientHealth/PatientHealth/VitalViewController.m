//
//  VitalViewController.m
//  dashboard1
//
//  Created by VM on 24/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "VitalViewController.h"

@interface VitalViewController (){
    //dicitionary to load data
    NSDictionary *vitalDictionary;
    NSArray *vitalSectionHeader;
}
@property(nonatomic,assign) NSInteger id;
//-(void)pulseUpdate;
@end

@implementation VitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Vitals";
    [self setUpView];
    [self populateDictionary];
}

/**
 populate tableview data
 */
-(void)populateDictionary{
    vitalDictionary = @{@"Blood Pressure":@[@"Systolic(mmHg)",@"Diastolic(mmHg)"],@"Blood Sugar":@[@"Fasting(mg/dL)",@"Random(mg/dL)",@"After Meal(mg/dL)"],@"Pulse":@[@"Pulse(bph)"],@"Weight":@[@"Weight(kg)"],@"Cholestrol" :@[@"LDL(mg/dL)",@"HDL(mg/dL)",@"TDL(mg/dL)"]};
    vitalSectionHeader = [[vitalDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

#pragma mark
/**
 Tablview methods
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [vitalSectionHeader count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger returnCount = 0;
    NSString *sectionTitle = [vitalSectionHeader objectAtIndex:section];
    NSArray *sectionVitals = [vitalDictionary objectForKey:sectionTitle];
    if ([[self.arrayForBool objectAtIndex:section] boolValue]) {
        returnCount = [sectionVitals count];
    }else{
        returnCount= 0;
    }
    
    return returnCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VitalChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VitalChildTableViewCell" forIndexPath:indexPath];
    NSString *sectionTitle = [vitalSectionHeader objectAtIndex:indexPath.section];
    NSArray *sectionArray = [vitalDictionary objectForKey:sectionTitle];
    NSString *rowTitle = [sectionArray objectAtIndex:indexPath.row];
    cell.txtVal0.placeholder = rowTitle;
    NSInteger rowCount = [self.tblView numberOfRowsInSection:[indexPath section]];
    if(indexPath.row == rowCount-1){
        [cell.btnSave setHidden:NO];
        [cell.btnReport setHidden:NO];
    }else{
        [cell.btnSave setHidden:YES];
       [cell.btnReport setHidden:YES];
    }
    [cell.txtVal0.layer setValue:indexPath forKey:@"indexPath"];
    [cell.btnSave.layer setValue:indexPath forKey:@"indexPath"];
    [cell.btnReport.layer setValue:indexPath forKey:@"indexPath"];
//    [cell.btnModify.layer setValue:indexPath forKey:@"indexPath"];
    [self setCellData:cell :indexPath];
    cell.delegate = self;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [vitalSectionHeader objectAtIndex:section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    VitalSectionTableViewCell *sectionCell = [tableView dequeueReusableCellWithIdentifier:@"VitalSectionTableViewCell"];
    sectionCell.delegate = self;
    NSString *string =[vitalSectionHeader objectAtIndex:section];
    sectionCell.lblSectionHeader.text = string;
    sectionCell.btnSectionHeaderAdd.tag = section;
    
    sectionCell.tag                  = section;
    //    UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20-50, 50)];
    BOOL manyCells                  = [[self.arrayForBool objectAtIndex:section] boolValue];
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionCell addGestureRecognizer:headerTapped];
    
    //up or down arrow depending on the bool
    if(manyCells){
        [sectionCell.imgArrow setImage:[UIImage imageNamed:@"upArrow"]];
    }
    else{
        [sectionCell.imgArrow setImage:[UIImage imageNamed:@"downArrow"]];
    }
    //    [sectionCell.btnSectionHeaderAdd setHidden:!manyCells];
    return sectionCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(void)setObservers{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pulseUpdate:) name:@"PulseNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bpUpdate:) name:@"BPNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bloodGlucoseUpdate:) name:@"BloodGlucoseNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weightUpdate:) name:@"WeightNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cholestrolUpdate:) name:@"CholestrolNotification" object:nil];
}


//-(void)pulseUpdate:(NSNotification*)notification{
//    [self setPulseData];
//}

//-(void)bpUpdate:(NSNotification*)notification{
//    //[self setBPData];
//}

//-(void)bloodGlucoseUpdate:(NSNotification*)notification{
//    [self setBloodGlucoseData];
//}

//-(void)weightUpdate:(NSNotification*)notification{
//    [self setWeightData];
//}

//-(void)cholestrolUpdate:(NSNotification*)notification{
//    [self setCholestrolData];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setPulseData];
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

-(void)setPulseData{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"PulseReport"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    NSInteger count = [results count];
    if(count > 0){
        PulseReport *pulseReport = [results objectAtIndex: count-1];
        NSString *pulseString = [NSString stringWithFormat:@"%@ %@" ,[pulseReport valueForKey:@"pulse"],[pulseReport valueForKey:@"unit"]];
        NSString *dateString = [NSString stringWithFormat:@"%@",[pulseReport valueForKey:@"date"]];
        
        self.lblPulse.text = [NSString stringWithFormat:@"%@ %@ %@ %@", @"Reading : ",pulseString, @" Added on : ",dateString ];
    }
    else{
        self.lblPulse.text = [NSString stringWithFormat:@"%@",@"No Data Recorded"];
    }
}

//-(void)setWeightData{
//    
//}

//-(void)setCholestrolData{
//    
//}

//-(void)setBloodGlucoseData{
//    
//}

-(NSMutableString *)concatButtonTitle:(NSString *)titleString :(NSString *)valueString :(NSString *)strUnit{
    NSMutableString *aMutStr = [[NSMutableString alloc] init];
    NSString *newLineCharacter = @" \n ";
    [aMutStr setString:titleString];
    [aMutStr appendString:newLineCharacter];
    [aMutStr appendString:valueString];
    [aMutStr appendString:strUnit];
    return aMutStr;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setUpView{
    [self.tblView registerNib:[UINib nibWithNibName:@"VitalChildTableViewCell" bundle:nil] forCellReuseIdentifier:@"VitalChildTableViewCell"];
    [self.tblView registerNib:[UINib nibWithNibName:@"VitalSectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"VitalSectionTableViewCell"];
    self.arrayForBool = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO],
                         [NSNumber numberWithBool:NO],
                         [NSNumber numberWithBool:NO],
                         [NSNumber numberWithBool:NO],
                         [NSNumber numberWithBool:NO] , nil];
    SEL selector = @selector(backAction);
    [[Utilities sharedInstance] setCustomBackButton:self withSelector:selector];
}

-(void)setCellData:(VitalChildTableViewCell*)cell : (NSIndexPath*)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case 0:{
            //            BP
            BPReport *bpReport = [[Utilities sharedInstance]fetchData:BpEntity];
            NSInteger rowCount = [self.tblView numberOfRowsInSection:[indexPath section]];
            for(int i = 0;i < rowCount;i++){
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow: i inSection: indexPath.section];
//                VitalChildTableViewCell *currCell = [self.tblView cellForRowAtIndexPath:indexpath];
            if(bpReport != nil){
                if(indexPath.row == 0){
                    //                systolic
                    NSString *systolic = [NSString stringWithFormat:@"%@",[bpReport valueForKey:@"systolic"]];
                    cell.txtVal0.text = systolic;
                }else if(indexPath.row ==1){
                    //                diastolic
                    NSString *dystolic = [NSString stringWithFormat:@"%@",[bpReport valueForKey:@"diastolic"]];
                    cell.txtVal0.text = dystolic;
                }
             }
         }
        }
            break;
        case 1:{
            //            blood sugar
            BloodSugarReport *bloodSugarReport = [[Utilities sharedInstance]fetchData:BloodSugarEntity];
            NSInteger rowCount = [self.tblView numberOfRowsInSection:[indexPath section]];
            for(int i = 0;i < rowCount;i++){
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow: i inSection: indexPath.section];
//                VitalChildTableViewCell *currCell = [self.tblView cellForRowAtIndexPath:indexpath];
            if(bloodSugarReport != nil){
                if(row == 0){
                    //                fasting
                    cell.txtVal0.text = [NSString stringWithFormat:@"%@",[bloodSugarReport valueForKey:@"fasting"]];
                }else if(row == 1){
                    //                random
                    cell.txtVal0.text = [NSString stringWithFormat:@"%@",[bloodSugarReport valueForKey:@"random"]];
                }else if(row == 2){
                    //                Aftermeal
                    cell.txtVal0.text = [NSString stringWithFormat:@"%@",[bloodSugarReport valueForKey:@"afterMeal"]];
                }
            }else{
                cell.txtVal0.text = @"";
            }
            }
        }
            break;
        case 2:{
            //            CholestrolReport
            CholestrolReport *cholestrolReport = [[Utilities sharedInstance] fetchData:CholestrolEntity];
            NSInteger rowCount = [self.tblView numberOfRowsInSection:[indexPath section]];
            for(int i = 0;i < rowCount;i++){
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow: i inSection: indexPath.section];
//                VitalChildTableViewCell *currCell = [self.tblView cellForRowAtIndexPath:indexpath];
            if(cholestrolReport != nil){
                if(row == 0){
                    //                LDL
                    cell.txtVal0.text = [NSString stringWithFormat:@"%@",[cholestrolReport valueForKey:@"ldl"]];
                }else if(row == 1){
                    //               HDL
                    cell.txtVal0.text = [NSString stringWithFormat:@"%@",[cholestrolReport valueForKey:@"hdl"]];
                }else if(row == 2){
                    //                TDL
                    cell.txtVal0.text = [NSString stringWithFormat:@"%@",[cholestrolReport valueForKey:@"tdl"]];
                }
            }
            }
        }
            break;
        case 3:{
            //Pulse
            PulseReport *pulseReport = [[Utilities sharedInstance] fetchData:PulseEntity];
            if(pulseReport != nil){
                if(row==0){
                    //pulse
                    cell.txtVal0.text = [NSString stringWithFormat:@"%@",[pulseReport valueForKey:@"pulse"]];
                }
            }
        }
            break;
        case 4:{
            //Weight
            WeightReport *weightReport = [[Utilities sharedInstance] fetchData:WeightEntity];
            if(weightReport != nil){
                if(row==0){
                    cell.txtVal0.text = [NSString stringWithFormat:@"%@",[weightReport valueForKey:@"weight"]];
                }
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - gesture tapped
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[self.arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        NSInteger section = indexPath.section;
        if([self.arrayForBool count] > 0 && [self.arrayForBool count] > indexPath.row){
            
            [self.arrayForBool replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:collapsed]];
            
            //reload specific section animated
            [self.tblView reloadData];
        }
    }
}

#pragma mark - show report screen
-(void)showReportScreen:(VitalChildTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *reportViewController = [storyboard instantiateViewControllerWithIdentifier:@"ReportViewController"];
    [[SlideNavigationController sharedInstance]pushViewController:reportViewController animated:YES];
    int section = indexPath.section;
    NSString* strSection = [NSString stringWithFormat:@"%i", section];
    [[NSUserDefaults standardUserDefaults] setValue:strSection forKey:@"SelectedVital"];
//    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"It's hitting log");
}

#pragma mark - save data to coredata
-(void)saveDataToCoreData:(VitalChildTableViewCell *)cell textField:(UITextField *)valToSave indexPath:(NSIndexPath *)indexPath{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    switch (indexPath.section) {
        case 0:{
            NSInteger rowCount = [self.tblView numberOfRowsInSection:[indexPath section]];
            NSNumber *systolic,*diastolic;
            for (int i =0; i < rowCount; i++){
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow: i inSection: indexPath.section];
                VitalChildTableViewCell *currCell = [self.tblView cellForRowAtIndexPath:indexpath];
            if(i == 0){
                systolic =  @([currCell.txtVal0.text floatValue]);
            }else if(i == 1){
                diastolic = @([currCell.txtVal0.text floatValue]);
            }
            if(systolic !=nil && diastolic!=nil){
                [self saveBPData:systolic :diastolic :context];
            }
            }
        }
            break;
        case 1:{
            NSInteger rowCount = [self.tblView numberOfRowsInSection:[indexPath section]];
            NSString *fasting,*random,*aftermeal;
            
            for (int i =0; i < rowCount; i++){
            
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow: i inSection: indexPath.section];
                VitalChildTableViewCell *currCell = [self.tblView cellForRowAtIndexPath:indexpath];
                if(i == 0){
                    fasting =  currCell.txtVal0.text;
                }else if(i == 1){
                    random = currCell.txtVal0.text;
                }else if (i==2){
                    aftermeal = currCell.txtVal0.text;
                }
                
                if(fasting !=nil && random != nil && aftermeal !=nil){
                    [self saveBloodGlucoseData:fasting :aftermeal :random :context];
                }
            }
        }
            break;
        case 2:{
            NSInteger rowCount = [self.tblView numberOfRowsInSection:[indexPath section]];
            NSNumber *ldl,*hdl,*tdl;
            for (int i =0; i < rowCount; i++){
                
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow: i inSection: indexPath.section];
                VitalChildTableViewCell *currCell = [self.tblView cellForRowAtIndexPath:indexpath];
                if(i == 0){
                    ldl =  @([currCell.txtVal0.text floatValue]);
                }else if(i == 1){
                    hdl = @([currCell.txtVal0.text floatValue]);
                }else if (i==2){
                    tdl = @([currCell.txtVal0.text floatValue]);
                }
                
                if(hdl !=nil && ldl != nil && tdl !=nil){
                    [self saveCholestrolData:ldl :hdl :tdl :context];
                }
            }
        }
            break;
        case 3:{
            NSString *pulse;
            pulse = cell.txtVal0.text;
            if(pulse !=nil){
                [self savePulseData:pulse :context];
            }
        }
            break;
        case 4:{
            NSNumber *weight;
            weight = @([cell.txtVal0.text floatValue]);
            if(weight !=nil){
                [self saveWeightData:weight :context];
            }
        }
            break;
        default:
            break;
    }
    
    
}

-(NSString *)getTodayDate{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    return dateString;
}

-(void)saveBPData:(NSNumber*) systolic : (NSNumber*) diastolic : (NSManagedObjectContext*)context{
    BPReport *bpReport;
    bpReport = [NSEntityDescription
                insertNewObjectForEntityForName:@"BPReport"
                inManagedObjectContext:context];
    [bpReport setValue:@"mmHg" forKey:@"unit"];
    [bpReport setValue:[self getTodayDate] forKey:@"date"];
//    NSNumber *someVal = @80;
    [bpReport setValue:systolic forKey:@"systolic"];
    [bpReport setValue:diastolic forKey:@"diastolic"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"data Saved");
    }
}

-(void)saveBloodGlucoseData:(NSString*) fasting : (NSString*) aftermeal :(NSString*) random :(NSManagedObjectContext*)context{
    BloodSugarReport *bloodReport;
    bloodReport = [NSEntityDescription
                insertNewObjectForEntityForName:@"BloodSugarReport"
                inManagedObjectContext:context];
    [bloodReport setValue:@"mg/dL" forKey:@"unit"];
    [bloodReport setValue:[self getTodayDate] forKey:@"date"];
    //    NSNumber *someVal = @80;
    [bloodReport setValue:fasting forKey:@"fasting"];
    [bloodReport setValue:aftermeal forKey:@"afterMeal"];
    [bloodReport setValue:random forKey:@"random"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"data Saved");
    }

}

-(void)saveCholestrolData:(NSNumber*) ldl : (NSNumber*) hdl :(NSNumber*) tdl :(NSManagedObjectContext*)context{
    CholestrolReport *cholestrolReport;
    cholestrolReport = [NSEntityDescription
                   insertNewObjectForEntityForName:@"CholestrolReport"
                   inManagedObjectContext:context];
    [cholestrolReport setValue:@"mg/dL" forKey:@"unit"];
    [cholestrolReport setValue:[self getTodayDate] forKey:@"date"];
    //    NSNumber *someVal = @80;
    [cholestrolReport setValue:ldl forKey:@"ldl"];
    [cholestrolReport setValue:hdl forKey:@"hdl"];
    [cholestrolReport setValue:tdl forKey:@"tdl"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"data Saved");
    }
}
    
-(void)savePulseData:(NSString*) pulse : (NSManagedObjectContext*) context{
    PulseReport *pulseReport;
    pulseReport = [NSEntityDescription
                   insertNewObjectForEntityForName:@"PulseReport"
                   inManagedObjectContext:context];
    [pulseReport setValue:@"bph" forKey:@"unit"];
    [pulseReport setValue:[self getTodayDate] forKey:@"date"];
    //    NSNumber *someVal = @80;
    [pulseReport setValue:pulse forKey:@"pulse"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"data Saved");
    }

}

-(void)saveWeightData:(NSNumber*) pulse : (NSManagedObjectContext*) context{
    WeightReport *weightReport;
    weightReport = [NSEntityDescription
                   insertNewObjectForEntityForName:@"WeightReport"
                   inManagedObjectContext:context];
    [weightReport setValue:@"kg" forKey:@"unit"];
    [weightReport setValue:[self getTodayDate] forKey:@"date"];
    //    NSNumber *someVal = @80;
    [weightReport setValue:pulse forKey:@"weight"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"data Saved");
    }
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
