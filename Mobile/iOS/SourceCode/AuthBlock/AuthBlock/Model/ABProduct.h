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

@property ( nonatomic, strong ) NSString *name;
@property ( nonatomic, strong ) ABHistory *history;

@end
