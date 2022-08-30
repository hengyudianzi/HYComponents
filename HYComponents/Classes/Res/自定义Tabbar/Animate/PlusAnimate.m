//
//  PlusAnimate.m
//  MCMCDouTuArtifact
//
//  Created by 赵其龙 on 2021/7/22.
//

#import "PlusAnimate.h"
#import "Header.h"


@interface PlusAnimate()
//center button
@property (strong , nonatomic) UIButton* CenterBtn;
//other function button
@property (strong , nonatomic) NSMutableArray* BtnItem;
@property (strong , nonatomic) NSMutableArray* BtnItemTitle;
/** rect */
@property (nonatomic,assign) CGRect rect;
@end


@implementation PlusAnimate

/**
 *  show view
 */
+ (PlusAnimate *)standardPublishAnimateWithView:(UIView *)view{
    PlusAnimate * animateView = [[PlusAnimate alloc]init];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:animateView];
    CGRect rect = [animateView convertRect:view.frame fromView:view.superview];
    rect.origin.y += 5;
    animateView.rect = rect;
    
    //Add button
    
    [animateView CrentBtnImageName:@"make_tx" Title:@"头像制作" tag:3];
    [animateView CrentBtnImageName:@"make_cj" Title:@"九宫格裁剪" tag:4];
    [animateView CrentBtnImageName:@"make_qr" Title:@"二维码" tag:5];
    [animateView CrentBtnImageName:@"make_gif" Title:@"GIF制作" tag:2];
    [animateView CrentBtnImageName:@"make_bq" Title:@"表情制作" tag:1];
//    [animateView CrentBtnImageName:@"make_mb" Title:@"模版制作" tag:0];
    [animateView CrentBtnImageName:@"make_mb" Title:@"发布圈" tag:6];
//    if ([McMcFUNCMethod isHasUserPower]) {
//        [animateView CrentBtnImageName:@"make_mb" Title:@"发布圈" tag:6];
//    }
    

//    [animateView CrentBtnImageName:@"post_animate_akey" Title:@"一键转卖" tag:6];

    //Add center button
    [animateView CrentCenterBtnImageName:@"post_animate_add" tag:3];
    //Do animation
    [animateView AnimateBegin];
    return animateView;
}

- (instancetype)init{
    self = [super init];
    if (self)
    {
        self.frame = [[UIScreen mainScreen]bounds];
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [visualEffectView setFrame:self.bounds];
        [self addSubview:visualEffectView];
        
    }
    return self;
}

/**
 *  creat button
 */
- (void)CrentBtnImageName:(NSString *)ImageName Title:(NSString *)Title tag:(int)tag{
//    if (_BtnItem.count >= 3)  return;
    UIButton * btn = [[UIButton alloc]initWithFrame:self.rect];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self.BtnItem addObject:btn];
    [self.BtnItemTitle addObject:[self CrenterBtnTitle:Title]];
}

/**
 *  creat center button
 */
- (void)CrentCenterBtnImageName:(NSString *)ImageName tag:(int)tag{
    _CenterBtn = [[UIButton alloc]initWithFrame:self.rect];
    [_CenterBtn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [_CenterBtn addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
    _CenterBtn.tag = tag;
    [self addSubview:_CenterBtn];
}

/**
 *  getter
 */
- (NSMutableArray *)BtnItem{
    if (!_BtnItem) {
        _BtnItem = [NSMutableArray array];
    }
    return _BtnItem;
}
- (NSMutableArray *)BtnItemTitle{
    if (!_BtnItemTitle) {
        _BtnItemTitle = [NSMutableArray array];
    }
    return _BtnItemTitle;
}
- (UILabel *)CrenterBtnTitle:(NSString *)Title{
    UILabel * lab = [[UILabel alloc]init];
    lab.textColor = Color(240, 240, 240,1);
    lab.font = [UIFont italicSystemFontOfSize:13.5*bl];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = Title;
    [self addSubview:lab];
    return lab;
}

/**
 *  remove view and notice the selectIndex
 */
- (void)removeView:(UIButton*)btn{
    [self removeFromSuperview];
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
}

/**
 *  click other space to cancle
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAnimation];
}

/**
 *  button click
 */
- (void)BtnClick:(UIButton*)btn{
    NSLog(@"%ld click",(long)btn.tag);
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
    [self removeFromSuperview];
}


/**
 *  Do animation
 */
- (void)AnimateBegin{
    //centet button rotation
    [UIView animateWithDuration:0.2 animations:^{
        _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4-M_LOG10E);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4+M_LOG10E);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
            }];
        }];
    }];
    
    
    __block int  i = 0 , k = 0;
    
    NSInteger index = 0;
    for (UIView *  btn in _BtnItem) {
        //rotation
        [UIView animateWithDuration:0.7 delay:i*0.14 usingSpringWithDamping:0.46 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            btn.transform = CGAffineTransformScale(btn.transform, 1.2734*bl, 1.2734*bl);//缩放
            if (index >=3 && index <=5) {
                i = (i-2) + 1;
                btn.center = CGPointMake((74+i*113)*bl, self.frame.size.height-165*bl-125*bl);
            }else if (index >= 6) {
                NSInteger h = (index )/3;
                i = (i-2) + 2;
                btn.center = CGPointMake((74+i*113)*bl, self.frame.size.height-165*bl-125*h*bl);
            }else{
                btn.center = CGPointMake((74+i++*113)*bl, self.frame.size.height-165*bl);
            }
            
        } completion:nil];

        //move
        [UIView animateWithDuration:0.2 delay:i*0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            btn.transform = CGAffineTransformRotate (btn.transform, -M_2_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                btn.transform = CGAffineTransformRotate (btn.transform, M_2_PI+M_LOG10E);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    btn.transform = CGAffineTransformRotate (btn.transform, -M_LOG10E);
                } completion:^(BOOL finished) {
                    UILabel * lab = (UILabel *)_BtnItemTitle[ index];
                    lab.frame = CGRectMake(0, 0, KH/3-30, 30);
                    lab.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)+20);
                }];
            }];
        }];
        index += 1;
    }
    

}


/**
 *  Cancle animation
 */
- (void)cancelAnimation{
    //rotation
    [UIView animateWithDuration:0.15 animations:^{
        _CenterBtn.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        //move
        int n = (int)_BtnItem.count;
        for (int i = n-1; i>=0; i--){
            UIButton *btn = _BtnItem[i];
            [UIButton animateWithDuration:0.25 delay:0.1*(n-i) options:UIViewAnimationOptionTransitionCurlDown animations:^{
                btn.center = CGPointMake(KW/2 ,KH-43.052385);
                btn.transform = CGAffineTransformMakeScale(1, 1);
                btn.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
                
                UILabel * lab = (UILabel *)_BtnItemTitle[i];
                [lab removeFromSuperview];
            } completion:^(BOOL finished) {
                [btn removeFromSuperview];
                if (i==0) {
                    [self removeFromSuperview];
                }
            }];
        }
    }];
    
}

@end
