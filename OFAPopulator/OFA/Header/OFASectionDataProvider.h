//
//  OFADataProvider.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 20.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OFASectionDataProvider <NSObject>
@property (nonatomic, strong) NSArray *sectionObjects;
@end
