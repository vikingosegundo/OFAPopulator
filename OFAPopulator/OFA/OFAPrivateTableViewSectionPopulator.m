//
//  OFATableViewSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAPrivateTableViewSectionPopulator.h"

@interface OFAPrivateTableViewSectionPopulator ()
@property(nonatomic, weak) UITableView *parentTableView;
@end

@implementation OFAPrivateTableViewSectionPopulator

@synthesize  heightForCellAtIndexPath = _heightForCellAtIndexPath;
@synthesize shouldHighlightCell = _shouldHighlightCell;
@synthesize shouldShowSelection = _shouldShowSelection;
@synthesize header = _header;
@synthesize footer = _footer;


- (instancetype)initWithParentView:(UITableView *)parentView
                      dataProvider:(id<OFASectionDataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UITableViewCell *, NSIndexPath *))cellConfigurator
{
    if (self = [super init]) {
        self.dataProvider    = dataProvider;
        self.parentTableView = parentView;
        _cellConfigurator   = cellConfigurator;
        self.cellIdentifier = cellIdentifier;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataProvider sectionObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier([self.dataProvider sectionObjects][indexPath.row], indexPath) forIndexPath:indexPath];
    self.cellConfigurator([self.dataProvider sectionObjects][indexPath.row], cell, indexPath);
    return cell;
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.shouldShowSelection) {
        if (!self.shouldShowSelection([self.dataProvider sectionObjects][indexPath.row],
                                     [tableView cellForRowAtIndexPath:indexPath],
                                     indexPath)) {
            [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    }
    return indexPath;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected(
                                    [self.dataProvider sectionObjects][indexPath.row],
                                    [tableView cellForRowAtIndexPath:indexPath],
                                    indexPath
                                  );
    };
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellDeselected) {
        self.objectOnCellDeselected(
                                  [self.dataProvider sectionObjects][indexPath.row],
                                  [tableView cellForRowAtIndexPath:indexPath],
                                  indexPath
                                  );
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.heightForCellAtIndexPath) {
        return self.heightForCellAtIndexPath([self.dataProvider sectionObjects][indexPath.row],indexPath);

    }
    return tableView.rowHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.header) {
        CGFloat height = [self.header(section) frame].size.height;
        return height;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.footer) {
        CGFloat height = [self.footer(section) frame].size.height;
        return height;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.header) {
        return self.header(section);
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.footer) {
        return self.footer(section);
    }
    return nil;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shouldHighlightCell) {
        return self.shouldHighlightCell([self.dataProvider sectionObjects][indexPath.row],
                                        [tableView cellForRowAtIndexPath:indexPath],
                                        indexPath);
    }
    return YES;
}


-(void)setHeightForCellAtIndexPath:(CGFloat (^)(id, NSIndexPath *))heightForCellAtIndexPath
{
    _heightForCellAtIndexPath = heightForCellAtIndexPath;
}


-(void)setHeader:(UIView *(^)(NSUInteger))header
{
    _header = header;
}

-(void)setFooter:(UIView *(^)(NSUInteger))footer
{
    _footer = footer;
}


-(UIView *)parentView
{
    return self.parentTableView;
}

@end
