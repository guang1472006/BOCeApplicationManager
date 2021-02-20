//
//  AEGuideViewInnerCollectionViewCell.h
//  AEGuideViewDemo
//
//  Created by WangLin on 2016/11/11.
//  Copyright © 2016年 amberease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEGuideViewConstants.h"


@interface AEGuideViewInnerCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic,assign) NSInteger lastButtonBottmSpace;
@end
