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

 Date: 04/21/2014 22:43:47 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

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
  `is_used` varchar(1) DEFAULT '1',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_channel_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目表';

-- ----------------------------
--  Records of `e_channel`
-- ----------------------------
BEGIN;
INSERT INTO `e_channel` VALUES ('0', 'all', '全部', '', null, '0', null, '1'), ('1', 'food', '美食', '', null, '1', null, '1'), ('2', 'clothes', '服装', '', null, '2', null, '1'), ('3', 'beauty', '美妆', '', null, '3', null, '1'), ('40', 'baby', '母婴', 'baby.html', null, '4', null, '1'), ('41', 'computer', '电脑', 'computer.html', null, '5', null, '1'), ('42', 'book', '书城', 'book.html', null, '6', null, '1');
COMMIT;

-- ----------------------------
--  Table structure for `e_friend`
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
--  Records of `e_friend`
-- ----------------------------
BEGIN;
INSERT INTO `e_friend` VALUES ('2be6e5c9-ea0c-48fa-ae8c-c625e3a81743', '95982f2a-df27-42a2-bfeb-98332233d498', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '0', null), ('98fb5d0c-fb82-4f29-86c5-fa4371cda01d', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '95982f2a-df27-42a2-bfeb-98332233d498', '0', '1398089617528'), ('ea676d36-dbd9-459e-a83a-ca93873b845f', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '7248db2e-c8d2-4d26-8047-79c8082fb80f', '1', null), ('f0dfaea8-bb03-40be-b2b5-70f9800f6f9c', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '95982f2a-df27-42a2-bfeb-98332233d498', '0', null);
COMMIT;

