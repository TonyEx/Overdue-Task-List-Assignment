//
//  TEAEditTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import "TEAEditTaskViewController.h"

@interface TEAEditTaskViewController ()

@end

@implementation TEAEditTaskViewController


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
	self.taskDate.date = self.task.date;
	
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


#pragma mark - Button Actions


- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
	
	[self updateTask];
	
	[self.delegate didUpdateTask];
}


-(void) updateTask
{
	self.task.title = self.taskName.text;
	self.task.description = self.taskDescription.text;
	self.task.date = self.taskDate.date;
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
