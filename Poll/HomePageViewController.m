//
//  HomePageViewController.m
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "HomePageViewController.h"
#import "ServerConnector.h"
#import "PollsFeedCell.h"
#import "VotesFeedCell.h"
#import "CommentsFeedCell.h"
#import "InternetCheck.h"
#import "pollDetailViewController.h"


@interface HomePageViewController ()
{
    NSMutableArray* pollFeeds;
    NSMutableArray* voteFeeds;
    NSMutableArray* commentFeeds;
    NSMutableArray* feeds;
}
@end

@implementation HomePageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadFeedsOfFriends];
    feeds = [[NSMutableArray alloc]init];
    pollFeeds = [[NSMutableArray alloc] init];
    voteFeeds = [[NSMutableArray alloc] init];
    commentFeeds = [[NSMutableArray alloc] init];
    // Refresh Controller
    UIRefreshControl *pullToRefresh = [[UIRefreshControl alloc] init];
    pullToRefresh.tintColor = [UIColor magentaColor];
    [pullToRefresh addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = pullToRefresh;
    
    [self.tableView setAllowsSelection:YES];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]];
    
    [[self.navigationController navigationBar] setTranslucent:NO];
    [[self.navigationController navigationBar] setBackgroundColor:[UIColor colorWithRed:76/255.0f green:132/255.0f blue:78/255.0f alpha:1.0f]];
    [[self.navigationController navigationBar] setBarTintColor:[UIColor colorWithRed:76/255.0f green:132/255.0f blue:78/255.0f alpha:1.0f]];
}
/*******************************************************************************
 * @class           HomePageViewController
 * @description     Drag to refresh
 ******************************************************************************/
