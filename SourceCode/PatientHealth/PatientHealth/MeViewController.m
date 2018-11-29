//
//  MeViewController.m
//  PatientHealth
//
//  Created by VM on 31/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()


@property(strong,nonatomic) NSArray* data;
@property(strong,nonatomic) NSArray* dataAllergies;


@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = @[@"Asthma",@"Heart-disease",@"BP",@""@"",@""];
    self.tableViewPreExistingDisease.delegate = self;
    self.tableViewPreExistingDisease.dataSource = self;
    
    
    self.dataAllergies = @[@"Dust",@"Water",@"Sun",@"Detergent"@"",@""];
    self.tableViewAllergies.delegate = self;
    self.tableViewAllergies.dataSource = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"Me";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    int b;
    if (tableView == _tableViewPreExistingDisease) {
        
        b = [self.data count];
    }
    else if (tableView == _tableViewAllergies){
        
        b = [self.dataAllergies count];
    }
       return b;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if (tableView == self.tableViewPreExistingDisease) {
        
        static NSString *identifier1 = @"PreExistingDisease";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            
        }
        
        cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    }
    
    
    
    else  if (tableView == self.tableViewAllergies)
        
    {
        static NSString *identifier2 = @"Allergies";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            
        }
        
        cell.textLabel.text = [self.dataAllergies objectAtIndex:indexPath.row];
    }
    
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor grayColor];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (tableView == _tableViewPreExistingDisease) {
        UITableViewCell *cell = [self.tableViewPreExistingDisease cellForRowAtIndexPath:indexPath];
        [self.outletPreExistingdiseases setTitle:cell.textLabel.text forState:UIControlStateNormal];
        
    }
    
    
    else if (tableView == _tableViewAllergies)
        
    {
        UITableViewCell *cell = [self.tableViewAllergies cellForRowAtIndexPath:indexPath];
        [self.outletAllergies setTitle:cell.textLabel.text forState:UIControlStateNormal];
   
    }
    
    tableView.hidden = YES;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0;
}




- (IBAction)edit:(id)sender {
    [self performSegueWithIdentifier:@"editProfileSegue" sender:self];
}


- (IBAction)actionPreExistingDisease:(id)sender {
    
    if (self.tableViewPreExistingDisease.hidden == YES) {
        self.tableViewPreExistingDisease.hidden = NO;
    }
    else
        self.tableViewPreExistingDisease.hidden = YES;
    
    
    //hide year tableview if not hidden
    if (self.tableViewAllergies.hidden == NO) {
        self.tableViewAllergies.hidden = YES;
    }
   
    
    
}
- (IBAction)btnActionAllergies:(id)sender {
    
    
    if (self.tableViewAllergies.hidden == YES) {
        self.tableViewAllergies.hidden = NO;
    }
    else
        self.tableViewAllergies.hidden = YES;
    
    //hide year tableview if not hidden
    if (self.tableViewPreExistingDisease.hidden == NO) {
        self.tableViewPreExistingDisease.hidden = YES;
    }
    
    
    
}
@end
