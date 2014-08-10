//
//  TEADetailTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Tony Angelo on 8/10/14.
//  Copyright (c) 2014 Tony Angelo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEADetailTaskViewController : UIViewController

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *taskName;
@property (strong, nonatomic) IBOutlet UILabel *taskDate;
@property (strong, nonatomic) IBOutlet UILabel *taskDescription;

@end
