//
//  FoodDetailViewController.m
//  PatientHealth
//
//  Created by VM  on 21/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "FoodDetailViewController.h"

@interface FoodDetailViewController ()

@end

@implementation FoodDetailViewController
@synthesize fooddataedit;

//{
//    NSArray *fromdate;
//}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Food"];
    self.fooddata = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [super viewDidLoad];
    [self initDatePicker:self.fromdatetextfield];
    [self initDatePicker:self.endDateTextField];
    [self initInputListPicker];
    [self initFoodNameListPicker];
    // Do any additional setup after loading the view.
    if (![_dateFromCalender isEqualToString:@""]) {
        [self.fromdatetextfield setText:_dateFromCalender];
    }
    
    if (self.fooddataedit) {
        //  medicineNameTextField.text = medicineName;
        [self.foodTypeTextField setText:[self.fooddataedit valueForKey:@"foodname"]];
        [self.fromdatetextfield setText:[self.fooddataedit valueForKey:@"startdate"]];
        [self.endDateTextField setText:[self.fooddataedit valueForKey:@"enddate"]];
        [self.intakeTextField setText:[self.fooddataedit valueForKey:@"input"]];
        [self.calorieCountTextField setText:[self.fooddataedit valueForKey:@"calories"]];
       
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
    if(self.fooddataedit){
        [self.fooddataedit setValue:self.foodTypeTextField.text forKey:@"foodname"];
        [self.fooddataedit setValue:self.fromdatetextfield.text forKey:@"startdate"];
        [self.fooddataedit setValue:self.endDateTextField.text forKey:@"enddate"];
        [self.fooddataedit setValue:self.intakeTextField.text forKey:@"input"];
        [self.fooddataedit setValue:self.calorieCountTextField.text forKey:@"calories"];
        
    }
    else{
        //    NSManagedObjectID *objectID = [managedObject objectID];
        //    NSManagedObject *copy = [context2 objectWithID:objectID];
       
        NSManagedObject *newfood= [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        // Create a new managed object
        [newfood setValue:self.foodTypeTextField.text forKey:@"foodname"];
        [newfood setValue:self.fromdatetextfield.text forKey:@"startdate"];
        [newfood setValue:self.endDateTextField.text forKey:@"enddate"];
        [newfood setValue:self.intakeTextField.text forKey:@"input"];
        [newfood setValue:self.calorieCountTextField.text forKey:@"calories"];

    }
    
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    //[self createEvent:medID];
    //[self performSelector:@selector(createEvent) withObject:nil afterDelay:0.4];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)initFoodNameListPicker{
    self.foodNamePicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"Salad",@"Biriyani", @"No Oil Food",nil];
    self.foodNamePicker.dataSourceArrayForSimplePicker = array;
    self.foodNamePicker.delegate = self;
    self.foodNamePicker.tag = 1004;
    [self.foodTypeTextField setInputView:self.foodNamePicker];
}
-(void)initInputListPicker{
    self.intakePicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"Morning",@"Noon", @"Evening",@"Night",nil];
    self.intakePicker.dataSourceArrayForSimplePicker = array;
    self.intakePicker.delegate = self;
    self.intakePicker.tag = 1005;
    [self.intakeTextField setInputView:self.intakePicker];
}

-(void)initDatePicker:(UITextField *)textField{
    CustomPicker *picker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_DATE)];
    picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    picker.dateFormat = @"yyyy/MM/dd";
    picker.delegate = self;
    [textField setInputView:picker];
    if(textField == self.fromdatetextfield){
        self.fromDatePicker = picker;
        self.fromDatePicker.tag = 1001;
    }else{
        self.endDatePicker = picker;
        self.endDatePicker.tag = 99;
    }
}

-(void)didTapOnDoneOf:(CustomPicker *)picker{
    
    if(picker.tag == 1001){
        self.fromdatetextfield.text = picker.selectedValue.text;
        [self.fromdatetextfield resignFirstResponder];
    }else if (picker.tag == 99){
        self.endDateTextField.text = picker.selectedValue.text;
        [self.endDateTextField resignFirstResponder];
    }else if(picker.tag == 1004){
        self.foodTypeTextField.text = picker.selectedValue.text;
        [self.foodTypeTextField resignFirstResponder];
    }else if(picker.tag == 1005){
        self.intakeTextField.text = picker.selectedValue.text;
        [self.intakeTextField resignFirstResponder];
        
    
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
