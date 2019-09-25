//
//  LXMessageList.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/13.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"

@interface LXMessageList : LXObject
@property (nonatomic,strong) NSMutableArray *dataArray;      /**< 数组 */
@end
@interface LXBorrowInfoModel :LXObject
@property (nonatomic,copy) NSString *Remark;                   /**< 备注 */
@property (nonatomic,copy) NSString *Reply;                    /**< 回复 */
@property (nonatomic,copy) NSString *UseTime;                  /**< 使用时间 */
@property (nonatomic,copy) NSString *ReturnTime;               /**< 还车时间 */
@property (nonatomic,assign) NSInteger BorrowStateId;          /**< 借车状态 */
@property (nonatomic,strong) NSString *carNumber;              /**< 车牌号 */
@property (nonatomic,strong) NSString *DriverPhone;            /**< 车主电话 */
@property (nonatomic,strong) NSString *OwnerPhone;             /**< 接车人电话 */
@end

@interface LXMessageModel : LXObject
@property (nonatomic,assign) NSInteger MsgInfoId;           /**< 消息id*/
@property (nonatomic,assign) NSInteger MsgTypeId;           /**< 消息类型 */
@property (nonatomic,strong) NSString  *MsgContent;         /**< 消息列表 */
@property (nonatomic,strong) NSString  *MsgLink;            /**< 消息连接 */
@property (nonatomic,strong) NSString  *AddTime;            /**< 添加时间 */
@property (nonatomic,assign) bool  IsRead;                  /**< 是否读 */
@property (nonatomic,strong) NSString  *TypeName;           /**< 添加时间 */
@property (nonatomic,strong) LXBorrowInfoModel *BorrowInfo;      /**<  */
@end

@interface LXMyMessageList : LXObject
@property (nonatomic,strong) NSMutableArray *dataArray;      /**< 数组 */
@end

@interface LXMyMessageDetailModel : LXObject
@property (nonatomic,assign) NSInteger MsgInfoId;           /**< 消息id*/
@property (nonatomic,assign) NSInteger MsgTypeId;           /**< 消息类型 */
@property (nonatomic,strong) NSString  *MsgContent;         /**< 消息列表 */
@property (nonatomic,strong) NSString  *AddTime;         /**< 消息列表 */
@property (nonatomic,assign) bool  IsRead;                  /**< 是否读 */ 
@end
@interface LXMyMessageModel : LXObject
@property (nonatomic,strong) LXMyMessageDetailModel *LastLetter;                          /**< 最后一条站内信 */
@property (nonatomic,assign) NSInteger               UnReadLetter;                        /**< 站内信未读数量 */
@property (nonatomic,strong) LXMyMessageDetailModel *LastNotice;                          /**< 最后一条公告, */
@property (nonatomic,assign) NSInteger               UnReadNotice;                        /**< 未读公告数量 */
@property (nonatomic,strong) LXMyMessageDetailModel *RequestCar;                          /**< 最后一条向朋友借车*/
@property (nonatomic,assign) NSInteger               UnReadRequestCar;                    /**< 向朋友借车数量, */
@property (nonatomic,strong) LXMyMessageDetailModel *BorrowCar;                           /**< 最后一条借车给朋友 */
@property (nonatomic,assign) NSInteger               UnReadBorrowCar;                     /**< 借车给朋友的数量*/
@end
