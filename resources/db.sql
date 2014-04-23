/*
Navicat MySQL Data Transfer

Source Server         : localhost_ebs
Source Server Version : 50511
Source Host           : localhost:3306
Source Database       : ebs

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2014-04-23 17:10:58
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
  `is_deleted` int(1) DEFAULT '0',
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_friend
-- ----------------------------
INSERT INTO `e_friend` VALUES ('2be6e5c9-ea0c-48fa-ae8c-c625e3a81743', '95982f2a-df27-42a2-bfeb-98332233d498', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '0', null);
INSERT INTO `e_friend` VALUES ('3fa09213-0dda-4e75-928c-8c834147ace4', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '95982f2a-df27-42a2-bfeb-98332233d498', '0', '1398157830593');
INSERT INTO `e_friend` VALUES ('ea676d36-dbd9-459e-a83a-ca93873b845f', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '7248db2e-c8d2-4d26-8047-79c8082fb80f', '1', null);

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
INSERT INTO `e_sale` VALUES ('f1385b00-92b7-413b-98d6-61e3fd471a05', '五月优惠大酬宾', '五月每周二中午套餐一律25元，不限量。', '1398873653248', '1401465602048', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1', '-1400089674_1397637457444.png', '95982f2a-df27-42a2-bfeb-98332233d498', '1397637513216', '2014-04-16', '1398224659166', '128', '-1', '2');

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
INSERT INTO `e_sale_discuss` VALUES ('3ff0d72d-4e3e-41e2-9e17-f5fd04d9a758', 'f1385b00-92b7-413b-98d6-61e3fd471a05', null, '囧囧囧j', '95982f2a-df27-42a2-bfeb-98332233d498', '1398153726703', '1', '1398158559281');
INSERT INTO `e_sale_discuss` VALUES ('5fdb9837-3b73-4cf8-b326-c091e6c9c343', 'f1385b00-92b7-413b-98d6-61e3fd471a05', null, '确实很优惠', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398137068593', '0', '1398137068593');
INSERT INTO `e_sale_discuss` VALUES ('6c2e8533-edfd-4f20-bd37-38e863d17952', 'f1385b00-92b7-413b-98d6-61e3fd471a05', null, '囧囧囧j', '95982f2a-df27-42a2-bfeb-98332233d498', '1398153726156', '1', '1398153738453');
INSERT INTO `e_sale_discuss` VALUES ('87a42703-645b-4697-bdae-3306b3d8c938', 'f1385b00-92b7-413b-98d6-61e3fd471a05', null, '感谢惠顾', '95982f2a-df27-42a2-bfeb-98332233d498', '1398143643281', '1', '1398158693515');
INSERT INTO `e_sale_discuss` VALUES ('94d8074a-4501-4d3f-b6f1-f23ee9a7645c', 'f1385b00-92b7-413b-98d6-61e3fd471a05', null, '擦擦擦擦', '95982f2a-df27-42a2-bfeb-98332233d498', '1398153711656', '1', '1398158600656');

-- ----------------------------
-- Table structure for `e_sale_favorit`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale_favorit`;
CREATE TABLE `e_sale_favorit` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `sale_id` varchar(36) NOT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_sale_favorit
-- ----------------------------
INSERT INTO `e_sale_favorit` VALUES ('79550ba8-ba56-4442-88d2-a327f59b55d5', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398143915984', '0');

-- ----------------------------
-- Table structure for `e_sale_img`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale_img`;
CREATE TABLE `e_sale_img` (
  `uuid` varchar(36) NOT NULL,
  `img` varchar(128) DEFAULT NULL,
  `sale_id` varchar(36) NOT NULL,
  `ord_index` int(11) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of e_sale_img
-- ----------------------------
INSERT INTO `e_sale_img` VALUES ('116c18d0-86a5-46aa-89b2-38efb18306bb', '-1400089674_1397637457444.png', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '0', null);
INSERT INTO `e_sale_img` VALUES ('3fd02fb7-12d8-4872-b9e5-b270ffc2e0b6', '2105981903_1397637457446.png', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1', null);

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
INSERT INTO `e_sale_visit` VALUES ('00e85aa3-302d-4aaa-b4c4-8e27c04a2268', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398156280515');
INSERT INTO `e_sale_visit` VALUES ('058fa94c-b3c8-4cf3-9999-433f4c9da4fc', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398151624765');
INSERT INTO `e_sale_visit` VALUES ('05bc8f0f-8154-4d23-a75e-33eaa5289735', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397960342436');
INSERT INTO `e_sale_visit` VALUES ('09830bc3-a792-41de-8a1c-495a771bc277', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216');
INSERT INTO `e_sale_visit` VALUES ('0a411f98-052e-4bfa-9bbe-b0dc770d82d2', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398150956296');
INSERT INTO `e_sale_visit` VALUES ('0b0ab314-ca20-4cdc-b082-08adb97406a5', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803687421');
INSERT INTO `e_sale_visit` VALUES ('0d1e189c-f5fb-49b3-9ed8-d3a11b5e0806', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398143255906');
INSERT INTO `e_sale_visit` VALUES ('0d980d58-46bc-43e7-b8bc-4922b8c7f7ce', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146284765');
INSERT INTO `e_sale_visit` VALUES ('0e53e34d-4144-40a6-8145-46c32e138ccb', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803834781');
INSERT INTO `e_sale_visit` VALUES ('1400d1be-03b7-4e10-9567-7160fbc9f3bc', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398153779421');
INSERT INTO `e_sale_visit` VALUES ('198a570a-e979-4f90-9437-9fa93d6f2205', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398152599125');
INSERT INTO `e_sale_visit` VALUES ('1a2a7813-3bf9-4e03-93b3-f40f4ca6b9c5', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914673751');
INSERT INTO `e_sale_visit` VALUES ('1a3e9e05-7587-410d-a545-2091cfc4ca67', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919626630');
INSERT INTO `e_sale_visit` VALUES ('1e08a3f8-9765-42ea-ad23-471c1ae360ab', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398143623250');
INSERT INTO `e_sale_visit` VALUES ('205fcb8e-7445-45e9-a4d5-3a78a791e5eb', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398151853484');
INSERT INTO `e_sale_visit` VALUES ('266d1a44-3efc-45eb-97d5-0fd552d4fb30', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398129584843');
INSERT INTO `e_sale_visit` VALUES ('2b2459d5-8e6b-4262-b98e-c3da61f7b196', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398142878312');
INSERT INTO `e_sale_visit` VALUES ('2c03740f-b219-4051-a5d8-a18ca6f979fb', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147383');
INSERT INTO `e_sale_visit` VALUES ('300a617c-e59c-473b-9798-da53c647f401', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398144108906');
INSERT INTO `e_sale_visit` VALUES ('30a4cdbb-672c-4ea9-a7c9-768566338012', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919551675');
INSERT INTO `e_sale_visit` VALUES ('30feaa5d-557f-4e78-868a-6a9f31b1ec26', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398151247218');
INSERT INTO `e_sale_visit` VALUES ('31993eab-c47b-4316-ab45-f1fcaccaac6b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398151903671');
INSERT INTO `e_sale_visit` VALUES ('335516c6-d098-4d70-83f8-d4e8d2cb0f9d', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398149126187');
INSERT INTO `e_sale_visit` VALUES ('38878855-b488-4662-9d4a-3f859c5c06fe', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397913430824');
INSERT INTO `e_sale_visit` VALUES ('38e46934-4529-4f7e-9baa-e80fa944da2f', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398150516046');
INSERT INTO `e_sale_visit` VALUES ('3ca5bdc7-4f98-454f-9ac8-90cd41e40cdf', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398139471140');
INSERT INTO `e_sale_visit` VALUES ('3d0128a5-f883-4f5c-b460-fd9124b4a317', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397918882287');
INSERT INTO `e_sale_visit` VALUES ('3f765d3b-cf90-4dde-897a-97bdacfa8041', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398129630593');
INSERT INTO `e_sale_visit` VALUES ('40d88f0f-89d3-46b4-ada3-9d2368c493a8', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397639741440');
INSERT INTO `e_sale_visit` VALUES ('48ab9a09-6041-4d8a-9866-d1c0074af774', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398136167031');
INSERT INTO `e_sale_visit` VALUES ('49b4ee9d-d83c-4700-a7d0-c65472b1e4e3', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398143543765');
INSERT INTO `e_sale_visit` VALUES ('4ad79b85-57df-4252-85e8-70490c9c1a16', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398156263125');
INSERT INTO `e_sale_visit` VALUES ('4bb01768-f5f4-4a93-b15f-2767e4138a37', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398136986421');
INSERT INTO `e_sale_visit` VALUES ('4c1913ea-0d2c-4a7d-a7a6-5467342dcfff', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147334171');
INSERT INTO `e_sale_visit` VALUES ('4d20e39f-5571-44d9-ad5f-2afe5c427cef', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398158738328');
INSERT INTO `e_sale_visit` VALUES ('4d6e2c0e-907e-44eb-9c5a-876680c1deb9', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398153746640');
INSERT INTO `e_sale_visit` VALUES ('507d2263-ed8b-431f-94ca-ab787f195166', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147391');
INSERT INTO `e_sale_visit` VALUES ('62174ae5-2190-4cc0-b4b4-484a5a1c45e2', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398215555338');
INSERT INTO `e_sale_visit` VALUES ('644d9e4a-38ca-48fb-9a60-70792ce7a111', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803287796');
INSERT INTO `e_sale_visit` VALUES ('649804b6-bd76-4bae-92b3-70812b5a9a28', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147801703');
INSERT INTO `e_sale_visit` VALUES ('64ecb654-e0c7-453d-bcea-a95aca0d824d', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146431500');
INSERT INTO `e_sale_visit` VALUES ('654ffb41-dd83-4d4f-9d6a-c6e2606e03dd', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147377');
INSERT INTO `e_sale_visit` VALUES ('65f8aa4e-db15-4c2b-bd56-937463edd579', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397896611601');
INSERT INTO `e_sale_visit` VALUES ('6a6db16c-0339-4e21-882e-49115ca77a1b', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397639741440');
INSERT INTO `e_sale_visit` VALUES ('6a882337-6dff-42d7-b2b8-c472a091f04d', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398139367156');
INSERT INTO `e_sale_visit` VALUES ('6cdeb9d7-1d68-43a2-a735-fb9c157a405b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398143494109');
INSERT INTO `e_sale_visit` VALUES ('7279330a-8175-4035-a196-6239c85ff5bc', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398148332921');
INSERT INTO `e_sale_visit` VALUES ('76bccbbe-61db-4836-8f89-e6f705052c70', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216');
INSERT INTO `e_sale_visit` VALUES ('78210731-3519-4893-af84-152036fba8d1', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147789718');
INSERT INTO `e_sale_visit` VALUES ('7bd41c7e-004a-44d5-a336-9b1652c0b3f6', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146049000');
INSERT INTO `e_sale_visit` VALUES ('7d679a81-9db6-43df-a6d7-065df1f80aba', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147344');
INSERT INTO `e_sale_visit` VALUES ('7e641d13-5c22-4e1b-b196-a38acb89df86', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794341906');
INSERT INTO `e_sale_visit` VALUES ('7e8c11c3-e8a3-44dd-996b-f2fdaded20e8', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147795328');
INSERT INTO `e_sale_visit` VALUES ('7f50f834-26c6-47f5-a0b6-3e18dc75288b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398158400921');
INSERT INTO `e_sale_visit` VALUES ('7f8c4c92-b985-4752-bb2a-35d90d762e47', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794387578');
INSERT INTO `e_sale_visit` VALUES ('812b4326-d9b0-4cc7-9253-efc9afd011f0', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397700689920');
INSERT INTO `e_sale_visit` VALUES ('8460f605-e1f2-41d8-bbd8-735cab39816b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398136737828');
INSERT INTO `e_sale_visit` VALUES ('85c882d5-cca3-4f5c-a05b-918720f9513b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398139620468');
INSERT INTO `e_sale_visit` VALUES ('86604c29-6b6d-4afa-a227-0589294e15a4', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398150041937');
INSERT INTO `e_sale_visit` VALUES ('87165ab6-f174-4d30-adda-82e2e1af4f46', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397912606478');
INSERT INTO `e_sale_visit` VALUES ('88e9fe79-6a0a-4527-9591-6bd6d208c0d5', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398153693171');
INSERT INTO `e_sale_visit` VALUES ('89c0e683-0ad3-4457-b987-55bae14926bd', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398158760718');
INSERT INTO `e_sale_visit` VALUES ('8b6777a2-679f-4a2c-b301-35d7d37ecdb6', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147915265');
INSERT INTO `e_sale_visit` VALUES ('8c59b296-0ad7-4a03-8c09-7cb34285fbf4', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397960318827');
INSERT INTO `e_sale_visit` VALUES ('8fe639f3-a53f-44f6-8254-2cbea21dbf8e', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794102640');
INSERT INTO `e_sale_visit` VALUES ('90ed72be-3b98-4596-9cb6-df60bf7ea948', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146143984');
INSERT INTO `e_sale_visit` VALUES ('9160ded0-2e76-4d4a-a39c-cf990c76f507', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147438484');
INSERT INTO `e_sale_visit` VALUES ('9213dccb-32e3-4b6f-a59f-de18ff95815d', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398152570156');
INSERT INTO `e_sale_visit` VALUES ('926e5d55-9eda-4814-9006-c8f9ac3491ec', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398149355125');
INSERT INTO `e_sale_visit` VALUES ('9338d3eb-cd84-4f49-8b43-c0493001f7ee', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146119046');
INSERT INTO `e_sale_visit` VALUES ('95972f14-c1d6-4584-b471-bc2ff2048033', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397897252503');
INSERT INTO `e_sale_visit` VALUES ('95af2d80-7076-4c24-8729-0ddf4689402a', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398150781500');
INSERT INTO `e_sale_visit` VALUES ('96cf9617-c929-4b8a-b685-234fb8629a19', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147451593');
INSERT INTO `e_sale_visit` VALUES ('9ab9e6cb-cc9e-4f16-b8f0-f20da5682666', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919429100');
INSERT INTO `e_sale_visit` VALUES ('9c2f4d60-dabf-4c2d-be35-c778ae6b02cf', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397913855065');
INSERT INTO `e_sale_visit` VALUES ('9fbf05db-fefd-4479-aa1f-069d169b5450', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398137226671');
INSERT INTO `e_sale_visit` VALUES ('9ff01e68-e912-43eb-836d-db927e805b54', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397995352507');
INSERT INTO `e_sale_visit` VALUES ('9ff1ff7d-040f-41b4-8f69-a21420c2c069', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397896551797');
INSERT INTO `e_sale_visit` VALUES ('a1223073-a5a3-4a8c-b0fe-ec4307bc3db2', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398224659166');
INSERT INTO `e_sale_visit` VALUES ('a50c97ac-97dc-427e-a4a2-c2372f9ea63c', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398137575234');
INSERT INTO `e_sale_visit` VALUES ('a5ca8f3a-0559-4a65-b154-937ade77b29b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919636151');
INSERT INTO `e_sale_visit` VALUES ('a66e83fb-23f4-4a7f-9eec-743c2fc6e682', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146611703');
INSERT INTO `e_sale_visit` VALUES ('a705bf60-d0fb-4394-8634-c6b501ac1ed3', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398149303328');
INSERT INTO `e_sale_visit` VALUES ('b02cc941-8727-4893-89e4-399c2ad94ed8', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398150691515');
INSERT INTO `e_sale_visit` VALUES ('b3707c80-14c7-44a7-8f32-618229feea8e', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147036484');
INSERT INTO `e_sale_visit` VALUES ('b4367258-3732-4216-b85c-b0e9dc8be1e7', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397638430720');
INSERT INTO `e_sale_visit` VALUES ('b68fc370-7a8c-4f44-a8ab-564ceacf49f8', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398150490421');
INSERT INTO `e_sale_visit` VALUES ('b7dbb0e7-7386-4638-9cae-90b07c970240', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147237312');
INSERT INTO `e_sale_visit` VALUES ('b8c29ba0-39b0-4f57-859d-f48c2dcc1683', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397912721591');
INSERT INTO `e_sale_visit` VALUES ('b8cee9c4-dfd7-48cf-9137-9e8ee28ebdd2', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398151216890');
INSERT INTO `e_sale_visit` VALUES ('bb9a751d-046f-46b7-9297-377493cc7f62', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397638299648');
INSERT INTO `e_sale_visit` VALUES ('c3416770-23bb-4eaa-8040-9144b0a5bd00', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398129507312');
INSERT INTO `e_sale_visit` VALUES ('c49164bc-6aca-49e3-9cbc-10944917cad1', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397918387298');
INSERT INTO `e_sale_visit` VALUES ('c5030227-1886-4a74-a86b-efb0d0b9f4de', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794291484');
INSERT INTO `e_sale_visit` VALUES ('c79d7a4f-4584-4266-9e6d-4ae1b1139b75', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397702092906');
INSERT INTO `e_sale_visit` VALUES ('c907428d-a7d7-4eab-9ad1-978416f20acb', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398156157265');
INSERT INTO `e_sale_visit` VALUES ('caf82252-50a7-4048-bb9f-275d9dbc390f', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397918315070');
INSERT INTO `e_sale_visit` VALUES ('ce4600b6-02ff-42d3-898f-074203690e4d', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147457671');
INSERT INTO `e_sale_visit` VALUES ('cfd66d89-3819-4477-a883-139b1351e0c4', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398150049046');
INSERT INTO `e_sale_visit` VALUES ('d22b59a5-fd9e-4976-a2f5-f62c648037eb', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397913348244');
INSERT INTO `e_sale_visit` VALUES ('d66d22af-51d3-447a-b6a5-4fcbc672a878', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637644288');
INSERT INTO `e_sale_visit` VALUES ('d709761f-f2b1-45a6-8001-6dc3381930dc', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398150205750');
INSERT INTO `e_sale_visit` VALUES ('d7e389a0-5514-4a4e-84a8-6a00401026c7', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398144808781');
INSERT INTO `e_sale_visit` VALUES ('d9116341-fc92-4cab-a1be-d41560734671', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637644288');
INSERT INTO `e_sale_visit` VALUES ('da990b23-aa7f-4f4a-a79c-54d658093961', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397995305600');
INSERT INTO `e_sale_visit` VALUES ('dd20ddf9-b0cc-4e5d-991b-e08f12647b3c', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637906432');
INSERT INTO `e_sale_visit` VALUES ('de33b525-259c-48a7-a3a5-b5a66a84cb22', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919458902');
INSERT INTO `e_sale_visit` VALUES ('def0b0bb-9966-41d6-847b-5b649de0ff0e', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398149598812');
INSERT INTO `e_sale_visit` VALUES ('df30fda8-d9cb-4314-9764-f14b2464dc02', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637775360');
INSERT INTO `e_sale_visit` VALUES ('e12d1001-3c86-441f-af57-0cbd6cc3015b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397713270015');
INSERT INTO `e_sale_visit` VALUES ('e1f5566f-df97-4cad-bb94-52dc3d4e81df', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398143834875');
INSERT INTO `e_sale_visit` VALUES ('e306811a-f3b8-4f53-b830-8fd27624fa38', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397960220912');
INSERT INTO `e_sale_visit` VALUES ('e48a2c8d-c3fb-49c3-bd89-42d7b46d04a4', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398136872078');
INSERT INTO `e_sale_visit` VALUES ('e553b558-c760-4950-bbf1-dd2a78b3bf0c', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398143934437');
INSERT INTO `e_sale_visit` VALUES ('e5bfbb3d-fc64-4fe2-9ae0-9279b6eb7d60', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398136469312');
INSERT INTO `e_sale_visit` VALUES ('e60a921d-9c9d-4261-90e4-77ce8386745a', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398139564781');
INSERT INTO `e_sale_visit` VALUES ('e6e1b35d-b4b1-4f87-bd24-65711a49cfb4', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398091385452');
INSERT INTO `e_sale_visit` VALUES ('e7666d2f-9acd-4d44-a058-0d33eadf55fe', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216');
INSERT INTO `e_sale_visit` VALUES ('e8e59d2c-4851-4d3c-a316-8b91ce2b27a7', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794083718');
INSERT INTO `e_sale_visit` VALUES ('e91b7a3a-3a2e-4660-b21f-07e785e2a6ca', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398149442796');
INSERT INTO `e_sale_visit` VALUES ('e99b11ce-b129-4f7e-93d2-7142ccdfd3e0', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803448500');
INSERT INTO `e_sale_visit` VALUES ('ec36c239-a751-4d4c-89d5-c273b9f61565', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147830203');
INSERT INTO `e_sale_visit` VALUES ('ec37a631-b0ae-4b2e-9909-94c91b59694d', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146020093');
INSERT INTO `e_sale_visit` VALUES ('efc34fb3-a228-4a69-b478-1658738f039c', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794130875');
INSERT INTO `e_sale_visit` VALUES ('f200e292-bbe5-4c56-b847-6e64539e9e31', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146082281');
INSERT INTO `e_sale_visit` VALUES ('f4863785-20b5-450e-9d39-365b684d5f4c', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398146191312');
INSERT INTO `e_sale_visit` VALUES ('f6a3c62f-7543-43fc-bf09-4f9625093f63', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397804610718');
INSERT INTO `e_sale_visit` VALUES ('f89d19a7-f96a-47dd-9a29-9c220b8dbd8e', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398147962046');
INSERT INTO `e_sale_visit` VALUES ('fa92d223-a434-41c8-84e1-e76990488df0', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397896523746');
INSERT INTO `e_sale_visit` VALUES ('fe1bc33d-023e-4857-82f1-84dcce252ed9', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398151146468');
INSERT INTO `e_sale_visit` VALUES ('fed0a023-2f09-4a95-9d36-3ad6ab5d0361', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397786241625');
INSERT INTO `e_sale_visit` VALUES ('ffbc18db-1597-44d9-b33b-d3c81483a04c', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147391');

-- ----------------------------
-- Table structure for `e_setting`
-- ----------------------------
DROP TABLE IF EXISTS `e_setting`;
CREATE TABLE `e_setting` (
  `uuid` varchar(36) NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(128) NOT NULL,
  `ord_index` int(11) NOT NULL DEFAULT '0',
  `img` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_setting
-- ----------------------------
INSERT INTO `e_setting` VALUES ('1', 'login', '登录设置', '0', null);
INSERT INTO `e_setting` VALUES ('2', 'cache', '缓存', '1', null);
INSERT INTO `e_setting` VALUES ('3', 'radar', '雷达配置', '2', null);
INSERT INTO `e_setting` VALUES ('9999', 'logout', '退出', '9999', null);

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
INSERT INTO `e_share` VALUES ('3a84d1ce-36c3-4de6-9cf5-9e0d0b441eb8', '优惠幅度很大，下次再来', '7248db2e-c8d2-4d26-8047-79c8082fb80f', '1398224761416', '2014-04-23', null, '0', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1398244122666');
INSERT INTO `e_share` VALUES ('47e07784-7b25-414b-8261-f61d21f960c6', '11111', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398088689727', '2014-04-21', null, '1', '', '1398088987349');
INSERT INTO `e_share` VALUES ('77e75293-dcef-417e-a5b4-f917a93e15be', '上地肯德基的优惠真给力', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1397636464640', '2014-04-16', null, '1', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1398082411528');
INSERT INTO `e_share` VALUES ('ab6f6874-88f1-4015-8eed-8c8f24937d56', '88888', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398089176683', '2014-04-21', null, '0', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1398158349375');
INSERT INTO `e_share` VALUES ('b664f078-e33e-4421-80bd-2e00824fd524', '2222', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398088789310', '2014-04-21', null, '0', '', '1398089130609');

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
INSERT INTO `e_share_comment` VALUES ('7a8742d7-2c97-4be0-90e5-070ea8930a5c', '3a84d1ce-36c3-4de6-9cf5-9e0d0b441eb8', null, '自评下', '7248db2e-c8d2-4d26-8047-79c8082fb80f', '1398244122666', '0', '1398244122666');
INSERT INTO `e_share_comment` VALUES ('9ed6efa6-ee75-4ca6-aae0-b08d76706391', 'ab6f6874-88f1-4015-8eed-8c8f24937d56', null, '呵呵', '95982f2a-df27-42a2-bfeb-98332233d498', '1398158349375', '0', '1398158349375');
INSERT INTO `e_share_comment` VALUES ('eabe1e04-ca4f-486b-9df2-cc7281df076e', 'b664f078-e33e-4421-80bd-2e00824fd524', null, '66666', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398089112075', '1', '1398089130605');

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
INSERT INTO `e_share_img` VALUES ('05159152-962e-4935-b180-8f916da8679c', '1259860143_1398224729380.png', '3a84d1ce-36c3-4de6-9cf5-9e0d0b441eb8', '2', '1398224761541');
INSERT INTO `e_share_img` VALUES ('49a17f10-7973-4d2b-84db-5757e34ff0c2', '-703256829_1398224716598.png', '3a84d1ce-36c3-4de6-9cf5-9e0d0b441eb8', '1', '1398224761479');
INSERT INTO `e_share_img` VALUES ('53eca583-869a-42f7-b25c-c1ffc7255123', '1309850451_1398088778771.png', 'b664f078-e33e-4421-80bd-2e00824fd524', '1', '1398088789314');
INSERT INTO `e_share_img` VALUES ('83b61b99-8bc7-480d-ae91-a50deca7a4e9', '463517179_1398088785990.png', 'b664f078-e33e-4421-80bd-2e00824fd524', '2', '1398088789738');

-- ----------------------------
-- Table structure for `e_share_shop_reply`
-- ----------------------------
DROP TABLE IF EXISTS `e_share_shop_reply`;
CREATE TABLE `e_share_shop_reply` (
  `uuid` varchar(36) NOT NULL DEFAULT '',
  `share_id` varchar(36) NOT NULL,
  `shop_id` varchar(36) NOT NULL,
  `replier` varchar(36) DEFAULT NULL,
  `reply_time` varchar(16) DEFAULT NULL,
  `grade` int(11) DEFAULT '0',
  `content` varchar(2000) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share_shop_reply
-- ----------------------------
INSERT INTO `e_share_shop_reply` VALUES ('2fb9c01b-0cd4-427b-ba92-e2258a761e0d', '3a84d1ce-36c3-4de6-9cf5-9e0d0b441eb8', 'a7b21d66-5681-421d-96c4-6c560471eee8', '95982f2a-df27-42a2-bfeb-98332233d498', '1398240209119', '10', '欢迎选购', '0');

-- ----------------------------
-- Table structure for `e_shop`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop`;
CREATE TABLE `e_shop` (
  `uuid` varchar(36) NOT NULL,
  `name` varchar(64) NOT NULL,
  `trademark` varchar(128) DEFAULT NULL,
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
INSERT INTO `e_shop` VALUES ('a7b21d66-5681-421d-96c4-6c560471eee8', '肯德基上地店', null, '1309850451_1397631831384.png', '{\"address\":\"北京市海淀区北清路68号\",\"lontitude\":116.242521,\"radius\":20.5,\"latitude\":40.073394}', '北京市海淀区北清路68号', '肯德基大品牌', '-1044649450_1397631831387.png', null, '95982f2a-df27-42a2-bfeb-98332233d498', null, '1397631877120', '1', 'barcode_-1053186559_1397631834031.png');

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
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_favorit
-- ----------------------------
INSERT INTO `e_shop_favorit` VALUES ('136bba39-3725-44cb-8d40-45ffc499231f', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1397637775360', '0');
INSERT INTO `e_shop_favorit` VALUES ('21eb5bf4-5821-4f03-9c10-76f846829a7a', '95982f2a-df27-42a2-bfeb-98332233d498', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1397803300781', '0');

-- ----------------------------
-- Table structure for `e_shop_trade`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_trade`;
CREATE TABLE `e_shop_trade` (
  `uuid` varchar(36) NOT NULL,
  `shop_id` varchar(36) NOT NULL,
  `trade_id` varchar(36) NOT NULL,
  `last_modify_time` varchar(16) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_trade
-- ----------------------------
INSERT INTO `e_shop_trade` VALUES ('c7cbdc71-e8ce-4dc6-86f6-ed4281165470', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1', '');

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
INSERT INTO `e_user` VALUES ('2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '李四', '4444', null, '4', '4_1397634425877.png', null, null, null, '1397634498560');
INSERT INTO `e_user` VALUES ('7248db2e-c8d2-4d26-8047-79c8082fb80f', '张三', '3333', null, '3', '3_1397638131573.png', null, null, null, '1397638168576');
INSERT INTO `e_user` VALUES ('95982f2a-df27-42a2-bfeb-98332233d498', 'i依依', '1111', null, '1', '1_1397631232100.png', null, null, null, '1397631221760');
