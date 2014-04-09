//
//  Poll.m
//  pollAndUsers
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "Poll.h"

@interface Poll ()
{
    NSString* title;
    NSInteger pollId;
    BOOL isSingleChoice;
    NSInteger numOfOptions;
    NSArray* options;
    NSString* image;
    NSString* posterId;
    NSString* postDate;
    
    NSMutableArray* voteStats;
    NSMutableArray* allComments;
}
@end

@implementation Poll

// Convenient Constructor
- (id) loadPollNamed: (NSString*) pollTitle
                ofId: (NSInteger) idOfPoll
             isRadio: (BOOL) isRado
          withNumber: (NSInteger) numOfOptions
             options: (NSArray*) optionsProvided
            andImage: (NSString*) imagePath
         andPostDate: (NSString*) timeOfPost
            byPoster: (NSString*) posterId{
    return nil;
}

-(NSString*)title{
    return title;
}
-(NSInteger) pollId{
    return pollId;
}
-(BOOL) isSingleChoice{
    return isSingleChoice;
}
-(NSInteger) numOfOptions{
    return numOfOptions;
}
-(NSArray*) options{
    return options;
}
-(NSString*) image{
    return image;
}
-(NSString*) posterId{
    return posterId;
}
-(NSString*) postDate{
    return postDate;
}

- (NSMutableArray*)voteStats{
    return voteStats;
}

- (NSMutableArray*) allComments{
    return allComments;
}

/*******************************************************************************
 * @class           Poll
 * @description     Given pollId, load all the infomation about the poll from database.
 ******************************************************************************/
-(void)loadPollWithId:(NSInteger)getPollId
           Completion:(void (^)(Poll *returnPoll))handleCompletion{
    ServerConnector *conn = [[ServerConnector alloc]init];
    [conn dbQuery:[NSString stringWithFormat:
                   @"select * from Polls where pollId = \'%d\'", (int)getPollId]
       Completion:^(NSArray *returnData) {
           NSLog(@"Poll loading completed");
           if ([returnData count] == 2) {
               NSArray *optionsProvided = [NSArray arrayWithObjects:
                                           [[returnData objectAtIndex:1]objectAtIndex:8],
                                           [[returnData objectAtIndex:1]objectAtIndex:9],
                                           [[returnData objectAtIndex:1]objectAtIndex:10],
                                           [[returnData objectAtIndex:1]objectAtIndex:11],
                                           [[returnData objectAtIndex:1]objectAtIndex:12],
                                           [[returnData objectAtIndex:1]objectAtIndex:13],
                                           [[returnData objectAtIndex:1]objectAtIndex:14],
                                           [[returnData objectAtIndex:1]objectAtIndex:15],nil];
               
               [self setPollName: [[returnData objectAtIndex:1]objectAtIndex:3]
                           andId: [[[returnData objectAtIndex:1]objectAtIndex:0]integerValue]
                         isRadio: [[[returnData objectAtIndex:1]objectAtIndex:6]boolValue]
                    numOfOptions: [[[returnData objectAtIndex:1]objectAtIndex:7]integerValue]
                         options:  optionsProvided
                           image: [[returnData objectAtIndex:1]objectAtIndex:5]
                        postDate: [[returnData objectAtIndex:1]objectAtIndex:2]
                          poster: [[returnData objectAtIndex:1]objectAtIndex:1]];
               
               [self fetchVoteStats];
               [self fetchAllComments];
           }
           handleCompletion(self);
       }];

    
}

/*******************************************************************************
 * @class           Poll
 * @description     Set instance varaince value.
 ******************************************************************************/
-(void) setPollName:(NSString*) pollTitle
                 andId: (NSInteger) idOfPoll
            isRadio: (BOOL) isRadio
       numOfOptions: (NSInteger) nOfOptions
            options: (NSArray*) optionsProvided
              image: (NSString*) imagePath
           postDate: (NSString*) timeOfPost
             poster: (NSString*) poster{
    
    title = pollTitle;
    pollId = idOfPoll;
    isSingleChoice = isRadio;
    numOfOptions = nOfOptions;
    options = optionsProvided;
    image = imagePath;
    posterId = poster;
    postDate = timeOfPost;
    
}

- (id) createPollNamed: (NSString*) pollTitle
               isRadio: (BOOL) isRadio
            withNumber: (NSInteger) numOfOptions
               options: (NSArray*) optionsProvided
              andIamge: (NSString*) imagePath
                atTime: (NSString*) postTime
              byPoster: (NSString*) posterId{
    return nil;
}

// Methods
- (BOOL) comment: (NSString*) content
          byUser: (NSString*) commenterId
          atTime: (NSString*) commentTime{
    return YES;
}

- (BOOL) votefor: (NSArray*) votes
          byUser: (NSString*) voterId
          atTime: (NSString*) voteTime{
    
    
    return YES;
}


/*******************************************************************************
 * @class           Poll
 * @description     Fetch the statistics of all the choices.
 ******************************************************************************/
- (void)fetchVoteStats{
    
    voteStats = [[NSMutableArray alloc]initWithCapacity:numOfOptions];
    for (int i = 0; i < numOfOptions; i++) {
        [voteStats setObject:[NSNumber numberWithInt:0] atIndexedSubscript:i];
    }
    
    ServerConnector *conn = [[ServerConnector alloc]init];
    [conn dbQuery:[NSString stringWithFormat:
                   @"select choice from Votes where voteFor = \'%d\'", (int)pollId]
       Completion:^(NSArray *returnData) {
           NSLog(@"Vote Stats fetched");
           NSLog(@"Votes: %@",returnData);
           for (int i = 1; i < [returnData count]; i++) {
               NSString *aVote = [[returnData objectAtIndex:i]objectAtIndex:0];
               
               NSArray *aVoteArray = [aVote componentsSeparatedByString:@","];
               
               for (int j = 0; j < [aVoteArray count]; j++) {
                   NSInteger k = [[aVoteArray objectAtIndex:j]integerValue];
                   NSInteger t = [[voteStats objectAtIndex:k]integerValue];
                   
                   [voteStats setObject:[NSNumber numberWithInteger:++t] atIndexedSubscript:k];
               }
           }
           
       }];
}

/*******************************************************************************
 * @class           Poll
 * @description     Fetch all the comments of the poll.
 ******************************************************************************/

-(void)fetchAllComments{
    
    allComments = [[NSMutableArray alloc]init];
    ServerConnector *conn = [[ServerConnector alloc]init];
    [conn dbQuery:[NSString stringWithFormat:
                   @"select commentId,commenterId,commentOn,commentTime,content,nickName from Comments join Users on commenterId=userId where commentOn = \'%d\'", (int)pollId]
       Completion:^(NSArray *returnData) {
           NSLog(@"Comments Fetched");
           NSLog(@"Return Value: %@",returnData);
           allComments = [returnData mutableCopy];
           
       }];
    
}

- (BOOL) modifyPollWithTitle: (NSString*) newTitle
              andDescription: (NSString*) newDescription
               andChoiceType: (BOOL) isRadio
            andOptionNumbers: (NSInteger) numOfChoice
                  andOptions: (NSArray*) optionDescription
               attachedImage: (NSString*) newImagePath
                      atTime: (NSString*) modificationTime{
    return YES;
}

- (NSDictionary*)pollDetail{
    return nil;
}



@end
