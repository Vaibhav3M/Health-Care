//
//  Entity+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Entity+CoreDataProperties.h"

@implementation Entity (CoreDataProperties)

+ (NSFetchRequest<Entity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Login"];
}

@dynamic password;
@dynamic userId;
@dynamic userName;

@end
