//
//  OFACollectionViewSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 05/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAPrivateCollectionViewSectionPopulator.h"

@interface OFAPrivateCollectionViewSectionPopulator ()
@property(nonatomic, weak) UICollectionView *parentCollectionView;

@end


@implementation OFAPrivateCollectionViewSectionPopulator
@synthesize objectOnCellSelected = _objectOnCellSelected;
@synthesize header = _header;
@synthesize supplementaryView = _supplementaryView;
@synthesize heightForSupplementaryHeaderView = _heightForSupplementaryHeaderView;

- (instancetype)initWithParentView:(UICollectionView *)parentView
                      dataProvider:(id<OFASectionDataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UICollectionViewCell *, NSIndexPath *))cellConfigurator
{
    if (self = [super init]) {
        self.parentCollectionView   = parentView;
        self.dataProvider           = dataProvider;
        
        _cellConfigurator   = cellConfigurator;
        self.cellIdentifier = cellIdentifier;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.dataProvider sectionObjects] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier([self.dataProvider sectionObjects][indexPath.row], indexPath)  forIndexPath:indexPath];

    self.cellConfigurator([self.dataProvider sectionObjects][indexPath.row], cell, indexPath);
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected([self.dataProvider sectionObjects][indexPath.row], [collectionView cellForItemAtIndexPath:indexPath], indexPath);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected([self.dataProvider sectionObjects][indexPath.row], [collectionView cellForItemAtIndexPath:indexPath], indexPath);
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(self.supplementaryView) {
        return self.supplementaryView([self.dataProvider sectionObjects][indexPath.row], indexPath, kind);
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (self.supplementaryView) {
        NSAssert(self.heightForSupplementaryHeaderView != nil, @"if you implement supplementaryView, heightForSupplementaryHeaderView needs to be implemented too");
        return CGSizeMake(0, self.heightForSupplementaryHeaderView([self.dataProvider sectionObjects][0], section));
    }
    return CGSizeZero;
}

-(void)setSupplementaryView:(UICollectionReusableView *(^)(id, NSIndexPath *, NSString *))supplementaryView {
    _supplementaryView =supplementaryView;
}

-(UICollectionView *)parentView
{
    return self.parentCollectionView;
}

@end
