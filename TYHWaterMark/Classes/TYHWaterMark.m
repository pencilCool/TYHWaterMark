//
//  SanyWaterMaskVC.m
//  SanyLocalPodDemo
//
//  Created by yuhua Tang on 2022/8/5.
//

#import "TYHWaterMark.h"
@import Aspects;

@implementation UIViewController (tyh_waterMark)
+ (UIViewController *)tyh_topViewController:(UIViewController *)root
{
    if (root.presentedViewController != nil)
    {
        return [self tyh_topViewController:root.presentedViewController];
    }

    if ([root isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tab = (UITabBarController *)root;
        return [self tyh_topViewController:tab.selectedViewController];
    }

    if ([root isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)root;
        return [self tyh_topViewController:nav.topViewController];
    }
    return root;
}
@end

static NSString *g_characteristicStr = @"";
static NSString *g_formatStr = @"yyyy-MM-dd";
static TYHWaterMarkView *g_waterMarkView = nil;

@interface TYHWaterMarkView ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TYHWaterMarkView
+ (void)initialize
{
    [UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> aspectInfo, UIViewController *vc, BOOL animated, id completion) {
                                 if ([vc isKindOfClass:[UIImagePickerController class]])
                                 {
                                     if (g_waterMarkView)
                                     {
                                         g_waterMarkView.hidden = YES;
                                     }
                                 }
                               }
                                    error:nil];

    [UIViewController aspect_hookSelector:@selector(dismissViewControllerAnimated:completion:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated, id completion) {
                                 UIViewController *vc = aspectInfo.instance;
                                 UIViewController *topVC = [UIViewController tyh_topViewController:vc];
                                 // FIXME: this hard code class may vary with iOS system version, if you find bug please let me know
                                 if ([topVC isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")])
                                 {
                                     if (g_waterMarkView)
                                     {
                                         g_waterMarkView.hidden = NO;
                                     }
                                 }
                               }
                                    error:nil];
}

+ (void)setCharacter:(NSString *)str
{
    if (g_waterMarkView)
    {
        [g_waterMarkView setCharacteristic:str];
    }
    else
    {
        g_characteristicStr = str;
    }
}

+ (void)setTimeFormat:(NSString *)format
{
    if (g_waterMarkView)
    {
        [g_waterMarkView setTimeFormat:format];
    }
    else
    {
        g_formatStr = format;
    }
}

+ (void)updateDate
{
    if (g_waterMarkView)
    {
        [g_waterMarkView updateContent];
    }
    else
    {
    }
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(-width, -height, 3 * width, 3 * height);
    self.layer.zPosition = 999;
    [self addSubview:self.textView];
    self.textView.frame = CGRectMake(0, 0, 3 * width, 3 * height);
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:[self markContent] attributes:[self getAttributes]];
    self.transform = CGAffineTransformMakeRotation(-30 * M_PI / 180);
    g_waterMarkView = self;
}

- (NSString *)markContent
{
    NSString *dateString = [self stringWithFormat:g_formatStr];
    NSString *mark = [NSString stringWithFormat:@"%@  %@", g_characteristicStr, dateString];
    NSMutableString *all = @"".mutableCopy;
    for (int i = 0; i < 100; i++)
    {
        [all appendString:mark];
        [all appendString:@"     "];
    }
    return all;
}

- (void)setCharacteristic:(NSString *)str
{
    g_characteristicStr = str;
    [self updateContent];
}

- (void)setTimeFormat:(NSString *)format
{
    g_formatStr = format;
    [self updateContent];
}

- (void)updateContent
{
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:[self markContent] attributes:[self getAttributes]];
}

- (NSDictionary *)getAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 100; // 字体的行间距
    UIFont *font = [UIFont systemFontOfSize:18];
    UIColor *color = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.14];
    NSDictionary *attributes = @{
        NSFontAttributeName : font,
        NSParagraphStyleAttributeName : paragraphStyle,
        NSForegroundColorAttributeName : color
    };
    return attributes;
}

- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:[NSDate date]];
}

- (UITextView *)textView
{
    if (!_textView)
    {
        UITextView *textView = [UITextView new];
        textView.backgroundColor = [UIColor clearColor];
        textView.editable = NO;
        textView.selectable = NO;
        textView.userInteractionEnabled = NO;
        _textView = textView;
    }
    return _textView;
}

@end
