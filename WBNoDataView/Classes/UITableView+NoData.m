//
//  UITableView+NoData.m
//  WBNoDataView
//
//  Created by 王博 on 2019/10/18.
//  Copyright © 2019 王博. All rights reserved.
//

#import "UITableView+NoData.h"

#import "IWBNoDataViewProtocol.h"

#import "WBNoDataView.h"

#import <objc/runtime.h>

@implementation UITableView (NoData)

/**
 加载时, 交换方法
 */
+ (void)load {
    //  只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
        Method wb_reloadData = class_getInstanceMethod(self, @selector(wb_reloadData));
        method_exchangeImplementations(reloadData, wb_reloadData);

        Method dealloc = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
        Method wb_dealloc = class_getInstanceMethod(self, @selector(wb_dealloc));
        method_exchangeImplementations(dealloc, wb_dealloc);
        Method insertSections = class_getInstanceMethod(self, @selector(insertSections:withRowAnimation:));
        Method wb_insertSections = class_getInstanceMethod(self, @selector(wb_insertSections:withRowAnimation:));
        method_exchangeImplementations(insertSections, wb_insertSections);
        
        Method deleteSections = class_getInstanceMethod(self, @selector(insertRowsAtIndexPaths:withRowAnimation:));
        Method wb_deleteSections = class_getInstanceMethod(self, @selector(wb_insertRowsAtIndexPaths:withRowAnimation:));
        method_exchangeImplementations(deleteSections, wb_deleteSections);
        
        Method insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteSections:withRowAnimation:));
        Method wb_insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(wb_deleteSections:withRowAnimation:));
        method_exchangeImplementations(insertItemsAtIndexPaths, wb_insertItemsAtIndexPaths);
        
        Method deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteRowsAtIndexPaths:withRowAnimation:));
        Method wb_deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(wb_deleteRowsAtIndexPaths:withRowAnimation:));
        method_exchangeImplementations(deleteItemsAtIndexPaths, wb_deleteItemsAtIndexPaths);
    });
}

- (void)wb_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self wb_insertSections:sections withRowAnimation:animation];
    [self checkHaveData];
}

- (void)wb_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self wb_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self checkHaveData];
}

- (void)wb_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self wb_deleteSections:sections withRowAnimation:animation];
    [self checkHaveData];
}

- (void)wb_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self wb_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self checkHaveData];
}

/**
 在 ReloadData 的时候检查数据
 */
- (void)wb_reloadData {
    [self wb_reloadData];

    //  忽略第一次加载
    if (![self isInitFinish]) {
        [self wb_havingData:YES];
        [self setIsInitFinish:YES];
        return;
    }
    [self checkHaveData];
}

/**
 在 ReloadData 的时候检查数据
 */
- (void)checkHaveData {
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL havingData = NO;
        NSInteger numberOfSections = [self numberOfSections];
        if ([self.delegate respondsToSelector:@selector(wb_havData)]) {
            havingData = [self.delegate performSelector:@selector(wb_havData)];
        } else if ([self.delegate respondsToSelector:@selector(wb_havData:)]) {
            havingData = [self.delegate performSelector:@selector(wb_havData:) withObject:self];
        } else {
            if (numberOfSections == 0) {
                havingData = NO;
            } else {
                for (NSInteger i = 0; i < numberOfSections; i++) {
                    if ([self numberOfRowsInSection:i] > 0) {
                        havingData = YES;
                        break;
                    }
                }
            }
        }
        [self wb_havingData:havingData];
    });
}

/**
 展示占位图
 */
