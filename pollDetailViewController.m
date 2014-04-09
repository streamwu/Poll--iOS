//
//  pollDetailViewController.m
//  Poll
//
//  Created by Matt Sun on 3/22/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "pollDetailViewController.h"
#import "AllCommentsCell.h"

@interface pollDetailViewController ()

@property (nonatomic,strong) NSArray* profile_pic_list;

@end

@implementation pollDetailViewController

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
    self.profile_pic_list = [NSArray arrayWithObjects:[UIImage imageNamed:@"chris_palmer_profile_11.jpg"],[UIImage imageNamed:@"pt.jpg"],[UIImage imageNamed:@"Mohib-Mirza-Complete-Profile-001.jpg"],[UIImage imageNamed:@"photo.JPG"],[UIImage imageNamed:@"594partner-profile-pic-An.jpg"],[UIImage imageNamed:@"2219225-austin-carr-profile.jpg"], nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"comments: %@",self.comments);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"comment count: %lu",(unsigned long)self.comments.count);
    return self.comments.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"allCommentCell";
    AllCommentsCell* cell = (AllCommentsCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"path.row: %ld",(long)indexPath.row);
    NSArray* comm = [self.comments objectAtIndex:indexPath.row+1];
    NSLog(@"comm: %@",comm);
    NSString *atSign = @"@";

    cell.userNickName.text = [NSString stringWithFormat:@"%@:",[atSign stringByAppendingString:[comm objectAtIndex:5]]];
    cell.commentContent.text = [comm objectAtIndex:4];
    cell.prof_Pic.image = [self.profile_pic_list objectAtIndex:rand() % 6];
    //[NSString stringWithFormat:@"%d", rand() % (10000 - 1000) + 1000];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
