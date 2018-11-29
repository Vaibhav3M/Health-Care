//
//  ForgetPasswordController.m
//  PatientHealth
//
//  Created by VM on 8/22/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "ForgetPasswordController.h"

@interface ForgetPasswordController ()

@end

@implementation ForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Forgot Password";
    NSArray *imageNamesArray = @[@"forget_password1.png", @"forget_password2.png", @"forget_password3.png", @"forget_password4.png",@"forget_password5.png", @"forget_password6.png", @"forget_password7.png", @"forget_password8.png", @"forget_password9.png", @"forget_password10.png",@"forget_password11.png", @"forget_password12.png",@"forget_password13.png" ,@"forget_password14.png", @"forget_password15.png",@"forget_password16.png",@"forget_password17"];
    
    self.imgArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNamesArray.count; i++) {
        [self.imgArray addObject:[UIImage imageNamed:[imageNamesArray objectAtIndex:i]]];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self setAnimatedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onGetEmailClick:(id)sender {
    if([_txtEmail.text isEqualToString:@""]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error !!"
                                      message:@"Enter email ID."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else if([self NSStringIsValidEmail:_txtEmail.text] == NO){
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Error !!"
                                    message:@"Invalid email ID."
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [self performSegueWithIdentifier:@"forgotPasswordIdentifier" sender:self];
    }
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)setAnimatedImage{
    // Normal Animation
    self.imgAnimatedImage.animationImages = self.imgArray;
    self.imgAnimatedImage.animationDuration = 1.2;
    [self.view addSubview:self.imgAnimatedImage];
    [self.imgAnimatedImage startAnimating];
}
@end
