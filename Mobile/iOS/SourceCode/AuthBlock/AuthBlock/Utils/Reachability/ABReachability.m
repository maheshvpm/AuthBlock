//
//  ABReachability.m
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import "ABReachability.h"
#import <AFNetworking/AFNetworking.h>

@implementation ABReachability

+ ( BOOL )checkInternetConnection
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
