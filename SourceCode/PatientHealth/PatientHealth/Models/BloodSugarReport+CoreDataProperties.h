//
//  BloodSugarReport+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "BloodSugarReport+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BloodSugarReport (CoreDataProperties)

+ (NSFetchRequest<BloodSugarReport *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *unit;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *fasting;
@property (nullable, nonatomic, copy) NSString *afterMeal;
@property (nullable, nonatomic, copy) NSString *random;
@property (nullable, nonatomic, copy) NSString *date;

@end

NS_ASSUME_NONNULL_END
