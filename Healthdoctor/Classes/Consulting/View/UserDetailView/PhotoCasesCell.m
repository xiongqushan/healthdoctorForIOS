//
//  PhotoCasesCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PhotoCasesCell.h"
#import "PhotoCell.h"
#import "Define.h"
#import "UIColor+Utils.h"

@implementation PhotoCasesCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"PhotoCasesCell";
    PhotoCasesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PhotoCasesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setPhotoList:(NSArray *)photoList {
    _photoList = photoList;
    self.backgroundColor = [UIColor viewBackgroundColor];
    
    [self setUpCollectionView];
}

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    NSInteger row = (_photoList.count-1)/3 + 1;
    CGFloat photoItemW = (kScreenSizeWidth - 2*10)/3;
    CGFloat photoItemH = photoItemW*0.8 + 50;
    
    UICollectionView *collecView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, row * (photoItemH + 10)) collectionViewLayout:flowLayout];
    collecView.backgroundColor = [UIColor viewBackgroundColor];
    collecView.delegate = self;
    collecView.dataSource = self;
    [self.contentView addSubview:collecView];
    [collecView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
}

#pragma mark -- UICollectionViewDelegateFlowLayout && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];

    [cell showDataWithModel:_photoList[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
  //  NSMutableArray *imageArr = [NSMutableArray array];
    PhotoCell *cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *imageView = [[cell.imageBgView subviews] lastObject];
    if ([self.delegate respondsToSelector:@selector(photoCasesDidSelected:imageView:)]) {
        [self.delegate photoCasesDidSelected:indexPath imageView:imageView];
    }
    
//    for (NSInteger i = 0; i < _imageList.count; i++) {
//        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc] init];
//        browseItem.smallImageView = [self.collection viewWithTag:100 +i];
//        browseItem.bigImageUrl = _imageList[i];
//        [imageArr addObject:browseItem];
//    }
//    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc] initWithBrowseItemArray:imageArr currentIndex:indexPath.row];
//    
//    if (self.present) {
//        self.present(bvc);
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth = (kScreenSizeWidth - 2*10)/3;
    return CGSizeMake(itemWidth, itemWidth*0.8+50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//- (CGSize)sizeThatFits:(CGSize)size {
//    CGFloat totalHeight = 0;
//    CGFloat itemWidth = (kScreenSizeWidth - 32 - 3*8)/4;
//    NSInteger row = (_model.imageUrlList.count-1)/4 + 1;
//    totalHeight = 33 +8 +19 + row*itemWidth + (row-1)*8;
//    return CGSizeMake(size.width, totalHeight);
//}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
