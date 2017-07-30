//
//  TradeBookDetailsViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/26/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "TradeBookDetailsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreLocation/CoreLocation.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface TradeBookDetailsViewController ()

@end

@implementation TradeBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem.backBarButtonItem setTitle:@""];

    self.tradeBookTitleLabel.text = _tradeBookTitle;
    self.tradeBookGenreLabel.text = _tradeBookGenre;
    self.tradeBookDescriptionsTextView.text = _tradeBookDescription;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_tradeBookImageUrl]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self.tradeBookImage setImage:image];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)acceptTradeReqeust:(id)sender {
    
    
    /****************************updateTradeRequest start*********************/
    
    // Setup the session
    NSURLSessionConfiguration * configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession
                              sessionWithConfiguration:configuration];
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-54-85-207-189.compute-1.amazonaws.com:4000/updateTradeRequest"];
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
    
    [dicData setValue:_tradeId forKey:@"id"];
    [dicData setValue:_tradeBookId forKey:@"acceptorWantsBookId"];
    [dicData setValue:@"approved" forKey:@"status"];

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
                                        
                                        for(NSString *key in [json allKeys]) {
                                            NSLog(@"%@",[json objectForKey:key]);
                                        }
                                        
                                        
                                        
                                        
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
    
    /****************************updateTradeRequest end*********************/
    
    
    /******************************alert start*****************************/
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Success"
                                                                  message:[NSString stringWithFormat:@"Now you can contact %@ to get your book!",_tradeEmail]
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* goButton = [UIAlertAction actionWithTitle:@"Go to Main Page"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
    {
        
        // call method whatever u need
        [self performSegueWithIdentifier:@"acceptBookSuccess" sender:nil];
    }];
    
    UIAlertAction* postButton = [UIAlertAction actionWithTitle:@"Post to Facebook"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
    {

        // call method whatever u need
        
        /*********************************share test ***************************/
        
        
//        slComposer = [[SLComposeViewController alloc] init];
//        slComposer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//        [slComposer setInitialText:[NSString stringWithFormat:@"%@ - Download our app", self.label.text]];
//        [slComposer addImage:self.imageView.image];
//        [self presentViewController:slComposer animated:YES completion:nil];
        
        
        
        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
            
            NSLog(@"test");
            FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
            
            //http://books.google.com/books/content?id=uagODAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api
            
            content.contentURL = [NSURL URLWithString:@"http://books.google.com/books/content?id=uagODAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api"];
            content.quote = @"Nurture your love for reading at no cost! Share your books using the Meridio App! I just did ;)";
            
            [FBSDKShareDialog showFromViewController:self
                                         withContent:content
                                            delegate:nil];
        }else{
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logInWithPublishPermissions:@[@"publish_actions"]
                                   fromViewController:self
                                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                                  //TODO: process error or result.
                                                  FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
                                                  
                                                  //http://books.google.com/books/content?id=uagODAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api
                                                  
                                                  content.contentURL = [NSURL URLWithString:@"http://books.google.com/books/content?id=uagODAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api"];
                                                  content.quote = @"Nurture your love for reading at no cost! Share your books using the Meridio App! I just did ;)";
                                                  
                                                  [FBSDKShareDialog showFromViewController:self
                                                                               withContent:content
                                                                                  delegate:nil];
                                              }];
        }
        
        
        
        /*********************************share test ***************************/
        


        
    }];
    
    [alert addAction:goButton];
    [alert addAction:postButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    /******************************alert end ******************************/
    
    
    
}
@end
