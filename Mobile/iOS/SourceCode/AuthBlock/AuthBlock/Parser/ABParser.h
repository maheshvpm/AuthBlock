//
//  ABParser.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABUser.h"

@interface ABParser : NSObject

- ( NSMutableArray * )parseProductList:( NSDictionary * )response;
- ( NSMutableArray * )parseTransactionHistory:( NSDictionary * )response;
- ( ABUser * )parseSellerInfo:( NSDictionary * )response;

@end
