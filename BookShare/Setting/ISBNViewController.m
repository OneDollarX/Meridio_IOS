//
//  ISBNViewController.m
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "ISBNViewController.h"
#import "BookDetailsViewController.h"

@interface ISBNViewController ()

@end

@implementation ISBNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputISBNTextView.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"ISBNBookDetails"]){
        BookDetailsViewController *bookDetailsView = [segue destinationViewController];
        bookDetailsView.bookISBN = [NSString stringWithFormat:@"%@",self.inputISBNTextView.text];
        
    }
    
}

- (IBAction)goPressed:(id)sender {
    [self performSegueWithIdentifier:@"ISBNBookDetails" sender:nil];
}
@end
