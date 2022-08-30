//
//  Header.h
//  Pods
//
//  Created by 🐲 on 2022/8/29.
//

#ifndef Header_h
#define Header_h

//#import "Masonry.h"

#define WeakSelf __weak typeof(self) weakSelf = self;
#define Color(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define bl [[UIScreen mainScreen]bounds].size.width/375
#define KW  (MIN([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width))
#define KH  ([UIScreen mainScreen].bounds.size.height)

#endif /* Header_h */
