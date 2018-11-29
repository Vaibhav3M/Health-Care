//  LeftMenuViewController.m
//  loginSample
//
//  Created by AthithChandra on 22/07/16.
//  Copyright © 2016 Vaibhav . All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "VitalViewController.h"
#import "MeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DiseaseCategoryViewController.h"

@interface LeftMenuViewController ()
@property (nonatomic) NSArray *titleArray;
@property (nonatomic)NSArray *detailsArray;
@property (nonatomic) NSArray *photoNameArray;
@property (nonatomic) NSMutableArray *contactArray;

@end

@implementation LeftMenuViewController
{
    CGRect screenFrame;
    float screenHeight;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    
    return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LeftMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"LeftMenuTableViewCell"];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    self.contactArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
}

-(NSInteger)countOfContacts{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    self.contactArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    return _contactArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftMenuTableViewCell"];
        cell.textLabel.textColor = [UIColor whiteColor];
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = @"  Me";
                cell.imageView.image = [UIImage imageNamed:@"1"];
                break;
                
            case 1:
                cell.textLabel.text = @"Vitals";
                //TO DO : Change Icon
                cell.imageView.image = [UIImage imageNamed:@"2"];
                break;
                
            case 2:
                cell.textLabel.text = @"Reports";
                cell.imageView.image = [UIImage imageNamed:@"3"];
                break;
            case 3:
                cell.textLabel.text = @"Add Fitness Devices";
                cell.imageView.image = [UIImage imageNamed:@"4"];
                break;
            case 4:
                cell.textLabel.text = @"Emergency Contacts";
                cell.imageView.image = [UIImage imageNamed:@"5"];
                break;
                
            case 5:
                cell.textLabel.text = @"Good To Know";
                cell.imageView.image = [UIImage imageNamed:@"6"];
                break;
            case 6:
                cell.textLabel.text = @"Discuss";
                cell.imageView.image = [UIImage imageNamed:@"7"];
                break;
                
            case 7:
                cell.textLabel.text = @"Settings";
                cell.imageView.image = [UIImage imageNamed:@"8"];
                break;
                
            case 8:
                cell.textLabel.text = @"Help";
                cell.imageView.image = [UIImage imageNamed:@"9"];
                break;
                
                
            case 9:
                cell.textLabel.text = @"About Us";
                cell.imageView.image = [UIImage imageNamed:@"10"];
                break;
                
            case 10:
                cell.textLabel.text = @"Logout";
                cell.imageView.image = [UIImage imageNamed:@"11"];
                break;
                
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    screenFrame =[UIScreen mainScreen].bounds;
    screenHeight= screenFrame.size.height;
    
    return screenHeight/11;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *vc ;
    LoginViewController *loginController=[mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    switch (indexPath.row)
    {
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MeViewController"];
            break;
            
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"VitalViewController"];
            break;
            
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ReportViewController"];
            break;
        case 4:
            
            if([self countOfContacts] > 0){
                
                vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ListedContactsViewController"];
            }else{
                vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"EmergencyViewController"];
            }
            break;
            
        case 5:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"DiseaseCategoryViewController"];
            break;
        case 6:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"DiscussionViewController"];
            break;
        case 7:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SettingsTableViewController"];
            break;
        case 10:
            
            [[SlideNavigationController sharedInstance]popAllAndSwitchToViewController:loginController withCompletion:nil];
            break;
    }
    [[SlideNavigationController sharedInstance] pushViewController:vc animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
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
@end
