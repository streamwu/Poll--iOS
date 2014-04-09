//
//  User.m
//  pollAndUsers
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithUserId: (NSString*) thisId
            andGender: (BOOL) isMale
          andNickname: (NSString*) userNickname
        andProfilePic: (NSString*) picPath
        andCellNumber: (NSString*) mobile{
    
    self = [super init];
    if (self != nil) {
        userId = thisId;
        gender = isMale;
        nickName = userNickname;
        profilePicturePath = picPath;
        cellNumber = mobile;
    }
    return self;
}

//getters

- (NSString*) userId{
    return userId;
}

- (BOOL) gender{
    return gender;
}

- (NSString*) nickName{
    return nickName;
}

- (NSString*) profilePicturePath{
    return profilePicturePath;
}

- (NSString*) cellNumber{
    return cellNumber;
}

//setter
/*******************************************************************************
 * @class           User
 * @description     It's quite streightforward
 ******************************************************************************/
- (void) setUserId: (NSString*) thisId
         andGender: (BOOL) isMale
       andNickname: (NSString*) userNickname
     andProfilePic: (NSString*) picPath
     andCellNumber: (NSString*) mobile{
    
    userId = thisId;
    gender = isMale;
    nickName = userNickname;
    profilePicturePath = picPath;
    cellNumber = mobile;
}




- (NSArray*) followerList{
    return nil;
}
- (NSArray*) followingList{
    return  nil;
}
- (NSArray*) FeedsOfSelf{
    return nil;
}

@end
