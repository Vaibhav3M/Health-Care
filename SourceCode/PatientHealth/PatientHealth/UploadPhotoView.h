//
//  Uploadphoto.h
//  registration login
//
//  Created by VM on 12/08/16.
//  Copyright (c) 2016 Emobility Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadPhotoView : UIView <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)camera:(id)sender;

- (IBAction)gallery:(id)sender;

@end
