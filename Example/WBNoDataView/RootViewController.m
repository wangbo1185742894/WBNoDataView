//
//  RootViewController.m
//  WBNoDataView
//
//  Created by 王博 on 2019/10/21.
//  Copyright © 2019 王博. All rights reserved.
//

#import "RootViewController.h"
#import "MyTableViewController.h"
#import "MyCollectionViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)actionTableview:(id)sender {
    MyTableViewController *tableVC = [[MyTableViewController alloc]init];
    [self.navigationController pushViewController:tableVC animated:YES];
}


- (IBAction)uicollectionView:(id)sender {
    MyCollectionViewController *tableVC = [[MyCollectionViewController alloc]init];
    [self.navigationController pushViewController:tableVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
