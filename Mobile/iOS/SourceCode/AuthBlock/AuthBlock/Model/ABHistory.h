//
//  ABHistory.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABHistory : NSObject

@property ( nonatomic, strong ) NSString *transactionDate;
@property ( nonatomic, strong ) NSString *previousOwner;
@property ( nonatomic, strong ) NSString *currentOwner;

@end
