//
//  ABProductDetailViewController.m
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 19/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABProductDetailViewController.h"
#import "ABProductDetailImageCell.h"
#import "ABProductDescriptionCell.h"

typedef NS_ENUM(NSInteger, ProductDetailSections) {
    ProductImage,
    ProductDescription
};

@interface ABProductDetailViewController ()

@end

@implementation ABProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productDetailTableView.dataSource = self;
    self.productDetailTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK:- Tableview Datasource and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case ProductImage:
            return self.view.frame.size.height * 0.4;
        case ProductDescription:
            return self.view.frame.size.height * 0.2;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case ProductImage: {
            static NSString *identifier = @"ABProductDetailImageCell";
            ABProductDetailImageCell *cell = (ABProductDetailImageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            return cell;
        }
        case ProductDescription: {
            static NSString *identifier = @"ABProductDescriptionCell";
            ABProductDescriptionCell *cell = (ABProductDescriptionCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            return cell;
        }
        default: {
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
            return cell;
        }
    }
}

@end
