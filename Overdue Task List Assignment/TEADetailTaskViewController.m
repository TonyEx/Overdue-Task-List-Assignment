//
//  TEADetailTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import "TEADetailTaskViewController.h"

@interface TEADetailTaskViewController ()

@end

@implementation TEADetailTaskViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.taskName.text = self.task.title;
	self.taskDescription.text = self.task.description;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *stringFromDate = [formatter stringFromDate:self.task.date];
	
	self.taskDate.text = stringFromDate;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.destinationViewController isKindOfClass:[TEAEditTaskViewController class]])
	{
		TEAEditTaskViewController *taskVC = segue.destinationViewController;
		taskVC.task = self.task;
		taskVC.delegate = self;
	}
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Button Actions


- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
	[self performSegueWithIdentifier:@"toEditTaskViewControllerSegue" sender:nil];
	
}

-(void)didUpdateTask
{
	self.taskName.text = self.task.title;
	self.taskDescription.text = self.task.description;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	
	NSString *stringFromDate = [formatter stringFromDate:self.task.date];
	self.taskDate.text = stringFromDate;
	
	[self.navigationController popViewControllerAnimated:TRUE];
	[self.delegate updateTask];
}


@end