- (void)wb_havingData:(BOOL)havingData {
    //  不需要显示占位图
    if (havingData) {
        [self freeNoDataViewIfNeeded];
        self.backgroundView = nil;
        return;
    }

    //  不需要重复创建
    if (self.backgroundView) {
        return;
    }

    //  自定义了占位图
    if ([self.delegate respondsToSelector:@selector(wb_noDataView)]) {
        self.backgroundView = [self.delegate performSelector:@selector(wb_noDataView)];
        return;
    }

    //  使用自带
    UIImage *img = [UIImage imageNamed:@""];
    NSString *msg = @"";

    UIColor *color = [UIColor lightGrayColor];
    CGFloat offset = 0;
    UIButton *itemButton;
    CGSize size = CGSizeZero;
    //  获取图片
    if ([self.delegate respondsToSelector:@selector(wb_noDataViewImage)]) {
        img = [self.delegate performSelector:@selector(wb_noDataViewImage)];
    }
    //  获取文字
    if ([self.delegate respondsToSelector:@selector(wb_noDataViewMessage)]) {
        msg = [self.delegate performSelector:@selector(wb_noDataViewMessage)];
    }
    //  获取颜色
    if ([self.delegate respondsToSelector:@selector(wb_noDataViewMessageColor)]) {
        color = [self.delegate performSelector:@selector(wb_noDataViewMessageColor)];
    }
    //  获取偏移量
    if ([self.delegate respondsToSelector:@selector(wb_noDataViewCenterYOffset)]) {
        offset = [[self.delegate performSelector:@selector(wb_noDataViewCenterYOffset)] floatValue];
    }

    //  获取偏移量
    if ([self.delegate respondsToSelector:@selector(wb_noDataViewButton)]) {
        itemButton = [self.delegate performSelector:@selector(wb_noDataViewButton)];
    }
    if ([self.delegate respondsToSelector:@selector(wb_noDataViewSize)]) {
        size = [[self.delegate performSelector:@selector(wb_noDataViewSize)] CGSizeValue];
    }

    if ([self.delegate respondsToSelector:@selector(wb_noDataViewButton)]) {
        itemButton = [self.delegate performSelector:@selector(wb_noDataViewButton)];
    }

    //  创建占位图
    self.backgroundView = [WBNoDataView defaultNoDataViewWithTarget:self
                                                               Image:img
                                                             message:msg
                                                               color:color
                                                             offsetY:offset
                                                           andButton:itemButton
                                                             andSize:size];
}

/**
 监听
 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:kWBNoDataViewObserveKeyPath]) {
        /**
         在 TableView 滚动 ContentOffset 改变时, 会同步改变 backgroundView 的 frame.origin.y
         可以实现, backgroundView 位置相对于 TableView 不动, 但是我们希望
         backgroundView 跟随 TableView 的滚动而滚动, 只能强制设置 frame.origin.y 永远为 0
         兼容 MJRefresh
         */
        CGRect frame = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        if (frame.origin.y != 0) {
            frame.origin.y = 0;
            self.backgroundView.frame = frame;
        }
    }
}

#pragma mark - 属性

/// 加载完数据的标记属性名
static NSString *const kWBTableViewPropertyInitFinish = @"kWBTableViewPropertyInitFinish";

/**
 设置已经加载完成数据了
 */
- (void)setIsInitFinish:(BOOL)finish {
    objc_setAssociatedObject(self, &kWBTableViewPropertyInitFinish, @(finish), OBJC_ASSOCIATION_ASSIGN);
}

/**
 是否已经加载完成数据
 */
- (BOOL)isInitFinish {
    id obj = objc_getAssociatedObject(self, &kWBTableViewPropertyInitFinish);
    return [obj boolValue];
}

/**
 移除 KVO 监听
 */
- (void)freeNoDataViewIfNeeded {
    if ([self.backgroundView isKindOfClass:[WBNoDataView class]]) {
        [self.backgroundView removeObserver:self forKeyPath:kWBNoDataViewObserveKeyPath context:nil];
    }
}

- (void)wb_dealloc {
    [self freeNoDataViewIfNeeded];
    [self wb_dealloc];
}

- (void)refreshHelperWithTarget:(id)target loadNewData:(SEL)loadNewData loadMoreData:(SEL)loadMoreData isBeginRefresh:(BOOL)beginRefreshing {
    if (loadNewData) {
        MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:loadNewData];
        mj_header.automaticallyChangeAlpha = YES;

        if (beginRefreshing) {
            [mj_header beginRefreshing];
        }

        self.mj_header = mj_header;
    }
    if (loadMoreData) {
        MJRefreshBackNormalFooter *mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:loadMoreData];
        mj_footer.automaticallyChangeAlpha = YES;
        self.mj_footer = mj_footer;
    }
}

- (void)tableViewViewEndRefreshCurPageCount:(NSInteger)count {
    [self.mj_header endRefreshing];
    if (count == KpageSize) {
        [self.mj_footer endRefreshing];
    } else {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

@end
