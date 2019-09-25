//
//  LXRoadAdministrationModel.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/21.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"
@interface LXRoadAdministrationDetailModel : LXObject
@property (nonatomic,assign) NSInteger CMSNavId; /**< */
@property (nonatomic,assign) NSInteger ParentId; /**< 上级导航 */
@property (nonatomic,assign) NSInteger NavLevel; /**< 导航级别 */
@property (nonatomic,assign) NSInteger SortNO;   /**< 排序号 */
@end

@interface LXRoadAdministrationModel : LXObject
@property (nonatomic,assign) NSInteger       CMSArticleId;      /**< 导航 */
@property (nonatomic,assign) NSInteger       CMSNavId;          /**< 导航 */
@property (nonatomic,copy) NSString       *ArticleTitle;      /**< 标题 */
@property (nonatomic,copy) NSString       *ArticleContent;    /**< 内容 */
@property (nonatomic,copy) NSString       *LinkUrl;           /**< 链接地址 */
@property (nonatomic,copy) NSString       *ComeFrom;          /**< 来源   */
@property (nonatomic,copy) NSString       *PublishTime;       /**< 发布时间   */
@property (nonatomic,assign) BOOL           IsPublish;          /**< 已发布 */
@property (nonatomic,copy) NSString       *Introduction;      /**< 简介 */
@property (nonatomic,strong) LXRoadAdministrationDetailModel *MPCMSNavId; /**<  */
@end

@interface LXRoadAdministrationListModel : LXObject
@property (nonatomic,strong) NSMutableArray *dataArray;          /**< 通知 */
@end
