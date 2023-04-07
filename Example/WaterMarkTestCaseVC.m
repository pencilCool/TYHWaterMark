//
//  WaterMarkTestCaseVC.m
//  TYHWaterMark
//
//  Created by yuhua Tang on 2022/8/20.
//  Copyright © 2022 pencilCool. All rights reserved.
//


#import "WaterMarkTestCaseVC.h"
@import WebKit;
@interface WebViewVC : UIViewController

@end



@interface WebViewVC ()<WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = true;
    [self.view addSubview:self.webView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"input" ofType:@"html"];
    NSData*data = [NSData dataWithContentsOfFile:path];
    NSString *html  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self.webView loadHTMLString:html baseURL:nil];
}

@end


@interface SubImagePickerVC:UIImagePickerController
@end

@implementation SubImagePickerVC
@end

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
    
    [self addCell:@"System VC: UIImagePickerController" action:^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:picker animated:YES completion:^{
        }];
    }];
    
    [self addCell:@"sub System VC: UIImagePickerController" action:^{
        SubImagePickerVC *picker = [[SubImagePickerVC alloc] init];
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:picker animated:YES completion:^{
        }];
    }];
    
    [self addCell:@"System VC: UIDocumentPickerViewController" action:^{
        UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.image"] inMode:UIDocumentPickerModeImport];
        [weakSelf presentViewController:picker animated:YES completion:^{
        }];
    }];
   
//    [self addCell:@"System VC: UIPrinterPickerController" action:^{
//        UIPrinterPickerController *picker = [UIPrinterPickerController printerPickerControllerWithInitiallySelectedPrinter:nil];
////        [weakSelf presentViewController:picker animated:YES completion:^{
////        }];
//        [picker presentAnimated:YES completionHandler:^(UIPrinterPickerController * _Nonnull printerPickerController, BOOL userDidSelect, NSError * _Nullable error) {
//
//        }];
//    }];
    
    
    [self addCell:@"System VC: UIFontPickerViewController" action:^{
        UIFontPickerViewController *picker = [[UIFontPickerViewController alloc] init];
        picker.modalPresentationStyle = UIModalPresentationFormSheet;
        [weakSelf presentViewController:picker animated:YES completion:^{
        }];
    }];
    
    [self addCell:@"System VC: UIColorPickerViewController" action:^{
        UIColorPickerViewController *picker = [[UIColorPickerViewController alloc] init];
        picker.modalPresentationStyle = UIModalPresentationFormSheet;
        [weakSelf presentViewController:picker animated:YES completion:^{
        }];
    }];
   
 
    [self addCell:@"UIAlertControllerStyleAlert" action:^{
        UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"title" message:@"b" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
    
    [self addCell:@"UIAlertControllerStyleActionSheet" action:^{
        UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"title" message:@"b" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
    
    [self addCell:@"webview input " action:^{
        WebViewVC *vc = [WebViewVC new];
        [weakSelf.navigationController pushViewController:vc animated:true];
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
    
    [self addCell:@"set color to green" action:^{
        [TYHWaterMarkView setColor:[UIColor systemGreenColor]];
    }];
    
    [self addCell:@"set color to blue" action:^{
        [TYHWaterMarkView setColor:[UIColor systemBlueColor]];
    }];
    
    [self addCell:@"set font size to 30" action:^{
        [TYHWaterMarkView setFont:[UIFont systemFontOfSize:30]];
    }];
    
    [self addCell:@"set font size to 12" action:^{
        [TYHWaterMarkView setFont:[UIFont systemFontOfSize:12]];
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
