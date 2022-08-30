//
//  CYCenterButton.h
//  MCMCDouTuArtifact
//
//  Created by 赵其龙 on 2021/7/22.
//

#import <UIKit/UIKit.h>
#define BULGEH 16

NS_ASSUME_NONNULL_BEGIN

@interface CYCenterButton : UIButton

/** Whether center button to bulge */
@property(assign , nonatomic,getter=is_bulge) BOOL bulge;

@end

NS_ASSUME_NONNULL_END
