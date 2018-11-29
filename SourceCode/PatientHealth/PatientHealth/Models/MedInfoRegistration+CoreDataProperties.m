//
//  MedInfoRegistration+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "MedInfoRegistration+CoreDataProperties.h"

@implementation MedInfoRegistration (CoreDataProperties)

+ (NSFetchRequest<MedInfoRegistration *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MedInfoRegistration"];
}

@dynamic doseTimes;
@dynamic medId;
@dynamic medName;

@end
