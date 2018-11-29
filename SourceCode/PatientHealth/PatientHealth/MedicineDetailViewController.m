//
//  MedicineDetailViewController.m
//  PatientHealth
//
//  Created by VM  on 02/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "MedicineDetailViewController.h"

@interface MedicineDetailViewController ()

@end

@implementation MedicineDetailViewController

{
    
    NSArray *fromdate;
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
@synthesize medicineNameTextField;
@synthesize medicineName;
@synthesize medicinedata;
@synthesize medicinedataedit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
    self.medicinedata = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [super viewDidLoad];
    [self initDatePicker:self.fromDateTextField];
    [self initDatePicker:self.endDateTextField];
    [self initDiseaseListPicker];
    [self initDosageListPicker];
        [self initDosageNatureListPicker];
    // Do any additional setup after loading the view.
    
    if (![_dateFromCalender isEqualToString:@""]) {
        [self.fromDateTextField setText:_dateFromCalender];
    }
    
    if (self.medicinedataedit) {
           //  medicineNameTextField.text = medicineName;
        [self.medicineNameTextField setText:[self.medicinedataedit valueForKey:@"medicinename"]];
            [self.fromDateTextField setText:[self.medicinedataedit valueForKey:@"fromdate"]];
            [self.endDateTextField setText:[self.medicinedataedit valueForKey:@"enddate"]];
            [self.dosageTextField setText:[self.medicinedataedit valueForKey:@"dosage"]];
            [self.diseaseNameTextField setText:[self.medicinedataedit valueForKey:@"diseasename"]];
            [self.dosageNatureTextField setText:[self.medicinedataedit valueForKey:@"dosagenature"]];
//        [self.versionTextField setText:[self.device valueForKey:@"version"]];
//        [self.companyTextField setText:[self.device valueForKey:@"company"]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];

    if(self.medicinedataedit){
        [self.medicinedataedit setValue:self.medicineNameTextField.text forKey:@"medicinename"];
        [self.medicinedataedit setValue:self.fromDateTextField.text forKey:@"fromdate"];
        [self.medicinedataedit setValue:self.endDateTextField.text forKey:@"enddate"];
        [self.medicinedataedit setValue:self.dosageTextField.text forKey:@"dosage"];
        [self.medicinedataedit setValue:self.diseaseNameTextField.text forKey:@"diseasename"];
        [self.medicinedataedit setValue:self.dosageNatureTextField.text forKey:@"dosagenature"];

    }
    else{
        NSManagedObject *newmedicine= [NSEntityDescription insertNewObjectForEntityForName:@"Medicine" inManagedObjectContext:context];
        [newmedicine setValue:self.medicineNameTextField.text forKey:@"medicinename"];
        [newmedicine setValue:self.fromDateTextField.text forKey:@"fromdate"];
        [newmedicine setValue:self.endDateTextField.text forKey:@"enddate"];
        [newmedicine setValue:self.dosageTextField.text forKey:@"dosage"];
        [newmedicine setValue:self.diseaseNameTextField.text forKey:@"diseasename"];
        [newmedicine setValue:self.dosageNatureTextField.text forKey:@"dosagenature"];
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
        NSMutableArray *medArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
        NSUInteger count = [medArray count];
        count++;
        NSNumber *medID = [NSNumber numberWithUnsignedInteger:count];
        [newmedicine setValue:medID forKey:@"medID"];
        // Create a new managed object
       
        
        [self createEvent:medID];

    }
       NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
       //[self performSelector:@selector(createEvent) withObject:nil afterDelay:0.4];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createEvent:(NSNumber*)medID{
    //predicate to fetch only last added record,to add single event for each medicine.
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(medID == %@)", medID];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
    [fetchRequest setPredicate:predicate];
    self.medicinedata = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    EKEventStore *Store = [EKEventStore new];
    [Store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy/MM/dd"];
        EKEvent *event = [EKEvent eventWithEventStore:Store];
        NSArray *dosageArray=[medicinedata valueForKey:@"medicinename"];
        NSString *dosagedata = dosageArray [0];
        event.title =dosagedata;
        NSLog(@"%@",dosagedata);
        NSArray*startdateArray=[medicinedata valueForKey:@"fromdate"];
        NSString * startdata = startdateArray[0];
        NSDate *startDate = [df dateFromString: startdata];
        event.startDate = startDate;//start
        NSLog(@"%@",startDate);
        NSArray *enddateArray=[medicinedata valueForKey:@"enddate"];
        NSString *enddata = enddateArray[0];
        NSDate *enddate = [df dateFromString: enddata];
        event.endDate = enddate;//end
        NSLog(@"%@",enddate);
        //event.allDay = YES;
        event.calendar = [Store defaultCalendarForNewEvents];
        NSError *err = nil;
        [Store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];//save the event id if you want to access this later
        self.savedEventId = event.eventIdentifier;
        if (err == noErr) {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Event Created!!"
                                          message:@"YAY!!"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
            [alert addAction:ok];
            // [alert release];
        }
        
    }];
    
    
    //    }
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)initDiseaseListPicker{
    self.diseasePicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"Sugar",@"HeadAche", @"Cold",@"Thyroid",@"HeartDisease",@"CalciumDeficiency",@"Jaundice",@"Malaria",@"ChickenPox",@"BloodCancer",@"NeuralDisease",nil];
    self.diseasePicker.dataSourceArrayForSimplePicker = array;
    self.diseasePicker.delegate = self;
    self.diseasePicker.tag = 1002;
    [self.diseaseNameTextField setInputView:self.diseasePicker];
}
-(void)initDosageListPicker{
    self.dosagePicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"1",@"2", @"3",@"4",nil];
    self.dosagePicker.dataSourceArrayForSimplePicker = array;
    self.dosagePicker.delegate = self;
    self.dosagePicker.tag = 1003;
    [self.dosageTextField setInputView:self.dosagePicker];
    if([self.dosageTextField.text  isEqual: @"Once a day"])
    {
        self.dosageTextField.text =@"1";
    }
    else if([ self.dosageTextField.text  isEqual: @"Twice daily"])
    {
        self.dosageTextField.text =@"2";
    }
    else if([ self.dosageTextField.text  isEqual: @"Thrice Daily"])
    {
        self.dosageTextField.text =@"3";
        
    }
    else if([ self.dosageTextField.text  isEqual: @"4 times a Day"])
    {
        self.dosageTextField.text =@"4";
        
    }
}
-(void)initDosageNatureListPicker{
    self.dosageNaturePicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"Monthly",@"Weekly", @"Daily",nil];
    self.dosageNaturePicker.dataSourceArrayForSimplePicker = array;
    self.dosageNaturePicker.delegate = self;
    self.dosageNaturePicker.tag = 1004;
    [self.dosageNatureTextField setInputView:self.dosageNaturePicker];
}

