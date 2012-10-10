//
//  BlogDataSource.m
//  PhotoBlog
//
//  Created by Zhijun Ding on 10/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BlogDataSource.h"
#import "AmazonClientManager.h"
#import "Post.h"
#import "ISO8601DateFormatter.h"

#define FULL_SIZE_INDEX 0
#define THUMBNAIL_INDEX 1

@implementation BlogDataSource

@synthesize nextToken;
@synthesize offset;

- (id)init {
    self = [super init];
    if (self) {
        // Create a 2-dimensional array. First element of
        // the sub-array is the full size image URL and 
        // the second element is the thumbnail URL.
//        images_ = [[NSArray alloc] initWithObjects:
//                   [NSArray arrayWithObjects:@"http://farm5.static.flickr.com/4001/4439826859_19ba9a6cfa_o.jpg", @"http://farm5.static.flickr.com/4001/4439826859_4215c01a16_s.jpg", nil],
//                   [NSArray arrayWithObjects:@"http://farm4.static.flickr.com/3427/3192205971_0f494a3da2_o.jpg", @"http://farm4.static.flickr.com/3427/3192205971_b7b18558db_s.jpg", nil],
//                   [NSArray arrayWithObjects:@"http://farm2.static.flickr.com/1316/4722532733_6b73d00787_z.jpg", @"http://farm2.static.flickr.com/1316/4722532733_6b73d00787_s.jpg", nil],
//                   [NSArray arrayWithObjects:@"http://farm2.static.flickr.com/1200/591574815_8a4a732d00_o.jpg", @"http://farm2.static.flickr.com/1200/591574815_29db79a63a_s.jpg", nil],
//                   [NSArray arrayWithObjects:@"http://farm4.static.flickr.com/3610/3439180743_21b8799d82_o.jpg", @"http://farm4.static.flickr.com/3610/3439180743_b7b07df9d4_s.jpg", nil],
//                   [NSArray arrayWithObjects:@"http://farm3.static.flickr.com/2721/4441122896_eec9285a67.jpg", @"http://farm3.static.flickr.com/2721/4441122896_eec9285a67_s.jpg", nil],
//                   nil];
        
//        [posts_ removeAllObjects];
        
        offset = 0;
        posts_ = [[NSMutableArray alloc] init];
        
        NSString *selectExpression = [NSString stringWithFormat:@"select * from Post where ImageTakenTime is not null order by ImageTakenTime desc limit 20"];
        SimpleDBSelectRequest *selectRequest = [[SimpleDBSelectRequest alloc] initWithSelectExpression:selectExpression];
        SimpleDBSelectResponse *selectResponse = [[AmazonClientManager sdb] select:selectRequest];
        self.offset += 20;
        
        for (SimpleDBItem *item in selectResponse.items) {
            Post *post = [[Post alloc] init];
            post.Id = item.name;
            for (SimpleDBAttribute *attr in item.attributes) {
                if ([attr.name isEqualToString:@"UserId"]) {
                    post.UserId = attr.value;
                }
                else if ([attr.name isEqualToString:@"UserName"]) {
                    post.UserName = attr.value;
                }
                else if ([attr.name isEqualToString:@"Title"]) {
                    post.Title = attr.value;
                }
                else if ([attr.name isEqualToString:@"Description"]) {
                    post.Description = attr.value;
                }
                else if ([attr.name isEqualToString:@"PostDateTime"]) {
                    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
                    post.PostDateTime = [formatter dateFromString:attr.value];
                }
                else if ([attr.name isEqualToString:@"ImageCameraModel"]) {
                    post.ImageCameraModel = attr.value;
                }
                else if ([attr.name isEqualToString:@"ImageContentType"]) {
                    post.ImageContentType = attr.value;
                }
                else if ([attr.name isEqualToString:@"ImageExposureTime"]) {
                    post.ImageExposureTime = attr.value;
                }
                else if ([attr.name isEqualToString:@"ImageName"]) {
                    post.ImageName = attr.value;
                }
                else if ([attr.name isEqualToString:@"ImageTakenTime"]) {
                    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
                    post.PostDateTime = [formatter dateFromString:attr.value];
                }
            }
            
            [posts_ addObject:post];
        }

    }
    return self;
}

- (UIImage *)imageWithURLString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

#pragma mark -
#pragma mark KTPhotoBrowserDataSource

- (NSInteger)numberOfPhotos {
    NSInteger count = [posts_ count];
    return count;
}

- (Post *)postAtIndex:(NSInteger)index {
    Post *post = [posts_ objectAtIndex:index];
    
    return post;
}

- (UIImage *)imageAtIndex:(NSInteger)index {
    //NSArray *imageUrls = [posts_ objectAtIndex:index];
    //NSString *url = [imageUrls objectAtIndex:FULL_SIZE_INDEX];
    
    Post *post = [posts_ objectAtIndex:index];
    NSString *url = [NSString stringWithFormat:@"%@%@-%@", @"https://s3.amazonaws.com/Photoblog_Original/", post.Id, post.ImageName];
    return [self imageWithURLString:url];
}

- (UIImage *)thumbImageAtIndex:(NSInteger)index {
    //NSArray *imageUrls = [posts_ objectAtIndex:index];
    //NSString *url = [imageUrls objectAtIndex:THUMBNAIL_INDEX];
    
    Post *post = [posts_ objectAtIndex:index];
    NSString *url = [NSString stringWithFormat:@"%@%@-%@", @"https://s3.amazonaws.com/Photoblog_Resized/", post.Id, post.ImageName];
    
    return [self imageWithURLString:url];
}


@end
