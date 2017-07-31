//
//  PopOverViewController.m
//  PopOverMenu
//
//  Created by YILUN XU on 7/31/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "PopOverViewController.h"


@interface PopOverViewController ()

/* Array to hold the options for different color type */
@property (strong, nonatomic) NSMutableArray *nums;

/* Array to hold the options for different font type */
@property (strong, nonatomic) NSMutableArray *letters;

@end

@implementation PopOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Initialize the table and arrays with options
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    // Below line for scroll enabling is optional
    self.myTableView.scrollEnabled = NO;
    
    // Initialize both arrays with default values
    self.nums = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
    self.letters = [[NSMutableArray alloc] initWithObjects:@"A",@"B", nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

/* We will have two sections for colors and font types */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

/* Set the header for each sections */
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"NUMBERS";
    else
        return @"LETTERS";
}

/* Set the number of rows for each section. Section 1 contains row for nums and section 2 for nums
 Notice that for section 1, index is 0 and for section 2, index is 1
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return self.nums.count;
    else {
        return self.letters.count;
    }
}


#pragma mark - Table view delegate


/* Set the cell title depending on section. For section 1, set the cell labels as defined in color array and for section 2, set the cell labels as defined in font array */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if (indexPath.section == 0)
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.nums[indexPath.row]];
    else
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.letters[indexPath.row]];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /* Inform the delegate when a row is selected (an event) with what is choosen.
     Send the choosen cell label (either color or font) and what to do (either change color or font)
     For example if 1st row in 1st section is choosen, delegate call will be:
     [_delegate performAction:@"yellow" andChange:@"color"];
     
     */
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            NSLog(@"1");
            [self performSegueWithIdentifier:@"one" sender:nil];
            
        }else{
            NSLog(@"2");
            [self performSegueWithIdentifier:@"two" sender:nil];
        }
    }else{
        if(indexPath.row == 0){
            NSLog(@"A");
            [self performSegueWithIdentifier:@"A" sender:nil];
        }else{
            NSLog(@"B");
            [self performSegueWithIdentifier:@"B" sender:nil];
        }
    }

    



    
    // Once message is sent to delegate, dismiss the current view controller
    //[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Conent Size for pop over view

/* The following two methods are needed to set the content size of the popover view. Try playing with the width and you will notice the difference */
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.myTableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 150;
        CGSize size = [self.myTableView sizeThatFits:tempSize];
        return size;
    }else {
        return [super preferredContentSize];
    }
}

- (void)setPreferredContentSize:(CGSize)preferredContentSize{
    super.preferredContentSize = preferredContentSize;
}


@end
