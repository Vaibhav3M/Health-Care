//
//  ActivityDetailViewController.m
//  PatientHealth
//
//  Created by VM  on 24/10/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController
@synthesize activitydataedit;


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

- (void)viewDidLoad
{
    [_targetTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
  [_currentTextField addTarget:self action:@selector(textFieldDidChange1:) forControlEvents:UIControlEventEditingChanged];
    [super viewDidLoad];
    [self initDatePicker:self.startDateTextField];
    [self initDatePicker:self.endDateTextField];
    [self initActivityListPicker];
    [self initActivityNatureListPicker];
    
    if (![_dateFromCalender isEqualToString:@""]) {
        [self.startDateTextField setText:_dateFromCalender];
    }
    
    if (self.activitydataedit) {
        //  medicineNameTextField.text = medicineName;
        [self.activityTextField setText:[self.activitydataedit valueForKey:@"activity"]];
        [self.targetTextField setText:[self.activitydataedit valueForKey:@"target"]];
        [self.currentTextField setText:[self.activitydataedit valueForKey:@"current"]];
        [self.sessionTextField setText:[self.activitydataedit valueForKey:@"session"]];
        [self.startDateTextField setText:[self.activitydataedit valueForKey:@"startDate"]];
        [self.endDateTextField setText:[self.activitydataedit valueForKey:@"endDate"]];
        //        [self.versionTextField setText:[self.device valueForKey:@"version"]];
        //        [self.companyTextField setText:[self.device valueForKey:@"company"]];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    

    if(self.activitydataedit){
        [self.activitydataedit setValue:self.activityTextField.text forKey:@"activity"];
        [self.activitydataedit setValue:self.targetTextField.text forKey:@"target"];
        [self.activitydataedit setValue:self.currentTextField.text forKey:@"current"];
        [self.activitydataedit setValue:self.sessionTextField.text forKey:@"session"];
        [self.activitydataedit setValue:self.startDateTextField.text forKey:@"startDate"];
        [self.activitydataedit setValue:self.endDateTextField.text forKey:@"endDate"];
        
    }
    else{
       // Create a new managed object
    NSManagedObject *newActivity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:context];
    [newActivity setValue:self.activityTextField.text forKey:@"activity"];
    [newActivity setValue:self.targetTextField.text forKey:@"target"];
    [newActivity setValue:self.currentTextField.text forKey:@"current"];
        [newActivity setValue:self.sessionTextField.text forKey:@"session"];
    [newActivity setValue:self.startDateTextField.text forKey:@"startDate"];
    [newActivity setValue:self.endDateTextField.text forKey:@"endDate"];
    }
   
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)initActivityListPicker{
    self.activityPicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"Running",@"Walking", @"Swimming",@"Cross Training",@"Jogging",@"Trekking",@"Dance",@"Cricket",@"Boxing",@"Hockey",@"Jump Rope",nil];
    self.activityPicker.dataSourceArrayForSimplePicker = array;
    self.activityPicker.delegate = self;
    self.activityPicker.tag = 1002;
    [self.activityTextField setInputView:self.activityPicker];
  
}
-(void)initActivityNatureListPicker{
    self.activitySessionPicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"Monthly",@"Daily", @"Weekly",nil];
    self.activitySessionPicker.dataSourceArrayForSimplePicker = array;
    self.activitySessionPicker.delegate = self;
    self.activitySessionPicker.tag = 1003;
    [self.sessionTextField setInputView:self.activitySessionPicker];
}

-(void)initDatePicker:(UITextField *)textField{
    CustomPicker *picker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_DATE)];
    picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    picker.dateFormat = @"yyyy/MM/dd";
    picker.delegate = self;
    [textField setInputView:picker];
    if(textField == self.startDateTextField){
        self.startDatePicker = picker;
        self.startDatePicker.tag = 1001;
    }else{
        self.endDatePicker = picker;
        self.endDatePicker.tag = 99;
    }
}

-(void)didTapOnDoneOf:(CustomPicker *)picker{
    
    if(picker.tag == 1001){
        self.startDateTextField.text = picker.selectedValue.text;
        [self.startDateTextField resignFirstResponder];
    }else if (picker.tag == 99){
        self.endDateTextField.text = picker.selectedValue.text;
        [self.endDateTextField resignFirstResponder];
    }else if(picker.tag == 1002){
        self.activityTextField.text = picker.selectedValue.text;
        [self.activityTextField resignFirstResponder];
         }else if(picker.tag == 1003){
        self.sessionTextField.text = picker.selectedValue.text;
        [self.sessionTextField resignFirstResponder];
    }
}


-(void)textFieldDidChange :(UITextField *) textField{
    if([self.activityTextField.text  isEqual: @"Running"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Km "];
        _targetTextField.text = string;
      
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Walking"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Km "];
        _targetTextField.text = string;
                //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }

    else if([self.activityTextField.text  isEqual: @"Swimming"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Hrs "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Cross Training"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Hrs "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Jogging"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Hrs "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Trekking"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Km "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
  
    else if([self.activityTextField.text  isEqual: @"Dance"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Hrs "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Cricket"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Hrs "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Boxing"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Hrs "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Hockey"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Hrs "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Jump Rope"])
    {
        NSString *string = [_targetTextField.text stringByAppendingString:@"Counts "];
        _targetTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }

}
-(void)textFieldDidChange1 :(UITextField *) textField{
    if([self.activityTextField.text  isEqual: @"Running"])
    {
                NSString *string1 = [_currentTextField.text stringByAppendingString:@"Km "];
        _currentTextField.text = string1;
        
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Walking"])
    {
               NSString *string1 = [_currentTextField.text stringByAppendingString:@"Km "];
        _currentTextField.text = string1;
        
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Swimming"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Hrs "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Cross Training"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Hrs "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Jogging"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Hrs "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Trekking"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Km "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
       else if([self.activityTextField.text  isEqual: @"Dance"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Hrs "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Cricket"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Hrs "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Boxing"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Hrs "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Hockey"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Hrs "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }
    else if([self.activityTextField.text  isEqual: @"Jump Rope"])
    {
        NSString *string = [_currentTextField.text stringByAppendingString:@"Counts "];
        _currentTextField.text = string;
        //self.targetTextField.text=[NSString stringWithFormat:@"%@ Km",_targetTextField.text];
    }


}
@end
