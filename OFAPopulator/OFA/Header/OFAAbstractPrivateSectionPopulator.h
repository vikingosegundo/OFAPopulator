//
//  OFAAbstractSectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 05/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OFASectionPopulator.h"

@interface OFAAbstractPrivateSectionPopulator : NSObject <OFASectionPopulator>
@property (nonatomic, strong) id<OFASectionDataProvider> dataProvider;

@end
