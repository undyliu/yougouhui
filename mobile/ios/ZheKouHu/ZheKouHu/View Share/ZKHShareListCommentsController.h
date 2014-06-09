//
//  ZKHShareListCommentsController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-9.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHShareListCommentsController : NSObject<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *comments;
@end

@interface ZKHSHareCommentCell : UITableViewCell

@end