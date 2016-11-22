//
//  OFASectionedPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

@import UIKit;

@interface OFAScrollViewPopulator : NSObject <UIScrollViewDelegate>



@end

@interface OFATableViewPopulator : OFAScrollViewPopulator <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, readonly) NSArray *populators;

@end

@interface OFACollectionViewPopulator : OFAScrollViewPopulator <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, readonly) NSArray *populators;

@end

@interface OFAViewPopulator : NSProxy <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong, readonly) id privatePopulator;

- (instancetype)initWithSectionPopulators:(NSArray *)populators;
- (instancetype)initWithSectionPopulators:(NSArray *)populators populatorClass:(Class)cls;

@property (nonatomic, copy) void (^didScroll)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didBeginDragging)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didEndDragging)(UIScrollView *scrollView, BOOL decelerate);@end
