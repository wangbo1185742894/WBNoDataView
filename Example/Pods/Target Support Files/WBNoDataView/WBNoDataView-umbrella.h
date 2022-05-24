#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IWBNoDataViewProtocol.h"
#import "UICollectionView+NoData.h"
#import "UITableView+NoData.h"
#import "UIView+Frame.h"
#import "WBNoData.h"
#import "WBNoDataView.h"

FOUNDATION_EXPORT double WBNoDataViewVersionNumber;
FOUNDATION_EXPORT const unsigned char WBNoDataViewVersionString[];

