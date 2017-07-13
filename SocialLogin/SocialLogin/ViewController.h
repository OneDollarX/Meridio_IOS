//
//  ViewController.h
//  SocialLogin
//
//  Created by YILUN XU on 7/11/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (strong, nonatomic) IBOutlet UILabel *facebookName;
@property (strong, nonatomic) IBOutlet UILabel *facebookEmail;
@property (nonatomic, strong) NSMutableData *responseDataEmail;
@property (nonatomic, strong) NSMutableData *responseDataName;

@property (strong, nonatomic) IBOutlet UIButton *post;

@end

