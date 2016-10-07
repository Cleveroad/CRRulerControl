
//  CRViewController.m
//  CRRulerControl
//
//  Created by Sergey Chuchukalo on 08/25/2016.
//  
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import "CRViewController.h"
#import "CRRulerControl.h"

@interface CRViewController ()

@property (weak, nonatomic) IBOutlet CRRulerControl *rulerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarButtonItem;
@end

@implementation CRViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.widthLabel.text = [NSNumber numberWithFloat:self.rulerView.rulerWidth].stringValue;
    self.fromLabel.text = [NSNumber numberWithFloat:self.rulerView.rangeFrom].stringValue;
    self.lengthLabel.text = [NSNumber numberWithFloat:self.rulerView.rangeLength].stringValue;
    self.frequencyLabel.text = [NSNumber numberWithFloat:[self.rulerView frequencyForMarkType:CRRulerMarkTypeMinor]].stringValue;
    self.imageView.layer.zPosition = -1000;
    [self setEditing:NO animated:NO];
    UIImage *image = [self createImageWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    self.editView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.editView.layer.shadowOffset = CGSizeMake(0, 2);
    self.editView.layer.shadowOpacity = 1;
    self.editView.layer.shadowRadius = 1.0;
    self.rulerView.pointerImageView.layer.cornerRadius = 2;
}

- (UIImage *) createImageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContext(CGSizeMake(5, 5));
    UIBezierPath* rPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 5, 5)];
    [color setFill];
    [rPath fill];
    UIImage *clearImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clearImage;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    UIImage *buttonImage = editing ? [UIImage imageNamed:@"ic_done"] : [UIImage imageNamed:@"ic_settings"];
    NSTimeInterval duration = animated ? 0.5 : 0.0;
    [self.menuBarButtonItem setImage:buttonImage];
    CGAffineTransform transform = editing ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, - self.editView.frame.size.height - 100);
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.6f
          initialSpringVelocity:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.editView.transform = transform;
    } completion:nil];
}

#pragma mark - Actions

- (IBAction)rulerValueChaned:(CRRulerControl *)sender {
    NSLog(@"value = %f",sender.value);
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, sender.value * M_PI / 180, 0.0f, 1.0f, 0.0f);
    self.imageView.layer.transform = rotationAndPerspectiveTransform;
}

- (IBAction)rulerWidthValueChanged:(UISlider *)sender {
    self.rulerView.rulerWidth = roundf(sender.value);
    self.widthLabel.text = [NSNumber numberWithFloat:roundf(sender.value)].stringValue;
}

- (IBAction)frequencyValueChange:(UISlider *)sender {
    [self.rulerView setFrequency:roundf(sender.value) forMarkType:CRRulerMarkTypeMinor];
    self.frequencyLabel.text = [NSNumber numberWithFloat:roundf(sender.value)].stringValue;
}

- (IBAction)rulerFromValueChanged:(UISlider *)sender {
    self.rulerView.rangeFrom = roundf(sender.value);
    self.fromLabel.text = [NSNumber numberWithFloat:roundf(sender.value)].stringValue;
}

- (IBAction)rulerLengthCalueChanged:(UISlider *)sender {
    self.rulerView.rangeLength = roundf(sender.value);
    self.lengthLabel.text = [NSNumber numberWithFloat:roundf(sender.value)].stringValue;
}

- (IBAction)barButtonItemTouchDown:(UIBarButtonItem *)sender {
    [self setEditing:!self.isEditing animated:YES];
}

@end
