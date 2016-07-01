//
//  OFAReorderSectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 09.05.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFASectionPopulator.h"

@interface OFAReorderSectionPopulator : OFASectionPopulator
- (instancetype)initWithParentView:(UIView *)parentView
                      dataProvider:(id<OFASectionDataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id obj, id cell, NSIndexPath *indexPath))cellConfigurator
                   reorderCallBack:(void(^)(id sourceObj, id destinationObj, NSIndexPath *sourceIndexpath, NSIndexPath *destinationIndexPath))reorderCallBack;
@end
