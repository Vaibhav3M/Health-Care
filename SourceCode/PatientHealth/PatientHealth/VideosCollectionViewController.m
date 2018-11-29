//
//  VideosCollectionViewController.m
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import "VideosCollectionViewController.h"
#import "VideosViewController.h"
#import "PDFViewController.h"
#import "PDFListViewController.h"




@interface VideosCollectionViewController ()

@property (nonatomic) NSArray *VideosIDArray;
@property (nonatomic) NSArray *VideosIconArray;
@property (nonatomic) NSArray *VideosNameArray;




@end
NSString *httpLink2;

@implementation VideosCollectionViewController

{
    
    NSDictionary *VideosDataRecieved;
    NSDictionary *dataVideos;
    NSArray *VideoIcon;
    NSArray *VideoNames;
    NSArray *VideoID;
    
    NSDictionary *errorVideo;
    NSString *errorCodeVideo;
    
    UIActivityIndicatorView *spinner;
    
    
    
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    _videoCollectionView.delegate=self;
    _videoCollectionView.dataSource=self;
    
#ifdef DEMO
    {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Videos" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    VideosDataRecieved = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSArray *items = [VideosDataRecieved valueForKeyPath:@"service_response"];
    NSLog(@"%@",items);
    NSEnumerator *enumerator = [items objectEnumerator];
    NSDictionary* item;
    while (item = (NSDictionary*)[enumerator nextObject]) {
        
    }
    [self dataLoad];
    [self.videoCollectionView reloadData];
    
    }
#else
    {
    
        
        HTTPHandler *object = [[HTTPHandler alloc] init];
        
        [object Category];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(recivingMethodOnListnerE:)
         name:@"VideoNotification"
         object:nil];
        
        //        [self.tableViewCategory registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:@"CategoryCell"];
        //
        
        
        
        [self.videoCollectionView reloadData];

    }
    
#endif
}

-(void)recivingMethodOnListnerE: (NSNotification*) n{
    
    VideosDataRecieved = n.userInfo;
    
    NSLog(@"%@",VideosDataRecieved);
    
    resultV = ([VideosDataRecieved valueForKey:@"error_response"]);
    errorVideo = ([resultV valueForKey:@"error"]);
    errorCodeVideo = ([errorVideo valueForKey:@"code"]);
    
    if ([errorCodeVideo isEqualToString:@""]) {
        
        NSLog(@"%@",resultV);
        
        [self dataLoad];
        [self.videoCollectionView reloadData];
    }
    else{
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"%@"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        [errorAlert setMessage:errorCodeVideo];
        
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

-(void)dataLoad
{
    
    httpLink2 =@"";
    
    dataVideos= [VideosDataRecieved valueForKey:@"service_response"];
    VideoIcon = [dataVideos valueForKey:@"videoImage"];
    VideoID=[dataVideos valueForKey:@"_id"];
    VideoNames = [dataVideos valueForKey:@"videoPlay"];
    
    
    self.VideosNameArray = VideoNames;
    self.VideosIconArray = VideoIcon;
    self.VideosIDArray = VideoID;
    [spinner stopAnimating];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.videoCollectionView reloadData];
    });

    
    //NSLog(@"%@",_VideosNameArray);
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.VideosIconArray count];
    
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
      VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCollectionViewCell" forIndexPath:indexPath];
    
#ifdef DEMO
    {
        
        NSString *videoIconStr = [self.VideosIconArray objectAtIndex:indexPath.row];
 cell.imgVideoIcon.image = [UIImage imageNamed:videoIconStr];
        
    }
#else
    {
        
        
        NSString *MainImage = [httpLink2 stringByAppendingString:self.VideosIconArray[indexPath.row]];
        NSURL *mainImageUrl = [NSURL URLWithString:MainImage];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL:mainImageUrl];
        cell.imgVideoIcon.image = [UIImage imageWithData: imageData];

    
    }
    
#endif
    
    
    
    return cell;
    
}



//
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return CGSizeMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//
//
//}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    VideosViewController *controller1;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];// like Main.storyboard for used "Main"
    controller1 = [storyboard instantiateViewControllerWithIdentifier:@"VideosViewController"];
    [self.navigationController pushViewController:controller1 animated:YES];
    controller1.videoName=self.VideosNameArray[indexPath.row];
    
    
}


- (IBAction)Okay:(id)sender {
    
    //    PDFViewController *controller2;
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];// like Main.storyboard for used "Main"
    //    controller2 = [storyboard instantiateViewControllerWithIdentifier:@"PDFViewController"];
    //    [self.navigationController pushViewController:controller2 animated:YES];
    
    
    PDFListViewController *controller3;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];// like Main.storyboard for used "Main"
    controller3 = [storyboard instantiateViewControllerWithIdentifier:@"PDFListViewController"];
    [self.navigationController pushViewController:controller3 animated:YES];
    
    
}
@end
