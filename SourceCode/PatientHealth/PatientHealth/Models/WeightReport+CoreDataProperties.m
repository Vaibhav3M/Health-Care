//
//  WeightReport+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "WeightReport+CoreDataProperties.h"

@implementation WeightReport (CoreDataProperties)

+ (NSFetchRequest<WeightReport *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WeightReport"];
}

@dynamic date;
@dynamic weight;
@dynamic unit;
@dynamic userId;

@end
