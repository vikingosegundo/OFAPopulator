//
//  OFACollectionViewSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 07/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFACollectionViewSectionPopulator.h"

@implementation OFACollectionViewSectionPopulator


-(void)setSectionIndexTitle:(NSString *(^)())sectionIndexTitle
{
    NSAssert(NO,@"Section tittles currently aren't supported for Collection Views");
    [super setSectionIndexTitle:sectionIndexTitle];
}

-(void)setHeader:(UIView *(^)(NSUInteger))headerForSection
{
    NSAssert(NO,@"Section titles currently aren't supported for Collection Views");
}
@end
