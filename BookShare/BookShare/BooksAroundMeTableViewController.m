//
//  BooksAroundMeTableViewController.m
//  BookShare
//
//  Created by Dhruv Prakash on 26/07/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "BooksAroundMeTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "BooksAroundMeTableViewCell.h"
#import "RequestBookDetailViewController.h"
@interface BooksAroundMeTableViewController (){
    NSString *currentLat;
    NSString *currentLong;
    NSString *userId;
    NSString *selectedBookIsbn;
}

@end

@implementation BooksAroundMeTableViewController

- (void)viewDidLoad {
    userId = @"4";

    /**************************booksaroundme start***********************/
    
    NSURLSessionConfiguration * configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession
                              sessionWithConfiguration:configuration];
    NSString *urlString = @"http://ec2-54-85-207-189.compute-1.amazonaws.com:4000/booksAroundMe";
    // create HttpURLrequest
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:url
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    
    // Setup the HttpURLRequest Body(Continue…)
    
    NSMutableDictionary *dicData = [[NSMutableDictionary
                                     alloc]init];
    [dicData setValue:@"40.43140843" forKey:@"latitude"];
    [dicData setValue:@"-79.92909952" forKey:@"longitude"];
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
                                        
                                        
                                        NSDictionary* json = [NSJSONSerialization
                                                              JSONObjectWithData:data
                                                              options:kNilOptions
                                                              error:&error];
                                        for(NSString *key in [json allKeys]) {
                                            NSLog(@"%@",[json objectForKey:key]);
                                        }
                                        [super viewDidLoad];
                                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                            
                                            title = [json valueForKeyPath:@"books.title"];
                                            //NSLog(@"%@",title);

                                            imageURL = [json valueForKeyPath:@"books.image_url"];
                                            //NSLog(@"%@",imageURL);
                                            
                                            bookId = [json valueForKeyPath:@"books.id"];
                                            NSLog(@"%@",bookId);
                                            
                                            aroundMeUserId = [json valueForKeyPath:@"books.user_id"];
                                            //NSLog(@"%@",aroundMeUserId);
                                            
                                            aroundMeBookIsbn = [json valueForKeyPath:@"books.isbn"];
                                            //NSLog(@"%@",aroundMeBookIsbn);
                                            
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
    
    
    /**************************booksAroundMe END***********************/
    
    
    
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
    BooksAroundMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookAroundMeCell" forIndexPath:indexPath];
    
     // Configure the cell...
    
    cell.bookAroundMeTitle.text = title[indexPath.row];
    //NSLog(@"%@",bookId[indexPath.row]);
    cell.bookAroundMeId.text = [NSString stringWithFormat:@"%@",bookId[indexPath.row]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageURL[indexPath.row]]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    cell.bookAroundMeImage.image = image;
    

    
    
    
   
    

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if([[segue identifier] isEqualToString:@"showRequestBookDetail"]){
        RequestBookDetailViewController *bookRequestDetailsView = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        int row = (int) [myIndexPath row];
        selectedBookIsbn = aroundMeBookIsbn[row];
        bookRequestDetailsView.requestBookIsbn = selectedBookIsbn;
        bookRequestDetailsView.requestBookId = [NSString stringWithFormat:@"%@",bookId[row]];
        
    }
}

@end
