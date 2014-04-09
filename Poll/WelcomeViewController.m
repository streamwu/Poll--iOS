//
//  WelcomeViewController.m
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //splashView before homeView
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL firstRun = [defaults boolForKey:@"FirstRun"];
    if (firstRun) {
        [defaults setBool:NO forKey:@"FirstRun"];
        [defaults synchronize];
        
        self.svc = [[self storyboard] instantiateViewControllerWithIdentifier:@"SplashViewController"];
        [self.view.window addSubview:self.svc.view ];
        [self performSelector:@selector(hideSplash) withObject:nil afterDelay:2];
    }
    
}

-(void)hideSplash
{
    [UIView transitionFromView:self.svc.view
                        toView:nil
                      duration:2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        [self.svc.view removeFromSuperview];
                    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
