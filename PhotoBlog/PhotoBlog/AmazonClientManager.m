//
//  AmazonClientManager.m
//  PhotoBlog
//
//  Created by Zhijun Ding on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "AmazonClientManager.h"

static AmazonS3Client       *s3  = nil;
static AmazonSimpleDBClient *sdb = nil;

@implementation AmazonClientManager

+(AmazonS3Client *)s3
{
    if (s3 == nil) {
        s3 = [[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY];
    }
    
    return s3;
}

+(AmazonSimpleDBClient *)sdb
{
    if (sdb == nil) {
        sdb = [[AmazonSimpleDBClient alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY];
    }
    
    return sdb;
}

@end
