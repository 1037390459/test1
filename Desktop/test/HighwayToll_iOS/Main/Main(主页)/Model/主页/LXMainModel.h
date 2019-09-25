//
//  LXMainModel.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/21.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"

@interface LXMainModel : LXObject
@property (nonatomic,copy) NSString *Title;                     /**< 标题 */
@property (nonatomic,copy) NSString *ImageUrl;                  /**< 图片连接地址  */
@property (nonatomic,strong) NSString *LinkUrl;                 /**< 连接地址 */
@end

@interface LXMainListModel : LXObject
@property (nonatomic,strong) NSMutableArray *dataArray;          /**<  */
@property (nonatomic,strong) NSMutableArray *imageArray;         /**<  */
@end

