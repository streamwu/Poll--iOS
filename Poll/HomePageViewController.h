//
//  HomePageViewController.h
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultUser.h"
#import "Poll.h"
#import "PollsFeedCell.h"
#import "VotesFeedCell.h"
#import "CommentsFeedCell.h"

@interface HomePageViewController : UITableViewController
- (IBAction)info:(id)sender;


@property(strong,nonatomic) DefaultUser *user;

@end
