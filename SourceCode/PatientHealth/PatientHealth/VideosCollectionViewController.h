//
//  VideosCollectionViewController.h
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "VideoCollectionViewCell.h"
#import "HTTPHandler.h"

@interface VideosCollectionViewController : UIViewController
<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>

{
    
    
        
        NSMutableDictionary *resultV;
        
        
        
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *videoCollectionView;


@property (strong, nonatomic) IBOutlet UITextField *txtFieldEnterMailAddress;

- (IBAction)btnSendMail:(id)sender;
- (IBAction)Okay:(id)sender;
-(void)dataLoad;

@end
