//
//  ViewController.m
//  Setting
//
//  Created by YILUN XU on 7/18/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LibraryTableViewController.h"
#import "MyRequestsTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "BooksAroundMeTableViewController.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "constant.h"

@interface ViewController ()  <CLLocationManagerDelegate,FBSDKSharingDelegate>{
    
    CLLocationManager *locationManager;
    NSString *Lat;
    NSString *Long;
    
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"main page constanttttttttttttttt is %@",USER_ID);

    self.btnLogOut.enabled = NO;
    self.btnLogOut.hidden = YES;
    self.btnRequestSent.enabled = NO;
    self.btnRequestSent.hidden = YES;
    self.btnRequestReceived.enabled = NO;
    self.btnRequestReceived.hidden = YES;
    self.btnLibrary.enabled = NO;
    self.btnLibrary.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
    
    UIButton *button1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"library.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(libraryClicked)forControlEvents:UIControlEventTouchUpInside];
    [button1 setFrame:CGRectMake(0, 0, 40, 50)];

    
    UIBarButtonItem *barButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    
    UIButton *button2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"requestSent.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(requestSentClicked)forControlEvents:UIControlEventTouchUpInside];
    [button2 setFrame:CGRectMake(0, 0, 40, 45)];
    
    
    UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    
    UIButton *button3 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setImage:[UIImage imageNamed:@"requestReceived.png"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(requestReceivedClicked)forControlEvents:UIControlEventTouchUpInside];
    [button3 setFrame:CGRectMake(0, 0, 35, 30)];
    
    
    UIBarButtonItem *barButton3 = [[UIBarButtonItem alloc] initWithCustomView:button3];
    
    UIButton *button4 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setImage:[UIImage imageNamed:@"log_out.png"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(logoutClicked)forControlEvents:UIControlEventTouchUpInside];
    [button4 setFrame:CGRectMake(0, 0, 40, 35)];
    
    
    UIBarButtonItem *barButton4 = [[UIBarButtonItem alloc] initWithCustomView:button4];
    
    
    UIButton *button5 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button5 setImage:[UIImage imageNamed:@"Main.png"] forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(mainClicked)forControlEvents:UIControlEventTouchUpInside];
    [button5 setFrame:CGRectMake(0, 0, 40, 40)];
    
    
    UIBarButtonItem *barButton5 = [[UIBarButtonItem alloc] initWithCustomView:button5];
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 15.0f;
    
    
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:barButton5, fixedItem, barButton1, fixedItem, barButton2,fixedItem,barButton3,fixedItem,barButton4, nil];
    


    

    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationController setToolbarHidden:NO];
    [self setToolbarItems:myButtonArray animated:NO];
    
    
    //location
    locationManager = [[CLLocationManager alloc] init];
    
    
    //TODO: get current location
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    self.aroundMeButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.aroundMeButton.titleLabel.numberOfLines = 2;
    
    
    
//    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//    content.contentURL = [NSURL
//                          URLWithString:@"https://www.facebook.com/FacebookDevelopers"];
//    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
//    shareButton.shareContent = content;
//    shareButton.center = self.view.center;
//    [self.view addSubview:shareButton];
    


    


    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (IBAction)SettingClicked:(id)sender {
//    
//    
//    
//    
//    /*********************************share test ***************************/
//
//    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
//        
//        NSLog(@"test");
//        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//
//        //http://books.google.com/books/content?id=uagODAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api
//
//        content.contentURL = [NSURL URLWithString:@"http://books.google.com/books/content?id=uagODAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api"];
//        content.quote = @"Nurture your love for reading at no cost! Share your books using the Meridio App! I just did ;)";
//    
//        [FBSDKShareDialog showFromViewController:self
//                                 withContent:content
//                                    delegate:nil];
//    }else{
//        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//        [loginManager logInWithPublishPermissions:@[@"publish_actions"]
//                               fromViewController:self
//                                          handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//                                              //TODO: process error or result.
//                                              FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//                                              
//                                              //http://books.google.com/books/content?id=uagODAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api
//                                              
//                                              content.contentURL = [NSURL URLWithString:@"http://books.google.com/books/content?id=uagODAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api"];
//                                              content.quote = @"Nurture your love for reading at no cost! Share your books using the Meridio App! I just did ;)";
//                                              
//                                              [FBSDKShareDialog showFromViewController:self
//                                                                           withContent:content
//                                                                              delegate:nil];
//                                          }];
//    }
//
//    
//
//    /*********************************share test ***************************/
//    
//    
//}

- (IBAction)logOut:(id)sender {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //[locationManager stopUpdatingLocation];
    
    if([[segue identifier] isEqualToString:@"showBooksAroundMe"]){
        BooksAroundMeTableViewController *bookAroundMeView = [segue destinationViewController];
        
        bookAroundMeView.passingLat = Lat;
        bookAroundMeView.passingLong = Long;

        
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        Long = [NSString stringWithFormat:@"%.10f", currentLocation.coordinate.longitude];
        Lat = [NSString stringWithFormat:@"%.10f", currentLocation.coordinate.latitude];
        NSLog(@"%@,%@",Long,Lat);
        
        
        
    }
}

#pragma mark === delegate method
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"completed share:%@", results);
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"sharing error:%@", error);
    NSString *message = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?:
    @"There was a problem sharing, please try again later.";
    NSString *title = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops!";
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"share cancelled");
}
-(void)libraryClicked{
    [self performSegueWithIdentifier:@"ToLibrary" sender:nil];
    
}
-(void)requestSentClicked{
    [self performSegueWithIdentifier:@"ToRequestSent" sender:nil];
    
}
-(void)requestReceivedClicked{
    [self performSegueWithIdentifier:@"ToRequestReceived" sender:nil];
    
}
-(void)logoutClicked{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [self performSegueWithIdentifier:@"ToLogIn" sender:nil];
    
}
-(void)mainClicked{
    //[self performSegueWithIdentifier:@"ToLibrary" sender:nil];
}


@end




