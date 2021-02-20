//
//  BOCeNetImageRequest.h
//  Industrial
//
//  Created by boce on 2019/11/26.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AliyunOSSiOS/AliyunOSSiOS.h>

typedef void(^BOCeUploadProgress)(float progress);


NS_ASSUME_NONNULL_BEGIN

@interface BOCeNetImageRequest : OSSPutObjectRequest

/**
 上传的图片（yyyy-MM-dd）
 */
@property(strong,nonatomic)UIImage *uploadImage;

/**
 上传的文件路径
 */
@property(strong,nonatomic)NSString *filePath;

/**
 文件名
 */
@property(strong,nonatomic)NSString *fileName;

/**
上传图片限制的大小(默认1M)
*/
@property(assign,nonatomic)NSInteger limitLength;

/**
上传日期
*/
@property(strong,nonatomic,readonly)NSString *uploadDate;

/**
是否显示遮罩
*/
@property(assign,nonatomic)BOOL enableMark;

/**
请求进度
*/
@property(strong,nonatomic)BOCeUploadProgress BOCeUploadProgress;

@end

NS_ASSUME_NONNULL_END
