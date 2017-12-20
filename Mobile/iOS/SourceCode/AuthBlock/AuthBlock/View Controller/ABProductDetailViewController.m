//
//  ABProductDetailViewController.m
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 19/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABProductDetailViewController.h"

@interface ABProductDetailViewController ()

@end

@implementation ABProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sellerInfoView.layer.borderWidth = 1.0;
    self.sellerInfoView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
