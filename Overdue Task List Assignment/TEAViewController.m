//
//  TEAViewController.m
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import "TEAViewController.h"

@interface TEAViewController ()

@end

@implementation TEAViewController


//	Lazy instantiation of the taskObjects array:
-(NSMutableArray *)taskObjects
{
	if(!_taskObjects) {
		_taskObjects = [[NSMutableArray alloc] init];
	}
	
	return _taskObjects;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}


#pragma mark - Button Actions


- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
	
}


- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
	
}


#pragma mark - TEAAddTaskProtocol Methods


-(void)didCancel
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


-(void)didAddTask:(TEATask *)task
{
//	Add the new task to the global array:
	[self.taskObjects addObject:task];
	
//	Retrieve the defaults to write out the array (save state):
	NSMutableArray *taskPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJ_KEY] mutableCopy];
	
//	If this is the first run ever, the build a new property list:
	if(!taskPropertyList)
		taskPropertyList = [[NSMutableArray alloc] init];
	
//	Write the new task to the property list (yes, we're doing this twice--once for the application, once for the saved file state):
	[taskPropertyList addObject:[self taskObjectAsAPropertyList:task]];
	
//	Save it back to maintain state if the app is terminated:
	[[NSUserDefaults standardUserDefaults] setObject:taskPropertyList forKey:TASK_OBJ_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
	[self.tableView reloadData];
}


#pragma mark - Helper Methods


-(NSDictionary *)taskObjectAsAPropertyList:(TEATask *)taskObject
{
	NSDictionary *dictionary = @{TASK_TITLE:taskObject.title, TASK_DESCRIPTION:taskObject.description, TASK_DATE:taskObject.date, TASK_COMPLETE:@(taskObject.isCompleted)};
	
	return dictionary;
}


@end
