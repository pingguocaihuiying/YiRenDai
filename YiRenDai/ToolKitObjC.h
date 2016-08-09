//
//  Verify.h
//  YiRenDai
//
//  Created by Rain on 16/5/7.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolKitObjC : NSObject

#pragma mark 判断身份证格式是否正确
+ (BOOL)hyb_isValidPersonID:(NSString *)personId;

#pragma mark - 根据银行卡号获取银行名称
+ (NSString *)returnBankName:(NSString*) idCard;

@end
