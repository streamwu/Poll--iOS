//
//  CommentsFeedCell.h
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsFeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commenterPic;
@property (weak, nonatomic) IBOutlet UILabel *pollSubject;
@property (weak, nonatomic) IBOutlet UILabel *commenterName;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *commenter1;
@property (weak, nonatomic) IBOutlet UILabel *comment1;
@property (weak, nonatomic) IBOutlet UILabel *commenter2;
@property (weak, nonatomic) IBOutlet UILabel *comment2;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *voteCount;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;
@property (weak, nonatomic) IBOutlet UILabel *commentContent;

@end
