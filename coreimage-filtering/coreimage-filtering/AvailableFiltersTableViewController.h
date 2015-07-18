//
//  AvailableFiltersTableViewController.h
//  coreimage-filtering
//
//  Created by Sergey Buravtsov on 18.07.15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AvailableFiltersTableViewController;

@protocol AvailableFiltersDelegate<NSObject>

@optional
- (void)availableFilters:(AvailableFiltersTableViewController *)picker didFinishPickingWithName:(NSString *)name;
@end


@interface AvailableFiltersTableViewController : UITableViewController

@property (nonatomic, weak) id<AvailableFiltersDelegate> delegate;

@property (nonatomic, strong) NSString * selectedFilterName;

@end
