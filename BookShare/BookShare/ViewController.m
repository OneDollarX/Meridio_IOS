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

@interface ViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *settingArray;

    
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
  
    //hide back button
    self.navigationItem.hidesBackButton = YES;
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SettingClicked:(id)sender {
    
//    if(self.tableView.hidden == YES){
//        self.tableView.hidden = NO;
//    }else{
//        self.tableView.hidden = YES;
//        
//    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    

    
    
}


@end
