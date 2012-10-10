//
//  Post.h
//  PhotoBlog
//
//  Created by Zhijun Ding on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *UserId;
@property (nonatomic, copy) NSString *UserName;
@property (nonatomic, copy) NSDate *PostDateTime;

@property (nonatomic, copy) NSString *ImageCameraModel;
@property (nonatomic, copy) NSString *ImageContentType;
@property (nonatomic, copy) NSString *ImageExposureTime;
@property (nonatomic, copy) NSString *ImageName;
@property (nonatomic, copy) NSString *ImagePath;
@property (nonatomic, copy) NSDate *ImageTakenTime;

@end

