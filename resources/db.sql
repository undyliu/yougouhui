/*
Navicat MySQL Data Transfer

Source Server         : localhost_ebs
Source Server Version : 50511
Source Host           : localhost:3306
Source Database       : ebs

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2014-04-14 17:22:34
*/

SET FOREIGN_KEY_CHECKS=0;
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
INSERT INTO `e_friend` VALUES ('e3c6e7f3-be50-494d-8a85-c27f6dc0373b', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '4eae0ad3-dfe1-40c9-8241-188885c86377', '0');
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
-- Table structure for `e_mapping_ct`
-- ----------------------------
DROP TABLE IF EXISTS `e_mapping_ct`;
CREATE TABLE `e_mapping_ct` (
  `uuid` varchar(36) NOT NULL DEFAULT '',
  `channel_id` varchar(36) NOT NULL,
  `trade_id` varchar(36) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_mapping_ct
-- ----------------------------
INSERT INTO `e_mapping_ct` VALUES ('1', '1', '1');
INSERT INTO `e_mapping_ct` VALUES ('2', '2', '2');
INSERT INTO `e_mapping_ct` VALUES ('3', '3', '3');
INSERT INTO `e_mapping_ct` VALUES ('40', '40', '40');
INSERT INTO `e_mapping_ct` VALUES ('41', '41', '41');
INSERT INTO `e_mapping_ct` VALUES ('42', '42', '42');

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
-- Table structure for `e_sale`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale`;
CREATE TABLE `e_sale` (
  `uuid` varchar(36) NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `start_date` varchar(16) DEFAULT NULL,
  `end_date` varchar(16) DEFAULT NULL,
  `shop_id` varchar(36) DEFAULT NULL,
  `trade_id` varchar(36) DEFAULT NULL,
  `img` varchar(128) DEFAULT NULL,
  `geo` varchar(128) DEFAULT NULL,
  `publisher` varchar(36) DEFAULT NULL,
  `publish_time` varchar(16) DEFAULT NULL,
  `publish_date` varchar(10) DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` datetime DEFAULT NULL,
  `price` double(16,2) DEFAULT '0.00',
  `discount` double(16,2) DEFAULT '0.00',
  `visit_count` int(11) DEFAULT '0',
  `discuss_count` int(11) DEFAULT '0',
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='活动记录表';

-- ----------------------------
-- Records of e_sale
-- ----------------------------
INSERT INTO `e_sale` VALUES ('790526d0-c979-4184-b33a-ba7b219d9580', '测试一些', '测试测试测试测试测试测试测试', '1397318400000', '1399910400000', '08c181bd-afa8-48ab-8522-ef22c89b3851', '41', '-354365311_1397390299564.png', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1397390300684', '2014-04-13', null, null, '0.00', '0.00', '0', '0', '0');
INSERT INTO `e_sale` VALUES ('c6d00203-5cec-437a-95fe-13ba8fcee037', '麦当劳优惠大酬宾', '午餐套餐一律25元', '1397404800000', '1397491200000', 'a1c99058-8244-48b6-8caf-5740111a36eb', '1', '1309850451_1397464111438.png', null, '4eae0ad3-dfe1-40c9-8241-188885c86377', '1397464111359', '2014-04-14', null, null, '0.00', '0.00', '0', '0', '0');
INSERT INTO `e_sale` VALUES ('d4202f4d-6134-4a77-a326-dce4451fbf98', '优惠券', '下载优惠券', '1397404800000', '1399996800000', '08c181bd-afa8-48ab-8522-ef22c89b3851', '41', '-1179112262_1397439937696.png', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1397439946671', '2014-04-14', null, null, '0.00', '0.00', '0', '0', '0');
INSERT INTO `e_sale` VALUES ('e739c0f7-a930-4207-8fec-298531cc6e89', '挥泪大甩卖', '全场一折优惠，仅限一个月', '1397404800000', '1399996800000', '08c181bd-afa8-48ab-8522-ef22c89b3851', '41', '602324364_1397439408476.png', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1397439417953', '2014-04-14', null, null, '0.00', '0.00', '0', '0', '0');
INSERT INTO `e_sale` VALUES ('fe9df9f2-4a39-4b18-8cbb-49da53b7b5ed', '雀巢咖啡打折', '卡布奇诺，摩卡一折大酬宾', '1397404800000', '1405440000000', '08c181bd-afa8-48ab-8522-ef22c89b3851', '41', '463517179_1397445849613.png', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1397445855375', '2014-04-14', null, null, '0.00', '0.00', '0', '0', '0');

-- ----------------------------
-- Table structure for `e_sale_discuss`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale_discuss`;
CREATE TABLE `e_sale_discuss` (
  `uuid` varchar(36) NOT NULL,
  `sale_id` varchar(36) DEFAULT NULL,
  `discuss_id` varchar(36) DEFAULT NULL COMMENT '用于点评的记录别人还可点评',
  `content` varchar(2000) DEFAULT NULL,
  `publisher` varchar(36) DEFAULT NULL,
  `publish_time` date DEFAULT NULL,
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_sale_discuss
-- ----------------------------

-- ----------------------------
-- Table structure for `e_sale_img`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale_img`;
CREATE TABLE `e_sale_img` (
  `uuid` varchar(36) NOT NULL,
  `img` varchar(128) DEFAULT NULL,
  `sale_id` varchar(36) NOT NULL,
  `ord_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of e_sale_img
-- ----------------------------
INSERT INTO `e_sale_img` VALUES ('2d1d6a8b-d761-46f7-b136-64dbbe5d25b0', '463517179_1397445849613.png', 'fe9df9f2-4a39-4b18-8cbb-49da53b7b5ed', '0');
INSERT INTO `e_sale_img` VALUES ('94033b9a-8ff2-47d0-8a70-e52866423057', '-1179112262_1397439937696.png', 'd4202f4d-6134-4a77-a326-dce4451fbf98', '0');
INSERT INTO `e_sale_img` VALUES ('94a335c2-490c-499a-92df-c035c7a006df', '1309850451_1397464111438.png', 'c6d00203-5cec-437a-95fe-13ba8fcee037', '0');
INSERT INTO `e_sale_img` VALUES ('ae8ed5a0-433d-4999-88f6-970b5b5e2692', '-354365311_1397390299564.png', '790526d0-c979-4184-b33a-ba7b219d9580', '0');
INSERT INTO `e_sale_img` VALUES ('cb0c1cd0-c451-474c-916b-9599a8917ef0', '602324364_1397439408476.png', 'e739c0f7-a930-4207-8fec-298531cc6e89', '0');
INSERT INTO `e_sale_img` VALUES ('fdd82109-d541-47cd-b24b-2ced86d6d33a', '2080523912_1397445849632.png', 'fe9df9f2-4a39-4b18-8cbb-49da53b7b5ed', '1');

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
  `shop_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share
-- ----------------------------
INSERT INTO `e_share` VALUES ('11e4c01a-2155-4822-bec5-3d83d55481a4', '圣诞节购物季', null, '43c72a72-ca25-4415-a5df-cff584fec842', '1396583054328', '2014-04-04', null, '0', null);
INSERT INTO `e_share` VALUES ('1a78b60a-dcad-4a45-b83f-822fc8e4f89d', '永旺的探路者打折很厉害', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1396583684640', '2014-04-04', null, '0', null);
INSERT INTO `e_share` VALUES ('959d02d3-e470-46a7-b8d5-cf44db3db482', '测试一下选择商铺', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1397178333937', '2014-04-11', null, '0', '08c181bd-afa8-48ab-8522-ef22c89b3851');
INSERT INTO `e_share` VALUES ('97dd86ad-f227-44f1-8791-73860dc9dfd4', '新辣道鱼火锅', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1396573458937', '2014-04-04', null, '0', null);

-- ----------------------------
-- Table structure for `e_share_comment`
-- ----------------------------
DROP TABLE IF EXISTS `e_share_comment`;
CREATE TABLE `e_share_comment` (
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
-- Records of e_share_comment
-- ----------------------------
INSERT INTO `e_share_comment` VALUES ('5d812a9a-ead1-49d4-9ca5-a4f4ae92e662', '11e4c01a-2155-4822-bec5-3d83d55481a4', null, '非常不错', '4eae0ad3-dfe1-40c9-8241-188885c86377', '1396583178296', '0');
INSERT INTO `e_share_comment` VALUES ('a399f33d-0178-4c69-92e2-e0b5b5925071', '11e4c01a-2155-4822-bec5-3d83d55481a4', null, '看起来很好', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1396583740343', '0');

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
INSERT INTO `e_shop` VALUES ('08c181bd-afa8-48ab-8522-ef22c89b3851', '上地华联一品香美食', null, '-703256829_1397006580733.png', null, '5555555', '看看666666', '-1400089674_1396933730140.png', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', null, null, null, null, '1396933731990', '1', 'barcode_2116703421_1397044192126.png');
INSERT INTO `e_shop` VALUES ('4e04cab4-e348-4fa4-9ca2-daec8cd55df6', '嘻嘻嘻', null, '969508071_1397182104998.png', null, '将计就计', '嘎嘎嘎嘎', '1309850451_1397182104999.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397182144375', '0', 'barcode_-2146544333_1397182145390.png');
INSERT INTO `e_shop` VALUES ('6b5fe500-ad3d-4321-b09f-b3f92b9854cc', '上地华联肯德基店', null, '1309850451_1397182856916.png', null, '哈哈哈哈', '哈哈哈哈哈哈哈', '969508071_1397182856919.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397182900812', '1', 'barcode_796720174_1397182901828.png');
INSERT INTO `e_shop` VALUES ('7d2798a5-d4a5-48d4-a835-9a409cd4e6bc', '333', null, '-1400089674_1397184200448.png', null, '3333', '33333', '-1044649450_1397184200452.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397184250015', '0', 'barcode_1848413068_1397184250265.png');
INSERT INTO `e_shop` VALUES ('8ab89cd5-a801-44fe-b299-b26010df1758', '嘎嘎嘎嘎', null, '969508071_1397181625641.png', null, '哈哈哈哈', '嘎嘎嘎嘎好好干给', '-418737538_1397181625644.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397181659718', '0', 'barcode_-249760923_1397181659843.png');
INSERT INTO `e_shop` VALUES ('9a9d820f-25e2-432e-9ee2-ff3b95871fca', '222', null, '-354365311_1397183615538.png', null, '2222', '2222', '-432990804_1397183615543.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397183661468', '0', 'barcode_-418861175_1397183661656.png');
INSERT INTO `e_shop` VALUES ('a1c99058-8244-48b6-8caf-5740111a36eb', '麦当劳上地店', null, '-1215697993_1397123329558.png', null, '666', '7788', '-1044649450_1397123329561.png', null, '4eae0ad3-dfe1-40c9-8241-188885c86377', null, null, null, null, '1397123363984', '1', 'barcode_55164796_1397123364250.png');
INSERT INTO `e_shop` VALUES ('a982f53e-6115-4da0-bae3-c26e3e424780', '1111', null, '-432990804_1397182361624.png', null, '1111', '1111', '-354365311_1397182361627.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397182403140', '0', 'barcode_291911631_1397182403500.png');
INSERT INTO `e_shop` VALUES ('af157fd4-37ae-4e23-85f3-3daf9ff0f988', '没喝过非常好', null, '-354365311_1397180667524.png', null, '好好干给', '火锅费发广告', '-432990804_1397180667528.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397180916484', '0', 'barcode_358126184_1397180916750.png');
INSERT INTO `e_shop` VALUES ('b45b241d-9c61-480a-9da1-f305ef9ece1c', '1111', null, '-432990804_1397182361624.png', null, '1111', '1111', '-354365311_1397182361627.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397182403171', '0', 'barcode_1138345116_1397182403546.png');
INSERT INTO `e_shop` VALUES ('c1b1adb2-8e39-4850-ad4a-edaf4bc4651d', '昌平永旺商场探路者专卖店', null, '-1303150572_1397036911977.png', null, '广告个22233', '干活奋斗史55', '463517179_1396871363810.png', null, 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', null, null, null, null, '1396871367348', '0', 'barcode_-1053622591_1397185849484.png');
INSERT INTO `e_shop` VALUES ('c8f3d706-afa8-4610-a084-f710c04178d4', '快快快', null, '1309850451_1397181836648.png', null, '流量了', '呵呵呵', '969508071_1397181836651.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397181872578', '0', 'barcode_1130252256_1397181872781.png');
INSERT INTO `e_shop` VALUES ('cbdae0c5-0c82-43bf-bc95-8cf8a8c3af26', '测试商铺', null, '1309850451_1397180485818.png', null, '烦烦烦', '将计就计', '-104682932_1397180485818.png', null, 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', null, null, null, null, '1397180510281', '0', 'barcode_-1012574465_1397180510640.png');

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
INSERT INTO `e_shop_emp` VALUES ('0d643c36-d375-45f9-a8e4-51e41271db7e', '08c181bd-afa8-48ab-8522-ef22c89b3851', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '2222', null, null, null, null);
INSERT INTO `e_shop_emp` VALUES ('12222222222212121212', 'a1c99058-8244-48b6-8caf-5740111a36eb', '4eae0ad3-dfe1-40c9-8241-188885c86377', '1111', null, null, null, null);
INSERT INTO `e_shop_emp` VALUES ('4243804b-6544-482a-84e0-1ce87130098c', '6b5fe500-ad3d-4321-b09f-b3f92b9854cc', 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', '2222', null, null, null, null);
INSERT INTO `e_shop_emp` VALUES ('5bb94c4a-e542-4f45-95d6-b057c1513e1b', 'c1b1adb2-8e39-4850-ad4a-edaf4bc4651d', 'c589a525-c3b6-4a22-9086-d9f1a2cdd5f5', '1111', null, null, null, null);
INSERT INTO `e_shop_emp` VALUES ('b4f6de6f-c252-40ed-bd42-a0c2c92fee57', '7d2798a5-d4a5-48d4-a835-9a409cd4e6bc', 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', '2222', null, null, null, null);
INSERT INTO `e_shop_emp` VALUES ('cdbcd7ac-c8ba-4848-8619-f33340bf4a7c', '08c181bd-afa8-48ab-8522-ef22c89b3851', '4eae0ad3-dfe1-40c9-8241-188885c86377', '1111', null, null, null, null);
INSERT INTO `e_shop_emp` VALUES ('d3ae0d20-1c0d-4a88-8c14-29b2cd58028c', '9a9d820f-25e2-432e-9ee2-ff3b95871fca', 'd3a5b588-3204-4e7f-8d73-20fdd0dbaf54', '2222', null, null, null, null);

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
INSERT INTO `e_shop_trade` VALUES ('1371f2b1-7576-44d6-8a78-faec4147194b', 'c1b1adb2-8e39-4850-ad4a-edaf4bc4651d', '2');
INSERT INTO `e_shop_trade` VALUES ('1c4dfab0-9a00-4168-81f2-d4f6e34000fe', '6b5fe500-ad3d-4321-b09f-b3f92b9854cc', '1');
INSERT INTO `e_shop_trade` VALUES ('1d80df38-7965-45d7-9e2a-56e0ccc7404c', 'c8f3d706-afa8-4610-a084-f710c04178d4', '1');
INSERT INTO `e_shop_trade` VALUES ('4036ec44-84e2-4041-a17c-bd8e2abe9bec', '4e04cab4-e348-4fa4-9ca2-daec8cd55df6', '41');
INSERT INTO `e_shop_trade` VALUES ('591157a6-e09d-4a46-adfa-8bab7726739e', '08c181bd-afa8-48ab-8522-ef22c89b3851', '41');
INSERT INTO `e_shop_trade` VALUES ('5fabeab4-6f83-41a8-8f00-64f708cb319b', 'a982f53e-6115-4da0-bae3-c26e3e424780', '1');
INSERT INTO `e_shop_trade` VALUES ('6056f514-5501-4eae-8f91-7da7fbf43b0a', '8ab89cd5-a801-44fe-b299-b26010df1758', '41');
INSERT INTO `e_shop_trade` VALUES ('826e76af-9dcf-486c-8597-911705d9c426', 'b45b241d-9c61-480a-9da1-f305ef9ece1c', '1');
INSERT INTO `e_shop_trade` VALUES ('83ebb706-06ab-4123-b01f-40fc7027a5ba', 'af157fd4-37ae-4e23-85f3-3daf9ff0f988', '40');
INSERT INTO `e_shop_trade` VALUES ('8a4ea2ee-3b84-4532-b382-77c27a9c7606', '7d2798a5-d4a5-48d4-a835-9a409cd4e6bc', '40');
INSERT INTO `e_shop_trade` VALUES ('bae2c8ef-6b7f-4ea1-803b-f3f95de81aa7', '9a9d820f-25e2-432e-9ee2-ff3b95871fca', '41');
INSERT INTO `e_shop_trade` VALUES ('e99807fd-7dbf-42ad-822e-2ece636b0e98', 'cbdae0c5-0c82-43bf-bc95-8cf8a8c3af26', '42');
INSERT INTO `e_shop_trade` VALUES ('ff5c0ad3-57aa-4063-97bc-965e46cd84b5', 'a1c99058-8244-48b6-8caf-5740111a36eb', '1');

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
