//
//  ABProductDescriptionCell.h
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 21/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABProductDescriptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;

@end
