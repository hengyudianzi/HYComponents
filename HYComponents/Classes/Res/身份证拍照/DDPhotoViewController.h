//
//  DDPhotoViewController.h
//  Loan
//

#import <UIKit/UIKit.h>



typedef void(^ImageBlock)(UIImage *image);


typedef enum : NSUInteger {
    IDCard,         //身份证
    IDCard_Front,   //正面
    IDCard_Back,    //反面
    BusCard         //公交卡
} CardType;

@interface DDPhotoViewController : UIViewController

@property (nonatomic, copy) ImageBlock imageblock;
@property (nonatomic, assign) CardType type;

@end
