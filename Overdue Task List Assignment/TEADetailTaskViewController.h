//
//  TEADetailTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEATaskModel.h"
#import "TEAEditTaskViewController.h"


@protocol TEADetailTaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end



@interface TEADetailTaskViewController : UIViewController <TEAEditTaskViewControllerDelegate>

@property(strong, nonatomic) TEATask *task;
@property(weak, nonatomic) id <TEADetailTaskViewControllerDelegate> delegate;


@property (strong, nonatomic) IBOutlet UILabel *taskName;
@property (strong, nonatomic) IBOutlet UILabel *taskDate;
@property (strong, nonatomic) IBOutlet UILabel *taskDescription;


- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@end
