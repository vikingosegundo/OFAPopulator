//
//  OFAMinMaxSelectionSectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 07/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFASectionPopulator.h"

@interface OFAMinMaxSelectionSectionPopulator : OFASectionPopulator
-(instancetype)initWithParentView:(UIView *)parentView
                     minSelection:(NSUInteger)min
                     maxSelection:(NSUInteger)max
                      dataFetcher:(id<OFADataFetcher>)dataFetcher
                   cellIdentifier:(NSString *(^)(id, NSIndexPath *))cellIdentifier
                 cellConfigurator:(void (^)(id, id, NSIndexPath *))cellConfigurator;

@property (copy, nonatomic) void (^objectsSelected)(NSArray *objects, id cell, NSIndexPath *indexPath, BOOL isMaxSelected);
@end
