/*
Navicat MySQL Data Transfer

Source Server         : localhost_ebs
Source Server Version : 50511
Source Host           : localhost:3306
Source Database       : ebs

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2014-05-16 14:52:35
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
INSERT INTO `e_channel` VALUES ('40', 'baby', '母婴', 'baby.html', null, '4', null, '0');
INSERT INTO `e_channel` VALUES ('41', 'computer', '电脑', 'computer.html', null, '5', null, '0');
INSERT INTO `e_channel` VALUES ('42', 'book', '书城', 'book.html', null, '6', null, '0');
INSERT INTO `e_channel` VALUES ('43', 'furniture\r\nfurniture', '家居', null, null, '7', null, '1');

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
INSERT INTO `e_log` VALUES ('00d32b54-a450-4963-81a9-687794409cf1', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:29', ':post', '/demo/addSaleDiscuss', '{:sale_id \"fc7c8598-fea8-4b85-9933-d5fe9a1ac725\", :publisher \"36a9a92d-9f19-4a8b-a566-841b5cf258af\", :content \"发发发\"}', '1399616489183');
INSERT INTO `e_log` VALUES ('00ee2d32-4505-480a-ada3-57253e31554c', null, '13651083480', '192.168.253.3', '2014-05-13 15:56:11', ':get', '/getSalesByChannel/1/1399967680640', null, '1399967771234');
INSERT INTO `e_log` VALUES ('014be67a-758b-4015-bedd-ab5718a8b042', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:57:51', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E7%9A%84%E4%BC%98%E6%83%A0%E5%B9%85%E5%BA%A6%E7%9C%9F%E5%A4%A7\", :fileNameList \"\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453071390');
INSERT INTO `e_log` VALUES ('01516b01-c47a-4680-a5a9-45fb19ecdb56', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:09:45', ':get', '/demo/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399615785151');
INSERT INTO `e_log` VALUES ('01f095f8-365c-48ab-86d6-9d1379a4011f', null, '13651083480', '192.168.253.3', '2014-05-13 09:26:08', ':get', '/getSalesByChannel/1/1399944299860', null, '1399944368798');
INSERT INTO `e_log` VALUES ('02001c5b-d2d4-4fa3-bed3-55636c2e77ab', null, '1', '192.168.253.3', '2014-05-13 15:45:30', ':post', '/login', '{:phone \"1\"}', '1399967130890');
INSERT INTO `e_log` VALUES ('0208b6b4-f0eb-4a46-899a-bff7ce80ab93', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:26', ':get', '/demo/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399616786730');
INSERT INTO `e_log` VALUES ('025c96b4-8bbb-425f-8500-ffe2b9bd5487', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 12:01:52', ':get', '/getSalesByChannel/1/1399953709173', null, '1399953712548');
INSERT INTO `e_log` VALUES ('027bfe76-347e-4762-962c-64003caa8d76', null, '13651083480', '118.194.195.3', '2014-05-09 14:06:44', ':get', '/demo/getSalesByChannel/2/1399615598136', null, '1399615604714');
INSERT INTO `e_log` VALUES ('03860890-ab64-4868-85ea-12b4f23ce859', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:40:36', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531236640');
INSERT INTO `e_log` VALUES ('03896533-7563-4699-9b5d-cdec57356dc4', null, null, '192.168.253.1', '2014-05-16 14:49:06', ':get', '/app/ios_android.png', null, '1400222946375');
INSERT INTO `e_log` VALUES ('04104099-6bef-4936-8b87-6da00f6769b3', null, '13651083480', '192.168.253.3', '2014-05-13 13:44:01', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399959650453', null, '1399959841062');
INSERT INTO `e_log` VALUES ('045881f1-2739-4162-b6a8-b4f768e7fd59', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780093');
INSERT INTO `e_log` VALUES ('045db13e-91a2-4564-a6c3-e3b0adb9ff45', null, '13651083480', '118.194.195.3', '2014-05-09 14:33:10', ':get', '/demo/getChannels', null, '1399617190917');
INSERT INTO `e_log` VALUES ('046fe82c-6a39-45e8-8df7-3e675c8c3a50', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:12', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450272593');
INSERT INTO `e_log` VALUES ('04d3ddb7-8f8f-4064-b062-287629f9614e', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:10', ':get', '/getSalesByChannel/1/1399448709921', null, '1399448710359');
INSERT INTO `e_log` VALUES ('0548c9c0-d7f6-4764-9033-f6f10eb9a0e0', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:05', ':get', '/getSalesByChannel/1/1399446365046', null, '1399446365312');
INSERT INTO `e_log` VALUES ('0552b6dd-9893-443a-afeb-3b8d336838df', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:09:48', ':get', '/getShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399968588828');
INSERT INTO `e_log` VALUES ('05800a5b-6534-4187-9073-7b5358587ff0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:39:53', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531193703');
INSERT INTO `e_log` VALUES ('058af94c-1da4-455e-b8e1-fa5727359592', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:44:47', ':get', '/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399970687015');
INSERT INTO `e_log` VALUES ('05ceaaee-acc7-48ea-aed8-e9b87b2ea6c1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:57:02', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399514222078');
INSERT INTO `e_log` VALUES ('05cebc83-3afb-42c3-b0b0-05d55c035db2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:41:16', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399452074181.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242455%2C%22radius%22%3A30.53333282470703%2C%22latitude%22%3A40.073713%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399452074181.png\", \"-1400089674_1399452074181.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-9101481504796265372.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399452074181.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\"}', '1399452076078');
INSERT INTO `e_log` VALUES ('05f46f7e-5d56-407d-8016-09bbd20ce2a5', null, null, '118.194.195.3', '2014-05-09 14:10:09', ':get', '/demo/getImageFile/463517179_1399516848803.png', null, '1399615809058');
INSERT INTO `e_log` VALUES ('06244c60-2180-4526-9194-80c92c87594a', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:09', ':get', '/getSalesByChannel/0/1399448672640', null, '1399448709859');
INSERT INTO `e_log` VALUES ('063b3fb2-6489-4570-b330-362fe9a8de3c', null, null, '118.194.195.3', '2014-05-09 14:07:37', ':get', '/demo/getImageFile/-810116522_1399514888415.png', null, '1399615657042');
INSERT INTO `e_log` VALUES ('065ea9af-f6d4-4e88-a658-e732addba354', null, null, '118.194.195.3', '2014-05-09 14:09:26', ':get', '/demo/getImageFile/barcode_-1897623607_1399449405500.png', null, '1399615766355');
INSERT INTO `e_log` VALUES ('06ba79d8-b480-4abc-8cfe-e0d172b9f0a5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:52:55', ':post', '/addFriend', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :friend_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399517575203');
INSERT INTO `e_log` VALUES ('06bf5caa-7b4c-48c0-ab04-d6fd38b15589', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:24', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607244671');
INSERT INTO `e_log` VALUES ('06c87506-5730-4a00-930f-690d391db253', null, '13651083480', '118.194.195.3', '2014-05-09 14:06:33', ':get', '/demo/getSalesByChannel/0/-1', null, '1399615593448');
INSERT INTO `e_log` VALUES ('06cc8233-db2f-48fc-8fbd-b6e9541e1e4f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:15', ':get', '/getSalesByChannel/0/1399449043453', null, '1399449255140');
INSERT INTO `e_log` VALUES ('06cf15d5-f025-42a8-bb1e-2eca37c59c89', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:34:36', ':get', '/getSalesByChannel/1/1399966464890', null, '1399966476281');
INSERT INTO `e_log` VALUES ('06ef12b6-c76a-42e7-b964-3945cd8d7212', null, '13651083480', '192.168.253.3', '2014-05-13 14:52:03', ':post', '/login', '{:phone \"13651083480\"}', '1399963923750');
INSERT INTO `e_log` VALUES ('06f606c2-f985-4736-bfed-82e6951aeaaa', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:41:05', ':get', '/getSettings', null, '1399970465656');
INSERT INTO `e_log` VALUES ('078ad9ce-0dd9-4e9c-8f5b-4f53ff29c814', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:34:24', ':get', '/getSalesByChannel/1/1399966052234', null, '1399966464859');
INSERT INTO `e_log` VALUES ('07ab7288-fefb-480b-939b-4bc87ac98057', null, '13651083480', '192.168.253.3', '2014-05-08 09:21:54', ':post', '/login', '{:phone \"13651083480\"}', '1399512114062');
INSERT INTO `e_log` VALUES ('08716db2-2389-423c-a26c-fdfbead55856', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:55:21', ':post', '/saveShare', '{:shop_id \"\", :content \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E4%B8%8A%E5%9C%B0%E5%BA%97%E4%BC%98%E6%83%A0%E5%BE%88%E5%A4%9A%EF%BC%8C%E6%AC%A2%E8%BF%8E%E6%83%A0%E9%A1%BE%E3%80%82\", :fileNameList \"\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399517721625');
INSERT INTO `e_log` VALUES ('08fcfa5b-432b-4e0f-b8b1-c80a85f18f04', null, null, '192.168.253.3', '2014-05-08 10:04:04', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514644046');
INSERT INTO `e_log` VALUES ('08fe037b-68b8-497b-9ae5-b0b5dcbfc36b', null, '13651083480', '192.168.253.3', '2014-05-13 16:01:43', ':get', '/getSalesByChannel/1/1399967947359', null, '1399968103250');
INSERT INTO `e_log` VALUES ('090b78d9-db96-4af3-ac90-160f2a5e6677', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:18:12', ':get', '/demo/getSettings', null, '1399616292964');
INSERT INTO `e_log` VALUES ('09b1cede-db92-4928-b193-51349619ccc2', null, '13651083480', '192.168.253.3', '2014-05-13 15:17:22', ':post', '/login', '{:phone \"13651083480\"}', '1399965442421');
INSERT INTO `e_log` VALUES ('09f2e66f-2f88-48c9-b79a-834f228ece03', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:48:06', ':get', '/getSalesByChannel/1/1399970777078', null, '1399970886687');
INSERT INTO `e_log` VALUES ('0a71ae96-4d3c-44a9-9cf2-e22acea47bd3', null, null, '192.168.253.3', '2014-05-08 09:59:05', ':get', '/getImageFile/748488426_1399514332755.png', null, '1399514345765');
INSERT INTO `e_log` VALUES ('0a7404ba-e79e-4e26-be0c-bf5e4ba9e889', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:49:04', ':get', '/getSalesByChannel/1/1399970886750', null, '1399970944437');
INSERT INTO `e_log` VALUES ('0a9a1c29-1376-4188-86ae-61c8371fa13a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:48:06', ':get', '/getSalesByChannel/0/1399451070468', null, '1399452486046');
INSERT INTO `e_log` VALUES ('0abb3eab-3c4d-43f3-9de3-d473103198bb', null, '13651083480', '192.168.253.3', '2014-05-09 08:33:29', ':get', '/getSalesByChannel/1/1399595538468', null, '1399595609375');
INSERT INTO `e_log` VALUES ('0b5c9f74-d737-4bf8-b10f-daa688ee367b', null, null, '192.168.253.1', '2014-05-16 14:49:06', ':get', '/app/barcode.html', null, '1400222946078');
INSERT INTO `e_log` VALUES ('0bb64b9c-f184-417d-9911-caa21b8e7d45', null, null, '192.168.253.3', '2014-05-09 08:41:08', ':get', '/pub/grade_shop.html', null, '1399596068046');
INSERT INTO `e_log` VALUES ('0bc70dbc-dd43-42d8-a881-059d79c4289b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:52', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399452952500', null, '1399453132015');
INSERT INTO `e_log` VALUES ('0bc95039-e470-4520-be59-ef39b8e38996', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:47:58', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"i妞妞\"}', '1399448878812');
INSERT INTO `e_log` VALUES ('0c1783a8-2ded-49da-9197-7ae98e8c4c5b', null, '1', '192.168.253.3', '2014-05-13 15:47:48', ':post', '/login', '{:phone \"1\"}', '1399967268796');
INSERT INTO `e_log` VALUES ('0c2b4147-8220-4b2c-9b1e-f500cdacd584', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:13:40', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399454020421');
INSERT INTO `e_log` VALUES ('0c588566-5b20-4492-9458-f31ce12ce047', null, '13651083480', '223.203.193.252', '2014-05-09 16:31:45', ':get', '/demo/getChannels', null, '1399624305776');
INSERT INTO `e_log` VALUES ('0c6d4c42-d63b-4c10-8def-f2bb2ff8cdc7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 15:28:40', ':get', '/demo/getUserGradeItems/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399620520651');
INSERT INTO `e_log` VALUES ('0cc648f8-285b-4678-8928-892435936b03', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:55:52', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971352812');
INSERT INTO `e_log` VALUES ('0d1d588f-792a-4efb-8638-18b55604630d', null, '13651083480', '192.168.253.3', '2014-05-13 16:37:04', ':post', '/login', '{:phone \"13651083480\"}', '1399970224546');
INSERT INTO `e_log` VALUES ('0d35e929-5255-49ec-8668-9efa0017ecc1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:13:18', ':get', '/demo/getSalesByDistance/40.073684/116.242457/20/0', null, '1399615998886');
INSERT INTO `e_log` VALUES ('0d6fc395-98c6-4b9f-ae86-8838a55ca22a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:44:46', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"address\", :value \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B71\", :fileNameList \"\"}', '1399513486640');
INSERT INTO `e_log` VALUES ('0dc06344-ebf1-4ae7-a4a1-0bbbedc92d6c', null, null, '192.168.253.3', '2014-05-13 14:42:49', ':get', '/getImageFile/506413869_1399963350419.png', null, '1399963369921');
INSERT INTO `e_log` VALUES ('0e052dd5-601a-48b6-b747-4c2780cb6948', null, '1', '192.168.253.3', '2014-05-08 16:14:51', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536891671');
INSERT INTO `e_log` VALUES ('0e0b365b-d497-4719-afcc-ee0bb1f51c63', null, '13651083480', '223.203.193.252', '2014-05-09 16:31:58', ':get', '/demo/getSalesByChannel/1/1399624309714', null, '1399624318917');
INSERT INTO `e_log` VALUES ('0e6297b8-f700-4ee8-9eca-9b8532f06780', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:45:50', ':get', '/getModules/discover', null, '1399607150468');
INSERT INTO `e_log` VALUES ('0e636571-3ad3-489f-b0ab-035393f9f145', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:32', ':get', '/getModules/me', null, '1399530812968');
INSERT INTO `e_log` VALUES ('0e835b6f-4c07-46e4-82f6-12f68d93f13a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 13:38:15', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399959495046');
INSERT INTO `e_log` VALUES ('0e87fc8a-24b0-4b9c-a558-09c3679ad592', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:08', ':get', '/getSalesByChannel/1/1399530810859', null, '1399533908453');
INSERT INTO `e_log` VALUES ('0ec698ad-175a-48ce-8716-79d620f27be0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:10:43', ':get', '/demo/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399615843558');
INSERT INTO `e_log` VALUES ('0eda625c-d99d-4952-828e-e3041bac0fbe', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:52:52', ':get', '/getSalesByChannel/1/1399967543390', null, '1399967572812');
INSERT INTO `e_log` VALUES ('0f21573a-5e57-48a8-8eb0-518a9b94bb72', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:00:28', ':post', '/searchUsers', '{:search-word \"1\"}', '1399971628718');
INSERT INTO `e_log` VALUES ('0f2fd0a6-c84a-47e9-9882-61a7fab5a9ee', null, '13651083480', '118.194.195.3', '2014-05-09 14:43:25', ':get', '/demo/getModules/me', null, '1399617805636');
INSERT INTO `e_log` VALUES ('0f333926-c445-44f4-957e-da33b9865a92', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:44:58', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399967049562', null, '1399967098937');
INSERT INTO `e_log` VALUES ('0f3cd0aa-473d-48bb-977f-9a69aa4e1e53', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 10:58:33', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399949913954');
INSERT INTO `e_log` VALUES ('0f4b37c0-e0df-40b9-8a18-34e0c1ef3abb', null, '13651083480', '192.168.253.3', '2014-05-13 14:12:07', ':get', '/getSalesByChannel/1/1399959836484', null, '1399961527593');
INSERT INTO `e_log` VALUES ('0ff9daa1-e35e-4ef1-8418-b85ebe3f8a2e', null, null, '192.168.253.3', '2014-05-08 10:08:42', ':get', '/getImageFile/-810116522_1399514888415.png', null, '1399514922796');
INSERT INTO `e_log` VALUES ('10053483-4f4a-4be0-8994-088bc29be1c2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:28', ':get', '/getSalesByChannel/2/1399521443171', null, '1399521448265');
INSERT INTO `e_log` VALUES ('105a7e7e-002f-4b54-b7ae-cfad6f659c39', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:40:01', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399603201453');
INSERT INTO `e_log` VALUES ('10c8594d-6445-489d-83f3-8273ca01af3a', null, '13651083480', '192.168.253.3', '2014-05-13 16:40:49', ':post', '/login', '{:phone \"13651083480\"}', '1399970449703');
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
INSERT INTO `e_log` VALUES ('12a3f5a0-d096-4d84-bfed-dbd066286481', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:13:31', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399950811423');
INSERT INTO `e_log` VALUES ('12bd4ff8-7b95-4624-8000-ed029d3313e0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 11:32:51', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399606371515');
INSERT INTO `e_log` VALUES ('12f0b3e2-5ba4-4386-9f7e-ad7caf9b3ba3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:35:58', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606558390');
INSERT INTO `e_log` VALUES ('130b34e0-44d3-47fe-9b1b-3ad2c5e4cb6c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:52:06', ':get', '/getShopsByDistance/40.07371/116.24245/2000/0', null, '1399971126234');
INSERT INTO `e_log` VALUES ('135c8326-fb21-44cf-9569-22f3e03d8e10', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 15:30:43', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399620643214');
INSERT INTO `e_log` VALUES ('135d966f-0a81-4603-b9dd-301c3bd94d44', null, '13651083480', '192.168.253.3', '2014-05-08 09:52:57', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399513964667.png\"}', '1399513977125');
INSERT INTO `e_log` VALUES ('13fc67df-4c49-4d89-a48b-690377341bc3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:07', ':get', '/getSalesByChannel/1/1399450446671', null, '1399450447125');
INSERT INTO `e_log` VALUES ('141c087f-bd88-463e-84de-d17c8ee014b5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:34', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453294828');
INSERT INTO `e_log` VALUES ('1458f5cd-b934-4192-868f-6f9654f1438e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:28', ':post', '/loginShop', '{:user_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399595548281');
INSERT INTO `e_log` VALUES ('1496e47a-7273-4c21-a0a4-515dec9579e7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:40:06', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399966780671', null, '1399966806359');
INSERT INTO `e_log` VALUES ('14a31d6d-d79f-4ae6-9033-64b50e1d879f', null, '13651083480', '192.168.253.3', '2014-05-13 16:02:06', ':post', '/login', '{:phone \"13651083480\"}', '1399968126796');
INSERT INTO `e_log` VALUES ('14da3335-d8d0-4681-9401-1b6e331b2986', null, '13651083480', '192.168.253.3', '2014-05-13 13:35:10', ':post', '/login', '{:phone \"13651083480\"}', '1399959310625');
INSERT INTO `e_log` VALUES ('156e309e-7fc0-47c9-aead-1dc707ff2f66', null, null, '192.168.253.3', '2014-05-08 09:22:04', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512124921');
INSERT INTO `e_log` VALUES ('1577044c-53be-4059-a1a7-15e1fc2b3068', null, null, '192.168.253.3', '2014-05-08 10:41:11', ':get', '/getImageFile/463517179_1399516848803.png', null, '1399516871937');
INSERT INTO `e_log` VALUES ('15dc10c6-fc72-4c7f-bb82-640a3686d933', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:44', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453124406');
INSERT INTO `e_log` VALUES ('15e5f89d-75ed-4405-9dd6-43e475a32670', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:51:19', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399539079640');
INSERT INTO `e_log` VALUES ('15eb62a6-a727-4405-8780-10bfe4d2c56a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:56:13', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528573109');
INSERT INTO `e_log` VALUES ('16539f3d-5cfb-467b-80f5-20eb4a2e37e5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:33:29', ':get', '/demo/getShopsByDistance/40.073731/116.242443/2000/0', null, '1399624409855');
INSERT INTO `e_log` VALUES ('16ce53e8-c4f5-4b1d-a323-9497c3479ba8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:11:48', ':get', '/getShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399968708390');
INSERT INTO `e_log` VALUES ('17208a11-edca-4e34-a45b-f0404b2c5bad', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 13:20:22', ':get', '/getSalesByChannel/1/1399958390843', null, '1399958422453');
INSERT INTO `e_log` VALUES ('17e139b2-8bc5-4ee5-8bd8-0d9f70c39f47', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:37', ':post', '/demo/addSaleDiscuss', '{:sale_id \"fc7c8598-fea8-4b85-9933-d5fe9a1ac725\", :publisher \"36a9a92d-9f19-4a8b-a566-841b5cf258af\", :content \"发发发\"}', '1399616497261');
INSERT INTO `e_log` VALUES ('17eef8fb-3aab-4369-9e41-c7953b0a6470', null, '13651083480', '192.168.253.3', '2014-05-07 17:43:21', ':post', '/login', '{:phone \"13651083480\"}', '1399455801671');
INSERT INTO `e_log` VALUES ('18090f57-6f25-49eb-a234-190dba17fc8e', null, '13651083480', '192.168.253.3', '2014-05-08 09:13:15', ':post', '/login', '{:phone \"13651083480\"}', '1399511595828');
INSERT INTO `e_log` VALUES ('180f7f5c-ac9d-4ef5-ac7b-9d9f2ee314d1', null, '13651083480', '192.168.253.3', '2014-05-08 09:05:30', ':post', '/login', '{:phone \"13651083480\"}', '1399511130109');
INSERT INTO `e_log` VALUES ('1831d5b6-f3d3-4eb1-b935-de7fa7822ae1', null, '1', '192.168.253.3', '2014-05-09 10:19:56', ':post', '/login', '{:phone \"1\"}', '1399601996609');
INSERT INTO `e_log` VALUES ('18330ddc-74f2-4a5e-9e19-1db203b5cb20', null, '13651083480', '192.168.253.3', '2014-05-09 11:30:20', ':post', '/login', '{:phone \"13651083480\"}', '1399606220515');
INSERT INTO `e_log` VALUES ('184a5c20-a87a-4868-ad21-7447a4a7ab94', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:56:48', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517808468');
INSERT INTO `e_log` VALUES ('18b326ed-a291-471a-85d0-16d4c6bd7677', null, '13651083480', '192.168.253.3', '2014-05-09 11:45:25', ':get', '/getChannels', null, '1399607125796');
INSERT INTO `e_log` VALUES ('18c8e9bf-5c3e-4b9b-aa98-68a3ee58cc64', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:29:35', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606175296');
INSERT INTO `e_log` VALUES ('190d8588-9793-4228-992e-96ce38552058', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:39:46', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451983821.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242442%2C%22radius%22%3A40.0625%2C%22latitude%22%3A40.073733%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451983821.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\", \"-1400089674_1399451983821.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-4374092049493088978.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451983821.png\"}}', '1399451986296');
INSERT INTO `e_log` VALUES ('19223438-8891-4b3c-8f88-964b344c21e3', null, null, '118.194.195.3', '2014-05-09 14:03:08', ':get', '/demo/barcode.html', null, '1399615388308');
INSERT INTO `e_log` VALUES ('1956413d-982d-4481-9242-1823426ec726', null, '13651083480', '118.194.195.3', '2014-05-09 14:20:59', ':get', '/demo/getFriendShares/36a9a92d-9f19-4a8b-a566-841b5cf258af/1399616036787', null, '1399616459245');
INSERT INTO `e_log` VALUES ('197ed8f7-a531-43be-89f1-69c6ad49b299', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:42:46', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399516966859');
INSERT INTO `e_log` VALUES ('197f38f5-3aa9-4cd8-a99d-ebd06964c0c1', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:19', ':get', '/getSalesByChannel/0/1399530793906', null, '1399530799578');
INSERT INTO `e_log` VALUES ('1995ae4f-b155-4121-b767-6a2190164e9f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:37', ':get', '/demo/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399616797636');
INSERT INTO `e_log` VALUES ('19d25bda-3e17-4420-8a4d-d4fac97c813f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:55:01', ':get', '/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399971295265', null, '1399971301406');
INSERT INTO `e_log` VALUES ('1a309f8e-43c6-47f3-838a-c00c29e02b0a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 13:19:39', ':get', '/getSettings', null, '1399958379078');
INSERT INTO `e_log` VALUES ('1a695663-03d3-4939-bc6b-a0daf7b3d048', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:13', ':get', '/getSalesByChannel/0/1399449255687', null, '1399450273500');
INSERT INTO `e_log` VALUES ('1a6a8ecc-7730-4359-871e-ff37fc44209b', null, '13651083480', '192.168.253.3', '2014-05-13 09:30:06', ':post', '/login', '{:phone \"1\"}', '1399944606595');
INSERT INTO `e_log` VALUES ('1a7b29c3-85c4-45fa-9750-ce588f72e1fb', null, '13651083480', '192.168.253.3', '2014-05-08 15:24:31', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399533871453');
INSERT INTO `e_log` VALUES ('1a7c0c8b-a067-4b62-9d44-6defc61a98fd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:45:31', ':get', '/getSalesByChannel/1/1399967085484', null, '1399967131453');
INSERT INTO `e_log` VALUES ('1ab1b26a-a4d3-469f-b764-e7173fb50332', null, null, '192.168.253.1', '2014-05-07 16:31:55', ':get', '/aa', null, '1399451515359');
INSERT INTO `e_log` VALUES ('1afdc2f8-3e4c-4c55-b050-f0247a9d43e0', null, null, '118.194.195.3', '2014-05-09 14:09:16', ':get', '/demo/getImageFile/602324364_1399449344230.png', null, '1399615756730');
INSERT INTO `e_log` VALUES ('1b41cd9f-9980-4a9d-9bbf-eef679f1f867', null, '13651083480', '192.168.253.3', '2014-05-13 14:49:09', ':get', '/getSalesByChannel/1/1399963521109', null, '1399963749656');
INSERT INTO `e_log` VALUES ('1b5546ef-d7b7-4066-aa80-0eb64727769a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 09:27:19', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399944439782');
INSERT INTO `e_log` VALUES ('1bbae5ab-e6d8-475e-b2d6-a7b625d1c59f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:30', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399449090046');
INSERT INTO `e_log` VALUES ('1bdf8f53-9cd2-45f5-a060-78b147e3b8c1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:53:51', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399521231937');
INSERT INTO `e_log` VALUES ('1c1a5be6-84e7-4fbc-b312-1f794c1011e3', null, '13651083480', '118.194.195.3', '2014-05-09 15:27:57', ':get', '/demo/getFriendShares/d480ed24-b6a5-4bad-a6fc-ca2337c09f15/1399620043827', null, '1399620477480');
INSERT INTO `e_log` VALUES ('1c4464a7-eda9-42a1-a207-41882b4a2087', null, '13651083480', '118.194.195.3', '2014-05-09 14:43:07', ':get', '/demo/getChannels', null, '1399617787948');
INSERT INTO `e_log` VALUES ('1c5203e0-800a-48e0-9fb5-4970053ce1f2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:44:09', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399966840078', null, '1399967049515');
INSERT INTO `e_log` VALUES ('1c56297d-6930-489b-ab2e-aac9a3492112', null, null, '192.168.253.3', '2014-05-07 17:43:41', ':get', '/getImageFile/barcode_-509784425_1399452076140.png', null, '1399455821218');
INSERT INTO `e_log` VALUES ('1c9b9f2d-41a4-4491-882c-f4afbbb2bf68', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:43:40', ':get', '/demo/getSalesByChannel/1/1399617800261', null, '1399617820948');
INSERT INTO `e_log` VALUES ('1d5c667f-e784-4738-bb2b-4a5b877c2c0c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:13:10', ':get', '/demo/getShopsByDistance/40.073684/116.242457/5/0', null, '1399615990214');
INSERT INTO `e_log` VALUES ('1d6a4177-18da-4c98-afcd-b8e622163442', null, '13651083480', '192.168.253.3', '2014-05-13 14:43:09', ':post', '/login', '{:phone \"13651083480\"}', '1399963389828');
INSERT INTO `e_log` VALUES ('1e0d1c21-36df-40f1-9d0a-12aef9cd2e43', null, '13651083480', '192.168.253.3', '2014-05-08 11:51:16', ':post', '/login', '{:phone \"13651083480\"}', '1399521076328');
INSERT INTO `e_log` VALUES ('1e257fb2-4b41-4042-be36-afb4b74ed0c5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:03:22', ':get', '/getSalesByChannel/3/1399971801140', null, '1399971802562');
INSERT INTO `e_log` VALUES ('1e445597-b428-4556-9384-d3647fd9c6b2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:33:28', ':get', '/demo/getSalesByDistance/40.073731/116.242443/2000/0', null, '1399624408480');
INSERT INTO `e_log` VALUES ('1e623aa6-2301-4cf4-9808-a8b064ce9e0c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:19:08', ':get', '/demo/getShopFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616348026');
INSERT INTO `e_log` VALUES ('1e68beb3-99d5-466f-a35b-878e30202868', null, null, '118.194.195.3', '2014-05-09 14:09:45', ':get', '/demo/getImageFile/748488426_1399514332755.png', null, '1399615785558');
INSERT INTO `e_log` VALUES ('1ea9bc91-67e6-46be-9c65-789e8804c534', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:10', ':get', '/getSettings', null, '1399517050953');
INSERT INTO `e_log` VALUES ('1f2229de-9486-4c0a-9403-19d49252ce03', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:11:21', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399515081765');
INSERT INTO `e_log` VALUES ('1f306aa1-19d7-48b9-a6d7-492f19499b8d', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:17:58', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616278105');
INSERT INTO `e_log` VALUES ('1f9fc324-fb10-4634-bf65-16e25510fa80', null, '13651083480', '192.168.253.3', '2014-05-08 09:08:31', ':post', '/login', '{:phone \"13651083480\"}', '1399511311500');
INSERT INTO `e_log` VALUES ('200cccb3-2ba5-4248-ac5b-7f945eef2753', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:53:59', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521239281');
INSERT INTO `e_log` VALUES ('20e15817-6cec-452f-a046-a2fffe7d70cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:41', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528361796');
INSERT INTO `e_log` VALUES ('2159a666-6ebb-4a8d-b081-0253adc858d0', null, null, '118.194.195.3', '2014-05-09 14:09:45', ':get', '/demo/getImageFile/748488426_1399514332755.png', null, '1399615785558');
INSERT INTO `e_log` VALUES ('2175d136-1d2d-4f97-9eb9-a9bc71c197a7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:43:18', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399963398046');
INSERT INTO `e_log` VALUES ('2183a7b6-a99f-421c-beec-6af810208252', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:14', ':get', '/getModules/discover', null, '1399446374921');
INSERT INTO `e_log` VALUES ('219ed265-0c6d-4226-9058-091665da0880', null, null, '192.168.253.3', '2014-05-08 09:10:30', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399511430640');
INSERT INTO `e_log` VALUES ('21bb9a84-89a8-4a23-901f-782f9af6ec22', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:15:36', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399615649792', null, '1399616136839');
INSERT INTO `e_log` VALUES ('21d2eddd-3822-4efe-a49c-60933b3f677f', null, '13651083480', '118.194.195.3', '2014-05-09 14:25:23', ':get', '/demo/getSalesByChannel/1/1399616712386', null, '1399616723948');
INSERT INTO `e_log` VALUES ('22669777-bbdc-47c0-a57f-e912bd92fd3d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:45:33', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399531533718');
INSERT INTO `e_log` VALUES ('227de008-b2ea-4eb7-b91e-983b5efc08b4', null, '13651083480', '192.168.253.3', '2014-05-13 15:59:06', ':post', '/login', '{:phone \"13651083480\"}', '1399967946984');
INSERT INTO `e_log` VALUES ('2295e41f-234c-4b3d-98d7-2b321475c468', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:28', ':get', '/getSalesByChannel/0/1399452890000', null, '1399453348296');
INSERT INTO `e_log` VALUES ('22d40a94-5a37-4c93-8aef-37ca6795d376', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:39:04', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451941843.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A43.61538314819336%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451941843.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\", \"-1400089674_1399451941843.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7030770994781893059.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451941843.png\"}}', '1399451944187');
INSERT INTO `e_log` VALUES ('22f4d41c-43a5-4bc9-988e-640c2556c785', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:05', ':get', '/getModules/me', null, '1399448705687');
INSERT INTO `e_log` VALUES ('22fe4eec-5f60-4b36-93a4-6a9081ed45ff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:14', ':get', '/getSalesByChannel/1/1399450273562', null, '1399450274187');
INSERT INTO `e_log` VALUES ('232eff68-a040-4085-960b-6f3ec4717eb2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:25:52', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399533952218');
INSERT INTO `e_log` VALUES ('23665cd9-f07e-46b6-a98c-ca1dca2c920a', null, '1', '192.168.253.3', '2014-05-09 10:29:23', ':post', '/login', '{:phone \"1\"}', '1399602563140');
INSERT INTO `e_log` VALUES ('238a4c8f-2483-4932-826a-281608f1dfc5', null, '13651083480', '118.194.195.3', '2014-05-09 14:06:38', ':get', '/demo/getSalesByChannel/1/1399615593464', null, '1399615598120');
INSERT INTO `e_log` VALUES ('23c70a5b-140c-4d78-a981-0cf3cd4f9786', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:01:49', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514494034.png\"}', '1399514509062');
INSERT INTO `e_log` VALUES ('24151ed8-e7a9-40cb-a13f-7a490b3455e4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:10:28', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399511428640');
INSERT INTO `e_log` VALUES ('244217ba-32e9-426e-901a-b8045773c203', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:08:27', ':get', '/getSalesByChannel/1/1399446507625', null, '1399446507828');
INSERT INTO `e_log` VALUES ('247ef96f-59c9-4cfa-a861-b9abb39ebdcd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:45:52', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399607152750');
INSERT INTO `e_log` VALUES ('249dfc74-77be-41f3-9301-65c98023213b', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 10:56:23', ':get', '/getSalesByChannel/1/1399947049720', null, '1399949783220');
INSERT INTO `e_log` VALUES ('24a3d094-9460-4fb9-8a6f-911b8562f0ff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:08:58', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"妞妞11\"}', '1399511338031');
INSERT INTO `e_log` VALUES ('2528b55d-b8ef-47c1-a1ad-4e8b203e7b8f', null, '13651083480', '192.168.253.3', '2014-05-08 16:48:44', ':get', '/getSalesByChannel/1/1399536258750', null, '1399538924359');
INSERT INTO `e_log` VALUES ('253eb26f-6391-4680-b28d-8c58a4ec1c72', null, '13651083480', '192.168.253.3', '2014-05-13 14:45:06', ':get', '/getSalesByChannel/1/1399963506281', null, '1399963506796');
INSERT INTO `e_log` VALUES ('255848ef-e97b-42b1-8d9c-784a8f175f48', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:27:37', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399516057125');
INSERT INTO `e_log` VALUES ('25832416-25da-4781-836a-3a84debc89e7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:48:26', ':get', '/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399970906812');
INSERT INTO `e_log` VALUES ('25b36e8c-b0bd-4f5e-bf89-b52a3830f1db', null, null, '192.168.253.1', '2014-05-07 16:30:02', ':get', '/aa', null, '1399451402000');
INSERT INTO `e_log` VALUES ('25b48fc6-c62d-4557-977e-ffb34da8a852', null, '13651083480', '192.168.253.3', '2014-05-09 11:32:51', ':post', '/login', '{:phone \"13651083480\"}', '1399606371093');
INSERT INTO `e_log` VALUES ('25cf977c-c482-41fe-a835-3cc9dbd4af69', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:48', ':post', '/addShopFavorit', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\"}', '1399452948625');
INSERT INTO `e_log` VALUES ('2652b80e-e028-4002-9332-3b077363a59f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:51:39', ':get', '/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399521367765', null, '1399971099828');
INSERT INTO `e_log` VALUES ('26ad8fdc-4c49-4837-8017-16533bd4635a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:43:26', ':get', '/getSaleFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517006562');
INSERT INTO `e_log` VALUES ('26bdf328-d232-45c0-914c-e2790c80d356', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:47:17', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399963601796', null, '1399963637203');
INSERT INTO `e_log` VALUES ('26d21988-6649-4ad2-a5ce-a3f6d9b352ec', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:39:51', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399966791921');
INSERT INTO `e_log` VALUES ('26d3146b-5ba5-48f9-93f1-fce5e911e9f6', null, '13651083480', '192.168.253.3', '2014-05-13 13:40:50', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399959650375');
INSERT INTO `e_log` VALUES ('26f2876e-b917-4f53-94d0-88f09c1a9503', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:51:25', ':get', '/getSalesByShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399452076125', null, '1399521085156');
INSERT INTO `e_log` VALUES ('2740b349-c41a-436d-809d-130a610ab6aa', null, null, '192.168.253.3', '2014-05-07 17:56:38', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399456598875');
INSERT INTO `e_log` VALUES ('27919ce8-d993-4cad-98a8-c2d3f185552b', null, '13651083480', '192.168.253.3', '2014-05-13 16:32:17', ':post', '/login', '{:phone \"13651083480\"}', '1399969937015');
INSERT INTO `e_log` VALUES ('27f3a1a2-5ace-4494-b923-25db492cac75', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:34:11', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606451140');
INSERT INTO `e_log` VALUES ('28239fa7-c74f-487b-880e-f93340977817', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:38:38', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399595918015');
INSERT INTO `e_log` VALUES ('28d7b203-b9ad-4d3b-b698-b19e8ef5d080', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:28', ':get', '/getSalesByChannel/0/1399453390453', null, '1399453408546');
INSERT INTO `e_log` VALUES ('28fa4548-2642-4fbe-a095-d61b0fa8da25', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:56:46', ':get', '/getSalesByChannel/0/1399515059500', null, '1399521406968');
INSERT INTO `e_log` VALUES ('2923a8ef-c409-4727-ac5d-56272b5114fa', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:40:46', ':get', '/getTrades', null, '1399513246140');
INSERT INTO `e_log` VALUES ('292a553d-8d57-4d7a-908e-c96ce0a93a31', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:56:19', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521379031');
INSERT INTO `e_log` VALUES ('29469f7a-1591-48a9-92cd-717db049934e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:03:34', ':get', '/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971814281');
INSERT INTO `e_log` VALUES ('297023fe-730b-459b-9948-4371ddb797e5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:05:11', ':get', '/getSalesByDistance/40.073683/116.242453/2000/0', null, '1399968311687');
INSERT INTO `e_log` VALUES ('29c7dc28-7de3-4241-b155-a42efe407699', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:11:40', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399968700375');
INSERT INTO `e_log` VALUES ('29eb59a7-98d3-4cda-8a94-7ae98e19742f', null, null, '192.168.253.3', '2014-05-07 16:55:43', ':get', '/getImageFile/barcode_-1897623607_1399449405500.png', null, '1399452943187');
INSERT INTO `e_log` VALUES ('2a4344e4-6392-4e2a-b121-a312a808533b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:56:27', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E7%9A%84%E4%BC%98%E6%83%A0%E5%B9%85%E5%BA%A6%E7%9C%9F%E5%A4%A7\", :fileNameList \"\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399452987562');
INSERT INTO `e_log` VALUES ('2a72844e-35fa-4df3-82b1-66c7b2a3fad2', null, null, '192.168.253.3', '2014-05-07 17:50:13', ':get', '/getImageFile/1711437471_1399456195076.png', null, '1399456213218');
INSERT INTO `e_log` VALUES ('2ab71615-c14b-4845-863b-509479729aeb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:56:27', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399963955937', null, '1399964187187');
INSERT INTO `e_log` VALUES ('2b7f9659-4066-4c34-b18d-64fdcdf7ad22', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 10:08:54', ':get', '/getSalesByChannel/1/1399944608267', null, '1399946934689');
INSERT INTO `e_log` VALUES ('2b8e57f4-9e95-4930-a86a-220eb89bc5bd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:52:27', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971147281');
INSERT INTO `e_log` VALUES ('2bcb1be7-efb4-4499-86c6-acc256ead064', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:56:45', ':post', '/registerShop', '{\"602324364_1399449344230.png\" {:size 282015, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3469479880405305017.tmp>, :content-type \"image/pjpeg\", :filename \"602324364_1399449344230.png\"}, :desc \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E5%A4%A7%E5%93%81%E7%89%8C\", :shop_img \"602324364_1399449344230.png\", \"898289355_1399449344232.png\" {:size 290977, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2058955765726519369.tmp>, :content-type \"image/pjpeg\", :filename \"898289355_1399449344232.png\"}, :name \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E4%B8%8A%E5%9C%B0%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242443%2C%22radius%22%3A44.83333206176758%2C%22latitude%22%3A40.073733%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"602324364_1399449344230.png%7C898289355_1399449344232.png\", :busi_license \"898289355_1399449344232.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"1\"}', '1399449405281');
INSERT INTO `e_log` VALUES ('2bd3388d-4461-46b2-aef1-f40be79c0ecc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 09:27:16', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399944436610');
INSERT INTO `e_log` VALUES ('2c08378c-447b-4a28-b725-f8a227ea1090', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:30', ':get', '/getSalesByChannel/1/1399451069687', null, '1399451070390');
INSERT INTO `e_log` VALUES ('2c372b81-90e6-4e47-8ce4-1aff7faaa9b9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:53', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448693312');
INSERT INTO `e_log` VALUES ('2c563777-a258-4147-9b24-24e0109d1d1a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:49:40', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399538980375');
INSERT INTO `e_log` VALUES ('2c5f2e18-10fd-4d29-bae0-f9ac301f48be', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:31', ':get', '/getSalesByChannel/40/1399521450546', null, '1399521451125');
INSERT INTO `e_log` VALUES ('2c9d64f5-a005-453d-b7de-a80fddd63183', null, '13651083480', '192.168.253.3', '2014-05-08 10:32:38', ':post', '/login', '{:phone \"13651083480\"}', '1399516358265');
INSERT INTO `e_log` VALUES ('2ce79a65-f280-4933-b948-3d0b4fdb634a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:51:59', ':get', '/getSalesByDistance/40.07371/116.24245/2000/0', null, '1399971119453');
INSERT INTO `e_log` VALUES ('2d2d95c7-661a-43b2-9bd7-242204ff3848', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 17:13:19', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399971898078', null, '1399972399281');
INSERT INTO `e_log` VALUES ('2d4b04e0-46a0-4c4a-861d-ada511bae86e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:06:32', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536392140');
INSERT INTO `e_log` VALUES ('2d519c01-88ad-4c9e-9221-f77f67f3a38f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:18:08', ':get', '/demo/getSalesByChannel/2/1399615969651', null, '1399616288167');
INSERT INTO `e_log` VALUES ('2d639bd0-123e-4c50-9f85-de28e250e18c', null, '13651083480', '192.168.253.3', '2014-05-13 16:40:32', ':get', '/getChannels', null, '1399970432265');
INSERT INTO `e_log` VALUES ('2d91934c-4d25-4695-82fb-11939eeb5899', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:45', ':get', '/getSalesByChannel/0/1399446373625', null, '1399446405593');
INSERT INTO `e_log` VALUES ('2dac2705-5269-46e1-b83b-6557d6326402', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:34', ':get', '/demo/getSalesByChannel/1/1399624336292', null, '1399624354198');
INSERT INTO `e_log` VALUES ('2db499bf-d9ec-4de6-9077-71c15cec0ec7', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:54', ':get', '/getChannels', null, '1399448574468');
INSERT INTO `e_log` VALUES ('2e37e831-4942-44db-ac51-857c7ef95047', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:47:46', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528066453');
INSERT INTO `e_log` VALUES ('2e458c73-4c32-4f0c-be75-b13b4f5dc76a', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780156');
INSERT INTO `e_log` VALUES ('2eb8a594-2b48-498e-b26b-528841119ee8', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:42:21', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E9%9D%9E%E5%B8%B8%E6%BB%A1%E6%84%8F%E7%9A%84%E6%B4%BB%E5%8A%A8\", :fileNameList \"\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399516941625');
INSERT INTO `e_log` VALUES ('2ec2e4f6-9d19-49c6-bda3-de9dfa5d78eb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:55', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516791406', null, '1399516795812');
INSERT INTO `e_log` VALUES ('2f34fc40-d1b9-4dca-a099-9e9e43ad7025', null, null, '192.168.253.3', '2014-05-08 09:48:46', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399513726875');
INSERT INTO `e_log` VALUES ('2f3d669a-9340-450d-b754-6b140e56d48a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:45:04', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399617904714');
INSERT INTO `e_log` VALUES ('2f532ece-36cf-497d-b51c-80dc4a7b3109', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:46:42', ':get', '/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399970802671');
INSERT INTO `e_log` VALUES ('30092bd1-0aa4-4a45-853e-48d401142f11', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:27:47', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399516067984');
INSERT INTO `e_log` VALUES ('3017a482-d989-4990-b42b-85be3ce88626', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:56:38', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"1711437471_1399456582365.png\"}', '1399456598156');
INSERT INTO `e_log` VALUES ('302c0a69-570d-4d71-810e-3d4d8a90421e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:14:06', ':get', '/demo/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616046636');
INSERT INTO `e_log` VALUES ('3047e659-2725-4461-acd9-d97b00d707e3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:53', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399452893343');
INSERT INTO `e_log` VALUES ('30a18fc2-5c01-44fd-a4c0-62a8723b8b2f', null, '13651083480', '192.168.253.3', '2014-05-09 11:45:42', ':post', '/login', '{:phone \"1\"}', '1399607142968');
INSERT INTO `e_log` VALUES ('30dc3e4c-2f91-48d5-a872-0edfd5d5f8eb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 17:04:03', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399971843906');
INSERT INTO `e_log` VALUES ('314e9b66-4869-4d0d-b97e-bddd4e9a9cd1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:10:01', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399615801558');
INSERT INTO `e_log` VALUES ('318b8bbe-7ab3-47da-b295-a34cf416aeaf', null, '13651083480', '192.168.253.3', '2014-05-13 16:11:27', ':post', '/login', '{:phone \"13651083480\"}', '1399968687750');
INSERT INTO `e_log` VALUES ('31a15513-4c4c-4b8b-9ec2-34b806cf4b7d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:25:30', ':get', '/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399969530531');
INSERT INTO `e_log` VALUES ('32ba5d37-f021-4533-9132-769ba7f81b80', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:33:05', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399595585859');
INSERT INTO `e_log` VALUES ('332324e3-738d-4c5c-ac37-34dbac6ad3dc', null, null, '118.194.195.3', '2014-05-09 14:20:02', ':get', '/demo/app/YouGouHui.apk', null, '1399616402245');
INSERT INTO `e_log` VALUES ('332b6750-45e0-4023-befb-f00f9f51177a', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:22', ':get', '/demo/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399521367765', null, '1399616482230');
INSERT INTO `e_log` VALUES ('33685fdc-ba3b-4c9d-955d-1a8f4139b9cd', null, null, '192.168.253.1', '2014-05-16 14:48:58', ':get', '/favicon.ico', null, '1400222938640');
INSERT INTO `e_log` VALUES ('337bdf55-b17a-4759-8ff2-2f528afa7dca', null, '13651083480', '192.168.253.3', '2014-05-07 15:54:14', ':post', '/login', '{:phone \"13651083480\"}', '1399449254062');
INSERT INTO `e_log` VALUES ('33b44499-a933-4c92-82d3-79bba273166c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:26:01', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399533961375');
INSERT INTO `e_log` VALUES ('33f02ec4-a0b5-4650-ae81-cddf42102099', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 10:10:54', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399947054735');
INSERT INTO `e_log` VALUES ('341fcc1b-a749-466c-b9d1-256ba12b8b4a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:52:12', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399971132906');
INSERT INTO `e_log` VALUES ('342a8d26-790a-4217-a21c-a6378aa7f353', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 11:42:45', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399520565531');
INSERT INTO `e_log` VALUES ('3430f6d6-98dd-4a64-b481-40023cb7177f', null, '13651083480', '192.168.253.3', '2014-05-13 14:52:16', ':get', '/getSalesByChannel/1/1399963924343', null, '1399963936812');
INSERT INTO `e_log` VALUES ('343dfb6c-8d58-4574-94a3-a10eace67e5d', null, '13651083480', '192.168.253.3', '2014-05-07 15:44:30', ':post', '/login', '{:phone \"13651083480\"}', '1399448670796');
INSERT INTO `e_log` VALUES ('3442f35e-80d8-431b-845c-77d13de93936', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:11:12', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399515072515');
INSERT INTO `e_log` VALUES ('34484246-3ba8-4c95-a958-816bf0f6b2a0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:33:05', ':get', '/demo/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399624385401');
INSERT INTO `e_log` VALUES ('347ba586-f5e3-4ab6-a491-c9a3e3f488bd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:51:39', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528299750');
INSERT INTO `e_log` VALUES ('3487c924-1581-410d-b9f2-9d401f3d4380', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:25:35', ':get', '/demo/getSalesByChannel/1/1399616723948', null, '1399616735417');
INSERT INTO `e_log` VALUES ('34ed1ec8-e1ea-4ea5-8fdf-c5a4f986a5b4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:45', ':get', '/getShopShares/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399530825843');
INSERT INTO `e_log` VALUES ('34ef156d-eb55-4b3c-8543-71bf3bb92f91', null, '13651083480', '192.168.253.3', '2014-05-13 16:24:57', ':post', '/login', '{:phone \"13651083480\"}', '1399969497234');
INSERT INTO `e_log` VALUES ('350c2160-d6a0-4b40-8cb9-c1c8dacd01fc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:25:46', ':post', '/demo/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399616746276');
INSERT INTO `e_log` VALUES ('350d687b-23c9-49b6-a766-0442f8ba04a0', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:52', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450730525.png\", :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242447%2C%22radius%22%3A39.31818389892578%2C%22latitude%22%3A40.073715%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450730525.png\", \"463517179_1399450730525.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3605247973725175815.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450730525.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450732265');
INSERT INTO `e_log` VALUES ('3547c4ba-2db0-4e7d-9776-2085da5cdd32', null, null, '192.168.253.3', '2014-05-08 09:40:48', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399513248187');
INSERT INTO `e_log` VALUES ('35545e52-0c95-4330-9f6b-c2932ca0d95d', null, null, '192.168.253.1', '2014-05-07 16:31:26', ':get', '/aa', null, '1399451486437');
INSERT INTO `e_log` VALUES ('355b1058-4ff1-4cd0-aaf9-17f172c02763', null, '1', '192.168.253.3', '2014-05-09 11:27:04', ':post', '/login', '{:phone \"1\"}', '1399606024390');
INSERT INTO `e_log` VALUES ('35809454-e9ad-40ce-bc9e-aa4c59a38bf4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:26:03', ':get', '/getTrades', null, '1399533963031');
INSERT INTO `e_log` VALUES ('361b228b-a1c5-4689-84fd-89e678c5f0bc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:33:25', ':get', '/demo/getSettings', null, '1399624405901');
INSERT INTO `e_log` VALUES ('36346a22-e977-452f-9051-5c2f80af9d64', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:29:13', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399526953906');
INSERT INTO `e_log` VALUES ('36605293-d577-405f-a35a-a04cf8761e29', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:16:27', ':get', '/demo/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616187214');
INSERT INTO `e_log` VALUES ('369fca96-8aca-4c33-b583-cec9c9ffabb0', null, '13651083480', '192.168.253.3', '2014-05-08 14:38:06', ':post', '/login', '{:phone \"13651083480\"}', '1399531086203');
INSERT INTO `e_log` VALUES ('36bb4479-0ba2-4d86-93a5-8d0372b5b6d2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:18:22', ':get', '/demo/getShopsByDistance/4.9E-324/4.9E-324/2000/0', null, '1399616302401');
INSERT INTO `e_log` VALUES ('36bfccb7-8b48-4e11-bc9e-0d9784ff4cf3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:16:57', ':post', '/demo/searchUsers', '{:search-word \"1\"}', '1399616217683');
INSERT INTO `e_log` VALUES ('371a6c0f-0948-4271-a33d-1a449c36f603', null, '13651083480', '192.168.253.3', '2014-05-13 15:13:32', ':post', '/login', '{:phone \"13651083480\"}', '1399965212000');
INSERT INTO `e_log` VALUES ('372a0ee3-f5cb-4388-8b08-4f87cf034105', null, '1', '192.168.253.3', '2014-05-13 14:52:30', ':post', '/login', '{:phone \"1\"}', '1399963950437');
INSERT INTO `e_log` VALUES ('3758f7ed-07c4-4ebb-af52-645c0f6471a4', null, '13651083480', '192.168.253.3', '2014-05-13 09:26:51', ':get', '/getSalesByShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399452076125', null, '1399944411454');
INSERT INTO `e_log` VALUES ('37bcbe2a-fa76-4b12-8252-051f2fa0b06d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:26:36', ':post', '/createShopBarcode', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399515996578');
INSERT INTO `e_log` VALUES ('37e18b00-b2cb-4b68-8fbd-84f9389ee6cc', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:39', ':post', '/demo/addSaleDiscuss', '{:sale_id \"fc7c8598-fea8-4b85-9933-d5fe9a1ac725\", :publisher \"36a9a92d-9f19-4a8b-a566-841b5cf258af\", :content \"发发发\"}', '1399616499855');
INSERT INTO `e_log` VALUES ('380a651c-c7ef-41a3-81ea-4d309138b7ce', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:29', ':get', '/getSalesByChannel/0/1399450999750', null, '1399451069656');
INSERT INTO `e_log` VALUES ('3855b996-e201-4a97-8951-7b3e67df60a5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:38', ':post', '/searchUsers', '{:search-word \"妞妞\"}', '1399516778156');
INSERT INTO `e_log` VALUES ('38b982f1-947f-4024-acd5-3d474070bd0e', null, '1', '192.168.253.3', '2014-05-08 16:10:15', ':post', '/login', '{:phone \"1\"}', '1399536615296');
INSERT INTO `e_log` VALUES ('3979598a-5001-402e-a65c-0e292ac4bb3e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 10:57:30', ':get', '/getSalesByChannel/1/1399949783251', null, '1399949850189');
INSERT INTO `e_log` VALUES ('397c6cb6-65c4-4ee7-8d6d-3ce3657201c6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:44:42', ':get', '/getSalesByChannel/1/1399970458359', null, '1399970682078');
INSERT INTO `e_log` VALUES ('398db1c9-9136-4f05-a017-b1be88a6265c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 13:19:50', ':get', '/getSalesByChannel/1/1399958375218', null, '1399958390765');
INSERT INTO `e_log` VALUES ('39d19293-a728-4d4d-a21a-dc4a892849f0', null, '13651083480', '192.168.253.3', '2014-05-13 14:49:20', ':post', '/login', '{:phone \"13651083480\"}', '1399963760093');
INSERT INTO `e_log` VALUES ('3a0f755c-8cdb-4d58-9ffb-b14b831b07e8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:27:45', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399516065015');
INSERT INTO `e_log` VALUES ('3a5555ef-d36c-49b0-905f-e4bbb469a7d5', null, null, '192.168.253.3', '2014-05-08 09:24:09', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512249765');
INSERT INTO `e_log` VALUES ('3a67a9e6-41bb-4da0-8ca5-48fcbfc54af3', null, '1', '192.168.253.3', '2014-05-13 11:10:41', ':post', '/login', '{:phone \"1\"}', '1399950641079');
INSERT INTO `e_log` VALUES ('3ab15c00-ed6f-4e3d-beb7-b05bad20b4de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:05', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450445765');
INSERT INTO `e_log` VALUES ('3ae29021-075f-4fef-b595-f9caf62c97e5', null, null, '192.168.253.3', '2014-05-08 09:13:28', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399511608671');
INSERT INTO `e_log` VALUES ('3b13d551-7e62-49f2-8a75-2d572bbe95df', null, '1', '192.168.253.3', '2014-05-08 16:17:10', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399537030890');
INSERT INTO `e_log` VALUES ('3b2a5a9f-4b87-4df0-9d40-54c1eb1d5c04', null, '1', '192.168.253.3', '2014-05-09 10:37:32', ':post', '/login', '{:phone \"1\"}', '1399603052140');
INSERT INTO `e_log` VALUES ('3bfbd918-4f6c-4474-8009-949de9ee38e4', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:28', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517068437');
INSERT INTO `e_log` VALUES ('3c161fcd-510a-4057-9e1d-0e0af5be4ed4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:28', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399452868843');
INSERT INTO `e_log` VALUES ('3cca892b-2108-4c99-9a31-ead28d402dc0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 11:30:21', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606221125');
INSERT INTO `e_log` VALUES ('3ce09b10-6538-4c17-89ef-119c34d5b1b0', null, '13651083480', '192.168.253.3', '2014-05-07 16:24:28', ':post', '/login', '{:phone \"13651083480\"}', '1399451068687');
INSERT INTO `e_log` VALUES ('3d15a189-9b0b-4441-8fba-debc4e5f6ef5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:55:28', ':get', '/getShopFavoritesByUser/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971328312');
INSERT INTO `e_log` VALUES ('3d48544c-8421-4763-b992-1c66da743980', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:33:04', ':get', '/demo/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399624384714');
INSERT INTO `e_log` VALUES ('3d822834-0867-480e-87f8-3c3149b5b3b6', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:55', ':get', '/getSalesByChannel/0/-1', null, '1399448575906');
INSERT INTO `e_log` VALUES ('3db6c4af-8ab5-45df-a396-3420842b2c97', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:15:18', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450516336.png\", :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A41.633331298828125%2C%22latitude%22%3A40.073734%7D\", \"463517179_1399450516336.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2483613127985079083.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450516336.png\"}, :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450516336.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450518328');
INSERT INTO `e_log` VALUES ('3dbe0646-4d9f-4b6b-83b2-009ab767cf75', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:42:03', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399596123140');
INSERT INTO `e_log` VALUES ('3ded2e94-8165-4f2f-9844-16e1941e7b1d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:34:16', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399530856234');
INSERT INTO `e_log` VALUES ('3dfe9387-38c9-4ad1-8f77-2273dc83e0fd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:45:35', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399967099015', null, '1399967135015');
INSERT INTO `e_log` VALUES ('3e5f0d37-0b9d-4104-87d4-802b1d8efb35', null, '1', '192.168.253.3', '2014-05-09 10:40:01', ':post', '/login', '{:phone \"1\"}', '1399603201046');
INSERT INTO `e_log` VALUES ('3e637bfa-8616-4c05-91d5-41acbcb4f39a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:02:07', ':get', '/getSalesByChannel/1/1399968103296', null, '1399968127234');
INSERT INTO `e_log` VALUES ('3eb3b157-8456-4724-9baa-7407c6959df6', null, '13651083480', '192.168.253.3', '2014-05-13 09:29:51', ':get', '/getSalesByChannel/1/1399944428939', null, '1399944591876');
INSERT INTO `e_log` VALUES ('3f0342ac-8435-45bf-bb96-f2d3f6c3ca63', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:53:13', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399517584468', null, '1399517593281');
INSERT INTO `e_log` VALUES ('3f4a7868-73cb-4de1-ae5c-4287ec1aaec7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:39:32', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399966471234', null, '1399966772187');
INSERT INTO `e_log` VALUES ('3f55fb8d-05d5-47f2-884f-d2c06ec9a3f5', null, null, '192.168.253.3', '2014-05-08 11:56:08', ':get', '/getImageFile/-354365311_1399521331897.png', null, '1399521368593');
INSERT INTO `e_log` VALUES ('3f72973b-0cf6-47bc-add7-049ce3876444', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:14', ':get', '/getSalesByChannel/1/1399446554312', null, '1399446554687');
INSERT INTO `e_log` VALUES ('3f8b2d4a-ed10-49dd-807e-009b4624548a', null, '13651083480', '118.194.195.3', '2014-05-09 14:08:19', ':get', '/demo/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/43f79202-6ea1-4c38-b923-b9fdeb013932', null, '1399615699386');
INSERT INTO `e_log` VALUES ('3f93a040-3dd5-4a8b-a272-90244a213e77', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:32:01', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399527121468');
INSERT INTO `e_log` VALUES ('3fbde255-1353-4ded-b9c4-2b623126ee52', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:15', ':get', '/getSalesByChannel/1/1399449255171', null, '1399449255593');
INSERT INTO `e_log` VALUES ('403dd564-de6f-44ef-a1f0-0b69345ddc23', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:34', ':post', '/demo/addSaleDiscuss', '{:sale_id \"fc7c8598-fea8-4b85-9933-d5fe9a1ac725\", :publisher \"36a9a92d-9f19-4a8b-a566-841b5cf258af\", :content \"发发发\"}', '1399616494448');
INSERT INTO `e_log` VALUES ('406b7e76-3cad-44cd-9a18-689a05b91e66', null, null, '192.168.253.3', '2014-05-07 16:55:43', ':get', '/getImageFile/898289355_1399449344232.png', null, '1399452943171');
INSERT INTO `e_log` VALUES ('40782aae-c5aa-48c0-b626-c4b4e477bdc5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:38:10', ':post', '/saveUserPhoto', '{:photo \"1321682725_1399516655545.png\", :fileNameList \"1321682725_1399516655545.png\", :uuid \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", \"1321682725_1399516655545.png\" {:size 244049, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-4907002354317488150.tmp>, :content-type \"image/pjpeg\", :filename \"1321682725_1399516655545.png\"}}', '1399516690390');
INSERT INTO `e_log` VALUES ('41ba8fce-dad0-4049-919a-39283ee1d0aa', null, '13651083480', '118.194.195.3', '2014-05-09 14:17:52', ':post', '/demo/login', '{:phone \"1\"}', '1399616272792');
INSERT INTO `e_log` VALUES ('42020c41-8503-4738-912a-d8800e5a1434', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:33', ':post', '/addSaleFavorit', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453533531');
INSERT INTO `e_log` VALUES ('4249258e-cb7e-4657-9feb-aa6a6116fffb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:08:49', ':post', '/saveUserPhoto', '{:photo \"940407648_1399511322875.png\", :fileNameList \"940407648_1399511322875.png\", :uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", \"940407648_1399511322875.png\" {:size 46837, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-5836286651036149654.tmp>, :content-type \"image/pjpeg\", :filename \"940407648_1399511322875.png\"}}', '1399511329031');
INSERT INTO `e_log` VALUES ('425037ae-831e-4b6a-8db4-7dfec0c71b9d', null, '13651083480', '118.194.195.3', '2014-05-09 15:28:39', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399620519214');
INSERT INTO `e_log` VALUES ('42bbaa9d-2e57-4430-b8dc-c31ff5b5e90b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:49', ':get', '/demo/getSalesByChannel/42/1399624365370', null, '1399624369761');
INSERT INTO `e_log` VALUES ('436e5e42-f8ad-4cb2-b3ef-6b8ab297d4f5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:28:13', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399516082250', null, '1399516093390');
INSERT INTO `e_log` VALUES ('43dcb43d-2ff9-466f-8226-2dede4aee492', null, '13651083480', '192.168.253.3', '2014-05-13 15:13:17', ':get', '/getSalesByChannel/1/1399964183515', null, '1399965197031');
INSERT INTO `e_log` VALUES ('45627410-e61d-4441-af06-ac9a9c8e2dfe', null, null, '192.168.253.3', '2014-05-08 11:56:08', ':get', '/getImageFile/-354365311_1399521331897.png', null, '1399521368640');
INSERT INTO `e_log` VALUES ('45aea1c9-dcd6-470d-bc4a-2e70fae3c64f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:48:58', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399456138375');
INSERT INTO `e_log` VALUES ('45d4822f-e598-493e-bc93-2e0d0676af02', null, null, '192.168.253.3', '2014-05-07 16:54:29', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452869937');
INSERT INTO `e_log` VALUES ('45da520a-1c79-4937-b620-beace244f883', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:24', ':post', '/addShopFavorit', '{:user_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\"}', '1399517064484');
INSERT INTO `e_log` VALUES ('461c1b0e-4112-47a0-8fc7-5481c78ca9ee', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:14', ':get', '/getSalesByChannel/0/1399446507875', null, '1399446554250');
INSERT INTO `e_log` VALUES ('46800fac-453e-4c29-89c3-201c3af85125', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:34', ':get', '/getSalesByChannel/42/1399521451203', null, '1399521454765');
INSERT INTO `e_log` VALUES ('4695b275-317a-40d5-8469-221de3744803', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:52:01', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971121406');
INSERT INTO `e_log` VALUES ('4719cee2-f309-4fd0-b644-34f2d11d95b2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:11:47', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399968707718');
INSERT INTO `e_log` VALUES ('471fd417-cd04-4a6f-814e-918433eb644f', null, '13651083480', '118.194.195.3', '2014-05-09 14:51:26', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/6b974797-5bf0-42d4-a89b-d57fa70bedf8', null, '1399618286933');
INSERT INTO `e_log` VALUES ('473a90dc-3e97-4a0a-9570-341b4d7cb39b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:38', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399451078015');
INSERT INTO `e_log` VALUES ('476e5922-6b94-4e7e-a120-f03b6835a043', null, null, '118.194.195.3', '2014-05-09 14:14:30', ':get', '/demo/getImageFile/-104682932_1399516864279.png', null, '1399616070370');
INSERT INTO `e_log` VALUES ('47e1bdcc-e09a-4aad-8b76-8babc6b8e648', null, '1', '192.168.253.3', '2014-05-08 16:09:41', ':post', '/login', '{:phone \"1\"}', '1399536581187');
INSERT INTO `e_log` VALUES ('47fe5373-4986-4fb8-b803-068fbe06cbb2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:15:34', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616134745');
INSERT INTO `e_log` VALUES ('484a0649-a747-410a-8047-ce8a4dee0acd', null, '13651083480', '192.168.253.3', '2014-05-07 15:17:00', ':post', '/login', '{:phone \"13651083480\"}', '1399447020343');
INSERT INTO `e_log` VALUES ('486cd3fb-b353-4181-845b-9cc47381e02b', null, '13651083480', '118.194.195.3', '2014-05-09 14:06:49', ':get', '/demo/getModules/discover', null, '1399615609573');
INSERT INTO `e_log` VALUES ('487ede92-3649-4bd7-a46e-8442cc72be0e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:49', ':get', '/getSalesByChannel/0/1399452486671', null, '1399452889609');
INSERT INTO `e_log` VALUES ('48836c88-7756-48eb-bf65-6a9561f3233d', null, null, '192.168.253.3', '2014-05-07 17:01:25', ':get', '/getImageFile/50489896_1399453226535.png', null, '1399453285000');
INSERT INTO `e_log` VALUES ('4924e514-9fd3-4bf5-b11c-259a01fc9bbf', null, '1', '192.168.253.3', '2014-05-13 10:08:54', ':post', '/login', '{:phone \"1\"}', '1399946934220');
INSERT INTO `e_log` VALUES ('496dce09-c0e2-4b89-8463-43c0df282aa0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:18', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450998453');
INSERT INTO `e_log` VALUES ('49a9dd3f-e004-4f13-8126-1e1a8fa89091', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:15:29', ':get', '/demo/getShopFavoritesByUser/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616129995');
INSERT INTO `e_log` VALUES ('4a016572-5c07-4bf0-a94b-fb82625fd20d', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:17:52', ':get', '/demo/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616272901');
INSERT INTO `e_log` VALUES ('4a3fe72d-048c-4730-a937-15d6fc9f3757', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:39:29', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531169390');
INSERT INTO `e_log` VALUES ('4a8befe6-1eb7-4f45-94ce-e7c19eb613c9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:51:58', ':post', '/registerShop', '{\"1259860143_1399452716068.png\" {:size 68674, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7107816321588269714.tmp>, :content-type \"image/pjpeg\", :filename \"1259860143_1399452716068.png\"}, :desc \"%E6%AC%A2%E8%BF%8E%E5%85%89%E4%B8%B4\", :shop_img \"1259860143_1399452716068.png\", :name \"%E4%B8%BD%E4%BD%B3%E5%AE%9D%E8%B4%9D%E6%B0%B8%E6%97%BA%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22radius%22%3A38.766666412353516%2C%22longitude%22%3A116.242444%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"1259860143_1399452716068.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"40%7C3\"}', '1399452718515');
INSERT INTO `e_log` VALUES ('4ab8d6c8-ee73-4ca7-8f18-8e1919469159', null, '13651083480', '118.194.195.3', '2014-05-09 14:51:21', ':get', '/demo/getSalesByChannel/2/1399617820964', null, '1399618281292');
INSERT INTO `e_log` VALUES ('4b0c7a14-8f35-4de9-bba2-436ad028d88a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:45:21', ':get', '/getSalesByChannel/1/1399963506843', null, '1399963521046');
INSERT INTO `e_log` VALUES ('4b13aa3d-cb4f-4b1e-b7a6-1de7f715683d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:26:07', ':get', '/getShopShares/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399533967328');
INSERT INTO `e_log` VALUES ('4bbd7282-bfbb-474d-ac6e-16cde7c2d862', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:13:56', ':get', '/demo/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616036730');
INSERT INTO `e_log` VALUES ('4c014699-2c1a-49ba-8ebd-b93f262e3374', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:09:13', ':post', '/demo/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399615753480');
INSERT INTO `e_log` VALUES ('4c846a15-4822-4468-ad4f-e5375f1d2ddb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:15:29', ':post', '/updateShop', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :field \"desc\", :value \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E5%A4%A7%E5%93%81%E7%89%8C\", :fileNameList \"\"}', '1399454129593');
INSERT INTO `e_log` VALUES ('4cf133d3-a301-4787-9aa3-9d7e0095b712', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:46:04', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399531564406');
INSERT INTO `e_log` VALUES ('4cfdf61a-743f-4978-ae97-5e8e55322f08', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:54', ':get', '/demo/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399616814386');
INSERT INTO `e_log` VALUES ('4d131017-8d08-4b90-a555-4099da01f4d3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:48:12', ':get', '/getShopsByDistance/40.073707/116.242451/2000/0', null, '1399607292203');
INSERT INTO `e_log` VALUES ('4d66f4bd-179a-4030-919b-1e849100d470', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:29:37', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606177390');
INSERT INTO `e_log` VALUES ('4e072192-5e31-4358-8cc8-9142d5644deb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:18', ':post', '/addSaleDiscuss', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"优惠多多\"}', '1399453518328');
INSERT INTO `e_log` VALUES ('4e1df8c6-8cdd-4fe3-ad70-4bf2944f955e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:51:30', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971090515');
INSERT INTO `e_log` VALUES ('4e59d1fd-b37a-4597-a921-9446ae5cec18', null, '13651083480', '223.203.193.252', '2014-05-09 16:32:14', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399624334480');
INSERT INTO `e_log` VALUES ('4e6ec635-9350-400b-960c-05be5c7531d3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:28:24', ':get', '/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399969704718');
INSERT INTO `e_log` VALUES ('4e9191e3-79f5-4842-bf87-b58ab91f6aec', null, '13651083480', '192.168.253.3', '2014-05-08 10:10:58', ':get', '/getSalesByChannel/0/-1', null, '1399515058921');
INSERT INTO `e_log` VALUES ('4fa1c528-adf5-45bc-a420-4c509d93a0af', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:25:16', ':get', '/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399969516859');
INSERT INTO `e_log` VALUES ('5015acb7-da38-423b-a66e-fba46eb86f66', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:46:08', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399617934495', null, '1399617968980');
INSERT INTO `e_log` VALUES ('504082cc-d287-4c7f-a39a-35fe1a3c277a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:02:36', ':post', '/searchUsers', '{:search-word \"1\"}', '1399971756875');
INSERT INTO `e_log` VALUES ('50940331-f986-4478-8d62-a28c94e5a9cf', null, '13651083480', '118.194.195.3', '2014-05-09 14:43:20', ':get', '/demo/getSalesByChannel/1/1399617795995', null, '1399617800245');
INSERT INTO `e_log` VALUES ('50bd734c-1778-4a9f-a4b8-7440232f52de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:01:45', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514494034.png\"}', '1399514505812');
INSERT INTO `e_log` VALUES ('50cddaa3-9928-4073-8e59-845ea67f7891', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:28:02', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399516082187');
INSERT INTO `e_log` VALUES ('511586b6-8078-4b8a-91d4-9a7db09bcef3', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:28', ':post', '/login', '{:phone \"13651083480\"}', '1399530808937');
INSERT INTO `e_log` VALUES ('514f3302-d6c7-42e6-a5f4-efda60550a01', null, '13651083480', '192.168.253.3', '2014-05-08 10:10:59', ':get', '/getSalesByChannel/1/1399515058984', null, '1399515059437');
INSERT INTO `e_log` VALUES ('51b07ba3-a1ce-4955-9fbc-93968a3c1c93', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:48:36', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528116515');
INSERT INTO `e_log` VALUES ('52477bfa-58f1-4357-a9fe-99281e86a511', null, '13651083480', '192.168.253.3', '2014-05-08 16:04:02', ':get', '/getSalesByChannel/1/1399533953296', null, '1399536242125');
INSERT INTO `e_log` VALUES ('524bf263-96d5-4b6f-8561-fbc67a22846c', null, '1', '192.168.253.3', '2014-05-08 16:06:31', ':post', '/login', '{:phone \"1\"}', '1399536391890');
INSERT INTO `e_log` VALUES ('528d48cd-5171-40c7-9710-b87dcf267333', null, '13651083480', '192.168.253.3', '2014-05-08 09:55:01', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514097772.png\"}', '1399514101687');
INSERT INTO `e_log` VALUES ('5296325f-77e8-4671-a829-3607594dce62', null, '13651083480', '118.194.195.3', '2014-05-09 14:20:15', ':get', '/demo/getChannels', null, '1399616415011');
INSERT INTO `e_log` VALUES ('529dfd4f-6048-489d-b485-a4ba59e7ccf7', null, '1', '192.168.253.3', '2014-05-09 11:31:10', ':post', '/login', '{:phone \"1\"}', '1399606270281');
INSERT INTO `e_log` VALUES ('5352126d-5d4a-4d96-bb57-d789d90d1d20', null, '1', '192.168.253.3', '2014-05-09 08:42:02', ':post', '/login', '{:phone \"1\"}', '1399596122859');
INSERT INTO `e_log` VALUES ('536f2345-4b90-4f42-93ff-75862a08bff0', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:45:37', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399963537031');
INSERT INTO `e_log` VALUES ('53955808-4f8a-43e3-88d7-58d59cc2924d', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:20', ':get', '/getModules/discover', null, '1399595540578');
INSERT INTO `e_log` VALUES ('53cd162b-44b1-4202-814c-9b84df1b961e', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870421');
INSERT INTO `e_log` VALUES ('54a583f8-dcbf-4c35-8c6b-3c1ed66b297f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:40:13', ':post', '/searchShops', '{:search-word \"上\"}', '1399516813812');
INSERT INTO `e_log` VALUES ('54b95d20-e9ec-4c26-8123-e0f45c574c9a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:48:46', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399513645372.png\"}', '1399513726203');
INSERT INTO `e_log` VALUES ('54bf5a80-245a-4b34-abca-b029bdace727', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:03:36', ':get', '/getSalesByDistance/40.073683/116.242453/2000/0', null, '1399968216562');
INSERT INTO `e_log` VALUES ('54e298ce-bb4c-4743-9300-d47643635db2', null, '13651083480', '118.194.195.3', '2014-05-09 14:07:29', ':get', '/demo/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399615646308', null, '1399615649792');
INSERT INTO `e_log` VALUES ('55194a78-1e1a-471c-a65f-650eed143c8c', null, null, '118.194.195.3', '2014-05-09 14:09:15', ':get', '/demo/getImageFile/602324364_1399449344230.png', null, '1399615755667');
INSERT INTO `e_log` VALUES ('5563ac7b-69a6-487a-afda-476ae8cc5aba', null, '13651083480', '192.168.253.3', '2014-05-13 14:51:53', ':get', '/getSalesByChannel/1/1399963810062', null, '1399963913140');
INSERT INTO `e_log` VALUES ('55939cea-d8f3-4bed-831c-21ca064403de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:51:48', ':get', '/getSalesByChannel/1/1399971040968', null, '1399971108953');
INSERT INTO `e_log` VALUES ('55e0cdd9-e322-4354-ad46-fd85f3a7923b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:24:34', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399533874328');
INSERT INTO `e_log` VALUES ('562c2d8d-8974-4ce8-b0d6-da3b1d35123c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:59:53', ':get', '/getSalesByChannel/1/1399951839673', null, '1399953593376');
INSERT INTO `e_log` VALUES ('562f3b20-bf6a-4da0-96dd-2dee41fa78bb', null, '13651083480', '192.168.253.3', '2014-05-13 16:40:33', ':get', '/getSalesByChannel/0/-1', null, '1399970433687');
INSERT INTO `e_log` VALUES ('56413cba-29de-439d-be3a-c1afab16ea86', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:04', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528324921');
INSERT INTO `e_log` VALUES ('5660bbc9-f474-4602-9a09-97311b40097a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:28:15', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399512495984');
INSERT INTO `e_log` VALUES ('568dc2ed-1c4f-410f-95ef-125e3fa68cae', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:10:15', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536615843');
INSERT INTO `e_log` VALUES ('56959890-5676-4c2e-bf16-e2b02cb32e40', null, null, '192.168.253.1', '2014-05-13 18:28:19', ':get', '/favicon.ico', null, '1399976899953');
INSERT INTO `e_log` VALUES ('5696951a-f7ed-4b3e-af60-1a0c5c6024fa', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:14', ':get', '/demo/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399624334823');
INSERT INTO `e_log` VALUES ('56e0dd1e-9a2f-4012-97b4-46534db34ee0', null, '13651083480', '192.168.253.3', '2014-05-08 11:28:32', ':post', '/login', '{:phone \"13651083480\"}', '1399519712140');
INSERT INTO `e_log` VALUES ('57495c3e-d9eb-4959-a4a3-518566f7824a', null, '13651083480', '192.168.253.3', '2014-05-07 17:13:39', ':post', '/login', '{:phone \"13651083480\"}', '1399454019968');
INSERT INTO `e_log` VALUES ('57cb42b2-d0a6-4fac-84ea-0705c91a647d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:54:37', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971277937');
INSERT INTO `e_log` VALUES ('58454d34-7343-4e93-9d13-fc278d1e7a0b', null, null, '192.168.253.1', '2014-05-16 14:48:57', ':get', '/', null, '1400222937765');
INSERT INTO `e_log` VALUES ('589b555d-79ea-4901-9d79-f98dd37c0423', null, '13651083480', '192.168.253.3', '2014-05-07 17:48:34', ':post', '/login', '{:phone \"13651083480\"}', '1399456114203');
INSERT INTO `e_log` VALUES ('58fc1eef-81f9-4f82-986f-c3e103c7c449', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:44:22', ':post', '/createShopBarcode', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399513462984');
INSERT INTO `e_log` VALUES ('590c911e-aa35-4bd0-a3a9-736be0db5bb5', null, '13651083480', '192.168.253.3', '2014-05-13 13:43:56', ':get', '/getSalesByChannel/1/1399959312093', null, '1399959836421');
INSERT INTO `e_log` VALUES ('59151d79-bbe0-4d39-97fb-3f50e7575dbd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:46:44', ':get', '/demo/getModules/discover', null, '1399618004620');
INSERT INTO `e_log` VALUES ('59a88e49-0e6d-402f-bead-e3c79d0369c7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:49', ':get', '/getSalesByChannel/1/1399452889671', null, '1399452889968');
INSERT INTO `e_log` VALUES ('59c61822-9bca-48dc-886f-d0bf4ddf7f61', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:58', ':post', '/login', '{:phone \"13651083480\"}', '1399450738156');
INSERT INTO `e_log` VALUES ('59de5d42-18f7-4ae1-9bdc-3036058a3562', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:31', ':get', '/getSalesByChannel/0/1399448759234', null, '1399449031968');
INSERT INTO `e_log` VALUES ('59f15065-b7f4-4aa2-9e4b-1d1ef041caa9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:27:32', ':get', '/getSalesByChannel/1/1399966045781', null, '1399966052187');
INSERT INTO `e_log` VALUES ('5a18b79a-fdc2-4d0a-967a-e5c20c76c8e2', null, '13651083480', '118.194.195.3', '2014-05-09 14:43:36', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399617816276');
INSERT INTO `e_log` VALUES ('5a1c302c-c0b6-405a-bfa4-e2261bd8c7bb', null, '13651083480', '118.194.195.3', '2014-05-09 14:06:56', ':get', '/demo/getSettings', null, '1399615616151');
INSERT INTO `e_log` VALUES ('5a2b0b25-f465-4c12-bb5c-ff0f37248422', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:52:23', ':get', '/getSalesByChannel/1/1399967530546', null, '1399967543312');
INSERT INTO `e_log` VALUES ('5a547d2b-8b65-4a19-b99e-55d0a4eade6a', null, null, '192.168.253.3', '2014-05-08 10:26:37', ':get', '/getImageFile/barcode_-509784425_1399515996656.png', null, '1399515997578');
INSERT INTO `e_log` VALUES ('5ab1c185-70a9-4b51-8149-9c0c1196b757', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:54', ':get', '/getShopsByDistance/40.073736/116.242445/2000/0', null, '1399448694828');
INSERT INTO `e_log` VALUES ('5abc8afa-c80b-436e-a440-460b1a5c3957', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:10:16', ':put', '/updateUserPwd', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399511416812');
INSERT INTO `e_log` VALUES ('5abe9ffe-7584-4a4d-85ba-4bafdc4c889e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:28:19', ':get', '/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399969699703');
INSERT INTO `e_log` VALUES ('5ae1f378-6a6e-4341-9e65-10ea60b94a84', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:35', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399446575765');
INSERT INTO `e_log` VALUES ('5af57c1e-b52f-4073-af3b-a4ddc1b65a97', null, '13651083480', '118.194.195.3', '2014-05-09 14:15:02', ':get', '/demo/getSalesByDistance/40.073684/116.242457/1994/0', null, '1399616102401');
INSERT INTO `e_log` VALUES ('5b026942-0340-427f-8a7f-2c01dce7ce1e', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:25', ':post', '/login', '{:phone \"13651083480\"}', '1399446445015');
INSERT INTO `e_log` VALUES ('5b6799b9-258f-49c2-8a4b-a76c715a2ca9', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:31:47', ':post', '/saveShare', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :content \"%E4%B9%B0%E7%9A%84%E7%94%B5%E8%84%91%E5%BE%88%E4%BC%98%E6%83%A0%EF%BC%8C%E5%BA%97%E5%91%98%E6%9C%8D%E5%8A%A1%E5%A5%BD%E3%80%82\", :fileNameList \"\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399606307515');
INSERT INTO `e_log` VALUES ('5b84052c-bfd3-45d0-b93b-d4796e19c120', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:35:23', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606523984');
INSERT INTO `e_log` VALUES ('5b84b5c1-3599-432f-927a-389fbba1ff37', null, '13651083480', '118.194.195.3', '2014-05-09 14:15:07', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399616107980');
INSERT INTO `e_log` VALUES ('5c886eec-27c3-40bc-b259-71854efd57c4', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:18:45', ':get', '/demo/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616325167');
INSERT INTO `e_log` VALUES ('5cf6aa37-cb47-4e3c-abf2-89384a1ace35', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:22:12', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399519332578');
INSERT INTO `e_log` VALUES ('5cf8b111-ed5a-44a6-8a1d-5f00f859bd9f', null, null, '192.168.253.3', '2014-05-08 10:07:56', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514876375');
INSERT INTO `e_log` VALUES ('5d271948-5ea9-4da6-b4f0-b2e75943ae44', null, '13651083480', '192.168.253.3', '2014-05-09 11:45:27', ':get', '/getSalesByChannel/0/-1', null, '1399607127406');
INSERT INTO `e_log` VALUES ('5d38e289-9c05-4c46-86e4-b3e46f5cec43', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:42:12', ':post', '/searchShops', '{:search-word \"上\"}', '1399516932734');
INSERT INTO `e_log` VALUES ('5d45eabf-4800-4ae6-a20d-f74a63214ac0', null, null, '192.168.253.3', '2014-05-08 10:07:55', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514875984');
INSERT INTO `e_log` VALUES ('5d74f66a-20e2-4091-9e2a-cd4dac4b2a16', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:28:17', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606097812');
INSERT INTO `e_log` VALUES ('5d987dc1-48e3-4915-aa7a-e37157ae4ade', null, '13651083480', '118.194.195.3', '2014-05-09 14:07:26', ':get', '/demo/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399521367765', null, '1399615646292');
INSERT INTO `e_log` VALUES ('5da59749-b678-4b2e-8d20-2e2c65bbd7ea', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:26:05', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605965390');
INSERT INTO `e_log` VALUES ('5db04152-de07-4ddd-86d7-0d2a32a8d1f6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:31', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453411437');
INSERT INTO `e_log` VALUES ('5dd4d46b-b415-47cb-b9b1-f44a7110be91', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:09:58', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511398734');
INSERT INTO `e_log` VALUES ('5dfc6c55-2147-4325-8e72-9a0cc08f36d4', null, null, '192.168.253.3', '2014-05-08 09:05:33', ':get', '/getImageFile/834375879_1399511048951.png', null, '1399511133703');
INSERT INTO `e_log` VALUES ('5e659080-efab-4562-824e-ae1871bc4b83', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:44:00', ':get', '/demo/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399617840667');
INSERT INTO `e_log` VALUES ('5e9e3594-8871-4884-acd5-a2a27e086455', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:22:07', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399515727156');
INSERT INTO `e_log` VALUES ('5ea00540-fafd-4a58-a2d1-733b806e5b66', null, '1', '192.168.253.3', '2014-05-13 11:30:39', ':post', '/login', '{:phone \"1\"}', '1399951839282');
INSERT INTO `e_log` VALUES ('5ef8cbb2-57ea-488c-a746-f8a8d78542a0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:09:31', ':put', '/updateUserPwd', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399511371640');
INSERT INTO `e_log` VALUES ('5f717df1-0460-47ab-80da-a69eff2a2b10', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:43:55', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :fileNameList \"\"}', '1399455835390');
INSERT INTO `e_log` VALUES ('5f99772d-6ccc-4dca-85df-ecc9030f211d', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:32', ':get', '/getSalesByChannel/1/1399449032031', null, '1399449032468');
INSERT INTO `e_log` VALUES ('5fdec4c8-cbae-4aa5-b6e1-f62bf9af8058', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:08', ':get', '/getSalesByChannel/1/1399446608109', null, '1399446608468');
INSERT INTO `e_log` VALUES ('5ff521f5-7c82-47cd-bf74-412930ed5c26', null, '13651083480', '192.168.253.3', '2014-05-08 15:24:33', ':post', '/login', '{:phone \"13651083480\"}', '1399533873765');
INSERT INTO `e_log` VALUES ('60025fd7-a1bb-4bac-9362-5ddb8d959c97', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:05:30', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399968330890');
INSERT INTO `e_log` VALUES ('600fae9c-b946-4301-b313-6af29bef50e2', null, '13651083480', '192.168.253.3', '2014-05-13 09:26:23', ':get', '/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399521367765', null, '1399944383470');
INSERT INTO `e_log` VALUES ('6027fab1-95a1-43cb-886f-9c88ec8c66fd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:08:31', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511311843');
INSERT INTO `e_log` VALUES ('60566a0a-c419-4629-ab58-370b3b3b9b71', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 13:32:24', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399959144687');
INSERT INTO `e_log` VALUES ('60cb5709-8415-4757-aeaa-657f6998ecca', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 09:30:15', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399944615501');
INSERT INTO `e_log` VALUES ('60e21dc1-1192-4b16-ac31-15304aca3a4e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:54:55', ':get', '/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399971099906', null, '1399971295171');
INSERT INTO `e_log` VALUES ('60e6b849-34a1-4800-a7c4-03986ebce2c9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:08:58', ':get', '/demo/getSalesByChannel/1/1399615697448', null, '1399615738589');
INSERT INTO `e_log` VALUES ('611e93e2-9890-41ff-9f28-7df4859d15c5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:10:48', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D%EF%BC%8C%E6%AC%A2%E8%BF%8E%E5%85%89%E4%B8%B4%E3%80%82\", :fileNameList \"\"}', '1399511448453');
INSERT INTO `e_log` VALUES ('6133bd8f-d209-44f8-a22a-93b9c1b2c5bb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:04:17', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536257421');
INSERT INTO `e_log` VALUES ('6197a5e8-f6b4-4997-bb9f-c573021e98c2', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284859');
INSERT INTO `e_log` VALUES ('61a03aee-6641-452f-8f38-cdcf6fb5abac', null, '13651083480', '192.168.253.3', '2014-05-08 14:38:00', ':post', '/login', '{:phone \"13651083480\"}', '1399531080968');
INSERT INTO `e_log` VALUES ('61b8ee38-01fb-4ad5-bc39-6e7dbed88b8f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:00', ':get', '/getSalesByDistance/40.073712/116.242458/2000/0', null, '1399453620437');
INSERT INTO `e_log` VALUES ('61c58eb3-ab27-4b2b-b1c7-57d1160ea6a8', null, '13651083480', '192.168.253.3', '2014-05-09 08:33:44', ':post', '/login', '{:phone \"13651083480\"}', '1399595624515');
INSERT INTO `e_log` VALUES ('627adfc3-1ad6-47d2-acc2-dfda5d1c1eb6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:22:58', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605778796');
INSERT INTO `e_log` VALUES ('628e0489-0b0f-43dc-a406-f93416cd6195', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:09', ':post', '/demo/addShopEmps', '{:emps \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\"}', '1399616769620');
INSERT INTO `e_log` VALUES ('63098214-73f1-4fb5-aeb2-610d5c644c19', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:13', ':get', '/getShopsByDistance/40.073715/116.242448/2000/0', null, '1399517053828');
INSERT INTO `e_log` VALUES ('632155ee-7c43-4759-89b1-02456568f6f4', null, '13651083480', '192.168.253.3', '2014-05-13 14:45:19', ':post', '/login', '{:phone \"1\"}', '1399963519156');
INSERT INTO `e_log` VALUES ('63277896-f782-416b-a0c8-b48f975519f3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:26:03', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605963765');
INSERT INTO `e_log` VALUES ('6345bc1d-8e81-4d47-b8da-a7f72305cb16', null, '13651083480', '118.194.195.3', '2014-05-09 14:20:17', ':get', '/demo/getSalesByChannel/1/1399616416917', null, '1399616417261');
INSERT INTO `e_log` VALUES ('63c34ea3-3254-4b26-80f0-661be40fa60a', null, '13651083480', '192.168.253.3', '2014-05-08 10:52:52', ':post', '/login', '{:phone \"13651083480\"}', '1399517572890');
INSERT INTO `e_log` VALUES ('63f11ae8-94d5-42d7-a29e-8ef98647c9ab', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:07', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607227578');
INSERT INTO `e_log` VALUES ('64301921-b72f-481a-bcd8-49523559cd42', null, '13651083480', '192.168.253.3', '2014-05-08 09:27:51', ':get', '/getChannels', null, '1399512471125');
INSERT INTO `e_log` VALUES ('643791d7-7886-4f87-aaf0-7528f3a20377', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:41:29', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D%EF%BC%8C%E6%AC%A2%E8%BF%8E%E3%80%82\", :fileNameList \"\"}', '1399513289375');
INSERT INTO `e_log` VALUES ('6446b844-ff2c-411f-888a-c33c90e319f8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:39:19', ':get', '/getSalesByChannel/1/1399966476359', null, '1399966759421');
INSERT INTO `e_log` VALUES ('647bfc2d-9084-48ec-8e2e-7b40b3e39574', null, '13651083480', '192.168.253.3', '2014-05-13 13:34:57', ':get', '/getSalesByChannel/1/1399959098281', null, '1399959297593');
INSERT INTO `e_log` VALUES ('64b4974c-d44f-4994-8f9a-372eecea1985', null, '13651083480', '192.168.253.3', '2014-05-13 15:52:22', ':post', '/login', '{:phone \"13651083480\"}', '1399967542812');
INSERT INTO `e_log` VALUES ('64c2dd1b-2b6f-4659-83a3-134ffecedeb5', null, '13651083480', '192.168.253.3', '2014-05-13 14:45:04', ':get', '/getChannels', null, '1399963504671');
INSERT INTO `e_log` VALUES ('655a6451-521b-40d2-b8e6-ea4e010275d2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:38:40', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399603120031');
INSERT INTO `e_log` VALUES ('657c5123-1edb-4db2-ad7b-705f33a84291', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:34', ':get', '/getSalesByChannel/1/1399450953734', null, '1399450954093');
INSERT INTO `e_log` VALUES ('6590f395-0ff3-4121-9a5a-2feb97671664', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:44:05', ':get', '/getSalesByChannel/1/1399967028203', null, '1399967045796');
INSERT INTO `e_log` VALUES ('65c3f4a5-5444-44a3-8243-5ef513cc8f50', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:09:48', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399968588109');
INSERT INTO `e_log` VALUES ('661d92a3-0884-4f65-86f2-d2f0c7cf2bb1', null, null, '192.168.253.3', '2014-05-08 10:10:25', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399515025515');
INSERT INTO `e_log` VALUES ('6637f5ae-8f6f-42d5-922c-d89ad0b3403a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:58:34', ':get', '/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971514359');
INSERT INTO `e_log` VALUES ('66cda67d-f231-441a-a79b-c76a8e44a413', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:11:38', ':get', '/getSalesByChannel/1/1399968690437', null, '1399968698484');
INSERT INTO `e_log` VALUES ('66e85eda-56d5-4214-9f5e-0006ef60a5c4', null, '13651083480', '192.168.253.3', '2014-05-13 09:25:05', ':get', '/getModules/me', null, '1399944305110');
INSERT INTO `e_log` VALUES ('677e582e-2836-4988-96ce-bbfe85a8a877', null, null, '118.194.195.3', '2014-05-09 14:20:00', ':get', '/demo/app/YouGouHui.apk', null, '1399616400636');
INSERT INTO `e_log` VALUES ('6796e24d-d045-4b23-9075-ae33eeb70c64', null, '13651083480', '192.168.253.3', '2014-05-08 11:40:51', ':post', '/login', '{:phone \"13651083480\"}', '1399520451156');
INSERT INTO `e_log` VALUES ('67bf0954-f6eb-404c-927a-326f57db4f38', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:14', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399449254546');
INSERT INTO `e_log` VALUES ('67dc88a5-9c96-400b-8fe0-c5f7a8376523', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:40', ':post', '/searchShops', '{:search-word \"上\"}', '1399452940171');
INSERT INTO `e_log` VALUES ('682cbff0-4a16-40c6-8214-bb1cd4b76b0f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:50:13', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399963637265', null, '1399963813906');
INSERT INTO `e_log` VALUES ('6835c339-59f9-48d8-860e-56f1cf56932b', null, '1', '192.168.253.3', '2014-05-09 11:34:08', ':post', '/login', '{:phone \"1\"}', '1399606448750');
INSERT INTO `e_log` VALUES ('68f16a6a-1e5f-4885-b46c-77f0c0ffd79d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:54:47', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971287562');
INSERT INTO `e_log` VALUES ('694501a2-9594-4547-b97a-932226016bd8', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:36:14', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606574015');
INSERT INTO `e_log` VALUES ('69641432-34bb-4a2c-8409-f03ad557e3d3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:44', ':get', '/demo/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399616804417');
INSERT INTO `e_log` VALUES ('6997a88e-f40f-4a23-808d-d1440307c248', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:42', ':post', '/login', '{:phone \"13651083480\"}', '1399449042015');
INSERT INTO `e_log` VALUES ('699ea2d1-4b3c-4c2a-a0c7-943611cfcfac', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:41:24', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399970484203');
INSERT INTO `e_log` VALUES ('69ceb455-597a-4dac-b541-db953896d710', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:56:23', ':get', '/getSalesByChannel/1/1399964164031', null, '1399964183500');
INSERT INTO `e_log` VALUES ('6a0c3c31-5687-4333-bf60-d251be2b56d6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:46:49', ':get', '/getModules/me', null, '1399607209343');
INSERT INTO `e_log` VALUES ('6a0c98b0-93fc-4745-88fd-1cc8cf02b6c9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:48:34', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399456114656');
INSERT INTO `e_log` VALUES ('6a0f1966-edc5-4a2a-9f94-816679f0bbe4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:46:40', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520800156');
INSERT INTO `e_log` VALUES ('6a24379c-88f2-4bfd-98cc-55077f9de6cb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:11:22', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536682750');
INSERT INTO `e_log` VALUES ('6a3f332c-67de-4cc4-8356-19085cab222c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:52:16', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971136468');
INSERT INTO `e_log` VALUES ('6a6ca85c-60a0-4786-b066-76bf09406ea2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:40:51', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520451593');
INSERT INTO `e_log` VALUES ('6a703fbd-1244-4c6d-ade0-8ce36501c09f', null, null, '192.168.253.1', '2014-05-07 16:30:39', ':get', '/aa', null, '1399451439578');
INSERT INTO `e_log` VALUES ('6a736cc8-531b-4239-bc53-5d9e0325d7fe', null, '13651083480', '192.168.253.3', '2014-05-13 16:58:27', ':post', '/login', '{:phone \"13651083480\"}', '1399971507031');
INSERT INTO `e_log` VALUES ('6a811cfb-dbda-4d39-b448-f00871ca0f2f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':get', '/getSalesByChannel/0/1399446405843', null, '1399446470546');
INSERT INTO `e_log` VALUES ('6ae5eb3d-1d50-4a7b-9b27-0f5a92407289', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:37', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399616497151');
INSERT INTO `e_log` VALUES ('6b37caec-3eaf-4d31-b3ae-d01bd42ef27f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:00', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448700703');
INSERT INTO `e_log` VALUES ('6b56cbc5-c167-40c3-b5d8-1dd7b3ced400', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:39:44', ':get', '/getSalesByChannel/1/1399966768593', null, '1399966784359');
INSERT INTO `e_log` VALUES ('6b8049d4-821f-4640-8a9b-e90f525496cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:57:28', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514244768.png\"}', '1399514248390');
INSERT INTO `e_log` VALUES ('6ba12d6c-aa65-43d8-92d9-01be7ccfd04a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:29:06', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399526946515');
INSERT INTO `e_log` VALUES ('6c0b0de6-8129-4932-acdd-be665a064b0a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:46:24', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399970784156');
INSERT INTO `e_log` VALUES ('6c68d3cd-86c7-466f-a124-a726711ef0eb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 12:01:36', ':get', '/getSalesByChannel/1/1399953593407', null, '1399953696157');
INSERT INTO `e_log` VALUES ('6c721543-355c-4978-90e3-7d0f162d58d3', null, '13651083480', '192.168.253.3', '2014-05-13 15:56:32', ':get', '/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399521367765', null, '1399967792250');
INSERT INTO `e_log` VALUES ('6c7fc3b6-b6b0-4183-b5f1-0c0a0f51f7e7', null, null, '192.168.253.1', '2014-05-07 16:34:43', ':get', '/aa', null, '1399451683328');
INSERT INTO `e_log` VALUES ('6c8833f6-b980-4727-8ee5-b8955e385902', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 11:41:32', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520492796');
INSERT INTO `e_log` VALUES ('6c9e9897-8df6-45fc-beea-6c9a8e4b9e62', null, '13651083480', '192.168.253.3', '2014-05-13 09:24:45', ':get', '/getSalesByChannel/2/1399944281392', null, '1399944285110');
INSERT INTO `e_log` VALUES ('6ce6c6ab-9c09-4601-879b-acb67ab83e42', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:13:07', ':get', '/demo/getSalesByDistance/40.073684/116.242457/5/0', null, '1399615987636');
INSERT INTO `e_log` VALUES ('6d185a36-c5da-4ae4-8e8a-8327943b32c8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:40:57', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399970457140');
INSERT INTO `e_log` VALUES ('6d2eb880-d94d-468e-b428-5d59b36a22c0', null, '13651083480', '223.203.193.252', '2014-05-09 16:31:49', ':get', '/demo/getSalesByChannel/0/-1', null, '1399624309401');
INSERT INTO `e_log` VALUES ('6d6b9a97-7c9c-4c23-97af-d8c513a99779', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:50:54', ':get', '/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399971054375');
INSERT INTO `e_log` VALUES ('6dad744a-df38-4511-aa20-4767cba7902e', null, '1', '192.168.253.3', '2014-05-13 11:25:07', ':post', '/login', '{:phone \"1\"}', '1399951507032');
INSERT INTO `e_log` VALUES ('6e37e39e-e5dc-405c-ab68-b804b6b329b0', null, '13651083480', '192.168.253.3', '2014-05-08 09:27:56', ':get', '/getModules/me', null, '1399512476000');
INSERT INTO `e_log` VALUES ('6e75d93b-5fde-4913-84df-358dc43e5328', null, '1', '192.168.253.3', '2014-05-13 13:32:15', ':post', '/login', '{:phone \"1\"}', '1399959135109');
INSERT INTO `e_log` VALUES ('6e875a17-afb4-496a-bcff-68f4aeb062fc', null, '13651083480', '192.168.253.3', '2014-05-07 16:48:04', ':post', '/login', '{:phone \"13651083480\"}', '1399452484906');
INSERT INTO `e_log` VALUES ('6ea2bea2-e0b1-4cea-84ef-197758e6bc42', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:08:27', ':get', '/getSalesByChannel/0/1399446470734', null, '1399446507546');
INSERT INTO `e_log` VALUES ('6eeaf8fe-1025-4a6b-bf0c-89cf648d5b0c', null, '1', '192.168.253.3', '2014-05-08 16:49:26', ':post', '/login', '{:phone \"1\"}', '1399538966843');
INSERT INTO `e_log` VALUES ('6f56985c-44dd-4964-8e83-bfe9fc61b5cb', null, '13651083480', '192.168.253.3', '2014-05-07 16:14:05', ':post', '/login', '{:phone \"13651083480\"}', '1399450445187');
INSERT INTO `e_log` VALUES ('6f65d46b-35c3-48c1-8bc5-2e996a7be784', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:39', ':get', '/getTrades', null, '1399449099765');
INSERT INTO `e_log` VALUES ('6f788849-8e22-4abf-a0ef-06b3e2f03f87', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:17:22', ':get', '/getSalesByChannel/1/1399965266812', null, '1399965442750');
INSERT INTO `e_log` VALUES ('6fc6e6f0-5c30-4f80-be2c-a018627d675e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 11:41:47', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520507718');
INSERT INTO `e_log` VALUES ('6fd63d90-edca-4a43-b9f2-04acf8889512', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:28', ':get', '/getSalesByChannel/1/1399453348375', null, '1399453348671');
INSERT INTO `e_log` VALUES ('6fe9c7df-6107-41b0-8cf0-8f2fdea1e2cc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:41', ':post', '/demo/addShopEmps', '{:emps \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399616801120');
INSERT INTO `e_log` VALUES ('6fef8fef-c1ec-439d-a28b-888cb0fec3c4', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:43:57', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517037562');
INSERT INTO `e_log` VALUES ('6ffb9fcc-f86c-443c-8272-c595fd6752bb', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:17', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399516757312');
INSERT INTO `e_log` VALUES ('7003a3cf-6618-4b67-8d73-9d0cacd68183', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 12:01:49', ':get', '/getSalesByChannel/1/1399953700345', null, '1399953709126');
INSERT INTO `e_log` VALUES ('7030640b-39d5-435b-9463-54b0a816228f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:47:16', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399520836328');
INSERT INTO `e_log` VALUES ('705d7d82-1847-4b4c-bc81-620fa4167009', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:25:58', ':get', '/demo/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399616758308');
INSERT INTO `e_log` VALUES ('708e108a-5b86-42a6-b054-414539c10ea5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:19:57', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399601997031');
INSERT INTO `e_log` VALUES ('709b6455-aa98-4ea5-b9ff-0284a9862020', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:27:18', ':post', '/demo/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399616838120');
INSERT INTO `e_log` VALUES ('70c78bb3-2231-4929-85c4-949d4c5fb77b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:33', ':get', '/getSalesByChannel/0/1399453348703', null, '1399453353015');
INSERT INTO `e_log` VALUES ('70cf055d-ef17-4473-8b9b-504bfc0a4fb8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:27:42', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616862823');
INSERT INTO `e_log` VALUES ('70eaf78b-07cf-4e9c-8218-2c736e79699e', null, '13651083480', '118.194.195.3', '2014-05-09 14:33:47', ':get', '/demo/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/9fe8f8d8-f280-427c-94c8-c97abaccb449', null, '1399617227886');
INSERT INTO `e_log` VALUES ('710523a1-60ac-4a72-bfc8-bff91aba68d5', null, '1', '192.168.253.3', '2014-05-08 10:55:48', ':post', '/login', '{:phone \"1\"}', '1399517748234');
INSERT INTO `e_log` VALUES ('715933c5-b64a-4f9c-a7d0-a73a07fc5f16', null, null, '118.194.195.3', '2014-05-09 14:07:23', ':get', '/demo/getImageFile/-711923960_1399521341112.png', null, '1399615643214');
INSERT INTO `e_log` VALUES ('718d5228-f4f0-4fa5-befe-b5f83546b824', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:49:20', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399963760781');
INSERT INTO `e_log` VALUES ('71d4b5da-396a-4bf3-8437-a0165b3871bb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:03:39', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511019015');
INSERT INTO `e_log` VALUES ('7261f77a-5909-43fc-bbdd-4de8b871f637', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:40:24', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399513224843');
INSERT INTO `e_log` VALUES ('72699994-5874-4a34-9580-b222b64ea949', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:19', ':get', '/demo/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/36a9a92d-9f19-4a8b-a566-841b5cf258af', null, '1399616479042');
INSERT INTO `e_log` VALUES ('729b5b9b-b46b-4773-941a-595c1e47838b', null, '13651083480', '118.194.195.3', '2014-05-09 14:07:21', ':get', '/demo/getSalesByChannel/1/1399615604730', null, '1399615641245');
INSERT INTO `e_log` VALUES ('72af98bb-22bc-4577-a889-60962f36d708', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:51:55', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399967481656', null, '1399967515203');
INSERT INTO `e_log` VALUES ('7367612f-cc19-4070-933c-bdcada3daff6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:13:17', ':get', '/demo/getShopsByDistance/40.073684/116.242457/20/0', null, '1399615997276');
INSERT INTO `e_log` VALUES ('73bca826-f04c-463e-a160-040e2d440999', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:57', ':post', '/demo/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399624377698');
INSERT INTO `e_log` VALUES ('73ecd7f4-11b8-4aaf-93e2-cc6552d7cb79', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:10', ':get', '/demo/getSalesByChannel/1/1399616462042', null, '1399616470464');
INSERT INTO `e_log` VALUES ('73fd1337-2d8c-4a39-8bf7-2ff57eb9328c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:46:52', ':get', '/demo/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399618012526');
INSERT INTO `e_log` VALUES ('740948a5-ca34-404d-bf69-7e75eaea460e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:41', ':get', '/getSaleFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607261500');
INSERT INTO `e_log` VALUES ('74103241-76c9-4254-afb2-91829053e775', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:03:38', ':get', '/getShopsByDistance/40.073683/116.242453/2000/0', null, '1399968218078');
INSERT INTO `e_log` VALUES ('743caf36-7216-48eb-973e-b032cd3e118e', null, '13651083480', '192.168.253.3', '2014-05-13 16:40:29', ':get', '/getModules/me', null, '1399970429890');
INSERT INTO `e_log` VALUES ('743db9f0-e186-486e-ad3a-f98a74d4771a', null, '1', '192.168.253.3', '2014-05-08 11:41:32', ':post', '/login', '{:phone \"1\"}', '1399520492484');
INSERT INTO `e_log` VALUES ('7468a16a-6aba-4d8d-8a66-0c9b581190cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:55:06', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399971306906');
INSERT INTO `e_log` VALUES ('7492ca6e-3eae-4bff-96a3-736fa251937c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:38:29', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399516709375');
INSERT INTO `e_log` VALUES ('749d261b-d27a-45c5-b62e-e8fbda10c470', null, '13651083480', '192.168.253.3', '2014-05-13 14:12:20', ':post', '/login', '{:phone \"13651083480\"}', '1399961540437');
INSERT INTO `e_log` VALUES ('7500a62e-39c2-4dbc-aba5-b0898ef4c8d6', null, null, '192.168.253.3', '2014-05-07 16:58:46', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453126062');
INSERT INTO `e_log` VALUES ('7513f299-d09e-4c63-94c6-65e7aa9e2d80', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:09:58', ':get', '/demo/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399615798948');
INSERT INTO `e_log` VALUES ('752564e2-14b8-4328-93b8-feabfb0eefe9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:02:53', ':post', '/searchUsers', '{:search-word \"1\"}', '1399971773953');
INSERT INTO `e_log` VALUES ('752bc4f5-1caf-4f56-ae8e-e82d963629c9', null, '13651083480', '192.168.253.3', '2014-05-08 10:32:38', ':post', '/registerUser', '{:fileNameList \"\", :phone \"1\", :type \"1\", :name \"%E4%BE%9D%E4%BE%9D\"}', '1399516358765');
INSERT INTO `e_log` VALUES ('754865bc-5038-4f4d-bffb-ee0f7a21dc59', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:25:19', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399969519671');
INSERT INTO `e_log` VALUES ('757eda53-dbb8-43d1-9983-8bd1eabe9a55', null, '13651083480', '192.168.253.3', '2014-05-08 09:03:36', ':post', '/login', '{:phone \"13651083480\"}', '1399511016343');
INSERT INTO `e_log` VALUES ('75d92cfd-cdcd-4e33-a513-3b01fe0c6b81', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:29:16', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399526956093');
INSERT INTO `e_log` VALUES ('763eda95-0d8c-4c1f-98f3-11811fa408f6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:59:12', ':get', '/demo/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399618752167');
INSERT INTO `e_log` VALUES ('767c6b37-2687-4ec5-bf47-c21ff9292ad6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:41:50', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399603310937');
INSERT INTO `e_log` VALUES ('768d68c0-86f6-4d6e-aeea-706ac3a4bf33', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:19:39', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450779140');
INSERT INTO `e_log` VALUES ('7693989e-7013-450e-a501-968058200a85', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:38:38', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399595918109');
INSERT INTO `e_log` VALUES ('76fbd2c9-f4b9-444f-9b8c-7a1523b46a2d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:09:48', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399968588109');
INSERT INTO `e_log` VALUES ('7713b183-f66e-4a96-a91b-e9fddc85eccc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:33:17', ':get', '/demo/getSalesByChannel/3/1399624393776', null, '1399624397245');
INSERT INTO `e_log` VALUES ('772d9e9d-fbcc-4852-bd26-b50ddfccb109', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:13:27', ':get', '/getTrades', null, '1399511607000');
INSERT INTO `e_log` VALUES ('779303f2-4972-421d-8b06-473e5c31a935', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:03:21', ':get', '/getSalesByChannel/2/1399971109000', null, '1399971801109');
INSERT INTO `e_log` VALUES ('77b9998e-6d1e-4fa5-bd3d-019a500ed87d', null, '1', '192.168.253.3', '2014-05-13 15:44:05', ':post', '/login', '{:phone \"1\"}', '1399967045375');
INSERT INTO `e_log` VALUES ('77d38d8c-65b3-4a98-87bc-6977cd30f8f6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:53:04', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/-1', null, '1399517584390');
INSERT INTO `e_log` VALUES ('77dddbc1-b0be-4c43-96d6-8a1ae16a0e33', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:43:26', ':get', '/getShopFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517006875');
INSERT INTO `e_log` VALUES ('77f315dc-338f-4a37-adab-5d368eb5b223', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:41:10', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E4%BC%98%E6%83%A0%E7%9C%9F%E5%A4%A7\", :fileNameList \"463517179_1399516848803.png%7C-104682932_1399516864279.png\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", \"463517179_1399516848803.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-213471294769942995.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399516848803.png\"}, \"-104682932_1399516864279.png\" {:size 50594, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2224820879666342011.tmp>, :content-type \"image/pjpeg\", :filename \"-104682932_1399516864279.png\"}}', '1399516870937');
INSERT INTO `e_log` VALUES ('7808da2c-bca7-4daf-afa5-6c9053ba9cdc', null, '13651083480', '192.168.253.3', '2014-05-07 15:17:00', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"%E4%BA%BA%E4%BA%BA\"}', '1399447020640');
INSERT INTO `e_log` VALUES ('7852411c-fb06-4fab-a89a-481022c8bbcd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 13:19:41', ':get', '/getSalesByDistance/40.073727/116.242438/2000/0', null, '1399958381218');
INSERT INTO `e_log` VALUES ('788013a9-282b-4ff8-961c-7da9508ad24b', null, '1', '192.168.253.3', '2014-05-13 15:51:17', ':post', '/login', '{:phone \"1\"}', '1399967477296');
INSERT INTO `e_log` VALUES ('7886d045-bf81-4f97-b676-b42a3d99cc89', null, '13651083480', '192.168.253.3', '2014-05-13 16:48:06', ':post', '/login', '{:phone \"13651083480\"}', '1399970886171');
INSERT INTO `e_log` VALUES ('78f85312-4813-4da5-b1f8-ecd920ccb57a', null, '13651083480', '118.194.195.3', '2014-05-09 14:43:15', ':get', '/demo/getSalesByChannel/0/-1', null, '1399617795995');
INSERT INTO `e_log` VALUES ('79035535-c755-4dc7-83d5-a31613ab4abe', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780312');
INSERT INTO `e_log` VALUES ('790d264b-5dfc-4359-b339-04465d63b9d9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:13:39', ':get', '/demo/getSalesByDistance/40.073684/116.242457/20/1', null, '1399616019776');
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
INSERT INTO `e_log` VALUES ('7a84749f-606c-4547-84a4-5419c3fdeeb6', null, '13651083480', '223.203.193.252', '2014-05-09 16:32:09', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399624329042');
INSERT INTO `e_log` VALUES ('7acd3aab-92c7-4068-84f7-2a46588b67c3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:25:51', ':get', '/demo/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399616751698');
INSERT INTO `e_log` VALUES ('7b0326d0-5e56-4442-b118-234ee6db0daa', null, '13651083480', '192.168.253.3', '2014-05-08 09:09:58', ':post', '/login', '{:phone \"13651083480\"}', '1399511398234');
INSERT INTO `e_log` VALUES ('7b15332d-43d0-4cd2-9191-848b5b10a8ea', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:09:13', ':get', '/demo/getTrades', null, '1399615753823');
INSERT INTO `e_log` VALUES ('7b719564-8996-4017-b615-b002b0a52fff', null, null, '192.168.253.2', '2014-05-13 13:34:27', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399959267734');
INSERT INTO `e_log` VALUES ('7bbc1079-4bdf-4a1d-8d33-45e8461d32b9', null, '13651083480', '192.168.253.3', '2014-05-13 09:25:07', ':get', '/getModules/discover', null, '1399944307360');
INSERT INTO `e_log` VALUES ('7bcdb9b0-eb0c-4630-bc8c-ec6a3c5c88b8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:03:39', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399971517921', null, '1399971819328');
INSERT INTO `e_log` VALUES ('7bf1612d-6f36-4da4-a400-268b7909ebea', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:34', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399616494370');
INSERT INTO `e_log` VALUES ('7bf58787-2c6b-4c1c-94d4-2eab5fe50c8c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:15:29', ':get', '/demo/getSaleFavoritesByUser/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616129933');
INSERT INTO `e_log` VALUES ('7c079c84-4307-4d86-84ea-55194df7101d', null, null, '192.168.253.3', '2014-05-08 10:41:12', ':get', '/getImageFile/463517179_1399516848803.png', null, '1399516872000');
INSERT INTO `e_log` VALUES ('7c33e912-4d89-4ea4-910d-e27a18da42c0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:47:38', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399528058984');
INSERT INTO `e_log` VALUES ('7c7ddcb4-32cf-4198-b568-2a31355c28f0', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:18:21', ':get', '/demo/getSalesByDistance/4.9E-324/4.9E-324/2000/0', null, '1399616301120');
INSERT INTO `e_log` VALUES ('7cb82964-09fd-4db4-b7af-b18e41c78ecd', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:02', ':get', '/demo/getSalesByChannel/1/1399616417276', null, '1399616462026');
INSERT INTO `e_log` VALUES ('7cd47844-2603-402b-a2a8-e7a83b145c86', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 09:27:11', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399944431298');
INSERT INTO `e_log` VALUES ('7d66eca7-17f0-41e0-a0dc-66a3b7740334', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:12', ':get', '/getSalesByDistance/40.073715/116.242448/2000/0', null, '1399517052125');
INSERT INTO `e_log` VALUES ('7d881f53-8504-4fa5-8a4e-eece80bb17e5', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:08', ':get', '/getSalesByChannel/0/1399446577046', null, '1399446608031');
INSERT INTO `e_log` VALUES ('7dbd9350-fa06-4f7b-bcd0-19b759c34a3d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:08:03', ':post', '/updateShop', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :field \"desc\", :value \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E5%A4%A7%E5%93%81%E7%89%8C\", :fileNameList \"\"}', '1399453683718');
INSERT INTO `e_log` VALUES ('7dff29cf-1f8d-4946-8336-4b62662c040b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:44:00', ':put', '/updateShopTrades', '{:tradeList \"41|42\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399513440734');
INSERT INTO `e_log` VALUES ('7e0f11e0-3f01-43c2-9b54-98ec26224d3e', null, '13651083480', '192.168.253.3', '2014-05-13 09:24:40', ':get', '/getSalesByChannel/0/-1', null, '1399944280892');
INSERT INTO `e_log` VALUES ('7e1f616c-b3ee-46ef-adbf-2ea3f326e10c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:51', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399607271343');
INSERT INTO `e_log` VALUES ('7e6a224d-af66-4d12-8d93-13a06f68d90b', null, '13651083480', '192.168.253.3', '2014-05-13 14:42:58', ':get', '/getSalesByChannel/1/1399963313812', null, '1399963378765');
INSERT INTO `e_log` VALUES ('7ee507ea-2f19-4bba-9745-86aaa66c5d14', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:32', ':get', '/getSalesByChannel/0/1399448576921', null, '1399448672296');
INSERT INTO `e_log` VALUES ('7ef51083-7540-42f9-9d12-2b85f88ee47a', null, '13651083480', '192.168.253.3', '2014-05-07 16:23:18', ':post', '/login', '{:phone \"13651083480\"}', '1399450998015');
INSERT INTO `e_log` VALUES ('7f3b507a-aff3-4cf4-b034-dad0b45f8663', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:45:34', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399617934480');
INSERT INTO `e_log` VALUES ('7f46ec1f-ce4f-45b4-9e0b-99e36a344290', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 13:37:47', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399959467421');
INSERT INTO `e_log` VALUES ('7f49b047-2931-47f6-aea0-f389b5a7b72d', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:20', ':get', '/getSettings', null, '1399446380453');
INSERT INTO `e_log` VALUES ('80188625-d5b3-4ca6-b419-4cd85b68611c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:43:55', ':get', '/demo/getTrades', null, '1399617835917');
INSERT INTO `e_log` VALUES ('8028868c-3e7e-4d4f-88cc-e5b566bcf835', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:29:33', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399616864698', null, '1399616973792');
INSERT INTO `e_log` VALUES ('80427d2f-176e-4bdd-9786-32b71812c4c2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:15:56', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399616153089', null, '1399616156495');
INSERT INTO `e_log` VALUES ('8047893e-1055-4c0f-807b-72a09bdd04e8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:12:58', ':get', '/demo/getSalesByDistance/40.073684/116.242457/2000/0', null, '1399615978855');
INSERT INTO `e_log` VALUES ('80967f34-a3a0-409b-988f-c390f93c30cc', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:34:10', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399602850046');
INSERT INTO `e_log` VALUES ('80c786f6-37f4-4ca9-af78-8f43b177198d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:53:58', ':get', '/getSalesByShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399521085218', null, '1399521238812');
INSERT INTO `e_log` VALUES ('810dd5ac-95fa-4feb-8487-38b4aada2ff2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:25:02', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399967548828', null, '1399969502093');
INSERT INTO `e_log` VALUES ('822a47d1-7611-423a-867d-c82f90cdbef4', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:13', ':get', '/getSalesByChannel/1/1399530793359', null, '1399530793843');
INSERT INTO `e_log` VALUES ('833dd651-f77a-499e-bb6b-a9ce0f8ba361', null, '13651083480', '192.168.253.3', '2014-05-07 15:16:33', ':get', '/getSalesByChannel/0/1399446608500', null, '1399446993046');
INSERT INTO `e_log` VALUES ('833e771d-6fdb-4e1f-b083-15cae12a6bb5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:31', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399448671234');
INSERT INTO `e_log` VALUES ('8350c76b-6fef-43e2-b7bc-ad026922c9d1', null, null, '118.194.195.3', '2014-05-09 14:17:33', ':get', '/demo/pub/grade_shop.html', null, '1399616253761');
INSERT INTO `e_log` VALUES ('83512152-0dfb-4b7e-a93b-06c2fea6831c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:00:22', ':get', '/getSalesByDistance/40.073683/116.242453/2000/0', null, '1399968022000');
INSERT INTO `e_log` VALUES ('84202e6f-a2b7-49ff-b3f6-f857d46a75cd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:25:38', ':get', '/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399969538625');
INSERT INTO `e_log` VALUES ('8422d120-7f09-44ce-b260-d8a977e2b7f0', null, '13651083480', '192.168.253.3', '2014-05-08 10:22:50', ':post', '/login', '{:phone \"13651083480\"}', '1399515770578');
INSERT INTO `e_log` VALUES ('8431e0b6-f318-451e-8553-ee132cd8e1cf', null, '13651083480', '192.168.253.3', '2014-05-13 09:26:31', ':get', '/getShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399944391329');
INSERT INTO `e_log` VALUES ('845a7bd7-a845-4f77-9f8a-fc6d8e313764', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:26', ':post', '/registerUser', '{:fileNameList \"13651083480_1399446443410.png\", :phone \"13651083480\", :type \"1\", :photo \"13651083480_1399446443410.png\", :name \"%E5%A6%9E%E5%A6%9E\", \"13651083480_1399446443410.png\" {:size 46837, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7366176588694513618.tmp>, :content-type \"image/pjpeg\", :filename \"13651083480_1399446443410.png\"}}', '1399446446046');
INSERT INTO `e_log` VALUES ('845d172c-a4f6-40da-84c3-e22c58a38023', null, '1', '192.168.253.3', '2014-05-09 11:28:15', ':post', '/login', '{:phone \"1\"}', '1399606095812');
INSERT INTO `e_log` VALUES ('84642af6-aa5d-447c-89a0-684194c6481f', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:56', ':get', '/getSalesByChannel/1/1399448575968', null, '1399448576890');
INSERT INTO `e_log` VALUES ('848a4ce0-38f3-440e-b446-2e97d0a48f98', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:28:18', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399951698751');
INSERT INTO `e_log` VALUES ('84c203db-3ceb-4f90-9dc6-f7575de71fe3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:12:57', ':get', '/demo/getSettings', null, '1399615977823');
INSERT INTO `e_log` VALUES ('84f12ad7-59e2-4e9a-9774-96243c838bf1', null, null, '192.168.253.3', '2014-05-08 09:24:10', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512250171');
INSERT INTO `e_log` VALUES ('84f74b1e-612e-413e-a967-d7c5d5d0cea1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:10:32', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450232343');
INSERT INTO `e_log` VALUES ('85180f01-66f6-4c0f-8735-755eb6f6f0bc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:05', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399595645546');
INSERT INTO `e_log` VALUES ('851efe21-4a86-4b74-996f-620bf843fc33', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:49:31', ':get', '/getSettings', null, '1399538971640');
INSERT INTO `e_log` VALUES ('853486e2-f8bd-4975-88fd-e5e5de659a95', null, '13651083480', '192.168.253.3', '2014-05-13 15:34:24', ':post', '/login', '{:phone \"13651083480\"}', '1399966464546');
INSERT INTO `e_log` VALUES ('853a20eb-33cc-4c6a-854d-4bedee37546e', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:03', ':get', '/getChannels', null, '1399446363593');
INSERT INTO `e_log` VALUES ('85683f3a-3122-44d4-aaae-dc2d0a476274', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:42', ':get', '/getSalesByChannel/0/1399449032515', null, '1399449042921');
INSERT INTO `e_log` VALUES ('85b8bdd3-694f-4edf-aef5-42b06e2f45af', null, null, '118.194.195.3', '2014-05-09 14:03:27', ':get', '/demo/app/ios_android.png', null, '1399615407667');
INSERT INTO `e_log` VALUES ('86870d36-d8a1-4f2d-a5a7-6d65dbf8bf61', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:51', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516757375', null, '1399516791343');
INSERT INTO `e_log` VALUES ('86a7d40d-b181-403a-9aa9-19a5f2e8fc4e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:37:32', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399603052515');
INSERT INTO `e_log` VALUES ('86e19041-035c-4441-94b5-8134ee8319fc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:04:06', ':get', '/getSalesByChannel/1/1399968127343', null, '1399968246171');
INSERT INTO `e_log` VALUES ('87140004-4a1f-49d5-96be-2e778f7d6258', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:47:49', ':get', '/getSalesByChannel/1/1399967131531', null, '1399967269234');
INSERT INTO `e_log` VALUES ('872b4982-89ed-4032-af1e-b4e0f38bb39f', null, '1', '192.168.253.3', '2014-05-13 15:44:45', ':post', '/login', '{:phone \"1\"}', '1399967085125');
INSERT INTO `e_log` VALUES ('8739bb2a-ab31-4c1c-8e64-60366a832fd8', null, '13651083480', '192.168.253.3', '2014-05-07 15:43:31', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"222\"}', '1399448611484');
INSERT INTO `e_log` VALUES ('876e5f4b-3dce-4b05-b6bd-dae20e186daf', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:43:48', ':get', '/demo/getUserShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399617828448');
INSERT INTO `e_log` VALUES ('8794b804-6c5a-4c35-9f7d-33960ec0d044', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:14', ':post', '/addSale', '{:content \"%E5%85%A8%E5%9C%BA%E6%B1%89%E5%A0%A1%E4%B9%B0%E4%B8%80%E9%80%81%E4%B8%80\", :end_date \"1401465600000\", \"50489896_1399453226535.png\" {:size 228877, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2626007887600820125.tmp>, :content-type \"image/pjpeg\", :filename \"50489896_1399453226535.png\"}, :fileNameList \"50489896_1399453226535.png\", :title \"%E4%BA%94%E6%9C%88%E4%BC%98%E6%83%A0%E5%A4%A7%E6%94%BE%E9%80%81\", :trade_id \"1\", :start_date \"1398873600000\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453274984');
INSERT INTO `e_log` VALUES ('87a942d2-3b3d-4193-a15a-18159dffa08d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:41', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453301359');
INSERT INTO `e_log` VALUES ('87b2d814-dacd-438e-8c7e-9f0e9f1fe4f1', null, null, '192.168.253.3', '2014-05-08 10:41:12', ':get', '/getImageFile/-104682932_1399516864279.png', null, '1399516872000');
INSERT INTO `e_log` VALUES ('87d8d276-a8c3-45af-88e1-1a5f20dacc16', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:39:40', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399966772328', null, '1399966780593');
INSERT INTO `e_log` VALUES ('87d9f409-a37a-4047-a79f-3916f4b034b9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:52', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453132406');
INSERT INTO `e_log` VALUES ('88829a5c-212f-4733-a03f-81670bc39661', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 17:04:09', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399971849687');
INSERT INTO `e_log` VALUES ('891ce0dd-afb6-470b-a001-cabb6c4c6e16', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:27:25', ':get', '/getSalesByChannel/1/1399965442781', null, '1399966045703');
INSERT INTO `e_log` VALUES ('8954d480-fad5-4458-a757-c351013cb0ca', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:37', ':get', '/getChannels', null, '1399533937812');
INSERT INTO `e_log` VALUES ('8955b532-834b-48ab-8576-cd9183f5ecad', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:43:54', ':post', '/demo/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399617834792');
INSERT INTO `e_log` VALUES ('89dac233-0337-4b81-92e1-7d307c64dd1f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:37', ':get', '/getSalesByChannel/3/1399521454796', null, '1399521457546');
INSERT INTO `e_log` VALUES ('8a50032c-1407-48fa-8f86-8c3af237f5a3', null, '1', '192.168.253.3', '2014-05-13 15:51:49', ':post', '/login', '{:phone \"1\"}', '1399967509734');
INSERT INTO `e_log` VALUES ('8a588999-243d-44da-a7f9-5136a27aff9e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:29', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399451009109');
INSERT INTO `e_log` VALUES ('8ab6ba43-08aa-451c-a85c-3a4ffa6216aa', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:13:00', ':get', '/demo/getShopsByDistance/40.073684/116.242457/2000/0', null, '1399615980167');
INSERT INTO `e_log` VALUES ('8b4ff1fe-9957-4b59-acfa-653fc0a9ffd6', null, '1', '192.168.253.3', '2014-05-09 11:29:33', ':post', '/login', '{:phone \"1\"}', '1399606173578');
INSERT INTO `e_log` VALUES ('8bf18cce-06d0-43bf-8766-1397a52cbebe', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:51:15', ':get', '/getSalesByChannel/1/1399538967328', null, '1399539075765');
INSERT INTO `e_log` VALUES ('8bfbb160-cf1e-4d05-9bfa-3d1148a32d85', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 09:27:07', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399944427689');
INSERT INTO `e_log` VALUES ('8c2bee59-bd35-4185-ac8d-09cb718ae790', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:49:21', ':get', '/getSalesByChannel/1/1399963749718', null, '1399963761890');
INSERT INTO `e_log` VALUES ('8c57173f-e258-40c3-8a78-5c55653bdd53', null, '13651083480', '192.168.253.3', '2014-05-07 16:39:45', ':post', '/login', '{:phone \"13651083480\"}', '1399451985312');
INSERT INTO `e_log` VALUES ('8c6f2412-c4e3-44f3-8489-c72e9ef3976a', null, '1', '192.168.253.3', '2014-05-08 16:11:22', ':post', '/login', '{:phone \"1\"}', '1399536682468');
INSERT INTO `e_log` VALUES ('8caef690-2dff-41cb-b8da-be92406be19b', null, '13651083480', '118.194.195.3', '2014-05-09 14:07:22', ':get', '/demo/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/43f79202-6ea1-4c38-b923-b9fdeb013932', null, '1399615642964');
INSERT INTO `e_log` VALUES ('8ccd218d-3640-4419-912d-81db8298685b', null, '1', '192.168.253.3', '2014-05-09 10:34:06', ':post', '/login', '{:phone \"1\"}', '1399602846859');
INSERT INTO `e_log` VALUES ('8d1d36dd-237a-44c8-a954-f0cd8fb92e4b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:30', ':get', '/getSalesByChannel/1/1399530799656', null, '1399530810796');
INSERT INTO `e_log` VALUES ('8d1d3c6c-87e1-4f99-8aca-c9a2eca2735a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:40:35', ':get', '/getSalesByChannel/1/1399966818828', null, '1399966835515');
INSERT INTO `e_log` VALUES ('8d239c9b-e91b-4bdc-b514-50ab70eb6ab2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:47:00', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520820609');
INSERT INTO `e_log` VALUES ('8e3fc0fe-102c-4626-9ade-a3a6b17e2e0d', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 13:19:43', ':get', '/getShopsByDistance/40.073727/116.242438/2000/0', null, '1399958383062');
INSERT INTO `e_log` VALUES ('8e46ef15-0d59-4cac-9f8e-362f31f55d5f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:18:43', ':get', '/demo/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616323886');
INSERT INTO `e_log` VALUES ('8eb93119-faa5-4278-bcf1-b1a771e5e907', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:50:12', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399456212750');
INSERT INTO `e_log` VALUES ('8ed066b0-7e13-42d3-bb25-755b533cc70e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:52', ':get', '/getSettings', null, '1399448692171');
INSERT INTO `e_log` VALUES ('8f17752e-da96-44c9-ae82-b9cf1826e63f', null, null, '192.168.253.3', '2014-05-08 09:57:03', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514223890');
INSERT INTO `e_log` VALUES ('8f98c5d4-df2e-4f98-b905-40f78f75d6de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:31', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453531093');
INSERT INTO `e_log` VALUES ('9027d000-1574-436b-bf50-18f84621ed56', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:32:14', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399963929625', null, '1399966334468');
INSERT INTO `e_log` VALUES ('904ab94f-6f17-4e55-a0cf-617ef3b5f31a', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780125');
INSERT INTO `e_log` VALUES ('90881ee6-fff2-49b2-8ddb-1143a6fd47a7', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:43', ':post', '/login', '{:phone \"13651083480\"}', '1399446643296');
INSERT INTO `e_log` VALUES ('9102ef49-382f-4ed1-8667-cb0f9089dec5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:13:18', ':get', '/getSalesByChannel/1/1399950641642', null, '1399950798798');
INSERT INTO `e_log` VALUES ('911c99c0-2d14-40b9-a370-83698a557a34', null, null, '192.168.253.3', '2014-05-08 09:55:03', ':get', '/getImageFile/-810116522_1399514097772.png', null, '1399514103000');
INSERT INTO `e_log` VALUES ('91405d0f-e82f-482a-b5bd-da61e0d82aed', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:48:19', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399970899015');
INSERT INTO `e_log` VALUES ('9192a327-0878-46f5-9768-d749aa6184cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:31:34', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399527094015');
INSERT INTO `e_log` VALUES ('91b2494a-d7e4-498f-90a9-c4f9d0833e49', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 17:04:11', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399971851843');
INSERT INTO `e_log` VALUES ('926d9d15-21c4-4910-a78e-d855566de12d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:55:05', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971305046');
INSERT INTO `e_log` VALUES ('9291175a-eeba-4530-86a3-9192d6fb1b9c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:18:59', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450736650.png\", \"463517179_1399450736650.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-6386821006836686561.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450736650.png\"}, :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242447%2C%22radius%22%3A39.31818389892578%2C%22latitude%22%3A40.073715%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450736650.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450739031');
INSERT INTO `e_log` VALUES ('92c55976-9bc9-41e7-a30e-46a2ea3671a2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:40:40', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399964187265', null, '1399966840000');
INSERT INTO `e_log` VALUES ('92c80bbd-f87c-4c44-95b8-2aed0ba273a2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:11', ':get', '/getModules/discover', null, '1399516751968');
INSERT INTO `e_log` VALUES ('92df0aad-c508-49d4-801e-ac49af3fe6ba', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:45:45', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399520745406');
INSERT INTO `e_log` VALUES ('93021c0e-ee30-43f2-998e-556db4d4f850', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:52', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399452952421');
INSERT INTO `e_log` VALUES ('934f45b6-e63e-4116-94b2-bfc5b7ebe086', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:22', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607242703');
INSERT INTO `e_log` VALUES ('935b3306-d0a6-4dfd-a266-205185f62e5d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:59', ':get', '/getSalesByChannel/1/1399448758515', null, '1399448759171');
INSERT INTO `e_log` VALUES ('93628f2c-1037-49b8-adce-9b3f69cabd48', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:59', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"妞妞\"}', '1399449059484');
INSERT INTO `e_log` VALUES ('93a4e3a9-e0b8-4ddd-b508-3edf3d5034aa', null, null, '192.168.253.2', '2014-05-13 13:33:46', ':get', '/favicon.ico', null, '1399959226703');
INSERT INTO `e_log` VALUES ('93c07046-32e2-46c6-96f6-dbb6002a26f3', null, null, '118.194.195.3', '2014-05-09 14:06:38', ':get', '/demo/getImageFile/-354365311_1399521331897.png', null, '1399615598167');
INSERT INTO `e_log` VALUES ('9487d840-a498-4d94-b6f1-52685b743983', null, null, '192.168.253.1', '2014-05-07 16:31:20', ':get', '/aa', null, '1399451480281');
INSERT INTO `e_log` VALUES ('94e79313-5e19-4a00-bc92-82ecdfafabff', null, '1', '192.168.253.3', '2014-05-13 10:56:22', ':post', '/login', '{:phone \"1\"}', '1399949782892');
INSERT INTO `e_log` VALUES ('94f55592-5a11-414c-9acf-8b415473822b', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780531');
INSERT INTO `e_log` VALUES ('954eb7aa-caa8-47b8-b86d-6114783cfdce', null, '13651083480', '192.168.253.3', '2014-05-08 09:13:05', ':get', '/getSalesByChannel/1/1399511585484', null, '1399511585937');
INSERT INTO `e_log` VALUES ('9582b7a4-07a9-48b3-8800-b0320c26614e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:29', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399530809906');
INSERT INTO `e_log` VALUES ('95cdac71-012e-45ef-81ae-e0cbe85a6c9c', null, '13651083480', '192.168.253.3', '2014-05-13 15:43:48', ':get', '/getSalesByChannel/1/1399966835546', null, '1399967028140');
INSERT INTO `e_log` VALUES ('95de4614-a955-4907-a262-8df5b3b04a79', null, '13651083480', '192.168.253.3', '2014-05-07 16:11:12', ':post', '/login', '{:phone \"13651083480\"}', '1399450272234');
INSERT INTO `e_log` VALUES ('95e70c25-8777-4b68-8378-d8c2381506ee', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:49:51', ':get', '/getSettings', null, '1399963791109');
INSERT INTO `e_log` VALUES ('962f3840-ffd6-49a7-a371-2d1cafd06736', null, null, '192.168.253.1', '2014-05-13 18:28:19', ':get', '/index.html', null, '1399976899718');
INSERT INTO `e_log` VALUES ('9665b07e-ce90-45d5-b460-42b250922cc4', null, '13651083480', '192.168.253.3', '2014-05-07 16:39:03', ':post', '/login', '{:phone \"13651083480\"}', '1399451943312');
INSERT INTO `e_log` VALUES ('967db682-be0b-4858-901b-fc3b1484f187', null, '13651083480', '192.168.253.3', '2014-05-08 09:13:03', ':get', '/getChannels', null, '1399511583968');
INSERT INTO `e_log` VALUES ('968dd435-4342-402a-b88c-19101a201cba', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:25:08', ':get', '/getSalesByChannel/1/1399950798845', null, '1399951508735');
INSERT INTO `e_log` VALUES ('9697f4bc-3978-462a-8c22-c3c3788ddaa2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:19:08', ':get', '/demo/getSaleFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616348011');
INSERT INTO `e_log` VALUES ('969ea643-ee66-42ec-9451-16a951cf4df9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:25:55', ':delete', '/demo/deleteShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616755401');
INSERT INTO `e_log` VALUES ('97016f38-4071-476a-8774-d05a82132cca', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:52:04', ':get', '/getSalesByChannel/1/1399963913171', null, '1399963924265');
INSERT INTO `e_log` VALUES ('9741ce8b-3913-4fde-821f-654200ecc112', null, '13651083480', '118.194.195.3', '2014-05-09 14:08:17', ':get', '/demo/getSalesByChannel/1/1399615641245', null, '1399615697448');
INSERT INTO `e_log` VALUES ('976d6457-f9b6-4d94-9e5f-8c362a48fe01', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 15:28:39', ':get', '/demo/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399620519308');
INSERT INTO `e_log` VALUES ('976df005-8f89-46cc-9a6b-e1fc04b9eaf6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:10:41', ':get', '/getSalesByChannel/1/1399949850220', null, '1399950641610');
INSERT INTO `e_log` VALUES ('977f6533-7037-476f-9345-34e4c6f89ec7', null, '13651083480', '192.168.253.3', '2014-05-08 11:53:51', ':post', '/login', '{:phone \"13651083480\"}', '1399521231437');
INSERT INTO `e_log` VALUES ('97bcbef4-e33e-455e-aa75-7e0748bfe76c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 09:30:07', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399944607110');
INSERT INTO `e_log` VALUES ('97f6f45e-1331-4f01-9c22-8441c19f6ae6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:27:40', ':get', '/getShopShares/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399516060359');
INSERT INTO `e_log` VALUES ('98256bf8-d5cb-4cb0-94a4-75c3dac72c34', null, '13651083480', '118.194.195.3', '2014-05-09 14:49:26', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/c888a184-8678-4193-ad6e-85c84fde2a93', null, '1399618166558');
INSERT INTO `e_log` VALUES ('982e6348-519d-4bb7-8733-1165501019be', null, '13651083480', '192.168.253.3', '2014-05-13 17:02:36', ':post', '/login', '{:phone \"13651083480\"}', '1399971756328');
INSERT INTO `e_log` VALUES ('98953654-70f3-47ac-9a98-f4ebd63888a0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 11:33:24', ':post', '/saveShareReply', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :share_id \"eb7cd9e8-f6ad-4445-a2d6-3609f01da1c7\", :grade \"5\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎惠顾\"}', '1399606404203');
INSERT INTO `e_log` VALUES ('98f467f9-6b76-4698-8182-0dae2d546ec6', null, null, '118.194.195.3', '2014-05-09 14:09:26', ':get', '/demo/getImageFile/898289355_1399449344232.png', null, '1399615766370');
INSERT INTO `e_log` VALUES ('992015fb-b8ca-4510-a783-4a50d68a2d47', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:13:16', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511596515');
INSERT INTO `e_log` VALUES ('992f2541-1dfb-45da-b02f-b6f810d53f4f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:42:50', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399516970312');
INSERT INTO `e_log` VALUES ('99acd25a-67fd-447e-b9fd-ae5dc725194f', null, null, '118.194.195.3', '2014-05-09 14:07:37', ':get', '/demo/getImageFile/barcode_-509784425_1399515996656.png', null, '1399615657042');
INSERT INTO `e_log` VALUES ('99f00e38-264b-4164-b2c9-afc1e0dc9eba', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:35', ':post', '/login', '{:phone \"13651083480\"}', '1399446575203');
INSERT INTO `e_log` VALUES ('9a07c075-b644-4681-81b5-450e2b32ed3e', null, '13651083480', '192.168.253.3', '2014-05-13 16:35:51', ':post', '/login', '{:phone \"13651083480\"}', '1399970151687');
INSERT INTO `e_log` VALUES ('9a533269-e402-4a24-8247-d79cacb1342c', null, '13651083480', '192.168.253.3', '2014-05-13 09:27:06', ':post', '/login', '{:phone \"13651083480\"}', '1399944426876');
INSERT INTO `e_log` VALUES ('9aee9264-14e6-47a7-963b-90876c1048ad', null, '13651083480', '192.168.253.3', '2014-05-13 17:04:03', ':post', '/login', '{:phone \"1\"}', '1399971843421');
INSERT INTO `e_log` VALUES ('9b291bcf-2f3c-4d87-9aab-63e25e2d7161', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:11:01', ':put', '/updateShopTrades', '{:tradeList \"41|42|40\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399511461062');
INSERT INTO `e_log` VALUES ('9b2a97fc-09ac-4635-a340-4488f64480a9', null, '13651083480', '192.168.253.3', '2014-05-13 15:39:18', ':post', '/login', '{:phone \"13651083480\"}', '1399966758984');
INSERT INTO `e_log` VALUES ('9b31e8e9-abd3-410d-9aa0-8390feef1e6f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:52:53', ':post', '/searchUsers', '{:search-word \"1\"}', '1399517573328');
INSERT INTO `e_log` VALUES ('9b39d492-066f-49f7-adc1-d131147f7566', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:53:05', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528385578');
INSERT INTO `e_log` VALUES ('9b436aee-8efa-4c66-8ab0-0de5694e2eed', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:03:15', ':get', '/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399971301468', null, '1399971795140');
INSERT INTO `e_log` VALUES ('9b4f0461-c3ba-48a9-88a0-f29a241d8515', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:38:42', ':post', '/addSaleDiscuss', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :content \"非常不错啊\"}', '1399516722671');
INSERT INTO `e_log` VALUES ('9b63461e-38f6-4c52-9ed7-ddb15388f2ca', null, null, '192.168.253.3', '2014-05-08 09:54:14', ':get', '/getImageFile/-810116522_1399514042943.png', null, '1399514054296');
INSERT INTO `e_log` VALUES ('9bbe3194-a7b5-49d0-a677-af1b4a6d5f8f', null, '13651083480', '118.194.195.3', '2014-05-09 14:25:33', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399616733636');
INSERT INTO `e_log` VALUES ('9bbefc13-30a0-48fd-ba15-226c60325598', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:33:13', ':get', '/demo/getSalesByChannel/40/1399624369776', null, '1399624393448');
INSERT INTO `e_log` VALUES ('9bf8707c-dfe6-40aa-8210-5e65c733efab', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:58:27', ':get', '/getUserShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971507437');
INSERT INTO `e_log` VALUES ('9c2faa0c-5ea5-4503-8f48-ab978379ffc0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:23:29', ':post', '/updateShop', '{:value \"专卖电脑和书籍，欢迎惠顾。\", :field \"desc\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\"}', '1399515809765');
INSERT INTO `e_log` VALUES ('9d0ce00d-d79c-446a-b855-e9aa27d87fea', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:44:15', ':get', '/demo/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399617855026');
INSERT INTO `e_log` VALUES ('9d366a39-d24d-4c93-8c78-4b598a351d2a', null, '13651083480', '118.194.195.3', '2014-05-09 14:07:36', ':get', '/demo/getShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399615656526');
INSERT INTO `e_log` VALUES ('9d5f9cc7-f45b-4a10-85f6-365da5019bc5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:38', ':get', '/getSalesByChannel/2/1399521457609', null, '1399521458046');
INSERT INTO `e_log` VALUES ('9d6a7841-b562-4617-b239-45e2d3cc8fb7', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':post', '/login', '{:phone \"13651083480\"}', '1399446470312');
INSERT INTO `e_log` VALUES ('9dd1f966-c30c-44dd-9dcd-3fbc8e83d394', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:57', ':post', '/login', '{:phone \"13651083480\"}', '1399448757062');
INSERT INTO `e_log` VALUES ('9e05c1aa-41ac-4c77-aad1-f2c008996d1c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:37:15', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399970235609');
INSERT INTO `e_log` VALUES ('9e3572f0-22a7-4715-8301-ff2b8bc21fee', null, '13651083480', '192.168.253.3', '2014-05-13 09:26:12', ':get', '/getFriendShares/a439840c-e231-4a8f-8a09-7e4f8883fe00/1399944275595', null, '1399944372282');
INSERT INTO `e_log` VALUES ('9e4d963b-a97b-457f-9d83-911c1c1e1a40', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:56:53', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399514213640');
INSERT INTO `e_log` VALUES ('9e7e468d-4302-4941-8d1d-f8f4d29be88e', null, '13651083480', '192.168.253.3', '2014-05-13 16:50:40', ':post', '/login', '{:phone \"13651083480\"}', '1399971040531');
INSERT INTO `e_log` VALUES ('9eb4c829-39c3-4676-b70a-6fcedf1cb51f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:43:36', ':get', '/demo/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399617816776');
INSERT INTO `e_log` VALUES ('9ffe5752-59db-4a2c-b035-56bf7a1f60d3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:09:41', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536581562');
INSERT INTO `e_log` VALUES ('a0012b25-5ba9-4fbb-a19c-5a86f85efe63', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:40:57', ':get', '/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399596057656');
INSERT INTO `e_log` VALUES ('a00d9b9d-8ec5-442f-9fe7-9cddd1059cf0', null, '13651083480', '118.194.195.3', '2014-05-09 14:51:01', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/6b974797-5bf0-42d4-a89b-d57fa70bedf8', null, '1399618261761');
INSERT INTO `e_log` VALUES ('a070b7cc-89b8-4cdb-9d9b-3a9e8d78bccd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:56:11', ':get', '/getFriendShares/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516795859', null, '1399517771765');
INSERT INTO `e_log` VALUES ('a0772799-94da-495b-8fd6-3944b1df7227', null, '13651083480', '118.194.195.3', '2014-05-09 15:27:22', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/d480ed24-b6a5-4bad-a6fc-ca2337c09f15', null, '1399620442105');
INSERT INTO `e_log` VALUES ('a07b66e0-b181-4dcc-b3f7-9e19ca6b6d59', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:51:21', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399967279234', null, '1399967481578');
INSERT INTO `e_log` VALUES ('a0942cee-325c-4650-b99c-ab647aae4694', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:53:40', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399517620812');
INSERT INTO `e_log` VALUES ('a0b23745-e654-4870-9577-5588736f1b88', null, null, '192.168.253.3', '2014-05-13 14:42:50', ':get', '/getImageFile/506413869_1399963350419.png', null, '1399963370031');
INSERT INTO `e_log` VALUES ('a0b2ca9e-f9ad-44b7-8205-497da1e3cbe4', null, '13651083480', '192.168.253.3', '2014-05-13 15:52:10', ':get', '/getSalesByChannel/1/1399967510656', null, '1399967530468');
INSERT INTO `e_log` VALUES ('a0b856c1-94ad-4ef1-a829-c5ff32023901', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:05', ':get', '/getSalesByChannel/0/-1', null, '1399446365015');
INSERT INTO `e_log` VALUES ('a0fa5d1f-9b16-4f2f-9e7e-6d998f88990f', null, null, '118.194.195.3', '2014-05-09 14:03:27', ':get', '/demo/app/barcode.html', null, '1399615407620');
INSERT INTO `e_log` VALUES ('a124ab8c-be29-494e-bfa7-d55cda810b45', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 09:27:08', ':get', '/getSalesByChannel/1/1399944375954', null, '1399944428798');
INSERT INTO `e_log` VALUES ('a128522b-54b1-4948-a4ca-c17c7ac4ef1c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:11:18', ':post', '/sendMessage', '{:sender \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :receiver \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"测试一下\"}', '1399950678001');
INSERT INTO `e_log` VALUES ('a12d13b6-b53b-4943-86fb-ef7ab795dfa6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:03', ':get', '/getSalesByChannel/1/1399539075843', null, '1399595523421');
INSERT INTO `e_log` VALUES ('a131db62-7e62-45bc-a659-c042433831e2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:56:09', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399456569203');
INSERT INTO `e_log` VALUES ('a17ab024-0223-458e-9cf3-e054047f15ca', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:39', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399616499745');
INSERT INTO `e_log` VALUES ('a1a43abd-93d4-443b-8993-147d9ddb580f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:57:13', ':get', '/getShopsByDistance/40.073701/116.242454/2000/0', null, '1399528633968');
INSERT INTO `e_log` VALUES ('a1e5f3cb-a11f-4268-bb5f-e9354bd12f2e', null, '1', '192.168.253.3', '2014-05-08 16:51:15', ':post', '/login', '{:phone \"1\"}', '1399539075250');
INSERT INTO `e_log` VALUES ('a233e388-2fe3-4b55-9620-6f2e47e48da6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:31', ':get', '/demo/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399616791026');
INSERT INTO `e_log` VALUES ('a2341395-afbc-498c-a222-cda4a16e67b9', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:04:18', ':get', '/getSalesByChannel/1/1399536242281', null, '1399536258656');
INSERT INTO `e_log` VALUES ('a2a8cba0-22b7-4a15-887a-bb5c8a84351c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:18:14', ':get', '/demo/getSalesByDistance/4.9E-324/4.9E-324/2000/0', null, '1399616294480');
INSERT INTO `e_log` VALUES ('a2bb5742-6961-42d8-9a8b-0c8ffffd4a5c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:49:35', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D%EF%BC%8C%E6%AC%A2%E8%BF%8E%E3%80%82\", :fileNameList \"\"}', '1399456175968');
INSERT INTO `e_log` VALUES ('a2da363c-88b3-4262-b24a-88ee44208fb3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:52:09', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399963768203', null, '1399963929562');
INSERT INTO `e_log` VALUES ('a30b8f1c-cfe0-4a57-82f5-fb2b7726998b', null, '13651083480', '192.168.253.3', '2014-05-09 11:45:27', ':get', '/getSalesByChannel/1/1399607127421', null, '1399607127859');
INSERT INTO `e_log` VALUES ('a3b79535-2012-4c63-b831-0e4415ff15fe', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:25', ':get', '/demo/getUserGradeItems/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399624345339');
INSERT INTO `e_log` VALUES ('a3c5b2c4-1d68-4a4f-9fb5-923a9e250d39', null, '13651083480', '223.203.193.252', '2014-05-09 16:31:57', ':get', '/demo/getModules/discover', null, '1399624317433');
INSERT INTO `e_log` VALUES ('a3c5f7bc-9e46-4a79-9ae3-bada1f235b56', null, '13651083480', '192.168.253.3', '2014-05-07 15:16:33', ':get', '/getSalesByChannel/1/1399446993109', null, '1399446993390');
INSERT INTO `e_log` VALUES ('a4c887b6-7a21-4e26-832c-7cfc2d0e74ab', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:36', ':get', '/getSalesByChannel/0/1399446554718', null, '1399446576500');
INSERT INTO `e_log` VALUES ('a4f352fd-2a6c-4c2d-8f96-e4341973de70', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:04', ':get', '/demo/getModules/me', null, '1399616464495');
INSERT INTO `e_log` VALUES ('a50dc640-59d9-48ff-84d2-f91ec293c0b2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:16', ':get', '/demo/getSalesByChannel/1/1399624318933', null, '1399624336276');
INSERT INTO `e_log` VALUES ('a5568d57-51aa-4163-baa7-a0cc727c65ca', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:40', ':get', '/getShopShares/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399595675734', null, '1399595680156');
INSERT INTO `e_log` VALUES ('a601a08d-3744-4362-9460-68922f815833', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 09:27:20', ':get', '/getShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399944440470');
INSERT INTO `e_log` VALUES ('a60262b1-8bf1-40c2-811a-30f9a7195f6e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:52', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528372640');
INSERT INTO `e_log` VALUES ('a6217e4c-14da-4768-8084-69d41c5026e0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:10', ':get', '/getSalesByChannel/0/1399453353109', null, '1399453390390');
INSERT INTO `e_log` VALUES ('a628b894-7cdd-470b-826e-0a11ac42f23d', null, '1', '192.168.253.3', '2014-05-13 10:57:29', ':post', '/login', '{:phone \"1\"}', '1399949849720');
INSERT INTO `e_log` VALUES ('a63b8b7b-16b6-4b23-b6b1-f1bda94013e1', null, '13651083480', '118.194.195.3', '2014-05-09 14:20:16', ':get', '/demo/getSalesByChannel/0/-1', null, '1399616416901');
INSERT INTO `e_log` VALUES ('a6638f62-9b2e-4612-9591-a1f610cbb925', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:41:57', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399963317062');
INSERT INTO `e_log` VALUES ('a681ce9e-591e-467b-9bc6-e9beb0983074', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:13', ':get', '/getSalesByChannel/0/-1', null, '1399530793281');
INSERT INTO `e_log` VALUES ('a6875a7f-811e-4b50-8c2d-cf1a219e6752', null, '13651083480', '192.168.253.3', '2014-05-08 14:39:29', ':post', '/login', '{:phone \"13651083480\"}', '1399531169000');
INSERT INTO `e_log` VALUES ('a6ea8024-d4cb-4068-a9e7-6b3830388a1a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:22:08', ':get', '/getTrades', null, '1399512128156');
INSERT INTO `e_log` VALUES ('a7073d85-518e-44e4-9a1f-f97c258fc5cc', null, '13651083480', '192.168.253.3', '2014-05-13 14:41:31', ':get', '/getSalesByChannel/1/1399961542343', null, '1399963291515');
INSERT INTO `e_log` VALUES ('a714878a-2e2f-4165-b1f5-fdcad11754b6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 12:01:40', ':get', '/getSalesByChannel/1/1399953696235', null, '1399953700329');
INSERT INTO `e_log` VALUES ('a71aef3a-56d5-46f9-8239-62fc0a5de451', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:49:27', ':get', '/getSalesByChannel/1/1399538924421', null, '1399538967296');
INSERT INTO `e_log` VALUES ('a73db566-8698-47ce-85c9-f33a962760b9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:14:26', ':get', '/getSalesByChannel/1/1399965212609', null, '1399965266671');
INSERT INTO `e_log` VALUES ('a773d0f5-f412-476d-aa2f-552c108c04c2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:45:45', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607145750');
INSERT INTO `e_log` VALUES ('a7ae4130-9309-4959-af64-a637db0c3c9a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:48:33', ':get', '/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399970913656');
INSERT INTO `e_log` VALUES ('a7dd4243-6662-40d8-b909-8303e13ea10e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:02', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399595642531');
INSERT INTO `e_log` VALUES ('a7e52ffb-6410-4a48-b163-75e65873c085', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:17:59', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399616156495', null, '1399616279620');
INSERT INTO `e_log` VALUES ('a803924a-0c65-4e89-b0cb-4e221ef411d3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:28:16', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606096265');
INSERT INTO `e_log` VALUES ('a8186cd7-924d-437a-90cb-0d21c7a4ca88', null, null, '192.168.253.1', '2014-05-16 14:49:28', ':get', '/index.html', null, '1400222968062');
INSERT INTO `e_log` VALUES ('a8dc5357-7629-47c2-bc26-d58fe08d2560', null, '13651083480', '192.168.253.3', '2014-05-13 16:49:03', ':post', '/login', '{:phone \"13651083480\"}', '1399970943859');
INSERT INTO `e_log` VALUES ('a8ea01fa-5bf2-4401-b709-102ba9839d9f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:51:58', ':post', '/registerShop', '{\"1259860143_1399452716068.png\" {:size 68674, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3820336725498127850.tmp>, :content-type \"image/pjpeg\", :filename \"1259860143_1399452716068.png\"}, :desc \"%E6%AC%A2%E8%BF%8E%E5%85%89%E4%B8%B4\", :shop_img \"1259860143_1399452716068.png\", :name \"%E4%B8%BD%E4%BD%B3%E5%AE%9D%E8%B4%9D%E6%B0%B8%E6%97%BA%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22radius%22%3A38.766666412353516%2C%22longitude%22%3A116.242444%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"1259860143_1399452716068.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"40%7C3\"}', '1399452718562');
INSERT INTO `e_log` VALUES ('a8ea5190-c836-4de6-a702-9a54c082bfc8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:02:56', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399971776453');
INSERT INTO `e_log` VALUES ('a90b4729-fcbb-47dc-8de1-cea6582b7e97', null, null, '192.168.253.3', '2014-05-08 09:08:49', ':get', '/getImageFile/940407648_1399511322875.png', null, '1399511329640');
INSERT INTO `e_log` VALUES ('a919d6d8-61e4-4aab-a19c-5864ad5bc5e2', null, '1', '192.168.253.3', '2014-05-09 11:22:56', ':post', '/login', '{:phone \"1\"}', '1399605776375');
INSERT INTO `e_log` VALUES ('a9532289-8a13-4742-bc78-2f824dfec01b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:28:32', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399517593359', null, '1399519712515');
INSERT INTO `e_log` VALUES ('a96b5abb-7abc-4b09-928b-85b71724aefc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:27:22', ':get', '/demo/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399616842948');
INSERT INTO `e_log` VALUES ('a9d01922-85f0-47f5-8b46-17686f48e4e7', null, '13651083480', '192.168.253.3', '2014-05-07 16:57:51', ':post', '/login', '{:phone \"13651083480\"}', '1399453071031');
INSERT INTO `e_log` VALUES ('a9e32dc6-28ef-4501-bc73-bb870cd28e19', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:13:32', ':get', '/getSalesByChannel/1/1399965197109', null, '1399965212578');
INSERT INTO `e_log` VALUES ('aa036ac8-593a-4a2e-bc8a-d7bf6f770283', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:58:37', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399971517828');
INSERT INTO `e_log` VALUES ('aa69f165-95f5-4623-91de-0854cfd11c8e', null, '1', '192.168.253.3', '2014-05-09 11:35:21', ':post', '/login', '{:phone \"1\"}', '1399606521468');
INSERT INTO `e_log` VALUES ('aa7e22b0-eeb9-412f-93ec-ada7e850215f', null, '13651083480', '192.168.253.3', '2014-05-07 16:10:32', ':post', '/login', '{:phone \"13651083480\"}', '1399450232000');
INSERT INTO `e_log` VALUES ('aa86f10c-a5a7-42a8-82de-39d05dd9d601', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:45:34', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517134343');
INSERT INTO `e_log` VALUES ('aacb7ae9-6050-4470-ac0f-feb36782f00a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:49:20', ':get', '/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399970960343');
INSERT INTO `e_log` VALUES ('aae5c444-6a2b-45da-af19-7e751fd1335a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:44', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521464687');
INSERT INTO `e_log` VALUES ('ab321719-2ea1-4c71-a481-df1961e9d665', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:19', ':get', '/getSalesByChannel/1/1399450999187', null, '1399450999687');
INSERT INTO `e_log` VALUES ('aba66e4d-d0a7-44d2-83b8-4e470fc76b24', null, '13651083480', '192.168.253.3', '2014-05-07 17:05:18', ':post', '/login', '{:phone \"13651083480\"}', '1399453518125');
INSERT INTO `e_log` VALUES ('abb09b02-5edf-4a71-9775-f3ae44639996', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:11:37', ':get', '/demo/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399615897245');
INSERT INTO `e_log` VALUES ('abe8ada8-bea6-4713-8734-5e5e75d4e04e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:58', ':get', '/getSalesByChannel/0/1399448710437', null, '1399448758468');
INSERT INTO `e_log` VALUES ('ac0f0cc1-5818-40a5-9582-1bea891abce6', null, '1', '192.168.253.3', '2014-05-08 16:12:52', ':post', '/login', '{:phone \"1\"}', '1399536772609');
INSERT INTO `e_log` VALUES ('ac127493-b8c0-4613-93d3-3b1459bbd7a6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:25:34', ':get', '/demo/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616734120');
INSERT INTO `e_log` VALUES ('ac5b1e2e-c25c-44e9-a1a7-71777062615e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:43:55', ':post', '/saveShareReply', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :share_id \"9fbebd30-1271-433e-8067-8099384ca9f6\", :grade \"8\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"谢谢惠顾。\"}', '1399963435765');
INSERT INTO `e_log` VALUES ('aca782a8-916d-426f-a817-57a45e6b82c2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:40:58', ':get', '/getSalesByChannel/1/1399970434328', null, '1399970458296');
INSERT INTO `e_log` VALUES ('acc36254-abd9-40e0-8deb-5752c00c11d6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:41', ':get', '/getTrades', null, '1399530821187');
INSERT INTO `e_log` VALUES ('accdfda3-da24-4440-8943-d9b62abd24c8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:25:10', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399969510375');
INSERT INTO `e_log` VALUES ('ad0a45eb-7b03-4a06-b677-60308f604cf0', null, null, '192.168.253.3', '2014-05-07 17:01:25', ':get', '/getImageFile/50489896_1399453226535.png', null, '1399453285000');
INSERT INTO `e_log` VALUES ('ad3a14ce-56e2-41f2-8068-f62c87eddba1', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:45', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399516785187');
INSERT INTO `e_log` VALUES ('ad44208e-f4a3-4823-b51d-f10baa9bad69', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:59:07', ':get', '/getSalesByChannel/1/1399967934750', null, '1399967947343');
INSERT INTO `e_log` VALUES ('ad4672f8-5c93-49d8-800a-e7b5607cf4bf', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:11', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399595651718');
INSERT INTO `e_log` VALUES ('ad64a030-86a6-4697-be24-ca5f3abe3488', null, '13651083480', '118.194.195.3', '2014-05-09 14:21:29', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399616489058');
INSERT INTO `e_log` VALUES ('ad6d6691-fb32-4e2a-a434-be9743c81815', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:34', ':post', '/loginShop', '{:user_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\"}', '1399595554265');
INSERT INTO `e_log` VALUES ('adb2c266-33cb-4448-8db5-2f6bdf002b17', null, null, '192.168.253.3', '2014-05-08 09:44:25', ':get', '/getImageFile/barcode_-509784425_1399513463015.png', null, '1399513465078');
INSERT INTO `e_log` VALUES ('adbacce5-e4ea-478a-93be-c0faa16ba672', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:57:11', ':get', '/getSalesByDistance/40.073701/116.242454/2000/0', null, '1399528631890');
INSERT INTO `e_log` VALUES ('adeef12a-8bc3-4db2-8707-00c7b6844806', null, '13651083480', '192.168.253.3', '2014-05-13 14:49:53', ':get', '/getSalesByChannel/1/1399963761953', null, '1399963793781');
INSERT INTO `e_log` VALUES ('ae209395-1ba9-4d68-b0a4-fdad68785409', null, '13651083480', '192.168.253.3', '2014-05-08 16:04:16', ':post', '/login', '{:phone \"1\"}', '1399536256531');
INSERT INTO `e_log` VALUES ('ae2d09f2-c7c0-4f91-b838-b31ebbbfd957', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:35:21', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606521843');
INSERT INTO `e_log` VALUES ('aee32575-8120-46bc-84f7-28989b0968d2', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 12:02:28', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399953748376');
INSERT INTO `e_log` VALUES ('af3b75d4-e42c-4ca7-8e35-6984c9abeca7', null, '1', '192.168.253.3', '2014-05-08 16:20:55', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399537255593');
INSERT INTO `e_log` VALUES ('af581992-a79b-4360-b6a7-1140e9cddc9a', null, null, '192.168.253.2', '2014-05-13 13:33:46', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399959226187');
INSERT INTO `e_log` VALUES ('afc7dc21-bee1-405d-b57e-86fa9e3faaf4', null, null, '192.168.253.3', '2014-05-08 09:57:04', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399514224234');
INSERT INTO `e_log` VALUES ('afdeb7d9-442a-4b3b-94f8-893925ff6a0a', null, '13651083480', '192.168.253.3', '2014-05-08 11:45:45', ':post', '/login', '{:phone \"13651083480\"}', '1399520745000');
INSERT INTO `e_log` VALUES ('b1daacd8-4362-4094-9bc7-03c52ad9817c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:52:30', ':get', '/getSalesByChannel/1/1399963936843', null, '1399963950875');
INSERT INTO `e_log` VALUES ('b1fc188d-e03f-4331-b860-599a9ebbb67d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:30', ':get', '/getSalesByChannel/3/1399521448343', null, '1399521450468');
INSERT INTO `e_log` VALUES ('b205f301-e836-4499-a59d-db617de7c411', null, '13651083480', '192.168.253.3', '2014-05-13 16:46:16', ':post', '/login', '{:phone \"13651083480\"}', '1399970776734');
INSERT INTO `e_log` VALUES ('b21bdd36-1cf3-47df-8e78-dbaecd8e16ab', null, null, '118.194.195.3', '2014-05-09 14:06:02', ':get', '/demo/app/download.html', null, '1399615562011');
INSERT INTO `e_log` VALUES ('b21ce2cc-c087-4b46-8598-9c3b4293fe42', null, null, '118.194.195.3', '2014-05-09 14:09:59', ':get', '/demo/getImageFile/50489896_1399453226535.png', null, '1399615799245');
INSERT INTO `e_log` VALUES ('b23e3821-ff89-4feb-ae2b-d58297d8449c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:48', ':get', '/getModules/discover', null, '1399448688203');
INSERT INTO `e_log` VALUES ('b28c6937-65ed-4078-aae4-93b6e3ec79c9', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:16', ':get', '/getModules/me', null, '1399446376812');
INSERT INTO `e_log` VALUES ('b29ae889-64f7-4321-8336-72c3af7584d6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:18:23', ':get', '/demo/getSalesByDistance/4.9E-324/4.9E-324/2000/0', null, '1399616303730');
INSERT INTO `e_log` VALUES ('b2a6e309-48d7-4b45-8b23-dfdbc27be04d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:45', ':get', '/demo/getSalesByChannel/40/1399624363464', null, '1399624365370');
INSERT INTO `e_log` VALUES ('b2b4f16f-3305-45d7-9206-b07d82b3f941', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:12', ':get', '/demo/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399616772480');
INSERT INTO `e_log` VALUES ('b2f4d33b-5e4e-4d53-ba8f-90a2e2ba1bd2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:32:17', ':get', '/getSalesByChannel/1/1399969684984', null, '1399969937421');
INSERT INTO `e_log` VALUES ('b38c66a6-c8e7-4ac5-9f8f-999399494e86', null, null, '192.168.253.1', '2014-05-16 14:48:58', ':get', '/index.html', null, '1400222938218');
INSERT INTO `e_log` VALUES ('b38c91bd-39f7-4970-be87-8dc811ffffd0', null, '13651083480', '118.194.195.3', '2014-05-09 14:06:32', ':get', '/demo/getChannels', null, '1399615592605');
INSERT INTO `e_log` VALUES ('b3ed6f9f-3e5e-40ec-aa93-19a940b5404d', null, '13651083480', '192.168.253.3', '2014-05-13 09:26:15', ':get', '/getSalesByChannel/1/1399944368860', null, '1399944375876');
INSERT INTO `e_log` VALUES ('b41cf8fe-e6e5-424d-901b-94f5b4434aa6', null, '13651083480', '118.194.195.3', '2014-05-09 14:33:57', ':get', '/demo/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399521367765', null, '1399617237605');
INSERT INTO `e_log` VALUES ('b4badc37-ba81-4acf-b5d9-eb861e6ae286', null, null, '192.168.253.3', '2014-05-08 09:52:57', ':get', '/getImageFile/-810116522_1399513964667.png', null, '1399513977656');
INSERT INTO `e_log` VALUES ('b5171037-e0a8-45bd-a5d2-6db12d5174a3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:51:41', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528301968');
INSERT INTO `e_log` VALUES ('b5a749a2-0af2-4f28-9dfc-8e7d98fbe7ec', null, '1', '192.168.253.3', '2014-05-09 08:32:03', ':post', '/login', '{:phone \"1\"}', '1399595523031');
INSERT INTO `e_log` VALUES ('b5b8ba6f-85c6-4cf7-9e78-4f5e005f065d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:19', ':get', '/getSalesByChannel/0/1399450954234', null, '1399450999109');
INSERT INTO `e_log` VALUES ('b6007b9f-d2e6-4d10-b4af-5cbb921a678f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:36', ':get', '/getSalesByChannel/1/1399446576531', null, '1399446576937');
INSERT INTO `e_log` VALUES ('b6137f4d-a73d-4338-b613-05fc4fae150d', null, null, '192.168.253.1', '2014-05-07 16:29:22', ':get', '/aa', null, '1399451362000');
INSERT INTO `e_log` VALUES ('b61b2edd-2dee-45c6-8aac-c81a14885b97', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870015');
INSERT INTO `e_log` VALUES ('b63bcd6a-f184-41c0-a350-7be9c87d47ef', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:46:17', ':get', '/getSalesByChannel/1/1399970682093', null, '1399970777046');
INSERT INTO `e_log` VALUES ('b663d860-bb64-4a50-a6f9-8f1614aae583', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:44:45', ':get', '/getSalesByChannel/1/1399967045812', null, '1399967085437');
INSERT INTO `e_log` VALUES ('b6d8f676-0642-45a7-8d07-e8ae24f9fb54', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:27:26', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616846855');
INSERT INTO `e_log` VALUES ('b729494e-bc07-42a8-8ffe-7906a54a7f5f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 13:38:07', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399959487203');
INSERT INTO `e_log` VALUES ('b73a774e-b338-44c4-b3eb-8e8284994dd1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:33:39', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399530819515');
INSERT INTO `e_log` VALUES ('b73a7c1d-f128-4cd0-907e-7172c22a1449', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125796');
INSERT INTO `e_log` VALUES ('b79ae4fa-f3c9-436b-b3c1-6ffaa86a4fbb', null, '13651083480', '223.203.193.252', '2014-05-09 16:31:49', ':get', '/demo/getSalesByChannel/1/1399624309417', null, '1399624309714');
INSERT INTO `e_log` VALUES ('b7ef26ec-1ca9-4ad3-ad85-2ae8f7e2cba2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:48:05', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399452485484');
INSERT INTO `e_log` VALUES ('b80ce76b-5585-4e05-9e38-5d21d224d84c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:59:54', ':post', '/saveComment', '{:publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :content \"有积分不错\"}', '1399517994390');
INSERT INTO `e_log` VALUES ('b8148444-d2f7-4b27-9824-8838c045cea3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:36:21', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606581687');
INSERT INTO `e_log` VALUES ('b82cc1ed-81a7-424c-ada9-8b9a93ae86c5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:13', ':get', '/getSalesByChannel/2/1399595527906', null, '1399595533984');
INSERT INTO `e_log` VALUES ('b8856968-ec98-4393-914c-f4dc1ad60ab9', null, '13651083480', '192.168.253.3', '2014-05-08 14:40:36', ':post', '/login', '{:phone \"13651083480\"}', '1399531236156');
INSERT INTO `e_log` VALUES ('b8b4f5f5-a15a-4c25-b07c-6a31010fd899', null, '13651083480', '192.168.253.3', '2014-05-08 09:27:52', ':get', '/getSalesByChannel/0/-1', null, '1399512472515');
INSERT INTO `e_log` VALUES ('b8c26da0-ceba-41a1-97da-f2265b5a1fcd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:38:06', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531086609');
INSERT INTO `e_log` VALUES ('b906252d-0582-48f2-8647-b05ec1a0f56d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:52:28', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399966806453', null, '1399967548703');
INSERT INTO `e_log` VALUES ('b917329d-dcad-4116-b8ea-42400bfc77a4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:44:33', ':get', '/demo/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399521367765', null, '1399617873730');
INSERT INTO `e_log` VALUES ('b91ef9dc-ee8a-4d2f-9bdc-374a6843262c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:27:06', ':get', '/getUserGradeItems/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606026468');
INSERT INTO `e_log` VALUES ('b922d3ab-660e-4c01-949c-451e185a65ea', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:18', ':get', '/getSalesByChannel/1/1399595534031', null, '1399595538390');
INSERT INTO `e_log` VALUES ('b9480b9a-30a3-43dc-85c4-5880722a6205', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:07', ':post', '/searchShops', '{:search-word \"上地\"}', '1399452907718');
INSERT INTO `e_log` VALUES ('b95b9dd9-7920-4a1e-a0f5-8c14f8317e91', null, '13651083480', '192.168.253.3', '2014-05-08 10:52:37', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517557062');
INSERT INTO `e_log` VALUES ('b96ac5ac-3022-4526-b417-a817b26b1aff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:45:11', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"address\", :value \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :fileNameList \"\"}', '1399513511343');
INSERT INTO `e_log` VALUES ('b96ee15e-0f13-493a-8a2a-1ee906858cec', null, '13651083480', '118.194.195.3', '2014-05-09 14:59:11', ':post', '/demo/login', '{:phone \"1\"}', '1399618751745');
INSERT INTO `e_log` VALUES ('bac99bef-4397-4d44-ba96-57ede1eb8bd8', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:46:32', ':get', '/getShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399607192109');
INSERT INTO `e_log` VALUES ('bb0130d6-80a4-4d2f-9db7-08b026ef2dcf', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:10:48', ':get', '/demo/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399615848745');
INSERT INTO `e_log` VALUES ('bb959455-f2bf-4020-a7e8-619c952d21a1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:39:28', ':get', '/getSalesByChannel/1/1399966759578', null, '1399966768515');
INSERT INTO `e_log` VALUES ('bc4789a1-79d2-4af3-b23c-ebb5cf3b1014', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:01:23', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399514483468');
INSERT INTO `e_log` VALUES ('bc9e9a7c-de5c-4953-a59b-d4564baf4c61', null, '13651083480', '192.168.253.3', '2014-05-13 16:44:41', ':post', '/login', '{:phone \"13651083480\"}', '1399970681734');
INSERT INTO `e_log` VALUES ('bcc6c7b7-e9e4-42d7-90af-e56843ef7fd5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:10:05', ':get', '/demo/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399615805839');
INSERT INTO `e_log` VALUES ('bcd387fb-dca4-4334-bdcb-8074c288c941', null, '13651083480', '192.168.253.3', '2014-05-13 15:40:18', ':get', '/getSalesByChannel/1/1399966784437', null, '1399966818750');
INSERT INTO `e_log` VALUES ('bcfed06f-d57e-4069-a85c-5851738ab3bd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:59', ':get', '/demo/getSalesByChannel/1/1399616735433', null, '1399616819605');
INSERT INTO `e_log` VALUES ('bd102a8d-9f5d-407e-be71-ebc1010babe6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:57:10', ':get', '/getSalesByChannel/1/1399967784156', null, '1399967830687');
INSERT INTO `e_log` VALUES ('bd190f18-e88f-48fe-a13c-2293891965fb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:32:27', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399969947687');
INSERT INTO `e_log` VALUES ('bd543b61-a1a9-40d7-b87e-e312442cf521', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 10:09:03', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399946943017');
INSERT INTO `e_log` VALUES ('bd7b9ba9-57ca-4381-ae95-fef7724461d1', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:30:39', ':get', '/getSalesByChannel/1/1399951508814', null, '1399951839642');
INSERT INTO `e_log` VALUES ('bd817462-023c-4dea-b99e-9ca42b9047ee', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:33:13', ':get', '/demo/getSalesByChannel/42/1399624393448', null, '1399624393761');
INSERT INTO `e_log` VALUES ('bd9fbd86-5148-4504-a485-a6a591a4024f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:46:20', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"i妞妞\"}', '1399448780109');
INSERT INTO `e_log` VALUES ('bdacec5d-310e-4668-a044-a103a6143a51', null, '13651083480', '192.168.253.3', '2014-05-08 09:09:49', ':post', '/login', '{:phone \"13651083480\"}', '1399511389984');
INSERT INTO `e_log` VALUES ('bdbfe4fb-5d87-477e-b15f-c4609474681f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:25:47', ':get', '/demo/getTrades', null, '1399616747417');
INSERT INTO `e_log` VALUES ('be6cbb7d-3052-4582-88c5-889105d3cabb', null, '13651083480', '192.168.253.3', '2014-05-13 17:00:28', ':post', '/login', '{:phone \"13651083480\"}', '1399971628312');
INSERT INTO `e_log` VALUES ('be8058b2-98fd-41d1-9af9-55f2ec876fe6', null, null, '192.168.253.3', '2014-05-08 16:51:21', ':get', '/pub/grade_shop.html', null, '1399539081484');
INSERT INTO `e_log` VALUES ('bea78c3d-b820-415d-b8c1-fb5954d90ec7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:12:22', ':get', '/getSalesByChannel/1/1399961527640', null, '1399961542296');
INSERT INTO `e_log` VALUES ('beb921c0-456f-4c90-8cca-47b0f1ac1065', null, '13651083480', '192.168.253.3', '2014-05-08 10:11:11', ':post', '/login', '{:phone \"13651083480\"}', '1399515071765');
INSERT INTO `e_log` VALUES ('bf03a998-7566-48bf-b76e-b66ef4e006bc', null, null, '192.168.253.1', '2014-05-07 16:34:59', ':get', '/aa', null, '1399451699296');
INSERT INTO `e_log` VALUES ('bf1ca3f6-5ffa-40bb-97b2-c4ffc49db7f1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:08:12', ':post', '/updateShop', '{:value \"-810116522_1399514888415.png\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"shop_img\", :fileNameList \"-810116522_1399514888415.png\", \"-810116522_1399514888415.png\" {:size 111143, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7395602937005622125.tmp>, :content-type \"image/pjpeg\", :filename \"-810116522_1399514888415.png\"}}', '1399514892625');
INSERT INTO `e_log` VALUES ('bfb3083f-2652-4592-b277-03b249710c05', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:27:06', ':get', '/demo/getSaleDiscusses/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/1399616482245', null, '1399616826511');
INSERT INTO `e_log` VALUES ('bfbca298-67d4-4032-85ac-0c99065ca904', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:16:28', ':get', '/demo/getUserGradeItems/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616188651');
INSERT INTO `e_log` VALUES ('bfc1dc4a-f23d-4fa7-aaa3-2aac23c42422', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:45:46', ':get', '/getSalesByChannel/1/1399607127906', null, '1399607146875');
INSERT INTO `e_log` VALUES ('c0013f81-9e1b-4b00-a602-e26e12544968', null, '13651083480', '192.168.253.3', '2014-05-13 15:27:25', ':post', '/login', '{:phone \"13651083480\"}', '1399966045187');
INSERT INTO `e_log` VALUES ('c0412e06-c5e5-41c1-bfe8-80d92f812982', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:44:50', ':get', '/getSaleFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517090718');
INSERT INTO `e_log` VALUES ('c07e4cca-963b-46e0-a6f4-391ebe3abb17', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:24:57', ':get', '/getSalesByChannel/1/1399968698562', null, '1399969497625');
INSERT INTO `e_log` VALUES ('c0862c85-45e2-41a0-99ef-185922d8b7c4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:31:14', ':get', '/getSaleFavoritesByUser/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399519874703');
INSERT INTO `e_log` VALUES ('c098c939-5474-44b5-a6e3-10d4b7cd4846', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 13:19:35', ':get', '/getSalesByChannel/1/1399953712642', null, '1399958375140');
INSERT INTO `e_log` VALUES ('c0ac9dc1-d4d7-4620-9bd7-6ca877248a68', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:15:44', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399616136855', null, '1399616144448');
INSERT INTO `e_log` VALUES ('c0f6d232-23b6-4186-93f2-9af9d6943f8f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:47:48', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528068468');
INSERT INTO `e_log` VALUES ('c0fdc7e4-fb47-49ec-a8b5-b645a72788ed', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:39', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528359703');
INSERT INTO `e_log` VALUES ('c119c158-0133-4324-92f5-82d79920637f', null, '13651083480', '192.168.253.3', '2014-05-13 15:54:40', ':get', '/getSalesByChannel/1/1399967572890', null, '1399967680546');
INSERT INTO `e_log` VALUES ('c148218b-b2c0-4cce-b0a9-ba29f81a6364', null, null, '118.194.195.3', '2014-05-09 14:06:02', ':get', '/demo/app/YouGouHui.apk', null, '1399615562573');
INSERT INTO `e_log` VALUES ('c164da69-79bf-4eb6-9caf-1227ed6afc01', null, null, '118.194.195.3', '2014-05-09 14:09:15', ':get', '/demo/getImageFile/602324364_1399449344230.png', null, '1399615755667');
INSERT INTO `e_log` VALUES ('c168cce1-7bed-4d78-8811-fb91b1283610', null, null, '192.168.253.3', '2014-05-08 09:13:28', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399511608734');
INSERT INTO `e_log` VALUES ('c23d8725-e613-41d6-b49a-7c9b9fdd57e8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:22:03', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399512123531');
INSERT INTO `e_log` VALUES ('c25de38c-761d-4767-bbb9-ac90606d148d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:35:52', ':get', '/getSalesByChannel/1/1399969937562', null, '1399970152468');
INSERT INTO `e_log` VALUES ('c29dad1b-fac5-4e4d-8f0a-6d51f845360b', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:51', ':post', '/login', '{:phone \"13651083480\"}', '1399533951468');
INSERT INTO `e_log` VALUES ('c2cbb793-3d0b-4948-94d7-fad1381cc0d6', null, '13651083480', '223.203.193.252', '2014-05-09 16:31:52', ':get', '/demo/getModules/me', null, '1399624312308');
INSERT INTO `e_log` VALUES ('c31ba712-c224-4c56-87d5-cfbd845330cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:23', ':get', '/demo/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399624343526');
INSERT INTO `e_log` VALUES ('c33ed1de-ee89-4c29-93a6-851af221625f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 09:30:08', ':get', '/getSalesByChannel/1/1399944591907', null, '1399944608251');
INSERT INTO `e_log` VALUES ('c375245a-8deb-4698-956e-29487a656800', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:57:23', ':get', '/getSalesByChannel/0/1399521407062', null, '1399521443125');
INSERT INTO `e_log` VALUES ('c3992d28-c546-416e-b51d-d8867cec12cd', null, '13651083480', '192.168.253.3', '2014-05-08 11:51:01', ':post', '/login', '{:phone \"13651083480\"}', '1399521061203');
INSERT INTO `e_log` VALUES ('c3d91424-ba69-467d-b746-209055dafd1e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 13:35:12', ':get', '/getSalesByChannel/1/1399959297656', null, '1399959312031');
INSERT INTO `e_log` VALUES ('c3e03de0-da6a-4cbb-9a48-7285f3508a09', null, '13651083480', '192.168.253.3', '2014-05-08 09:40:14', ':post', '/login', '{:phone \"13651083480\"}', '1399513214687');
INSERT INTO `e_log` VALUES ('c3f87f1a-0b13-448c-971e-544ea0d69a8c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:44:53', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399970693812');
INSERT INTO `e_log` VALUES ('c4020eec-f75b-462c-ac64-26d3d4727715', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:56:25', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521385000');
INSERT INTO `e_log` VALUES ('c418040f-075a-482a-8829-5d862bf2d687', null, '13651083480', '118.194.195.3', '2014-05-09 14:33:21', ':get', '/demo/getSalesByChannel/1/1399617200370', null, '1399617201480');
INSERT INTO `e_log` VALUES ('c444b2b9-9d4e-4246-9a6e-604a52c6751d', null, '13651083480', '192.168.253.3', '2014-05-13 15:57:10', ':post', '/login', '{:phone \"13651083480\"}', '1399967830390');
INSERT INTO `e_log` VALUES ('c48ad146-0efc-4eaa-a09e-a67dc8da7aee', null, '1', '192.168.253.3', '2014-05-09 11:22:22', ':post', '/login', '{:phone \"1\"}', '1399605742265');
INSERT INTO `e_log` VALUES ('c4b21398-2c7e-4bad-ab2a-74cda006a939', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:03:12', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971792250');
INSERT INTO `e_log` VALUES ('c55c6a91-98d6-401a-bdb5-ab05eca738c6', null, '13651083480', '192.168.253.3', '2014-05-08 09:27:52', ':get', '/getSalesByChannel/1/1399512472562', null, '1399512472875');
INSERT INTO `e_log` VALUES ('c5a42aa5-565e-4e33-ae8f-a02939c64ebd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:09:59', ':get', '/demo/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399615799073');
INSERT INTO `e_log` VALUES ('c60dfe99-c838-4d42-b6a5-0f1be914230c', null, null, '192.168.253.3', '2014-05-08 16:52:01', ':get', '/pub/grade_shop.html', null, '1399539121390');
INSERT INTO `e_log` VALUES ('c64b833d-a94f-4240-a1f7-c3265ed9722c', null, '13651083480', '118.194.195.3', '2014-05-09 14:25:12', ':get', '/demo/getSalesByChannel/1/1399616470480', null, '1399616712370');
INSERT INTO `e_log` VALUES ('c64f7f7e-3a5b-400f-86ea-51a186be24c2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:28:14', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399969694453');
INSERT INTO `e_log` VALUES ('c6d4fe2f-ee70-4796-89e9-23bd258a993b', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:51:50', ':get', '/getSalesByChannel/1/1399967477781', null, '1399967510593');
INSERT INTO `e_log` VALUES ('c6d7549a-482e-4bf4-8f5e-1dc9993c3e76', null, '1', '192.168.253.3', '2014-05-13 14:50:09', ':post', '/login', '{:phone \"1\"}', '1399963809687');
INSERT INTO `e_log` VALUES ('c6daf605-9845-4c41-b50f-3305ec8f67ae', null, null, '118.194.195.3', '2014-05-09 14:07:37', ':get', '/demo/getImageFile/898289355_1399515888683.png', null, '1399615657058');
INSERT INTO `e_log` VALUES ('c7251ae2-87a3-4421-b518-52c6fee101e6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:21:54', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399512114515');
INSERT INTO `e_log` VALUES ('c7a306c2-702e-4ad4-ab6f-e19d0fd57cda', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 17:04:58', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399516358796', null, '1399971898000');
INSERT INTO `e_log` VALUES ('c7c06e86-039e-4068-bb64-0a6a8749fef9', null, '1', '192.168.253.3', '2014-05-13 11:59:52', ':post', '/login', '{:phone \"1\"}', '1399953592970');
INSERT INTO `e_log` VALUES ('c932bdf4-9c60-40eb-b5b0-0e4028cd9f5a', null, '13651083480', '192.168.253.3', '2014-05-08 09:54:13', ':post', '/updateShop', '{:field \"shop_img\", :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :value \"-810116522_1399514042943.png\"}', '1399514053812');
INSERT INTO `e_log` VALUES ('c968c1e9-a146-48b9-a2c4-816880a0d7f0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 13:36:55', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399959415343');
INSERT INTO `e_log` VALUES ('c98cafee-fee7-4719-9ed7-58522183602b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:12:27', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399959841125', null, '1399961547046');
INSERT INTO `e_log` VALUES ('c9c33a93-9054-44a8-a972-dbb4d30475d7', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:39', ':get', '/getSalesByChannel/0/-1', null, '1399533939250');
INSERT INTO `e_log` VALUES ('c9e10567-0f76-4c82-9684-c136e2449b21', null, '1', '192.168.253.3', '2014-05-08 10:37:14', ':post', '/login', '{:phone \"1\"}', '1399516634453');
INSERT INTO `e_log` VALUES ('cae7c99e-1b69-4e75-a34c-641300255d27', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:25:53', ':get', '/getSalesByChannel/1/1399533939828', null, '1399533953234');
INSERT INTO `e_log` VALUES ('cb8e4416-7674-4630-bd05-189687e70b64', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:41:53', ':get', '/getSalesByChannel/1/1399963291578', null, '1399963313796');
INSERT INTO `e_log` VALUES ('cbe06073-4e22-4ecd-ae65-9e2f5d6924b3', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 17:04:48', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399971888312');
INSERT INTO `e_log` VALUES ('cc9df993-53e4-4620-8bed-64980930ef6c', null, null, '118.194.195.3', '2014-05-09 14:09:48', ':get', '/demo/getImageFile/1321682725_1399516655545.png', null, '1399615788651');
INSERT INTO `e_log` VALUES ('cde49078-e3eb-4c95-ba97-b881fc7b5984', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:51:34', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399528294890');
INSERT INTO `e_log` VALUES ('cdeec924-0d60-4d66-8675-55625f0ffc32', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:11:30', ':get', '/getSalesByChannel/1/1399968246203', null, '1399968690343');
INSERT INTO `e_log` VALUES ('ce28fda3-c9a8-4941-906b-2582f714976b', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:55:48', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399517748609');
INSERT INTO `e_log` VALUES ('ce60b445-49d5-41a0-992a-d9a6275c8acf', null, '13651083480', '192.168.253.3', '2014-05-07 17:55:45', ':post', '/login', '{:phone \"13651083480\"}', '1399456545468');
INSERT INTO `e_log` VALUES ('ce6c0389-7fea-4cd1-ac38-2b1e2a4e94fe', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:06', ':get', '/getSalesByChannel/0/1399450274265', null, '1399450446640');
INSERT INTO `e_log` VALUES ('ce9bc156-adb7-4bba-a39b-5fafdb5496f9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:47', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450967562');
INSERT INTO `e_log` VALUES ('ceb07556-d0f1-40e9-b72b-a1234f9819bd', null, '13651083480', '192.168.253.3', '2014-05-13 16:40:28', ':get', '/getModules/discover', null, '1399970428187');
INSERT INTO `e_log` VALUES ('cf0902b5-8fc5-4d59-87ac-f82e2ce14a9a', null, '13651083480', '192.168.253.3', '2014-05-08 09:59:04', ':post', '/login', '{:phone \"13651083480\"}', '1399514344765');
INSERT INTO `e_log` VALUES ('d00488c9-2208-4cce-b9fb-113eee52b3ff', null, null, '192.168.253.3', '2014-05-07 16:54:29', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452869968');
INSERT INTO `e_log` VALUES ('d0160566-3eb6-4219-930a-7d4b6f30d98a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:50:10', ':get', '/getSalesByChannel/1/1399963793843', null, '1399963810046');
INSERT INTO `e_log` VALUES ('d033a389-0918-4099-a5f0-6cf5c12d3a6e', null, '13651083480', '192.168.253.3', '2014-05-13 15:56:24', ':get', '/getSalesByChannel/1/1399967771296', null, '1399967784078');
INSERT INTO `e_log` VALUES ('d071ac0d-0966-4090-ba08-7f7d3eeeb6a4', null, '13651083480', '118.194.195.3', '2014-05-09 14:08:57', ':post', '/demo/login', '{:phone \"13651083480\"}', '1399615737995');
INSERT INTO `e_log` VALUES ('d078860d-753c-4730-bc43-df23b0bfa668', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125921');
INSERT INTO `e_log` VALUES ('d087fa21-977f-4cbd-8eca-47c8fbd8aedd', null, null, '192.168.253.3', '2014-05-07 15:07:42', ':get', '/getImageFile//storage/emulated/0/bluetooth/1.jpeg', null, '1399446462234');
INSERT INTO `e_log` VALUES ('d088ff6b-2662-4866-b9c3-903d9ab3e790', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:35', ':get', '/getShopShares/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399452076125', null, '1399595675687');
INSERT INTO `e_log` VALUES ('d093c6b6-2e95-4e0b-b005-12b9d181e688', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:10:49', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399950649564');
INSERT INTO `e_log` VALUES ('d11962ba-2c73-4399-b36b-644272a052d5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:43:23', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399455803015');
INSERT INTO `e_log` VALUES ('d134662e-12ea-4662-8ccf-a6d542792cc6', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:15', ':get', '/getSalesByChannel/1/1399607146953', null, '1399607235968');
INSERT INTO `e_log` VALUES ('d14f9283-7f2a-4045-b6f4-bf5c19de201e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:57:10', ':get', '/getSettings', null, '1399528630265');
INSERT INTO `e_log` VALUES ('d1ecf4f9-b38e-4a61-8f86-8bb8d4612f65', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:36:05', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399970165250');
INSERT INTO `e_log` VALUES ('d205baf8-069b-40d7-af89-633f1471943c', null, '13651083480', '192.168.253.3', '2014-05-08 09:13:05', ':get', '/getSalesByChannel/0/-1', null, '1399511585453');
INSERT INTO `e_log` VALUES ('d22ea171-a326-49dd-82cc-7e8eb7960f63', null, '13651083480', '192.168.253.3', '2014-05-07 15:43:30', ':post', '/login', '{:phone \"13651083480\"}', '1399448610968');
INSERT INTO `e_log` VALUES ('d25a3e3e-86eb-426e-8388-23c82997df2e', null, null, '192.168.253.3', '2014-05-08 09:22:05', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512125187');
INSERT INTO `e_log` VALUES ('d26c3fa1-f140-4d64-a48f-1d0bf5564171', null, null, '192.168.253.1', '2014-05-13 18:28:19', ':get', '/', null, '1399976899437');
INSERT INTO `e_log` VALUES ('d277d7a2-8f9c-4f4d-8e28-50cab104574a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:23', ':post', '/demo/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399616783433');
INSERT INTO `e_log` VALUES ('d2f1dc50-83fc-4db3-90f6-586bc31513b1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:50:59', ':get', '/getShopEmps/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399971059015');
INSERT INTO `e_log` VALUES ('d3d01466-5c36-4977-924d-0704a4522f07', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:33:54', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399595634125');
INSERT INTO `e_log` VALUES ('d402bcb6-8ce7-47ee-81a6-829baac144e2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:54:08', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎以后再来\"}', '1399517648296');
INSERT INTO `e_log` VALUES ('d40ecec8-09a2-4f29-920b-160d16560225', null, null, '192.168.253.3', '2014-05-09 11:36:23', ':get', '/pub/grade_shop.html', null, '1399606583515');
INSERT INTO `e_log` VALUES ('d41eba4b-1e56-4932-801d-19eb48512bdf', null, '13651083480', '192.168.253.3', '2014-05-08 10:11:01', ':get', '/getModules/me', null, '1399515061703');
INSERT INTO `e_log` VALUES ('d4a340d6-ebc3-4428-871d-f9867601bfa2', null, '13651083480', '192.168.253.3', '2014-05-13 16:54:37', ':post', '/login', '{:phone \"13651083480\"}', '1399971277453');
INSERT INTO `e_log` VALUES ('d4a913d2-3f1c-471e-8f62-9fee16d5cd8d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:07:45', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399514865187');
INSERT INTO `e_log` VALUES ('d4c30330-a7d5-4ccd-967f-f7fe7ef2be45', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:13:20', ':get', '/getModules/me', null, '1399511600218');
INSERT INTO `e_log` VALUES ('d4c34a4e-58a9-40dd-baad-45e8258a88f9', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:45', ':get', '/getSalesByChannel/1/1399446405671', null, '1399446405812');
INSERT INTO `e_log` VALUES ('d4f32f2a-e2c1-4823-a990-934ee8ffeaf4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:17:32', ':get', '/demo/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616252011');
INSERT INTO `e_log` VALUES ('d55de555-522c-40b4-bc2a-171d4c62e22f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:05:30', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399511130640');
INSERT INTO `e_log` VALUES ('d59e247d-2a0d-4090-b185-0ebaaa14467c', null, null, '192.168.253.3', '2014-05-08 09:22:04', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399512124875');
INSERT INTO `e_log` VALUES ('d5c97402-49fe-4ad5-93fa-b0079ea48b58', null, '1', '192.168.253.3', '2014-05-09 10:41:49', ':post', '/login', '{:phone \"1\"}', '1399603309625');
INSERT INTO `e_log` VALUES ('d5d4e38a-0bfb-450e-a7eb-706db318c3bd', null, '13651083480', '192.168.253.3', '2014-05-08 14:33:10', ':get', '/getChannels', null, '1399530790625');
INSERT INTO `e_log` VALUES ('d5dd8ff7-2005-4f5f-b375-e13b4572bebb', null, '13651083480', '192.168.253.3', '2014-05-08 09:28:06', ':post', '/login', '{:phone \"13651083480\"}', '1399512486453');
INSERT INTO `e_log` VALUES ('d61732c1-0197-459f-a93e-300cf1e8700a', null, null, '192.168.253.3', '2014-05-13 17:04:50', ':get', '/pub/grade_shop.html', null, '1399971890531');
INSERT INTO `e_log` VALUES ('d61f6bbf-8926-4e54-aa5c-4de31fb8ce80', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:41', ':get', '/demo/getSalesByChannel/2/1399624354214', null, '1399624361464');
INSERT INTO `e_log` VALUES ('d648a058-2b42-4a6f-b0cd-557a2b17ad20', null, '13651083480', '192.168.253.3', '2014-05-13 15:14:25', ':post', '/login', '{:phone \"13651083480\"}', '1399965265875');
INSERT INTO `e_log` VALUES ('d6539ba0-45f5-4ff1-9a7a-4e0cd00d73ed', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:51:17', ':get', '/getSalesByChannel/1/1399967269265', null, '1399967477734');
INSERT INTO `e_log` VALUES ('d65540c2-105f-4000-a557-342e0de56f39', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:27:44', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399616826511', null, '1399616864683');
INSERT INTO `e_log` VALUES ('d6c2fd41-84a4-4760-b825-92ca88ef8459', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:45:19', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399963519750');
INSERT INTO `e_log` VALUES ('d6fb6265-9103-4420-9df9-bc00d0d39188', null, '1', '192.168.253.3', '2014-05-08 16:17:44', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399537064343');
INSERT INTO `e_log` VALUES ('d6fde213-167f-47fd-bccd-4794cfbe4ce5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:47:20', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399520840312');
INSERT INTO `e_log` VALUES ('d7523479-758a-418a-8715-2bc58dc3cd4e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:44:01', ':get', '/demo/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399617841245');
INSERT INTO `e_log` VALUES ('d7c4e0bf-7134-41a9-8d1f-45eefd27d152', null, '1', '192.168.253.3', '2014-05-13 11:13:18', ':post', '/login', '{:phone \"1\"}', '1399950798235');
INSERT INTO `e_log` VALUES ('d811cba2-c8b4-4007-aef9-dda660ce61d0', null, '13651083480', '118.194.195.3', '2014-05-09 14:33:20', ':get', '/demo/getSalesByChannel/0/-1', null, '1399617200355');
INSERT INTO `e_log` VALUES ('d820cc5f-6977-40bf-8125-9b9122343010', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:13:43', ':get', '/demo/getShopsByDistance/40.073684/116.242457/20/2', null, '1399616023276');
INSERT INTO `e_log` VALUES ('d8c76e92-582a-4da2-a24d-517d28054072', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:43:10', ':get', '/getSalesByChannel/1/1399963378796', null, '1399963390281');
INSERT INTO `e_log` VALUES ('d9eeea5d-cadc-47ed-a5bf-2ae9ea503338', null, null, '118.194.195.3', '2014-05-09 14:05:50', ':get', '/demo/app/download.html', null, '1399615550308');
INSERT INTO `e_log` VALUES ('da8df8a5-f3ae-42b9-b116-e89d218f31d4', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125828');
INSERT INTO `e_log` VALUES ('da98fcbf-f3b6-4220-9e99-c1760f055209', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:04:24', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536264203');
INSERT INTO `e_log` VALUES ('dac3ac82-8ae4-4304-9346-a199fdb1c95a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:50:48', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399971048796');
INSERT INTO `e_log` VALUES ('dace9688-ab1a-4fd9-b843-db8043c87497', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 15:26:31', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次光临\"}', '1399533991265');
INSERT INTO `e_log` VALUES ('db7a644e-6c7c-4592-bd64-121da9c70ebc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:10:26', ':get', '/demo/getShopShares/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/1399452076125', null, '1399615826261');
INSERT INTO `e_log` VALUES ('dba51266-f366-4c77-9d77-945485e68a4f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 13:35:20', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399959320984');
INSERT INTO `e_log` VALUES ('dca20fe6-fdf5-4e66-9ef4-99156fd78d8d', null, '13651083480', '192.168.253.3', '2014-05-13 15:58:54', ':get', '/getSalesByChannel/1/1399967830718', null, '1399967934687');
INSERT INTO `e_log` VALUES ('dd2c7f4e-6b01-4051-bee9-6a0b03aab5fe', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:42:41', ':post', '/saveShare', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :content \"%E5%BE%88%E6%98%AF%E5%96%9C%E6%AC%A2\", :fileNameList \"506413869_1399963350419.png\", :publisher \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", \"506413869_1399963350419.png\" {:size 183086, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2505329983984601215.tmp>, :content-type \"image/pjpeg\", :filename \"506413869_1399963350419.png\"}}', '1399963361937');
INSERT INTO `e_log` VALUES ('dd47abd3-c5eb-4f73-80ac-a26034234ba9', null, null, '192.168.253.3', '2014-05-08 11:56:20', ':get', '/getImageFile/-711923960_1399521341112.png', null, '1399521380062');
INSERT INTO `e_log` VALUES ('dd50da5e-8ea9-4466-9353-fa5800668f2e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 08:32:48', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399595568765');
INSERT INTO `e_log` VALUES ('dd5455e4-da15-47e1-9b49-c31c4efc66e8', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:34:09', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606449062');
INSERT INTO `e_log` VALUES ('dda0d86f-8bef-4d75-9751-f545e43fad5e', null, '1', '192.168.253.3', '2014-05-13 13:31:38', ':get', '/getSalesByChannel/1/1399958422515', null, '1399959098203');
INSERT INTO `e_log` VALUES ('de0b6af0-7643-4b81-b9d9-b7e3b7ab302a', null, '13651083480', '192.168.253.3', '2014-05-08 11:22:12', ':post', '/login', '{:phone \"13651083480\"}', '1399519332093');
INSERT INTO `e_log` VALUES ('de68a04a-3104-4605-9b36-dcc028781ec0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:34:02', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399595642296');
INSERT INTO `e_log` VALUES ('deb4f5f7-fd93-4c12-9973-d855b7ffca44', null, null, '192.168.253.3', '2014-05-08 09:40:48', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399513248468');
INSERT INTO `e_log` VALUES ('df0115ff-748b-4004-ae6f-0bd3a7127370', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:40:15', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399513215031');
INSERT INTO `e_log` VALUES ('df0aff26-9fa9-490c-ba64-cad48b2d0067', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 17:02:47', ':post', '/searchUsers', '{:search-word \"4\"}', '1399971767078');
INSERT INTO `e_log` VALUES ('df0d09a2-311f-4601-b9a4-ef6d102c482b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:11:23', ':get', '/getTrades', null, '1399515083156');
INSERT INTO `e_log` VALUES ('df17ae1c-49a3-47ed-85bf-a75c0502fe26', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:15:08', ':get', '/demo/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616108042');
INSERT INTO `e_log` VALUES ('df56b242-c019-431e-a155-f238e70d09cf', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:25:11', ':get', '/getTrades', null, '1399969511703');
INSERT INTO `e_log` VALUES ('df8b5211-c908-46bd-a574-5ff8fc1355ea', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:59:05', ':post', '/saveUserPhoto', '{:photo \"748488426_1399514332755.png\", :fileNameList \"748488426_1399514332755.png\", :uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", \"748488426_1399514332755.png\" {:size 58889, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-1447260467401250110.tmp>, :content-type \"image/pjpeg\", :filename \"748488426_1399514332755.png\"}}', '1399514345281');
INSERT INTO `e_log` VALUES ('dfab29fe-e552-4736-a799-f4a46f59ef8e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:23', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450283375');
INSERT INTO `e_log` VALUES ('dffd4e94-78c0-4c83-980b-2c9caa276207', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:13:04', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399961547125', null, '1399961584937');
INSERT INTO `e_log` VALUES ('dfff639b-2157-4dfd-8c22-b85cc36a3e4c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:29', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399451069250');
INSERT INTO `e_log` VALUES ('e0a742ef-9b2d-462d-8a3d-0470acf11edb', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:42', ':get', '/getModules/me', null, '1399533942765');
INSERT INTO `e_log` VALUES ('e14a4689-4c06-44fe-bc92-148952b22148', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:43', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"uuu\"}', '1399446643687');
INSERT INTO `e_log` VALUES ('e18b5fce-d39d-487e-846b-a9f8a3862b2d', null, '13651083480', '192.168.253.3', '2014-05-13 15:56:43', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/a9eda062-9863-45cd-b12f-f62c69cc0682', null, '1399967803937');
INSERT INTO `e_log` VALUES ('e23b8e2f-5aee-4887-a44c-674193820eb6', null, '13651083480', '192.168.253.3', '2014-05-13 09:26:17', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/a439840c-e231-4a8f-8a09-7e4f8883fe00', null, '1399944377610');
INSERT INTO `e_log` VALUES ('e251924d-5b6d-4e68-b9c0-6c616c96c9ab', null, '13651083480', '192.168.253.3', '2014-05-08 14:39:53', ':post', '/login', '{:phone \"13651083480\"}', '1399531193296');
INSERT INTO `e_log` VALUES ('e26b215a-60d8-4324-a51b-832bcb13f09a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:43:19', ':get', '/getTrades', null, '1399963399359');
INSERT INTO `e_log` VALUES ('e2b7379f-2ac2-4c06-9bd3-828226ef8de3', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284890');
INSERT INTO `e_log` VALUES ('e2b9d3cd-9689-4f1d-9fc2-91b70ac67c60', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '118.194.195.3', '2014-05-09 14:19:14', ':get', '/demo/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616354183');
INSERT INTO `e_log` VALUES ('e2ffdfb3-e72c-4f82-82f5-09e79d9408cd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 16:13:47', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399536827281');
INSERT INTO `e_log` VALUES ('e35e5bde-2d08-43e1-a48e-f03f2b9b77cb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:59:32', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399967972687');
INSERT INTO `e_log` VALUES ('e36e8bb7-679b-4246-852b-eeab6f1b9c73', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125968');
INSERT INTO `e_log` VALUES ('e3896a50-1756-4353-88a5-f611fe6dfc7c', null, '13651083480', '192.168.253.3', '2014-05-13 14:56:03', ':get', '/getSalesByChannel/1/1399963950984', null, '1399964163968');
INSERT INTO `e_log` VALUES ('e3af01ff-d7a4-4dd6-bf07-6c7448467e72', null, '13651083480', '192.168.253.3', '2014-05-13 09:24:41', ':get', '/getSalesByChannel/1/1399944280923', null, '1399944281314');
INSERT INTO `e_log` VALUES ('e421adff-802c-4a12-95d9-e4fa3cf127e2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:56:07', ':post', '/addSale', '{:content \"%E8%8B%B9%E6%9E%9C%EF%BC%8Cibm%E7%AD%89%E7%94%B5%E8%84%91%E6%BB%A15000%E7%AB%8B%E5%87%8F100%E7%8E%B0%E9%87%91\", :end_date \"1402156800000\", :fileNameList \"-354365311_1399521331897.png%7C-711923960_1399521341112.png%7C463517179_1399521362365.png\", :title \"%E7%94%B5%E8%84%91%E4%BC%98%E6%83%A0%E5%AD%A3\", :trade_id \"41\", :start_date \"1399478400000\", \"-711923960_1399521341112.png\" {:size 130234, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-6082467065566929931.tmp>, :content-type \"image/pjpeg\", :filename \"-711923960_1399521341112.png\"}, :shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", \"-354365311_1399521331897.png\" {:size 81255, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3322197020084694980.tmp>, :content-type \"image/pjpeg\", :filename \"-354365311_1399521331897.png\"}, \"463517179_1399521362365.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3673600331020136337.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399521362365.png\"}, :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399521367687');
INSERT INTO `e_log` VALUES ('e47e42aa-16f3-4354-937e-00ea374935f3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:39:37', ':get', '/getUserTotalGrade/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399966777078');
INSERT INTO `e_log` VALUES ('e49b2e07-527f-4a54-8351-b96e4800dbff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:52', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399452952953');
INSERT INTO `e_log` VALUES ('e51180f3-0831-40f2-9836-645a2396e56b', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:13', ':get', '/getSalesByChannel/0/1399446365375', null, '1399446373593');
INSERT INTO `e_log` VALUES ('e569cc78-c4b6-4ee4-923f-fb537fe7aa79', null, '13651083480', '192.168.253.3', '2014-05-13 16:28:04', ':post', '/login', '{:phone \"13651083480\"}', '1399969684640');
INSERT INTO `e_log` VALUES ('e57eaa65-737d-4147-b9d1-5f60d0cf88ab', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:28:04', ':get', '/getSalesByChannel/1/1399969497671', null, '1399969684968');
INSERT INTO `e_log` VALUES ('e5bcb124-387c-48f3-b159-fbb4c1b8cbe4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:41:26', ':get', '/getTrades', null, '1399970486328');
INSERT INTO `e_log` VALUES ('e6116df9-7cf5-4626-ad70-f6e8a839e13d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:51:17', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399521077812');
INSERT INTO `e_log` VALUES ('e64a8942-a6b2-4e4d-b0fe-75af58a581db', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:57', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399448757500');
INSERT INTO `e_log` VALUES ('e6c3659a-07ce-4202-84cc-5907179f0f73', null, '13651083480', '192.168.253.3', '2014-05-13 15:56:26', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/a9eda062-9863-45cd-b12f-f62c69cc0682', null, '1399967786296');
INSERT INTO `e_log` VALUES ('e6c747b9-42f5-401a-a814-c44bc38f9ef6', null, '13651083480', '192.168.253.3', '2014-05-08 14:38:00', ':post', '/saveShareReply', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :share_id \"97fe7eee-834f-4806-a11a-e2fa91c084fd\", :grade \"10\", :replier \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"欢迎下次再来\"}', '1399531080968');
INSERT INTO `e_log` VALUES ('e6dbfabe-daa4-4350-bbf7-4802061f11d1', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:57:21', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517841234');
INSERT INTO `e_log` VALUES ('e6ebc32b-99ad-4bba-a875-1371b80dd250', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-09 08:33:44', ':get', '/getSalesByChannel/1/1399595609390', null, '1399595624921');
INSERT INTO `e_log` VALUES ('e7c80081-7d00-4da7-b869-4582a308e4f5', null, '13651083480', '192.168.253.3', '2014-05-13 16:40:34', ':get', '/getSalesByChannel/1/1399970433765', null, '1399970434250');
INSERT INTO `e_log` VALUES ('e81ba8c5-b10c-459d-9e88-4d5c4197509b', null, null, '192.168.253.3', '2014-05-08 10:26:23', ':get', '/getImageFile/898289355_1399515888683.png', null, '1399515983156');
INSERT INTO `e_log` VALUES ('e82d8d13-e5a8-4327-a674-057771a6b97b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:57', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448697125');
INSERT INTO `e_log` VALUES ('e85c9b61-4b87-4148-b2d9-c9052a408361', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:22:56', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399605776671');
INSERT INTO `e_log` VALUES ('e85dbc48-8848-4d06-b669-595815c509bf', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:09:54', ':post', '/demo/addShopEmps', '{:emps \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\"}', '1399615794620');
INSERT INTO `e_log` VALUES ('e891ed66-de04-4c2d-8c80-e5f325e0a54e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:43', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453663421');
INSERT INTO `e_log` VALUES ('e8ad1e6a-85ef-4436-98dc-47bf37bdba02', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:10:08', ':get', '/demo/getShopShares/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399615808480');
INSERT INTO `e_log` VALUES ('e8b0d425-0ec0-466d-a657-003cb8e2cce1', null, null, '118.194.195.3', '2014-05-09 14:05:50', ':get', '/demo/app/YouGouHui.apk', null, '1399615550573');
INSERT INTO `e_log` VALUES ('e8ffd2a7-864c-40c2-8f03-164120525c35', null, '13651083480', '192.168.253.3', '2014-05-07 16:41:15', ':post', '/login', '{:phone \"13651083480\"}', '1399452075609');
INSERT INTO `e_log` VALUES ('e9bc259a-69e5-4e62-bdb2-48b0dee28cce', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:43', ':get', '/demo/getSalesByChannel/3/1399624361464', null, '1399624363464');
INSERT INTO `e_log` VALUES ('ea153ff9-e174-4a07-81a4-f161447ca2f6', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284984');
INSERT INTO `e_log` VALUES ('ea28ae1f-ff65-4b08-83a8-b16ef1b607a0', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 17:13:22', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399972402781');
INSERT INTO `e_log` VALUES ('ea990b29-281b-42e0-9e58-a7f08320a9c4', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:04', ':get', '/getShop/6abbacc1-aa63-4175-bd3a-4fb96abbd19f', null, '1399607224265');
INSERT INTO `e_log` VALUES ('eaa4b1a2-475a-4b22-813f-4e4649a2e088', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:22:59', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399515779781');
INSERT INTO `e_log` VALUES ('eb35aae9-a647-4373-87b9-b83b5138442e', null, null, '192.168.253.3', '2014-05-07 17:57:24', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399456644640');
INSERT INTO `e_log` VALUES ('eb48b1cd-1334-4787-8e98-782087b1c66f', null, '1', '192.168.253.3', '2014-05-09 10:38:39', ':post', '/login', '{:phone \"1\"}', '1399603119640');
INSERT INTO `e_log` VALUES ('eb5210f5-2cfa-45b0-b6fd-d608d63ad7b6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 11:51:25', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399521085468');
INSERT INTO `e_log` VALUES ('ebba14c1-4a18-4ea0-b77a-0f2f0888d482', null, null, '192.168.253.3', '2014-05-07 15:09:48', ':get', '/getImageFile/13651083480_1399446443410.png', null, '1399446588859');
INSERT INTO `e_log` VALUES ('ebf0a857-cecd-4326-aaa0-67fae28f2bb4', null, '13651083480', '192.168.253.3', '2014-05-08 11:23:08', ':get', '/getFriendShares/74dc86dd-dc56-4d45-a020-dd6b939e4fe2/1399519380403', null, '1399519388078');
INSERT INTO `e_log` VALUES ('ec02f49f-3ecf-4785-ab05-1d72f8915ca3', null, '13651083480', '192.168.253.3', '2014-05-08 11:22:01', ':get', '/getFriendShares/37c61b15-7333-45d0-bc7e-473b13cf34f9/1399519303584', null, '1399519321156');
INSERT INTO `e_log` VALUES ('ec195fe6-500f-463b-87ba-34b91f37d656', null, '13651083480', '192.168.253.3', '2014-05-08 13:51:34', ':post', '/login', '{:phone \"13651083480\"}', '1399528294031');
INSERT INTO `e_log` VALUES ('ec5a8529-d11c-4fab-84e9-93b2fce34085', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:34:31', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399966334515', null, '1399966471156');
INSERT INTO `e_log` VALUES ('ec71d0fc-accd-4c4a-a734-319d70689389', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870156');
INSERT INTO `e_log` VALUES ('ecb3d714-32a8-4277-8e32-084123519d78', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:22:21', ':get', '/getTrades', null, '1399512141250');
INSERT INTO `e_log` VALUES ('ed596ced-015a-45a7-b6c9-4768456fdd1b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:46:17', ':get', '/demo/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399617977245');
INSERT INTO `e_log` VALUES ('ee12196c-ec27-4575-8543-6f5f11f57f35', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:36:06', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399606566312');
INSERT INTO `e_log` VALUES ('ee31e1eb-78de-45e6-8b6f-27acb95009f2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:51:28', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971088453');
INSERT INTO `e_log` VALUES ('ee8515b8-a921-4391-a25d-439bec810d39', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:39:40', ':post', '/addFriend', '{:user_id \"076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd\", :friend_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399516780546');
INSERT INTO `e_log` VALUES ('ef0dcfa3-0bf7-48f1-b3d1-4635d3763bd5', null, null, '118.194.195.3', '2014-05-09 14:06:03', ':get', '/demo/app/YouGouHui.apk', null, '1399615563730');
INSERT INTO `e_log` VALUES ('ef570ab7-2460-448e-905a-cd852068dfb3', null, '1', '192.168.253.3', '2014-05-13 15:40:35', ':post', '/login', '{:phone \"1\"}', '1399966835046');
INSERT INTO `e_log` VALUES ('ef7993d3-9f61-4072-a692-bd94cfe688da', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 13:52:02', ':get', '/checkShopEmp/6abbacc1-aa63-4175-bd3a-4fb96abbd19f/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399528322500');
INSERT INTO `e_log` VALUES ('ef853864-ce87-4187-95cc-a468be23fad5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:49', ':get', '/demo/getShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5', null, '1399616809026');
INSERT INTO `e_log` VALUES ('f0c1de71-6466-4b76-8916-c4fca6a2fe4b', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:37:15', ':get', '/getFriends/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399516635046');
INSERT INTO `e_log` VALUES ('f121467b-0c35-4935-827a-737f7a37f712', null, '13651083480', '192.168.253.3', '2014-05-13 09:24:59', ':get', '/getSalesByChannel/3/1399944285173', null, '1399944299814');
INSERT INTO `e_log` VALUES ('f15870c1-c018-4ea5-8f8d-ac2b86cd67c7', null, '13651083480', '192.168.253.3', '2014-05-08 10:07:44', ':post', '/login', '{:phone \"13651083480\"}', '1399514864750');
INSERT INTO `e_log` VALUES ('f162c57c-a3a8-4ba7-b1b5-ea8b1d6d08f3', null, null, '192.168.253.3', '2014-05-08 10:10:25', ':get', '/getImageFile/-810116522_1399513645372.png', null, '1399515025484');
INSERT INTO `e_log` VALUES ('f183092b-f743-446f-bbe4-a07ab7a5e38c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:55:38', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971338015');
INSERT INTO `e_log` VALUES ('f1b42edd-d352-43bd-ad49-f944df147683', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:45:23', ':get', '/getModules/me', null, '1399963523328');
INSERT INTO `e_log` VALUES ('f1c7b356-8cf9-451e-9e39-29c0dd6e6d9e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:28:42', ':get', '/getSettings', null, '1399516122281');
INSERT INTO `e_log` VALUES ('f1d94239-5c76-41d5-b581-250d7ac4cc0c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:29:18', ':get', '/demo/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616958980');
INSERT INTO `e_log` VALUES ('f24a915e-cd28-4c5f-a857-fbe57ab4cf68', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:52', ':post', '/login', '{:phone \"13651083480\"}', '1399450732421');
INSERT INTO `e_log` VALUES ('f2756af2-f1c4-4ddc-a7fc-9e3fd150c538', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:32', ':get', '/getSalesByChannel/1/1399448672375', null, '1399448672609');
INSERT INTO `e_log` VALUES ('f29f102a-f99c-4d2a-9c97-7156a5f89d0e', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:52:35', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399963813937', null, '1399963955906');
INSERT INTO `e_log` VALUES ('f2a4f07e-ac5a-4918-a2e2-9e976658f5c4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:36', ':get', '/demo/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399624356917');
INSERT INTO `e_log` VALUES ('f2c9d6ef-49ec-4105-9613-6efa06c64d75', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:50:40', ':get', '/getSalesByChannel/1/1399970944593', null, '1399971040921');
INSERT INTO `e_log` VALUES ('f306d97d-2bda-40fa-bb08-0987dba161c8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:33', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450953031');
INSERT INTO `e_log` VALUES ('f323da6c-1f9d-4065-a0f5-8ac6fbeb40d6', null, '13651083480', '192.168.253.3', '2014-05-08 15:25:39', ':get', '/getSalesByChannel/1/1399533939312', null, '1399533939703');
INSERT INTO `e_log` VALUES ('f383f776-419a-4249-be1a-fcd602960a9e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 14:49:28', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399963768125');
INSERT INTO `e_log` VALUES ('f3a4699b-d5c1-44b7-a72c-af7d9aac724a', null, '13651083480', '118.194.195.3', '2014-05-09 14:20:56', ':get', '/demo/getModules/discover', null, '1399616456683');
INSERT INTO `e_log` VALUES ('f3dfc9fa-d8c0-4b66-8a05-4349d4968f49', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:55:42', ':get', '/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971342296');
INSERT INTO `e_log` VALUES ('f3e4d294-8851-40ba-9de7-45f53662e104', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:41', ':get', '/getShopFavoritesByUser/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399607261937');
INSERT INTO `e_log` VALUES ('f40990ee-fd0d-474f-a9ba-42abf5d2a0c3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':get', '/getSalesByChannel/1/1399446470578', null, '1399446470718');
INSERT INTO `e_log` VALUES ('f46cece9-e1c8-4286-ad40-3e951cfb5efe', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:22:35', ':get', '/getTrades', null, '1399512155656');
INSERT INTO `e_log` VALUES ('f4ccd575-b422-43da-afc2-416a746821a4', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 15:47:59', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399967135046', null, '1399967279156');
INSERT INTO `e_log` VALUES ('f4e4570e-b468-4a22-9410-8215f29b7bf5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:58:30', ':get', '/getModules/discover', null, '1399964310515');
INSERT INTO `e_log` VALUES ('f5040983-dc0b-4938-a83f-1936a3a2751d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:37:05', ':get', '/getSalesByChannel/1/1399970152546', null, '1399970225031');
INSERT INTO `e_log` VALUES ('f50c9210-2c63-4cd0-83c5-199e0cbc3c68', null, '1', '192.168.253.3', '2014-05-13 14:41:53', ':post', '/login', '{:phone \"1\"}', '1399963313515');
INSERT INTO `e_log` VALUES ('f5c6d174-a410-4d39-9e1b-8feb75e72f2d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 13:38:31', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399959511125');
INSERT INTO `e_log` VALUES ('f5d127ed-acb0-4c09-bb30-8ffd41b596c9', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:47:57', ':get', '/getSettings', null, '1399607277875');
INSERT INTO `e_log` VALUES ('f663e5d8-6c05-4317-acfe-98a5e8fe68ee', null, '13651083480', '192.168.253.3', '2014-05-08 10:10:57', ':get', '/getChannels', null, '1399515057421');
INSERT INTO `e_log` VALUES ('f6bcb2f5-dd48-47d5-b25c-c37637645117', null, '13651083480', '192.168.253.3', '2014-05-13 14:45:06', ':get', '/getSalesByChannel/0/-1', null, '1399963506203');
INSERT INTO `e_log` VALUES ('f6d013e0-a150-494e-865a-90d252a4cb56', null, '13651083480', '192.168.253.3', '2014-05-13 09:24:39', ':get', '/getChannels', null, '1399944279157');
INSERT INTO `e_log` VALUES ('f754fc09-72fe-451a-aaf3-4f58fcc30673', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:14:16', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399454056125');
INSERT INTO `e_log` VALUES ('f7ebd434-1c7d-4b78-92e7-07842238b408', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 10:22:50', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399515770921');
INSERT INTO `e_log` VALUES ('f7ee2b52-c94c-4a99-8b71-cd3493063a1a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:27:01', ':get', '/demo/getSaleData/fc7c8598-fea8-4b85-9933-d5fe9a1ac725/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616821886');
INSERT INTO `e_log` VALUES ('f85fb314-f879-4c22-8dc0-867ae2696ee1', null, '13651083480', '192.168.253.3', '2014-05-08 09:56:53', ':post', '/login', '{:phone \"13651083480\"}', '1399514213203');
INSERT INTO `e_log` VALUES ('f8907613-a61a-475e-9165-ae40de4c984c', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 10:10:49', ':get', '/getSalesByChannel/1/1399946934720', null, '1399947049657');
INSERT INTO `e_log` VALUES ('f8fb8a29-0769-4fd7-81fe-16b95c9d51f4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:08:58', ':get', '/demo/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399615738230');
INSERT INTO `e_log` VALUES ('f8ff38b8-b5e7-4e84-b82d-63d8599d5bae', null, '1', '192.168.253.3', '2014-05-13 14:56:22', ':post', '/login', '{:phone \"1\"}', '1399964182890');
INSERT INTO `e_log` VALUES ('f906a65f-0d96-4037-bf9b-d1ca81c16c02', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:02', ':get', '/getShopsByDistance/40.073712/116.242458/2000/0', null, '1399453622796');
INSERT INTO `e_log` VALUES ('f9490bb9-add8-4adb-9a6c-ccb69bfa07cc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:15:53', ':get', '/demo/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399616144464', null, '1399616153089');
INSERT INTO `e_log` VALUES ('f97d9cef-2253-4c83-85b5-45aa7f1c02db', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:00:24', ':get', '/getShopsByDistance/40.073683/116.242453/2000/0', null, '1399968024625');
INSERT INTO `e_log` VALUES ('f9bdb5d0-d95e-4838-ad42-099af7340426', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:04:14', ':post', '/saveUserPhoto', '{:photo \"834375879_1399511048951.png\", :fileNameList \"834375879_1399511048951.png\", :uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", \"834375879_1399511048951.png\" {:size 52141, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2384327552444089330.tmp>, :content-type \"image/pjpeg\", :filename \"834375879_1399511048951.png\"}}', '1399511054609');
INSERT INTO `e_log` VALUES ('f9d2f615-1b75-488c-83be-e09f49a45c1f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:27:23', ':get', '/demo/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399616843370');
INSERT INTO `e_log` VALUES ('f9dd371c-6bc5-4c4d-b146-b1bf3eb80975', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 10:29:23', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399602563515');
INSERT INTO `e_log` VALUES ('f9eda959-b2aa-451e-a755-361bda58fbf6', null, null, '192.168.253.1', '2014-05-07 16:28:59', ':get', '/aa', null, '1399451339046');
INSERT INTO `e_log` VALUES ('fa0be236-dc0e-48d4-ae27-3119476a8dfb', null, '13651083480', '192.168.253.3', '2014-05-08 11:49:40', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/b34a6fd2-e6f2-4565-8106-64cbe17be618', null, '1399520980046');
INSERT INTO `e_log` VALUES ('fa2c636c-dbfe-449e-a6cd-df1e28de81ee', null, null, '118.194.195.3', '2014-05-09 14:07:23', ':get', '/demo/getImageFile/463517179_1399521362365.png', null, '1399615643245');
INSERT INTO `e_log` VALUES ('fa4a4311-a3b6-4bb0-bbc9-f348241f388e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:34', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399453414437');
INSERT INTO `e_log` VALUES ('faa88ac5-5822-4435-a1b6-b18b737b96d1', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-08 10:57:12', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399517832234');
INSERT INTO `e_log` VALUES ('fab6ec7d-b9bc-4ee8-adb3-ca9eac765be4', null, '1', '192.168.253.3', '2014-05-08 16:17:31', ':get', '/getUserTotalGrade/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399537051281');
INSERT INTO `e_log` VALUES ('fac7a923-4fa9-4ac3-9aa8-aae144b1265d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:45:33', ':post', '/updateShop', '{:shop_id \"6abbacc1-aa63-4175-bd3a-4fb96abbd19f\", :field \"desc\", :value \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :fileNameList \"\"}', '1399455933875');
INSERT INTO `e_log` VALUES ('fae36d0b-17ef-4702-9b29-e0448cdde98a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:49:13', ':post', '/loginShopByPhone', '{:phone \"13651083480\"}', '1399970953578');
INSERT INTO `e_log` VALUES ('fb1cc060-3c95-4f1e-9d63-b116a3159532', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:26:33', ':delete', '/demo/deleteShopEmps/e162af86-f928-4ed1-8a7c-e6178d25a8d5/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616793370');
INSERT INTO `e_log` VALUES ('fb2809f8-103c-4e34-bd0d-80f69b740794', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 09:28:07', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399512487140');
INSERT INTO `e_log` VALUES ('fb314c60-962c-4efd-bdf9-c996c76d972b', null, null, '192.168.253.3', '2014-05-07 16:19:45', ':get', '/getImageFile/barcode_1641208558_1399450739125.png', null, '1399450785609');
INSERT INTO `e_log` VALUES ('fb5eb74a-de70-4637-b660-ebac1f3f2e88', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 14:46:41', ':get', '/getUserMessages/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd/1399963537125', null, '1399963601781');
INSERT INTO `e_log` VALUES ('fb78a3af-24d3-4486-aa5d-4e116d4934a4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '118.194.195.3', '2014-05-09 14:12:49', ':get', '/demo/getSalesByChannel/2/1399615738589', null, '1399615969651');
INSERT INTO `e_log` VALUES ('fb9bc70f-4f33-453e-9607-e5c137f9d04e', null, '13651083480', '192.168.253.3', '2014-05-08 10:22:06', ':post', '/login', '{:phone \"13651083480\"}', '1399515726843');
INSERT INTO `e_log` VALUES ('fbb8fa86-6282-4e13-b3bb-c11630843ab5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:43', ':get', '/getSalesByChannel/1/1399449042953', null, '1399449043375');
INSERT INTO `e_log` VALUES ('fbc253d2-6980-4bc1-be2c-6fdbadd3292b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:55:27', ':get', '/getSaleFavoritesByUser/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399971327765');
INSERT INTO `e_log` VALUES ('fc4ec61e-bf56-46cd-bb8d-ff7a9040809f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 15:32:14', ':get', '/getUserMessages/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399963929625', null, '1399966334468');
INSERT INTO `e_log` VALUES ('fc5df13c-aea7-4550-94cb-b4f4f3d09105', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-08 14:45:33', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399531533968');
INSERT INTO `e_log` VALUES ('fc60c8f8-03fb-4df0-a6f8-4670fae55f49', null, null, '192.168.253.3', '2014-05-08 10:38:11', ':get', '/getImageFile/1321682725_1399516655545.png', null, '1399516691000');
INSERT INTO `e_log` VALUES ('fc9f4f00-bb45-4da5-bc7e-3076b85f7562', null, null, '118.194.195.3', '2014-05-09 14:19:59', ':get', '/demo/app/download.html', null, '1399616399355');
INSERT INTO `e_log` VALUES ('fcd879f0-b86b-4bf9-8264-26da9d37bebd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:55:45', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399456545937');
INSERT INTO `e_log` VALUES ('fd2b3f26-bb4d-4dbc-8f25-3ea1d8c86df7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:06:48', ':post', '/searchUsers', '{:search-word \"12222222\"}', '1399453608531');
INSERT INTO `e_log` VALUES ('fd322c01-dd31-40f2-8c6b-6f02f8bb5db3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '223.203.193.252', '2014-05-09 16:32:58', ':get', '/demo/getTrades', null, '1399624378948');
INSERT INTO `e_log` VALUES ('fdbb48f3-e0d6-48a5-b59b-edf259517f4c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 09:27:44', ':get', '/getUserProfile/076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399944464392');
INSERT INTO `e_log` VALUES ('fdcedfb2-2308-4e9f-8439-373d84e40a33', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-13 16:05:13', ':get', '/getShopsByDistance/40.073683/116.242453/2000/0', null, '1399968313015');
INSERT INTO `e_log` VALUES ('fdf1bf9d-5e88-4be6-8bc5-1b6251a69be2', null, '13651083480', '118.194.195.3', '2014-05-09 14:06:51', ':get', '/demo/getModules/me', null, '1399615611292');
INSERT INTO `e_log` VALUES ('fe062298-380f-4fbe-9b9a-ebd91a7f18dd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-13 11:26:20', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399951580282');
INSERT INTO `e_log` VALUES ('fe22d684-8982-4d86-833b-8759ad39541d', null, null, '192.168.253.3', '2014-05-08 09:10:30', ':get', '/getImageFile/1711437471_1399456582365.png', null, '1399511430984');
INSERT INTO `e_log` VALUES ('fe255737-4720-4ca6-bad7-8adc7154992b', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1', '192.168.253.3', '2014-05-09 11:48:09', ':get', '/getSalesByDistance/40.073707/116.242451/2000/0', null, '1399607289921');
INSERT INTO `e_log` VALUES ('fe6f60d0-290d-4505-83e1-7b9533d39273', null, null, '192.168.253.3', '2014-05-13 14:42:49', ':get', '/getImageFile/506413869_1399963350419.png', null, '1399963369890');
INSERT INTO `e_log` VALUES ('fea061d9-7429-43bd-a45c-dce729de14dd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:06:07', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453567750');
INSERT INTO `e_log` VALUES ('fec6c1c4-4263-42f3-9464-8ab75d86c7a4', null, '13651083480', '192.168.253.3', '2014-05-07 16:38:56', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451933560.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A43.61538314819336%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451933560.png\", \"-1400089674_1399451933560.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3674141896022570713.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451933560.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\"}', '1399451936468');
INSERT INTO `e_log` VALUES ('fefd51c4-4700-46b6-8d9b-524a85759659', null, '13651083480', '192.168.253.3', '2014-05-13 16:04:05', ':post', '/login', '{:phone \"13651083480\"}', '1399968245781');
INSERT INTO `e_log` VALUES ('ff3a9f3b-bc94-4af3-8c87-b1630540a246', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:34', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399449094000');
INSERT INTO `e_log` VALUES ('ffaa670d-3fd2-4fed-b380-8373a8b36e4b', null, '1', '192.168.253.3', '2014-05-13 10:10:49', ':post', '/login', '{:phone \"1\"}', '1399947049032');
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
  `send_shop` varchar(36) DEFAULT NULL,
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
INSERT INTO `e_message` VALUES ('4e074272-c26a-4d6d-8181-365fb58756e3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '购物晒单-奖励积分:8\n商家回馈:谢谢惠顾。', '1399963435843', null, '0', null);
INSERT INTO `e_message` VALUES ('d0e75a90-2bac-4a00-a25c-4f192bbfb683', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '测试一下', '1399950678095', null, '0', null);

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
INSERT INTO `e_module` VALUES ('207', 'my_message', '我的消息', null, null, null, '6', 'me', '1');

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
INSERT INTO `e_sale` VALUES ('43b10a06-f46a-4816-a5cf-00eb257e6141', '五月优惠大放送', '全场汉堡买一送一', '1398873600000', '1401465600000', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1', '50489896_1399453226535.png', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399453275062', '2014-05-07', '1399971352890', '30', '2', '2');
INSERT INTO `e_sale` VALUES ('fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '电脑优惠季', '苹果，ibm等电脑满5000立减100现金', '1399478400000', '1402156800000', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '41', '-354365311_1399521331897.png', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399521367765', '2014-05-08', '1399971792328', '32', '0', '1');

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
INSERT INTO `e_sale_visit` VALUES ('04c21d5b-e8bf-4dfe-88a1-a83a433b1a99', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399968700421');
INSERT INTO `e_sale_visit` VALUES ('10bbd44a-282f-413d-bcd8-f30f1a113392', 'd480ed24-b6a5-4bad-a6fc-ca2337c09f15', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399620442120');
INSERT INTO `e_sale_visit` VALUES ('13883769-9c33-4aee-b03a-2f9b84eaff72', 'a439840c-e231-4a8f-8a09-7e4f8883fe00', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399944377704');
INSERT INTO `e_sale_visit` VALUES ('15d465d5-cb8d-4c02-8a1f-ce90df1a5d3b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399528372671');
INSERT INTO `e_sale_visit` VALUES ('185599fc-afbc-4b57-a734-291a13573704', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399521379093');
INSERT INTO `e_sale_visit` VALUES ('195f6360-16cb-4e74-bfbd-743da7f56da1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399528068546');
INSERT INTO `e_sale_visit` VALUES ('1a5e06bc-e11d-413c-8607-6dd398f4ceef', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453531140');
INSERT INTO `e_sale_visit` VALUES ('1f05c4df-9be5-47f3-871b-5bcf30035854', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399526956171');
INSERT INTO `e_sale_visit` VALUES ('209e5223-1e46-4834-b55c-c252891f3a95', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399617855042');
INSERT INTO `e_sale_visit` VALUES ('23b9dd85-d4b9-41f5-9ca8-5f8ccaaa45dd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453411515');
INSERT INTO `e_sale_visit` VALUES ('2410f0e5-8a6d-40bb-939f-4172cdbb61b5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399944431376');
INSERT INTO `e_sale_visit` VALUES ('25a2ddaf-84af-479d-be78-5699c9244b41', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399971342421');
INSERT INTO `e_sale_visit` VALUES ('2994eac8-4910-476c-9d69-b886a4183bfc', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399971305125');
INSERT INTO `e_sale_visit` VALUES ('2d643aea-8580-44b4-9487-b318677b5f81', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453294906');
INSERT INTO `e_sale_visit` VALUES ('35522955-7297-4dab-b975-02fec338e2ca', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399595645625');
INSERT INTO `e_sale_visit` VALUES ('35d40fb8-98b3-4aeb-b33b-9ef7bad2cde4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399521464781');
INSERT INTO `e_sale_visit` VALUES ('38ccc433-df6a-4626-b36a-1fc326196eee', '36a9a92d-9f19-4a8b-a566-841b5cf258af', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399616479058');
INSERT INTO `e_sale_visit` VALUES ('3b05c00d-d35c-42ce-ba09-d23db3062fe7', '6b974797-5bf0-42d4-a89b-d57fa70bedf8', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399618286948');
INSERT INTO `e_sale_visit` VALUES ('46bf6c00-c4ae-4b99-981c-9c414f2d3bd0', '43f79202-6ea1-4c38-b923-b9fdeb013932', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399615642995');
INSERT INTO `e_sale_visit` VALUES ('5934b847-fb06-4600-91cb-5e631a56408d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399616862839');
INSERT INTO `e_sale_visit` VALUES ('5a168b4b-c553-4da4-8dde-ccb9b6089a10', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399620643230');
INSERT INTO `e_sale_visit` VALUES ('5c9a1e0b-cf5a-4da6-83c9-277e9f061d5a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399616846870');
INSERT INTO `e_sale_visit` VALUES ('5f93cd1f-f689-4755-ab6a-c723113640c3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399527121500');
INSERT INTO `e_sale_visit` VALUES ('6527fd7c-615f-43f5-9266-81727c66e080', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399968588187');
INSERT INTO `e_sale_visit` VALUES ('686967bd-6d0f-463b-906d-9c21d2320335', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399516709453');
INSERT INTO `e_sale_visit` VALUES ('71fbfba9-8d7f-44a2-a5cc-5335fcb51ce0', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399616278120');
INSERT INTO `e_sale_visit` VALUES ('77549268-aef3-467f-b9a0-c944754bbc86', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399528116593');
INSERT INTO `e_sale_visit` VALUES ('78d22152-b29d-44de-8d34-1261eb3d249e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399624356933');
INSERT INTO `e_sale_visit` VALUES ('799d45e0-383b-4954-bf74-cca5aa4e3509', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399971136515');
INSERT INTO `e_sale_visit` VALUES ('7a0484b2-71c1-4292-80af-49e78a9f950c', 'b34a6fd2-e6f2-4565-8106-64cbe17be618', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399520980109');
INSERT INTO `e_sale_visit` VALUES ('7d4cea88-51f2-4c75-b968-5ad005047375', '9fe8f8d8-f280-427c-94c8-c97abaccb449', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399617227901');
INSERT INTO `e_sale_visit` VALUES ('7d78b242-458b-4490-b35f-33aa706faa3c', '6b974797-5bf0-42d4-a89b-d57fa70bedf8', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399618261776');
INSERT INTO `e_sale_visit` VALUES ('7fb7e27c-0592-4f79-a1dc-293edb6bddbb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399968588203');
INSERT INTO `e_sale_visit` VALUES ('7fd03604-a3ea-456b-8ed7-5cd75b5bcdf9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399616958995');
INSERT INTO `e_sale_visit` VALUES ('840751f3-7e62-45d0-af1a-805c0f936332', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399971147359');
INSERT INTO `e_sale_visit` VALUES ('850f9a54-c3e8-4464-809e-7be59c7fd847', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399616821901');
INSERT INTO `e_sale_visit` VALUES ('8acf0eb2-318d-409d-98c0-998246d67821', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399971352890');
INSERT INTO `e_sale_visit` VALUES ('8f257752-f008-4174-a6bf-d3e354a215f2', 'c888a184-8678-4193-ad6e-85c84fde2a93', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399618166573');
INSERT INTO `e_sale_visit` VALUES ('92310e80-b6f4-4411-b2ee-7ee951b4e41a', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399963317156');
INSERT INTO `e_sale_visit` VALUES ('9515b947-02ce-45c0-b07e-482ef11725c2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399971287656');
INSERT INTO `e_sale_visit` VALUES ('9afc2cb7-7f82-48bf-9078-3709ebef003a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399615801573');
INSERT INTO `e_sale_visit` VALUES ('a85dfba8-026b-42dc-9808-ddbec5b187ce', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399516068015');
INSERT INTO `e_sale_visit` VALUES ('a9771c54-99b8-4506-98b5-9e0fa4e47254', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399520820687');
INSERT INTO `e_sale_visit` VALUES ('aeff55b0-0aa5-4274-a7bb-5accfb2309b6', 'a9eda062-9863-45cd-b12f-f62c69cc0682', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399967803968');
INSERT INTO `e_sale_visit` VALUES ('b30a1edb-f890-4724-ac6b-8d66437c2949', 'a9eda062-9863-45cd-b12f-f62c69cc0682', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399967786390');
INSERT INTO `e_sale_visit` VALUES ('b851f890-ae7f-4d66-af4c-aaaa00fab77a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399527094093');
INSERT INTO `e_sale_visit` VALUES ('ba51257b-eed9-4849-80d7-e1b819569e04', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453301437');
INSERT INTO `e_sale_visit` VALUES ('bd1017d6-f263-47fa-b7fd-a08115fa571d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399528361828');
INSERT INTO `e_sale_visit` VALUES ('be072e24-2ae6-4c50-9ac2-9e13155b78f6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399521385093');
INSERT INTO `e_sale_visit` VALUES ('c336408a-e82d-4abb-a6fe-7f64f0405a6b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399944439860');
INSERT INTO `e_sale_visit` VALUES ('c882d7f0-1929-42cd-b5c7-6c2eeb49ed45', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399971277984');
INSERT INTO `e_sale_visit` VALUES ('cd486e3b-589b-4af9-b855-80bbc1a9e761', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399971338062');
INSERT INTO `e_sale_visit` VALUES ('d2539db4-13fb-470b-a026-a5ed4e0eff49', '43f79202-6ea1-4c38-b923-b9fdeb013932', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399615699401');
INSERT INTO `e_sale_visit` VALUES ('d42d0469-6a4a-4bd4-8171-5d5dfa70817a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399616134761');
INSERT INTO `e_sale_visit` VALUES ('e0aff33b-c747-4375-a046-da945f41a6d2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399971090546');
INSERT INTO `e_sale_visit` VALUES ('e35beb7e-e78f-415d-b50c-57275bb10f04', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399528302078');
INSERT INTO `e_sale_visit` VALUES ('e796112f-01f5-44a1-806e-60bd2686d094', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399528324953');
INSERT INTO `e_sale_visit` VALUES ('ea364ce5-bc94-41e0-9e5d-0a7f42030fd5', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399606270875');
INSERT INTO `e_sale_visit` VALUES ('f18497df-623f-4256-8cc8-b3b0bd0288c9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399971121437');
INSERT INTO `e_sale_visit` VALUES ('f4168aeb-388b-4493-aea9-f31cd501c531', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399968707781');
INSERT INTO `e_sale_visit` VALUES ('f76c0588-c3ed-41ad-89f7-8eb7fb76432d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', 'fc7c8598-fea8-4b85-9933-d5fe9a1ac725', '1399971792328');
INSERT INTO `e_sale_visit` VALUES ('ff9293a2-0aa5-4419-9551-b75fd06363e0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399617904730');

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
INSERT INTO `e_share` VALUES ('9fbebd30-1271-433e-8067-8099384ca9f6', '很是喜欢', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '1399963362000', '2014-05-13', null, '0', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '1399963362000');
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
INSERT INTO `e_share_img` VALUES ('363e8bd5-342f-45f6-b6a5-6cc828c36233', '506413869_1399963350419.png', '9fbebd30-1271-433e-8067-8099384ca9f6', '1', '1399963362015');
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
INSERT INTO `e_share_shop_reply` VALUES ('8c451bda-e36d-443c-b2e9-ba1f2d34bb30', '9fbebd30-1271-433e-8067-8099384ca9f6', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399963435843', '8', '谢谢惠顾。', '1');

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
INSERT INTO `e_shop_emp` VALUES ('28ed2c22-7060-4f63-99cc-1e3adfc70496', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', null, '1399616801136');
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
INSERT INTO `e_user_grade` VALUES ('5f8c18c8-a508-44ab-a638-f432a12c53ae', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '9fbebd30-1271-433e-8067-8099384ca9f6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399963435843', '1410331435843', '8', '0');
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
INSERT INTO `e_user_profile` VALUES ('076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '076b0d4d-3a7d-4f87-b9ba-7dab8b47abcd', '4', '1', '23', '0');
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
