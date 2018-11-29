//
//  User+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic age;
@dynamic bloodGroup;
@dynamic firstName;
@dynamic fullName;
@dynamic lastName;
@dynamic password;
@dynamic profilePhoto;
@dynamic smoker;
@dynamic userId;
@dynamic userName;
@dynamic weight;
@dynamic relationship;

@end
