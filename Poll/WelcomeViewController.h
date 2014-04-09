//
//  WelcomeViewController.h
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashViewController.h"

@interface WelcomeViewController : UIViewController

@property(strong,nonatomic) SplashViewController *svc;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;

@end
