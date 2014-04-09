//
//  Poll.h
//  pollAndUsers
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerConnector.h"

@interface Poll : NSObject

- (id) loadPollNamed: (NSString*) pollTitle
                ofId: (NSInteger) idOfPoll
             isRadio: (BOOL) isRado
          withNumber: (NSInteger) numOfOptions
             options: (NSArray*) optionsProvided
            andImage: (NSString*) imagePath
         andPostDate: (NSString*) timeOfPost
            byPoster: (NSString*) posterId;

-(NSString*)title;
-(NSInteger) pollId;
-(BOOL) isSingleChoice;
-(NSInteger) numOfOptions;
-(NSArray*) options;
-(NSString*) image;
-(NSString*) posterId;
-(NSString*) postDate;



-(void)loadPollWithId:(NSInteger)pollId
           Completion:(void (^)(Poll *returnPoll))handleCompletion;

-(void) setPollName:(NSString*) pollTitle
               andId: (NSInteger) idOfPoll
          isRadio: (BOOL) isRadio
     numOfOptions: (NSInteger) nOfOptions
          options: (NSArray*) optionsProvided
            image: (NSString*) imagePath
         postDate: (NSString*) timeOfPost
           poster: (NSString*) poster;

- (id) createPollNamed: (NSString*) pollTitle
               isRadio: (BOOL) isRadio
            withNumber: (NSInteger) numOfOptions
               options: (NSArray*) optionsProvided
              andIamge: (NSString*) imagePath
                atTime: (NSString*) postTime
              byPoster: (NSString*) posterId;

- (BOOL) comment: (NSString*) content
          byUser: (NSString*) commenterId
          atTime: (NSString*) commentTime;

- (BOOL) votefor: (NSArray*) votes
          byUser: (NSString*) voterId
          atTime: (NSString*) voteTime;


- (NSMutableArray*)voteStats;
- (NSMutableArray*) allComments;

- (BOOL) modifyPollWithTitle: (NSString*) newTitle
              andDescription: (NSString*) newDescription
               andChoiceType: (BOOL) isRadio
            andOptionNumbers: (NSInteger) numOfChoice
                  andOptions: (NSArray*) optionDescription
               attachedImage: (NSString*) newImagePath
                      atTime: (NSString*) modificationTime;

- (NSDictionary*)pollDetail;
@end
