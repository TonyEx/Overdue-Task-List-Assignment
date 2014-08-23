//
//  TEAEditTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEATaskModel.h"


@protocol TEAEditTaskViewControllerDelegate <NSObject>

-(void) didUpdateTask;

@end;


@interface TEAEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property(strong, nonatomic) TEATask *task;
@property(weak, nonatomic) id <TEAEditTaskViewControllerDelegate> delegate;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UITextField *taskName;
@property (strong, nonatomic) IBOutlet UITextView *taskDescription;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDate;

@end
