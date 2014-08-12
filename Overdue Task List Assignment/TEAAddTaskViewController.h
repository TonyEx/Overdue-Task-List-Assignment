//
//  TEAAddTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEATaskModel.h"


@protocol TEAAddTaskProtocol <NSObject>

@required

-(void)didCancel;
-(void)didAddTask:(TEATask *)task;

@end


@interface TEAAddTaskViewController : UIViewController

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addTaskButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextField *taskName;
@property (strong, nonatomic) IBOutlet UITextView *taskDescription;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDate;

@property (weak, nonatomic) id <TEAAddTaskProtocol> delegate;

@end
