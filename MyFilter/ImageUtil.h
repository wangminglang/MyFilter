//
//  ImageUtil.h
//  MyFilter
//
//  Created by WangMinglang on 16/2/24.
//  Copyright © 2016年 好价. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtil : NSObject

+ (UIImage *)imageWithImage:(UIImage *)image withColorMatrix:(const float*)f;

@end
