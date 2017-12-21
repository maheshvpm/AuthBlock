//
//  ABParser.m
//  AuthBlock
//
//  Created by Logu Subramaniyan on 16/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABParser.h"
#import "ABProduct.h"

@implementation ABParser

- ( NSMutableArray * )parseProductList:( NSDictionary * )response
{
    NSMutableArray *products = [[NSMutableArray alloc]init];
    
    if (response)
    {
        for (NSDictionary *dict in response[@"orders"])
        {
            ABProduct *product = [[ABProduct alloc]init];
            product.productName = dict[@"product_name"];
            product.productDescription = dict[@"product_description"];
            product.productPrice = dict[@"product_price"];
            product.productImageURL = dict[@"product_image"];
            [products addObject:product];
        }
    }
    return products;
}

@end
