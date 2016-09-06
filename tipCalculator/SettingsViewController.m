//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Karen Fay on 9/5/16.
//  Copyright © 2016 yahoo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIPickerView *colorPicker;
@property (strong, nonatomic)        NSArray *colorArray;
@property (strong, nonatomic)        NSArray *colorValues;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Set up the default tip value
    long tip = [defaults integerForKey:@"tip"];
    self.tipControl.selectedSegmentIndex = tip;
    
    // Set up the color picker
    self.colorArray  = @[@"Black",  @"Purple", @"Blue",   @"Green",  @"Yellow", @"Orange", @"Red"];
    self.colorValues = @[@0x000000, @0x30006D, @0x0000FF, @0x256140, @0xFFDD00, @0xFF8037, @0xFF0000];
    self.colorPicker.delegate = self;
    self.colorPicker.dataSource = self;
    long row = [defaults integerForKey:@"colorIndex"];
    [self.colorPicker selectRow:row inComponent:0 animated:YES];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in the UIPickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    return self.colorArray.count;
}

// returns the label for a row of the UIPickerView
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.colorArray objectAtIndex:row];
}

// called when the user chooses a new UIPickerView row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSNumber *colorValue = [self.colorValues objectAtIndex:row];
    long colorInt = [colorValue integerValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:colorInt forKey:@"colorValue"];
    [defaults setInteger:row forKey:@"colorIndex"];
    [defaults synchronize];
}

// called when the user chooses a new default tip percentage
- (IBAction)onTipChanged:(UISegmentedControl *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long tip = self.tipControl.selectedSegmentIndex;
    [defaults setInteger:tip forKey:@"tip"];
    [defaults synchronize];
}

@end
