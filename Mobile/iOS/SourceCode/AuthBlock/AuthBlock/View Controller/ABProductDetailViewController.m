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
#import "ABSellerInfoCell.h"
#import "ABCertificationCell.h"

typedef NS_ENUM(NSInteger, ProductDetailSections) {
    ProductImage,
    ProductDescription,
    SellerInfo,
    Certification
};

@interface ABProductDetailViewController () <ABProductVerifyDelegate>

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

- (IBAction)shareAction:(id)sender {
    if (self.product != nil) {
        NSString *title = self.product.productName;
        NSURL *imageURL = [NSURL URLWithString:self.product.productImageURL];
        NSArray *objectsToShare = @[title, imageURL];
    
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        activityVC.popoverPresentationController.sourceView = self.view;
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}

//MARK:- Tableview Datasource and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case ProductImage:
            return self.view.frame.size.height * 0.4;
        case ProductDescription:
            return self.view.frame.size.height * 0.15;
        case SellerInfo:
            return self.view.frame.size.height * 0.15;
        case Certification:
            return self.view.frame.size.height * 0.1;
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case SellerInfo:
            return 50;
        default:
            return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case SellerInfo: {
            UIView *headerView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 50)];
            [label setFont:[UIFont boldSystemFontOfSize:18]];
            NSString *string =@"SELLER INFO";
            [label setText:string];
            [headerView addSubview:label];
            return headerView;
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
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
            [cell.imageView setImageWithURL:[NSURL URLWithString:self.product.productImageURL]];
            return cell;
        }
        case ProductDescription: {
            static NSString *identifier = @"ABProductDescriptionCell";
            ABProductDescriptionCell *cell = (ABProductDescriptionCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.delegate = self;
            cell.productTitle.text = self.product.productName;
            cell.productPrice.text = [NSString stringWithFormat:@"%@",self.product.productPrice];
            return cell;
        }
        case SellerInfo: {
            static NSString *identifier = @"ABSellerInfoCell";
            ABSellerInfoCell *cell = (ABSellerInfoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            return cell;
        }
        case Certification: {
            static NSString *identifier = @"ABCertificationCell";
            ABCertificationCell *cell = (ABCertificationCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
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

-(void)verifyProduct:(NSString *)productId {
    NSLog(@"Verify product for product id:%@", productId);
}

@end
