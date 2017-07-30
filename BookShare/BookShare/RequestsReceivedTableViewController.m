//
//  RequestsReceivedTableViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/25/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "RequestsReceivedTableViewController.h"
#import "RequestsReceivedTableViewCell.h"
#import "UserLibraryTableViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface RequestsReceivedTableViewController () {
    NSString *toUserId;
    NSDictionary *requestsReceivedJson;
}

@end

@implementation RequestsReceivedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.navigationItem.hidesBackButton = YES;
    

    toUserId = @"1";
    
    
    
    
    
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
    
    
    
    
    
    /**************************requests received start***********************/
    
    
    // Setup the session
    NSURLSessionConfiguration * configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession
                              sessionWithConfiguration:configuration];
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-54-85-207-189.compute-1.amazonaws.com:4000/getTradeRequests"];
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
    [dicData setValue:toUserId forKey:@"toUserId"];
    
    NSError *error;
    NSData *postData = [NSJSONSerialization
                        dataWithJSONObject:dicData options:0 error:&error];
    [request setHTTPBody:postData];
    NSLog(@"here");
    
    
    
    // Create a data task to transfer the web service endpoint contents
    NSURLSessionUploadTask * dataTask
    = [session uploadTaskWithRequest:request
                            fromData:postData completionHandler:^(NSData *data,
                                                                  NSURLResponse *response, NSError *error) {
                                
                                
                                
                                if (!error) {
                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
                                    NSLog(@"%li",(long)httpResponse.statusCode);
                                    if (httpResponse.statusCode == 200) {
                                        
                                        
                                        requestsReceivedJson = [NSJSONSerialization
                                                            JSONObjectWithData:data
                                                            options:kNilOptions
                                                            error:&error];
                                        for(NSString *key in [requestsReceivedJson allKeys]) {
                                            NSLog(@"%@",[requestsReceivedJson objectForKey:key]);
                                        }
                                        [super viewDidLoad];
                                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                            
                                            requestorWantsBook = [requestsReceivedJson valueForKeyPath:@"tradeRequests.requestorWantsBook"];
                                            NSLog(@"%@",requestorWantsBook);
                                            acceptorWantsBook = [requestsReceivedJson valueForKeyPath:@"tradeRequests.acceptorWantsBook"];
                                            NSLog(@"%@",requestorWantsBook);
                                            statusReceived = [requestsReceivedJson valueForKeyPath:@"tradeRequests.status"];
                                            NSLog(@"%@",statusReceived);
                                            usernameReceived = [requestsReceivedJson valueForKeyPath:@"tradeRequests.fromUserId"];
                                            NSLog(@"%@",usernameReceived);
                                            tradeId = [requestsReceivedJson valueForKeyPath:@"tradeRequests.id"];
                                            NSLog(@"%@",tradeId);
                                            
                                            fromEmail = [requestsReceivedJson valueForKeyPath:@"tradeRequests.fromEmail"];
                                            NSLog(@"%@",fromEmail);
                                            
                                            
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
    
    
    /**************************requests received end***********************/
    
    
    /****************************hardcode start****************************/
    
//        requestorWantsBook = [NSMutableArray arrayWithObjects:@"Fovernance of Security Systems",@"The Astronomical Ephemeris",@"Brown's Boundary Control and Legal Principles", nil];
//    
//        tradeId = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
//        acceptorWantsBook = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
//    
//    
//    
//        usernameReceived = [NSMutableArray arrayWithObjects:@"4",@"5",@"123",nil];
//    
//
//    
//        statusReceived = [NSMutableArray arrayWithObjects:@"pending",@"pending",@"pending", nil];
    /****************************hardcode end****************************/
    

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
    return usernameReceived.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RequestsReceivedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RequestsReceivedCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.acceptTitle.hidden = YES;
    cell.acceptorWantsBook.hidden = YES;
    cell.acceptorWantsBook.text = [NSString stringWithFormat:@"%@",acceptorWantsBook[indexPath.row]];
    cell.requestorWantsBook.text = [NSString stringWithFormat:@"%@",requestorWantsBook[indexPath.row]];
    cell.statusReceived.text = statusReceived[indexPath.row];
    //cell.usernameReceived.text = [NSString stringWithFormat:@"%@",usernameReceived[indexPath.row]];
    cell.usernameReceived.text = fromEmail[indexPath.row];
    
    if([statusReceived[indexPath.row] isEqualToString:@"pending"]){
        cell.statusImage.image = [UIImage imageNamed:@"pending.png"];
    }else if([statusReceived[indexPath.row] isEqualToString:@"approved"]){
        cell.statusImage.image = [UIImage imageNamed:@"success.png"];
        cell.acceptTitle.hidden = NO;
        cell.acceptorWantsBook.hidden = NO;
        
    }else{
        cell.statusImage.image = [UIImage imageNamed:@"decline.png"];
    }
    
    
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageURL[indexPath.row]]];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [UIImage imageWithData:data];
//    cell.myRequestsImageView.image = image;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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



-(void)libraryClicked{
    [self performSegueWithIdentifier:@"RequestReceivedToLibrary" sender:nil];
    
}
-(void)requestSentClicked{
    [self performSegueWithIdentifier:@"RequestReceivedToRequestSent" sender:nil];
    
}
-(void)requestReceivedClicked{

    
}
-(void)logoutClicked{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [self performSegueWithIdentifier:@"RequestReceivedToLogIn" sender:nil];
    
}
-(void)mainClicked{
    [self performSegueWithIdentifier:@"RequestReceivedToMain" sender:nil];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"showUserLibrary"]){
        UserLibraryTableViewController *userLibraryView = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        int row = (int) [myIndexPath row];
        NSLog(@"%@",usernameReceived[row]);
        
        userLibraryView.receivedUserId = usernameReceived[row];
        userLibraryView.receivedTradeId = tradeId[row];
        userLibraryView.receivedEmail = fromEmail[row];
    }
    
    
    
}


@end
