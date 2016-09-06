//
//  ViewController.m
//  tipCalculator
//
//  Created by Karen Fay on 9/5/16.
//  Copyright © 2016 yahoo. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Calculator";
    [self.billTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateColors];
    [self updateTipControl];
    [self updateValues];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onTipValueChanged:(UISegmentedControl *)sender {
    [self updateValues];
}

- (IBAction)onBillValueChanged:(UITextField *)sender {
    [self updateValues];
}


// Helper function to generate a UIColor from an integer/long value
- (UIColor*)colorFromInteger:(long)colorInt alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((colorInt & 0xFF0000) >> 16))/255.0
                           green:((float)((colorInt & 0xFF00) >> 8))/255.0
                            blue:((float)(colorInt & 0xFF))/255.0
                           alpha:alpha];
}

// Update the tip control from user preferences
- (void)updateTipControl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long tip = [defaults integerForKey:@"tip"];
    self.tipControl.selectedSegmentIndex = tip;
}

// Update the colors from user preferences
- (void)updateColors {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long colorValue = [defaults integerForKey:@"colorValue"];
    UIColor *darkColor = [self colorFromInteger:colorValue alpha:1.0];
    UIColor *lightColor = [self colorFromInteger:colorValue alpha:0.5];
    self.tipControl.tintColor = darkColor;
    self.topView.backgroundColor = lightColor;
    self.bottomView.backgroundColor = darkColor;
}

// Update the values based on the user input
- (void)updateValues {
    // Get bill amount
    float billAmount = [self.billTextField.text floatValue];
    
    // Compute tip & total
    NSArray *tipValues = @[@(0.15), @(0.2), @(0.25)];
    float tipAmount = [tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    float totalAmount = tipAmount + billAmount;
    
    // Update the UI
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

@end
