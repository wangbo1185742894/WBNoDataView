//
//  UICollectionView+NoData.h
//  WBNoDataView
//
//  Created by 王博 on 2019/10/18.
//  Copyright © 2019 王博. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (NoData)

- (void)setIsInitFinish:(BOOL)finish;

- (void)refreshHelperWithTarget:(id)target loadNewData:(SEL)loadNewData loadMoreData:(SEL)loadMoreData isBeginRefresh:(BOOL)beginRefreshing;

- (void)collectionViewEndRefreshCurPageCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
