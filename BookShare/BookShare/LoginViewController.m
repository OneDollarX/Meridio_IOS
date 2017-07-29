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
    NSString *userId;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    loginButton.readPermissions =@[@"public_profile", @"email", @"user_friends"];
//    [self.view addSubview:loginButton];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"yes");

        
        [self performSegueWithIdentifier:@"login" sender:nil];
        
    }
    
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
    
    
    /**************************FACEBOOK LOGIN***********************/
    
    
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
             
             
             /**************************FACEBOOK END***********************/
             
             
             
             
             /**************************SetUserSession POST***********************/
             

             // Setup the session
             NSURLSessionConfiguration * configuration =
             [NSURLSessionConfiguration defaultSessionConfiguration];
             NSURLSession * session = [NSURLSession
                                       sessionWithConfiguration:configuration];
            NSString *urlString = [NSString stringWithFormat:@"http://ec2-54-85-207-189.compute-1.amazonaws.com:4000/setUserSession"];
             // create HttpURLrequest
             NSURL *url = [NSURL URLWithString:urlString];
             NSMutableURLRequest *request = [NSMutableURLRequest
                                             requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:60.0];
             [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
             [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
             [request setHTTPMethod:@"POST"];
             
             
             
             NSMutableDictionary *dicData = [[NSMutableDictionary
                                              alloc]init];
             [dicData setValue:name forKey:@"name"];
             [dicData setValue:email forKey:@"emailId"];
             [dicData setValue:accessToken forKey:@"sessionToken"];
             NSError *error;
             NSData *postData = [NSJSONSerialization
                                 dataWithJSONObject:dicData options:0 error:&error];
             [request setHTTPBody:postData];
             
             
             
             // Create a data task to transfer the web service endpoint contents
             NSURLSessionUploadTask * dataTask
             = [session uploadTaskWithRequest:request
                                     fromData:postData completionHandler:^(NSData *data,
                                                                           NSURLResponse *response, NSError *error) {
                                         
                                         
                                         
                    if (!error) {
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
                        NSLog(@"%li",(long)httpResponse.statusCode);
                        if (httpResponse.statusCode == 200) {
                                                 
                                                 
                            NSDictionary* json = [NSJSONSerialization
                                            JSONObjectWithData:data
                                            options:kNilOptions
                                            error:&error];
                            
                            NSString *sessionStatus = [json valueForKeyPath:@"status"];
                            NSString *sessionUserId = [json valueForKeyPath:@"userId"];
                            sessionUserId = userId;
                            NSLog(@"userid is  %@",sessionUserId);
                            NSLog(@"status is  %@",sessionStatus);
                                                 
                                                 
                        }else{
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                message:@"Something is wrong with the server. Plsese check!"
                                preferredStyle:UIAlertControllerStyleAlert];
                                                 
                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {}];
                                                 
                            [alert addAction:defaultAction];
                            [self presentViewController:alert animated:YES completion:nil];
                        }
                    }
                                         
             }];
             
             [dataTask resume];
             
             
             /**************************SetUserSession END***********************/
             
             
            /**************************NAVIGATION To MAINPAGE***********************/
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
        //view.userId = [NSString stringWithFormat:@"%@",userId];

    }
}


@end
