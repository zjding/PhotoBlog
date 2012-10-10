//
//  AmazonClientManager.h
//  PhotoBlog
//
//  Created by Zhijun Ding on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import <AWSiOSSDK/SimpleDB/AmazonSimpleDBClient.h>

#define ACCESS_KEY_ID                @"0169PEE8C9TAM3SJH202"
#define SECRET_KEY                   @"3OrelQ7ckVMMjIXVsuEyz2rJ3Omp6Q5AfExCdmKh"

@interface AmazonClientManager : NSObject {
    
}

+(AmazonS3Client *)s3;
+(AmazonSimpleDBClient *)sdb;

@end