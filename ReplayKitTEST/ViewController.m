//
//  ViewController.m
//  ReplayKitTEST
//
//  Created by sycf_ios on 2017/6/8.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "ViewController.h"
#import <ReplayKit/ReplayKit.h>
@interface ViewController ()<RPPreviewViewControllerDelegate>

@property (nonatomic,strong) RPScreenRecorder *recorder;
@end

@implementation ViewController
-(RPScreenRecorder *)recorder{
    if (!_recorder) {
        _recorder = [RPScreenRecorder sharedRecorder];
    }
    return _recorder;
}

- (IBAction)handleTap:(id)sender {
    UIButton *button = sender;
    if ([button.currentTitle isEqualToString:@"录屏"]) {
        [self.recorder startRecordingWithHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"开始录屏错误：%@",error);
            }
        }];
    }else{
        [self.recorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
            if (error) {
                NSLog(@"关闭录屏错误：%@",error);
                return;
            }
            previewViewController.previewControllerDelegate = self;
            [self presentViewController:previewViewController animated:YES completion:nil];
            
        }];
    }
}
//MARK: RPPreviewViewControllerDelegate
- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
