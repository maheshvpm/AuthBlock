//
//  ABWebServiceManager.m
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import "ABWebServiceManager.h"
#import <AFNetworking/AFNetworking.h>
#import "ABParser.h"

@implementation ABWebServiceManager

- ( void )getProducts:( NSString * )urlString
   withSccessResponse:( ProductListResponse )products
  withFailureResponse:( WebServiceFailureResponse )failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json",@"application/x-www-form-urlencoded",nil];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:
                 NSUTF8StringEncoding];

    NSURL *URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];

    [request addValue:@"identity" forHTTPHeaderField:@"Accept-Encoding"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            ABError * serviceError = [[ABError alloc]init];
            serviceError.errorMessage = [error localizedDescription];
            serviceError.errorCode = [error code];
            failure(serviceError);
        } else {

            NSNumber *status = responseObject[@"success"];

            if ( [status boolValue] ) {
                ABParser *parser = [[ABParser alloc]init];

                NSMutableArray * responseArray = [parser parseProductList:responseObject];
                products(responseArray);
            }
            else {

                ABError * serviceError = [[ABError alloc]init];
                serviceError.errorMessage = responseObject[@"message"];
                failure(serviceError);
            }
        }
    }];
    [dataTask resume];
}

@end
