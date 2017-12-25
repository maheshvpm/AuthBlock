//
//  ABHistory.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABHistory : NSObject

@property ( strong, nonatomic ) NSString *txID;
@property ( strong, nonatomic ) NSString *txType;
@property ( strong, nonatomic ) NSString *txInvoked;
@property ( strong, nonatomic ) NSString *txOldData;
@property ( strong, nonatomic ) NSString *txNewData;
@property ( strong, nonatomic ) NSString *txDate;
@property ( strong, nonatomic ) NSString *currentOwner;

@end
