//
//  RequestBookDetailViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/28/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "RequestBookDetailViewController.h"
#import "LibraryTableViewCell.h"
#import "LibraryTableViewController.h"

@interface RequestBookDetailViewController () {
    NSString * fromUserId;
}



@end

@implementation RequestBookDetailViewController


- (void)viewDidLoad {
    fromUserId = @"1";
    [super viewDidLoad];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LibraryTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"checkLibrary"];
    
//    NSInteger a = controller.tableView.numberOfSections;
//    NSLog(@"%li",(long)a);
//    //- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

    
    
    
    // Do any additional setup after loading the view.
    NSLog(@"this is the isbn passed from booksAroundMe%@",_requestBookIsbn);
    NSLog(@"this is the id passed from booksAroundMe%@",_requestBookId);


    
    // convert to JSON
    NSError *myError = nil;
    NSString *url_bookDetail =[NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=%@",_requestBookIsbn];
    NSData *dataBook = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_bookDetail]];
    NSDictionary *resultBook = [NSJSONSerialization JSONObjectWithData:dataBook options:kNilOptions error:&myError];

    
    //bookTitle
    NSArray *bookTitle = [resultBook valueForKeyPath:@"items.volumeInfo.title"];
    NSLog(@"%@",bookTitle[0]);
    self.requestBookTitle.text = [NSString stringWithFormat:@"%@",bookTitle[0]];

    
    
    
    //bookDescription
    NSArray *bookDescription = [resultBook valueForKeyPath:@"items.volumeInfo.description"];
    NSLog(@"%@",bookDescription[0]);
    if([bookDescription[0] isKindOfClass:[NSNull class]]){
        self.requestBookDescription.text = @"Description is not available for now.";

    }else{
        self.requestBookDescription.text = [NSString stringWithFormat:@"%@",bookDescription[0]];

    }
    

    
    
    //bookCategories
    NSArray *bookCategories = [resultBook valueForKeyPath:@"items.volumeInfo.categories"];
    NSLog(@"%@",bookCategories[0]);
    if([bookCategories[0] isKindOfClass:[NSNull class]]){
        self.requestBookCategories.text = @"Categories is not available for now.";
    }else{
        NSArray *bookCategories2 = bookCategories[0];
        NSLog(@"%@",bookCategories2[0]);
        if([bookCategories2[0] isKindOfClass:[NSNull class]]){
            self.requestBookCategories.text = @"Categories is not available for now.";
        }else{
            self.requestBookCategories.text = [NSString stringWithFormat:@"%@",bookCategories2[0]];
        }
    }
    
    
    //image
    NSArray *bookImageLinks = [resultBook valueForKeyPath:@"items.volumeInfo.imageLinks.smallThumbnail"];
    NSLog(@"%@",bookImageLinks[0]);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",bookImageLinks[0]]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self.requestBookImageView setImage:image];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reqeustBook:(id)sender {
    
    
    
    /**************************Create Request Start***********************/
    
    
    // Setup the session
    NSURLSessionConfiguration * configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession
                              sessionWithConfiguration:configuration];
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-54-85-207-189.compute-1.amazonaws.com:4000/createTradeRequest"];
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
    
    
    
    [dicData setValue:fromUserId forKey:@"fromUserId"];
    [dicData setValue:_requestBookId forKey:@"requestorWantsBookId"];

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
    
    
    /**************************Create Request End***********************/
    
    /******************************alert start*****************************/
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Success"
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* goButton = [UIAlertAction actionWithTitle:@"Go to Main Page"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   
                                   // call method whatever u need
                                   [self performSegueWithIdentifier:@"requestMain" sender:nil];
                               }];
    

    
    [alert addAction:goButton];

    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    /******************************alert end ******************************/
}
@end
