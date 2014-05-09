/*
Navicat MySQL Data Transfer

Source Server         : localhost_ebs
Source Server Version : 50511
Source Host           : localhost:3306
Source Database       : ebs

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2014-05-09 11:49:27
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
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_friend_user_friend_id` (`friend_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_friend
-- ----------------------------
INSERT INTO `e_friend` VALUES ('85f0c293-6970-436d-b356-c5d7c22c8bb6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399517575250');
INSERT INTO `e_friend` VALUES ('af24f8b6-b2fe-4491-97b7-dd141fdc906f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1399516780656');

-- ----------------------------
-- Table structure for `e_log`
-- ----------------------------
DROP TABLE IF EXISTS `e_log`;
CREATE TABLE `e_log` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `user_phone` varchar(11) DEFAULT NULL,
  `remote_addr` varchar(20) DEFAULT NULL,
  `act_time` varchar(20) DEFAULT NULL,
  `action` varchar(32) DEFAULT NULL,
  `act_uri` varchar(500) DEFAULT NULL,
  `act_content` varchar(2000) DEFAULT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_log
-- ----------------------------
INSERT INTO `e_log` VALUES ('00288660-21bd-4985-b0eb-2ea4ff58ff06', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:25:34', ':post', '/updateShop', '{:value \"898289355_1399515888683.png\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"busi_license\", :fileNameList \"898289355_1399515888683.png\", \"898289355_1399515888683.png\" {:size 290977, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2209431152795542016.tmp>, :content-type \"image/pjpeg\", :filename \"898289355_1399515888683.png\"}}', '1399515934328');
INSERT INTO `e_log` VALUES ('00418834-6df5-461b-97b6-11345fc182d2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:09:04', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"妞妞\"}', '1399511344734');
INSERT INTO `e_log` VALUES ('014be67a-758b-4015-bedd-ab5718a8b042', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:57:51', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E7%9A%84%E4%BC%98%E6%83%A0%E5%B9%85%E5%BA%A6%E7%9C%9F%E5%A4%A7\", :fileNameList \"\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453071390');
INSERT INTO `e_log` VALUES ('03860890-ab64-4868-85ea-12b4f23ce859', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:40:36', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531236640');
INSERT INTO `e_log` VALUES ('045881f1-2739-4162-b6a8-b4f768e7fd59', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780093');
INSERT INTO `e_log` VALUES ('046fe82c-6a39-45e8-8df7-3e675c8c3a50', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:12', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450272593');
INSERT INTO `e_log` VALUES ('04d3ddb7-8f8f-4064-b062-287629f9614e', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:10', ':get', '/getSalesByChannel/1/1399448709921', null, '1399448710359');
INSERT INTO `e_log` VALUES ('0548c9c0-d7f6-4764-9033-f6f10eb9a0e0', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:05', ':get', '/getSalesByChannel/1/1399446365046', null, '1399446365312');
INSERT INTO `e_log` VALUES ('05800a5b-6534-4187-9073-7b5358587ff0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:39:53', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531193703');
INSERT INTO `e_log` VALUES ('05ceaaee-acc7-48ea-aed8-e9b87b2ea6c1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:57:02', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399514222078');
INSERT INTO `e_log` VALUES ('05cebc83-3afb-42c3-b0b0-05d55c035db2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:41:16', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399452074181.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242455%2C%22radius%22%3A30.53333282470703%2C%22latitude%22%3A40.073713%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399452074181.png\", \"-1400089674_1399452074181.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-9101481504796265372.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399452074181.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\"}', '1399452076078');
INSERT INTO `e_log` VALUES ('06244c60-2180-4526-9194-80c92c87594a', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:09', ':get', '/getSalesByChannel/0/1399448672640', null, '1399448709859');
INSERT INTO `e_log` VALUES ('06ba79d8-b480-4abc-8cfe-e0d172b9f0a5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:52:55', ':post', '/addFriend', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :friend_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399517575203');
INSERT INTO `e_log` VALUES ('06bf5caa-7b4c-48c0-ab04-d6fd38b15589', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:24', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607244671');
INSERT INTO `e_log` VALUES ('06cc8233-db2f-48fc-8fbd-b6e9541e1e4f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:15', ':get', '/getSalesByChannel/0/1399449043453', null, '1399449255140');
INSERT INTO `e_log` VALUES ('07ab7288-fefb-480b-939b-4bc87ac98057', null, '13651083480', '192.168.253.3', '2014-05-08 09:21:54', ':post', '/login', '{:phone \"13651083480\"}', '1399512114062');
INSERT INTO `e_log` VALUES ('08716db2-2389-423c-a26c-fdfbead55856', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:55:21', ':post', '/saveShare', '{:shop_id \"\", :content \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E4%B8%8A%E5%9C%B0%E5%BA%97%E4%BC%98%E6%83%A0%E5%BE%88%E5%A4%9A%EF%BC%8C%E6%AC%A2%E8%BF%8E%E6%83%A0%E9%A1%BE%E3%80%82\", :fileNameList \"\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399517721625');
INSERT INTO `e_log` VALUES ('08fcfa5b-432b-4e0f-b8b1-c80a85f18f04', null, null, '192.168.253.3', '2014-05-08 10:04:04', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514644046');
INSERT INTO `e_log` VALUES ('0a71ae96-4d3c-44a9-9cf2-e22acea47bd3', null, null, '192.168.253.3', '2014-05-08 09:59:05', ':get', '/getImageFile/748488426_1399514332755.png', null, '1399514345765');
INSERT INTO `e_log` VALUES ('0a9a1c29-1376-4188-86ae-61c8371fa13a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:48:06', ':get', '/getSalesByChannel/0/1399451070468', null, '1399452486046');
INSERT INTO `e_log` VALUES ('0abb3eab-3c4d-43f3-9de3-d473103198bb', null, '13651083480', '192.168.253.3', '2014-05-09 08:33:29', ':get', '/getSalesByChannel/1/1399595538468', null, '1399595609375');
INSERT INTO `e_log` VALUES ('0bb64b9c-f184-417d-9911-caa21b8e7d45', null, null, '192.168.253.3', '2014-05-09 08:41:08', ':get', '/pub/grade_shop.html', null, '1399596068046');
INSERT INTO `e_log` VALUES ('0bc70dbc-dd43-42d8-a881-059d79c4289b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:52', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399452952500', null, '1399453132015');
INSERT INTO `e_log` VALUES ('0bc95039-e470-4520-be59-ef39b8e38996', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:47:58', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"i妞妞\"}', '1399448878812');
INSERT INTO `e_log` VALUES ('0c2b4147-8220-4b2c-9b1e-f500cdacd584', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:13:40', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399454020421');
INSERT INTO `e_log` VALUES ('0d6fc395-98c6-4b9f-ae86-8838a55ca22a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:44:46', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"address\", :value \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B71\", :fileNameList \"\"}', '1399513486640');
INSERT INTO `e_log` VALUES ('0e052dd5-601a-48b6-b747-4c2780cb6948', null, '1', '192.168.253.3', '2014-05-08 16:14:51', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536891671');
INSERT INTO `e_log` VALUES ('0e6297b8-f700-4ee8-9eca-9b8532f06780', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:45:50', ':get', '/getModules/discover', null, '1399607150468');
INSERT INTO `e_log` VALUES ('0e636571-3ad3-489f-b0ab-035393f9f145', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:32', ':get', '/getModules/me', null, '1399530812968');
INSERT INTO `e_log` VALUES ('0e87fc8a-24b0-4b9c-a558-09c3679ad592', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:08', ':get', '/getSalesByChannel/1/1399530810859', null, '1399533908453');
INSERT INTO `e_log` VALUES ('0ff9daa1-e35e-4ef1-8418-b85ebe3f8a2e', null, null, '192.168.253.3', '2014-05-08 10:08:42', ':get', '/getImageFile/-810116522_1399514888415.png', null, '1399514922796');
INSERT INTO `e_log` VALUES ('10053483-4f4a-4be0-8994-088bc29be1c2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:28', ':get', '/getSalesByChannel/2/1399521443171', null, '1399521448265');
INSERT INTO `e_log` VALUES ('105a7e7e-002f-4b54-b7ae-cfad6f659c39', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:40:01', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399603201453');
INSERT INTO `e_log` VALUES ('10f7a4f2-b998-49ab-947d-e4dea57212c0', null, '13651083480', '192.168.253.3', '2014-05-07 16:22:32', ':post', '/login', '{:phone \"13651083480\"}', '1399450952531');
INSERT INTO `e_log` VALUES ('1101a8f0-31ce-40c8-a6cb-2a3361128b4a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:42', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399449042515');
INSERT INTO `e_log` VALUES ('117f1198-7ffe-4064-960e-b132a901c3ab', null, '1', '192.168.253.3', '2014-05-09 11:26:03', ':post', '/login', '{:phone \"1\"}', '1399605963468');
INSERT INTO `e_log` VALUES ('11974522-309d-4d8e-8655-53caba6a8ae1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:31:15', ':get', '/getShopFavoritesByUser/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399519875140');
INSERT INTO `e_log` VALUES ('119a0115-d949-404d-9dfd-054f59f1b517', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:43:35', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399455815953');
INSERT INTO `e_log` VALUES ('119bf673-3d86-49c7-a87e-7da75d94be52', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:27:04', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606024875');
INSERT INTO `e_log` VALUES ('11a43941-e9a5-49ef-bc12-50f7958568aa', null, '13651083480', '192.168.253.3', '2014-05-08 09:59:01', ':post', '/saveUserPhoto', '{:photo \"748488426_1399514332755.png\", :fileNameList \"748488426_1399514332755.png\", :uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", \"748488426_1399514332755.png\" {:size 58889, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3240792689501395081.tmp>, :content-type \"image/pjpeg\", :filename \"748488426_1399514332755.png\"}}', '1399514341843');
INSERT INTO `e_log` VALUES ('11b74667-38cd-4d1c-bce2-914b83b5c0d5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:07:54', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399514874234');
INSERT INTO `e_log` VALUES ('11dc5b97-ffdc-489f-b8a0-99d6949abfbd', null, '13651083480', '192.168.253.3', '2014-05-08 13:47:38', ':post', '/login', '{:phone \"13651083480\"}', '1399528058468');
INSERT INTO `e_log` VALUES ('1237f85f-e58b-418d-b833-29693b9d33ec', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:07', ':get', '/getSalesByChannel/2/1399595523437', null, '1399595527828');
INSERT INTO `e_log` VALUES ('123a3304-50b7-4c1e-a789-38ee8c9ac142', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:48:06', ':get', '/getSalesByChannel/1/1399452486171', null, '1399452486562');
INSERT INTO `e_log` VALUES ('127fe341-8189-4d50-9889-7125f44115e3', null, null, '192.168.253.3', '2014-05-08 11:56:20', ':get', '/getImageFile/463517179_1399521362365.png', null, '1399521380062');
INSERT INTO `e_log` VALUES ('12948cd6-858b-4a17-9ebc-7c2ed1e3b49a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:45:52', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517152812');
INSERT INTO `e_log` VALUES ('12bd4ff8-7b95-4624-8000-ed029d3313e0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 11:32:51', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399606371515');
INSERT INTO `e_log` VALUES ('12f0b3e2-5ba4-4386-9f7e-ad7caf9b3ba3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:35:58', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606558390');
INSERT INTO `e_log` VALUES ('135d966f-0a81-4603-b9dd-301c3bd94d44', null, '13651083480', '192.168.253.3', '2014-05-08 09:52:57', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399513964667.png\"}', '1399513977125');
INSERT INTO `e_log` VALUES ('13fc67df-4c49-4d89-a48b-690377341bc3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:07', ':get', '/getSalesByChannel/1/1399450446671', null, '1399450447125');
INSERT INTO `e_log` VALUES ('141c087f-bd88-463e-84de-d17c8ee014b5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:34', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453294828');
INSERT INTO `e_log` VALUES ('1458f5cd-b934-4192-868f-6f9654f1438e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:28', ':post', '/loginShop', '{:user_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399595548281');
INSERT INTO `e_log` VALUES ('156e309e-7fc0-47c9-aead-1dc707ff2f66', null, null, '192.168.253.3', '2014-05-08 09:22:04', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512124921');
INSERT INTO `e_log` VALUES ('1577044c-53be-4059-a1a7-15e1fc2b3068', null, null, '192.168.253.3', '2014-05-08 10:41:11', ':get', '/getImageFile/463517179_1399516848803.png', null, '1399516871937');
INSERT INTO `e_log` VALUES ('15dc10c6-fc72-4c7f-bb82-640a3686d933', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:44', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453124406');
INSERT INTO `e_log` VALUES ('15e5f89d-75ed-4405-9dd6-43e475a32670', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:51:19', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399539079640');
INSERT INTO `e_log` VALUES ('15eb62a6-a727-4405-8780-10bfe4d2c56a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:56:13', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528573109');
INSERT INTO `e_log` VALUES ('17eef8fb-3aab-4369-9e41-c7953b0a6470', null, '13651083480', '192.168.253.3', '2014-05-07 17:43:21', ':post', '/login', '{:phone \"13651083480\"}', '1399455801671');
INSERT INTO `e_log` VALUES ('18090f57-6f25-49eb-a234-190dba17fc8e', null, '13651083480', '192.168.253.3', '2014-05-08 09:13:15', ':post', '/login', '{:phone \"13651083480\"}', '1399511595828');
INSERT INTO `e_log` VALUES ('180f7f5c-ac9d-4ef5-ac7b-9d9f2ee314d1', null, '13651083480', '192.168.253.3', '2014-05-08 09:05:30', ':post', '/login', '{:phone \"13651083480\"}', '1399511130109');
INSERT INTO `e_log` VALUES ('1831d5b6-f3d3-4eb1-b935-de7fa7822ae1', null, '1', '192.168.253.3', '2014-05-09 10:19:56', ':post', '/login', '{:phone \"1\"}', '1399601996609');
INSERT INTO `e_log` VALUES ('18330ddc-74f2-4a5e-9e19-1db203b5cb20', null, '13651083480', '192.168.253.3', '2014-05-09 11:30:20', ':post', '/login', '{:phone \"13651083480\"}', '1399606220515');
INSERT INTO `e_log` VALUES ('184a5c20-a87a-4868-ad21-7447a4a7ab94', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:56:48', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517808468');
INSERT INTO `e_log` VALUES ('18b326ed-a291-471a-85d0-16d4c6bd7677', null, '13651083480', '192.168.253.3', '2014-05-09 11:45:25', ':get', '/getChannels', null, '1399607125796');
INSERT INTO `e_log` VALUES ('18c8e9bf-5c3e-4b9b-aa98-68a3ee58cc64', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:29:35', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606175296');
INSERT INTO `e_log` VALUES ('190d8588-9793-4228-992e-96ce38552058', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:39:46', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451983821.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242442%2C%22radius%22%3A40.0625%2C%22latitude%22%3A40.073733%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451983821.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\", \"-1400089674_1399451983821.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-4374092049493088978.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451983821.png\"}}', '1399451986296');
INSERT INTO `e_log` VALUES ('197ed8f7-a531-43be-89f1-69c6ad49b299', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:42:46', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399516966859');
INSERT INTO `e_log` VALUES ('197f38f5-3aa9-4cd8-a99d-ebd06964c0c1', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:19', ':get', '/getSalesByChannel/0/1399530793906', null, '1399530799578');
INSERT INTO `e_log` VALUES ('1a695663-03d3-4939-bc6b-a0daf7b3d048', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:13', ':get', '/getSalesByChannel/0/1399449255687', null, '1399450273500');
INSERT INTO `e_log` VALUES ('1a7b29c3-85c4-45fa-9750-ce588f72e1fb', null, '13651083480', '192.168.253.3', '2014-05-08 15:24:31', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399533871453');
INSERT INTO `e_log` VALUES ('1ab1b26a-a4d3-469f-b764-e7173fb50332', null, null, '192.168.253.1', '2014-05-07 16:31:55', ':get', '/aa', null, '1399451515359');
INSERT INTO `e_log` VALUES ('1bbae5ab-e6d8-475e-b2d6-a7b625d1c59f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:30', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399449090046');
INSERT INTO `e_log` VALUES ('1bdf8f53-9cd2-45f5-a060-78b147e3b8c1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:53:51', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399521231937');
INSERT INTO `e_log` VALUES ('1c56297d-6930-489b-ab2e-aac9a3492112', null, null, '192.168.253.3', '2014-05-07 17:43:41', ':get', '/getImageFile/barcode_-509784425_1399452076140.png', null, '1399455821218');
INSERT INTO `e_log` VALUES ('1e0d1c21-36df-40f1-9d0a-12aef9cd2e43', null, '13651083480', '192.168.253.3', '2014-05-08 11:51:16', ':post', '/login', '{:phone \"13651083480\"}', '1399521076328');
INSERT INTO `e_log` VALUES ('1ea9bc91-67e6-46be-9c65-789e8804c534', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:10', ':get', '/getSettings', null, '1399517050953');
INSERT INTO `e_log` VALUES ('1f2229de-9486-4c0a-9403-19d49252ce03', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:11:21', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399515081765');
INSERT INTO `e_log` VALUES ('1f9fc324-fb10-4634-bf65-16e25510fa80', null, '13651083480', '192.168.253.3', '2014-05-08 09:08:31', ':post', '/login', '{:phone \"13651083480\"}', '1399511311500');
INSERT INTO `e_log` VALUES ('200cccb3-2ba5-4248-ac5b-7f945eef2753', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:53:59', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521239281');
INSERT INTO `e_log` VALUES ('20e15817-6cec-452f-a046-a2fffe7d70cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:41', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528361796');
INSERT INTO `e_log` VALUES ('2183a7b6-a99f-421c-beec-6af810208252', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:14', ':get', '/getModules/discover', null, '1399446374921');
INSERT INTO `e_log` VALUES ('219ed265-0c6d-4226-9058-091665da0880', null, null, '192.168.253.3', '2014-05-08 09:10:30', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399511430640');
INSERT INTO `e_log` VALUES ('22669777-bbdc-47c0-a57f-e912bd92fd3d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:45:33', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399531533718');
INSERT INTO `e_log` VALUES ('2295e41f-234c-4b3d-98d7-2b321475c468', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:28', ':get', '/getSalesByChannel/0/1399452890000', null, '1399453348296');
INSERT INTO `e_log` VALUES ('22d40a94-5a37-4c93-8aef-37ca6795d376', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:39:04', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451941843.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A43.61538314819336%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451941843.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\", \"-1400089674_1399451941843.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7030770994781893059.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451941843.png\"}}', '1399451944187');
INSERT INTO `e_log` VALUES ('22f4d41c-43a5-4bc9-988e-640c2556c785', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:05', ':get', '/getModules/me', null, '1399448705687');
INSERT INTO `e_log` VALUES ('22fe4eec-5f60-4b36-93a4-6a9081ed45ff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:14', ':get', '/getSalesByChannel/1/1399450273562', null, '1399450274187');
INSERT INTO `e_log` VALUES ('232eff68-a040-4085-960b-6f3ec4717eb2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:25:52', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399533952218');
INSERT INTO `e_log` VALUES ('23665cd9-f07e-46b6-a98c-ca1dca2c920a', null, '1', '192.168.253.3', '2014-05-09 10:29:23', ':post', '/login', '{:phone \"1\"}', '1399602563140');
INSERT INTO `e_log` VALUES ('23c70a5b-140c-4d78-a981-0cf3cd4f9786', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:01:49', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514494034.png\"}', '1399514509062');
INSERT INTO `e_log` VALUES ('24151ed8-e7a9-40cb-a13f-7a490b3455e4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:10:28', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399511428640');
INSERT INTO `e_log` VALUES ('244217ba-32e9-426e-901a-b8045773c203', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:08:27', ':get', '/getSalesByChannel/1/1399446507625', null, '1399446507828');
INSERT INTO `e_log` VALUES ('247ef96f-59c9-4cfa-a861-b9abb39ebdcd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:45:52', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399607152750');
INSERT INTO `e_log` VALUES ('24a3d094-9460-4fb9-8a6f-911b8562f0ff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:08:58', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"妞妞11\"}', '1399511338031');
INSERT INTO `e_log` VALUES ('2528b55d-b8ef-47c1-a1ad-4e8b203e7b8f', null, '13651083480', '192.168.253.3', '2014-05-08 16:48:44', ':get', '/getSalesByChannel/1/1399536258750', null, '1399538924359');
INSERT INTO `e_log` VALUES ('255848ef-e97b-42b1-8d9c-784a8f175f48', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:27:37', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399516057125');
INSERT INTO `e_log` VALUES ('25b36e8c-b0bd-4f5e-bf89-b52a3830f1db', null, null, '192.168.253.1', '2014-05-07 16:30:02', ':get', '/aa', null, '1399451402000');
INSERT INTO `e_log` VALUES ('25b48fc6-c62d-4557-977e-ffb34da8a852', null, '13651083480', '192.168.253.3', '2014-05-09 11:32:51', ':post', '/login', '{:phone \"13651083480\"}', '1399606371093');
INSERT INTO `e_log` VALUES ('25cf977c-c482-41fe-a835-3cc9dbd4af69', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:48', ':post', '/addShopFavorit', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\"}', '1399452948625');
INSERT INTO `e_log` VALUES ('26ad8fdc-4c49-4837-8017-16533bd4635a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:43:26', ':get', '/getSaleFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517006562');
INSERT INTO `e_log` VALUES ('26f2876e-b917-4f53-94d0-88f09c1a9503', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:51:25', ':get', '/getSalesByShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399452076125', null, '1399521085156');
INSERT INTO `e_log` VALUES ('2740b349-c41a-436d-809d-130a610ab6aa', null, null, '192.168.253.3', '2014-05-07 17:56:38', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399456598875');
INSERT INTO `e_log` VALUES ('27f3a1a2-5ace-4494-b923-25db492cac75', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:34:11', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606451140');
INSERT INTO `e_log` VALUES ('28239fa7-c74f-487b-880e-f93340977817', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:38:38', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399595918015');
INSERT INTO `e_log` VALUES ('28d7b203-b9ad-4d3b-b698-b19e8ef5d080', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:28', ':get', '/getSalesByChannel/0/1399453390453', null, '1399453408546');
INSERT INTO `e_log` VALUES ('28fa4548-2642-4fbe-a095-d61b0fa8da25', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:56:46', ':get', '/getSalesByChannel/0/1399515059500', null, '1399521406968');
INSERT INTO `e_log` VALUES ('2923a8ef-c409-4727-ac5d-56272b5114fa', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:40:46', ':get', '/getTrades', null, '1399513246140');
INSERT INTO `e_log` VALUES ('292a553d-8d57-4d7a-908e-c96ce0a93a31', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:56:19', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521379031');
INSERT INTO `e_log` VALUES ('29eb59a7-98d3-4cda-8a94-7ae98e19742f', null, null, '192.168.253.3', '2014-05-07 16:55:43', ':get', '/getImageFile/barcode_-1897623607_1399449405500.png', null, '1399452943187');
INSERT INTO `e_log` VALUES ('2a4344e4-6392-4e2a-b121-a312a808533b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:56:27', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E7%9A%84%E4%BC%98%E6%83%A0%E5%B9%85%E5%BA%A6%E7%9C%9F%E5%A4%A7\", :fileNameList \"\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399452987562');
INSERT INTO `e_log` VALUES ('2a72844e-35fa-4df3-82b1-66c7b2a3fad2', null, null, '192.168.253.3', '2014-05-07 17:50:13', ':get', '/getImageFile/1711437471_1399456195076.png', null, '1399456213218');
INSERT INTO `e_log` VALUES ('2bcb1be7-efb4-4499-86c6-acc256ead064', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:56:45', ':post', '/registerShop', '{\"602324364_1399449344230.png\" {:size 282015, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3469479880405305017.tmp>, :content-type \"image/pjpeg\", :filename \"602324364_1399449344230.png\"}, :desc \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E5%A4%A7%E5%93%81%E7%89%8C\", :shop_img \"602324364_1399449344230.png\", \"898289355_1399449344232.png\" {:size 290977, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2058955765726519369.tmp>, :content-type \"image/pjpeg\", :filename \"898289355_1399449344232.png\"}, :name \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E4%B8%8A%E5%9C%B0%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242443%2C%22radius%22%3A44.83333206176758%2C%22latitude%22%3A40.073733%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"602324364_1399449344230.png%7C898289355_1399449344232.png\", :busi_license \"898289355_1399449344232.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"1\"}', '1399449405281');
INSERT INTO `e_log` VALUES ('2c08378c-447b-4a28-b725-f8a227ea1090', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:30', ':get', '/getSalesByChannel/1/1399451069687', null, '1399451070390');
INSERT INTO `e_log` VALUES ('2c372b81-90e6-4e47-8ce4-1aff7faaa9b9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:53', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448693312');
INSERT INTO `e_log` VALUES ('2c563777-a258-4147-9b24-24e0109d1d1a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:49:40', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399538980375');
INSERT INTO `e_log` VALUES ('2c5f2e18-10fd-4d29-bae0-f9ac301f48be', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:31', ':get', '/getSalesByChannel/40/1399521450546', null, '1399521451125');
INSERT INTO `e_log` VALUES ('2c9d64f5-a005-453d-b7de-a80fddd63183', null, '13651083480', '192.168.253.3', '2014-05-08 10:32:38', ':post', '/login', '{:phone \"13651083480\"}', '1399516358265');
INSERT INTO `e_log` VALUES ('2d4b04e0-46a0-4c4a-861d-ada511bae86e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:06:32', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536392140');
INSERT INTO `e_log` VALUES ('2d91934c-4d25-4695-82fb-11939eeb5899', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:45', ':get', '/getSalesByChannel/0/1399446373625', null, '1399446405593');
INSERT INTO `e_log` VALUES ('2db499bf-d9ec-4de6-9077-71c15cec0ec7', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:54', ':get', '/getChannels', null, '1399448574468');
INSERT INTO `e_log` VALUES ('2e37e831-4942-44db-ac51-857c7ef95047', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:47:46', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528066453');
INSERT INTO `e_log` VALUES ('2e458c73-4c32-4f0c-be75-b13b4f5dc76a', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780156');
INSERT INTO `e_log` VALUES ('2eb8a594-2b48-498e-b26b-528841119ee8', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:42:21', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E9%9D%9E%E5%B8%B8%E6%BB%A1%E6%84%8F%E7%9A%84%E6%B4%BB%E5%8A%A8\", :fileNameList \"\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399516941625');
INSERT INTO `e_log` VALUES ('2ec2e4f6-9d19-49c6-bda3-de9dfa5d78eb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:55', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516791406', null, '1399516795812');
INSERT INTO `e_log` VALUES ('2f34fc40-d1b9-4dca-a099-9e9e43ad7025', null, null, '192.168.253.3', '2014-05-08 09:48:46', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399513726875');
INSERT INTO `e_log` VALUES ('30092bd1-0aa4-4a45-853e-48d401142f11', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:27:47', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399516067984');
INSERT INTO `e_log` VALUES ('3017a482-d989-4990-b42b-85be3ce88626', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:56:38', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"1711437471_1399456582365.png\"}', '1399456598156');
INSERT INTO `e_log` VALUES ('3047e659-2725-4461-acd9-d97b00d707e3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:53', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399452893343');
INSERT INTO `e_log` VALUES ('30a18fc2-5c01-44fd-a4c0-62a8723b8b2f', null, '13651083480', '192.168.253.3', '2014-05-09 11:45:42', ':post', '/login', '{:phone \"1\"}', '1399607142968');
INSERT INTO `e_log` VALUES ('32ba5d37-f021-4533-9132-769ba7f81b80', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:33:05', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399595585859');
INSERT INTO `e_log` VALUES ('337bdf55-b17a-4759-8ff2-2f528afa7dca', null, '13651083480', '192.168.253.3', '2014-05-07 15:54:14', ':post', '/login', '{:phone \"13651083480\"}', '1399449254062');
INSERT INTO `e_log` VALUES ('33b44499-a933-4c92-82d3-79bba273166c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:26:01', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399533961375');
INSERT INTO `e_log` VALUES ('342a8d26-790a-4217-a21c-a6378aa7f353', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 11:42:45', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399520565531');
INSERT INTO `e_log` VALUES ('343dfb6c-8d58-4574-94a3-a10eace67e5d', null, '13651083480', '192.168.253.3', '2014-05-07 15:44:30', ':post', '/login', '{:phone \"13651083480\"}', '1399448670796');
INSERT INTO `e_log` VALUES ('3442f35e-80d8-431b-845c-77d13de93936', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:11:12', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399515072515');
INSERT INTO `e_log` VALUES ('347ba586-f5e3-4ab6-a491-c9a3e3f488bd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:51:39', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528299750');
INSERT INTO `e_log` VALUES ('34ed1ec8-e1ea-4ea5-8fdf-c5a4f986a5b4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:45', ':get', '/getShopShares/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399530825843');
INSERT INTO `e_log` VALUES ('350d687b-23c9-49b6-a766-0442f8ba04a0', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:52', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450730525.png\", :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242447%2C%22radius%22%3A39.31818389892578%2C%22latitude%22%3A40.073715%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450730525.png\", \"463517179_1399450730525.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3605247973725175815.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450730525.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450732265');
INSERT INTO `e_log` VALUES ('3547c4ba-2db0-4e7d-9776-2085da5cdd32', null, null, '192.168.253.3', '2014-05-08 09:40:48', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399513248187');
INSERT INTO `e_log` VALUES ('35545e52-0c95-4330-9f6b-c2932ca0d95d', null, null, '192.168.253.1', '2014-05-07 16:31:26', ':get', '/aa', null, '1399451486437');
INSERT INTO `e_log` VALUES ('355b1058-4ff1-4cd0-aaf9-17f172c02763', null, '1', '192.168.253.3', '2014-05-09 11:27:04', ':post', '/login', '{:phone \"1\"}', '1399606024390');
INSERT INTO `e_log` VALUES ('35809454-e9ad-40ce-bc9e-aa4c59a38bf4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:26:03', ':get', '/getTrades', null, '1399533963031');
INSERT INTO `e_log` VALUES ('36346a22-e977-452f-9051-5c2f80af9d64', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:29:13', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399526953906');
INSERT INTO `e_log` VALUES ('369fca96-8aca-4c33-b583-cec9c9ffabb0', null, '13651083480', '192.168.253.3', '2014-05-08 14:38:06', ':post', '/login', '{:phone \"13651083480\"}', '1399531086203');
INSERT INTO `e_log` VALUES ('37bcbe2a-fa76-4b12-8252-051f2fa0b06d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:26:36', ':post', '/createShopBarcode', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399515996578');
INSERT INTO `e_log` VALUES ('380a651c-c7ef-41a3-81ea-4d309138b7ce', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:29', ':get', '/getSalesByChannel/0/1399450999750', null, '1399451069656');
INSERT INTO `e_log` VALUES ('3855b996-e201-4a97-8951-7b3e67df60a5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:38', ':post', '/searchUsers', '{:search-word \"妞妞\"}', '1399516778156');
INSERT INTO `e_log` VALUES ('38b982f1-947f-4024-acd5-3d474070bd0e', null, '1', '192.168.253.3', '2014-05-08 16:10:15', ':post', '/login', '{:phone \"1\"}', '1399536615296');
INSERT INTO `e_log` VALUES ('3a0f755c-8cdb-4d58-9ffb-b14b831b07e8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:27:45', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399516065015');
INSERT INTO `e_log` VALUES ('3a5555ef-d36c-49b0-905f-e4bbb469a7d5', null, null, '192.168.253.3', '2014-05-08 09:24:09', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512249765');
INSERT INTO `e_log` VALUES ('3ab15c00-ed6f-4e3d-beb7-b05bad20b4de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:05', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450445765');
INSERT INTO `e_log` VALUES ('3ae29021-075f-4fef-b595-f9caf62c97e5', null, null, '192.168.253.3', '2014-05-08 09:13:28', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399511608671');
INSERT INTO `e_log` VALUES ('3b13d551-7e62-49f2-8a75-2d572bbe95df', null, '1', '192.168.253.3', '2014-05-08 16:17:10', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399537030890');
INSERT INTO `e_log` VALUES ('3b2a5a9f-4b87-4df0-9d40-54c1eb1d5c04', null, '1', '192.168.253.3', '2014-05-09 10:37:32', ':post', '/login', '{:phone \"1\"}', '1399603052140');
INSERT INTO `e_log` VALUES ('3bfbd918-4f6c-4474-8009-949de9ee38e4', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:28', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517068437');
INSERT INTO `e_log` VALUES ('3c161fcd-510a-4057-9e1d-0e0af5be4ed4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:28', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399452868843');
INSERT INTO `e_log` VALUES ('3cca892b-2108-4c99-9a31-ead28d402dc0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 11:30:21', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606221125');
INSERT INTO `e_log` VALUES ('3ce09b10-6538-4c17-89ef-119c34d5b1b0', null, '13651083480', '192.168.253.3', '2014-05-07 16:24:28', ':post', '/login', '{:phone \"13651083480\"}', '1399451068687');
INSERT INTO `e_log` VALUES ('3d822834-0867-480e-87f8-3c3149b5b3b6', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:55', ':get', '/getSalesByChannel/0/-1', null, '1399448575906');
INSERT INTO `e_log` VALUES ('3db6c4af-8ab5-45df-a396-3420842b2c97', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:15:18', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450516336.png\", :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A41.633331298828125%2C%22latitude%22%3A40.073734%7D\", \"463517179_1399450516336.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2483613127985079083.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450516336.png\"}, :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450516336.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450518328');
INSERT INTO `e_log` VALUES ('3dbe0646-4d9f-4b6b-83b2-009ab767cf75', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:42:03', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399596123140');
INSERT INTO `e_log` VALUES ('3ded2e94-8165-4f2f-9844-16e1941e7b1d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:34:16', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399530856234');
INSERT INTO `e_log` VALUES ('3e5f0d37-0b9d-4104-87d4-802b1d8efb35', null, '1', '192.168.253.3', '2014-05-09 10:40:01', ':post', '/login', '{:phone \"1\"}', '1399603201046');
INSERT INTO `e_log` VALUES ('3f0342ac-8435-45bf-bb96-f2d3f6c3ca63', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:53:13', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399517584468', null, '1399517593281');
INSERT INTO `e_log` VALUES ('3f55fb8d-05d5-47f2-884f-d2c06ec9a3f5', null, null, '192.168.253.3', '2014-05-08 11:56:08', ':get', '/getImageFile/-354365311_1399521331897.png', null, '1399521368593');
INSERT INTO `e_log` VALUES ('3f72973b-0cf6-47bc-add7-049ce3876444', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:14', ':get', '/getSalesByChannel/1/1399446554312', null, '1399446554687');
INSERT INTO `e_log` VALUES ('3f93a040-3dd5-4a8b-a272-90244a213e77', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:32:01', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399527121468');
INSERT INTO `e_log` VALUES ('3fbde255-1353-4ded-b9c4-2b623126ee52', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:15', ':get', '/getSalesByChannel/1/1399449255171', null, '1399449255593');
INSERT INTO `e_log` VALUES ('406b7e76-3cad-44cd-9a18-689a05b91e66', null, null, '192.168.253.3', '2014-05-07 16:55:43', ':get', '/getImageFile/898289355_1399449344232.png', null, '1399452943171');
INSERT INTO `e_log` VALUES ('40782aae-c5aa-48c0-b626-c4b4e477bdc5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:38:10', ':post', '/saveUserPhoto', '{:photo \"1321682725_1399516655545.png\", :fileNameList \"1321682725_1399516655545.png\", :uuid \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", \"1321682725_1399516655545.png\" {:size 244049, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-4907002354317488150.tmp>, :content-type \"image/pjpeg\", :filename \"1321682725_1399516655545.png\"}}', '1399516690390');
INSERT INTO `e_log` VALUES ('42020c41-8503-4738-912a-d8800e5a1434', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:33', ':post', '/addSaleFavorit', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453533531');
INSERT INTO `e_log` VALUES ('4249258e-cb7e-4657-9feb-aa6a6116fffb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:08:49', ':post', '/saveUserPhoto', '{:photo \"940407648_1399511322875.png\", :fileNameList \"940407648_1399511322875.png\", :uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", \"940407648_1399511322875.png\" {:size 46837, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-5836286651036149654.tmp>, :content-type \"image/pjpeg\", :filename \"940407648_1399511322875.png\"}}', '1399511329031');
INSERT INTO `e_log` VALUES ('436e5e42-f8ad-4cb2-b3ef-6b8ab297d4f5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:28:13', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399516082250', null, '1399516093390');
INSERT INTO `e_log` VALUES ('45627410-e61d-4441-af06-ac9a9c8e2dfe', null, null, '192.168.253.3', '2014-05-08 11:56:08', ':get', '/getImageFile/-354365311_1399521331897.png', null, '1399521368640');
INSERT INTO `e_log` VALUES ('45aea1c9-dcd6-470d-bc4a-2e70fae3c64f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:48:58', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399456138375');
INSERT INTO `e_log` VALUES ('45d4822f-e598-493e-bc93-2e0d0676af02', null, null, '192.168.253.3', '2014-05-07 16:54:29', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452869937');
INSERT INTO `e_log` VALUES ('45da520a-1c79-4937-b620-beace244f883', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:24', ':post', '/addShopFavorit', '{:user_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\"}', '1399517064484');
INSERT INTO `e_log` VALUES ('461c1b0e-4112-47a0-8fc7-5481c78ca9ee', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:14', ':get', '/getSalesByChannel/0/1399446507875', null, '1399446554250');
INSERT INTO `e_log` VALUES ('46800fac-453e-4c29-89c3-201c3af85125', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:34', ':get', '/getSalesByChannel/42/1399521451203', null, '1399521454765');
INSERT INTO `e_log` VALUES ('473a90dc-3e97-4a0a-9570-341b4d7cb39b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:38', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399451078015');
INSERT INTO `e_log` VALUES ('47e1bdcc-e09a-4aad-8b76-8babc6b8e648', null, '1', '192.168.253.3', '2014-05-08 16:09:41', ':post', '/login', '{:phone \"1\"}', '1399536581187');
INSERT INTO `e_log` VALUES ('484a0649-a747-410a-8047-ce8a4dee0acd', null, '13651083480', '192.168.253.3', '2014-05-07 15:17:00', ':post', '/login', '{:phone \"13651083480\"}', '1399447020343');
INSERT INTO `e_log` VALUES ('487ede92-3649-4bd7-a46e-8442cc72be0e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:49', ':get', '/getSalesByChannel/0/1399452486671', null, '1399452889609');
INSERT INTO `e_log` VALUES ('48836c88-7756-48eb-bf65-6a9561f3233d', null, null, '192.168.253.3', '2014-05-07 17:01:25', ':get', '/getImageFile/50489896_1399453226535.png', null, '1399453285000');
INSERT INTO `e_log` VALUES ('496dce09-c0e2-4b89-8463-43c0df282aa0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:18', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450998453');
INSERT INTO `e_log` VALUES ('4a3fe72d-048c-4730-a937-15d6fc9f3757', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:39:29', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531169390');
INSERT INTO `e_log` VALUES ('4a8befe6-1eb7-4f45-94ce-e7c19eb613c9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:51:58', ':post', '/registerShop', '{\"1259860143_1399452716068.png\" {:size 68674, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7107816321588269714.tmp>, :content-type \"image/pjpeg\", :filename \"1259860143_1399452716068.png\"}, :desc \"%E6%AC%A2%E8%BF%8E%E5%85%89%E4%B8%B4\", :shop_img \"1259860143_1399452716068.png\", :name \"%E4%B8%BD%E4%BD%B3%E5%AE%9D%E8%B4%9D%E6%B0%B8%E6%97%BA%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22radius%22%3A38.766666412353516%2C%22longitude%22%3A116.242444%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"1259860143_1399452716068.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"40%7C3\"}', '1399452718515');
INSERT INTO `e_log` VALUES ('4b13aa3d-cb4f-4b1e-b7a6-1de7f715683d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:26:07', ':get', '/getShopShares/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399533967328');
INSERT INTO `e_log` VALUES ('4c846a15-4822-4468-ad4f-e5375f1d2ddb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:15:29', ':post', '/updateShop', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :field \"desc\", :value \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E5%A4%A7%E5%93%81%E7%89%8C\", :fileNameList \"\"}', '1399454129593');
INSERT INTO `e_log` VALUES ('4cf133d3-a301-4787-9aa3-9d7e0095b712', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:46:04', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399531564406');
INSERT INTO `e_log` VALUES ('4d131017-8d08-4b90-a555-4099da01f4d3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:48:12', ':get', '/getShopsByDistance/40.073707/116.242451/2000/0', null, '1399607292203');
INSERT INTO `e_log` VALUES ('4d66f4bd-179a-4030-919b-1e849100d470', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:29:37', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606177390');
INSERT INTO `e_log` VALUES ('4e072192-5e31-4358-8cc8-9142d5644deb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:18', ':post', '/addSaleDiscuss', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"优惠多多\"}', '1399453518328');
INSERT INTO `e_log` VALUES ('4e9191e3-79f5-4842-bf87-b58ab91f6aec', null, '13651083480', '192.168.253.3', '2014-05-08 10:10:58', ':get', '/getSalesByChannel/0/-1', null, '1399515058921');
INSERT INTO `e_log` VALUES ('50bd734c-1778-4a9f-a4b8-7440232f52de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:01:45', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514494034.png\"}', '1399514505812');
INSERT INTO `e_log` VALUES ('50cddaa3-9928-4073-8e59-845ea67f7891', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:28:02', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399516082187');
INSERT INTO `e_log` VALUES ('511586b6-8078-4b8a-91d4-9a7db09bcef3', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:28', ':post', '/login', '{:phone \"13651083480\"}', '1399530808937');
INSERT INTO `e_log` VALUES ('514f3302-d6c7-42e6-a5f4-efda60550a01', null, '13651083480', '192.168.253.3', '2014-05-08 10:10:59', ':get', '/getSalesByChannel/1/1399515058984', null, '1399515059437');
INSERT INTO `e_log` VALUES ('51b07ba3-a1ce-4955-9fbc-93968a3c1c93', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:48:36', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528116515');
INSERT INTO `e_log` VALUES ('52477bfa-58f1-4357-a9fe-99281e86a511', null, '13651083480', '192.168.253.3', '2014-05-08 16:04:02', ':get', '/getSalesByChannel/1/1399533953296', null, '1399536242125');
INSERT INTO `e_log` VALUES ('524bf263-96d5-4b6f-8561-fbc67a22846c', null, '1', '192.168.253.3', '2014-05-08 16:06:31', ':post', '/login', '{:phone \"1\"}', '1399536391890');
INSERT INTO `e_log` VALUES ('528d48cd-5171-40c7-9710-b87dcf267333', null, '13651083480', '192.168.253.3', '2014-05-08 09:55:01', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514097772.png\"}', '1399514101687');
INSERT INTO `e_log` VALUES ('529dfd4f-6048-489d-b485-a4ba59e7ccf7', null, '1', '192.168.253.3', '2014-05-09 11:31:10', ':post', '/login', '{:phone \"1\"}', '1399606270281');
INSERT INTO `e_log` VALUES ('5352126d-5d4a-4d96-bb57-d789d90d1d20', null, '1', '192.168.253.3', '2014-05-09 08:42:02', ':post', '/login', '{:phone \"1\"}', '1399596122859');
INSERT INTO `e_log` VALUES ('53955808-4f8a-43e3-88d7-58d59cc2924d', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:20', ':get', '/getModules/discover', null, '1399595540578');
INSERT INTO `e_log` VALUES ('53cd162b-44b1-4202-814c-9b84df1b961e', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870421');
INSERT INTO `e_log` VALUES ('54a583f8-dcbf-4c35-8c6b-3c1ed66b297f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:40:13', ':post', '/searchShops', '{:search-word \"上\"}', '1399516813812');
INSERT INTO `e_log` VALUES ('54b95d20-e9ec-4c26-8123-e0f45c574c9a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:48:46', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399513645372.png\"}', '1399513726203');
INSERT INTO `e_log` VALUES ('55e0cdd9-e322-4354-ad46-fd85f3a7923b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:24:34', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399533874328');
INSERT INTO `e_log` VALUES ('56413cba-29de-439d-be3a-c1afab16ea86', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:04', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528324921');
INSERT INTO `e_log` VALUES ('5660bbc9-f474-4602-9a09-97311b40097a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:28:15', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399512495984');
INSERT INTO `e_log` VALUES ('568dc2ed-1c4f-410f-95ef-125e3fa68cae', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:10:15', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536615843');
INSERT INTO `e_log` VALUES ('56e0dd1e-9a2f-4012-97b4-46534db34ee0', null, '13651083480', '192.168.253.3', '2014-05-08 11:28:32', ':post', '/login', '{:phone \"13651083480\"}', '1399519712140');
INSERT INTO `e_log` VALUES ('57495c3e-d9eb-4959-a4a3-518566f7824a', null, '13651083480', '192.168.253.3', '2014-05-07 17:13:39', ':post', '/login', '{:phone \"13651083480\"}', '1399454019968');
INSERT INTO `e_log` VALUES ('589b555d-79ea-4901-9d79-f98dd37c0423', null, '13651083480', '192.168.253.3', '2014-05-07 17:48:34', ':post', '/login', '{:phone \"13651083480\"}', '1399456114203');
INSERT INTO `e_log` VALUES ('58fc1eef-81f9-4f82-986f-c3e103c7c449', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:44:22', ':post', '/createShopBarcode', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399513462984');
INSERT INTO `e_log` VALUES ('59a88e49-0e6d-402f-bead-e3c79d0369c7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:49', ':get', '/getSalesByChannel/1/1399452889671', null, '1399452889968');
INSERT INTO `e_log` VALUES ('59c61822-9bca-48dc-886f-d0bf4ddf7f61', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:58', ':post', '/login', '{:phone \"13651083480\"}', '1399450738156');
INSERT INTO `e_log` VALUES ('59de5d42-18f7-4ae1-9bdc-3036058a3562', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:31', ':get', '/getSalesByChannel/0/1399448759234', null, '1399449031968');
INSERT INTO `e_log` VALUES ('5a547d2b-8b65-4a19-b99e-55d0a4eade6a', null, null, '192.168.253.3', '2014-05-08 10:26:37', ':get', '/getImageFile/barcode_-509784425_1399515996656.png', null, '1399515997578');
INSERT INTO `e_log` VALUES ('5ab1c185-70a9-4b51-8149-9c0c1196b757', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:54', ':get', '/getShopsByDistance/40.073736/116.242445/2000/0', null, '1399448694828');
INSERT INTO `e_log` VALUES ('5abc8afa-c80b-436e-a440-460b1a5c3957', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:10:16', ':put', '/updateUserPwd', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399511416812');
INSERT INTO `e_log` VALUES ('5ae1f378-6a6e-4341-9e65-10ea60b94a84', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:35', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399446575765');
INSERT INTO `e_log` VALUES ('5b026942-0340-427f-8a7f-2c01dce7ce1e', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:25', ':post', '/login', '{:phone \"13651083480\"}', '1399446445015');
INSERT INTO `e_log` VALUES ('5b6799b9-258f-49c2-8a4b-a76c715a2ca9', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:31:47', ':post', '/saveShare', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :content \"%E4%B9%B0%E7%9A%84%E7%94%B5%E8%84%91%E5%BE%88%E4%BC%98%E6%83%A0%EF%BC%8C%E5%BA%97%E5%91%98%E6%9C%8D%E5%8A%A1%E5%A5%BD%E3%80%82\", :fileNameList \"\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399606307515');
INSERT INTO `e_log` VALUES ('5b84052c-bfd3-45d0-b93b-d4796e19c120', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:35:23', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606523984');
INSERT INTO `e_log` VALUES ('5cf6aa37-cb47-4e3c-abf2-89384a1ace35', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:22:12', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399519332578');
INSERT INTO `e_log` VALUES ('5cf8b111-ed5a-44a6-8a1d-5f00f859bd9f', null, null, '192.168.253.3', '2014-05-08 10:07:56', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514876375');
INSERT INTO `e_log` VALUES ('5d271948-5ea9-4da6-b4f0-b2e75943ae44', null, '13651083480', '192.168.253.3', '2014-05-09 11:45:27', ':get', '/getSalesByChannel/0/-1', null, '1399607127406');
INSERT INTO `e_log` VALUES ('5d38e289-9c05-4c46-86e4-b3e46f5cec43', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:42:12', ':post', '/searchShops', '{:search-word \"上\"}', '1399516932734');
INSERT INTO `e_log` VALUES ('5d45eabf-4800-4ae6-a20d-f74a63214ac0', null, null, '192.168.253.3', '2014-05-08 10:07:55', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514875984');
INSERT INTO `e_log` VALUES ('5d74f66a-20e2-4091-9e2a-cd4dac4b2a16', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:28:17', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606097812');
INSERT INTO `e_log` VALUES ('5da59749-b678-4b2e-8d20-2e2c65bbd7ea', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:26:05', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605965390');
INSERT INTO `e_log` VALUES ('5db04152-de07-4ddd-86d7-0d2a32a8d1f6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:31', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453411437');
INSERT INTO `e_log` VALUES ('5dd4d46b-b415-47cb-b9b1-f44a7110be91', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:09:58', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511398734');
INSERT INTO `e_log` VALUES ('5dfc6c55-2147-4325-8e72-9a0cc08f36d4', null, null, '192.168.253.3', '2014-05-08 09:05:33', ':get', '/getImageFile/834375879_1399511048951.png', null, '1399511133703');
INSERT INTO `e_log` VALUES ('5e9e3594-8871-4884-acd5-a2a27e086455', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:22:07', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399515727156');
INSERT INTO `e_log` VALUES ('5ef8cbb2-57ea-488c-a746-f8a8d78542a0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:09:31', ':put', '/updateUserPwd', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399511371640');
INSERT INTO `e_log` VALUES ('5f717df1-0460-47ab-80da-a69eff2a2b10', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:43:55', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :fileNameList \"\"}', '1399455835390');
INSERT INTO `e_log` VALUES ('5f99772d-6ccc-4dca-85df-ecc9030f211d', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:32', ':get', '/getSalesByChannel/1/1399449032031', null, '1399449032468');
INSERT INTO `e_log` VALUES ('5fdec4c8-cbae-4aa5-b6e1-f62bf9af8058', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:08', ':get', '/getSalesByChannel/1/1399446608109', null, '1399446608468');
INSERT INTO `e_log` VALUES ('5ff521f5-7c82-47cd-bf74-412930ed5c26', null, '13651083480', '192.168.253.3', '2014-05-08 15:24:33', ':post', '/login', '{:phone \"13651083480\"}', '1399533873765');
INSERT INTO `e_log` VALUES ('6027fab1-95a1-43cb-886f-9c88ec8c66fd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:08:31', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511311843');
INSERT INTO `e_log` VALUES ('611e93e2-9890-41ff-9f28-7df4859d15c5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:10:48', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D%EF%BC%8C%E6%AC%A2%E8%BF%8E%E5%85%89%E4%B8%B4%E3%80%82\", :fileNameList \"\"}', '1399511448453');
INSERT INTO `e_log` VALUES ('6133bd8f-d209-44f8-a22a-93b9c1b2c5bb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:04:17', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536257421');
INSERT INTO `e_log` VALUES ('6197a5e8-f6b4-4997-bb9f-c573021e98c2', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284859');
INSERT INTO `e_log` VALUES ('61a03aee-6641-452f-8f38-cdcf6fb5abac', null, '13651083480', '192.168.253.3', '2014-05-08 14:38:00', ':post', '/login', '{:phone \"13651083480\"}', '1399531080968');
INSERT INTO `e_log` VALUES ('61b8ee38-01fb-4ad5-bc39-6e7dbed88b8f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:00', ':get', '/getSalesByDistance/40.073712/116.242458/2000/0', null, '1399453620437');
INSERT INTO `e_log` VALUES ('61c58eb3-ab27-4b2b-b1c7-57d1160ea6a8', null, '13651083480', '192.168.253.3', '2014-05-09 08:33:44', ':post', '/login', '{:phone \"13651083480\"}', '1399595624515');
INSERT INTO `e_log` VALUES ('627adfc3-1ad6-47d2-acc2-dfda5d1c1eb6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:22:58', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605778796');
INSERT INTO `e_log` VALUES ('63098214-73f1-4fb5-aeb2-610d5c644c19', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:13', ':get', '/getShopsByDistance/40.073715/116.242448/2000/0', null, '1399517053828');
INSERT INTO `e_log` VALUES ('63277896-f782-416b-a0c8-b48f975519f3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:26:03', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605963765');
INSERT INTO `e_log` VALUES ('63c34ea3-3254-4b26-80f0-661be40fa60a', null, '13651083480', '192.168.253.3', '2014-05-08 10:52:52', ':post', '/login', '{:phone \"13651083480\"}', '1399517572890');
INSERT INTO `e_log` VALUES ('63f11ae8-94d5-42d7-a29e-8ef98647c9ab', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:07', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607227578');
INSERT INTO `e_log` VALUES ('64301921-b72f-481a-bcd8-49523559cd42', null, '13651083480', '192.168.253.3', '2014-05-08 09:27:51', ':get', '/getChannels', null, '1399512471125');
INSERT INTO `e_log` VALUES ('643791d7-7886-4f87-aaf0-7528f3a20377', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:41:29', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D%EF%BC%8C%E6%AC%A2%E8%BF%8E%E3%80%82\", :fileNameList \"\"}', '1399513289375');
INSERT INTO `e_log` VALUES ('655a6451-521b-40d2-b8e6-ea4e010275d2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:38:40', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399603120031');
INSERT INTO `e_log` VALUES ('657c5123-1edb-4db2-ad7b-705f33a84291', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:34', ':get', '/getSalesByChannel/1/1399450953734', null, '1399450954093');
INSERT INTO `e_log` VALUES ('661d92a3-0884-4f65-86f2-d2f0c7cf2bb1', null, null, '192.168.253.3', '2014-05-08 10:10:25', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399515025515');
INSERT INTO `e_log` VALUES ('6796e24d-d045-4b23-9075-ae33eeb70c64', null, '13651083480', '192.168.253.3', '2014-05-08 11:40:51', ':post', '/login', '{:phone \"13651083480\"}', '1399520451156');
INSERT INTO `e_log` VALUES ('67bf0954-f6eb-404c-927a-326f57db4f38', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:14', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399449254546');
INSERT INTO `e_log` VALUES ('67dc88a5-9c96-400b-8fe0-c5f7a8376523', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:40', ':post', '/searchShops', '{:search-word \"上\"}', '1399452940171');
INSERT INTO `e_log` VALUES ('6835c339-59f9-48d8-860e-56f1cf56932b', null, '1', '192.168.253.3', '2014-05-09 11:34:08', ':post', '/login', '{:phone \"1\"}', '1399606448750');
INSERT INTO `e_log` VALUES ('694501a2-9594-4547-b97a-932226016bd8', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:36:14', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606574015');
INSERT INTO `e_log` VALUES ('6997a88e-f40f-4a23-808d-d1440307c248', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:42', ':post', '/login', '{:phone \"13651083480\"}', '1399449042015');
INSERT INTO `e_log` VALUES ('6a0c3c31-5687-4333-bf60-d251be2b56d6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:46:49', ':get', '/getModules/me', null, '1399607209343');
INSERT INTO `e_log` VALUES ('6a0c98b0-93fc-4745-88fd-1cc8cf02b6c9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:48:34', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399456114656');
INSERT INTO `e_log` VALUES ('6a0f1966-edc5-4a2a-9f94-816679f0bbe4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:46:40', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520800156');
INSERT INTO `e_log` VALUES ('6a24379c-88f2-4bfd-98cc-55077f9de6cb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:11:22', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536682750');
INSERT INTO `e_log` VALUES ('6a6ca85c-60a0-4786-b066-76bf09406ea2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:40:51', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520451593');
INSERT INTO `e_log` VALUES ('6a703fbd-1244-4c6d-ade0-8ce36501c09f', null, null, '192.168.253.1', '2014-05-07 16:30:39', ':get', '/aa', null, '1399451439578');
INSERT INTO `e_log` VALUES ('6a811cfb-dbda-4d39-b448-f00871ca0f2f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':get', '/getSalesByChannel/0/1399446405843', null, '1399446470546');
INSERT INTO `e_log` VALUES ('6b37caec-3eaf-4d31-b3ae-d01bd42ef27f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:00', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448700703');
INSERT INTO `e_log` VALUES ('6b8049d4-821f-4640-8a9b-e90f525496cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:57:28', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514244768.png\"}', '1399514248390');
INSERT INTO `e_log` VALUES ('6ba12d6c-aa65-43d8-92d9-01be7ccfd04a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:29:06', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399526946515');
INSERT INTO `e_log` VALUES ('6c7fc3b6-b6b0-4183-b5f1-0c0a0f51f7e7', null, null, '192.168.253.1', '2014-05-07 16:34:43', ':get', '/aa', null, '1399451683328');
INSERT INTO `e_log` VALUES ('6c8833f6-b980-4727-8ee5-b8955e385902', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 11:41:32', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520492796');
INSERT INTO `e_log` VALUES ('6e37e39e-e5dc-405c-ab68-b804b6b329b0', null, '13651083480', '192.168.253.3', '2014-05-08 09:27:56', ':get', '/getModules/me', null, '1399512476000');
INSERT INTO `e_log` VALUES ('6e875a17-afb4-496a-bcff-68f4aeb062fc', null, '13651083480', '192.168.253.3', '2014-05-07 16:48:04', ':post', '/login', '{:phone \"13651083480\"}', '1399452484906');
INSERT INTO `e_log` VALUES ('6ea2bea2-e0b1-4cea-84ef-197758e6bc42', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:08:27', ':get', '/getSalesByChannel/0/1399446470734', null, '1399446507546');
INSERT INTO `e_log` VALUES ('6eeaf8fe-1025-4a6b-bf0c-89cf648d5b0c', null, '1', '192.168.253.3', '2014-05-08 16:49:26', ':post', '/login', '{:phone \"1\"}', '1399538966843');
INSERT INTO `e_log` VALUES ('6f56985c-44dd-4964-8e83-bfe9fc61b5cb', null, '13651083480', '192.168.253.3', '2014-05-07 16:14:05', ':post', '/login', '{:phone \"13651083480\"}', '1399450445187');
INSERT INTO `e_log` VALUES ('6f65d46b-35c3-48c1-8bc5-2e996a7be784', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:39', ':get', '/getTrades', null, '1399449099765');
INSERT INTO `e_log` VALUES ('6fc6e6f0-5c30-4f80-be2c-a018627d675e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 11:41:47', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520507718');
INSERT INTO `e_log` VALUES ('6fd63d90-edca-4a43-b9f2-04acf8889512', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:28', ':get', '/getSalesByChannel/1/1399453348375', null, '1399453348671');
INSERT INTO `e_log` VALUES ('6fef8fef-c1ec-439d-a28b-888cb0fec3c4', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:43:57', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517037562');
INSERT INTO `e_log` VALUES ('6ffb9fcc-f86c-443c-8272-c595fd6752bb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:17', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399516757312');
INSERT INTO `e_log` VALUES ('7030640b-39d5-435b-9463-54b0a816228f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:47:16', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399520836328');
INSERT INTO `e_log` VALUES ('708e108a-5b86-42a6-b054-414539c10ea5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:19:57', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399601997031');
INSERT INTO `e_log` VALUES ('70c78bb3-2231-4929-85c4-949d4c5fb77b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:33', ':get', '/getSalesByChannel/0/1399453348703', null, '1399453353015');
INSERT INTO `e_log` VALUES ('710523a1-60ac-4a72-bfc8-bff91aba68d5', null, '1', '192.168.253.3', '2014-05-08 10:55:48', ':post', '/login', '{:phone \"1\"}', '1399517748234');
INSERT INTO `e_log` VALUES ('71d4b5da-396a-4bf3-8437-a0165b3871bb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:03:39', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511019015');
INSERT INTO `e_log` VALUES ('7261f77a-5909-43fc-bbdd-4de8b871f637', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:40:24', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399513224843');
INSERT INTO `e_log` VALUES ('740948a5-ca34-404d-bf69-7e75eaea460e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:41', ':get', '/getSaleFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607261500');
INSERT INTO `e_log` VALUES ('743db9f0-e186-486e-ad3a-f98a74d4771a', null, '1', '192.168.253.3', '2014-05-08 11:41:32', ':post', '/login', '{:phone \"1\"}', '1399520492484');
INSERT INTO `e_log` VALUES ('7492ca6e-3eae-4bff-96a3-736fa251937c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:38:29', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399516709375');
INSERT INTO `e_log` VALUES ('7500a62e-39c2-4dbc-aba5-b0898ef4c8d6', null, null, '192.168.253.3', '2014-05-07 16:58:46', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453126062');
INSERT INTO `e_log` VALUES ('752bc4f5-1caf-4f56-ae8e-e82d963629c9', null, '13651083480', '192.168.253.3', '2014-05-08 10:32:38', ':post', '/registerUser', '{:fileNameList \"\", :phone \"1\", :type \"1\", :name \"%E4%BE%9D%E4%BE%9D\"}', '1399516358765');
INSERT INTO `e_log` VALUES ('757eda53-dbb8-43d1-9983-8bd1eabe9a55', null, '13651083480', '192.168.253.3', '2014-05-08 09:03:36', ':post', '/login', '{:phone \"13651083480\"}', '1399511016343');
INSERT INTO `e_log` VALUES ('75d92cfd-cdcd-4e33-a513-3b01fe0c6b81', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:29:16', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399526956093');
INSERT INTO `e_log` VALUES ('767c6b37-2687-4ec5-bf47-c21ff9292ad6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:41:50', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399603310937');
INSERT INTO `e_log` VALUES ('768d68c0-86f6-4d6e-aeea-706ac3a4bf33', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:19:39', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450779140');
INSERT INTO `e_log` VALUES ('7693989e-7013-450e-a501-968058200a85', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:38:38', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399595918109');
INSERT INTO `e_log` VALUES ('772d9e9d-fbcc-4852-bd26-b50ddfccb109', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:13:27', ':get', '/getTrades', null, '1399511607000');
INSERT INTO `e_log` VALUES ('77d38d8c-65b3-4a98-87bc-6977cd30f8f6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:53:04', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/-1', null, '1399517584390');
INSERT INTO `e_log` VALUES ('77dddbc1-b0be-4c43-96d6-8a1ae16a0e33', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:43:26', ':get', '/getShopFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517006875');
INSERT INTO `e_log` VALUES ('77f315dc-338f-4a37-adab-5d368eb5b223', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:41:10', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E4%BC%98%E6%83%A0%E7%9C%9F%E5%A4%A7\", :fileNameList \"463517179_1399516848803.png%7C-104682932_1399516864279.png\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", \"463517179_1399516848803.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-213471294769942995.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399516848803.png\"}, \"-104682932_1399516864279.png\" {:size 50594, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2224820879666342011.tmp>, :content-type \"image/pjpeg\", :filename \"-104682932_1399516864279.png\"}}', '1399516870937');
INSERT INTO `e_log` VALUES ('7808da2c-bca7-4daf-afa5-6c9053ba9cdc', null, '13651083480', '192.168.253.3', '2014-05-07 15:17:00', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"%E4%BA%BA%E4%BA%BA\"}', '1399447020640');
INSERT INTO `e_log` VALUES ('79035535-c755-4dc7-83d5-a31613ab4abe', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780312');
INSERT INTO `e_log` VALUES ('7913c194-0273-4c4d-8af5-082144f51e6c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:13:51', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536831140');
INSERT INTO `e_log` VALUES ('7936af6d-6ca6-494a-b28e-528dd40691d6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:53:58', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399528438171');
INSERT INTO `e_log` VALUES ('79732c4d-927c-48a8-af02-ca7485d57c9e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:01:12', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399514472156');
INSERT INTO `e_log` VALUES ('799bf7df-97b1-479c-bd48-c9f05498b2f5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:45:25', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"name\", :value \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E1\", :fileNameList \"\"}', '1399513525593');
INSERT INTO `e_log` VALUES ('79a06487-fc30-4e74-9a32-8a4577002c4d', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:22:22', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605742734');
INSERT INTO `e_log` VALUES ('79c6026d-9362-4e91-ab0d-2bdeb0d6b369', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:17', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453637250');
INSERT INTO `e_log` VALUES ('79fb53f8-e428-45fa-94c0-0018bf2bf0a6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:31:32', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399527092109');
INSERT INTO `e_log` VALUES ('7a18794a-7275-457c-9cbd-4e23412605f3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:44', ':put', '/cancelSale', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\"}', '1399528364843');
INSERT INTO `e_log` VALUES ('7a2e479e-d1d6-4d44-bf3a-291ae11ce21a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:13:26', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399511606046');
INSERT INTO `e_log` VALUES ('7a2f6967-ce5b-4635-bcf2-34f6f6a6519b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:33', ':get', '/getSalesByChannel/0/1399450447187', null, '1399450953703');
INSERT INTO `e_log` VALUES ('7a505088-693d-4b30-9c6f-ceb0cd9d9c47', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:50', ':post', '/addSaleDiscuss', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"优惠多多\"}', '1399453430421');
INSERT INTO `e_log` VALUES ('7a52967d-7611-44f2-aeff-b20171114295', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:31:10', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606270750');
INSERT INTO `e_log` VALUES ('7b0326d0-5e56-4442-b118-234ee6db0daa', null, '13651083480', '192.168.253.3', '2014-05-08 09:09:58', ':post', '/login', '{:phone \"13651083480\"}', '1399511398234');
INSERT INTO `e_log` VALUES ('7c079c84-4307-4d86-84ea-55194df7101d', null, null, '192.168.253.3', '2014-05-08 10:41:12', ':get', '/getImageFile/463517179_1399516848803.png', null, '1399516872000');
INSERT INTO `e_log` VALUES ('7c33e912-4d89-4ea4-910d-e27a18da42c0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:47:38', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399528058984');
INSERT INTO `e_log` VALUES ('7d66eca7-17f0-41e0-a0dc-66a3b7740334', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:12', ':get', '/getSalesByDistance/40.073715/116.242448/2000/0', null, '1399517052125');
INSERT INTO `e_log` VALUES ('7d881f53-8504-4fa5-8a4e-eece80bb17e5', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:08', ':get', '/getSalesByChannel/0/1399446577046', null, '1399446608031');
INSERT INTO `e_log` VALUES ('7dbd9350-fa06-4f7b-bcd0-19b759c34a3d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:08:03', ':post', '/updateShop', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :field \"desc\", :value \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E5%A4%A7%E5%93%81%E7%89%8C\", :fileNameList \"\"}', '1399453683718');
INSERT INTO `e_log` VALUES ('7dff29cf-1f8d-4946-8336-4b62662c040b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:44:00', ':put', '/updateShopTrades', '{:tradeList \"41|42\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399513440734');
INSERT INTO `e_log` VALUES ('7e1f616c-b3ee-46ef-adbf-2ea3f326e10c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:51', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399607271343');
INSERT INTO `e_log` VALUES ('7ee507ea-2f19-4bba-9745-86aaa66c5d14', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:32', ':get', '/getSalesByChannel/0/1399448576921', null, '1399448672296');
INSERT INTO `e_log` VALUES ('7ef51083-7540-42f9-9d12-2b85f88ee47a', null, '13651083480', '192.168.253.3', '2014-05-07 16:23:18', ':post', '/login', '{:phone \"13651083480\"}', '1399450998015');
INSERT INTO `e_log` VALUES ('7f49b047-2931-47f6-aea0-f389b5a7b72d', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:20', ':get', '/getSettings', null, '1399446380453');
INSERT INTO `e_log` VALUES ('80967f34-a3a0-409b-988f-c390f93c30cc', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:34:10', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399602850046');
INSERT INTO `e_log` VALUES ('80c786f6-37f4-4ca9-af78-8f43b177198d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:53:58', ':get', '/getSalesByShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399521085218', null, '1399521238812');
INSERT INTO `e_log` VALUES ('822a47d1-7611-423a-867d-c82f90cdbef4', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:13', ':get', '/getSalesByChannel/1/1399530793359', null, '1399530793843');
INSERT INTO `e_log` VALUES ('833dd651-f77a-499e-bb6b-a9ce0f8ba361', null, '13651083480', '192.168.253.3', '2014-05-07 15:16:33', ':get', '/getSalesByChannel/0/1399446608500', null, '1399446993046');
INSERT INTO `e_log` VALUES ('833e771d-6fdb-4e1f-b083-15cae12a6bb5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:31', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399448671234');
INSERT INTO `e_log` VALUES ('8422d120-7f09-44ce-b260-d8a977e2b7f0', null, '13651083480', '192.168.253.3', '2014-05-08 10:22:50', ':post', '/login', '{:phone \"13651083480\"}', '1399515770578');
INSERT INTO `e_log` VALUES ('845a7bd7-a845-4f77-9f8a-fc6d8e313764', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:26', ':post', '/registerUser', '{:fileNameList \"13651083480_1399446443410.png\", :phone \"13651083480\", :type \"1\", :photo \"13651083480_1399446443410.png\", :name \"%E5%A6%9E%E5%A6%9E\", \"13651083480_1399446443410.png\" {:size 46837, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7366176588694513618.tmp>, :content-type \"image/pjpeg\", :filename \"13651083480_1399446443410.png\"}}', '1399446446046');
INSERT INTO `e_log` VALUES ('845d172c-a4f6-40da-84c3-e22c58a38023', null, '1', '192.168.253.3', '2014-05-09 11:28:15', ':post', '/login', '{:phone \"1\"}', '1399606095812');
INSERT INTO `e_log` VALUES ('84642af6-aa5d-447c-89a0-684194c6481f', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:56', ':get', '/getSalesByChannel/1/1399448575968', null, '1399448576890');
INSERT INTO `e_log` VALUES ('84f12ad7-59e2-4e9a-9774-96243c838bf1', null, null, '192.168.253.3', '2014-05-08 09:24:10', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512250171');
INSERT INTO `e_log` VALUES ('84f74b1e-612e-413e-a967-d7c5d5d0cea1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:10:32', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450232343');
INSERT INTO `e_log` VALUES ('85180f01-66f6-4c0f-8735-755eb6f6f0bc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:05', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399595645546');
INSERT INTO `e_log` VALUES ('851efe21-4a86-4b74-996f-620bf843fc33', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:49:31', ':get', '/getSettings', null, '1399538971640');
INSERT INTO `e_log` VALUES ('853a20eb-33cc-4c6a-854d-4bedee37546e', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:03', ':get', '/getChannels', null, '1399446363593');
INSERT INTO `e_log` VALUES ('85683f3a-3122-44d4-aaae-dc2d0a476274', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:42', ':get', '/getSalesByChannel/0/1399449032515', null, '1399449042921');
INSERT INTO `e_log` VALUES ('86870d36-d8a1-4f2d-a5a7-6d65dbf8bf61', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:51', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516757375', null, '1399516791343');
INSERT INTO `e_log` VALUES ('86a7d40d-b181-403a-9aa9-19a5f2e8fc4e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:37:32', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399603052515');
INSERT INTO `e_log` VALUES ('8739bb2a-ab31-4c1c-8e64-60366a832fd8', null, '13651083480', '192.168.253.3', '2014-05-07 15:43:31', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"222\"}', '1399448611484');
INSERT INTO `e_log` VALUES ('8794b804-6c5a-4c35-9f7d-33960ec0d044', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:14', ':post', '/addSale', '{:content \"%E5%85%A8%E5%9C%BA%E6%B1%89%E5%A0%A1%E4%B9%B0%E4%B8%80%E9%80%81%E4%B8%80\", :end_date \"1401465600000\", \"50489896_1399453226535.png\" {:size 228877, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2626007887600820125.tmp>, :content-type \"image/pjpeg\", :filename \"50489896_1399453226535.png\"}, :fileNameList \"50489896_1399453226535.png\", :title \"%E4%BA%94%E6%9C%88%E4%BC%98%E6%83%A0%E5%A4%A7%E6%94%BE%E9%80%81\", :trade_id \"1\", :start_date \"1398873600000\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453274984');
INSERT INTO `e_log` VALUES ('87a942d2-3b3d-4193-a15a-18159dffa08d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:41', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453301359');
INSERT INTO `e_log` VALUES ('87b2d814-dacd-438e-8c7e-9f0e9f1fe4f1', null, null, '192.168.253.3', '2014-05-08 10:41:12', ':get', '/getImageFile/-104682932_1399516864279.png', null, '1399516872000');
INSERT INTO `e_log` VALUES ('87d9f409-a37a-4047-a79f-3916f4b034b9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:52', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453132406');
INSERT INTO `e_log` VALUES ('8954d480-fad5-4458-a757-c351013cb0ca', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:37', ':get', '/getChannels', null, '1399533937812');
INSERT INTO `e_log` VALUES ('89dac233-0337-4b81-92e1-7d307c64dd1f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:37', ':get', '/getSalesByChannel/3/1399521454796', null, '1399521457546');
INSERT INTO `e_log` VALUES ('8a588999-243d-44da-a7f9-5136a27aff9e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:29', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399451009109');
INSERT INTO `e_log` VALUES ('8b4ff1fe-9957-4b59-acfa-653fc0a9ffd6', null, '1', '192.168.253.3', '2014-05-09 11:29:33', ':post', '/login', '{:phone \"1\"}', '1399606173578');
INSERT INTO `e_log` VALUES ('8bf18cce-06d0-43bf-8766-1397a52cbebe', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:51:15', ':get', '/getSalesByChannel/1/1399538967328', null, '1399539075765');
INSERT INTO `e_log` VALUES ('8c57173f-e258-40c3-8a78-5c55653bdd53', null, '13651083480', '192.168.253.3', '2014-05-07 16:39:45', ':post', '/login', '{:phone \"13651083480\"}', '1399451985312');
INSERT INTO `e_log` VALUES ('8c6f2412-c4e3-44f3-8489-c72e9ef3976a', null, '1', '192.168.253.3', '2014-05-08 16:11:22', ':post', '/login', '{:phone \"1\"}', '1399536682468');
INSERT INTO `e_log` VALUES ('8ccd218d-3640-4419-912d-81db8298685b', null, '1', '192.168.253.3', '2014-05-09 10:34:06', ':post', '/login', '{:phone \"1\"}', '1399602846859');
INSERT INTO `e_log` VALUES ('8d1d36dd-237a-44c8-a954-f0cd8fb92e4b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:30', ':get', '/getSalesByChannel/1/1399530799656', null, '1399530810796');
INSERT INTO `e_log` VALUES ('8d239c9b-e91b-4bdc-b514-50ab70eb6ab2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:47:00', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520820609');
INSERT INTO `e_log` VALUES ('8eb93119-faa5-4278-bcf1-b1a771e5e907', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:50:12', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399456212750');
INSERT INTO `e_log` VALUES ('8ed066b0-7e13-42d3-bb25-755b533cc70e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:52', ':get', '/getSettings', null, '1399448692171');
INSERT INTO `e_log` VALUES ('8f17752e-da96-44c9-ae82-b9cf1826e63f', null, null, '192.168.253.3', '2014-05-08 09:57:03', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514223890');
INSERT INTO `e_log` VALUES ('8f98c5d4-df2e-4f98-b905-40f78f75d6de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:31', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453531093');
INSERT INTO `e_log` VALUES ('904ab94f-6f17-4e55-a0cf-617ef3b5f31a', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780125');
INSERT INTO `e_log` VALUES ('90881ee6-fff2-49b2-8ddb-1143a6fd47a7', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:43', ':post', '/login', '{:phone \"13651083480\"}', '1399446643296');
INSERT INTO `e_log` VALUES ('911c99c0-2d14-40b9-a370-83698a557a34', null, null, '192.168.253.3', '2014-05-08 09:55:03', ':get', '/getImageFile/-810116522_1399514097772.png', null, '1399514103000');
INSERT INTO `e_log` VALUES ('9192a327-0878-46f5-9768-d749aa6184cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:31:34', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399527094015');
INSERT INTO `e_log` VALUES ('9291175a-eeba-4530-86a3-9192d6fb1b9c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:18:59', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450736650.png\", \"463517179_1399450736650.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-6386821006836686561.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450736650.png\"}, :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242447%2C%22radius%22%3A39.31818389892578%2C%22latitude%22%3A40.073715%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450736650.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450739031');
INSERT INTO `e_log` VALUES ('92c80bbd-f87c-4c44-95b8-2aed0ba273a2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:11', ':get', '/getModules/discover', null, '1399516751968');
INSERT INTO `e_log` VALUES ('92df0aad-c508-49d4-801e-ac49af3fe6ba', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:45:45', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399520745406');
INSERT INTO `e_log` VALUES ('93021c0e-ee30-43f2-998e-556db4d4f850', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:52', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399452952421');
INSERT INTO `e_log` VALUES ('934f45b6-e63e-4116-94b2-bfc5b7ebe086', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:22', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607242703');
INSERT INTO `e_log` VALUES ('935b3306-d0a6-4dfd-a266-205185f62e5d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:59', ':get', '/getSalesByChannel/1/1399448758515', null, '1399448759171');
INSERT INTO `e_log` VALUES ('93628f2c-1037-49b8-adce-9b3f69cabd48', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:59', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"妞妞\"}', '1399449059484');
INSERT INTO `e_log` VALUES ('9487d840-a498-4d94-b6f1-52685b743983', null, null, '192.168.253.1', '2014-05-07 16:31:20', ':get', '/aa', null, '1399451480281');
INSERT INTO `e_log` VALUES ('94f55592-5a11-414c-9acf-8b415473822b', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780531');
INSERT INTO `e_log` VALUES ('954eb7aa-caa8-47b8-b86d-6114783cfdce', null, '13651083480', '192.168.253.3', '2014-05-08 09:13:05', ':get', '/getSalesByChannel/1/1399511585484', null, '1399511585937');
INSERT INTO `e_log` VALUES ('9582b7a4-07a9-48b3-8800-b0320c26614e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:29', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399530809906');
INSERT INTO `e_log` VALUES ('95de4614-a955-4907-a262-8df5b3b04a79', null, '13651083480', '192.168.253.3', '2014-05-07 16:11:12', ':post', '/login', '{:phone \"13651083480\"}', '1399450272234');
INSERT INTO `e_log` VALUES ('9665b07e-ce90-45d5-b460-42b250922cc4', null, '13651083480', '192.168.253.3', '2014-05-07 16:39:03', ':post', '/login', '{:phone \"13651083480\"}', '1399451943312');
INSERT INTO `e_log` VALUES ('967db682-be0b-4858-901b-fc3b1484f187', null, '13651083480', '192.168.253.3', '2014-05-08 09:13:03', ':get', '/getChannels', null, '1399511583968');
INSERT INTO `e_log` VALUES ('977f6533-7037-476f-9345-34e4c6f89ec7', null, '13651083480', '192.168.253.3', '2014-05-08 11:53:51', ':post', '/login', '{:phone \"13651083480\"}', '1399521231437');
INSERT INTO `e_log` VALUES ('97f6f45e-1331-4f01-9c22-8441c19f6ae6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:27:40', ':get', '/getShopShares/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399516060359');
INSERT INTO `e_log` VALUES ('98953654-70f3-47ac-9a98-f4ebd63888a0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 11:33:24', ':post', '/saveShareReply', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :share_id \"eb7cd9e8-f6ad-4445-a2d6-3609f01da1c7\", :grade \"5\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎惠顾\"}', '1399606404203');
INSERT INTO `e_log` VALUES ('992015fb-b8ca-4510-a783-4a50d68a2d47', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:13:16', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511596515');
INSERT INTO `e_log` VALUES ('992f2541-1dfb-45da-b02f-b6f810d53f4f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:42:50', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399516970312');
INSERT INTO `e_log` VALUES ('99f00e38-264b-4164-b2c9-afc1e0dc9eba', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:35', ':post', '/login', '{:phone \"13651083480\"}', '1399446575203');
INSERT INTO `e_log` VALUES ('9b291bcf-2f3c-4d87-9aab-63e25e2d7161', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:11:01', ':put', '/updateShopTrades', '{:tradeList \"41|42|40\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399511461062');
INSERT INTO `e_log` VALUES ('9b31e8e9-abd3-410d-9aa0-8390feef1e6f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:52:53', ':post', '/searchUsers', '{:search-word \"1\"}', '1399517573328');
INSERT INTO `e_log` VALUES ('9b39d492-066f-49f7-adc1-d131147f7566', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:53:05', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528385578');
INSERT INTO `e_log` VALUES ('9b4f0461-c3ba-48a9-88a0-f29a241d8515', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:38:42', ':post', '/addSaleDiscuss', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :content \"非常不错啊\"}', '1399516722671');
INSERT INTO `e_log` VALUES ('9b63461e-38f6-4c52-9ed7-ddb15388f2ca', null, null, '192.168.253.3', '2014-05-08 09:54:14', ':get', '/getImageFile/-810116522_1399514042943.png', null, '1399514054296');
INSERT INTO `e_log` VALUES ('9c2faa0c-5ea5-4503-8f48-ab978379ffc0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:23:29', ':post', '/updateShop', '{:value \"专卖电脑和书籍，欢迎惠顾。\", :field \"desc\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399515809765');
INSERT INTO `e_log` VALUES ('9d5f9cc7-f45b-4a10-85f6-365da5019bc5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:38', ':get', '/getSalesByChannel/2/1399521457609', null, '1399521458046');
INSERT INTO `e_log` VALUES ('9d6a7841-b562-4617-b239-45e2d3cc8fb7', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':post', '/login', '{:phone \"13651083480\"}', '1399446470312');
INSERT INTO `e_log` VALUES ('9dd1f966-c30c-44dd-9dcd-3fbc8e83d394', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:57', ':post', '/login', '{:phone \"13651083480\"}', '1399448757062');
INSERT INTO `e_log` VALUES ('9e4d963b-a97b-457f-9d83-911c1c1e1a40', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:56:53', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399514213640');
INSERT INTO `e_log` VALUES ('9ffe5752-59db-4a2c-b035-56bf7a1f60d3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:09:41', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536581562');
INSERT INTO `e_log` VALUES ('a0012b25-5ba9-4fbb-a19c-5a86f85efe63', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:40:57', ':get', '/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399596057656');
INSERT INTO `e_log` VALUES ('a070b7cc-89b8-4cdb-9d9b-3a9e8d78bccd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:56:11', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516795859', null, '1399517771765');
INSERT INTO `e_log` VALUES ('a0942cee-325c-4650-b99c-ab647aae4694', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:53:40', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399517620812');
INSERT INTO `e_log` VALUES ('a0b856c1-94ad-4ef1-a829-c5ff32023901', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:05', ':get', '/getSalesByChannel/0/-1', null, '1399446365015');
INSERT INTO `e_log` VALUES ('a12d13b6-b53b-4943-86fb-ef7ab795dfa6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:03', ':get', '/getSalesByChannel/1/1399539075843', null, '1399595523421');
INSERT INTO `e_log` VALUES ('a131db62-7e62-45bc-a659-c042433831e2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:56:09', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399456569203');
INSERT INTO `e_log` VALUES ('a1a43abd-93d4-443b-8993-147d9ddb580f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:57:13', ':get', '/getShopsByDistance/40.073701/116.242454/2000/0', null, '1399528633968');
INSERT INTO `e_log` VALUES ('a1e5f3cb-a11f-4268-bb5f-e9354bd12f2e', null, '1', '192.168.253.3', '2014-05-08 16:51:15', ':post', '/login', '{:phone \"1\"}', '1399539075250');
INSERT INTO `e_log` VALUES ('a2341395-afbc-498c-a222-cda4a16e67b9', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:04:18', ':get', '/getSalesByChannel/1/1399536242281', null, '1399536258656');
INSERT INTO `e_log` VALUES ('a2bb5742-6961-42d8-9a8b-0c8ffffd4a5c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:49:35', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D%EF%BC%8C%E6%AC%A2%E8%BF%8E%E3%80%82\", :fileNameList \"\"}', '1399456175968');
INSERT INTO `e_log` VALUES ('a30b8f1c-cfe0-4a57-82f5-fb2b7726998b', null, '13651083480', '192.168.253.3', '2014-05-09 11:45:27', ':get', '/getSalesByChannel/1/1399607127421', null, '1399607127859');
INSERT INTO `e_log` VALUES ('a3c5f7bc-9e46-4a79-9ae3-bada1f235b56', null, '13651083480', '192.168.253.3', '2014-05-07 15:16:33', ':get', '/getSalesByChannel/1/1399446993109', null, '1399446993390');
INSERT INTO `e_log` VALUES ('a4c887b6-7a21-4e26-832c-7cfc2d0e74ab', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:36', ':get', '/getSalesByChannel/0/1399446554718', null, '1399446576500');
INSERT INTO `e_log` VALUES ('a5568d57-51aa-4163-baa7-a0cc727c65ca', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:40', ':get', '/getShopShares/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399595675734', null, '1399595680156');
INSERT INTO `e_log` VALUES ('a60262b1-8bf1-40c2-811a-30f9a7195f6e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:52', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528372640');
INSERT INTO `e_log` VALUES ('a6217e4c-14da-4768-8084-69d41c5026e0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:10', ':get', '/getSalesByChannel/0/1399453353109', null, '1399453390390');
INSERT INTO `e_log` VALUES ('a681ce9e-591e-467b-9bc6-e9beb0983074', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:13', ':get', '/getSalesByChannel/0/-1', null, '1399530793281');
INSERT INTO `e_log` VALUES ('a6875a7f-811e-4b50-8c2d-cf1a219e6752', null, '13651083480', '192.168.253.3', '2014-05-08 14:39:29', ':post', '/login', '{:phone \"13651083480\"}', '1399531169000');
INSERT INTO `e_log` VALUES ('a6ea8024-d4cb-4068-a9e7-6b3830388a1a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:22:08', ':get', '/getTrades', null, '1399512128156');
INSERT INTO `e_log` VALUES ('a71aef3a-56d5-46f9-8239-62fc0a5de451', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:49:27', ':get', '/getSalesByChannel/1/1399538924421', null, '1399538967296');
INSERT INTO `e_log` VALUES ('a773d0f5-f412-476d-aa2f-552c108c04c2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:45:45', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607145750');
INSERT INTO `e_log` VALUES ('a7dd4243-6662-40d8-b909-8303e13ea10e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:02', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399595642531');
INSERT INTO `e_log` VALUES ('a803924a-0c65-4e89-b0cb-4e221ef411d3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:28:16', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606096265');
INSERT INTO `e_log` VALUES ('a8ea01fa-5bf2-4401-b709-102ba9839d9f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:51:58', ':post', '/registerShop', '{\"1259860143_1399452716068.png\" {:size 68674, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3820336725498127850.tmp>, :content-type \"image/pjpeg\", :filename \"1259860143_1399452716068.png\"}, :desc \"%E6%AC%A2%E8%BF%8E%E5%85%89%E4%B8%B4\", :shop_img \"1259860143_1399452716068.png\", :name \"%E4%B8%BD%E4%BD%B3%E5%AE%9D%E8%B4%9D%E6%B0%B8%E6%97%BA%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22radius%22%3A38.766666412353516%2C%22longitude%22%3A116.242444%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"1259860143_1399452716068.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"40%7C3\"}', '1399452718562');
INSERT INTO `e_log` VALUES ('a90b4729-fcbb-47dc-8de1-cea6582b7e97', null, null, '192.168.253.3', '2014-05-08 09:08:49', ':get', '/getImageFile/940407648_1399511322875.png', null, '1399511329640');
INSERT INTO `e_log` VALUES ('a919d6d8-61e4-4aab-a19c-5864ad5bc5e2', null, '1', '192.168.253.3', '2014-05-09 11:22:56', ':post', '/login', '{:phone \"1\"}', '1399605776375');
INSERT INTO `e_log` VALUES ('a9532289-8a13-4742-bc78-2f824dfec01b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:28:32', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399517593359', null, '1399519712515');
INSERT INTO `e_log` VALUES ('a9d01922-85f0-47f5-8b46-17686f48e4e7', null, '13651083480', '192.168.253.3', '2014-05-07 16:57:51', ':post', '/login', '{:phone \"13651083480\"}', '1399453071031');
INSERT INTO `e_log` VALUES ('aa69f165-95f5-4623-91de-0854cfd11c8e', null, '1', '192.168.253.3', '2014-05-09 11:35:21', ':post', '/login', '{:phone \"1\"}', '1399606521468');
INSERT INTO `e_log` VALUES ('aa7e22b0-eeb9-412f-93ec-ada7e850215f', null, '13651083480', '192.168.253.3', '2014-05-07 16:10:32', ':post', '/login', '{:phone \"13651083480\"}', '1399450232000');
INSERT INTO `e_log` VALUES ('aa86f10c-a5a7-42a8-82de-39d05dd9d601', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:45:34', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517134343');
INSERT INTO `e_log` VALUES ('aae5c444-6a2b-45da-af19-7e751fd1335a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:44', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521464687');
INSERT INTO `e_log` VALUES ('ab321719-2ea1-4c71-a481-df1961e9d665', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:19', ':get', '/getSalesByChannel/1/1399450999187', null, '1399450999687');
INSERT INTO `e_log` VALUES ('aba66e4d-d0a7-44d2-83b8-4e470fc76b24', null, '13651083480', '192.168.253.3', '2014-05-07 17:05:18', ':post', '/login', '{:phone \"13651083480\"}', '1399453518125');
INSERT INTO `e_log` VALUES ('abe8ada8-bea6-4713-8734-5e5e75d4e04e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:58', ':get', '/getSalesByChannel/0/1399448710437', null, '1399448758468');
INSERT INTO `e_log` VALUES ('ac0f0cc1-5818-40a5-9582-1bea891abce6', null, '1', '192.168.253.3', '2014-05-08 16:12:52', ':post', '/login', '{:phone \"1\"}', '1399536772609');
INSERT INTO `e_log` VALUES ('acc36254-abd9-40e0-8deb-5752c00c11d6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:41', ':get', '/getTrades', null, '1399530821187');
INSERT INTO `e_log` VALUES ('ad0a45eb-7b03-4a06-b677-60308f604cf0', null, null, '192.168.253.3', '2014-05-07 17:01:25', ':get', '/getImageFile/50489896_1399453226535.png', null, '1399453285000');
INSERT INTO `e_log` VALUES ('ad3a14ce-56e2-41f2-8068-f62c87eddba1', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:45', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399516785187');
INSERT INTO `e_log` VALUES ('ad4672f8-5c93-49d8-800a-e7b5607cf4bf', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:11', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399595651718');
INSERT INTO `e_log` VALUES ('ad6d6691-fb32-4e2a-a434-be9743c81815', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:34', ':post', '/loginShop', '{:user_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399595554265');
INSERT INTO `e_log` VALUES ('adb2c266-33cb-4448-8db5-2f6bdf002b17', null, null, '192.168.253.3', '2014-05-08 09:44:25', ':get', '/getImageFile/barcode_-509784425_1399513463015.png', null, '1399513465078');
INSERT INTO `e_log` VALUES ('adbacce5-e4ea-478a-93be-c0faa16ba672', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:57:11', ':get', '/getSalesByDistance/40.073701/116.242454/2000/0', null, '1399528631890');
INSERT INTO `e_log` VALUES ('ae209395-1ba9-4d68-b0a4-fdad68785409', null, '13651083480', '192.168.253.3', '2014-05-08 16:04:16', ':post', '/login', '{:phone \"1\"}', '1399536256531');
INSERT INTO `e_log` VALUES ('ae2d09f2-c7c0-4f91-b838-b31ebbbfd957', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:35:21', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606521843');
INSERT INTO `e_log` VALUES ('af3b75d4-e42c-4ca7-8e35-6984c9abeca7', null, '1', '192.168.253.3', '2014-05-08 16:20:55', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399537255593');
INSERT INTO `e_log` VALUES ('afc7dc21-bee1-405d-b57e-86fa9e3faaf4', null, null, '192.168.253.3', '2014-05-08 09:57:04', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514224234');
INSERT INTO `e_log` VALUES ('afdeb7d9-442a-4b3b-94f8-893925ff6a0a', null, '13651083480', '192.168.253.3', '2014-05-08 11:45:45', ':post', '/login', '{:phone \"13651083480\"}', '1399520745000');
INSERT INTO `e_log` VALUES ('b1fc188d-e03f-4331-b860-599a9ebbb67d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:30', ':get', '/getSalesByChannel/3/1399521448343', null, '1399521450468');
INSERT INTO `e_log` VALUES ('b23e3821-ff89-4feb-ae2b-d58297d8449c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:48', ':get', '/getModules/discover', null, '1399448688203');
INSERT INTO `e_log` VALUES ('b28c6937-65ed-4078-aae4-93b6e3ec79c9', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:16', ':get', '/getModules/me', null, '1399446376812');
INSERT INTO `e_log` VALUES ('b4badc37-ba81-4acf-b5d9-eb861e6ae286', null, null, '192.168.253.3', '2014-05-08 09:52:57', ':get', '/getImageFile/-810116522_1399513964667.png', null, '1399513977656');
INSERT INTO `e_log` VALUES ('b5171037-e0a8-45bd-a5d2-6db12d5174a3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:51:41', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528301968');
INSERT INTO `e_log` VALUES ('b5a749a2-0af2-4f28-9dfc-8e7d98fbe7ec', null, '1', '192.168.253.3', '2014-05-09 08:32:03', ':post', '/login', '{:phone \"1\"}', '1399595523031');
INSERT INTO `e_log` VALUES ('b5b8ba6f-85c6-4cf7-9e78-4f5e005f065d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:19', ':get', '/getSalesByChannel/0/1399450954234', null, '1399450999109');
INSERT INTO `e_log` VALUES ('b6007b9f-d2e6-4d10-b4af-5cbb921a678f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:36', ':get', '/getSalesByChannel/1/1399446576531', null, '1399446576937');
INSERT INTO `e_log` VALUES ('b6137f4d-a73d-4338-b613-05fc4fae150d', null, null, '192.168.253.1', '2014-05-07 16:29:22', ':get', '/aa', null, '1399451362000');
INSERT INTO `e_log` VALUES ('b61b2edd-2dee-45c6-8aac-c81a14885b97', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870015');
INSERT INTO `e_log` VALUES ('b73a774e-b338-44c4-b3eb-8e8284994dd1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:39', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399530819515');
INSERT INTO `e_log` VALUES ('b73a7c1d-f128-4cd0-907e-7172c22a1449', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125796');
INSERT INTO `e_log` VALUES ('b7ef26ec-1ca9-4ad3-ad85-2ae8f7e2cba2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:48:05', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399452485484');
INSERT INTO `e_log` VALUES ('b80ce76b-5585-4e05-9e38-5d21d224d84c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:59:54', ':post', '/saveComment', '{:publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :content \"有积分不错\"}', '1399517994390');
INSERT INTO `e_log` VALUES ('b8148444-d2f7-4b27-9824-8838c045cea3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:36:21', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606581687');
INSERT INTO `e_log` VALUES ('b82cc1ed-81a7-424c-ada9-8b9a93ae86c5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:13', ':get', '/getSalesByChannel/2/1399595527906', null, '1399595533984');
INSERT INTO `e_log` VALUES ('b8856968-ec98-4393-914c-f4dc1ad60ab9', null, '13651083480', '192.168.253.3', '2014-05-08 14:40:36', ':post', '/login', '{:phone \"13651083480\"}', '1399531236156');
INSERT INTO `e_log` VALUES ('b8b4f5f5-a15a-4c25-b07c-6a31010fd899', null, '13651083480', '192.168.253.3', '2014-05-08 09:27:52', ':get', '/getSalesByChannel/0/-1', null, '1399512472515');
INSERT INTO `e_log` VALUES ('b8c26da0-ceba-41a1-97da-f2265b5a1fcd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:38:06', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531086609');
INSERT INTO `e_log` VALUES ('b91ef9dc-ee8a-4d2f-9bdc-374a6843262c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:27:06', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606026468');
INSERT INTO `e_log` VALUES ('b922d3ab-660e-4c01-949c-451e185a65ea', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:18', ':get', '/getSalesByChannel/1/1399595534031', null, '1399595538390');
INSERT INTO `e_log` VALUES ('b9480b9a-30a3-43dc-85c4-5880722a6205', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:07', ':post', '/searchShops', '{:search-word \"上地\"}', '1399452907718');
INSERT INTO `e_log` VALUES ('b95b9dd9-7920-4a1e-a0f5-8c14f8317e91', null, '13651083480', '192.168.253.3', '2014-05-08 10:52:37', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517557062');
INSERT INTO `e_log` VALUES ('b96ac5ac-3022-4526-b417-a817b26b1aff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:45:11', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"address\", :value \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :fileNameList \"\"}', '1399513511343');
INSERT INTO `e_log` VALUES ('bac99bef-4397-4d44-ba96-57ede1eb8bd8', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:46:32', ':get', '/getShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399607192109');
INSERT INTO `e_log` VALUES ('bc4789a1-79d2-4af3-b23c-ebb5cf3b1014', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:01:23', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399514483468');
INSERT INTO `e_log` VALUES ('bd9fbd86-5148-4504-a485-a6a591a4024f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:46:20', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"i妞妞\"}', '1399448780109');
INSERT INTO `e_log` VALUES ('bdacec5d-310e-4668-a044-a103a6143a51', null, '13651083480', '192.168.253.3', '2014-05-08 09:09:49', ':post', '/login', '{:phone \"13651083480\"}', '1399511389984');
INSERT INTO `e_log` VALUES ('be8058b2-98fd-41d1-9af9-55f2ec876fe6', null, null, '192.168.253.3', '2014-05-08 16:51:21', ':get', '/pub/grade_shop.html', null, '1399539081484');
INSERT INTO `e_log` VALUES ('beb921c0-456f-4c90-8cca-47b0f1ac1065', null, '13651083480', '192.168.253.3', '2014-05-08 10:11:11', ':post', '/login', '{:phone \"13651083480\"}', '1399515071765');
INSERT INTO `e_log` VALUES ('bf03a998-7566-48bf-b76e-b66ef4e006bc', null, null, '192.168.253.1', '2014-05-07 16:34:59', ':get', '/aa', null, '1399451699296');
INSERT INTO `e_log` VALUES ('bf1ca3f6-5ffa-40bb-97b2-c4ffc49db7f1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:08:12', ':post', '/updateShop', '{:value \"-810116522_1399514888415.png\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"shop_img\", :fileNameList \"-810116522_1399514888415.png\", \"-810116522_1399514888415.png\" {:size 111143, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7395602937005622125.tmp>, :content-type \"image/pjpeg\", :filename \"-810116522_1399514888415.png\"}}', '1399514892625');
INSERT INTO `e_log` VALUES ('bfc1dc4a-f23d-4fa7-aaa3-2aac23c42422', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:45:46', ':get', '/getSalesByChannel/1/1399607127906', null, '1399607146875');
INSERT INTO `e_log` VALUES ('c0412e06-c5e5-41c1-bfe8-80d92f812982', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:50', ':get', '/getSaleFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517090718');
INSERT INTO `e_log` VALUES ('c0862c85-45e2-41a0-99ef-185922d8b7c4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:31:14', ':get', '/getSaleFavoritesByUser/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399519874703');
INSERT INTO `e_log` VALUES ('c0f6d232-23b6-4186-93f2-9af9d6943f8f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:47:48', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528068468');
INSERT INTO `e_log` VALUES ('c0fdc7e4-fb47-49ec-a8b5-b645a72788ed', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:39', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528359703');
INSERT INTO `e_log` VALUES ('c168cce1-7bed-4d78-8811-fb91b1283610', null, null, '192.168.253.3', '2014-05-08 09:13:28', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399511608734');
INSERT INTO `e_log` VALUES ('c23d8725-e613-41d6-b49a-7c9b9fdd57e8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:22:03', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399512123531');
INSERT INTO `e_log` VALUES ('c29dad1b-fac5-4e4d-8f0a-6d51f845360b', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:51', ':post', '/login', '{:phone \"13651083480\"}', '1399533951468');
INSERT INTO `e_log` VALUES ('c375245a-8deb-4698-956e-29487a656800', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:23', ':get', '/getSalesByChannel/0/1399521407062', null, '1399521443125');
INSERT INTO `e_log` VALUES ('c3992d28-c546-416e-b51d-d8867cec12cd', null, '13651083480', '192.168.253.3', '2014-05-08 11:51:01', ':post', '/login', '{:phone \"13651083480\"}', '1399521061203');
INSERT INTO `e_log` VALUES ('c3e03de0-da6a-4cbb-9a48-7285f3508a09', null, '13651083480', '192.168.253.3', '2014-05-08 09:40:14', ':post', '/login', '{:phone \"13651083480\"}', '1399513214687');
INSERT INTO `e_log` VALUES ('c4020eec-f75b-462c-ac64-26d3d4727715', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:56:25', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521385000');
INSERT INTO `e_log` VALUES ('c48ad146-0efc-4eaa-a09e-a67dc8da7aee', null, '1', '192.168.253.3', '2014-05-09 11:22:22', ':post', '/login', '{:phone \"1\"}', '1399605742265');
INSERT INTO `e_log` VALUES ('c55c6a91-98d6-401a-bdb5-ab05eca738c6', null, '13651083480', '192.168.253.3', '2014-05-08 09:27:52', ':get', '/getSalesByChannel/1/1399512472562', null, '1399512472875');
INSERT INTO `e_log` VALUES ('c60dfe99-c838-4d42-b6a5-0f1be914230c', null, null, '192.168.253.3', '2014-05-08 16:52:01', ':get', '/pub/grade_shop.html', null, '1399539121390');
INSERT INTO `e_log` VALUES ('c7251ae2-87a3-4421-b518-52c6fee101e6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:21:54', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399512114515');
INSERT INTO `e_log` VALUES ('c932bdf4-9c60-40eb-b5b0-0e4028cd9f5a', null, '13651083480', '192.168.253.3', '2014-05-08 09:54:13', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514042943.png\"}', '1399514053812');
INSERT INTO `e_log` VALUES ('c9c33a93-9054-44a8-a972-dbb4d30475d7', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:39', ':get', '/getSalesByChannel/0/-1', null, '1399533939250');
INSERT INTO `e_log` VALUES ('c9e10567-0f76-4c82-9684-c136e2449b21', null, '1', '192.168.253.3', '2014-05-08 10:37:14', ':post', '/login', '{:phone \"1\"}', '1399516634453');
INSERT INTO `e_log` VALUES ('cae7c99e-1b69-4e75-a34c-641300255d27', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:25:53', ':get', '/getSalesByChannel/1/1399533939828', null, '1399533953234');
INSERT INTO `e_log` VALUES ('cde49078-e3eb-4c95-ba97-b881fc7b5984', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:51:34', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399528294890');
INSERT INTO `e_log` VALUES ('ce28fda3-c9a8-4941-906b-2582f714976b', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:55:48', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517748609');
INSERT INTO `e_log` VALUES ('ce60b445-49d5-41a0-992a-d9a6275c8acf', null, '13651083480', '192.168.253.3', '2014-05-07 17:55:45', ':post', '/login', '{:phone \"13651083480\"}', '1399456545468');
INSERT INTO `e_log` VALUES ('ce6c0389-7fea-4cd1-ac38-2b1e2a4e94fe', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:06', ':get', '/getSalesByChannel/0/1399450274265', null, '1399450446640');
INSERT INTO `e_log` VALUES ('ce9bc156-adb7-4bba-a39b-5fafdb5496f9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:47', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450967562');
INSERT INTO `e_log` VALUES ('cf0902b5-8fc5-4d59-87ac-f82e2ce14a9a', null, '13651083480', '192.168.253.3', '2014-05-08 09:59:04', ':post', '/login', '{:phone \"13651083480\"}', '1399514344765');
INSERT INTO `e_log` VALUES ('d00488c9-2208-4cce-b9fb-113eee52b3ff', null, null, '192.168.253.3', '2014-05-07 16:54:29', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452869968');
INSERT INTO `e_log` VALUES ('d078860d-753c-4730-bc43-df23b0bfa668', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125921');
INSERT INTO `e_log` VALUES ('d087fa21-977f-4cbd-8eca-47c8fbd8aedd', null, null, '192.168.253.3', '2014-05-07 15:07:42', ':get', '/getImageFile//storage/emulated/0/bluetooth/1.jpeg', null, '1399446462234');
INSERT INTO `e_log` VALUES ('d088ff6b-2662-4866-b9c3-903d9ab3e790', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:35', ':get', '/getShopShares/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399452076125', null, '1399595675687');
INSERT INTO `e_log` VALUES ('d11962ba-2c73-4399-b36b-644272a052d5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:43:23', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399455803015');
INSERT INTO `e_log` VALUES ('d134662e-12ea-4662-8ccf-a6d542792cc6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:15', ':get', '/getSalesByChannel/1/1399607146953', null, '1399607235968');
INSERT INTO `e_log` VALUES ('d14f9283-7f2a-4045-b6f4-bf5c19de201e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:57:10', ':get', '/getSettings', null, '1399528630265');
INSERT INTO `e_log` VALUES ('d205baf8-069b-40d7-af89-633f1471943c', null, '13651083480', '192.168.253.3', '2014-05-08 09:13:05', ':get', '/getSalesByChannel/0/-1', null, '1399511585453');
INSERT INTO `e_log` VALUES ('d22ea171-a326-49dd-82cc-7e8eb7960f63', null, '13651083480', '192.168.253.3', '2014-05-07 15:43:30', ':post', '/login', '{:phone \"13651083480\"}', '1399448610968');
INSERT INTO `e_log` VALUES ('d25a3e3e-86eb-426e-8388-23c82997df2e', null, null, '192.168.253.3', '2014-05-08 09:22:05', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512125187');
INSERT INTO `e_log` VALUES ('d3d01466-5c36-4977-924d-0704a4522f07', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:33:54', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399595634125');
INSERT INTO `e_log` VALUES ('d402bcb6-8ce7-47ee-81a6-829baac144e2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:54:08', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎以后再来\"}', '1399517648296');
INSERT INTO `e_log` VALUES ('d40ecec8-09a2-4f29-920b-160d16560225', null, null, '192.168.253.3', '2014-05-09 11:36:23', ':get', '/pub/grade_shop.html', null, '1399606583515');
INSERT INTO `e_log` VALUES ('d41eba4b-1e56-4932-801d-19eb48512bdf', null, '13651083480', '192.168.253.3', '2014-05-08 10:11:01', ':get', '/getModules/me', null, '1399515061703');
INSERT INTO `e_log` VALUES ('d4a913d2-3f1c-471e-8f62-9fee16d5cd8d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:07:45', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399514865187');
INSERT INTO `e_log` VALUES ('d4c30330-a7d5-4ccd-967f-f7fe7ef2be45', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:13:20', ':get', '/getModules/me', null, '1399511600218');
INSERT INTO `e_log` VALUES ('d4c34a4e-58a9-40dd-baad-45e8258a88f9', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:45', ':get', '/getSalesByChannel/1/1399446405671', null, '1399446405812');
INSERT INTO `e_log` VALUES ('d55de555-522c-40b4-bc2a-171d4c62e22f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:05:30', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511130640');
INSERT INTO `e_log` VALUES ('d59e247d-2a0d-4090-b185-0ebaaa14467c', null, null, '192.168.253.3', '2014-05-08 09:22:04', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512124875');
INSERT INTO `e_log` VALUES ('d5c97402-49fe-4ad5-93fa-b0079ea48b58', null, '1', '192.168.253.3', '2014-05-09 10:41:49', ':post', '/login', '{:phone \"1\"}', '1399603309625');
INSERT INTO `e_log` VALUES ('d5d4e38a-0bfb-450e-a7eb-706db318c3bd', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:10', ':get', '/getChannels', null, '1399530790625');
INSERT INTO `e_log` VALUES ('d5dd8ff7-2005-4f5f-b375-e13b4572bebb', null, '13651083480', '192.168.253.3', '2014-05-08 09:28:06', ':post', '/login', '{:phone \"13651083480\"}', '1399512486453');
INSERT INTO `e_log` VALUES ('d6fb6265-9103-4420-9df9-bc00d0d39188', null, '1', '192.168.253.3', '2014-05-08 16:17:44', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399537064343');
INSERT INTO `e_log` VALUES ('d6fde213-167f-47fd-bccd-4794cfbe4ce5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:47:20', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520840312');
INSERT INTO `e_log` VALUES ('da8df8a5-f3ae-42b9-b116-e89d218f31d4', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125828');
INSERT INTO `e_log` VALUES ('da98fcbf-f3b6-4220-9e99-c1760f055209', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:04:24', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536264203');
INSERT INTO `e_log` VALUES ('dace9688-ab1a-4fd9-b843-db8043c87497', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:26:31', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次光临\"}', '1399533991265');
INSERT INTO `e_log` VALUES ('dd47abd3-c5eb-4f73-80ac-a26034234ba9', null, null, '192.168.253.3', '2014-05-08 11:56:20', ':get', '/getImageFile/-711923960_1399521341112.png', null, '1399521380062');
INSERT INTO `e_log` VALUES ('dd50da5e-8ea9-4466-9353-fa5800668f2e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:48', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399595568765');
INSERT INTO `e_log` VALUES ('dd5455e4-da15-47e1-9b49-c31c4efc66e8', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:34:09', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606449062');
INSERT INTO `e_log` VALUES ('de0b6af0-7643-4b81-b9d9-b7e3b7ab302a', null, '13651083480', '192.168.253.3', '2014-05-08 11:22:12', ':post', '/login', '{:phone \"13651083480\"}', '1399519332093');
INSERT INTO `e_log` VALUES ('de68a04a-3104-4605-9b36-dcc028781ec0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:02', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399595642296');
INSERT INTO `e_log` VALUES ('deb4f5f7-fd93-4c12-9973-d855b7ffca44', null, null, '192.168.253.3', '2014-05-08 09:40:48', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399513248468');
INSERT INTO `e_log` VALUES ('df0115ff-748b-4004-ae6f-0bd3a7127370', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:40:15', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399513215031');
INSERT INTO `e_log` VALUES ('df0d09a2-311f-4601-b9a4-ef6d102c482b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:11:23', ':get', '/getTrades', null, '1399515083156');
INSERT INTO `e_log` VALUES ('df8b5211-c908-46bd-a574-5ff8fc1355ea', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:59:05', ':post', '/saveUserPhoto', '{:photo \"748488426_1399514332755.png\", :fileNameList \"748488426_1399514332755.png\", :uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", \"748488426_1399514332755.png\" {:size 58889, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-1447260467401250110.tmp>, :content-type \"image/pjpeg\", :filename \"748488426_1399514332755.png\"}}', '1399514345281');
INSERT INTO `e_log` VALUES ('dfab29fe-e552-4736-a799-f4a46f59ef8e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:23', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450283375');
INSERT INTO `e_log` VALUES ('dfff639b-2157-4dfd-8c22-b85cc36a3e4c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:29', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399451069250');
INSERT INTO `e_log` VALUES ('e0a742ef-9b2d-462d-8a3d-0470acf11edb', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:42', ':get', '/getModules/me', null, '1399533942765');
INSERT INTO `e_log` VALUES ('e14a4689-4c06-44fe-bc92-148952b22148', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:43', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"uuu\"}', '1399446643687');
INSERT INTO `e_log` VALUES ('e251924d-5b6d-4e68-b9c0-6c616c96c9ab', null, '13651083480', '192.168.253.3', '2014-05-08 14:39:53', ':post', '/login', '{:phone \"13651083480\"}', '1399531193296');
INSERT INTO `e_log` VALUES ('e2b7379f-2ac2-4c06-9bd3-828226ef8de3', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284890');
INSERT INTO `e_log` VALUES ('e2ffdfb3-e72c-4f82-82f5-09e79d9408cd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:13:47', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536827281');
INSERT INTO `e_log` VALUES ('e36e8bb7-679b-4246-852b-eeab6f1b9c73', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125968');
INSERT INTO `e_log` VALUES ('e421adff-802c-4a12-95d9-e4fa3cf127e2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:56:07', ':post', '/addSale', '{:content \"%E8%8B%B9%E6%9E%9C%EF%BC%8Cibm%E7%AD%89%E7%94%B5%E8%84%91%E6%BB%A15000%E7%AB%8B%E5%87%8F100%E7%8E%B0%E9%87%91\", :end_date \"1402156800000\", :fileNameList \"-354365311_1399521331897.png%7C-711923960_1399521341112.png%7C463517179_1399521362365.png\", :title \"%E7%94%B5%E8%84%91%E4%BC%98%E6%83%A0%E5%AD%A3\", :trade_id \"41\", :start_date \"1399478400000\", \"-711923960_1399521341112.png\" {:size 130234, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-6082467065566929931.tmp>, :content-type \"image/pjpeg\", :filename \"-711923960_1399521341112.png\"}, :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", \"-354365311_1399521331897.png\" {:size 81255, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3322197020084694980.tmp>, :content-type \"image/pjpeg\", :filename \"-354365311_1399521331897.png\"}, \"463517179_1399521362365.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3673600331020136337.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399521362365.png\"}, :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399521367687');
INSERT INTO `e_log` VALUES ('e49b2e07-527f-4a54-8351-b96e4800dbff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:52', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399452952953');
INSERT INTO `e_log` VALUES ('e51180f3-0831-40f2-9836-645a2396e56b', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:13', ':get', '/getSalesByChannel/0/1399446365375', null, '1399446373593');
INSERT INTO `e_log` VALUES ('e6116df9-7cf5-4626-ad70-f6e8a839e13d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:51:17', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399521077812');
INSERT INTO `e_log` VALUES ('e64a8942-a6b2-4e4d-b0fe-75af58a581db', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:57', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399448757500');
INSERT INTO `e_log` VALUES ('e6c747b9-42f5-401a-a814-c44bc38f9ef6', null, '13651083480', '192.168.253.3', '2014-05-08 14:38:00', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531080968');
INSERT INTO `e_log` VALUES ('e6dbfabe-daa4-4350-bbf7-4802061f11d1', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:57:21', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517841234');
INSERT INTO `e_log` VALUES ('e6ebc32b-99ad-4bba-a875-1371b80dd250', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:33:44', ':get', '/getSalesByChannel/1/1399595609390', null, '1399595624921');
INSERT INTO `e_log` VALUES ('e81ba8c5-b10c-459d-9e88-4d5c4197509b', null, null, '192.168.253.3', '2014-05-08 10:26:23', ':get', '/getImageFile/898289355_1399515888683.png', null, '1399515983156');
INSERT INTO `e_log` VALUES ('e82d8d13-e5a8-4327-a674-057771a6b97b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:57', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448697125');
INSERT INTO `e_log` VALUES ('e85c9b61-4b87-4148-b2d9-c9052a408361', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:22:56', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605776671');
INSERT INTO `e_log` VALUES ('e891ed66-de04-4c2d-8c80-e5f325e0a54e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:43', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453663421');
INSERT INTO `e_log` VALUES ('e8ffd2a7-864c-40c2-8f03-164120525c35', null, '13651083480', '192.168.253.3', '2014-05-07 16:41:15', ':post', '/login', '{:phone \"13651083480\"}', '1399452075609');
INSERT INTO `e_log` VALUES ('ea153ff9-e174-4a07-81a4-f161447ca2f6', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284984');
INSERT INTO `e_log` VALUES ('ea990b29-281b-42e0-9e58-a7f08320a9c4', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:04', ':get', '/getShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399607224265');
INSERT INTO `e_log` VALUES ('eaa4b1a2-475a-4b22-813f-4e4649a2e088', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:22:59', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399515779781');
INSERT INTO `e_log` VALUES ('eb35aae9-a647-4373-87b9-b83b5138442e', null, null, '192.168.253.3', '2014-05-07 17:57:24', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399456644640');
INSERT INTO `e_log` VALUES ('eb48b1cd-1334-4787-8e98-782087b1c66f', null, '1', '192.168.253.3', '2014-05-09 10:38:39', ':post', '/login', '{:phone \"1\"}', '1399603119640');
INSERT INTO `e_log` VALUES ('eb5210f5-2cfa-45b0-b6fd-d608d63ad7b6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:51:25', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521085468');
INSERT INTO `e_log` VALUES ('ebba14c1-4a18-4ea0-b77a-0f2f0888d482', null, null, '192.168.253.3', '2014-05-07 15:09:48', ':get', '/getImageFile/13651083480_1399446443410.png', null, '1399446588859');
INSERT INTO `e_log` VALUES ('ebf0a857-cecd-4326-aaa0-67fae28f2bb4', null, '13651083480', '192.168.253.3', '2014-05-08 11:23:08', ':get', '/getFriendShares/74dc86dd-dc56-4d45-a020-dd6b939e4fe2/1399519380403', null, '1399519388078');
INSERT INTO `e_log` VALUES ('ec02f49f-3ecf-4785-ab05-1d72f8915ca3', null, '13651083480', '192.168.253.3', '2014-05-08 11:22:01', ':get', '/getFriendShares/37c61b15-7333-45d0-bc7e-473b13cf34f9/1399519303584', null, '1399519321156');
INSERT INTO `e_log` VALUES ('ec195fe6-500f-463b-87ba-34b91f37d656', null, '13651083480', '192.168.253.3', '2014-05-08 13:51:34', ':post', '/login', '{:phone \"13651083480\"}', '1399528294031');
INSERT INTO `e_log` VALUES ('ec71d0fc-accd-4c4a-a734-319d70689389', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870156');
INSERT INTO `e_log` VALUES ('ecb3d714-32a8-4277-8e32-084123519d78', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:22:21', ':get', '/getTrades', null, '1399512141250');
INSERT INTO `e_log` VALUES ('ee12196c-ec27-4575-8543-6f5f11f57f35', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:36:06', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606566312');
INSERT INTO `e_log` VALUES ('ee8515b8-a921-4391-a25d-439bec810d39', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:40', ':post', '/addFriend', '{:user_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :friend_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399516780546');
INSERT INTO `e_log` VALUES ('ef7993d3-9f61-4072-a692-bd94cfe688da', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:02', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528322500');
INSERT INTO `e_log` VALUES ('f0c1de71-6466-4b76-8916-c4fca6a2fe4b', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:37:15', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399516635046');
INSERT INTO `e_log` VALUES ('f15870c1-c018-4ea5-8f8d-ac2b86cd67c7', null, '13651083480', '192.168.253.3', '2014-05-08 10:07:44', ':post', '/login', '{:phone \"13651083480\"}', '1399514864750');
INSERT INTO `e_log` VALUES ('f162c57c-a3a8-4ba7-b1b5-ea8b1d6d08f3', null, null, '192.168.253.3', '2014-05-08 10:10:25', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399515025484');
INSERT INTO `e_log` VALUES ('f1c7b356-8cf9-451e-9e39-29c0dd6e6d9e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:28:42', ':get', '/getSettings', null, '1399516122281');
INSERT INTO `e_log` VALUES ('f24a915e-cd28-4c5f-a857-fbe57ab4cf68', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:52', ':post', '/login', '{:phone \"13651083480\"}', '1399450732421');
INSERT INTO `e_log` VALUES ('f2756af2-f1c4-4ddc-a7fc-9e3fd150c538', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:32', ':get', '/getSalesByChannel/1/1399448672375', null, '1399448672609');
INSERT INTO `e_log` VALUES ('f306d97d-2bda-40fa-bb08-0987dba161c8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:33', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450953031');
INSERT INTO `e_log` VALUES ('f323da6c-1f9d-4065-a0f5-8ac6fbeb40d6', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:39', ':get', '/getSalesByChannel/1/1399533939312', null, '1399533939703');
INSERT INTO `e_log` VALUES ('f3e4d294-8851-40ba-9de7-45f53662e104', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:41', ':get', '/getShopFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607261937');
INSERT INTO `e_log` VALUES ('f40990ee-fd0d-474f-a9ba-42abf5d2a0c3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':get', '/getSalesByChannel/1/1399446470578', null, '1399446470718');
INSERT INTO `e_log` VALUES ('f46cece9-e1c8-4286-ad40-3e951cfb5efe', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:22:35', ':get', '/getTrades', null, '1399512155656');
INSERT INTO `e_log` VALUES ('f5d127ed-acb0-4c09-bb30-8ffd41b596c9', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:57', ':get', '/getSettings', null, '1399607277875');
INSERT INTO `e_log` VALUES ('f663e5d8-6c05-4317-acfe-98a5e8fe68ee', null, '13651083480', '192.168.253.3', '2014-05-08 10:10:57', ':get', '/getChannels', null, '1399515057421');
INSERT INTO `e_log` VALUES ('f754fc09-72fe-451a-aaf3-4f58fcc30673', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:14:16', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399454056125');
INSERT INTO `e_log` VALUES ('f7ebd434-1c7d-4b78-92e7-07842238b408', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:22:50', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399515770921');
INSERT INTO `e_log` VALUES ('f85fb314-f879-4c22-8dc0-867ae2696ee1', null, '13651083480', '192.168.253.3', '2014-05-08 09:56:53', ':post', '/login', '{:phone \"13651083480\"}', '1399514213203');
INSERT INTO `e_log` VALUES ('f906a65f-0d96-4037-bf9b-d1ca81c16c02', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:02', ':get', '/getShopsByDistance/40.073712/116.242458/2000/0', null, '1399453622796');
INSERT INTO `e_log` VALUES ('f9bdb5d0-d95e-4838-ad42-099af7340426', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:04:14', ':post', '/saveUserPhoto', '{:photo \"834375879_1399511048951.png\", :fileNameList \"834375879_1399511048951.png\", :uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", \"834375879_1399511048951.png\" {:size 52141, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2384327552444089330.tmp>, :content-type \"image/pjpeg\", :filename \"834375879_1399511048951.png\"}}', '1399511054609');
INSERT INTO `e_log` VALUES ('f9dd371c-6bc5-4c4d-b146-b1bf3eb80975', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:29:23', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399602563515');
INSERT INTO `e_log` VALUES ('f9eda959-b2aa-451e-a755-361bda58fbf6', null, null, '192.168.253.1', '2014-05-07 16:28:59', ':get', '/aa', null, '1399451339046');
INSERT INTO `e_log` VALUES ('fa0be236-dc0e-48d4-ae27-3119476a8dfb', null, '13651083480', '192.168.253.3', '2014-05-08 11:49:40', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/b34a6fd2-e6f2-4565-8106-64cbe17be618', null, '1399520980046');
INSERT INTO `e_log` VALUES ('fa4a4311-a3b6-4bb0-bbc9-f348241f388e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:34', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399453414437');
INSERT INTO `e_log` VALUES ('faa88ac5-5822-4435-a1b6-b18b737b96d1', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:57:12', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517832234');
INSERT INTO `e_log` VALUES ('fab6ec7d-b9bc-4ee8-adb3-ca9eac765be4', null, '1', '192.168.253.3', '2014-05-08 16:17:31', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399537051281');
INSERT INTO `e_log` VALUES ('fac7a923-4fa9-4ac3-9aa8-aae144b1265d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:45:33', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :fileNameList \"\"}', '1399455933875');
INSERT INTO `e_log` VALUES ('fb2809f8-103c-4e34-bd0d-80f69b740794', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:28:07', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399512487140');
INSERT INTO `e_log` VALUES ('fb314c60-962c-4efd-bdf9-c996c76d972b', null, null, '192.168.253.3', '2014-05-07 16:19:45', ':get', '/getImageFile/barcode_1641208558_1399450739125.png', null, '1399450785609');
INSERT INTO `e_log` VALUES ('fb9bc70f-4f33-453e-9607-e5c137f9d04e', null, '13651083480', '192.168.253.3', '2014-05-08 10:22:06', ':post', '/login', '{:phone \"13651083480\"}', '1399515726843');
INSERT INTO `e_log` VALUES ('fbb8fa86-6282-4e13-b3bb-c11630843ab5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:43', ':get', '/getSalesByChannel/1/1399449042953', null, '1399449043375');
INSERT INTO `e_log` VALUES ('fc5df13c-aea7-4550-94cb-b4f4f3d09105', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:45:33', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399531533968');
INSERT INTO `e_log` VALUES ('fc60c8f8-03fb-4df0-a6f8-4670fae55f49', null, null, '192.168.253.3', '2014-05-08 10:38:11', ':get', '/getImageFile/1321682725_1399516655545.png', null, '1399516691000');
INSERT INTO `e_log` VALUES ('fcd879f0-b86b-4bf9-8264-26da9d37bebd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:55:45', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399456545937');
INSERT INTO `e_log` VALUES ('fd2b3f26-bb4d-4dbc-8f25-3ea1d8c86df7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:06:48', ':post', '/searchUsers', '{:search-word \"12222222\"}', '1399453608531');
INSERT INTO `e_log` VALUES ('fe22d684-8982-4d86-833b-8759ad39541d', null, null, '192.168.253.3', '2014-05-08 09:10:30', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399511430984');
INSERT INTO `e_log` VALUES ('fe255737-4720-4ca6-bad7-8adc7154992b', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:48:09', ':get', '/getSalesByDistance/40.073707/116.242451/2000/0', null, '1399607289921');
INSERT INTO `e_log` VALUES ('fea061d9-7429-43bd-a45c-dce729de14dd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:06:07', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453567750');
INSERT INTO `e_log` VALUES ('fec6c1c4-4263-42f3-9464-8ab75d86c7a4', null, '13651083480', '192.168.253.3', '2014-05-07 16:38:56', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451933560.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A43.61538314819336%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451933560.png\", \"-1400089674_1399451933560.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3674141896022570713.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451933560.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\"}', '1399451936468');
INSERT INTO `e_log` VALUES ('ff3a9f3b-bc94-4af3-8c87-b1630540a246', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:34', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399449094000');
INSERT INTO `e_log` VALUES ('fff2c8ff-c660-4cab-a67e-a7753a48b09e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:45:39', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"name\", :value \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :fileNameList \"\"}', '1399513539093');
INSERT INTO `e_log` VALUES ('fff6a09d-1e91-45c5-a359-143d65ca6e51', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:12:54', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536774062');

-- ----------------------------
-- Table structure for `e_mapping_ct`
-- ----------------------------
DROP TABLE IF EXISTS `e_mapping_ct`;
CREATE TABLE `e_mapping_ct` (
  `uuid` varchar(36) NOT NULL DEFAULT '',
  `channel_id` varchar(36) NOT NULL,
  `trade_id` varchar(36) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_mapping_ct_ct` (`channel_id`,`trade_id`)
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
  PRIMARY KEY (`uuid`),
  KEY `i_sale_shop_id` (`shop_id`),
  KEY `i_sale_lmt` (`last_modify_time`),
  KEY `i_sale_publisher` (`publisher`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='活动记录表';

-- ----------------------------
-- Records of e_sale
-- ----------------------------
INSERT INTO `e_sale` VALUES ('43b10a06-f46a-4816-a5cf-00eb257e6141', '五月优惠大放送', '全场汉堡买一送一', '1398873600000', '1401465600000', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1', '50489896_1399453226535.png', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399453275062', '2014-05-07', '1399595645625', '13', '2', '2');
INSERT INTO `e_sale` VALUES ('fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '电脑优惠季', '苹果，ibm等电脑满5000立减100现金', '1399478400000', '1402156800000', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '41', '-354365311_1399521331897.png', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399521367765', '2014-05-08', '1399606270875', '9', '0', '1');

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
  PRIMARY KEY (`uuid`),
  KEY `i_sale_discuss_sale_id` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_sale_discuss
-- ----------------------------
INSERT INTO `e_sale_discuss` VALUES ('c904600b-d4a0-4e55-83c4-9efb13601ee6', '43b10a06-f46a-4816-a5cf-00eb257e6141', null, '优惠多多', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399453518375', '0', '1399453518375');
INSERT INTO `e_sale_discuss` VALUES ('e063ec6c-674a-4e5e-b56a-9e3771ad5495', '43b10a06-f46a-4816-a5cf-00eb257e6141', null, '非常不错啊', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1399516722750', '0', '1399516722750');

-- ----------------------------
-- Table structure for `e_sale_favorit`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale_favorit`;
CREATE TABLE `e_sale_favorit` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `sale_id` varchar(36) NOT NULL,
  `last_modify_time` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_sale_favorit_user_sale` (`user_id`,`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_sale_favorit
-- ----------------------------
INSERT INTO `e_sale_favorit` VALUES ('71e0c89b-7dee-496d-833a-3793cd2f1678', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453533703');

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
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `e_sale_img_si` (`sale_id`,`img`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of e_sale_img
-- ----------------------------
INSERT INTO `e_sale_img` VALUES ('25884073-8ce0-4993-a41e-f54e85bf304f', '463517179_1399521362365.png', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '2', null);
INSERT INTO `e_sale_img` VALUES ('66d8f101-32cd-4fc4-a517-3e290f7dbea9', '-711923960_1399521341112.png', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1', null);
INSERT INTO `e_sale_img` VALUES ('8c81d58b-f763-4e9f-a268-3d35665961cc', '-354365311_1399521331897.png', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '0', null);
INSERT INTO `e_sale_img` VALUES ('fa5da47e-8fc2-4c35-b888-a3b7d390e943', '50489896_1399453226535.png', '43b10a06-f46a-4816-a5cf-00eb257e6141', '0', null);

-- ----------------------------
-- Table structure for `e_sale_visit`
-- ----------------------------
DROP TABLE IF EXISTS `e_sale_visit`;
CREATE TABLE `e_sale_visit` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `sale_id` varchar(36) NOT NULL,
  `visit_time` varchar(16) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `i_sale_visit_user` (`user_id`),
  KEY `i_sale_visit_sale` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_sale_visit
-- ----------------------------
INSERT INTO `e_sale_visit` VALUES ('15d465d5-cb8d-4c02-8a1f-ce90df1a5d3b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399528372671');
INSERT INTO `e_sale_visit` VALUES ('185599fc-afbc-4b57-a734-291a13573704', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399521379093');
INSERT INTO `e_sale_visit` VALUES ('195f6360-16cb-4e74-bfbd-743da7f56da1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399528068546');
INSERT INTO `e_sale_visit` VALUES ('1a5e06bc-e11d-413c-8607-6dd398f4ceef', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453531140');
INSERT INTO `e_sale_visit` VALUES ('1f05c4df-9be5-47f3-871b-5bcf30035854', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399526956171');
INSERT INTO `e_sale_visit` VALUES ('23b9dd85-d4b9-41f5-9ca8-5f8ccaaa45dd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453411515');
INSERT INTO `e_sale_visit` VALUES ('2d643aea-8580-44b4-9487-b318677b5f81', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453294906');
INSERT INTO `e_sale_visit` VALUES ('35522955-7297-4dab-b975-02fec338e2ca', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399595645625');
INSERT INTO `e_sale_visit` VALUES ('35d40fb8-98b3-4aeb-b33b-9ef7bad2cde4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399521464781');
INSERT INTO `e_sale_visit` VALUES ('5f93cd1f-f689-4755-ab6a-c723113640c3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399527121500');
INSERT INTO `e_sale_visit` VALUES ('686967bd-6d0f-463b-906d-9c21d2320335', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399516709453');
INSERT INTO `e_sale_visit` VALUES ('77549268-aef3-467f-b9a0-c944754bbc86', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399528116593');
INSERT INTO `e_sale_visit` VALUES ('7a0484b2-71c1-4292-80af-49e78a9f950c', 'b34a6fd2-e6f2-4565-8106-64cbe17be618', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399520980109');
INSERT INTO `e_sale_visit` VALUES ('a85dfba8-026b-42dc-9808-ddbec5b187ce', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399516068015');
INSERT INTO `e_sale_visit` VALUES ('a9771c54-99b8-4506-98b5-9e0fa4e47254', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399520820687');
INSERT INTO `e_sale_visit` VALUES ('b851f890-ae7f-4d66-af4c-aaaa00fab77a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399527094093');
INSERT INTO `e_sale_visit` VALUES ('ba51257b-eed9-4849-80d7-e1b819569e04', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453301437');
INSERT INTO `e_sale_visit` VALUES ('bd1017d6-f263-47fa-b7fd-a08115fa571d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399528361828');
INSERT INTO `e_sale_visit` VALUES ('be072e24-2ae6-4c50-9ac2-9e13155b78f6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399521385093');
INSERT INTO `e_sale_visit` VALUES ('e35beb7e-e78f-415d-b50c-57275bb10f04', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399528302078');
INSERT INTO `e_sale_visit` VALUES ('e796112f-01f5-44a1-806e-60bd2686d094', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399528324953');
INSERT INTO `e_sale_visit` VALUES ('ea364ce5-bc94-41e0-9e5d-0a7f42030fd5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399606270875');

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
  `is_used` int(1) DEFAULT '1',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_setting_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_setting
-- ----------------------------
INSERT INTO `e_setting` VALUES ('1', 'login', '登录设置', '0', null, '1');
INSERT INTO `e_setting` VALUES ('2', 'cache', '缓存', '1', null, '0');
INSERT INTO `e_setting` VALUES ('3', 'radar', '雷达配置', '2', null, '1');
INSERT INTO `e_setting` VALUES ('9999', 'logout', '退出', '9999', null, '1');

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
  PRIMARY KEY (`uuid`),
  KEY `e_share_publisher` (`publisher`),
  KEY `e_share_shop` (`shop_id`),
  KEY `e_share_lmt` (`last_modify_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share
-- ----------------------------
INSERT INTO `e_share` VALUES ('2c82ce0c-eba1-459d-820e-19d714fd7a7c', '非常满意的活动', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1399516941671', '2014-05-08', null, '0', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1399516941671');
INSERT INTO `e_share` VALUES ('56621832-eb80-42e6-b034-459796447087', '肯德基的优惠幅度真大', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399453071437', '2014-05-07', null, '0', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1399453071437');
INSERT INTO `e_share` VALUES ('77013635-8b31-409b-88f4-656e87bec74f', '肯德基上地店优惠很多，欢迎惠顾。', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399517721656', '2014-05-08', null, '0', '', '1399517721656');
INSERT INTO `e_share` VALUES ('97fe7eee-834f-4806-a11a-e2fa91c084fd', '优惠真大', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1399516870968', '2014-05-08', null, '0', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1399517994562');
INSERT INTO `e_share` VALUES ('eb7cd9e8-f6ad-4445-a2d6-3609f01da1c7', '买的电脑很优惠，店员服务好。', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1399606307656', '2014-05-09', null, '0', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '1399606307656');

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
  PRIMARY KEY (`uuid`),
  KEY `i_share_comment_share` (`share_id`),
  KEY `i_share_comment_lmt` (`last_modify_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share_comment
-- ----------------------------
INSERT INTO `e_share_comment` VALUES ('e828f15e-7f71-4c46-88ad-95efc0660dc8', '97fe7eee-834f-4806-a11a-e2fa91c084fd', null, '有积分不错', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1399517994562', '0', '1399517994562');

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
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_share_img_si` (`img`,`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share_img
-- ----------------------------
INSERT INTO `e_share_img` VALUES ('596b75ea-4103-4713-8f03-eb2cc290ffac', '-104682932_1399516864279.png', '97fe7eee-834f-4806-a11a-e2fa91c084fd', '2', '1399516871015');
INSERT INTO `e_share_img` VALUES ('e2343e65-7c22-44a0-b7fa-19ed5222e882', '463517179_1399516848803.png', '97fe7eee-834f-4806-a11a-e2fa91c084fd', '1', '1399516870984');

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
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_share_shop_reply_ss` (`share_id`,`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_share_shop_reply
-- ----------------------------
INSERT INTO `e_share_shop_reply` VALUES ('5312d194-d154-4c6d-9cfc-85c6ade0d374', 'eb7cd9e8-f6ad-4445-a2d6-3609f01da1c7', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399606404281', '5', '欢迎惠顾', '1');
INSERT INTO `e_share_shop_reply` VALUES ('75be8ef6-82c0-4369-9ddc-640630cd5367', '97fe7eee-834f-4806-a11a-e2fa91c084fd', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399533991343', '10', '欢迎下次光临', '1');

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
  `latitude` varchar(16) DEFAULT NULL,
  `longitude` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop
-- ----------------------------
INSERT INTO `e_shop` VALUES ('238831cf-04bb-4549-9c6e-97724ccfa2a1', '丽佳宝贝永旺店', null, '1259860143_1399452716068.png', '{\"address\":\"北京市海淀区北清路68号\",\"radius\":38.766666412353516,\"longitude\":116.242444,\"latitude\":40.073734}', '北京市海淀区北清路68号', '欢迎光临', null, null, '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399452719546', '1399452718593', '0', 'barcode_1778418391_1399452718593.png', '40.073734', '116.242444');
INSERT INTO `e_shop` VALUES ('6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '北清路电脑城', null, '-810116522_1399514888415.png', '{\"address\":\"北京市海淀区北清路68号\",\"longitude\":116.242455,\"radius\":30.53333282470703,\"latitude\":40.073713}', '北京市海淀区北清路68号', '专卖电脑和书籍，欢迎惠顾。', '898289355_1399515888683.png', null, '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399515997093', '1399452076125', '1', 'barcode_-509784425_1399515996656.png', '40.073713', '116.242455');
INSERT INTO `e_shop` VALUES ('b7d34ff0-21db-44df-8626-04231feb078e', '上地华联探路者专卖店', null, '463517179_1399450736650.png', '{\"address\":\"北京市海淀区北清路68号\",\"longitude\":116.242447,\"radius\":39.31818389892578,\"latitude\":40.073715}', '北京市海淀区北清路68号', '探路者旗舰店', null, null, '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399450739187', '1399450739109', '0', 'barcode_1641208558_1399450739125.png', '40.073715', '116.242447');
INSERT INTO `e_shop` VALUES ('e162af86-f928-4ed1-8a7c-e6178d25a8d5', '肯德基上地店', null, '602324364_1399449344230.png', '{\"address\":\"北京市海淀区北清路68号\",\"longitude\":116.242443,\"radius\":44.83333206176758,\"latitude\":40.073733}', '北京市海淀区北清路68号', '肯德基大品牌', '898289355_1399449344232.png', null, '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399454129687', '1399449405468', '1', 'barcode_-1897623607_1399449405500.png', '40.073733', '116.242443');

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
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_shop_emp_su` (`shop_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_emp
-- ----------------------------
INSERT INTO `e_shop_emp` VALUES ('6cfffe68-edd0-4c9f-8e44-e02a06e0606f', 'b7d34ff0-21db-44df-8626-04231feb078e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1111', '1399450739125');
INSERT INTO `e_shop_emp` VALUES ('cd299799-f51c-4614-99ba-b755010ad9da', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '11111', '1399449405484');
INSERT INTO `e_shop_emp` VALUES ('db5caa32-9a08-4e50-8a7a-1d72a4516792', '238831cf-04bb-4549-9c6e-97724ccfa2a1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1111', '1399452718593');
INSERT INTO `e_shop_emp` VALUES ('e9157119-e9d3-44db-963e-68d98cd5e419', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '11111', '1399452076140');

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
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_shop_favorit_su` (`user_id`,`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_favorit
-- ----------------------------
INSERT INTO `e_shop_favorit` VALUES ('7b607371-aa1b-4e95-979e-23816dd957a5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1399517064578', '0');
INSERT INTO `e_shop_favorit` VALUES ('c0130518-782a-421a-8f46-25bc5240535f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1399452948703', '0');

-- ----------------------------
-- Table structure for `e_shop_trade`
-- ----------------------------
DROP TABLE IF EXISTS `e_shop_trade`;
CREATE TABLE `e_shop_trade` (
  `uuid` varchar(36) NOT NULL,
  `shop_id` varchar(36) NOT NULL,
  `trade_id` varchar(36) NOT NULL,
  `last_modify_time` varchar(16) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `e_shop_trade_st` (`shop_id`,`trade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_shop_trade
-- ----------------------------
INSERT INTO `e_shop_trade` VALUES ('0225c6de-5bb7-47bd-a0ca-3621ece0cfa2', '40ffa225-c977-40bd-94cb-9841f245862d', '40', '1399452718625');
INSERT INTO `e_shop_trade` VALUES ('02c70ac7-0028-4fd5-aa99-b6de285a9995', '238831cf-04bb-4549-9c6e-97724ccfa2a1', '40', '1399452718593');
INSERT INTO `e_shop_trade` VALUES ('3a996f4b-f1be-47fb-b40f-9604a0bd1907', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '42', '1399513440828');
INSERT INTO `e_shop_trade` VALUES ('5b15535f-044b-490d-8363-280a1d19cb28', 'b7d34ff0-21db-44df-8626-04231feb078e', '2', '1399450739125');
INSERT INTO `e_shop_trade` VALUES ('81db8bd9-541b-43fd-b37e-164a726a9c0e', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '41', '1399513440828');
INSERT INTO `e_shop_trade` VALUES ('a156bab8-8f9b-4d6f-bca5-2a9b9637ae63', '40ffa225-c977-40bd-94cb-9841f245862d', '3', '1399452718625');
INSERT INTO `e_shop_trade` VALUES ('c5c5b720-422d-4680-9d9f-4bf974c9457a', '238831cf-04bb-4549-9c6e-97724ccfa2a1', '3', '1399452718593');
INSERT INTO `e_shop_trade` VALUES ('d5089960-3303-4506-9404-b8abaff1d617', 'b7d34ff0-21db-44df-8626-04231feb078e', '40', '1399450739125');
INSERT INTO `e_shop_trade` VALUES ('df4c9505-5289-42d8-992c-4e73ea0eb607', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1', '1399449405484');

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
  `phone` varchar(11) DEFAULT NULL,
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
INSERT INTO `e_user` VALUES ('076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '依依', '1111', '1', '1', '1321682725_1399516655545.png', null, null, '1399516690468', '1399516358796');
INSERT INTO `e_user` VALUES ('5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '妞妞', '1111', '1', '13651083480', '748488426_1399514332755.png', null, null, '1399514345343', '1399446446109');

-- ----------------------------
-- Table structure for `e_user_grade`
-- ----------------------------
DROP TABLE IF EXISTS `e_user_grade`;
CREATE TABLE `e_user_grade` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `shop_id` varchar(36) NOT NULL,
  `share_id` varchar(36) NOT NULL,
  `grader` varchar(36) DEFAULT NULL,
  `grade_time` varchar(16) DEFAULT NULL,
  `end_time` varchar(16) DEFAULT NULL,
  `grade_amount` int(11) DEFAULT '0',
  `grade_used` int(11) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_user_grade
-- ----------------------------
INSERT INTO `e_user_grade` VALUES ('76f72b6f-f18d-4555-9b68-2927a60b8672', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '97fe7eee-834f-4806-a11a-e2fa91c084fd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399533991359', '1409901991359', '10', '0');
INSERT INTO `e_user_grade` VALUES ('c47abb08-2c5f-42e7-a9ec-086802938d16', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', 'eb7cd9e8-f6ad-4445-a2d6-3609f01da1c7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399606404359', '1409974404359', '5', '0');

-- ----------------------------
-- Table structure for `e_user_profile`
-- ----------------------------
DROP TABLE IF EXISTS `e_user_profile`;
CREATE TABLE `e_user_profile` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `share_count` int(11) DEFAULT '0',
  `sale_discuss_count` int(11) DEFAULT '0',
  `grade_amount` int(11) DEFAULT '0',
  `grade_used` int(11) DEFAULT '0',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `u_e_user_profile_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_user_profile
-- ----------------------------
INSERT INTO `e_user_profile` VALUES ('076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '3', '1', '15', '0');
INSERT INTO `e_user_profile` VALUES ('5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '2', '1', '0', '0');

-- ----------------------------
-- Procedure structure for `geodist`
-- ----------------------------
DROP PROCEDURE IF EXISTS `geodist`;
DELIMITER ;;
CREATE DEFINER=`ebs`@`%` PROCEDURE `geodist`(IN `tabName` text,IN `lon` double,IN `lat` double,IN `dist` int)
BEGIN
	#Routine body goes here...
	if tabName = 'e_shop' then
		select s.*, (2 * 6378.137 * ASIN (SQRT (POW (SIN (PI() * (lat - s.latitude)/360),2)
				+ COS(PI() * lat/180)* COS(s.latitude * PI()/180)*POW(SIN(PI()*(lon - s.longitude)/360),2)))) as distance
           	 from e_shop s
	  	 where  s.latitude> lat -1 and s.latitude < lat + 1 and s.longitude > lon - 1 and s.longitude < lon + 1
          	 having distance <= dist
	  	order by distance;
	end if;
END;;
DELIMITER ;

-- ----------------------------
-- Function structure for `geodist_field`
-- ----------------------------
DROP FUNCTION IF EXISTS `geodist_field`;
DELIMITER ;;
CREATE DEFINER=`ebs`@`%` FUNCTION `geodist_field`(`lat_d` double,`lon_d` double,`lat_s` double,`lon_s` double) RETURNS double
BEGIN
	#Routine body goes here...

	RETURN (2 * 6378.137 * ASIN (SQRT (POW (SIN (PI() * (lat_d - lat_s)/360),2)
				+ COS(PI() * lat_d/180)* COS(lat_s * PI()/180)*POW(SIN(PI()*(lon_d - lon_s)/360),2)))) * 1000;
END;;
DELIMITER ;
