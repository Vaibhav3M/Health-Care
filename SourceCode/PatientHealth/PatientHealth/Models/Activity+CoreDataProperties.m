//
//  Activity+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Activity+CoreDataProperties.h"

@implementation Activity (CoreDataProperties)

+ (NSFetchRequest<Activity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Activity"];
}

@dynamic activity;
@dynamic current;
@dynamic endDate;
@dynamic startDate;
@dynamic target;

@end
