//
//  ViewController.m
//  Setting
//
//  Created by YILUN XU on 7/18/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "ViewController.h"
#import "settingTableViewCell.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *settingArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //show username in the setting
    self.info.text = _username;
  
    //hide back button
    self.navigationItem.hidesBackButton = YES;
    
    //setting menu
    settingArray = @[@"Library",@"Requests sent by me",@"Requests sent to me",@"Log out"];
    self.tableView.hidden = YES;
    
    
    

    

    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [settingArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    settingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    cell.cellTitle.text = [settingArray objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SettingClicked:(id)sender {
    
    if(self.tableView.hidden == YES){
        self.tableView.hidden = NO;
    }else{
        self.tableView.hidden = YES;
    }
}


@end
