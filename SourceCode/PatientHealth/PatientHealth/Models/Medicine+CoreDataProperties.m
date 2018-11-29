//
//  Medicine+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Medicine+CoreDataProperties.h"

@implementation Medicine (CoreDataProperties)

+ (NSFetchRequest<Medicine *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
}

@dynamic diseasename;
@dynamic dosage;
@dynamic enddate;
@dynamic firstTabIfSelected;
@dynamic fourthTabIfSelected;
@dynamic fromdate;
@dynamic medicinename;
@dynamic medID;
@dynamic secondTabIfSelected;
@dynamic thirdTabIfSelected;

@end
