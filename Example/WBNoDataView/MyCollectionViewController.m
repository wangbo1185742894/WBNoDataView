//
//  MyCollectionViewController.m
//  WBNoDataView
//
//  Created by 王博 on 2019/10/21.
//  Copyright © 2019 王博. All rights reserved.
//

#import "MyCollectionViewController.h"

#import "UICollectionView+NoData.h"

#import "IWBNoDataViewProtocol.h"

@interface MyCollectionViewController ()<IViewNoData>

@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
      UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
      layout.itemSize = CGSizeMake(103, 103);
      // 设置最小行间距
      layout.minimumLineSpacing = 20;
      // 设置垂直间距
      layout.minimumInteritemSpacing = 0;
      // 设置边缘的间距，默认是{0，0，0，0}
      layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
      return [self initWithCollectionViewLayout:layout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    

    
    [self.collectionView refreshHelperWithTarget:self loadNewData:@selector(loadNewData) loadMoreData:@selector(loadMoreDta) isBeginRefresh:YES];
}

-(void)loadNewData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView collectionViewEndRefreshCurPageCount:10];
        [self .collectionView reloadData];
    });
}

-(void)loadMoreDta{
    
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self.collectionView collectionViewEndRefreshCurPageCount:0];
       [self .collectionView reloadData];
   });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/



-(NSString *)wb_noDataViewMessage{
    return @"暂无数据";
}

- (UIImage *)wb_noDataViewImage{
    return  [UIImage imageNamed:@"de_kong"];
}
@end
