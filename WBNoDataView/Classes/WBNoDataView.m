//
//  WBNoDataView.m
//  WBNoDataView
//
//  Created by 王博 on 2019/10/18.
//  Copyright © 2019 王博. All rights reserved.
//

#import "WBNoDataView.h"
#import "UIView+Frame.h"

NSString *const kWBNoDataViewObserveKeyPath = @"frame";

@implementation WBNoDataView
+ (UIView *)defaultNoDataViewWithTarget:(UIView *)target
                                  Image:(UIImage *)image
                                message:(NSString *)message
                                  color:(UIColor *)color
                                offsetY:(CGFloat)offset
                              andButton:(UIButton *)itemButton
                                andSize:(CGSize)size {
    CGFloat sW = target.bounds.size.width;
    CGFloat cX = sW / 2;
    CGFloat cY = target.bounds.size.height * (1 - 0.618) + offset;

    CGFloat iW = 80; // image.size.width;
    CGFloat iH = 89; // image.size.height;
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        iW = size.width;
        iH = size.height;
    }
    CGRect frame = CGRectMake(cX - iW / 2, cY - iH / 2, iW, iH);
    //  图片
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = frame;
    imgView.image = image;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    //  文字
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = color;
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame) + 16, sW, label.font.lineHeight);

    //  视图
    WBNoDataView *view = [[WBNoDataView alloc] init];
    [view addSubview:imgView];
    [view addSubview:label];

    if (itemButton != nil) {
        itemButton.x = label.centerX - itemButton.width / 2;
        itemButton.y = label.y + label.height + 8;
        [view addSubview:itemButton];
    }

    //  实现跟随 TableView 滚动
    [view addObserver:target forKeyPath:kWBNoDataViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];

    return view;
}
@end
