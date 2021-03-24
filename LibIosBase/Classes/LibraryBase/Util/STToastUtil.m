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
#import "STStringUtil.h"

@implementation STToastUtil

+ (void)show:(NSString *)message{
    if([STStringUtil emptyOrNull:message]){
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[STSystemUtil topViewController].view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:15.f];
    hud.margin = 10.f; // text margin
    hud.offset = CGPointMake(0.f, STSystemUtil.deviceScreenHeight / 2 - 70);
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [[UIColor alloc] initWithHex:@"#333333"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [hud hideAnimated:YES afterDelay:2];
}

@end
