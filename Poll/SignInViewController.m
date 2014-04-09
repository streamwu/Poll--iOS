//
//  SignInViewController.m
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "SignInViewController.h"
#import "HomePageViewController.h"
#import "MBProgressHUD.h"
#import "InternetCheck.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.user = [[DefaultUser alloc] init];
    
    self.email.delegate = self;
    self.password.delegate = self;
    
    self.email.placeholder = @"Email";
    self.password.placeholder = @"Password";
    
    self.password.secureTextEntry = YES;
    
    [self.signIn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTapped:(UIButton*)sender{
    NSLog(@"Sign In Button Tapped");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Logging in...";
    if (![InternetCheck hasConnectivity]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No internet access!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        alertView.delegate = self;
        [alertView show];
    }
    else{
        [self.user userSignInWithId:self.email.text andPwd:self.password.text];
        [self performSelector:@selector(waitingForVerification:) withObject:nil afterDelay:2.0];
    }
}

/*******************************************************************************
 * @class           SignInViewController
 * @description     Waiting for the database operation
 ******************************************************************************/
-(void)waitingForVerification:(UIButton*)sender{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([self.user userId]) {
        UINavigationController *mainNavi = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainPageNavi"];
        HomePageViewController* mainView = (HomePageViewController*)[[mainNavi viewControllers] firstObject];
        //HomePageViewController* mainView = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainPageView"];
        mainView.user = self.user;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
        [self presentViewController:mainNavi animated:YES completion:nil];
        
        //[self performSegueWithIdentifier:@"signInToHomePage" sender:sender];
    }
    
    else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"user doesn't exist, try again please." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        alertView.delegate = self;
        [alertView show];
    }
    
}
/*
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
 if([segue.identifier isEqualToString:@"signInToHomePage"]){
 HomePageViewController *hpvc = (HomePageViewController*)segue.destinationViewController;
 hpvc.user = self.user;
 }
 
 }
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"OK"]) {
        //NSLog(@"retype to signin");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