-(void) refreshTable {
    [self loadFeedsOfFriends];
    NSLog(@"Table View Refreshed");
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [feeds count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"News Feeds Loaded");
    UITableViewCell *cell;
    
    if ([feeds count] > 0) {
        NSMutableArray *feed = [feeds objectAtIndex:indexPath.row];
        
        if ([[feed lastObject] isEqualToString:@"pollFeeds"]) {
            //NSLog(@"feeds: %@",feed);
            PollsFeedCell *pCell = (PollsFeedCell*)[tableView dequeueReusableCellWithIdentifier:@"pollsFeedCell" forIndexPath:indexPath];
            Poll *poll = [feed objectAtIndex:0];
            NSMutableArray *votes = [poll voteStats];
            NSMutableArray *comments = [poll allComments];
            pCell.subject.text = [NSString stringWithFormat:@"posts a new poll: %@",[poll title]];
            pCell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] ];
            NSString *atSign = @"@";
            pCell.posterName.text = [atSign stringByAppendingString:[feed objectAtIndex:3]];
            pCell.postTime.text = [[feed objectAtIndex:1] substringWithRange:NSMakeRange(5, ((NSString*)[feed objectAtIndex:1]).length-8)];
            
            NSInteger sum = 0;
            for (int i=0;i<votes.count;i++){
                sum+=[[votes objectAtIndex:i] integerValue];
                
            }
            NSArray* barColors = [NSArray arrayWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor grayColor],[UIColor cyanColor],[UIColor orangeColor],[UIColor magentaColor],[UIColor purpleColor], nil];
            for (int i=0;i<[poll numOfOptions];i++){
                UILabel* optDescription = [[UILabel alloc] initWithFrame:CGRectMake(50, 46+i*27, 243, 21)];
                UILabel* supportCount = [[UILabel alloc] initWithFrame:CGRectMake(292, 46+i*27, 20, 21)];
                UIImageView *visualization = [[UIImageView alloc] initWithFrame:CGRectMake(50, 66+i*27, (int)243* ([[[poll voteStats] objectAtIndex:i] floatValue]/sum), 8)];
                optDescription.text = [[poll options] objectAtIndex:i];
                supportCount.text = [NSString stringWithFormat:@"%@",[[poll voteStats] objectAtIndex:i]];
                visualization.backgroundColor = [barColors objectAtIndex:i];
                [optDescription setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
                [supportCount setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
                [pCell.contentView addSubview:optDescription];
                [pCell.contentView addSubview:supportCount];
                [pCell.contentView addSubview:visualization];
            }
            
            // Like, vote, and comment count
            UIImageView *likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 48+27*[poll numOfOptions], 15, 15)];
            UIImageView *voteImage = [[UIImageView alloc] initWithFrame:CGRectMake(117, 48+27*[poll numOfOptions], 15, 15)];
            UIImageView *commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(180, 48+27*[poll numOfOptions], 15, 15)];
            likeImage.image = [UIImage imageNamed:@"icon_thumbs-o-up.png"];
            voteImage.image = [UIImage imageNamed:@"icon_check-square-o.png"];
            commentImage.image = [UIImage imageNamed:@"icon_comment-o.png"];
            [pCell.contentView addSubview:likeImage];
            [pCell.contentView addSubview:voteImage];
            [pCell.contentView addSubview:commentImage];
            
            UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(69, 51+27*[poll numOfOptions], 50, 10)];
            UILabel *voteLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 51+27*[poll numOfOptions], 50, 10)];
            UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(199, 51+27*[poll numOfOptions], 50, 10)];
            likeLabel.text = [NSString stringWithFormat:@"%d", rand() % (10000 - 1000) + 1000];
            //likeLabel.text = @"32";
            voteLabel.text = [NSString stringWithFormat:@"%d",(int)comments.count];
            commentLabel.text = [NSString stringWithFormat:@"%d",(int)sum];
            [voteLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
            [likeLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
            [commentLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
            [pCell.contentView addSubview:likeLabel];
            [pCell.contentView addSubview:voteLabel];
            [pCell.contentView addSubview:commentLabel];
            
            
            if (comments.count>2) {
                UILabel *commenter1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 71+27*[poll numOfOptions], 75, 15)];
                UILabel *comment1 = [[UILabel alloc] initWithFrame:CGRectMake(131, 71+27*[poll numOfOptions], 100, 15)];
                UILabel *commenter2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 84+27*[poll numOfOptions], 75, 15)];
                UILabel *comment2 = [[UILabel alloc]initWithFrame:CGRectMake(131, 84+27*[poll numOfOptions], 140, 15)];
                [commenter1 setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
                commenter1.textColor = [UIColor colorWithRed:76/255.0f green:132/255.0f blue:78/255.0f alpha:1.0f];
                [commenter2 setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
                commenter2.textColor = [UIColor colorWithRed:76/255.0f green:132/255.0f blue:78/255.0f alpha:1.0f];
                [comment1 setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
                [comment2 setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
                
                commenter1.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:1] lastObject]]];
                comment1.text = [[comments objectAtIndex:1] objectAtIndex:4];
                commenter2.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:2] lastObject]]];
                comment2.text = [[comments objectAtIndex:2] objectAtIndex:4];
                
                [pCell.contentView addSubview:commenter1];
                [pCell.contentView addSubview:commenter2];
                [pCell.contentView addSubview:comment1];
                [pCell.contentView addSubview:comment2];
            }
            else if (comments.count==2){
                UILabel *commenter1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 71+27*[poll numOfOptions], 75, 15)];
                UILabel *comment1 = [[UILabel alloc] initWithFrame:CGRectMake(131, 71+27*[poll numOfOptions], 100, 15)];
                [commenter1 setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
                commenter1.textColor = [UIColor colorWithRed:76/255.0f green:132/255.0f blue:78/255.0f alpha:1.0f];
                [comment1 setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
                commenter1.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:1] lastObject]]];
                comment1.text = [[comments objectAtIndex:1] objectAtIndex:4];
                
                [pCell.contentView addSubview:commenter1];
                [pCell.contentView addSubview:comment1];
            }
            
            cell = pCell;
            
        }
        else if ([[feed lastObject] isEqualToString:@"voteFeeds"]) {
            VotesFeedCell *vCell =  (VotesFeedCell*)[tableView dequeueReusableCellWithIdentifier:@"votesFeedCell" forIndexPath:indexPath];
            Poll *poll = [feed objectAtIndex:0];
            vCell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] ];
            NSMutableArray *votes = [poll voteStats];
            NSMutableArray *comments = [poll allComments];
            NSString *atSign = @"@";
            vCell.voterName.text = [atSign stringByAppendingString:[feed objectAtIndex:4]];
            vCell.voteTime.text = [[feed objectAtIndex:1] substringWithRange:NSMakeRange(5, ((NSString*)[feed objectAtIndex:1]).length-8)];
            vCell.pollSubject.text = [NSString stringWithFormat:@"Voted in the poll: %@",[poll title]];
            vCell.likeCount.text = [NSString stringWithFormat:@"%d", rand() % (10000 - 1000) + 1000];
            vCell.commentCount.text = [NSString stringWithFormat:@"%d",(int)comments.count];
            NSInteger sum = 0;
            for (int i=0;i<votes.count;i++){
                sum+=[[votes objectAtIndex:i] integerValue];
                
            }
            vCell.voteCount.text = [NSString stringWithFormat:@"%d",(int)sum];
            if (comments.count>2) {
                //NSLog(@"HERE");
                vCell.commenter1.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:1] lastObject]]];
                vCell.comment1.text = [[comments objectAtIndex:1] objectAtIndex:4];
                vCell.commenter2.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:2] lastObject]]];
                vCell.comment2.text = [[comments objectAtIndex:2] objectAtIndex:4];
            }
            else if (comments.count==2){
                //NSLog(@"HERE2");
                vCell.commenter1.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:1] lastObject]]];
                vCell.comment1.text = [[comments objectAtIndex:1] objectAtIndex:4];
            }
            NSArray *choices = [[feed objectAtIndex:2] componentsSeparatedByString:@","];
            NSString* opt = [[poll options] objectAtIndex:[[choices objectAtIndex:0] integerValue]];
            vCell.choiceDescription.text = opt;
            //NSLog(@" opt: %@",opt);
            cell = vCell;
        }
        else if ([[feed lastObject] isEqualToString:@"commentFeeds"]) {
            CommentsFeedCell *cCell = (CommentsFeedCell*)[tableView dequeueReusableCellWithIdentifier:@"commentsFeedCell" forIndexPath:indexPath];
            cCell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] ];
            NSString *atSign = @"@";
            cCell.commenterName.text = [atSign stringByAppendingString:[feed objectAtIndex:4]];
            cCell.commentTime.text = [[feed objectAtIndex:1] substringWithRange:NSMakeRange(5, ((NSString*)[feed objectAtIndex:1]).length-8)];
            
            Poll *poll = [feed objectAtIndex:0];
            NSMutableArray *votes = [poll voteStats];
            NSMutableArray *comments = [poll allComments];
            cCell.pollSubject.text = [NSString stringWithFormat:@"Post a comment to the poll: %@",[poll title]];
            cCell.likeCount.text = [NSString stringWithFormat:@"%d", rand() % (10000 - 1000) + 1000];
            cCell.commentsCount.text = [NSString stringWithFormat:@"%d",(int)comments.count];
            NSInteger sum = 0;
            for (int i=0;i<votes.count;i++){
                sum+=[[votes objectAtIndex:i] integerValue];
                
            }
            cCell.voteCount.text = [NSString stringWithFormat:@"%d",(int)sum];
            cCell.commentContent.text = [feed objectAtIndex:2];
            if (comments.count>2) {
                //NSLog(@"HERE");
                cCell.commenter1.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:1] lastObject]]];
                cCell.comment1.text = [[comments objectAtIndex:1] objectAtIndex:4];
                cCell.commenter2.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:2] lastObject]]];
                cCell.comment2.text = [[comments objectAtIndex:2] objectAtIndex:4];
            }
            else if (comments.count==2){
                //NSLog(@"HERE2");
                cCell.commenter1.text = [NSString stringWithFormat:@"%@: ",[atSign stringByAppendingString:[[comments objectAtIndex:1] lastObject]]];
                cCell.comment1.text = [[comments objectAtIndex:1] objectAtIndex:4];
            }
            
            cell = cCell;
        }
        
    }
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     NSIndexPath *path = [self.tableView indexPathForSelectedRow];
     pollDetailViewController *dest = (pollDetailViewController*)segue.destinationViewController;
     NSLog(@"destination view: %@",dest);
     NSMutableArray *feed = [feeds objectAtIndex:path.row];
     Poll *poll = [feed objectAtIndex:0];
     dest.comments = [poll allComments];
     NSLog(@"dest.comments: %@",dest.comments);
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *feed = [feeds objectAtIndex:indexPath.row];
    if ([[feed lastObject] isEqualToString:@"commentFeeds"])
        return 130;
    else if ([[feed lastObject] isEqualToString:@"voteFeeds"])
        return 121;
    Poll *poll = [feed objectAtIndex:0];
    if ([poll allComments].count>2) {
        return 52 + 27*[poll numOfOptions]+56;
    }
    else if ([poll allComments].count==2)
    {
        return 53 + 27*[poll numOfOptions]+40;
    }
    return 53 + 27*[poll numOfOptions]+19;
}
/*******************************************************************************
 * @class           HomePageViewController
 * @description     Load news feeds of all friends of current user in form of NSArray and sort the feeds by datetime.
 ******************************************************************************/