-- ----------------------------
--  Table structure for `e_log`
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
--  Table structure for `e_mapping_ct`
-- ----------------------------
DROP TABLE IF EXISTS `e_mapping_ct`;
CREATE TABLE `e_mapping_ct` (
  `uuid` varchar(36) NOT NULL DEFAULT '',
  `channel_id` varchar(36) NOT NULL,
  `trade_id` varchar(36) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `e_mapping_ct`
-- ----------------------------
BEGIN;
INSERT INTO `e_mapping_ct` VALUES ('1', '1', '1'), ('2', '2', '2'), ('3', '3', '3'), ('40', '40', '40'), ('41', '41', '41'), ('42', '42', '42');
COMMIT;

-- ----------------------------
--  Table structure for `e_message`
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
  `is_used` int(1) DEFAULT '1',
  PRIMARY KEY (`uuid`),
  KEY `U_discover_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `e_module`
-- ----------------------------
BEGIN;
INSERT INTO `e_module` VALUES ('101', 'friends', '朋友圈', 'img/friend.png', 'friends.html', null, '0', 'discover', '1'), ('102', 'radar', '雷达', 'img/radar.png', 'radar.html', null, '1', 'discover', '1'), ('103', 'recommend', '推荐', 'img/recommend.png', 'recommend.html', null, '2', 'discover', '1'), ('104', 'hot', '热门', 'img/hot.png', 'hot.html', null, '3', 'discover', '1'), ('105', 'compare', '比价', 'img/compare.png', null, null, '4', 'discover', '1'), ('106', 'join', '拼单', 'img/join.png', null, null, '5', 'discover', '1'), ('201', 'settings', '设置', 'img/settings.png', 'settings.html', null, '0', 'me', '1'), ('202', 'contact_list', '通讯录', 'img/add_friend.png', 'contact_list.html', null, '1', 'me', '1'), ('203', 'my_favorite', '我的收藏', 'img/favorite.png', 'my_favorite.html', null, '2', 'me', '1'), ('204', 'my_share', '我的分享', 'img/share.png', 'my_share.html', null, '3', 'me', '1'), ('205', 'my_shop', '我的店铺', 'img/my_shop.png', 'my_shop.html', null, '4', 'me', '1'), ('206', 'my_grade', '我的积分', 'img/my_grade.png', 'my_grade.html', null, '5', 'me', '1');
COMMIT;

-- ----------------------------
--  Table structure for `e_sale`
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
--  Records of `e_sale`
-- ----------------------------
BEGIN;
INSERT INTO `e_sale` VALUES ('f1385b00-92b7-413b-98d6-61e3fd471a05', '五月优惠大酬宾', '五月每周二中午套餐一律25元，不限量。', '1398873653248', '1401465602048', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1', '-1400089674_1397637457444.png', '95982f2a-df27-42a2-bfeb-98332233d498', '1397637513216', '2014-04-16', '1398091385452', '51', '1', '0');
COMMIT;

-- ----------------------------
--  Table structure for `e_sale_discuss`
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
--  Records of `e_sale_discuss`
-- ----------------------------
BEGIN;
INSERT INTO `e_sale_discuss` VALUES ('5fdb9837-3b73-4cf8-b326-c091e6c9c343', 'f1385b00-92b7-413b-98d6-61e3fd471a05', null, '确实很优惠', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1397803734500', '0', null);
COMMIT;

-- ----------------------------
--  Table structure for `e_sale_favorit`
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
--  Table structure for `e_sale_img`
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
--  Records of `e_sale_img`
-- ----------------------------
BEGIN;
INSERT INTO `e_sale_img` VALUES ('116c18d0-86a5-46aa-89b2-38efb18306bb', '-1400089674_1397637457444.png', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '0', null), ('3fd02fb7-12d8-4872-b9e5-b270ffc2e0b6', '2105981903_1397637457446.png', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1', null);
COMMIT;

-- ----------------------------
--  Table structure for `e_sale_visit`
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
--  Records of `e_sale_visit`
-- ----------------------------
BEGIN;
INSERT INTO `e_sale_visit` VALUES ('05bc8f0f-8154-4d23-a75e-33eaa5289735', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397960342436'), ('09830bc3-a792-41de-8a1c-495a771bc277', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216'), ('0b0ab314-ca20-4cdc-b082-08adb97406a5', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803687421'), ('0e53e34d-4144-40a6-8145-46c32e138ccb', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803834781'), ('1a2a7813-3bf9-4e03-93b3-f40f4ca6b9c5', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914673751'), ('1a3e9e05-7587-410d-a545-2091cfc4ca67', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919626630'), ('2c03740f-b219-4051-a5d8-a18ca6f979fb', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147383'), ('30a4cdbb-672c-4ea9-a7c9-768566338012', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919551675'), ('38878855-b488-4662-9d4a-3f859c5c06fe', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397913430824'), ('3d0128a5-f883-4f5c-b460-fd9124b4a317', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397918882287'), ('40d88f0f-89d3-46b4-ada3-9d2368c493a8', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397639741440'), ('507d2263-ed8b-431f-94ca-ab787f195166', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147391'), ('644d9e4a-38ca-48fb-9a60-70792ce7a111', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803287796'), ('654ffb41-dd83-4d4f-9d6a-c6e2606e03dd', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147377'), ('65f8aa4e-db15-4c2b-bd56-937463edd579', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397896611601'), ('6a6db16c-0339-4e21-882e-49115ca77a1b', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397639741440'), ('76bccbbe-61db-4836-8f89-e6f705052c70', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216'), ('7d679a81-9db6-43df-a6d7-065df1f80aba', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147344'), ('7e641d13-5c22-4e1b-b196-a38acb89df86', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794341906'), ('7f8c4c92-b985-4752-bb2a-35d90d762e47', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794387578'), ('812b4326-d9b0-4cc7-9253-efc9afd011f0', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397700689920'), ('87165ab6-f174-4d30-adda-82e2e1af4f46', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397912606478'), ('8c59b296-0ad7-4a03-8c09-7cb34285fbf4', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397960318827'), ('8fe639f3-a53f-44f6-8254-2cbea21dbf8e', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794102640'), ('95972f14-c1d6-4584-b471-bc2ff2048033', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397897252503'), ('9ab9e6cb-cc9e-4f16-b8f0-f20da5682666', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919429100'), ('9c2f4d60-dabf-4c2d-be35-c778ae6b02cf', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397913855065'), ('9ff01e68-e912-43eb-836d-db927e805b54', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397995352507'), ('9ff1ff7d-040f-41b4-8f69-a21420c2c069', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397896551797'), ('a5ca8f3a-0559-4a65-b154-937ade77b29b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919636151'), ('b4367258-3732-4216-b85c-b0e9dc8be1e7', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397638430720'), ('b8c29ba0-39b0-4f57-859d-f48c2dcc1683', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397912721591'), ('bb9a751d-046f-46b7-9297-377493cc7f62', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397638299648'), ('c49164bc-6aca-49e3-9cbc-10944917cad1', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397918387298'), ('c5030227-1886-4a74-a86b-efb0d0b9f4de', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794291484'), ('c79d7a4f-4584-4266-9e6d-4ae1b1139b75', '7248db2e-c8d2-4d26-8047-79c8082fb80f', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397702092906'), ('caf82252-50a7-4048-bb9f-275d9dbc390f', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397918315070'), ('d22b59a5-fd9e-4976-a2f5-f62c648037eb', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397913348244'), ('d66d22af-51d3-447a-b6a5-4fcbc672a878', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637644288'), ('d9116341-fc92-4cab-a1be-d41560734671', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637644288'), ('da990b23-aa7f-4f4a-a79c-54d658093961', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397995305600'), ('dd20ddf9-b0cc-4e5d-991b-e08f12647b3c', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637906432'), ('de33b525-259c-48a7-a3a5-b5a66a84cb22', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397919458902'), ('df30fda8-d9cb-4314-9764-f14b2464dc02', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637775360'), ('e12d1001-3c86-441f-af57-0cbd6cc3015b', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397713270015'), ('e306811a-f3b8-4f53-b830-8fd27624fa38', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397960220912'), ('e6e1b35d-b4b1-4f87-bd24-65711a49cfb4', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1398091385452'), ('e7666d2f-9acd-4d44-a058-0d33eadf55fe', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397637513216'), ('e8e59d2c-4851-4d3c-a316-8b91ce2b27a7', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794083718'), ('e99b11ce-b129-4f7e-93d2-7142ccdfd3e0', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397803448500'), ('efc34fb3-a228-4a69-b478-1658738f039c', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397794130875'), ('f6a3c62f-7543-43fc-bf09-4f9625093f63', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397804610718'), ('fa92d223-a434-41c8-84e1-e76990488df0', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397896523746'), ('fed0a023-2f09-4a95-9d36-3ad6ab5d0361', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397786241625'), ('ffbc18db-1597-44d9-b33b-d3c81483a04c', '95982f2a-df27-42a2-bfeb-98332233d498', 'f1385b00-92b7-413b-98d6-61e3fd471a05', '1397914147391');
COMMIT;

-- ----------------------------
--  Table structure for `e_setting`
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
--  Records of `e_setting`
-- ----------------------------
BEGIN;
INSERT INTO `e_setting` VALUES ('1', 'login', '登录设置', '0', null), ('2', 'cache', '缓存', '1', null), ('3', 'radar', '雷达配置', '2', null);
COMMIT;

-- ----------------------------
--  Table structure for `e_share`
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
--  Records of `e_share`
-- ----------------------------
BEGIN;
INSERT INTO `e_share` VALUES ('47e07784-7b25-414b-8261-f61d21f960c6', '11111', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398088689727', '2014-04-21', null, '1', '', '1398088987349'), ('77e75293-dcef-417e-a5b4-f917a93e15be', '上地肯德基的优惠真给力', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1397636464640', '2014-04-16', null, '1', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1398082411528'), ('ab6f6874-88f1-4015-8eed-8c8f24937d56', '88888', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398089176683', '2014-04-21', null, '0', '', '1398089176683'), ('b664f078-e33e-4421-80bd-2e00824fd524', '2222', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398088789310', '2014-04-21', null, '0', '', '1398089130609');
COMMIT;

-- ----------------------------
--  Table structure for `e_share_comment`
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
--  Records of `e_share_comment`
-- ----------------------------
BEGIN;
INSERT INTO `e_share_comment` VALUES ('eabe1e04-ca4f-486b-9df2-cc7281df076e', 'b664f078-e33e-4421-80bd-2e00824fd524', null, '66666', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '1398089112075', '1', '1398089130605');
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
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `e_share_img`
-- ----------------------------
BEGIN;
INSERT INTO `e_share_img` VALUES ('53eca583-869a-42f7-b25c-c1ffc7255123', '1309850451_1398088778771.png', 'b664f078-e33e-4421-80bd-2e00824fd524', '1', '1398088789314'), ('83b61b99-8bc7-480d-ae91-a50deca7a4e9', '463517179_1398088785990.png', 'b664f078-e33e-4421-80bd-2e00824fd524', '2', '1398088789738');
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
--  Records of `e_shop`
-- ----------------------------
BEGIN;
INSERT INTO `e_shop` VALUES ('a7b21d66-5681-421d-96c4-6c560471eee8', '肯德基上地店', null, '1309850451_1397631831384.png', '{\"address\":\"北京市海淀区北清路68号\",\"lontitude\":116.242521,\"radius\":20.5,\"latitude\":40.073394}', '北京市海淀区北清路68号', '肯德基大品牌', '-1044649450_1397631831387.png', null, '95982f2a-df27-42a2-bfeb-98332233d498', null, '1397631877120', '1', 'barcode_-1053186559_1397631834031.png');
COMMIT;

-- ----------------------------
--  Table structure for `e_shop_emp`
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
--  Records of `e_shop_emp`
-- ----------------------------
BEGIN;
INSERT INTO `e_shop_emp` VALUES ('bc579f27-5d16-4ce7-9965-33e72028765a', 'a7b21d66-5681-421d-96c4-6c560471eee8', '95982f2a-df27-42a2-bfeb-98332233d498', '11111', null);
COMMIT;

-- ----------------------------
--  Table structure for `e_shop_favorit`
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
--  Records of `e_shop_favorit`
-- ----------------------------
BEGIN;
INSERT INTO `e_shop_favorit` VALUES ('136bba39-3725-44cb-8d40-45ffc499231f', '2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1397637775360', '0'), ('21eb5bf4-5821-4f03-9c10-76f846829a7a', '95982f2a-df27-42a2-bfeb-98332233d498', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1397803300781', '0');
COMMIT;

-- ----------------------------
--  Table structure for `e_shop_trade`
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
--  Records of `e_shop_trade`
-- ----------------------------
BEGIN;
INSERT INTO `e_shop_trade` VALUES ('c7cbdc71-e8ce-4dc6-86f6-ed4281165470', 'a7b21d66-5681-421d-96c4-6c560471eee8', '1', '');
COMMIT;

-- ----------------------------
--  Table structure for `e_trade`
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
--  Records of `e_trade`
-- ----------------------------
BEGIN;
INSERT INTO `e_trade` VALUES ('1', 'food', '美食', '1', '1'), ('2', 'clothes', '服装', '2', '1'), ('3', 'beauty', '美妆', '3', '1'), ('40', 'baby', '母婴', '4', '1'), ('41', 'computer', '电脑', '5', '1'), ('42', 'book', '书城', '6', '1');
COMMIT;

-- ----------------------------
--  Table structure for `e_user`
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
--  Records of `e_user`
-- ----------------------------
BEGIN;
INSERT INTO `e_user` VALUES ('2c0ae241-95e9-442f-8a4c-8a6ae9063b5e', '李四', '4444', null, '4', '4_1397634425877.png', null, null, null, '1397634498560'), ('7248db2e-c8d2-4d26-8047-79c8082fb80f', '张三', '3333', null, '3', '3_1397638131573.png', null, null, null, '1397638168576'), ('95982f2a-df27-42a2-bfeb-98332233d498', 'i依依', '1111', null, '1', '1_1397631232100.png', null, null, null, '1397631221760');
COMMIT;