-(void)initDatePicker:(UITextField *)textField{
    CustomPicker *picker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_DATE)];
    picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    picker.dateFormat = @"yyyy/MM/dd";
    picker.delegate = self;
    [textField setInputView:picker];
    if(textField == self.fromDateTextField){
        self.fromDatePicker = picker;
        self.fromDatePicker.tag = 1001;
    }else{
        self.endDatePicker = picker;
        self.endDatePicker.tag = 99;
    }
}

-(void)didTapOnDoneOf:(CustomPicker *)picker{
    
    if(picker.tag == 1001){
        self.fromDateTextField.text = picker.selectedValue.text;
        [self.fromDateTextField resignFirstResponder];
    }else if (picker.tag == 99){
        self.endDateTextField.text = picker.selectedValue.text;
        [self.endDateTextField resignFirstResponder];
    }else if(picker.tag == 1002){
        self.diseaseNameTextField.text = picker.selectedValue.text;
        [self.diseaseNameTextField resignFirstResponder];
    }else if(picker.tag == 1003){
        self.dosageTextField.text = picker.selectedValue.text;
        [self.dosageTextField resignFirstResponder];
    }else if(picker.tag == 1004){
        self.dosageNatureTextField.text = picker.selectedValue.text;
        [self.dosageNatureTextField resignFirstResponder];
    }

}


@end
