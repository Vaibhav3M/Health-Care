//
//  Food+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Food+CoreDataProperties.h"

@implementation Food (CoreDataProperties)

+ (NSFetchRequest<Food *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Food"];
}

@dynamic enddate;
@dynamic foodname;
@dynamic input;
@dynamic startdate;

@end
