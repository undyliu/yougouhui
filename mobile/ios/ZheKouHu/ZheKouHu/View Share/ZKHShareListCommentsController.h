//
//  ZKHShareListCommentsController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-9.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZKHCommentChangedDelegate <NSObject>

- (void) updateComments:(NSMutableArray *)comments;

@end

@interface ZKHShareListCommentsController : NSObject<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *comments;
@property (strong, nonatomic) id<ZKHCommentChangedDelegate> commentDelegate;
@end

@interface ZKHSHareCommentCell : UITableViewCell

@end