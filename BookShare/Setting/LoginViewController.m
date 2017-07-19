//
//  LoginViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/18/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ViewController.h"

@interface LoginViewController () {
    FBSDKAccessToken *accessToken;
    NSString *name;
    NSString *email;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    // Handle clicks on the button
    [_facebookLoginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Add the button to the view
    [self.view addSubview:_facebookLoginButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    
    [login
     logInWithReadPermissions: @[@"public_profile",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             //[_facebookLoginButton setTitle:@"facebook logged in" forState:UIControlStateNormal];
             accessToken = [FBSDKAccessToken currentAccessToken].tokenString;
             NSLog(@"%@",accessToken);
             
             
             
             
             
             //get email
             
             NSError *errorEmail;
             NSString *url_stringEmail = [NSString stringWithFormat:@"https://graph.facebook.com/me?fields=email&access_token=%@",accessToken];
             NSData *dataEmail = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_stringEmail]];
             NSDictionary *resultEmail = [NSJSONSerialization JSONObjectWithData:dataEmail options:kNilOptions error:&errorEmail];
             email = [resultEmail valueForKeyPath:@"email"];
             NSLog(@"email: %@", email);
             

             

             
             
             
             //get name
             
             NSError *errorName;
             NSString *url_stringName = [NSString stringWithFormat:@"https://graph.facebook.com/me?fields=name&access_token=%@",accessToken];
             NSData *dataName = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_stringName]];
             NSDictionary *resultName = [NSJSONSerialization JSONObjectWithData:dataName options:kNilOptions error:&errorName];
             name = [resultName valueForKeyPath:@"name"];
             NSLog(@"name: %@", name);
             
             
             //passing values
             
             
             
             
             //switch to homepage
//             if([FBSDKAccessToken currentAccessToken]){
//                 NSLog(@"yes");
//                 NSString * storyboardName = @"Main";
//                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//                 UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"HomePage"];
//
//                 
//                 
//                 [self presentViewController:vc animated:YES completion:nil];
//             }
             [self performSegueWithIdentifier:@"login" sender:nil];
             

             
             
         
             
         }
     }];


    
    
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     //Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
    
    
    if([[segue identifier] isEqualToString:@"login"]){
        ViewController *view = [segue destinationViewController];
        view.username = [NSString stringWithFormat:@"%@",name];
        view.emailAddress = [NSString stringWithFormat:@"%@",email];

    }
}


@end
