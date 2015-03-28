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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) OFAViewPopulator   *populator;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    OFAMinMaxSelectionSectionPopulator *section1Populator = [[OFAMinMaxSelectionSectionPopulator alloc] initWithParentView:self.tableView
                                                                                                              minSelection:1
                                                                                                              maxSelection:4
                                                                                                              dataProvider:[[ExampleDataProvider alloc] init]
                                                                                                            cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){return indexPath.row % 2 ? @"Section1_1" : @"Section1_2";}
                                                                                                          cellConfigurator:^(id obj, UITableViewCell *cell, NSIndexPath *indexPath)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }];

    section1Populator.objectOnCellSelected = ^(id obj, UIView *cell, NSIndexPath *indexPath){
        NSLog(@"%@", obj);
    };
    section1Populator.sectionIndexTitle = ^(NSUInteger section){
        return @"f";
    };
    
    section1Populator.objectsSelected = ^(NSArray *objects, UITableViewCell *cell,NSIndexPath *inxPath, BOOL isMax){
        if (isMax) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please proceed"
                                                                                     message:@"Maximum Number is selected, please proceed"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                            {
                                                [alertController dismissViewControllerAnimated:YES
                                                                                    completion:nil];
                                            }]
             ];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
        }
    };
    
    OFASectionPopulator *section2Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                                dataProvider:[[ExampleDataProvider alloc] init]
                                                                              cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return @"Section2"; }
                                                                            cellConfigurator:^(NSNumber *obj, UITableViewCell *cell, NSIndexPath *indexPath)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", @([obj doubleValue] * [obj doubleValue])];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }];
    
    section2Populator.sectionIndexTitle = ^(NSUInteger section){
        return @"s";
    };
    
    self.populator = [[OFAViewPopulator alloc] initWithSectionPopulators:@[section1Populator, section2Populator]];
}

@end
