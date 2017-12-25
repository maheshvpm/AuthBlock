//
//  ABHistoryViewController.h
//  AuthBlock
//
//  Created by Ramesh D on 12/20/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property ( nonatomic, strong )NSMutableArray *transactions;
@property ( nonatomic, strong )NSString *productID;
@end
