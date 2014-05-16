INSERT INTO `e_channel` VALUES ('0', 'all', '全部', '', null, '0', null, '1');
INSERT INTO `e_channel` VALUES ('1', 'food', '美食', '', null, '1', null, '1');
INSERT INTO `e_channel` VALUES ('2', 'clothes', '服装', '', null, '2', null, '1');
INSERT INTO `e_channel` VALUES ('3', 'beauty', '美妆', '', null, '3', null, '1');
INSERT INTO `e_channel` VALUES ('40', 'baby', '母婴', 'baby.html', null, '4', null, '0');
INSERT INTO `e_channel` VALUES ('41', 'computer', '电脑', 'computer.html', null, '5', null, '0');
INSERT INTO `e_channel` VALUES ('42', 'book', '书城', 'book.html', null, '6', null, '0');
INSERT INTO `e_channel` VALUES ('43', 'furniture\r\nfurniture', '家居', null, null, '7', null, '1');


-- ----------------------------
-- Records of e_module
-- ----------------------------
INSERT INTO `e_module` VALUES ('101', 'friends', '朋友圈', 'img/friend.png', 'friends.html', null, '0', 'discover', '1');
INSERT INTO `e_module` VALUES ('102', 'radar', '雷达', 'img/radar.png', 'radar.html', null, '1', 'discover', '1');
INSERT INTO `e_module` VALUES ('103', 'recommend', '推荐', 'img/recommend.png', 'recommend.html', null, '2', 'discover', '0');
INSERT INTO `e_module` VALUES ('104', 'hot', '热门', 'img/hot.png', 'hot.html', null, '3', 'discover', '0');
INSERT INTO `e_module` VALUES ('105', 'compare', '比价', 'img/compare.png', null, null, '4', 'discover', '0');
INSERT INTO `e_module` VALUES ('106', 'join', '拼单', 'img/join.png', null, null, '5', 'discover', '0');
INSERT INTO `e_module` VALUES ('201', 'settings', '设置', 'img/settings.png', 'settings.html', null, '0', 'me', '1');
INSERT INTO `e_module` VALUES ('202', 'contact_list', '通讯录', 'img/add_friend.png', 'contact_list.html', null, '1', 'me', '1');
INSERT INTO `e_module` VALUES ('203', 'my_favorite', '我的收藏', 'img/favorite.png', 'my_favorite.html', null, '2', 'me', '1');
INSERT INTO `e_module` VALUES ('204', 'my_share', '我的分享', 'img/share.png', 'my_share.html', null, '3', 'me', '1');
INSERT INTO `e_module` VALUES ('205', 'my_shop', '我的店铺', 'img/my_shop.png', 'my_shop.html', null, '4', 'me', '1');
INSERT INTO `e_module` VALUES ('206', 'my_grade', '我的积分', 'img/my_grade.png', 'my_grade.html', null, '5', 'me', '1');
INSERT INTO `e_module` VALUES ('207', 'my_message', '我的消息', null, null, null, '6', 'me', '1');


-- ----------------------------
-- Records of e_setting
-- ----------------------------
INSERT INTO `e_setting` VALUES ('1', 'login', '登录设置', '0', null, '1');
INSERT INTO `e_setting` VALUES ('2', 'cache', '缓存', '1', null, '0');
INSERT INTO `e_setting` VALUES ('3', 'radar', '雷达配置', '2', null, '1');
INSERT INTO `e_setting` VALUES ('9999', 'logout', '退出', '9999', null, '1');


-- ----------------------------
-- Records of e_trade
-- ----------------------------
insert into e_trade select uuid, code, name, ord_index, is_used from e_channel;
-- ----------------------------
-- Records of e_mapping_ct
-- ----------------------------