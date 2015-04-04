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

- (instancetype)initWithParentView:(UICollectionView *)parentView
                      dataProvider:(id<OFADataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UICollectionViewCell *, NSIndexPath *))cellConfigurator
{
    if (self = [super init]) {
        self.parentCollectionView   = parentView;
        self.dataProvider           = dataProvider;
        
        __weak typeof(self) weakSelf = self;
        [dataProvider dataAvailable:^{
            typeof(weakSelf) self = weakSelf;
            if (self) {
                [self.parentView reloadData];
            }
        }];
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

-(UICollectionView *)parentView
{
    return self.parentCollectionView;
}

@end
