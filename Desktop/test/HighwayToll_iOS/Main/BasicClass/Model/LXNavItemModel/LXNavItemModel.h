//
//  CWNavItemModel.h
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 Dandre. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  CWNavItemModel 用于进行单个item设置
 */
@interface LXNavItemModel : NSObject

/**
 *  button文字
 */
@property (nonatomic,copy) NSString *title;

/**
 *  button贴图的名称
 */
@property (nonatomic,copy) NSString *imageName;

/**
 *  button对应的方法
 */
//@property (nonatomic,assign) SEL selector;

/**
 *  button的位置
 */
@property (nonatomic,assign) BOOL isLeft;

@end
