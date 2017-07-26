//
//  RequestsReceivedTableViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/25/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "RequestsReceivedTableViewController.h"
#import "RequestsReceivedTableViewCell.h"

@interface RequestsReceivedTableViewController () {
    NSString *toUserId;
    NSDictionary *requestsReceivedJson;
}

@end

@implementation RequestsReceivedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    toUserId = @"123";
    
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
    cell.acceptorWantsBook.text = acceptorWantsBook[indexPath.row];
    cell.requestorWantsBook.text = requestorWantsBook[indexPath.row];
    cell.statusReceived.text = statusReceived[indexPath.row];
    cell.usernameReceived.text = usernameReceived[indexPath.row];
    if([statusReceived[indexPath.row] isEqualToString:@"pending"]){
        cell.statusImage.image = [UIImage imageNamed:@"pending.png"];
    }else if([statusReceived[indexPath.row] isEqualToString:@"approved"]){
        cell.statusImage.image = [UIImage imageNamed:@"success.png"];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
