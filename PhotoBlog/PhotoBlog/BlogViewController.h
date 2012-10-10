//
//  PBViewController.h
//  PhotoBlog
//
//  Created by Zhijun Ding on 10/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTThumbsViewController.h"

@class BlogDataSource;

@interface BlogViewController : KTThumbsViewController
{
    @private
    BlogDataSource *images_;
    UIActivityIndicatorView *activityIndicator_;    
}

@end
