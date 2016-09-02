//
//  OFASectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

@import UIKit;
#import "OFASectionDataProvider.h"

@protocol OFASectionPopulator <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) id<OFASectionDataProvider> dataProvider;

@optional
@property (nonatomic, copy) void (^objectOnCellSelected)(id obj, UIView *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^objectOnCellDeselected)(id obj, UIView *cell, NSIndexPath *indexPath);

@property (nonatomic, copy) CGFloat (^heightForCellAtIndexPath)(id obj, NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL (^shouldHighlightCell)(id, UITableViewCell *, NSIndexPath *);
@property (nonatomic, copy) BOOL (^shouldShowSelection)(id, UITableViewCell *, NSIndexPath *);

@property (nonatomic, copy) NSString* (^sectionIndexTitle)();
@property (nonatomic, copy) NSString * (^cellIdentifier)(id obj, NSIndexPath *indexPath);
@property (nonatomic, copy) UIView* (^header)(NSUInteger section);
@property (nonatomic, copy) UIView* (^footer)(NSUInteger section);

@property (nonatomic, copy) UICollectionReusableView* (^supplementaryView)(id obj, NSIndexPath *indexPath, NSString *kind);
@property (nonatomic, copy) CGFloat (^heightForSupplementaryHeaderView)(id obj, NSInteger section);

@property (nonatomic, weak) UIView *parentView;
@end

@interface OFASectionPopulator : NSProxy <OFASectionPopulator>
@property (nonatomic, strong) id<OFASectionDataProvider> dataProvider;

- (instancetype)initWithParentView:(UIView *)parentView
                      dataProvider:(id<OFASectionDataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id obj, id cell, NSIndexPath *indexPath))cellConfigurator;

-(NSString *)indexTitle;
@end
