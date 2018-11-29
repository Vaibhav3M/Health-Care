//
//  Utilities.h
//  
//
//  Created by VM on 19/08/16.
//
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

extern NSString *const BpEntity;
extern NSString *const BloodSugarEntity;
extern NSString *const WeightEntity;
extern NSString *const PulseEntity;
extern NSString *const CholestrolEntity;
@interface Utilities : NSObject
//@property (strong,nonatomic) NSString *txtfield;
@property (strong, nonatomic) IBOutlet UITextField *emailStr;
+ (id)sharedInstance;
-(BOOL)validateEmail:(NSString *)emailStr;
-(BOOL)isTextFieldEmpty:(UITextField *)txtField;
-(BOOL)isStringEmpty:(NSString *)inputString;
-(BOOL)isPasswordMatch:(NSString*)pwdTxtField :(NSString*)pwdTxtCnfField;
-(NSArray*)setCustomBackButton:(UIViewController*)viewController withSelector:(SEL)backFuntionName;
-(NSManagedObject*)fetchData:(NSString*)entityName;
-(NSManagedObject*)fetchDataForGraph:(NSString*)entityName;
@end
