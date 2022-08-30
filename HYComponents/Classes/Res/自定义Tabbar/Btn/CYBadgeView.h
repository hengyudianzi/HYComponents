//
//  CYBadgeView.h
//  MCMCDouTuArtifact
//
//  Created by 赵其龙 on 2021/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYBadgeView : UIButton

/** remind number */
@property (copy , nonatomic) NSString *badgeValue;
/** remind color */
@property (copy , nonatomic) UIColor *badgeColor;

@end

NS_ASSUME_NONNULL_END
