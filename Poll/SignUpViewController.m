//
//  SignUpViewController.m
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "SignUpViewController.h"
#import "HomePageViewController.h"
#import "MBProgressHUD.h"
#import "InternetCheck.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
	// Do any additional setup after loading the view.
    self.user = [[DefaultUser alloc]init];
    
    self.email.delegate = self;
    self.password.delegate = self;
    self.rePassword.delegate = self;
    
    self.email.placeholder = @"Email";
    self.password.placeholder = @"Password";
    self.rePassword.placeholder = @"RePassword";
    
    self.password.secureTextEntry = YES;
    self.rePassword.secureTextEntry = YES;
    
    [self.signUp addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonTapped:(UIButton*)sender{
    
    NSLog(@"Sign Up Button Tapped");
    //if two password areas don't match, present a alertview and prompt retyping
    if (![self.password.text isEqualToString:self.rePassword.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"passwords don't match, type again please!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        alertView.delegate = self;
        [alertView show];
    }
    else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Logging in...";
        if (![InternetCheck hasConnectivity]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Internet Access!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            alertView.delegate = self;
            [alertView show];
            
        }
        else{
            [self.user userSignUpWithId:self.email.text andPwd:self.password.text];
            [self performSelector:@selector(waitingForVerification:) withObject:nil afterDelay:2.0];
        }
    }
}

/*******************************************************************************
 * @class           SignUpViewController
 * @description     Waiting for the database operation
 ******************************************************************************/

-(void)waitingForVerification:(UIButton*)sender{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([self.user userId]) {
        UINavigationController *mainNavi = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainPageNavi"];
        HomePageViewController* mainView = (HomePageViewController*)[[mainNavi viewControllers] firstObject];
        //HomePageViewController* mainView = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainPageView"];
        mainView.user = self.user;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
        [self presentViewController:mainNavi animated:YES completion:nil];
        /*
         [self performSegueWithIdentifier:@"signUpToHomePage" sender:sender];*/
    }
    
    
}
/*
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
 if([segue.identifier isEqualToString:@"signUpToHomePage"]){
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
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
