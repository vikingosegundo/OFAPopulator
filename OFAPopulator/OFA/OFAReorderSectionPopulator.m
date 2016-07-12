//
//  OFAReorderSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 09.05.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAReorderSectionPopulator.h"

@interface OFAReorderSectionPopulator ()
@property (nonatomic, copy) void(^reorderCallBack)(id sourceObj, id destinationObj, NSIndexPath *sourceIndexpath, NSIndexPath *destinationIndexPath);
@end


@implementation OFAReorderSectionPopulator

- (instancetype)initWithParentView:(UIView *)parentView
                      dataProvider:(id<OFASectionDataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id obj, id cell, NSIndexPath *indexPath))cellConfigurator
                   reorderCallBack:(void(^)(id sourceObj, id destinationObj, NSIndexPath *sourceIndexpath, NSIndexPath *destinationIndexPath))reorderCallBack;

{
    self = [super initWithParentView:parentView
                        dataProvider:dataProvider
                      cellIdentifier:cellIdentifier
                    cellConfigurator:cellConfigurator];
    

    if (self) {
        NSAssert([parentView isKindOfClass:[UITableView class]], @"currently %@ only supports table views", NSStringFromClass([self class]));
        [(UITableView *)parentView setEditing:YES animated:YES];
        [(UITableView *)parentView setAllowsMultipleSelection:NO];
        [(UITableView *)parentView setAllowsSelection:NO];

        self.reorderCallBack = reorderCallBack;
        self.dataProvider = dataProvider;
    }
    
    return self;
}

-(instancetype)initWithParentView:(UIView *)parentView
                     dataProvider:(id<OFASectionDataProvider>)dataProvider
                   cellIdentifier:(NSString *(^)(id, NSIndexPath *))cellIdentifier
                 cellConfigurator:(void (^)(id, id, NSIndexPath *))cellConfigurator
{
    NSAssert(@"Dont use %@ to initialize %@. Designated initializer is %@",NSStringFromSelector(_cmd), NSStringFromClass([self class]), @selector(initWithParentView:dataProvider:cellIdentifier:cellConfigurator:reorderCallBack:));
    return nil;
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.section != sourceIndexPath.section) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    id sObj = self.dataProvider.sectionObjects[sourceIndexPath.row];
    id dObj = self.dataProvider.sectionObjects[destinationIndexPath.row];
    self.reorderCallBack(sObj, dObj, sourceIndexPath, destinationIndexPath);
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell setShowsReorderControl:YES];
    return cell;
}


@end
