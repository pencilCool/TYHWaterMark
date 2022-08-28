//
//  TYHWaterMark.m
//
//  Created by yuhua Tang on 2022/8/5.
//

#import "TYHWaterMark.h"
@import Aspects;
//
//NSArray<NSString *> *presentSystemVCs(void) {
//    static NSArray *list;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSMutableArray *array = @[].mutableCopy;
//        [array addObject:NSStringFromClass([UIImagePickerController class])];
//        [array addObject:NSStringFromClass([UIDocumentPickerViewController class])];
//        [array addObject:NSStringFromClass([UIDocumentMenuViewController class])];
//
//        if (@available(iOS 13.0, *)) {
//            [array addObject:NSStringFromClass([UIFontPickerViewController class])];
//        }
//
//        if (@available(iOS 14.0, *)) {
//            [array addObject:NSStringFromClass([UIColorPickerViewController class])];
//        }
//
//        list = [array copy];
//    });
//    return list;
//}

static NSString *g_characteristicStr = @"";
static NSString *g_formatStr = @"yyyy-MM-dd";
static TYHWaterMarkView *g_waterMarkView = nil;

@interface TYHWaterMarkView ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSDictionary *textAttributes;
@end

@implementation TYHWaterMarkView
+ (void)initialize
{
    [UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> aspectInfo, UIViewController *vc, BOOL animated, id completion) {
                                NSString *vcClassName = NSStringFromClass([vc class]);
//                                if ([presentSystemVCs() containsObject:vcClassName])
                                if([vcClassName hasPrefix:@"UI"]
                                   && ![vc isKindOfClass:[UIAlertController class]]
                                   && ![vc isMemberOfClass:[UIViewController class]])
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
                                    if (g_waterMarkView)
                                    {
                                        g_waterMarkView.hidden = NO;
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
    self.frame = CGRectMake(-0.5 * width, -0.5 * height, 2 * width, 2 * height);
    self.layer.zPosition = 999;
    [self addSubview:self.textView];
    self.textView.frame = CGRectMake(0, 0, 2 * width, 2 * height);
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:[self markContent] attributes:self.textAttributes];
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
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:[self markContent] attributes:self.textAttributes];
}

- (NSDictionary *)textAttributes {
    if (!_textAttributes) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 100; // 字体的行间距
        UIFont *font = [UIFont systemFontOfSize:18];
        UIColor *color = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.14];
        _textAttributes = @{
            NSFontAttributeName : font,
            NSParagraphStyleAttributeName : paragraphStyle,
            NSForegroundColorAttributeName : color
        };
    }
    return _textAttributes;
}

- (NSString *)stringWithFormat:(NSString *)format
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
    });
    [formatter setDateFormat:format];
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
