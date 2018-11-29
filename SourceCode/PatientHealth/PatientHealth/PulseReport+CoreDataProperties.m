//
//  PulseReport+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "PulseReport+CoreDataProperties.h"

@implementation PulseReport (CoreDataProperties)

+ (NSFetchRequest<PulseReport *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"PulseReport"];
}

@dynamic unit;
@dynamic date;
@dynamic pulse;
@dynamic userId;

@end
