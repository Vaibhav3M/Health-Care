//
//  DiseaseCategoryViewController.m
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import "DiseaseCategoryViewController.h"
#import "VideosCollectionViewController.h"
#import "SlideNavigationController.h"


@interface DiseaseCategoryViewController ()


@property(strong,nonatomic) NSArray* CategoryArray;
@property (nonatomic) NSArray *VideosIDArray;



@end

NSString *httpLink1;


@implementation DiseaseCategoryViewController
{
    
    NSDictionary *CategoryDataRecieved;
    NSDictionary *dataCategory;
    NSArray *categoryList;
    NSString *videoID;
    NSDictionary *errorCategory;
    NSString *errorCodeCategory;


    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SlideNavigationController sharedInstance].interactivePopGestureRecognizer.enabled=NO;
    self.tableViewCategory.delegate = self;
    self.tableViewCategory.dataSource = self;
    

    
#ifdef DEMO
    {
     
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Videos" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    CategoryDataRecieved = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSArray *items = [CategoryDataRecieved valueForKeyPath:@"service_response"];
    NSLog(@"%@",items);
    NSEnumerator *enumerator = [items objectEnumerator];
    NSDictionary* item;
    while (item = (NSDictionary*)[enumerator nextObject]) {
        
    }
    [self dataLoad];
    [self.tableViewCategory reloadData];
    }
#else
    {
    
        HTTPHandler *object = [[HTTPHandler alloc] init];
        
        [object Category];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(recivingMethodOnListnerE:)
         name:@"CategoryNotification"
         object:nil];

//        [self.tableViewCategory registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:@"CategoryCell"];
//        

        
        
        [self.tableViewCategory reloadData];

    }
    
#endif
    
}
-(void)recivingMethodOnListnerE: (NSNotification*) n{
    
    CategoryDataRecieved = n.userInfo;
    
    NSLog(@"%@",CategoryDataRecieved);
    
    resultC = ([CategoryDataRecieved valueForKey:@"error_response"]);
    errorCategory = ([resultC valueForKey:@"error"]);
    errorCodeCategory = ([errorCategory valueForKey:@"code"]);
    
    if ([errorCodeCategory isEqualToString:@""]) {
        
        NSLog(@"%@",resultC);
      
        [self dataLoad];
        [self.tableViewCategory reloadData];
    }
    else{
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"%@"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        [errorAlert setMessage:errorCodeCategory];
        
        
    }
}


-(void)dataLoad
{
    
    httpLink1 =@"";

    dataCategory = [CategoryDataRecieved valueForKey:@"service_response"];
    categoryList = [dataCategory valueForKey:@"category"];
    videoID=[dataCategory valueForKey:@"_id"];

    
    self.CategoryArray = categoryList;
    self.VideosIDArray = videoID;

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableViewCategory reloadData];
    });
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataCategory.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString *CellIdentifier1 = @"CategoryCell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
    // Configure the cell...
    //NSManagedObject *food = [self.food objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.CategoryArray objectAtIndex:indexPath.row];
    
    
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PdfCell"];
    
    // cell.textLabel.text = [self.PdfListArray objectAtIndex:indexPath.row];
    return  cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    VideosCollectionViewController *controller5;
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];// like Main.storyboard for used "Main"
//    controller5 = [storyboard instantiateViewControllerWithIdentifier:@"VideosCollectionViewController"];
//    [self.navigationController pushViewController:controller5 animated:YES];
    
    
    
    videoID = [_VideosIDArray objectAtIndex:indexPath.row];
    
    
    HTTPHandler *object = [[HTTPHandler alloc] init];
    object.httpvideoID=videoID;
    [object Videos:@""];
    
    
    
    VideosCollectionViewController *controller5;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];// like Main.storyboard for used "Main"
        controller5 = [storyboard instantiateViewControllerWithIdentifier:@"VideosCollectionViewController"];
        [self.navigationController pushViewController:controller5 animated:YES];

    
    
}



@end
