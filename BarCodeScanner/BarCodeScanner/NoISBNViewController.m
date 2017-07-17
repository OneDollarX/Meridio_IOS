//
//  NoISBNViewController.m
//  BarCodeScanner
//
//  Created by YILUN XU on 7/10/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "NoISBNViewController.h"
#import "BookDetailsViewController.h"

@interface NoISBNViewController ()

@end

@implementation NoISBNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.goButton.enabled = NO;


    
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
    
    if([[segue identifier] isEqualToString:@"NoISBN"]){
        BookDetailsViewController *bookDetailsView = [segue destinationViewController];
        bookDetailsView.bookISBN = [NSString stringWithFormat:@"%@",self.inputISBNTextView.text];
        
    }
    
}



@end
