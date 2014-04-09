//
//  DefaultUser.h
//  pollAndUsers
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "User.h"
#import "ServerConnector.h"




@interface DefaultUser : User


- (void) userSignUpWithId: (NSString*) loginId
                   andPwd: (NSString*) loginPwd;

- (void) userSignInWithId: (NSString*) loginId
                   andPwd: (NSString*) loginPwd;



- (BOOL) follow: (NSString*) unfollowUserId;
- (BOOL) unfollow: (NSString*) followingUserId;
- (NSArray*) feedsOfFriends;
- (BOOL) editProfilebyNickname: (NSString*) newNickname
                     andGender: (BOOL) newGender
                 andCellNumber: (NSString*) newPhone;
- (BOOL) uploadNewBioPic: (NSString*) picPath;


@end
