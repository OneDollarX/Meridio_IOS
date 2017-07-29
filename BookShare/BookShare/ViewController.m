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

@interface ViewController ()  <CLLocationManagerDelegate,FBSDKSharingDelegate>{
    
    CLLocationManager *locationManager;
    NSString *Lat;
    NSString *Long;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //hide back button
    //self.navigationItem.hidesBackButton = YES;
    
    //NSLog(@"ViewController userid is %@",_userId);
    
    
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


- (IBAction)SettingClicked:(id)sender {
    
    
}

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
        Long = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        Lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
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


@end




