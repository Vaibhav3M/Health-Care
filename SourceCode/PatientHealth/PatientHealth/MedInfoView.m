//
//  MedInfoView.m
//  PatientHealth
//
//  Created by VM on 15/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "MedInfoView.h"

#import "RegisterViewController.h"

@implementation MedInfoView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
        if (self) {
        [self registerForKeyboardNotifications];
        //[self setupView];
    }
    return self;
}
- (NSManagedObjectContext *)managedObjectContext
{ NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    { context = [delegate managedObjectContext];
    }
    return context;
}


- (void)registerForKeyboardNotifications
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)setupView{
    self.pickerData = [[NSArray alloc]initWithObjects:@"Once a day",@"Twice daily",@"Thrice Daily",@"4 times a Day", nil];
//    self.dosePickerRow2.delegate = self;
//    self.dosePickerRow2.dataSource = self;
    
//    self.dosePicker.delegate = self;
//    self.dosePicker.dataSource = self;
    
//    [self.btnAdd addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    checked = YES;
    

   

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
    //return 4;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    return [self.pickerData objectAtIndex:row];
    //return @"test";
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
  return 120;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *retval = (UILabel*)view;
    if (!retval) {
        retval = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    retval.font = [UIFont systemFontOfSize:15];
    retval.textColor = [UIColor whiteColor];
    retval.text = [self.pickerData objectAtIndex:row];
    return retval;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (row) {
        case 0:
            NSLog(@"zero intdex selected");
            break;
        case 1:
            NSLog(@"One intdex selected");
            break;
        case 2:
            NSLog(@"Two intdex selected");
            break;
        case 3:
            NSLog(@"Three intdex selected");
            break;
        default:
            NSLog(@"None intdex selected");
            break;
    }
}


- (void)drawRect:(CGRect)rect {
    
    arrayData = [[NSMutableArray alloc]init];
    arrayToDelete = [[NSMutableArray alloc]init];

    [self initActivityListPicker];
    [self.medInfotableView registerNib:[UINib nibWithNibName:@"MedInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MedInfoTableViewCell"];
    
    
   self.medInfotableView.dataSource=self;
    self.medInfotableView.delegate=self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.medInfotableView reloadData];
        
    });
}
-(void)initActivityListPicker{
    self.dosagePicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"Once a day",@"Twice daily",@"Thrice Daily",@"4 times a Day",nil];
    self.dosagePicker.dataSourceArrayForSimplePicker = array;
    self.dosagePicker.delegate = self;
    self.dosagePicker.tag = 100;
    [self.dosageTxtField setInputView:self.dosagePicker];
    
}

-(void)didTapOnDoneOf:(CustomPicker *)picker{
    
    if(picker.tag == 100){
        
        self.dosageTxtField.text = picker.selectedValue.text;
        [self.dosageTxtField resignFirstResponder];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    self.medInfotableView.delegate = self;
    self.medInfotableView.dataSource = self;
    
    [self.medInfotableView registerNib:[UINib nibWithNibName:@"MedInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MedInfoTableViewCell"];
    //counter=0;
    
}

-(void)addTableView
{
    CGRect fr = CGRectMake(0,176,320,500);
    
    _medInfotableView = [[UITableView alloc] initWithFrame:fr style:
                         UITableViewStylePlain];
    _medInfotableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleWidth;
    _medInfotableView.separatorColor = [UIColor darkGrayColor];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView*) tableView{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrayData.count >0) {
        return arrayData.count;
    }
    return 0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MedInfoTableViewCell";
    
    MedInfoTableViewCell *cell = [_medInfotableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MedInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.lblMedName.text = [NSString stringWithFormat:@"%@",arrayData[indexPath.row]];
    cell.lbldosage.text = _dosageTxtField.text;
    if([self.dosageTxtField.text  isEqual: @"Once a day"])
    {
        cell.lbldosage.text =@"1";
    }
    else if([ self.dosageTxtField.text  isEqual: @"Twice daily"])
    {
        cell.lbldosage.text =@"2";
    }
    else if([ self.dosageTxtField.text  isEqual: @"Thrice Daily"])
    {
        cell.lbldosage.text =@"3";
        
    }
    else if([ self.dosageTxtField.text  isEqual: @"4 times a Day"])
    {
        cell.lbldosage.text =@"4";
        
    }
    
    
    [self setmedData];
    cell.tintColor = [UIColor redColor];
    return cell;
}

-(void)setmedData{
    //  static NSString *CellIdentifier = @"MedInfoTableViewCell";
    
    
    //MedInfoTableViewCell *cell = [_medInfotableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    //NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    Medicine* medicine;
    
    medicine = [NSEntityDescription
                insertNewObjectForEntityForName:@"Medicine"
                inManagedObjectContext:context];
    [medicine setValue:self.medicineNametxtfield.text forKey:@"medicinename"];
    [medicine setValue:self.dosageTxtField.text forKey:@"dosage"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [arrayToDelete addObject:arrayData[indexPath.row]];

}
- (void)tableView:(UITableView *)tableView didDeSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [arrayToDelete removeObject:arrayData[indexPath.row]];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3;

}



- (IBAction)btnAdd:(id)sender {
    [arrayData addObject:self.medicineNametxtfield.text];
    [self.medInfotableView reloadData];
    self.medicineNametxtfield.text = @"";
        if (_medInfotableView.hidden)
        _medInfotableView.hidden=NO;
    
   }

- (IBAction)btnRemove:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.medInfotableView setEditing:sender.selected animated:YES];
    if (arrayToDelete.count) {
        for (NSString *str in arrayToDelete) {
            [arrayData removeObject:str];
        }
        [arrayToDelete removeAllObjects];
        [self.medInfotableView reloadData];
    }
   }
@end
