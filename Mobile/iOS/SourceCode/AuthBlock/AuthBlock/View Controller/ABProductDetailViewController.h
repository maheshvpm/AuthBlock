//
//  ABProductDetailViewController.h
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 19/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABProduct.h"
#import "UIImageView+AFNetworking.h"
#import "ABUser.h"

@interface ABProductDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *productDetailTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareBtn;

@property ( nonatomic, strong ) ABProduct *product;
@property ( nonatomic, strong ) ABUser *sellerInfo;

@end
