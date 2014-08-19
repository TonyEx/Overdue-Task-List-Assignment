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
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	
	NSArray *tasksAsPropertyList = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJ_KEY];
	
	for(NSDictionary *dictionary in tasksAsPropertyList) {
		TEATask *task = [self taskObjectForDictionary:dictionary];
		[self.taskObjects addObject:task];
		
	}
	
	if([self isDateGreaterThanDate:[NSDate date] and:[NSDate date]])
		{
			NSLog (@"Entereed the if statement.");
		}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}


#pragma mark - Button Actions


- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
	
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.destinationViewController isKindOfClass:[TEAAddTaskViewController class]])
	{
		TEAAddTaskViewController *addTaskVC = segue.destinationViewController;
		addTaskVC.delegate = self;
	}
}


- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
	[self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}


#pragma mark - TEAAddTaskProtocol Methods


-(void)didCancel
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


-(void)didAddTask:(TEATask *)task
{
	
	NSLog(@"%@", task.title);
	
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


#pragma UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.taskObjects count];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	TEATask *task = self.taskObjects[indexPath.row];
	
	cell.textLabel.text = task.title;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *stringFromDate = [formatter stringFromDate:task.date];
	
	cell.detailTextLabel.text = stringFromDate;
	
	
	BOOL isOverdue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
	
	if(task.isCompleted)
		cell.backgroundColor = [UIColor greenColor];
	else if (isOverdue)
		cell.backgroundColor = [UIColor redColor];
	else
		cell.backgroundColor = [UIColor yellowColor];
	
	return cell;
}


#pragma mark - Helper Methods

-(void) updateCompletionOfTask:(TEATask *)task forIndexPath:(NSIndexPath *)indexPath
{
	NSMutableArray *taskObjectsAsList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJ_KEY] mutableCopy];
	
	if(!taskObjectsAsList)
		taskObjectsAsList = [[NSMutableArray alloc] init];
	
	[taskObjectsAsList removeObjectAtIndex:indexPath.row];
	if(task.isCompleted == TRUE)
		task.isCompleted = FALSE;
	else
		task.isCompleted = TRUE;
	
	[taskObjectsAsList insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
	
	[[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsList forKey:TASK_OBJ_KEY];
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self.tableView reloadData];
}


-(BOOL)isDateGreaterThanDate:(NSDate *)date and: (NSDate *)toDate
{
	NSTimeInterval timeInterval = [date timeIntervalSince1970];
	NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
	
//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setDateFormat:@"yyyy-MM-dd h:mm:ss.SSSSSSS"];

//	NSLog (@"%lf", timeInterval);
//	NSLog (@"%@", [1formatter stringFromDate:date]);
//	NSLog (@"%@", [formatter stringFromDate:toDate]);
	
	return (timeInterval > toDateInterval);
}


-(NSDictionary *)taskObjectAsAPropertyList:(TEATask *)taskObject
{
	NSDictionary *dictionary = @{TASK_TITLE:taskObject.title, TASK_DESCRIPTION:taskObject.description, TASK_DATE:taskObject.date, TASK_COMPLETE:@(taskObject.isCompleted)};
	
	return dictionary;
}


-(TEATask *) taskObjectForDictionary:(NSDictionary *) dictionary
{
	TEATask *task = [[TEATask alloc] initWithData:dictionary];
	
	return task;
}


#pragma mark - UITableViewDelete Methods


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	TEATask *task = self.taskObjects[indexPath.row];
	
	[self updateCompletionOfTask:task forIndexPath:indexPath];
	
}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(editingStyle == UITableViewCellEditingStyleDelete)
	{
		[self.taskObjects removeObjectAtIndex:indexPath.row];
		
		NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
		
		for (TEATask *task in self.taskObjects)
			[newTaskObjectsData addObject:[self taskObjectAsAPropertyList:task]];
		
		[[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:TASK_OBJ_KEY];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
		[self.tableView reloadData];
	}
}


@end
