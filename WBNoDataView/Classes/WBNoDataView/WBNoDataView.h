//
//  WBNoDataView.h
//  WBNoDataView
//
//  Created by 王博 on 2019/10/18.
//  Copyright © 2019 王博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
NS_ASSUME_NONNULL_BEGIN

extern NSString * const kWBNoDataViewObserveKeyPath;

@interface WBNoDataView : UIView
+ (UIView *)wb_defaultNoDataViewWithTarget:(UIView *)target Image:(UIImage *)image message:(NSString *)message color:(UIColor *)color offsetY:(CGFloat)offset andButton:(UIButton *)itemButton andSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
