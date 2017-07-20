//
//  MyRequestsTableViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "MyRequestsTableViewController.h"
#import "MyRequestsTableViewCell.h"

@interface MyRequestsTableViewController ()

@end

@implementation MyRequestsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    title = [NSMutableArray arrayWithObjects:@"Fovernance of Security Systems",@"The Astronomical Ephemeris",@"Brown's Boundary Control and Legal Principles", nil];
    
    
    
    user = [NSMutableArray arrayWithObjects:@"user1",@"user2",@"user3",nil];
    
    imageURL = [NSMutableArray arrayWithObjects:@"https://books.google.com/books/content?id=fiAinQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",@"http://books.google.com/books/content?id=zBk8AQAAMAAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",@"http://books.google.com/books/content?id=E5k3AgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",nil];
    
    status = [NSMutableArray arrayWithObjects:@"pending",@"done",@"pending", nil];
    
    
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
    return user.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyRequestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myRequestsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.myRequestsBookTitle.text = title[indexPath.row];
    cell.myRequestsToUsername.text = user[indexPath.row];
    cell.myRequestsStatus.text = status[indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageURL[indexPath.row]]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    cell.myRequestsImageView.image = image;
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
