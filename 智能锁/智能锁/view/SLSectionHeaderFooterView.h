//
//  SLSectionHeaderFooterView.h
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLSectionHeaderFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (copy, nonatomic) void(^onClickedListener)(id sender);
@property (assign, nonatomic, getter=isSelected) BOOL selected;

@end

NS_ASSUME_NONNULL_END
