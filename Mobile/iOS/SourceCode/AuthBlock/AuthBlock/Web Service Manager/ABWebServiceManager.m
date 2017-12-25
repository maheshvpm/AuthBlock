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

#define KBaseURL @"http://172.24.212.116:3000/api/"

@implementation ABWebServiceManager

- ( void )getProductsWithSccessResponse:( ProductListResponse )products
                    withFailureResponse:( WebServiceFailureResponse )failure
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json",@"application/x-www-form-urlencoded",nil];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@Product",KBaseURL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];

    [request addValue:@"identity" forHTTPHeaderField:@"Accept-Encoding"];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

        if (error) {

            ABError * serviceError = [[ABError alloc]init];
            serviceError.errorMessage = [error localizedDescription];
            serviceError.errorCode = [error code];
            failure(serviceError);

        } else {

            ABParser *parser = [[ABParser alloc]init];
            NSMutableArray * responseArray = [parser parseProductList:responseObject];
            products(responseArray);

        }
    }];
    [dataTask resume];
}

- ( void )getTransactions:( NSString * )productID
      withSuccessResponse:( TransactionsResponse )transactions
      withFailureResponse:( WebServiceFailureResponse )failure
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json",@"application/x-www-form-urlencoded",nil];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@Product/%@",KBaseURL,productID]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [request addValue:@"identity" forHTTPHeaderField:@"Accept-Encoding"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {

            ABError * serviceError = [[ABError alloc]init];
            serviceError.errorMessage = [error localizedDescription];
            serviceError.errorCode = [error code];
            failure(serviceError);

        } else {

            ABParser *parser = [[ABParser alloc]init];
            NSMutableArray * responseArray = [parser parseTransactionHistory:responseObject];
            transactions(responseArray);

        }
    }];
    [dataTask resume];
}

- ( void )getSellerInfo:( NSString * )userId
    withSuccessResponse:( SellerInformation )info
    withFailureResponse:( WebServiceFailureResponse )failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json",@"application/x-www-form-urlencoded",nil];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@User/%@",KBaseURL,userId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [request addValue:@"identity" forHTTPHeaderField:@"Accept-Encoding"];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

        if (error) {

            ABError * serviceError = [[ABError alloc]init];
            serviceError.errorMessage = [error localizedDescription];
            serviceError.errorCode = [error code];
            failure(serviceError);

        } else {

            ABParser *parser = [[ABParser alloc]init];
            ABUser *user = [parser parseSellerInfo:responseObject];
            info(user);

        }
    }];
    [dataTask resume];
}


@end
