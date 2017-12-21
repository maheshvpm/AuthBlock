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
@property ( nonatomic, strong ) NSString *productPrice;
@property ( nonatomic, strong ) NSString *productImageURL;

@end
