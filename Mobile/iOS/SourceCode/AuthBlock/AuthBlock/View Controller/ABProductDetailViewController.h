//
//  ABProductDetailViewController.h
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 19/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABProductDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *productDetailTableView;


@end
