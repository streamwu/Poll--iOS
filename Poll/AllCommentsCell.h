//
//  AllCommentsCell.h
//  Poll
//
//  Created by Matt Sun on 3/22/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *prof_Pic;
@property (weak, nonatomic) IBOutlet UILabel *userNickName;
@property (weak, nonatomic) IBOutlet UILabel *commentContent;

@end
