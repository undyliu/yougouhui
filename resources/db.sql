/*
Navicat MySQL Data Transfer

Source Server         : localhost_ebs
Source Server Version : 50511
Source Host           : localhost:3306
Source Database       : ebs

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2014-04-21 17:13:09
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
  `is_used` varchar(1) DEFAULT '1',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_channel_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目表';

-- ----------------------------
-- Records of e_channel
-- ----------------------------
INSERT INTO `e_channel` VALUES ('0', 'all', '全部', '', null, '0', null, '1');
INSERT INTO `e_channel` VALUES ('1', 'food', '美食', '', null, '1', null, '1');
INSERT INTO `e_channel` VALUES ('2', 'clothes', '服装', '', null, '2', null, '1');
INSERT INTO `e_channel` VALUES ('3', 'beauty', '美妆', '', null, '3', null, '1');
INSERT INTO `e_channel` VALUES ('40', 'baby', '母婴', 'baby.html', null, '4', null, '1');
INSERT INTO `e_channel` VALUES ('41', 'computer', '电脑', 'computer.html', null, '5', null, '1');
INSERT INTO `e_channel` VALUES ('42', 'book', '书城', 'book.html', null, '6', null, '1');

-- ----------------------------
-- Table structure for `e_friend`
-- ----------------------------
DROP TABLE IF EXISTS `e_friend`;
CREATE TABLE `e_friend` (
  `uuid` varchar(36) NOT NULL,
  `friend_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_friend
-- ----------------------------
INSERT INTO `e_friend` VALUES ('2be6e5c9-ea0c-48fa-ae8c-c625e3a81743', '95982f2a-df27-42a2-bfeb-98332233d498', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', null);
INSERT INTO `e_friend` VALUES ('ea676d36-dbd9-459e-a83a-ca93873b845f', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '7248db2e-c8d2-4d26-8047-79c8082fb80f', null);
INSERT INTO `e_friend` VALUES ('f0dfaea8-bb03-40be-b2b5-70f9800f6f9c', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '95982f2a-df27-42a2-bfeb-98332233d498', null);

-- ----------------------------
-- Table structure for `e_log`
-- ----------------------------
DROP TABLE IF EXISTS `e_log`;
CREATE TABLE `e_log` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `act_time` varchar(16) DEFAULT NULL,
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
  PRIMARY KEY (`uuid`),
  KEY `U_discover_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_module
-- ----------------------------
INSERT INTO `e_module` VALUES ('101', 'friends', '朋友圈', 'img/friend.png', 'friends.html', null, '0', 'discover', '1');
INSERT INTO `e_module` VALUES ('102', 'radar', '雷达', 'img/radar.png', 'radar.html', null, '1', 'discover', '1');
INSERT INTO `e_module` VALUES ('103', 'recommend', '推荐', 'img/recommend.png', 'recommend.html', null, '2', 'discover', '1');
INSERT INTO `e_module` VALUES ('104', 'hot', '热门', 'img/hot.png', 'hot.html', null, '3', 'discover', '1');
INSERT INTO `e_module` VALUES ('105', 'compare', '比价', 'img/compare.png', null, null, '4', 'discover', '1');
INSERT INTO `e_module` VALUES ('106', 'join', '拼单', 'img/join.png', null, null, '5', 'discover', '1');
INSERT INTO `e_module` VALUES ('201', 'settings', '设置', 'img/settings.png', 'settings.html', null, '0', 'me', '1');
INSERT INTO `e_module` VALUES ('202', 'contact_list', '通讯录', 'img/add_friend.png', 'contact_list.html', null, '1', 'me', '1');
INSERT INTO `e_module` VALUES ('203', 'my_favorite', '我的收藏', 'img/favorite.png', 'my_favorite.html', null, '2', 'me', '1');
INSERT INTO `e_module` VALUES ('204', 'my_share', '我的分享', 'img/share.png', 'my_share.html', null, '3', 'me', '1');
INSERT INTO `e_module` VALUES ('205', 'my_shop', '我的店铺', 'img/my_shop.png', 'my_shop.html', null, '4', 'me', '1');
INSERT INTO `e_module` VALUES ('206', 'my_grade', '我的积分', 'img/my_grade.png', 'my_grade.html', null, '5', 'me', '1');

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
  `publisher` varchar(36) DEFAULT NULL,
  `publish_time` varchar(16) DEFAULT NULL,
  `publish_date` varchar(10) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  `visit_count` int(11) DEFAULT '0',
  `discuss_count` int(11) DEFAULT '0',
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='活动记录表';

-- ----------------------------
-- Records of e_sale
-- ----------------------------
INSERT INTO `e_sale` VALUES ('f1385b00-92b7-413b-98d6-61e3fd471a05', '五月优惠大酬宾', '五月每周二中午套餐一律25元，不限量。', '1398873653248', '1401465602048', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1', '-1400089674_1397637457444.png', '95982f2a-df27-42a2-bfeb-98332233d498', '1397637513216', '2014-04-16', null, '51', '1', '2');

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
  `publish_time` varchar(16) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT '0',
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_sale_discuss
-- ----------------------------
INSERT INTO `e_sale_discuss` VALUES ('5fdb9837-3b73-4cf8-b326-c091e6c9c343', 'f1385b00-92b7-413b-98d6-61e3fd471a05', null, '确实很优惠', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1397803734500', '0', null);

-- ----------------------------
-- Table structure for `e_sale_favorit`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale_favorit`;
CREATE TABLE `e_sale_favorit` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `sale_id` varchar(36) NOT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_sale_favorit
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
INSERT INTO `e_sale_img` VALUES ('116c18d0-86a5-46aa-89b2-38efb18306bb', '-1400089674_1397637457444.png', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '0');
INSERT INTO `e_sale_img` VALUES ('3fd02fb7-12d8-4872-b9e5-b270ffc2e0b6', '2105981903_1397637457446.png', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1');

-- ----------------------------
-- Table structure for `e_sale_visit`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale_visit`;
CREATE TABLE `e_sale_visit` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `sale_id` varchar(36) NOT NULL,
  `visit_time` varchar(16) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_sale_visit
-- ----------------------------
INSERT INTO `e_sale_visit` VALUES ('0020c574-f8ae-4e40-a441-cd154505f998', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397807848281');
INSERT INTO `e_sale_visit` VALUES ('09830bc3-a792-41de-8a1c-495a771bc277', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216');
INSERT INTO `e_sale_visit` VALUES ('0b0ab314-ca20-4cdc-b082-08adb97406a5', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803687421');
INSERT INTO `e_sale_visit` VALUES ('0e53e34d-4144-40a6-8145-46c32e138ccb', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803834781');
INSERT INTO `e_sale_visit` VALUES ('12ada400-9efd-4c76-aaa4-2f881a646439', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398047010687');
INSERT INTO `e_sale_visit` VALUES ('171ce07d-bf5e-4d3a-9fcd-20d1e46d9253', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398048385937');
INSERT INTO `e_sale_visit` VALUES ('28ef6229-6846-4162-a335-723ef6d2f742', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398052164359');
INSERT INTO `e_sale_visit` VALUES ('2df12d8c-96ca-4c17-8054-c2a9aadcab7a', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398048756312');
INSERT INTO `e_sale_visit` VALUES ('337abdf1-9c2c-414d-bd29-5001eb3c60a5', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397808059031');
INSERT INTO `e_sale_visit` VALUES ('3953680f-1ddf-4c8a-a8a2-f1d48a19f96f', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398053296703');
INSERT INTO `e_sale_visit` VALUES ('3f069b2d-b878-4d69-a3ba-499ebcaad7dc', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398052194046');
INSERT INTO `e_sale_visit` VALUES ('40d88f0f-89d3-46b4-ada3-9d2368c493a8', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397639741440');
INSERT INTO `e_sale_visit` VALUES ('45e6f453-e299-4154-b648-8161d28c2894', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398052251750');
INSERT INTO `e_sale_visit` VALUES ('4661736a-ae74-4149-a09e-9c1192992570', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398045839109');
INSERT INTO `e_sale_visit` VALUES ('644d9e4a-38ca-48fb-9a60-70792ce7a111', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803287796');
INSERT INTO `e_sale_visit` VALUES ('6a6db16c-0339-4e21-882e-49115ca77a1b', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397639741440');
INSERT INTO `e_sale_visit` VALUES ('76bccbbe-61db-4836-8f89-e6f705052c70', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216');
INSERT INTO `e_sale_visit` VALUES ('7e641d13-5c22-4e1b-b196-a38acb89df86', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794341906');
INSERT INTO `e_sale_visit` VALUES ('7ededeea-0be0-48a6-a952-93dd01df9859', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398040631390');
INSERT INTO `e_sale_visit` VALUES ('7f8c4c92-b985-4752-bb2a-35d90d762e47', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794387578');
INSERT INTO `e_sale_visit` VALUES ('812b4326-d9b0-4cc7-9253-efc9afd011f0', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397700689920');
INSERT INTO `e_sale_visit` VALUES ('8c1b0e76-c9e5-4b5d-805d-f4083d8e6a9e', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398040429468');
INSERT INTO `e_sale_visit` VALUES ('8fe639f3-a53f-44f6-8254-2cbea21dbf8e', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794102640');
INSERT INTO `e_sale_visit` VALUES ('93b4159f-8227-47e3-b8e4-0ab2724e8656', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398053290171');
INSERT INTO `e_sale_visit` VALUES ('9fb3558d-09c3-461f-ad7b-a6ee5421bdd8', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398052010062');
INSERT INTO `e_sale_visit` VALUES ('b4367258-3732-4216-b85c-b0e9dc8be1e7', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397638430720');
INSERT INTO `e_sale_visit` VALUES ('b7d93504-8449-4b91-b821-a376a04000b7', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397807235187');
INSERT INTO `e_sale_visit` VALUES ('bb3dc0f2-5ccd-4a0a-99f8-201d3fa8ad21', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398048932453');
INSERT INTO `e_sale_visit` VALUES ('bb9a751d-046f-46b7-9297-377493cc7f62', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397638299648');
INSERT INTO `e_sale_visit` VALUES ('c5030227-1886-4a74-a86b-efb0d0b9f4de', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794291484');
INSERT INTO `e_sale_visit` VALUES ('c79d7a4f-4584-4266-9e6d-4ae1b1139b75', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397702092906');
INSERT INTO `e_sale_visit` VALUES ('ca411942-9f27-4186-83d4-8129888a29e6', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398048628968');
INSERT INTO `e_sale_visit` VALUES ('cbe38d86-71d0-484d-8952-ec3511617129', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398050042625');
INSERT INTO `e_sale_visit` VALUES ('d3de4216-cceb-42f8-a940-8e262edcf235', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398050666703');
INSERT INTO `e_sale_visit` VALUES ('d56b4e30-165c-4c8a-a383-692339858de1', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398052216968');
INSERT INTO `e_sale_visit` VALUES ('d66d22af-51d3-447a-b6a5-4fcbc672a878', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637644288');
INSERT INTO `e_sale_visit` VALUES ('d675ecc9-5171-4e4c-9840-f715057cf6da', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398052465828');
INSERT INTO `e_sale_visit` VALUES ('d8583795-78be-4383-ac0e-7170aadce628', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398052295890');
INSERT INTO `e_sale_visit` VALUES ('d9116341-fc92-4cab-a1be-d41560734671', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637644288');
INSERT INTO `e_sale_visit` VALUES ('dd20ddf9-b0cc-4e5d-991b-e08f12647b3c', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637906432');
INSERT INTO `e_sale_visit` VALUES ('dddba367-98ad-4082-ade1-644aaa80919b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398050579171');
INSERT INTO `e_sale_visit` VALUES ('df30fda8-d9cb-4314-9764-f14b2464dc02', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637775360');
INSERT INTO `e_sale_visit` VALUES ('e12d1001-3c86-441f-af57-0cbd6cc3015b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397713270015');
INSERT INTO `e_sale_visit` VALUES ('e7666d2f-9acd-4d44-a058-0d33eadf55fe', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216');
INSERT INTO `e_sale_visit` VALUES ('e8e59d2c-4851-4d3c-a316-8b91ce2b27a7', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794083718');
INSERT INTO `e_sale_visit` VALUES ('e99b11ce-b129-4f7e-93d2-7142ccdfd3e0', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803448500');
INSERT INTO `e_sale_visit` VALUES ('ee3fe798-8d8b-4185-b3af-8508e74d98b9', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398048173218');
INSERT INTO `e_sale_visit` VALUES ('efc34fb3-a228-4a69-b478-1658738f039c', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794130875');
INSERT INTO `e_sale_visit` VALUES ('f508c063-9220-4609-8135-67418d109c9e', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398050615265');
INSERT INTO `e_sale_visit` VALUES ('f6a3c62f-7543-43fc-bf09-4f9625093f63', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397804610718');
INSERT INTO `e_sale_visit` VALUES ('fed0a023-2f09-4a95-9d36-3ad6ab5d0361', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397786241625');

-- ----------------------------
-- Table structure for `e_setting`
-- ----------------------------
DROP TABLE IF EXISTS `e_setting`;
CREATE TABLE `e_setting` (
  `uuid` varchar(36) NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(128) NOT NULL,
  `img` varchar(128) DEFAULT NULL,
  `ord_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_setting
-- ----------------------------
INSERT INTO `e_setting` VALUES ('1', 'login', '登录设置', null, '0');
INSERT INTO `e_setting` VALUES ('2', 'cache', '缓存', null, '1');
INSERT INTO `e_setting` VALUES ('3', 'radar', '雷达配置', null, '2');

-- ----------------------------
-- Table structure for `e_share`
-- ----------------------------
DROP TABLE IF EXISTS `e_share`;
CREATE TABLE `e_share` (
  `uuid` varchar(36) NOT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `publisher` varchar(36) DEFAULT NULL,
  `publish_time` varchar(16) DEFAULT NULL,
  `publish_date` varchar(10) DEFAULT NULL,
  `sale_id` varchar(36) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  `shop_id` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share
-- ----------------------------
INSERT INTO `e_share` VALUES ('77e75293-dcef-417e-a5b4-f917a93e15be', '上地肯德基的优惠真给力', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1397636464640', '2014-04-16', null, '0', 'a7b21d66-5681-421d-96c4-6c560471eee8', null);

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
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `e_share_img`
-- ----------------------------
DROP TABLE IF EXISTS `e_share_img`;
CREATE TABLE `e_share_img` (
  `uuid` varchar(36) NOT NULL,
  `img` varchar(128) DEFAULT NULL,
  `share_id` varchar(36) NOT NULL,
  `ord_index` int(11) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share_img
-- ----------------------------
INSERT INTO `e_share_img` VALUES ('b7a5bbce-420f-4d9a-a3f1-2b94f8a71402', '463517179_1397636423064.png', '77e75293-dcef-417e-a5b4-f917a93e15be', '1', null);
INSERT INTO `e_share_img` VALUES ('ed8c9154-04cd-4096-9a9f-fed6f7419408', '-2142473940_1397636423066.png', '77e75293-dcef-417e-a5b4-f917a93e15be', '2', null);

-- ----------------------------
-- Table structure for `e_share_shop_reply`
-- ----------------------------
DROP TABLE IF EXISTS `e_share_shop_reply`;
CREATE TABLE `e_share_shop_reply` (
  `uuid` varchar(36) NOT NULL DEFAULT '',
  `share_id` varchar(36) NOT NULL,
  `shop_id` varchar(0) NOT NULL,
  `grader` varchar(36) DEFAULT NULL,
  `grade_time` varchar(16) DEFAULT NULL,
  `grade` int(11) DEFAULT '0',
  `content` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share_shop_reply
-- ----------------------------

-- ----------------------------
-- Table structure for `e_shop`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop`;
CREATE TABLE `e_shop` (
  `uuid` varchar(36) NOT NULL,
  `name` varchar(64) NOT NULL,
  `shop_img` varchar(128) DEFAULT NULL,
  `location` varchar(2000) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `busi_license` varchar(128) DEFAULT NULL,
  `credit_rank` int(11) DEFAULT NULL,
  `owner` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  `register_time` varchar(16) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '0:注册未审核，1:已审核，2:已注销',
  `barcode` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop
-- ----------------------------
INSERT INTO `e_shop` VALUES ('a7b21d66-5681-421d-96c4-6c560471eee8', '肯德基上地店', '1309850451_1397631831384.png', '{\"address\":\"北京市海淀区北清路68号\",\"lontitude\":116.242521,\"radius\":20.5,\"latitude\":40.073394}', '北京市海淀区北清路68号', '肯德基大品牌', '-1044649450_1397631831387.png', null, '95982f2a-df27-42a2-bfeb-98332233d498', null, '1397631877120', '1', 'barcode_-1053186559_1397631834031.png');

-- ----------------------------
-- Table structure for `e_shop_emp`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_emp`;
CREATE TABLE `e_shop_emp` (
  `uuid` varchar(36) NOT NULL,
  `shop_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `pwd` varchar(36) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_emp
-- ----------------------------
INSERT INTO `e_shop_emp` VALUES ('bc579f27-5d16-4ce7-9965-33e72028765a', 'a7b21d66-5681-421d-96c4-6c560471eee8', '95982f2a-df27-42a2-bfeb-98332233d498', '11111', null);

-- ----------------------------
-- Table structure for `e_shop_favorit`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_favorit`;
CREATE TABLE `e_shop_favorit` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `shop_id` varchar(36) NOT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_favorit
-- ----------------------------
INSERT INTO `e_shop_favorit` VALUES ('136bba39-3725-44cb-8d40-45ffc499231f', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1397637775360');
INSERT INTO `e_shop_favorit` VALUES ('21eb5bf4-5821-4f03-9c10-76f846829a7a', '95982f2a-df27-42a2-bfeb-98332233d498', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1397803300781');

-- ----------------------------
-- Table structure for `e_shop_trade`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_trade`;
CREATE TABLE `e_shop_trade` (
  `uuid` varchar(36) NOT NULL,
  `shop_id` varchar(36) NOT NULL,
  `trade_id` varchar(36) NOT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_trade
-- ----------------------------
INSERT INTO `e_shop_trade` VALUES ('c7cbdc71-e8ce-4dc6-86f6-ed4281165470', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1', null);

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
  `last_modify_time` varchar(16) DEFAULT NULL,
  `register_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_e_user_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_user
-- ----------------------------
INSERT INTO `e_user` VALUES ('2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '李四', '4444', null, '4', '4_1397634425877.png', null, null, '1397634498560');
INSERT INTO `e_user` VALUES ('7248db2e-c8d2-4d26-8047-79c8082fb80f', '张三', '3333', null, '3', '3_1397638131573.png', null, null, '1397638168576');
INSERT INTO `e_user` VALUES ('95982f2a-df27-42a2-bfeb-98332233d498', '依依', '1111', null, '1', '1_1397631232100.png', null, null, '1397631221760');
