//
//  ViewController.m
//  SocialLogin
//
//  Created by YILUN XU on 7/11/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface ViewController (){
    FBSDKAccessToken *accessToken;
    
    
}



@end

@implementation ViewController


    

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    loginButton.readPermissions =@[@"public_profile", @"email", @"user_friends"];
//    [self.view addSubview:loginButton];
//    
    
    // Handle clicks on the button
    [_facebookLoginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Add the button to the view
    [self.view addSubview:_facebookLoginButton];
    
    [_post
     addTarget:self
     action:@selector(postClicked) forControlEvents:UIControlEventTouchUpInside];
}

// Once the button is clicked, show the login dialog
-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             [_facebookLoginButton setTitle:@"facebook logged in" forState:UIControlStateNormal];
             accessToken = [FBSDKAccessToken currentAccessToken].tokenString;
             NSLog(@"%@",accessToken);
             
             

             
             
             //get email
             
             NSError *errorEmail;
             NSString *url_stringEmail = [NSString stringWithFormat:@"https://graph.facebook.com/me?fields=email&access_token=%@",accessToken];
             NSData *dataEmail = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_stringEmail]];
             NSDictionary *resultEmail = [NSJSONSerialization JSONObjectWithData:dataEmail options:kNilOptions error:&errorEmail];
             NSString *email = [resultEmail valueForKeyPath:@"email"];
             NSLog(@"email: %@", email);
             
             self.facebookEmail.text = [NSString stringWithFormat:@"%@",email];
             
             
             //get name
             
             NSError *errorName;
             NSString *url_stringName = [NSString stringWithFormat:@"https://graph.facebook.com/me?fields=name&access_token=%@",accessToken];
             NSData *dataName = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_stringName]];
             NSDictionary *resultName = [NSJSONSerialization JSONObjectWithData:dataName options:kNilOptions error:&errorName];
             NSString *name = [resultName valueForKeyPath:@"name"];
             NSLog(@"name: %@", name);
             
             self.facebookName.text = [NSString stringWithFormat:@"%@",name];
             
             
             

             
//             if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
//                 // TODO: publish content.
//                 NSLog(@"publish actions granted");
//                 [[[FBSDKGraphRequest alloc]
//                   initWithGraphPath:@"me/feed"
//                   parameters: @{ @"message" : @"hello world"}
//                   HTTPMethod:@"POST"]
//                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//                      if (!error) {
//                          NSLog(@"Post id:%@", result[@"id"]);
//                      }
//                  }];
//             } else {
//                 FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//                 [loginManager logInWithPublishPermissions:@[@"publish_actions"]
//                                        fromViewController:self
//                                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//                                                       //TODO: process error or result.
//                                                       if(error){
//                                                           NSLog(@"Process Error");
//                                                       }else if(result.isCancelled){
//                                                           NSLog(@"Cancelled");
//                                                       }else{
//                                                           
//                                                           [[[FBSDKGraphRequest alloc]
//                                                             initWithGraphPath:@"me/feed"
//                                                             parameters: @{ @"message" : @"hello world"}
//                                                             HTTPMethod:@"POST"]
//                                                            startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//                                                                if (!error) {
//                                                                    NSLog(@"Post id:%@", result[@"id"]);
//                                                                }
//                                                            }];
//                                                       }
//
//                                                       
//                                                   }];
//             }

             
             
             
             
             
             

             

         }
     }];
}


-(void)postClicked{
    
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
        // TODO: publish content.
        NSLog(@"publish actions granted");
        [[[FBSDKGraphRequest alloc]
          initWithGraphPath:@"me/feed"
          parameters: @{ @"message" : @"hello world"}
          HTTPMethod:@"POST"]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"Post id:%@", result[@"id"]);
             }
         }];
    } else {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logInWithPublishPermissions:@[@"publish_actions"]
                               fromViewController:self
                                          handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                              //TODO: process error or result.
                                              if(error){
                                                  NSLog(@"Process Error");
                                              }else if(result.isCancelled){
                                                  NSLog(@"Cancelled");
                                              }else{
                                                  
                                                  [[[FBSDKGraphRequest alloc]
                                                    initWithGraphPath:@"me/feed"
                                                    parameters: @{ @"message" : @"hello world"}
                                                    HTTPMethod:@"POST"]
                                                   startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                                       if (!error) {
                                                           NSLog(@"Post id:%@", result[@"id"]);
                                                       }
                                                   }];
                                              }
                                              
                                              
                                          }];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