- (void) loadFeedsOfFriends{
    if(![InternetCheck hasConnectivity]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Internet Access" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        alertView.delegate = self;
        [alertView show];
        
    }
    else{
        ServerConnector *conn = [[ServerConnector alloc]init];
        // Feeds of Polls
        [conn dbQuery:[NSString stringWithFormat:@"select pollId, postTime, userId, nickName, userImg from Polls join Users on posterId = userId join Follows on userId = leaderId where followerId = \'%@\'", self.user.userId]
           Completion:^(NSArray *returnData) {
               if (returnData.count>pollFeeds.count) {
                   pollFeeds = [returnData mutableCopy];
                   
                   [pollFeeds removeObjectAtIndex:0];
                   for (int i = 0; i < [pollFeeds count]; i++) {
                       NSMutableArray *tmp = [[pollFeeds objectAtIndex:i] mutableCopy];
                       
                       //add a tag to each feed
                       [tmp addObject:@"pollFeeds"];
                       
                       [pollFeeds replaceObjectAtIndex:i withObject:tmp];
                   }
                   
                   [self replacePollIdWithPoll:pollFeeds];
               }
               
               
           }];
        
        // Feeds of Votes
        [conn dbQuery:[NSString stringWithFormat:@"select voteFor, voteTime, choice, userId, nickName, userImg from Votes join Users on userId = voterId join Follows on voterId = leaderId where followerId = \'%@\'", self.user.userId]
           Completion:^(NSArray *returnData) {
               if (returnData.count>voteFeeds.count) {
                   voteFeeds = [returnData mutableCopy];
                   [voteFeeds removeObjectAtIndex:0];
                   for (int i = 0; i < [voteFeeds count]; i++) {
                       NSMutableArray *tmp = [[voteFeeds objectAtIndex:i] mutableCopy];
                       //add a tag to each feed
                       [tmp addObject:@"voteFeeds"];
                       
                       [voteFeeds replaceObjectAtIndex:i withObject:tmp];
                   }
                   [self replacePollIdWithPoll:voteFeeds];
               }
               
           }];
        
        // Feeds of Comments
        [conn dbQuery:[NSString stringWithFormat:@"select commentOn, commentTime, content, userId, nickName, userImg from Comments join Users on userId = commenterId join Follows on commenterId = leaderId where followerId = \'%@\'", self.user.userId]
         
           Completion:^(NSArray *returnData) {
               if (returnData.count>commentFeeds.count) {
                   commentFeeds = [returnData mutableCopy];
                   
                   [commentFeeds removeObjectAtIndex:0];
                   for (int i = 0; i < [commentFeeds count]; i++) {
                       NSMutableArray *tmp = [[commentFeeds objectAtIndex:i] mutableCopy];
                       
                       [tmp addObject:@"commentFeeds"];
                       
                       [commentFeeds replaceObjectAtIndex:i withObject:tmp];
                   }
                   
                   [self replacePollIdWithPoll:commentFeeds];
               }
               
           }];
    }
}

