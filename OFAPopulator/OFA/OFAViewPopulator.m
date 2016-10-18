//
//  OFASectionedPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAViewPopulator.h"
#import "OFASectionPopulator.h"
#import "OFACollectionViewSectionPopulator.h"


@interface OFAScrollViewPopulator ()
@property (nonatomic, copy) void (^didScroll)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didBeginDragging)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didEndDragging)(UIScrollView *scrollView, BOOL decelerate);
@end

@implementation OFAScrollViewPopulator

@end

#pragma mark -

@interface OFATableViewPopulator ()
@property (nonatomic, weak) UITableView    *parentView;
@property (nonatomic, strong) NSArray      *populators;
@property (nonatomic, assign) NSUInteger    currentSection;


@end

@implementation OFATableViewPopulator
- (instancetype)initWithParentView:(UITableView *)tv sectionPopulators:(NSArray *)populators
{
    self = [super init];
    if (self) {
        _parentView = tv;
        _populators = populators;
        
        tv.dataSource = self;
        tv.delegate = self;
        tv.allowsSelectionDuringEditing = YES;
        [tv setEditing:YES animated:YES];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.populators.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.currentSection = section;

    id<OFASectionPopulator> pop = self.populators[section];
    return [pop tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    self.currentSection = indexPath.section;
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentSection = indexPath.section;
    
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop tableView:tableView willSelectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentSection = indexPath.section;

    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    [pop tableView:tableView didSelectRowAtIndexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
     self.currentSection = indexPath.section;

    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    [pop tableView:tableView didDeselectRowAtIndexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    [pop tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    
    if ([pop respondsToSelector:_cmd]) {
        return [pop tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    
    if ([pop respondsToSelector:_cmd]) {
        return [pop tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    
    if ([pop respondsToSelector:_cmd]) {
        return [pop tableView:tableView heightForFooterInSection:section];
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    
    if ([pop respondsToSelector:_cmd]) {
        return [pop tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    if ([pop respondsToSelector:_cmd]) {
        return [pop tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *titles = [@[] mutableCopy];
    [self.populators enumerateObjectsUsingBlock:^(OFASectionPopulator *pop, NSUInteger idx, BOOL *stop) {
        NSString *title = [pop indexTitle];
        if (title) {
            [titles addObject:title];
        }
    }];
    
    NSSet *titleSet = [NSSet setWithArray:titles];
    if ([titleSet count] == 1 && [[titleSet anyObject] isEqualToString:@""]) {
        return nil;
    }
    
    return [titles copy];
    
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    if ([[pop class] instancesRespondToSelector:_cmd]) {
        return [pop tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return NO;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id<OFASectionPopulator> pop = self.populators[sourceIndexPath.section];
    if ([[pop class] instancesRespondToSelector:_cmd]) {
        [pop tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }

}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    if ([[pop class] instancesRespondToSelector:_cmd]) {
        return [pop tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    if ([[pop class] instancesRespondToSelector:_cmd]) {
        return [pop tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleDelete;
}


-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    id<OFASectionPopulator> dPop = self.populators[proposedDestinationIndexPath.section];
    if ([[dPop class] instancesRespondToSelector:_cmd]) {
        return [dPop tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    return sourceIndexPath;
}


-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.didScroll) {
        self.didScroll(self.parentView);
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(self.didBeginDragging) {
        self.didBeginDragging(self.parentView);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.didEndDragging){
        self.didEndDragging(self.parentView, decelerate);
    }
}


@end




#pragma mark -

@interface OFACollectionViewPopulator ()
@property (nonatomic, weak) UICollectionView    *parentView;

@end


@implementation OFACollectionViewPopulator


- (instancetype)initWithParentView:(UICollectionView *)tv sectionPopulators:(NSArray *)populators
{
    self = [super init];
    if (self) {
        _parentView = tv;
        _populators = populators;
        
        tv.dataSource = self;
        tv.delegate = self;
        tv.allowsMultipleSelection = YES;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.populators.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    return [pop collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    id<OFASectionPopulator> pop = self.populators[section];
    
    if([pop isKindOfClass:[OFACollectionViewSectionPopulator class]]) {
        return [(OFACollectionViewSectionPopulator*)pop collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection: section];
    }
    return CGSizeMake(0, 100);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.didScroll) {
        self.didScroll(self.parentView);
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(self.didBeginDragging) {
        self.didBeginDragging(self.parentView);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.didEndDragging){
        self.didEndDragging(self.parentView, decelerate);
    }
}

@end


#pragma mark -

@interface OFAViewPopulator ()

@property (nonatomic, strong) id privatePopulator;
@end

@implementation OFAViewPopulator

@dynamic didEndDragging;
@dynamic didBeginDragging;
@dynamic didScroll;

- (instancetype)initWithSectionPopulators:(NSArray *)populators populatorClass:(Class)cls
{
    NSAssert(cls, @"populatorClass must not be Nil");
    NSSet *sectionParentView = [NSSet setWithArray:[populators valueForKey:@"parentView"]];
    if ([sectionParentView count] != 1) {
        NSAssert(NO, @"all populators must have the same parent view");
        return nil;
    }
    UIView *parentView = [sectionParentView anyObject];
    if (self) {
        if ([parentView isKindOfClass:[UITableView class]]) {
            self.privatePopulator = [[cls alloc] initWithParentView:(UITableView *)parentView
                                                                    sectionPopulators:populators];
        } else if ([parentView isKindOfClass:[UICollectionView class]]) {
            self.privatePopulator = [[cls alloc] initWithParentView:(UICollectionView *)parentView
                                                                         sectionPopulators:populators];
        }
    }
    return self;
}


- (instancetype)initWithSectionPopulators:(NSArray *)populators
{
    NSSet *sectionParentView = [NSSet setWithArray:[populators valueForKey:@"parentView"]];
    if ([sectionParentView count] != 1) {
        NSAssert(NO, @"all populators must have the same parent view");
        return nil;
    }
    UIView *parentView = [sectionParentView anyObject];
    
    Class populatorClass;
    
    if (self) {
        if ([parentView isKindOfClass:[UITableView class]]) {
            populatorClass = [OFATableViewPopulator class];
        } else if ([parentView isKindOfClass:[UICollectionView class]]) {
            populatorClass = [OFACollectionViewPopulator class];
        }
    }
    return [self initWithSectionPopulators:populators populatorClass:populatorClass];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [[self privatePopulator] methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([[[self privatePopulator] class] instancesRespondToSelector:invocation.selector]) {
        [invocation invokeWithTarget:[self privatePopulator]];
    }
}

-(void)setDidScroll:(void (^)(UIScrollView *))didScroll
{    
    if ([self.privatePopulator isKindOfClass:[OFAScrollViewPopulator class]]) {
        [(OFAScrollViewPopulator *)self.privatePopulator setDidScroll:didScroll];
    }
}

-(void) setDidBeginDragging:(void (^)(UIScrollView *))didBeginDragging {
    if ([self.privatePopulator isKindOfClass:[OFAScrollViewPopulator class]]) {
        [(OFAScrollViewPopulator *)self.privatePopulator setDidBeginDragging:didBeginDragging];
    }
}

-(void) setDidEndDragging:(void (^)(UIScrollView *, BOOL decelerate))didEndDragging {
    if ([self.privatePopulator isKindOfClass:[OFAScrollViewPopulator class]]) {
        [(OFAScrollViewPopulator *)self.privatePopulator setDidEndDragging:didEndDragging];
    }
}

@end
