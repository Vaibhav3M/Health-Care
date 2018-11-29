//
//  CholestrolReport+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "CholestrolReport+CoreDataProperties.h"

@implementation CholestrolReport (CoreDataProperties)

+ (NSFetchRequest<CholestrolReport *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CholestrolReport"];
}

@dynamic date;
@dynamic ldl;
@dynamic hdl;
@dynamic tdl;
@dynamic userId;
@dynamic unit;

@end
