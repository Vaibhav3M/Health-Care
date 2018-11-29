//
//  Tablets+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Tablets+CoreDataProperties.h"

@implementation Tablets (CoreDataProperties)

+ (NSFetchRequest<Tablets *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Tablets"];
}

@dynamic tabselected;

@end