/*******************************************************************************
 * @class           HomePageViewController
 * @description     Load poll information according to the pollId got from news feeds.
 ******************************************************************************/
-(void)replacePollIdWithPoll:(NSMutableArray*)theFeeds{
    
    for (int i = 0; i < [theFeeds count]; i++) {
        NSMutableArray *feed = [theFeeds objectAtIndex:i];
        
        Poll *poll = [[Poll alloc]init];
        //[poll loadPollWithId:[[feed objectAtIndex:0]integerValue]];
        [poll loadPollWithId:[[feed objectAtIndex:0]integerValue] Completion:^(Poll *returnPoll) {
        }];
        [self performSelector:@selector(replace:) withObject:[NSArray arrayWithObjects:theFeeds,[NSNumber numberWithInt:i],poll,nil] afterDelay:5.0];
    }
}

/*******************************************************************************
 * @class           HomePageViewController
 * @description     Synthesize the feeds array and sort all the feeds by datetime.
 ******************************************************************************/
-(void)replace:(NSArray*)theFeedsIAndPoll{
    NSMutableArray *theFeeds = [theFeedsIAndPoll objectAtIndex:0];
    
    NSInteger i = [[theFeedsIAndPoll objectAtIndex:1]integerValue];
    
    Poll *poll = [theFeedsIAndPoll objectAtIndex:2];
    
    NSMutableArray *feed = [theFeeds objectAtIndex:i];
    
    if ([[feed lastObject]isEqualToString:@"pollFeeds"]) {
        [[pollFeeds objectAtIndex:i] replaceObjectAtIndex:0 withObject:poll];
        if (i == ([pollFeeds count]-1)) {
            [feeds addObjectsFromArray:pollFeeds];
        }
        
    }
    
    else if ([[feed lastObject]isEqualToString:@"voteFeeds"]) {
        [[voteFeeds objectAtIndex:i] replaceObjectAtIndex:0 withObject:poll];
        if (i == ([voteFeeds count]-1)) {
            [feeds addObjectsFromArray:voteFeeds];
        }
        
    }
    
    else if ([[feed lastObject]isEqualToString:@"commentFeeds"]) {
        [[commentFeeds objectAtIndex:i] replaceObjectAtIndex:0 withObject:poll];
        if (i == ([commentFeeds count]-1)) {
            [feeds addObjectsFromArray:commentFeeds];
        }
        
    }
    
    //Sort NSMutableArray-feeds by time
    NSArray *sortedArray;
    sortedArray = [feeds sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        NSDate *first = [(NSArray*)a objectAtIndex:1];
        NSDate *second = [(NSArray*)b objectAtIndex:1];
        return [second compare:first];
    }];
    
    feeds = [sortedArray mutableCopy];
    [self.tableView reloadData];
}

- (IBAction)info:(id)sender {
    NSLog(@"Info Button Tapped");
    UIActionSheet *msg = [[UIActionSheet alloc]
                          initWithTitle:
                          @"1. See your friends’ activities in this page.\n"
                          "2. Drag to refresh.\n"
                          delegate:nil
                          cancelButtonTitle:nil  destructiveButtonTitle:nil
                          otherButtonTitles:@"Okay", nil];
    [msg showInView:self.view];
}
@end
