//
//  ABProductListCell.m
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 19/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABProductListCell.h"

@implementation ABProductListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.productImageView.layer.cornerRadius = 50.0f;
    self.productImageView.layer.borderWidth = 2.0f;
    self.productImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.productImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
