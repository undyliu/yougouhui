/*
Navicat MySQL Data Transfer

Source Server         : 10.10.65.86_ebs
Source Server Version : 50511
Source Host           : 10.10.65.86:3306
Source Database       : ebs

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2014-04-01 17:41:26
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
INSERT INTO `e_comment` VALUES ('0348646d-e7cd-4561-8ac9-2eeec8f46af4', 'feba087b-3243-4161-ba4a-db048737c6fb', null, '点点滴滴d', '57e17c48-1504-4e93-8bd7-cc08024a27f4', '1396345032562', '0');

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
  `user_code` varchar(32) NOT NULL,
  `friend_id` varchar(36) NOT NULL,
  `friend_code` varchar(32) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_friend
-- ----------------------------

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
INSERT INTO `e_share` VALUES ('1db537d1-924a-45bd-8ccc-5a383b584502', 'fenxiang', null, 'd92395a8-0f51-49ed-b473-5274cdcf183e', '1396335236218', '2014-04-01', null, '0');
INSERT INTO `e_share` VALUES ('6132cf8a-8717-4500-aac8-ff91fe853bbd', '测试一下', null, '57e17c48-1504-4e93-8bd7-cc08024a27f4', '1396324575500', '2014-04-01', null, '0');
INSERT INTO `e_share` VALUES ('a55c4209-202e-4a12-9d65-98b1bd346d23', '测试测试', null, '57e17c48-1504-4e93-8bd7-cc08024a27f4', '1396337331765', '2014-04-01', null, '0');
INSERT INTO `e_share` VALUES ('b8bdf374-c9d7-4ade-abe0-52768d783e4c', '分享一下', null, '57e17c48-1504-4e93-8bd7-cc08024a27f4', '1396337136406', '2014-04-01', null, '0');
INSERT INTO `e_share` VALUES ('feba087b-3243-4161-ba4a-db048737c6fb', '圣诞节快乐', null, '57e17c48-1504-4e93-8bd7-cc08024a27f4', '1396340884875', '2014-04-01', null, '0');

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
INSERT INTO `e_share_img` VALUES ('468e76fe-f7ae-4189-8e49-c65ca36cc070', '1031961510_1396340837965.png', 'feba087b-3243-4161-ba4a-db048737c6fb', '1');

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
  `credit_rank` int(11) DEFAULT NULL,
  `owner` varchar(36) DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `create_time` varchar(16) DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop
-- ----------------------------

-- ----------------------------
-- Table structure for `e_shop_emp`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_emp`;
CREATE TABLE `e_shop_emp` (
  `uuid` varchar(36) NOT NULL,
  `shop_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `create_time` varchar(16) DEFAULT NULL,
  `last_modifier` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_emp
-- ----------------------------

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
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_user
-- ----------------------------
INSERT INTO `e_user` VALUES ('1', '刘小勇', null, null, '111111', null, null, null, null);
INSERT INTO `e_user` VALUES ('57e17c48-1504-4e93-8bd7-cc08024a27f4', '张三', '11111', null, '3', '3_1396345047823.png', null, null, null);
INSERT INTO `e_user` VALUES ('d92395a8-0f51-49ed-b473-5274cdcf183e', '李四', '1111', null, '2', '2_1396314090641.png', null, null, null);
