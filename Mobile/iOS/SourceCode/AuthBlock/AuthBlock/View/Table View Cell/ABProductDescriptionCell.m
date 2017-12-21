//
//  ABProductDescriptionCell.m
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 21/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABProductDescriptionCell.h"

@implementation ABProductDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.verifyBtn.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)verifyBtnAction:(id)sender {
    [self.delegate verifyProduct:@""];
}

@end
