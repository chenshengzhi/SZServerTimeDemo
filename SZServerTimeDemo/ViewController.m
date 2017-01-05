//
//  ViewController.m
//  SZServerTimeDemo
//
//  Created by 陈圣治 on 2017/1/4.
//  Copyright © 2017年 陈圣治. All rights reserved.
//

#import "ViewController.h"
#import "SZServerTimeManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;

    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval serverTime = [date timeIntervalSince1970];
    SZServerTimeManagerSetupServerTime(serverTime);

    self.textView.text = [self.textView.text stringByAppendingFormat:@"\n%@", date.description];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSDate *date = [[NSDate alloc] init];
        weakSelf.timeLabel.text = [date description];
    }];
    [timer fire];
}

- (IBAction)buttonTapHandler:(id)sender {
    NSTimeInterval currentServerTime = SZServerTimeManagerGetCurrentServerTime;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:currentServerTime];
    self.textView.text = [self.textView.text stringByAppendingFormat:@"\n%@", date.description];
}

@end
