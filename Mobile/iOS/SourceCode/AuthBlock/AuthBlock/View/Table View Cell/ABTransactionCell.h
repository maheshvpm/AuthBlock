//
//  ABTransactionCell.h
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 22/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTransactionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *txID;
@property (weak, nonatomic) IBOutlet UILabel *txType;
@property (weak, nonatomic) IBOutlet UILabel *txInvoked;
@property (weak, nonatomic) IBOutlet UILabel *txOldData;
@property (weak, nonatomic) IBOutlet UILabel *txNewData;
@property (weak, nonatomic) IBOutlet UILabel *txDate;
@property (weak, nonatomic) IBOutlet UILabel *currentOwner;

@end
