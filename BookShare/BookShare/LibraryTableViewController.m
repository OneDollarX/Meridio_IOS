//
//  LibraryTableViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//yyyy

#import "LibraryTableViewController.h"
#import "LibraryTableViewCell.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LibraryTableViewController () {
    NSString *userId;
    NSDictionary *infoJson;
    
}

@end

@implementation LibraryTableViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.navigationItem.hidesBackButton = YES;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    userId = [defaults valueForKey:@"USER_ID"];
    
    //userId = @"1";
    
    /**************************tool bar***********************/
    
    
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
    /**************************tool bar ***********************/
    
    /**************************getmybooks start***********************/
    
    
    // Setup the session
    NSURLSessionConfiguration * configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession
                              sessionWithConfiguration:configuration];
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-54-85-207-189.compute-1.amazonaws.com:4000/getMyBooks"];
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
    [dicData setValue:userId forKey:@"userId"];

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
                                        
                                        
                                        infoJson = [NSJSONSerialization
                                                              JSONObjectWithData:data
                                                              options:kNilOptions
                                                              error:&error];
                                        for(NSString *key in [infoJson allKeys]) {
                                            NSLog(@"%@",[infoJson objectForKey:key]);
                                        }
                                        [super viewDidLoad];
                                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                title = [infoJson valueForKeyPath:@"books.title"];
                                                NSLog(@"%@",title);
                                                categories = [infoJson valueForKeyPath:@"books.genre"];
                                                NSLog(@"%@",categories);
                                                imageURL = [infoJson valueForKeyPath:@"books.imageUrl"];
                                                NSLog(@"%@",imageURL);
                                                bookId = [infoJson valueForKeyPath:@"books.bookId"];
                                                NSLog(@"%@",bookId);

                                            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
                                        });
                            
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
    
    
    /**************************getmybooks END***********************/
    


    
    
    
//    title = [NSMutableArray arrayWithObjects:@"Fovernance of Security Systems",@"The Astronomical Ephemeris",@"Brown's Boundary Control and Legal Principles", nil];
//    NSLog(@"this is the titles %@",title);
//
//    
//    
//    categories = [NSMutableArray arrayWithObjects:@"Crime prevention",@"Ephemerides",@"Technology & Engineering",nil];
//    
//    imageURL = [NSMutableArray arrayWithObjects:@"https://books.google.com/books/content?id=fiAinQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",@"http://books.google.com/books/content?id=zBk8AQAAMAAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",@"http://books.google.com/books/content?id=E5k3AgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return title.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"libraryCell" forIndexPath:indexPath];
    
    // Configure the cell...

    cell.bookLibraryId.hidden = YES;
    cell.bookLibraryTitle.text = title[indexPath.row];
    cell.bookLibraryCategories.text = categories[indexPath.row];
    cell.bookLibraryId.text = [NSString stringWithFormat:@"%@",bookId[indexPath.row]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageURL[indexPath.row]]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    cell.bookLibraryImageView.image = image;
    

    
    return cell;
}






// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Perform the real delete action here. Note: you may need to check editing style
//    //   if you do not perform delete only.
//    NSLog(@"Deleted row.");
//
//}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSLog(@"%@",bookId[indexPath.row]);
        [self deleteBook:bookId[indexPath.row]];
        [self viewDidLoad];
        
        
        
        
        
        //[title removeObjectAtIndex:indexPath.row];//or something similar to this based on your data source array structure
        //remove the corresponding object from your data source array before this or else you will get a crash

        
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)refresh:(id)sender {
    [self viewDidLoad];
}



-(void)deleteBook:(NSString *)deleteBookId{
    
    
    // Setup the session
    NSURLSessionConfiguration * configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession
                              sessionWithConfiguration:configuration];
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-54-85-207-189.compute-1.amazonaws.com:4000/deleteBook"];
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
    [dicData setValue:deleteBookId forKey:@"bookId"];
    
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
                                        
                                        
                                        infoJson = [NSJSONSerialization
                                                    JSONObjectWithData:data
                                                    options:kNilOptions
                                                    error:&error];
                                        
                                        for(NSString *key in [infoJson allKeys]) {
                                            NSLog(@"%@",[infoJson objectForKey:key]);
                                        }
                                        if([[infoJson objectForKey:@"status"] isEqualToString:@"success"]){
                                            NSLog(@"delete successfully");

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
    [self viewDidLoad];
    
}



-(void)libraryClicked{
    
}
-(void)requestSentClicked{
    [self performSegueWithIdentifier:@"LibraryToRequestSent" sender:nil];
    
}
-(void)requestReceivedClicked{
    [self performSegueWithIdentifier:@"LibraryToRequestReceived" sender:nil];
    
}
-(void)logoutClicked{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [self performSegueWithIdentifier:@"LibraryToLogIn" sender:nil];
    
}
-(void)mainClicked{
    [self performSegueWithIdentifier:@"LibraryToMain" sender:nil];
}



@end
