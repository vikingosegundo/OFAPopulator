//
//  OFAAbstractSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 05/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAAbstractPrivateSectionPopulator.h"


@interface OFAAbstractPrivateSectionPopulator ()
@end

@implementation OFAAbstractPrivateSectionPopulator
@synthesize objectOnCellSelected = _objectOnCellSelected;
@synthesize objectOnCellDeselected = _objectOnCellDeselected;

@synthesize sectionIndexTitle = _sectionIndexTitle;
@synthesize cellIdentifier = _cellIdentifier;
@synthesize dataProvider = _dataProvider;
@synthesize supplementaryView = _supplementaryView;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


-(void)setSectionIndexTitle:(NSString *(^)())sectionIndexTitle
{
    _sectionIndexTitle = sectionIndexTitle;
    
}

@end
