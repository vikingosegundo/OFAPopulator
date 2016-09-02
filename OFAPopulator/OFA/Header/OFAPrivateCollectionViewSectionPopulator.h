//
//  OFACollectionViewSectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 05/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAAbstractPrivateSectionPopulator.h"

@interface OFAPrivateCollectionViewSectionPopulator : OFAAbstractPrivateSectionPopulator

@property(nonatomic, weak, readonly) UICollectionView *parentView;
@property (nonatomic, copy) void (^cellConfigurator)(id, UICollectionViewCell *, NSIndexPath *);
@property (nonatomic, copy) UIView *(^header)(NSUInteger section);
@property (nonatomic, copy) UICollectionReusableView* (^supplementaryView)(id obj, NSIndexPath *indexPath, NSString *kind);
@property (nonatomic, copy) CGFloat (^heightForSupplementaryHeaderView)(id obj, NSInteger section);

- (instancetype)initWithParentView:(UICollectionView *)parentView
                      dataProvider:(id<OFASectionDataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UICollectionViewCell *, NSIndexPath *))cellConfigurator;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
@end
