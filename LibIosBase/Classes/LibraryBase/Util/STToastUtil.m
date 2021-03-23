//
//  STToastUtil.m
//  Template
//
//  Created by krmao on 2020/12/23.
//  Copyright © 2020 smart. All rights reserved.
//

#import "STToastUtil.h"
#import "STSystemUtil.h"
#import "MBProgressHUD.h"
#import "UIColor+ARGB.h"

@implementation STToastUtil

+ (void)show:(NSString *)message{
    NSString * fMessage = message; //@"dsjhaflkashdfklsafklasjflaskdjflkasfdlkasfalksfhaslkjfhaslkdsjhaflkashdfklsafklasjflaskdjflkasfdlkasfalksfhaslkjfhaslk";
    BOOL animation = YES;
    UIView *view = [STSystemUtil topViewController].view;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    [view addSubview:hud];
    
    hud.userInteractionEnabled = NO;
    hud.backgroundColor = [UIColor clearColor]; // fullscreen background color
    hud.contentColor = [UIColor clearColor];
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.mode = MBProgressHUDModeCustomView;
    CGRect messageRect = [STSystemUtil getTextSizeWithBoundingRect:fMessage withSize:CGSizeMake(0, 0) withFont:[UIFont systemFontOfSize:15]];
    // CGRect messageRect = [fMessage boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]} context:nil];
    hud.minSize = CGSizeMake(messageRect.size.width+30, messageRect.size.height + 15);
    hud.bezelView.color = [UIColor clearColor];
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.layer.masksToBounds = NO;
    hud.bezelView.layer.backgroundColor = [[UIColor alloc] initWithHex:@"#333333"].CGColor;
    hud.bezelView.layer.cornerRadius = 15.0;

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, messageRect.size.width+30 , messageRect.size.height + 10)];
    titleLabel.text = fMessage;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [hud.bezelView addSubview:titleLabel];
    
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud showAnimated:animation];
    [hud hideAnimated:animation afterDelay:2.0];
}

@end
