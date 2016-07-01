//
//  OFASectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFASectionPopulator.h"
#import "OFATableViewSectionPopulator.h"
#import "OFACollectionViewSectionPopulator.h"

@interface OFASectionPopulator ()
@property (nonatomic, strong) OFATableViewSectionPopulator      *tableViewPopulator;
@property (nonatomic, strong) OFACollectionViewSectionPopulator *collectionViewPopulator;

@end

@implementation OFASectionPopulator
@synthesize dataProvider = _dataProvider;
- (instancetype)initWithParentView:(UIView *)parentView
                      dataProvider:(id<OFASectionDataProvider>)dataProvider
                    cellIdentifier:(NSString *(^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, id, NSIndexPath *))cellConfigurator
{
    if (self) {
        self.dataProvider = _dataProvider;
        if ([parentView isKindOfClass:[UITableView class]]) {
            _tableViewPopulator = [[OFATableViewSectionPopulator alloc] initWithParentView:(UITableView *)parentView
                                                                            dataProvider:dataProvider
                                                                            cellIdentifier:cellIdentifier
                                                                          cellConfigurator:cellConfigurator];
        } else if ([parentView isKindOfClass:[UICollectionView class]]) {
            _collectionViewPopulator = [[OFACollectionViewSectionPopulator alloc] initWithParentView:(UICollectionView *)parentView
                                                                                        dataProvider:dataProvider
                                                                                      cellIdentifier:cellIdentifier
                                                                                    cellConfigurator:cellConfigurator];
        }
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [[self activeTaget] methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([[self activeTaget] respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:[self activeTaget]];
    }
}

- (OFAAbstractPrivateSectionPopulator *)activeTaget
{
    return (_tableViewPopulator) ? : _collectionViewPopulator;
}


-(void)setObjectOnCellSelected:(void (^)(id, UIView *, NSIndexPath *))objectOnCellSelected
{
    [[self activeTaget] setObjectOnCellSelected:objectOnCellSelected];
}

-(void)setObjectOnCellDeselected:(void (^)(id, UIView *, NSIndexPath *))objectOnCellDeselected
{
    [[self activeTaget] setObjectOnCellDeselected:objectOnCellDeselected];
}


-(void)setHeightForCellAtIndexPath:(CGFloat (^)(id, NSIndexPath *))heightForCellAtIndexPath
{
    [[self activeTaget] setHeightForCellAtIndexPath:heightForCellAtIndexPath];
}

-(void)setShouldHighlightCell:(BOOL (^)(id, UITableViewCell *, NSIndexPath *))shouldHighlightCell
{
    [[self activeTaget] setShouldHighlightCell:shouldHighlightCell];

}

-(void)setShouldShowSelection:(BOOL (^)(id, UITableViewCell *, NSIndexPath *))shouldShowSelection
{
    [[self activeTaget] setShouldShowSelection:shouldShowSelection];
}

-(void)setHeader:(UIView *(^)(NSUInteger))headerForSection
{
    [[self activeTaget] setHeader:headerForSection];
}

-(void)setFooter:(UIView *(^)(NSUInteger))footer
{
    [[self activeTaget] setFooter:footer];
}

-(NSString *)indexTitle
{
    
    if([[self activeTaget] sectionIndexTitle])
        return [self activeTaget].sectionIndexTitle();
    return @"";
}

-(UIView *)parentView
{
    OFAAbstractPrivateSectionPopulator *pop = (_tableViewPopulator) ? : _collectionViewPopulator;
    return pop.parentView;
}

-(BOOL)respondsToSelector:(SEL)aSelector
{
    return [[[self activeTaget] class] instancesRespondToSelector: aSelector];
}

-(id<OFASectionDataProvider>)dataProvider
{
    return _dataProvider;
}

-(void)setDataProvider:(id<OFASectionDataProvider>)dataProvider
{
    _dataProvider = dataProvider;
}


@end
