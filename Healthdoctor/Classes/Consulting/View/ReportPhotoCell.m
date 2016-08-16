//
//  ReportPhotoCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportPhotoCell.h"
#import "PhotoCell.h"
#import <UIImageView+WebCache.h>
#import "Define.h"

@interface ReportPhotoCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cuttingLineH;

@end

@implementation ReportPhotoCell
{
    NSArray *_imageList;
    ReportPhotoModel *_model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cuttingLineH.constant = 0.5;
}

- (void)showDataWithModel:(ReportPhotoModel *)model {
    self.nameLabel.text = model.nickName;
    self.dateLabel.text = model.date;
    self.companyLabel.text = model.healthCompanyName;
    _imageList = model.imageUrlList;
    _model = model;
    [self setUpCollectionView];
   // [self.collection reloadData];
}

- (void)setUpCollectionView {
//    if (self.collection) {
//        return;
//    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 8;
    flowLayout.minimumInteritemSpacing = 0;
    
    CGFloat itemWidth = (kScreenSizeWidth- 32 - 3*8)/4;
    NSInteger row = (_model.imageUrlList.count-1)/4 + 1;

    CGFloat collectionH = row *(itemWidth) + (row - 1)*8;
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth - 32, collectionH) collectionViewLayout:flowLayout];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.photoView addSubview:self.collection];
    
    [self.collection registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
}

#pragma mark -- UICollectionViewDelegateFlowLayout && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    NSString *photoUrl = [NSString stringWithFormat:@"%@!small200",_imageList[indexPath.row]];
    [cell.PhotoImageView sd_setImageWithURL:[NSURL URLWithString:photoUrl]];
    cell.PhotoImageView.tag = 100 + indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    NSMutableArray *imageArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < _imageList.count; i++) {
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc] init];
        browseItem.smallImageView = [self.collection viewWithTag:100 +i];
        browseItem.bigImageUrl = _imageList[i];
        [imageArr addObject:browseItem];
    }
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc] initWithBrowseItemArray:imageArr currentIndex:indexPath.row];
    
    if (self.present) {
        self.present(bvc);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth = (kScreenSizeWidth - 32 - 3*8)/4;
    return CGSizeMake(itemWidth, itemWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    CGFloat itemWidth = (kScreenSizeWidth - 32 - 3*8)/4;
    NSInteger row = (_model.imageUrlList.count-1)/4 + 1;
    totalHeight = 33 +8 +19 + row*itemWidth + (row-1)*8;
    return CGSizeMake(size.width, totalHeight);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
