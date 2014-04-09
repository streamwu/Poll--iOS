//
//  SignUpViewController.h
//  Poll
//
//  Created by Matt Sun on 3/17/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerConnector.h"
#import "HomePageViewController.h"
#import "DefaultUser.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *rePassword;
@property (weak, nonatomic) IBOutlet UIButton *signUp;

@property (strong,nonatomic) DefaultUser *user;

@end
