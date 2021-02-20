//
//  AEGuideViewConstants.h
//  AEGuideViewDemo
//
//  Created by WangLin on 2016/11/11.
//  Copyright © 2016年 amberease. All rights reserved.
//

#ifndef AEGuideViewConstants_h
#define AEGuideViewConstants_h

#define kAEGuideViewBounds [UIScreen mainScreen].bounds
#define kCellIdentifier_AEGuideViewCell @"AEGuideViewCell"

typedef void(^AEGuildeViewCompletionBlock)(void);

#define AEGuideViewLibraryLocalizedString(key, comment) \
NSLocalizedStringFromTableInBundle((key), @"AEGuideView", [NSBundle AEGuideView_LibraryBundle], (comment))

#endif /* AEGuideViewConstants_h */
