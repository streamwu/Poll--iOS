//
//  PollsFeedCell.h
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollsFeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImg;
@property (weak, nonatomic) IBOutlet UILabel *posterName;
@property (weak, nonatomic) IBOutlet UILabel *postTime;
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *option1;
@property (weak, nonatomic) IBOutlet UIImageView *option1Stat;
@property (weak, nonatomic) IBOutlet UILabel *option2;
@property (weak, nonatomic) IBOutlet UIImageView *option2Stat;
@property (weak, nonatomic) IBOutlet UILabel *option3;
@property (weak, nonatomic) IBOutlet UIImageView *option3Stat;
@property (weak, nonatomic) IBOutlet UILabel *commenter1;
@property (weak, nonatomic) IBOutlet UILabel *comment1;
@property (weak, nonatomic) IBOutlet UILabel *commenter2;
@property (weak, nonatomic) IBOutlet UILabel *comment2;



@end
