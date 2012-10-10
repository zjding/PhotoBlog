//
//  BlogDataSource.h
//  PhotoBlog
//
//  Created by Zhijun Ding on 10/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTPhotoBrowserDataSource.h"

@interface BlogDataSource : NSObject <KTPhotoBrowserDataSource> {
    NSMutableArray *posts_;
}

@property (nonatomic, retain) NSString *nextToken;
@property (nonatomic) NSInteger offset;

//-(void) reload;
//-(void) loadMore;

@end
