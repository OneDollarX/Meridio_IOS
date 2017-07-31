//
//  ViewController.m
//  Constant
//
//  Created by YILUN XU on 7/31/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@"123456" forKey:@"USER_ID"];
    [defaults synchronize];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
