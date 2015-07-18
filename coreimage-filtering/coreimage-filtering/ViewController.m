//
//  ViewController.m
//  coreimage-filtering
//
//  Created by Sergey Buravtsov on 18.07.15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL imageSelected;
@property (nonatomic, assign) BOOL filterApplied;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageSelected = NO;
    self.filterApplied = NO;
    
    [self updateButtonsState];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)updateButtonsState {
    
    self.saveChangesButton.enabled = self.filterApplied;
    self.applyFilterButton.enabled = self.imageSelected;
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
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, originalImage, @"inputIntensity", @0.8, nil];
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
    
    self.imageSelected = false;
    self.filterApplied = false;
    [self updateButtonsState];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.originalImageView setImage:selectedImage];
    
    self.imageSelected = YES;
    [self updateButtonsState];
}

@end
