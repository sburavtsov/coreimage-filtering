//
//  ViewController.h
//  coreimage-filtering
//
//  Created by Sergey Buravtsov on 18.07.15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UIButton *applyFilterButton;
@property (weak, nonatomic) IBOutlet UIButton *saveChangesButton;
@property (weak, nonatomic) IBOutlet UIImageView *originalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *filteredImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectFilterButton;

@end

