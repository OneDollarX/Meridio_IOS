//
//  BookDetailsViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "BookDetailsViewController.h"
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface BookDetailsViewController () <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    NSString *currentLat;
    NSString *currentLong;
}

@property (nonatomic, strong) NSMutableData *responseData;



@end

@implementation BookDetailsViewController

@synthesize responseData = _responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload");
    self.responseData = [NSMutableData data];
    NSLog(@"%@", _bookISBN);
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=%@",_bookISBN]]];
    
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    //location
    
    locationManager = [[CLLocationManager alloc] init];


    

    
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //    NSLog(@"didFailWithError");
    //    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //    NSLog(@"connectionDidFinishLoading");
    //    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    //    //NSLog(@"%@",self.responseData);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    //bookTitle
    NSArray *bookTitle = [res valueForKeyPath:@"items.volumeInfo.title"];
    NSLog(@"%@",bookTitle[0]);
    self.bookTitleLabel.text = [NSString stringWithFormat:@"%@",bookTitle[0]];
    
    
    //bookDescription
    NSArray *bookDescription = [res valueForKeyPath:@"items.volumeInfo.description"];
    NSLog(@"%@",bookDescription[0]);
    if([bookDescription[0] isKindOfClass:[NSNull class]]){
        self.bookDescriptionsTextView.text = @"Description is not available for now.";
    }else{
        self.bookDescriptionsTextView.text = [NSString stringWithFormat:@"%@",bookDescription[0]];
    }
    
    
    //bookAuthors
//    NSArray *bookAuthors = [res valueForKeyPath:@"items.volumeInfo.authors"];
//    NSLog(@"%@",bookAuthors[0]);
//    if([bookAuthors[0] isKindOfClass:[NSNull class]]){
//        self.bookAuthorLabel.text = @"Authors is not available for now.";
//    }else{
//        NSArray *bookAuthors2 = bookAuthors[0];
//        NSLog(@"%@",bookAuthors2[0]);
//        if([bookAuthors2[0] isKindOfClass:[NSNull class]]){
//            self.bookCategoriesLabel.text = @"Authors is not available for now.";
//        }else{
//            self.bookAuthorLabel.text = [NSString stringWithFormat:@"%@",bookAuthors2[0]];
//        }
//    }
    
    
    //bookCategories
    NSArray *bookCategories = [res valueForKeyPath:@"items.volumeInfo.categories"];
    NSLog(@"%@",bookCategories[0]);
    if([bookCategories[0] isKindOfClass:[NSNull class]]){
        self.bookCategoriesLabel.text = @"Categories is not available for now.";
    }else{
        NSArray *bookCategories2 = bookCategories[0];
        NSLog(@"%@",bookCategories2[0]);
        if([bookCategories2[0] isKindOfClass:[NSNull class]]){
            self.bookCategoriesLabel.text = @"Categories is not available for now.";
        }else{
            self.bookCategoriesLabel.text = [NSString stringWithFormat:@"%@",bookCategories2[0]];
        }
    }
    
    
    //image
    NSArray *bookImageLinks = [res valueForKeyPath:@"items.volumeInfo.imageLinks.smallThumbnail"];
    NSLog(@"%@",bookImageLinks[0]);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",bookImageLinks[0]]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self.bookImageView setImage:image];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    [super viewDidUnload];
}





 #pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"PostSuccessOK"]){
        ViewController *viewController = [segue destinationViewController];

        
    }
    
}


- (IBAction)postClicked:(id)sender {
    
    
    
    
    //TODO: get current location
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    NSLog(@"%@,%@",currentLat,currentLong);
    
    //TODO: connect to the server and send all the book information and location

    

    
    
    
    
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Success"
                                                                  message:@"You successfullly post a book, you may get a request soon~"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* backButton = [UIAlertAction actionWithTitle:@"Back to HomePage"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
    {
        // call method whatever u need
        [self performSegueWithIdentifier:@"PostSuccessOK" sender:nil];
        
    }];
    
    UIAlertAction* libraryButton = [UIAlertAction actionWithTitle:@"Go To Library"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
    {

        // call method whatever u need
        [self performSegueWithIdentifier:@"PostSuccessLibrary" sender:nil];
    }];
    
    
    [alert addAction:libraryButton];
    [alert addAction:backButton];
    
    [self presentViewController:alert animated:YES completion:nil];
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
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        currentLong = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        currentLat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        
        
    }
}

@end
