//
//  Utilities.m
//  
//
//  Created by VM on 19/08/16.
//
//

#import "Utilities.h"

NSString *const BpEntity = @"BPReport";
NSString *const BloodSugarEntity = @"BloodSugarReport";
NSString *const WeightEntity = @"WeightReport";
NSString *const PulseEntity = @"PulseReport";
NSString *const CholestrolEntity = @"CholestrolReport";

@implementation Utilities

+ (id)sharedInstance {
    static Utilities *sharedMyModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyModel = [[self alloc] init];
        
    });
    return sharedMyModel;
}

-(BOOL)isTextFieldEmpty:(UITextField *)txtField
{
    if (txtField.text && txtField.text.length > 0)
    {
        return YES;
    }
    else
    {
        NSLog(@"text required");
        return NO;
    }
}

-(BOOL)validateEmail:(NSString *)emailStr{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

-(BOOL)isStringEmpty:(NSString *)inputString{
    
    if(inputString.length <= 0){
        return NO;
    }else{
        return YES;
    }
}

-(BOOL)isPasswordMatch:(NSString*)pwdTxtField :(NSString*)pwdTxtCnfField {
    //asume pwd and cnfPwd has not whitespace
    if([pwdTxtField length]>0 && [pwdTxtCnfField length]>0){
        if([pwdTxtField isEqualToString:pwdTxtCnfField]){
            NSLog(@ "Password matches ");
            return TRUE;
        }else{
            NSLog(@"Oops! Password does not matches");
            return FALSE;
        }
    }    return FALSE;
}

-(NSArray*)setCustomBackButton:(UIViewController*)viewController withSelector:(SEL)backFuntionName{
    NSArray *btnArray;
    UIImage *temp = [[UIImage imageNamed:@"Back"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:temp style:UIBarButtonItemStylePlain target:viewController action:backFuntionName];
    viewController.navigationItem.leftBarButtonItem = barButtonItem;
    return btnArray;
}

-(NSManagedObject*)fetchData:(NSString*)entityName{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    NSInteger count = [results count];
    NSManagedObject *data = nil;
    if(count > 0){
        data = [results objectAtIndex:count-1];
    }
    else{
        data = nil;
    }
    return data;
}

-(NSArray*)fetchDataForGraph:(NSString*)entityName{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    NSInteger count = [results count];
    NSArray *data = nil;
    if(count > 0){
        data = results;
    }
    else{
        data = nil;
    }
    return data;
}

@end












