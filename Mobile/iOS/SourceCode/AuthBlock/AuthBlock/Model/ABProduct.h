//
//  ABProduct.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABHistory.h"

@interface ABProduct : NSObject

@property ( nonatomic, strong ) NSString *productName;
@property ( nonatomic, strong ) NSString *productDescription;
@property ( nonatomic, strong ) NSNumber *productPrice;
@property ( nonatomic, strong ) NSString *productImageURL;
@property ( nonatomic, strong ) NSNumber *productSKUID;
@property ( nonatomic, strong ) NSNumber *produdtId;
@property ( nonatomic, strong ) NSArray *productPreviousOwner;
@property ( nonatomic, strong ) NSArray *productPriceHistory;
@property ( nonatomic, strong ) NSString *productHolder;

@end
