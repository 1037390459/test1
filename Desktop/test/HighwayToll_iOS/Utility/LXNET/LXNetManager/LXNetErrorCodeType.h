//
//  LXNetErrorCode.h
//  LX
//
//  Created by cheng on 16/7/14.
//  Copyright © 2017年 LX Inc. All rights reserved.
//

#ifndef CWNetErrorCodeType_h
#define CWNetErrorCodeType_h

/**
 *  网络层访问错误代码
 */
typedef NS_ENUM(NSInteger, CWNetErrorCode) {
    CWNetErrorCodeNormal                = 0,       /**< 正常 */
    CWNetErrorCodeServerException       = -10002,   /**< 服务器内部异常 */
    CWNetErrorCodeDataCheckException    = -10003,   /**< 数据校验异常 */
    CWNetErrorCodeSignatureFailure      = -10010,   /**< 签名失败或签名不合法 */
    CWNetErrorCodeSessionExpired        = -10011,   /**< 会话过期或错误 */
    CWNetErrorCodeForceHTTPS            = -20002,   /**< 强制HTTPS */
};

#endif /* CWNetErrorCode_h */
