//
//  ABTransactionCell.h
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 22/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTransactionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *transactionDate;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *sellerName;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
