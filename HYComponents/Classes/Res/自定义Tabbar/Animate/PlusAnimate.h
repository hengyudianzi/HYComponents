//
//  PlusAnimate.h
//  MCMCDouTuArtifact
//
//  Created by 赵其龙 on 2021/7/22.
//

#import <UIKit/UIKit.h>

//通知点击按钮协议
@protocol PublishAnimateDelegate <NSObject>
- (void)didSelectBtnWithBtnTag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_BEGIN

@interface PlusAnimate : UIView


//通知点击按钮代理人
@property(weak,nonatomic) id<PublishAnimateDelegate> delegate;
//弹出动画view
+(PlusAnimate *)standardPublishAnimateWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
