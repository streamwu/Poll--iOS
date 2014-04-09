//
//  DefaultUser.m
//  pollAndUsers
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "DefaultUser.h"

//static bool signUpSuccessfully;
//static bool signInSuccessfully;


@implementation DefaultUser

/*******************************************************************************
 * @class           DefaultUser
 * @description     Sign up with userId and password
 ******************************************************************************/
- (void) userSignUpWithId: (NSString*) loginId
                   andPwd: (NSString*) loginPwd{
    
    ServerConnector *conn = [[ServerConnector alloc]init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [conn dbUpdate:[NSString stringWithFormat:
                    @"insert into Users(userId, password) values(\'%@\', \'%@\')", loginId, loginPwd]
        Completion:^(BOOL isSuccessful) {
            if (isSuccessful) {
                NSLog(@"Sign Up Succeeded");
                [self setUserId:loginId andGender:YES andNickname:nil andProfilePic:nil andCellNumber:nil];
            }
        }];
    
}

/*******************************************************************************
 * @class           DefaultUser
 * @description     Sign in with userId and password
 ******************************************************************************/
- (void) userSignInWithId: (NSString*) loginId
                   andPwd: (NSString*) loginPwd {
    
    ServerConnector *conn = [[ServerConnector alloc]init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [conn dbQuery:[NSString stringWithFormat:
                   @"select * from Users where userId = \'%@\' and password = \'%@\'", loginId, loginPwd]
       Completion:^(NSArray *returnData) {
           
           if ([returnData count] == 2) {
               NSLog(@"Log In Succeeded");
               [self setUserId:[[returnData objectAtIndex:1]objectAtIndex:0]
                     andGender:[[[returnData objectAtIndex:1]objectAtIndex:2]boolValue]
                   andNickname:[[returnData objectAtIndex:1]objectAtIndex:1]
                 andProfilePic:[[returnData objectAtIndex:1]objectAtIndex:3]
                 andCellNumber:[[returnData objectAtIndex:1]objectAtIndex:4]];
           }
           
       }];

}



- (BOOL) follow: (NSString*) unfollowUserId{
    return YES;
}
- (BOOL) unfollow: (NSString*) followingUserId{
    return YES;
}
- (NSArray*) feedsOfFriends{
    return nil;
}
- (BOOL) editProfilebyNickname: (NSString*) newNickname
                     andGender: (BOOL) newGender
                 andCellNumber: (NSString*) newPhone{
    return YES;
}
- (BOOL) uploadNewBioPic: (NSString*) picPath{
    return YES;
}


@end
