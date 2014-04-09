//
//  User.h
//  pollAndUsers
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

{
    NSString* userId;
    BOOL gender;
    NSString* nickName;
    NSString* profilePicturePath;
    NSString* cellNumber;
}

- (id) initWithUserId: (NSString*) thisId
            andGender: (BOOL) isMale
          andNickname: (NSString*) userNickname
        andProfilePic: (NSString*) picPath
        andCellNumber: (NSString*) mobile;

- (void) setUserId: (NSString*) thisId
         andGender: (BOOL) isMale
       andNickname: (NSString*) userNickname
     andProfilePic: (NSString*) picPath
     andCellNumber: (NSString*) mobile;

- (NSArray*) followerList;
- (NSArray*) followingList;
- (NSArray*) FeedsOfSelf;

- (NSString*) userId;
- (BOOL) gender;
- (NSString*) nickName;
- (NSString*) profilePicturePath;
- (NSString*) cellNumber;



@end
