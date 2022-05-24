//
//  IViewNoData.h
//  WBNoDataView
//
//  Created by 王博 on 2019/10/18.
//  Copyright © 2019 王博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

#define KpageSize 10
@protocol IViewNoData <NSObject>
@optional

/// 完全自定义占位图
- (UIView *)wb_noDataView;

/// 使用默认占位图, 提供一张图片,    可不提供, 默认不显示
- (UIImage *)wb_noDataViewImage;

/// 使用默认占位图, 提供显示文字,    可不提供, 默认为暂无数据
- (NSString *)wb_noDataViewMessage;

/// 使用默认占位图, 提供显示文字颜色, 可不提供, 默认为灰色
- (UIColor *)wb_noDataViewMessageColor;

/// 使用默认占位图, CenterY 向下的偏移量
- (NSNumber *)wb_noDataViewCenterYOffset;

/// 自定义展位图按钮
- (UIButton *)wb_noDataViewButton;

/// 判断是否有数据
- (BOOL)wb_havData;

- (BOOL)wb_havData:(UIScrollView *)scrollView;

/// 外部提供NodataView Size
- (NSValue *)wb_noDataViewSize;

@end

NS_ASSUME_NONNULL_END
