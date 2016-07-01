//
//  OFATableViewSectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAAbstractPrivateSectionPopulator.h"

@interface OFAPrivateTableViewSectionPopulator : OFAAbstractPrivateSectionPopulator


@property (nonatomic, weak, readonly) UIView *parentView;
@property (nonatomic, copy) void (^cellConfigurator)(id, UITableViewCell *, NSIndexPath *);
@property (nonatomic, copy) BOOL (^shouldHighlightCell)(id, UITableViewCell *, NSIndexPath *);
@property (nonatomic, copy) BOOL (^shouldShowSelection)(id, UITableViewCell *, NSIndexPath *);

@property (nonatomic, copy) UIView *(^header)(NSUInteger section);
@property (nonatomic, copy) UIView *(^footer)(NSUInteger section);

@property (nonatomic, copy) CGFloat (^heightForCellAtIndexPath)(id obj, NSIndexPath *indexPath);

- (instancetype)initWithParentView:(UITableView *)parentView
                      dataProvider:(id<OFASectionDataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UITableViewCell *, NSIndexPath *))cellConfigurator;

@end
