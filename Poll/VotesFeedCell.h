//
//  VotesFeedCell.h
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VotesFeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *voterImg;
@property (weak, nonatomic) IBOutlet UILabel *voterName;
@property (weak, nonatomic) IBOutlet UILabel *voteTime;
@property (weak, nonatomic) IBOutlet UILabel *pollSubject;
@property (weak, nonatomic) IBOutlet UIImageView *stat;
@property (weak, nonatomic) IBOutlet UILabel *commenter1;
@property (weak, nonatomic) IBOutlet UILabel *comment1;
@property (weak, nonatomic) IBOutlet UILabel *commenter2;
@property (weak, nonatomic) IBOutlet UILabel *comment2;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *voteCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *choiceDescription;

@end
