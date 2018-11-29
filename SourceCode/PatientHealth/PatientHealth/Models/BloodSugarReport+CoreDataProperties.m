//
//  BloodSugarReport+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "BloodSugarReport+CoreDataProperties.h"

@implementation BloodSugarReport (CoreDataProperties)

+ (NSFetchRequest<BloodSugarReport *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BloodSugarReport"];
}

@dynamic unit;
@dynamic userId;
@dynamic fasting;
@dynamic afterMeal;
@dynamic random;
@dynamic date;

@end
