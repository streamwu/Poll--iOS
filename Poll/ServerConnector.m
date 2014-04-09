//
//  ServerConnector.m
//  usingBlock
//
//  Created by Matt Sun on 3/16/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "ServerConnector.h"

@implementation ServerConnector

/*******************************************************************************
 * @class           ServerConnector
 * @description     Do database update.
 ******************************************************************************/
- (void)dbUpdate:(NSString*)sqlStat
      Completion:(void (^)(BOOL isSuccessful))handleCompletion{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://107.170.61.44/pollAPI.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params = [NSString stringWithFormat:@"requestType=update&sqlStat=%@",sqlStat];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           //NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               NSError *errorJson = nil;
                                                               NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
                                                               //NSLog(@"type is: %@",[[results objectAtIndex:0] class]);
                                                               //NSLog(@"Return Data: %@",results);
                                                               
                                                               if ([(NSString*)[results objectAtIndex:0] isEqualToString:@"Successful"]){
                                                                   //NSLog(@"It's yes");
                                                                   handleCompletion(YES);
                                                               }
                                                               else{
                                                                   //NSLog(@"It's no");
                                                                   handleCompletion(NO);
                                                               }
                                                           }
                                                       }];
    [dataTask resume];
}

/*******************************************************************************
 * @class           ServerConnector
 * @description     Do database query and get return data set.
 ******************************************************************************/
- (void)dbQuery:(NSString*)sqlStat
     Completion:(void (^)(NSArray* returnData))handleCompletion{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://107.170.61.44/pollAPI.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params = [NSString stringWithFormat:@"requestType=query&sqlStat=%@",sqlStat];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           //NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               NSLog(@"Connection Built");
                                                               NSError *errorJson = nil;
                                                               NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
                                                               //NSLog(@"type is: %@",[[results objectAtIndex:0] class]);
                                                               //NSLog(@"Return Data: %@",results);
                                                               NSLog(@"Database Return Data: %@",data);
                                                               handleCompletion(results);
                                                           }
                                                       }];
    [dataTask resume];
}

@end
