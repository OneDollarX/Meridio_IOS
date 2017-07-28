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

@interface ViewController ()  <CLLocationManagerDelegate>{
    
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
 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SettingClicked:(id)sender {
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


@end




