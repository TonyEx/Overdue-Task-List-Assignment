//
//  TEATaskModel.m
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import "TEATaskModel.h"

@implementation TEATask


-(id)init
{
	self = [self initWithData:nil];
	return self;
}


-(id) initWithData:(NSDictionary *)data
{
	self = [super init];
	
// added && data because you can pass in nil as an input, and using it would be invalid.
	if (self) {
		self.title = data[TASK_TITLE];
		self.description = data[TASK_DESCRIPTION];
		self.date = data[TASK_DATE];
		self.isCompleted = [data[TASK_COMPLETE] boolValue];
	}
	
	return self;
}


@end
