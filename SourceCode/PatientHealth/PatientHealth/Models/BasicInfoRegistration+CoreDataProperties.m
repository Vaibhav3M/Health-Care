//
//  BasicInfoRegistration+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "BasicInfoRegistration+CoreDataProperties.h"

@implementation BasicInfoRegistration (CoreDataProperties)

+ (NSFetchRequest<BasicInfoRegistration *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BasicInfoRegistration"];
}

@dynamic age;
@dynamic allergies;
@dynamic bloodGroup;
@dynamic drinking;
@dynamic email;
@dynamic gender;
@dynamic height;
@dynamic password;
@dynamic smoking;
@dynamic userName;
@dynamic weight;

@end
