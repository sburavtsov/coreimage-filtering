//
//  ViewController.m
//  coreimage-filtering
//
//  Created by Sergey Buravtsov on 18.07.15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import "AvailableFiltersTableViewController.h"
#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AvailableFiltersDelegate>

@property (nonatomic, assign) BOOL imageSelected;
@property (nonatomic, assign) BOOL filterApplied;
@property (nonatomic, assign) BOOL filterSelected;
@property (nonatomic, strong) NSString *filterName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageSelected = NO;
    self.filterApplied = NO;
    self.filterSelected = YES;
    self.filterName = @"CIColorPosterize";
    
    [self updateButtonsState];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)updateButtonsState {
    
    self.saveChangesButton.enabled = self.filterApplied;
    self.applyFilterButton.enabled = self.imageSelected;

    [self.selectFilterButton setTitle:self.filterName forState:UIControlStateNormal];
    [self.selectFilterButton setTitle:self.filterName forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPictureDidTap:(UIButton *)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)applyFilterDidTap:(UIButton *)sender {

    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *originalImage = [CIImage imageWithCGImage:self.originalImageView.image.CGImage];
    
    
    CIFilter *filter = self.filterSelected ? [CIFilter filterWithName:self.filterName] : [CIFilter filterWithName:@"CICircleSplashDistortion"];

    [filter setValue:originalImage forKey:[filter.inputKeys objectAtIndex:0]];

    CIImage *filteredImage = [filter outputImage];

    CGImageRef cgImageRef = [context createCGImage:filteredImage fromRect:[filteredImage extent]];
    self.filteredImageView.image = [UIImage imageWithCGImage:cgImageRef];
    CGImageRelease(cgImageRef);
    
    self.filterApplied = YES;
    [self updateButtonsState];
}

- (IBAction)saveChangesDidTap:(UIButton *)sender {
    
    self.imageSelected = false;
    self.filterApplied = false;
    [self updateButtonsState];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    self.imageSelected = (nil != self.originalImageView.image);
    [self updateButtonsState];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.originalImageView setImage:selectedImage];
    
    self.imageSelected = (nil != self.originalImageView.image);

    [self updateButtonsState];
}

- (void)availableFilters:(AvailableFiltersTableViewController *)picker didFinishPickingWithName:(NSString *)name {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    self.filterName = name;
    self.filterSelected = YES;
    [self updateButtonsState];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AvailableFiltersTableViewController *vc = (AvailableFiltersTableViewController *)segue.destinationViewController;
    vc.selectedFilterName = self.selectFilterButton.titleLabel.text;
    vc.delegate = self;
}

@end
