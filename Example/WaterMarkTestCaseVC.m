//
//  WaterMarkTestCaseVC.m
//  TYHWaterMark
//
//  Created by yuhua Tang on 2022/8/20.
//  Copyright © 2022 pencilCool. All rights reserved.
//

#import "WaterMarkTestCaseVC.h"
@import TYHWaterMark;
@interface WaterMarkTestCaseVC ()
@property (nonatomic,weak) NSTimer *timer;
@end

@implementation WaterMarkTestCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __typeof(self) weakSelf = self;
    [self addCell:@"push vc" action:^{
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [weakSelf.navigationController  pushViewController:vc animated:YES];
    }];
    
    [self addCell:@"present vc" action:^{
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [weakSelf presentViewController:vc animated:YES completion:nil];
    }];
    
    [self addCell:@"System VC: ImagePicker" action:^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:picker animated:YES completion:^{
        }];
    }];
    
    [self addCell:@"System VC: UIDocumentPicker" action:^{
        UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.image"] inMode:UIDocumentPickerModeImport];
        picker.modalPresentationStyle = UIModalPresentationFormSheet;
        [weakSelf presentViewController:picker animated:YES completion:^{
        }];
    }];
    
    [self addCell:@"push black vc" action:^{
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor blackColor];
        [weakSelf.navigationController  pushViewController:vc animated:YES];
    }];
    
    [self addCell:@"present black vc" action:^{
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor blackColor];
        [weakSelf presentViewController:vc animated:YES completion:nil];
    }];
    
    [self addCell:@"add character" action:^{
        [TYHWaterMarkView setCharacter:@"pencilCool"];
    }];
    
    [self addCell:@"set time format" action:^{
        [TYHWaterMarkView setTimeFormat:@"yyyy-MM-dd HH:mm:ss"];
    }];
    
    [self addCell:@"update date " action:^{
        [TYHWaterMarkView setTimeFormat:@"yyyy-MM-dd HH:mm:ss"];
        [TYHWaterMarkView updateDate];
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
            [TYHWaterMarkView updateDate];
        }];
    }];
}

@end
