//
//  TEAAddTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import "TEAAddTaskViewController.h"

@interface TEAAddTaskViewController ()

@end

@implementation TEAAddTaskViewController


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
	
	self.taskName.delegate = self;
	self.taskDescription.delegate = self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Helper methods


-(TEATask *)returnNewTaskObject
{
	TEATask *taskObject = [[TEATask alloc] init];
	
	taskObject.title = self.taskName.text;
	taskObject.description = self.taskDescription.text;
	taskObject.date = self.taskDate.date;
	taskObject.isCompleted = FALSE;
	
	return taskObject;
}


#pragma mark - Button Actions


- (IBAction)cancelButtonPressed:(UIButton *)sender {
	[self.delegate didCancel];
}


- (IBAction)addTaskButtonPressed:(UIButton *)sender {
	[self.delegate didAddTask:[self returnNewTaskObject]];
}


#pragma mark - UITextfieldDelegate


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.taskName resignFirstResponder];
	
	return TRUE;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if([text isEqualToString:@"\n"])
	   {
		   [self.taskDescription resignFirstResponder];
		   return FALSE;
	   }
	else
		return TRUE;
}


@end
