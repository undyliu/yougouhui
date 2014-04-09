/*
Navicat MySQL Data Transfer

Source Server         : localhost_ebs
Source Server Version : 50511
Source Host           : localhost:3306
Source Database       : ebs

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2014-04-09 17:54:36
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `e_activity`
-- ----------------------------
DROP TABLE IF EXISTS `e_activity`;
CREATE TABLE `e_activity` (
  `uuid` varchar(36) NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `channel_id` varchar(36) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `shop_id` varchar(36) DEFAULT NULL,
  `geo` varchar(128) DEFAULT NULL,
  `publisher` varchar(36) DEFAULT NULL,
  `publish_time` datetime DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` datetime DEFAULT NULL,
  `price` double(16,2) DEFAULT NULL,
  `discount` double(16,2) DEFAULT NULL,
  `visit_count` int(11) DEFAULT NULL,
  `discuss_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动记录表';

-- ----------------------------
-- Records of e_activity
-- ----------------------------
INSERT INTO `e_activity` VALUES ('1', 'iOS 6.1', '<p>Apple released iOS 6.1</p><p class=\"ui-li-aside\">iOS</p>', 'apple.png', '1', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
INSERT INTO `e_activity` VALUES ('2', 'BlackBerry 10', '<p>BlackBerry launched the Z10 and Q10 with the new BB10 OS</p><p class=\"ui-li-aside\">BlackBerry</p>\n				<p class=\"ui-li-aside\">BlackBerry</p>', 'blackberry_10.png', '2', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
INSERT INTO `e_activity` VALUES ('3', 'WP 7.8', '<p>Nokia rolls out WP 7.8 to Lumia 800</p><p class=\"ui-li-aside\">Windows Phone</p>', 'lumia_800.png', '41', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
INSERT INTO `e_activity` VALUES ('4', 'Galaxy', '<p>New Samsung Galaxy Express</p><p class=\"ui-li-aside\">Samsung</p>', 'galaxy_express.png', '1', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
INSERT INTO `e_activity` VALUES ('5', 'Nexus 7', '<p>Rumours about new full HD Nexus 7</p><p class=\"ui-li-aside\">Android</p>', 'nexus_7.png', '1', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
INSERT INTO `e_activity` VALUES ('6', 'Firefox OS', '<p>ZTE to launch Firefox OS smartphone at MWC</p><p class=\"ui-li-aside\">Firefox</p>', 'firefox_os.png', '3', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
INSERT INTO `e_activity` VALUES ('7', 'Tizen', '<p>First Samsung phones with Tizen can be expected in 2013</p><p class=\"ui-li-aside\">Tizen</p>', 'tizen.png', '41', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
INSERT INTO `e_activity` VALUES ('8', 'Symbian', '<p>Nokia confirms the end of Symbian</p><p class=\"ui-li-aside\">Symbian</p>', null, '2', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
INSERT INTO `e_activity` VALUES ('9', 'Symbian', '<p>Nokia confirms the end of Symbian</p>', null, '42', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);

-- ----------------------------
-- Table structure for `e_activity_img`
-- ----------------------------
DROP TABLE IF EXISTS `e_activity_img`;
CREATE TABLE `e_activity_img` (
  `uuid` varchar(36) NOT NULL,
  `img` varchar(128) DEFAULT NULL,
  `activity_id` varchar(36) NOT NULL,
  `ord_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_activity_img
-- ----------------------------

-- ----------------------------
-- Table structure for `e_channel`
-- ----------------------------
DROP TABLE IF EXISTS `e_channel`;
CREATE TABLE `e_channel` (
  `uuid` varchar(36) NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `ord_index` int(11) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` datetime DEFAULT NULL,
  `is_used` varchar(1) DEFAULT '1',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_channel_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目表';

-- ----------------------------
-- Records of e_channel
-- ----------------------------
INSERT INTO `e_channel` VALUES ('0', 'all', '全部', '', null, '0', null, null, null, null, null, '1');
INSERT INTO `e_channel` VALUES ('1', 'food', '美食', '', null, '1', null, null, null, null, null, '1');
INSERT INTO `e_channel` VALUES ('2', 'clothes', '服装', '', null, '2', null, null, null, null, null, '1');
INSERT INTO `e_channel` VALUES ('3', 'beauty', '美妆', '', null, '3', null, null, null, null, null, '1');
INSERT INTO `e_channel` VALUES ('40', 'baby', '母婴', 'baby.html', null, '4', null, null, null, null, null, '1');
INSERT INTO `e_channel` VALUES ('41', 'computer', '电脑', 'computer.html', null, '5', null, null, null, null, null, '1');
INSERT INTO `e_channel` VALUES ('42', 'book', '书城', 'book.html', null, '6', null, null, null, null, null, '1');

-- ----------------------------
-- Table structure for `e_comment`
-- ----------------------------
DROP TABLE IF EXISTS `e_comment`;
CREATE TABLE `e_comment` (
  `uuid` varchar(36) NOT NULL,
  `share_id` varchar(36) DEFAULT NULL,
  `comment_id` varchar(36) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `publisher` varchar(36) DEFAULT NULL,
  `publish_time` varchar(16) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_comment
-- ----------------------------
INSERT INTO `e_comment` VALUES ('5d812a9a-ead1-49d4-9ca5-a4f4ae92e662', '11e4c01a-2155-4822-bec5-3d83d55481a4', null, '非常不错', '4eae0ad3-dfe1-40c9-8241-188885c86377', '1396583178296', '0');
INSERT INTO `e_comment` VALUES ('a399f33d-0178-4c69-92e2-e0b5b5925071', '11e4c01a-2155-4822-bec5-3d83d55481a4', null, '看起来很好', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1396583740343', '0');

-- ----------------------------
-- Table structure for `e_discuss`
-- ----------------------------
DROP TABLE IF EXISTS `e_discuss`;
CREATE TABLE `e_discuss` (
  `uuid` varchar(36) NOT NULL,
  `activity_id` varchar(36) DEFAULT NULL,
  `discuss_id` varchar(36) DEFAULT NULL COMMENT '用于点评的记录别人还可点评',
  `content` varchar(2000) DEFAULT NULL,
  `publisher` varchar(36) DEFAULT NULL,
  `publish_time` date DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_discuss
-- ----------------------------

-- ----------------------------
-- Table structure for `e_friend`
-- ----------------------------
DROP TABLE IF EXISTS `e_friend`;
CREATE TABLE `e_friend` (
  `uuid` varchar(36) NOT NULL,
  `friend_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_friend
-- ----------------------------
INSERT INTO `e_friend` VALUES ('0bec1918-c45b-44dc-ab78-6791c25fb5d8', '4eae0ad3-dfe1-40c9-8241-188885c86377', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1');
INSERT INTO `e_friend` VALUES ('0ccbf194-a1d8-478f-b262-b228732b8667', '43c72a72-ca25-4415-a5df-cff584fec842', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '0');
INSERT INTO `e_friend` VALUES ('46d5eed0-2be2-44c3-a000-733e4b86dbfe', 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '0');
INSERT INTO `e_friend` VALUES ('62b301fd-0a5a-44a9-8ac3-2548b9f9bb0d', '4eae0ad3-dfe1-40c9-8241-188885c86377', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '0');
INSERT INTO `e_friend` VALUES ('6c6c114a-6a10-495f-8836-f8788e0dd6e1', '43c72a72-ca25-4415-a5df-cff584fec842', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1');
INSERT INTO `e_friend` VALUES ('8bfdacbb-8440-468a-85f0-03b0646bba28', 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1');
INSERT INTO `e_friend` VALUES ('9c4b1402-dea8-4ddb-ad49-1a25ee7f63c6', '43c72a72-ca25-4415-a5df-cff584fec842', '4eae0ad3-dfe1-40c9-8241-188885c86377', '0');
INSERT INTO `e_friend` VALUES ('b5e7431a-5014-49d3-985f-30f2ab6cce57', 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1');
INSERT INTO `e_friend` VALUES ('cd2389cd-39c6-4f87-b7f4-fdb239155b5c', '43c72a72-ca25-4415-a5df-cff584fec842', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1');
INSERT INTO `e_friend` VALUES ('de266908-db43-44eb-84e1-708561b8d20a', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '4eae0ad3-dfe1-40c9-8241-188885c86377', '1');
INSERT INTO `e_friend` VALUES ('e53d0478-52c4-4e87-b058-863e83adf11f', '4eae0ad3-dfe1-40c9-8241-188885c86377', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1');
INSERT INTO `e_friend` VALUES ('ef917ef5-509a-4e5b-8eb7-b18c40539a03', '43c72a72-ca25-4415-a5df-cff584fec842', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1');

-- ----------------------------
-- Table structure for `e_log`
-- ----------------------------
DROP TABLE IF EXISTS `e_log`;
CREATE TABLE `e_log` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `act_time` date DEFAULT NULL,
  `action` varchar(32) DEFAULT NULL,
  `act_cotent` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_log
-- ----------------------------

-- ----------------------------
-- Table structure for `e_message`
-- ----------------------------
DROP TABLE IF EXISTS `e_message`;
CREATE TABLE `e_message` (
  `uuid` varchar(36) NOT NULL,
  `sender` varchar(36) NOT NULL,
  `receiver` varchar(36) NOT NULL,
  `content` varchar(500) DEFAULT NULL,
  `send_time` varchar(16) DEFAULT NULL,
  `type` int(1) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `reply_mess_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_message
-- ----------------------------

-- ----------------------------
-- Table structure for `e_module`
-- ----------------------------
DROP TABLE IF EXISTS `e_module`;
CREATE TABLE `e_module` (
  `uuid` varchar(36) NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `icon` varchar(64) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `ord_index` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `is_used` int(1) DEFAULT '1',
  `creator` varchar(36) DEFAULT NULL,
  `create_time` varchar(16) DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `U_discover_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_module
-- ----------------------------
INSERT INTO `e_module` VALUES ('101', 'friends', '朋友圈', 'img/friend.png', 'friends.html', null, '0', 'discover', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('102', 'radar', '雷达', 'img/radar.png', 'radar.html', null, '1', 'discover', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('103', 'recommend', '推荐', 'img/recommend.png', 'recommend.html', null, '2', 'discover', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('104', 'hot', '热门', 'img/hot.png', 'hot.html', null, '3', 'discover', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('105', 'compare', '比价', 'img/compare.png', null, null, '4', 'discover', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('106', 'join', '拼单', 'img/join.png', null, null, '5', 'discover', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('201', 'settings', '设置', 'img/settings.png', 'settings.html', null, '0', 'me', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('202', 'contact_list', '通讯录', 'img/add_friend.png', 'contact_list.html', null, '1', 'me', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('203', 'my_favorite', '我的收藏', 'img/favorite.png', 'my_favorite.html', null, '2', 'me', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('204', 'my_share', '我的分享', 'img/share.png', 'my_share.html', null, '3', 'me', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('205', 'my_shop', '我的店铺', 'img/my_shop.png', 'my_shop.html', null, '4', 'me', '1', null, null, null, null);
INSERT INTO `e_module` VALUES ('206', 'my_grade', '我的积分', 'img/my_grade.png', 'my_grade.html', null, '5', 'me', '1', null, null, null, null);

-- ----------------------------
-- Table structure for `e_share`
-- ----------------------------
DROP TABLE IF EXISTS `e_share`;
CREATE TABLE `e_share` (
  `uuid` varchar(36) NOT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `geo` varchar(128) DEFAULT NULL,
  `publisher` varchar(36) DEFAULT NULL,
  `publish_time` varchar(16) DEFAULT NULL,
  `publish_date` varchar(10) DEFAULT NULL,
  `activity_id` varchar(36) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share
-- ----------------------------
INSERT INTO `e_share` VALUES ('11e4c01a-2155-4822-bec5-3d83d55481a4', '圣诞节购物季', null, '43c72a72-ca25-4415-a5df-cff584fec842', '1396583054328', '2014-04-04', null, '0');
INSERT INTO `e_share` VALUES ('1a78b60a-dcad-4a45-b83f-822fc8e4f89d', '永旺的探路者打折很厉害', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1396583684640', '2014-04-04', null, '0');
INSERT INTO `e_share` VALUES ('97dd86ad-f227-44f1-8791-73860dc9dfd4', '新辣道鱼火锅', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1396573458937', '2014-04-04', null, '0');

-- ----------------------------
-- Table structure for `e_share_img`
-- ----------------------------
DROP TABLE IF EXISTS `e_share_img`;
CREATE TABLE `e_share_img` (
  `uuid` varchar(36) NOT NULL,
  `img` varchar(128) DEFAULT NULL,
  `share_id` varchar(36) NOT NULL,
  `ord_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share_img
-- ----------------------------
INSERT INTO `e_share_img` VALUES ('4c0215d4-a422-4add-9e0f-67e0387448c3', '1031961510_1396583010680.png', '11e4c01a-2155-4822-bec5-3d83d55481a4', '1');
INSERT INTO `e_share_img` VALUES ('5ed0e8c4-4dd3-4383-96bc-a814492fc42d', '832378606_1396573415956.png', '97dd86ad-f227-44f1-8791-73860dc9dfd4', '1');
INSERT INTO `e_share_img` VALUES ('6c5fe797-4f05-470e-86de-34d3dcb01e4d', '537577157_1396583627575.png', '1a78b60a-dcad-4a45-b83f-822fc8e4f89d', '2');
INSERT INTO `e_share_img` VALUES ('97cfb2e8-29fd-414a-b607-2e479787cb10', '602324364_1396583627574.png', '1a78b60a-dcad-4a45-b83f-822fc8e4f89d', '1');

-- ----------------------------
-- Table structure for `e_shop`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop`;
CREATE TABLE `e_shop` (
  `uuid` varchar(36) NOT NULL,
  `name` varchar(64) NOT NULL,
  `trademark` varchar(128) DEFAULT NULL,
  `shop_img` varchar(128) DEFAULT NULL,
  `geo` varchar(128) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `busi_license` varchar(128) DEFAULT NULL,
  `credit_rank` int(11) DEFAULT NULL,
  `owner` varchar(36) DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `create_time` varchar(16) DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  `register_time` varchar(16) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '0:注册未审核，1:已审核，2:已注销',
  `barcode` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop
-- ----------------------------
INSERT INTO `e_shop` VALUES ('08c181bd-afa8-48ab-8522-ef22c89b3851', '上地华联一品香美食', null, '-703256829_1397006580733.png', null, '5555555', '666666', '-1400089674_1396933730140.png', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', null, null, null, null, '1396933731990', '1', null);
INSERT INTO `e_shop` VALUES ('c1b1adb2-8e39-4850-ad4a-edaf4bc4651d', '昌平永旺商场探路者专卖店', null, '-1303150572_1397036911977.png', null, '222', '3干活奋斗史', '463517179_1396871363810.png', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', null, null, null, null, '1396871367348', '0', 'barcode_-1053622591_1397036937468.png');

-- ----------------------------
-- Table structure for `e_shop_emp`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_emp`;
CREATE TABLE `e_shop_emp` (
  `uuid` varchar(36) NOT NULL,
  `shop_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `pwd` varchar(36) DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `create_time` varchar(16) DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_emp
-- ----------------------------
INSERT INTO `e_shop_emp` VALUES ('5bb94c4a-e542-4f45-95d6-b057c1513e1b', 'c1b1adb2-8e39-4850-ad4a-edaf4bc4651d', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1111', null, null, null, null);
INSERT INTO `e_shop_emp` VALUES ('ae419f22-d686-458b-a0a1-972ba5987ae5', '08c181bd-afa8-48ab-8522-ef22c89b3851', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '2222', null, null, null, null);

-- ----------------------------
-- Table structure for `e_shop_trade`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_trade`;
CREATE TABLE `e_shop_trade` (
  `uuid` varchar(36) NOT NULL,
  `shop_id` varchar(36) NOT NULL,
  `trade_id` varchar(36) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_trade
-- ----------------------------
INSERT INTO `e_shop_trade` VALUES ('01aad59b-df57-48f0-b54b-e481b83d4e15', 'c1b1adb2-8e39-4850-ad4a-edaf4bc4651d', '3');
INSERT INTO `e_shop_trade` VALUES ('b24b80c8-fb98-4339-bcf2-d5ad2f3f6d07', 'c1b1adb2-8e39-4850-ad4a-edaf4bc4651d', '1');
INSERT INTO `e_shop_trade` VALUES ('ca0b7729-038c-4ff9-84b9-743429964f64', '08c181bd-afa8-48ab-8522-ef22c89b3851', '1');

-- ----------------------------
-- Table structure for `e_trade`
-- ----------------------------
DROP TABLE IF EXISTS `e_trade`;
CREATE TABLE `e_trade` (
  `uuid` varchar(36) NOT NULL,
  `code` varchar(36) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `ord_index` int(1) DEFAULT NULL,
  `is_used` int(1) DEFAULT '1',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_trade
-- ----------------------------
INSERT INTO `e_trade` VALUES ('1', 'food', '美食', '1', '1');
INSERT INTO `e_trade` VALUES ('2', 'clothes', '服装', '2', '1');
INSERT INTO `e_trade` VALUES ('3', 'beauty', '美妆', '3', '1');
INSERT INTO `e_trade` VALUES ('40', 'baby', '母婴', '4', '1');
INSERT INTO `e_trade` VALUES ('41', 'computer', '电脑', '5', '1');
INSERT INTO `e_trade` VALUES ('42', 'book', '书城', '6', '1');

-- ----------------------------
-- Table structure for `e_user`
-- ----------------------------
DROP TABLE IF EXISTS `e_user`;
CREATE TABLE `e_user` (
  `uuid` varchar(36) NOT NULL,
  `name` varchar(64) NOT NULL,
  `pwd` varchar(64) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL COMMENT '用于区别商家与普通用户',
  `phone` int(11) DEFAULT NULL,
  `photo` varchar(64) DEFAULT NULL,
  `birthday` varchar(16) DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  `register_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_e_user_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_user
-- ----------------------------
INSERT INTO `e_user` VALUES ('43c72a72-ca25-4415-a5df-cff584fec842', '二二', '1111', null, '2', '', null, null, null, '1396573024125');
INSERT INTO `e_user` VALUES ('4eae0ad3-dfe1-40c9-8241-188885c86377', '依依', '1111', null, '1', '1_1396572944339.png', null, null, null, '1396572978531');
INSERT INTO `e_user` VALUES ('c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '李四', '1111', null, '4', '4_1396573057655.png', null, null, null, '1396573122453');
INSERT INTO `e_user` VALUES ('d3a5b588-3204-4e7f-8d73-20fdd0dbaf54', '张三', '1111', null, '3', '3_1396573019613.png', null, null, null, '1396573053250');
