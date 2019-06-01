//
//  LIView.h
//  test
//
//  Created by sweetloser on 2019/5/31.
//  Copyright © 2019 sweetloser. All rights reserved.
//
/*
 使用方法：
        +(LIView *)CreatLoopImageView:(CGRect)rect Images:(NSArray<UIImage *> *)images;
参数：
    rect：
        轮播图的frame
    images：
        需要轮播的图片的数组
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LIView : UIView
+(LIView *)CreatLoopImageView:(CGRect)rect Images:(NSArray<UIImage *> *)images;
@end

NS_ASSUME_NONNULL_END
