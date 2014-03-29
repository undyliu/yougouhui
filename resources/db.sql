/*
 Navicat Premium Data Transfer

 Source Server         : localhost_root
 Source Server Type    : MySQL
 Source Server Version : 50612
 Source Host           : localhost
 Source Database       : ebs

 Target Server Type    : MySQL
 Target Server Version : 50612
 File Encoding         : utf-8

 Date: 03/29/2014 22:58:23 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `e_activity`
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
  `publisher` varchar(32) DEFAULT NULL,
  `publish_time` datetime DEFAULT NULL,
  `last_modifier` varchar(32) DEFAULT NULL,
  `last_modify_time` datetime DEFAULT NULL,
  `price` double(16,2) DEFAULT NULL,
  `discount` double(16,2) DEFAULT NULL,
  `visit_count` int(11) DEFAULT NULL,
  `discuss_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动记录表';

-- ----------------------------
--  Records of `e_activity`
-- ----------------------------
BEGIN;
INSERT INTO `e_activity` VALUES ('1', 'iOS 6.1', '<p>Apple released iOS 6.1</p><p class=\"ui-li-aside\">iOS</p>', 'apple.png', '1', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null), ('2', 'BlackBerry 10', '<p>BlackBerry launched the Z10 and Q10 with the new BB10 OS</p><p class=\"ui-li-aside\">BlackBerry</p>\n				<p class=\"ui-li-aside\">BlackBerry</p>', 'blackberry_10.png', '2', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null), ('3', 'WP 7.8', '<p>Nokia rolls out WP 7.8 to Lumia 800</p><p class=\"ui-li-aside\">Windows Phone</p>', 'lumia_800.png', '41', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null), ('4', 'Galaxy', '<p>New Samsung Galaxy Express</p><p class=\"ui-li-aside\">Samsung</p>', 'galaxy_express.png', '1', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null), ('5', 'Nexus 7', '<p>Rumours about new full HD Nexus 7</p><p class=\"ui-li-aside\">Android</p>', 'nexus_7.png', '1', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null), ('6', 'Firefox OS', '<p>ZTE to launch Firefox OS smartphone at MWC</p><p class=\"ui-li-aside\">Firefox</p>', 'firefox_os.png', '3', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null), ('7', 'Tizen', '<p>First Samsung phones with Tizen can be expected in 2013</p><p class=\"ui-li-aside\">Tizen</p>', 'tizen.png', '41', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null), ('8', 'Symbian', '<p>Nokia confirms the end of Symbian</p><p class=\"ui-li-aside\">Symbian</p>', null, '2', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null), ('9', 'Symbian', '<p>Nokia confirms the end of Symbian</p>', null, '42', null, null, null, null, null, null, null, null, '1000.00', '0.70', '200', null);
COMMIT;

-- ----------------------------
--  Table structure for `e_activity_img`
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
--  Table structure for `e_channel`
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
  `creator` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_modifier` varchar(32) DEFAULT NULL,
  `last_modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_channel_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目表';

-- ----------------------------
--  Records of `e_channel`
-- ----------------------------
BEGIN;
INSERT INTO `e_channel` VALUES ('0', 'all', '全部', '', null, '0', null, null, null, null, null), ('1', 'food', '美食', '', null, '1', null, null, null, null, null), ('2', 'clothes', '服装', '', null, '2', null, null, null, null, null), ('3', 'beauty', '美妆', '', null, '3', null, null, null, null, null), ('40', 'baby', '母婴', 'baby.html', null, '4', null, null, null, null, null), ('41', 'computer', '电脑', 'computer.html', null, '5', null, null, null, null, null), ('42', 'book', '书城', 'book.html', null, '6', null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `e_comment`
-- ----------------------------
DROP TABLE IF EXISTS `e_comment`;
CREATE TABLE `e_comment` (
  `uuid` varchar(36) NOT NULL,
  `share_id` varchar(36) DEFAULT NULL,
  `comment_id` varchar(36) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `publisher` varchar(32) DEFAULT NULL,
  `publish_time` varchar(16) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `e_comment`
-- ----------------------------
BEGIN;
INSERT INTO `e_comment` VALUES ('607f3094-0696-4260-9833-06ecea912bf1', '4bb8116f-38ab-46b4-9074-3cd57b0495e9', null, '222', '111111', '1396103895516', '0'), ('64de5bdb-7168-4aa1-8b79-1f03d3b58035', '9caab804-8de8-46ed-9fe8-ed6ba2c66cb0', null, '5555', '111111', '1396102487369', '1'), ('75dc21f2-b364-42a9-bcfe-fc5db657e064', '4bb8116f-38ab-46b4-9074-3cd57b0495e9', null, '333', '111111', '1396103921385', '1'), ('77161126-b199-4ca5-824d-b376968fcf59', '4bb8116f-38ab-46b4-9074-3cd57b0495e9', null, '666', '111111', '1396104918910', '0');
COMMIT;

-- ----------------------------
--  Table structure for `e_discuss`
-- ----------------------------
DROP TABLE IF EXISTS `e_discuss`;
CREATE TABLE `e_discuss` (
  `uuid` varchar(36) NOT NULL,
  `activity_id` varchar(36) DEFAULT NULL,
  `discuss_id` varchar(36) DEFAULT NULL COMMENT '用于点评的记录别人还可点评',
  `content` varchar(2000) DEFAULT NULL,
  `publisher` varchar(32) DEFAULT NULL,
  `publish_time` date DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `e_friend`
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
--  Table structure for `e_log`
-- ----------------------------
DROP TABLE IF EXISTS `e_log`;
CREATE TABLE `e_log` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `act_time` date DEFAULT NULL,
  `action` varchar(32) DEFAULT NULL,
  `act_cotent` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `e_module`
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
  `creator` varchar(32) DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  `last_modifier` varchar(32) DEFAULT NULL,
  `last_modify_time` date DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `U_discover_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `e_module`
-- ----------------------------
BEGIN;
INSERT INTO `e_module` VALUES ('101', 'friends', '朋友圈', 'img/friend.png', 'friends.html', null, '0', 'discover', null, null, null, null), ('102', 'radar', '雷达', 'img/radar.png', 'radar.html', null, '1', 'discover', null, null, null, null), ('103', 'recommend', '推荐', 'img/recommend.png', 'recommend.html', null, '2', 'discover', null, null, null, null), ('104', 'hot', '热门', 'img/hot.png', 'hot.html', null, '3', 'discover', null, null, null, null), ('105', 'compare', '比价', 'img/compare.png', null, null, '4', 'discover', null, null, null, null), ('106', 'join', '拼单', 'img/join.png', null, null, '5', 'discover', null, null, null, null), ('201', 'settings', '设置', 'img/settings.png', 'settings.html', null, '0', 'me', null, null, null, null), ('202', 'contact_list', '通讯录', 'img/add_friend.png', 'contact_list.html', null, '1', 'me', null, null, null, null), ('203', 'my_favorite', '我的收藏', 'img/favorite.png', 'my_favorite.html', null, '2', 'me', null, null, null, null), ('204', 'my_share', '我的分享', 'img/share.png', 'my_share.html', null, '3', 'me', null, null, null, null), ('205', 'my_shop', '我的店铺', 'img/my_shop.png', 'my_shop.html', null, '4', 'me', null, null, null, null), ('206', 'my_grade', '我的积分', 'img/my_grade.png', 'my_grade.html', null, '5', 'me', null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `e_share`
-- ----------------------------
DROP TABLE IF EXISTS `e_share`;
CREATE TABLE `e_share` (
  `uuid` varchar(36) NOT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `geo` varchar(128) DEFAULT NULL,
  `publisher` varchar(32) DEFAULT NULL,
  `publish_time` varchar(16) DEFAULT NULL,
  `activity_id` varchar(36) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `e_share`
-- ----------------------------
BEGIN;
INSERT INTO `e_share` VALUES ('4bb8116f-38ab-46b4-9074-3cd57b0495e9', 'demo1', null, null, '1396102581904', null, '0'), ('9caab804-8de8-46ed-9fe8-ed6ba2c66cb0', 'demo', null, null, '1396102136651', null, '1');
COMMIT;

-- ----------------------------
--  Table structure for `e_share_img`
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
--  Records of `e_share_img`
-- ----------------------------
BEGIN;
INSERT INTO `e_share_img` VALUES ('188c00c0-b77b-4431-aead-601261ad12f0', '1590624401_1396102577517.png', '4bb8116f-38ab-46b4-9074-3cd57b0495e9', '1');
COMMIT;

-- ----------------------------
--  Table structure for `e_shop`
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
  `owner` varchar(32) DEFAULT NULL,
  `creator` varchar(32) DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  `last_modifier` varchar(32) DEFAULT NULL,
  `last_modify_time` date DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `e_shop_emp`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_emp`;
CREATE TABLE `e_shop_emp` (
  `uuid` varchar(36) NOT NULL,
  `shop_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `creator` varchar(32) DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  `last_modifier` varchar(32) DEFAULT NULL,
  `last_modify_time` date DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `e_user`
-- ----------------------------
DROP TABLE IF EXISTS `e_user`;
CREATE TABLE `e_user` (
  `uuid` varchar(36) NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `pwd` varchar(64) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL COMMENT '用于区别商家与普通用户',
  `phone` int(11) DEFAULT NULL,
  `photo` varchar(64) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `last_modifier` varchar(32) DEFAULT NULL,
  `last_modify_time` date DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `e_user`
-- ----------------------------
BEGIN;
INSERT INTO `e_user` VALUES ('1', 'liuxy', '刘小勇', null, null, '111111', null, null, null, null);
COMMIT;

