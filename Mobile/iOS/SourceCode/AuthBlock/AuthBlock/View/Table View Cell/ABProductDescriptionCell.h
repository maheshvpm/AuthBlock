//
//  ABProductDescriptionCell.h
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 21/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ABProductVerifyDelegate < NSObject >

- (void)verifyProduct:(NSString *)productId;

@end

@interface ABProductDescriptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;

@property (nonatomic, weak) id <ABProductVerifyDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *productDesciption;

@end
