//
//  LXHTMLModelConfig.h
//  PeacockShop
//
//  Created by Cheng on 17/11/15.
//  Copyright © 2017年 LX. All rights reserved.
//

#ifndef LXHTMLModelConfig_h
#define LXHTMLModelConfig_h

#define kStringReplace(old,str,new)   [old stringByReplacingOccurrencesOfString:str withString:new]

#ifdef DEBUG

// 内调地址（闵亮）
//#define kLocalHtmlPath @"http://192.168.10.50:8060"

// 沙盒地址
#define kLocalHtmlPath [[NSBundle mainBundle].resourcePath stringByAppendingString:@"/Html.bundle"]

#else

#define kLocalHtmlPath [[NSBundle mainBundle].resourcePath stringByAppendingString:@"/Html.bundle"]

#endif

#define kLocalHtml(s) [NSString stringWithFormat:@"%@/%@",kLocalHtmlPath,s]

#endif /* LXHTMLModelConfig_h */
