//
//  ViewController.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "ViewController.h"
#import "ExampleDataProvider.h"

#import "OFAMinMaxSelectionSectionPopulator.h"
#import "OFAViewPopulator.h"

#import "ExampleTableViewCell.h"
#import "OFAReorderSectionPopulator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) OFAViewPopulator   *populator;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    OFASectionPopulator *section1Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                                dataProvider:[[ExampleDataProvider alloc] init]
                                                                              cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){return indexPath.row % 2 ? @"Section1_1" : @"Section1_2";}
                                                                            cellConfigurator:^(id obj, UITableViewCell *cell, NSIndexPath *indexPath)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }];

    section1Populator.objectOnCellSelected = ^(id obj, UIView *cell, NSIndexPath *indexPath){
        NSLog(@"%@", obj);
    };

    
    section1Populator.shouldShowSelection = ^BOOL(id obj, UITableViewCell *cell, NSIndexPath *indexPath){
        return (indexPath.row % 3 == 0);
    };
    
    OFASectionPopulator *section2Populator = [[OFAReorderSectionPopulator alloc] initWithParentView:self.tableView
                                                                                       dataProvider:[[ExampleDataProvider alloc] init]
                                                                                     cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return @"Section2"; }
                                                                                   cellConfigurator:^(NSNumber *obj, UITableViewCell *cell, NSIndexPath *indexPath)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", @([obj doubleValue] * [obj doubleValue])];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    } reorderCallBack:^(id sourceObj, id destinationObj, NSIndexPath *sourceIndexpath, NSIndexPath *destinationIndexPath) {
        ;
    }];
    

    self.populator = [[OFAViewPopulator alloc] initWithSectionPopulators:@[section1Populator, section2Populator]];
}

@end
