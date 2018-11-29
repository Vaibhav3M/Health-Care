//
//  AddActivityViewController.m
//  PatientHealth
//
//  Created by VM on 9/1/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "AddActivityViewController.h"
#import "AddActivityTableViewCell.h"

@interface AddActivityViewController ()<CustomViewDelegateProtocol>

@end

@implementation AddActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tblView registerNib:[UINib nibWithNibName:@"AddActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddActivityTableViewCell"];
    self.navigationController.navigationItem.title = self.data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddActivityTableViewCell"];
    cell.delegate= self;
    NSInteger row = indexPath.row;
    self.lblControllerTitle.text = self.data;
    if([self.data  isEqualToString:@"Activity"]){
        [self createCellToAddActivity:cell:row];
    }else if([self.data isEqualToString:@"Medicine"]){
        [self createCellToAddMedication:cell:row];
    }else if([self.data isEqualToString:@"Food"]){
        [self createCellToAddFood:cell:row];
    }else{
        NSLog(@"Value not set");
    }
    cell.txtValue.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    
    NSLog(@"didSelectRowAtIndexPath : %@" ,[NSString stringWithFormat:@"%ld", indexPath.row]);
   switch (indexPath.row)
    {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
      }
}

-(void)customTextFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Tag for textfield : %@" ,[NSString stringWithFormat:@"%ld", (long)textField.tag]);
    NSLog(@"Data from textfield : %@", [NSString stringWithFormat:@"%@", textField.text]);
    [self setUserValues:textField];
}

-(void)setUserValues:(UITextView *) textField{
    NSInteger textFieldIndex = textField.tag;
    switch (textFieldIndex) {
        case 1:
            //currwt
            self.strCurrWeight = textField.text;
            break;
        case 2:
            self.strTargetWeight = textField.text;
            //targetrwt
            break;
        case 4:
            //currun
            self.strCurrRunning = textField.text;
            break;
        case 5:
            //            targetRun
            self.strTargetRunning = textField.text;
            break;
        case 7:
            //            currSteps
            self.strCurrSteps = textField.text;
            break;
        case 8:
            //            targetSteps
            self.strTargetSteps = textField.text;
        default:
            break;
    }
    if([self.data  isEqualToString:@"Activity"]){
       [self setActivityDataDefaultValues];
    }else if([self.data isEqualToString:@"Medicine"]){
        [self setMedicineValues];
    }else if([self.data isEqualToString:@"Food"]){
        
    }else{
        NSLog(@"Value not set");
    }
}

-(void)setActivityDataDefaultValues{
    [[NSUserDefaults standardUserDefaults] setObject:self.strCurrWeight forKey:@"CurrentWeight"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strTargetWeight forKey:@"TargetWeight"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strCurrRunning forKey:@"CurrentRunning"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strTargetRunning forKey:@"TagetRunning"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strCurrSteps forKey:@"CurrentSteps"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strTargetSteps forKey:@"TargetSteps"];
}

-(void)setMedicineValues{
    [[NSUserDefaults standardUserDefaults] setObject:self.strCurrWeight forKey:@"MorningConsumed"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strTargetWeight forKey:@"MorningTarget"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strCurrRunning forKey:@"AfterNoonConsumed"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strTargetRunning forKey:@"AfternoonTarget"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strCurrSteps forKey:@"EveningConsumed"];
    [[NSUserDefaults standardUserDefaults] setObject:self.strTargetSteps forKey:@"EveningTarget"];
}

-(void)setCustomCellLabel:(UILabel*)lblTitle :(UIColor*)textColor :(UIColor*)backgroundColor{
    lblTitle.backgroundColor = backgroundColor;
    lblTitle.textColor = textColor;
}

- (IBAction)onAddButtonClick:(id)sender {

}

-(void)createCellToAddActivity:(AddActivityTableViewCell*)cell :(NSInteger)row {
    switch (row) {
        case 0:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle:SECTION_TEXT_COLOR:SECTION_BG_COLOR];
            cell.lblTitle.text = @"LOOSE WEIGHT";
            [cell.txtValue setHidden:YES];
            break;
        case 1:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Current Weight";
            break;
        case 2:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Target Weight";
            break;
        case 3:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle :SECTION_TEXT_COLOR :SECTION_BG_COLOR];
            cell.lblTitle.text = @"RUNNING";
            [cell.txtValue setHidden:YES];
            break;
        case 4:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Current Running";
            break;
        case 5:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Target Weight";
            break;
        case 6:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle :SECTION_TEXT_COLOR :SECTION_BG_COLOR];
            cell.lblTitle.text = @"STEPS";
            [cell.txtValue setHidden:YES];
            break;
        case 7:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Current Steps In A Day";
            break;
        case 8:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Target Steps In A Day";
            break;
        default:
            break;
    }
    
}

-(void)createCellToAddMedication:(AddActivityTableViewCell*)cell :(NSInteger)row{
    switch (row) {
        case 0:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle:SECTION_TEXT_COLOR:SECTION_BG_COLOR];
            cell.lblTitle.text = @"MORNING DOSAGE";
            [cell.txtValue setHidden:YES];
            break;
        case 1:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Dosage Taken";
            break;
        case 2:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Target Dosage";
            break;
        case 3:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle :SECTION_TEXT_COLOR :SECTION_BG_COLOR];
            cell.lblTitle.text = @"AFTERNOON DOSAGE";
            [cell.txtValue setHidden:YES];
            break;
        case 4:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Dosage Taken";
            break;
        case 5:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Target Dosage";
            break;
        case 6:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle :SECTION_TEXT_COLOR :SECTION_BG_COLOR];
            cell.lblTitle.text = @"EVENING DOSAGE";
            [cell.txtValue setHidden:YES];
            break;
        case 7:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Dosage Taken";
            break;
        case 8:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Target Dosage";
            break;
        default:
            break;
    }
}

-(void)createCellToAddFood:(AddActivityTableViewCell*)cell :(NSInteger)row{
    switch (row) {
        case 0:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle:SECTION_TEXT_COLOR:SECTION_BG_COLOR];
            cell.lblTitle.text = @"BREAKFAST";
            [cell.txtValue setHidden:YES];
            break;
        case 1:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Actual Diet";
            break;
        case 2:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Proposed Diet";
            break;
        case 3:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle :SECTION_TEXT_COLOR :SECTION_BG_COLOR];
            cell.lblTitle.text = @"LUNCH";
            [cell.txtValue setHidden:YES];
            break;
        case 4:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Actual Diet";
            break;
        case 5:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Proposed Diet";
            break;
        case 6:
            [cell.containerView setBackgroundColor:SECTION_BG_COLOR];
            [self setCustomCellLabel:cell.lblTitle :SECTION_TEXT_COLOR :SECTION_BG_COLOR];
            cell.lblTitle.text = @"DINNER";
            [cell.txtValue setHidden:YES];
            break;
        case 7:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Actual Diet";
            break;
        case 8:
            [self setCustomCellLabel:cell.lblTitle :CELL_TEXT_COLOR :CELL_BG_COLOR];
            cell.lblTitle.text = @"Proposed Diet";
            break;
        default:
            break;
    }
}

@end
