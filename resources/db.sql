/*
Navicat MySQL Data Transfer

Source Server         : localhost_ebs
Source Server Version : 50511
Source Host           : localhost:3306
Source Database       : ebs

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2014-05-07 17:11:37
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

-- ----------------------------
-- Table structure for `e_grade_shop`
-- ----------------------------
DROP TABLE IF EXISTS `e_grade_shop`;
CREATE TABLE `e_grade_shop` (
  `uuid` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `shop_id` varchar(36) NOT NULL,
  `share_id` varchar(36) NOT NULL,
  `grader` varchar(36) DEFAULT NULL,
  `grade_time` varchar(16) DEFAULT NULL,
  `grade` int(11) DEFAULT '0',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_grade_shop
-- ----------------------------

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
INSERT INTO `e_log` VALUES ('014be67a-758b-4015-bedd-ab5718a8b042', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:57:51', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E7%9A%84%E4%BC%98%E6%83%A0%E5%B9%85%E5%BA%A6%E7%9C%9F%E5%A4%A7\", :fileNameList \"\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453071390');
INSERT INTO `e_log` VALUES ('045881f1-2739-4162-b6a8-b4f768e7fd59', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780093');
INSERT INTO `e_log` VALUES ('046fe82c-6a39-45e8-8df7-3e675c8c3a50', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:12', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450272593');
INSERT INTO `e_log` VALUES ('04d3ddb7-8f8f-4064-b062-287629f9614e', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:10', ':get', '/getSalesByChannel/1/1399448709921', null, '1399448710359');
INSERT INTO `e_log` VALUES ('0548c9c0-d7f6-4764-9033-f6f10eb9a0e0', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:05', ':get', '/getSalesByChannel/1/1399446365046', null, '1399446365312');
INSERT INTO `e_log` VALUES ('05cebc83-3afb-42c3-b0b0-05d55c035db2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:41:16', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399452074181.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242455%2C%22radius%22%3A30.53333282470703%2C%22latitude%22%3A40.073713%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399452074181.png\", \"-1400089674_1399452074181.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-9101481504796265372.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399452074181.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\"}', '1399452076078');
INSERT INTO `e_log` VALUES ('06244c60-2180-4526-9194-80c92c87594a', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:09', ':get', '/getSalesByChannel/0/1399448672640', null, '1399448709859');
INSERT INTO `e_log` VALUES ('06cc8233-db2f-48fc-8fbd-b6e9541e1e4f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:15', ':get', '/getSalesByChannel/0/1399449043453', null, '1399449255140');
INSERT INTO `e_log` VALUES ('0a9a1c29-1376-4188-86ae-61c8371fa13a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:48:06', ':get', '/getSalesByChannel/0/1399451070468', null, '1399452486046');
INSERT INTO `e_log` VALUES ('0bc70dbc-dd43-42d8-a881-059d79c4289b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:52', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399452952500', null, '1399453132015');
INSERT INTO `e_log` VALUES ('0bc95039-e470-4520-be59-ef39b8e38996', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:47:58', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"i妞妞\"}', '1399448878812');
INSERT INTO `e_log` VALUES ('10f7a4f2-b998-49ab-947d-e4dea57212c0', null, '13651083480', '192.168.253.3', '2014-05-07 16:22:32', ':post', '/login', '{:phone \"13651083480\"}', '1399450952531');
INSERT INTO `e_log` VALUES ('1101a8f0-31ce-40c8-a6cb-2a3361128b4a', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:42', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399449042515');
INSERT INTO `e_log` VALUES ('123a3304-50b7-4c1e-a789-38ee8c9ac142', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:48:06', ':get', '/getSalesByChannel/1/1399452486171', null, '1399452486562');
INSERT INTO `e_log` VALUES ('13fc67df-4c49-4d89-a48b-690377341bc3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:07', ':get', '/getSalesByChannel/1/1399450446671', null, '1399450447125');
INSERT INTO `e_log` VALUES ('141c087f-bd88-463e-84de-d17c8ee014b5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:34', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453294828');
INSERT INTO `e_log` VALUES ('15dc10c6-fc72-4c7f-bb82-640a3686d933', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:44', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453124406');
INSERT INTO `e_log` VALUES ('190d8588-9793-4228-992e-96ce38552058', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:39:46', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451983821.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242442%2C%22radius%22%3A40.0625%2C%22latitude%22%3A40.073733%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451983821.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\", \"-1400089674_1399451983821.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-4374092049493088978.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451983821.png\"}}', '1399451986296');
INSERT INTO `e_log` VALUES ('1a695663-03d3-4939-bc6b-a0daf7b3d048', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:13', ':get', '/getSalesByChannel/0/1399449255687', null, '1399450273500');
INSERT INTO `e_log` VALUES ('1ab1b26a-a4d3-469f-b764-e7173fb50332', null, null, '192.168.253.1', '2014-05-07 16:31:55', ':get', '/aa', null, '1399451515359');
INSERT INTO `e_log` VALUES ('1bbae5ab-e6d8-475e-b2d6-a7b625d1c59f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:30', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399449090046');
INSERT INTO `e_log` VALUES ('2183a7b6-a99f-421c-beec-6af810208252', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:14', ':get', '/getModules/discover', null, '1399446374921');
INSERT INTO `e_log` VALUES ('2295e41f-234c-4b3d-98d7-2b321475c468', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:28', ':get', '/getSalesByChannel/0/1399452890000', null, '1399453348296');
INSERT INTO `e_log` VALUES ('22d40a94-5a37-4c93-8aef-37ca6795d376', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:39:04', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451941843.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A43.61538314819336%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451941843.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\", \"-1400089674_1399451941843.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7030770994781893059.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451941843.png\"}}', '1399451944187');
INSERT INTO `e_log` VALUES ('22f4d41c-43a5-4bc9-988e-640c2556c785', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:05', ':get', '/getModules/me', null, '1399448705687');
INSERT INTO `e_log` VALUES ('22fe4eec-5f60-4b36-93a4-6a9081ed45ff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:14', ':get', '/getSalesByChannel/1/1399450273562', null, '1399450274187');
INSERT INTO `e_log` VALUES ('244217ba-32e9-426e-901a-b8045773c203', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:08:27', ':get', '/getSalesByChannel/1/1399446507625', null, '1399446507828');
INSERT INTO `e_log` VALUES ('25b36e8c-b0bd-4f5e-bf89-b52a3830f1db', null, null, '192.168.253.1', '2014-05-07 16:30:02', ':get', '/aa', null, '1399451402000');
INSERT INTO `e_log` VALUES ('25cf977c-c482-41fe-a835-3cc9dbd4af69', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:48', ':post', '/addShopFavorit', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\"}', '1399452948625');
INSERT INTO `e_log` VALUES ('28d7b203-b9ad-4d3b-b698-b19e8ef5d080', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:28', ':get', '/getSalesByChannel/0/1399453390453', null, '1399453408546');
INSERT INTO `e_log` VALUES ('29eb59a7-98d3-4cda-8a94-7ae98e19742f', null, null, '192.168.253.3', '2014-05-07 16:55:43', ':get', '/getImageFile/barcode_-1897623607_1399449405500.png', null, '1399452943187');
INSERT INTO `e_log` VALUES ('2a4344e4-6392-4e2a-b121-a312a808533b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:56:27', ':post', '/saveShare', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :content \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E7%9A%84%E4%BC%98%E6%83%A0%E5%B9%85%E5%BA%A6%E7%9C%9F%E5%A4%A7\", :fileNameList \"\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399452987562');
INSERT INTO `e_log` VALUES ('2bcb1be7-efb4-4499-86c6-acc256ead064', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:56:45', ':post', '/registerShop', '{\"602324364_1399449344230.png\" {:size 282015, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3469479880405305017.tmp>, :content-type \"image/pjpeg\", :filename \"602324364_1399449344230.png\"}, :desc \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E5%A4%A7%E5%93%81%E7%89%8C\", :shop_img \"602324364_1399449344230.png\", \"898289355_1399449344232.png\" {:size 290977, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2058955765726519369.tmp>, :content-type \"image/pjpeg\", :filename \"898289355_1399449344232.png\"}, :name \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E4%B8%8A%E5%9C%B0%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242443%2C%22radius%22%3A44.83333206176758%2C%22latitude%22%3A40.073733%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"602324364_1399449344230.png%7C898289355_1399449344232.png\", :busi_license \"898289355_1399449344232.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"1\"}', '1399449405281');
INSERT INTO `e_log` VALUES ('2c08378c-447b-4a28-b725-f8a227ea1090', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:30', ':get', '/getSalesByChannel/1/1399451069687', null, '1399451070390');
INSERT INTO `e_log` VALUES ('2c372b81-90e6-4e47-8ce4-1aff7faaa9b9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:53', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448693312');
INSERT INTO `e_log` VALUES ('2d91934c-4d25-4695-82fb-11939eeb5899', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:45', ':get', '/getSalesByChannel/0/1399446373625', null, '1399446405593');
INSERT INTO `e_log` VALUES ('2db499bf-d9ec-4de6-9077-71c15cec0ec7', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:54', ':get', '/getChannels', null, '1399448574468');
INSERT INTO `e_log` VALUES ('2e458c73-4c32-4f0c-be75-b13b4f5dc76a', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780156');
INSERT INTO `e_log` VALUES ('3047e659-2725-4461-acd9-d97b00d707e3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:53', ':get', '/getFriendShares/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c/1399446446109', null, '1399452893343');
INSERT INTO `e_log` VALUES ('337bdf55-b17a-4759-8ff2-2f528afa7dca', null, '13651083480', '192.168.253.3', '2014-05-07 15:54:14', ':post', '/login', '{:phone \"13651083480\"}', '1399449254062');
INSERT INTO `e_log` VALUES ('343dfb6c-8d58-4574-94a3-a10eace67e5d', null, '13651083480', '192.168.253.3', '2014-05-07 15:44:30', ':post', '/login', '{:phone \"13651083480\"}', '1399448670796');
INSERT INTO `e_log` VALUES ('350d687b-23c9-49b6-a766-0442f8ba04a0', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:52', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450730525.png\", :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242447%2C%22radius%22%3A39.31818389892578%2C%22latitude%22%3A40.073715%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450730525.png\", \"463517179_1399450730525.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3605247973725175815.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450730525.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450732265');
INSERT INTO `e_log` VALUES ('35545e52-0c95-4330-9f6b-c2932ca0d95d', null, null, '192.168.253.1', '2014-05-07 16:31:26', ':get', '/aa', null, '1399451486437');
INSERT INTO `e_log` VALUES ('380a651c-c7ef-41a3-81ea-4d309138b7ce', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:29', ':get', '/getSalesByChannel/0/1399450999750', null, '1399451069656');
INSERT INTO `e_log` VALUES ('3ab15c00-ed6f-4e3d-beb7-b05bad20b4de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:05', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450445765');
INSERT INTO `e_log` VALUES ('3c161fcd-510a-4057-9e1d-0e0af5be4ed4', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:28', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399452868843');
INSERT INTO `e_log` VALUES ('3ce09b10-6538-4c17-89ef-119c34d5b1b0', null, '13651083480', '192.168.253.3', '2014-05-07 16:24:28', ':post', '/login', '{:phone \"13651083480\"}', '1399451068687');
INSERT INTO `e_log` VALUES ('3d822834-0867-480e-87f8-3c3149b5b3b6', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:55', ':get', '/getSalesByChannel/0/-1', null, '1399448575906');
INSERT INTO `e_log` VALUES ('3db6c4af-8ab5-45df-a396-3420842b2c97', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:15:18', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450516336.png\", :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A41.633331298828125%2C%22latitude%22%3A40.073734%7D\", \"463517179_1399450516336.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2483613127985079083.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450516336.png\"}, :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450516336.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450518328');
INSERT INTO `e_log` VALUES ('3f72973b-0cf6-47bc-add7-049ce3876444', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:14', ':get', '/getSalesByChannel/1/1399446554312', null, '1399446554687');
INSERT INTO `e_log` VALUES ('3fbde255-1353-4ded-b9c4-2b623126ee52', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:15', ':get', '/getSalesByChannel/1/1399449255171', null, '1399449255593');
INSERT INTO `e_log` VALUES ('406b7e76-3cad-44cd-9a18-689a05b91e66', null, null, '192.168.253.3', '2014-05-07 16:55:43', ':get', '/getImageFile/898289355_1399449344232.png', null, '1399452943171');
INSERT INTO `e_log` VALUES ('42020c41-8503-4738-912a-d8800e5a1434', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:33', ':post', '/addSaleFavorit', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453533531');
INSERT INTO `e_log` VALUES ('45d4822f-e598-493e-bc93-2e0d0676af02', null, null, '192.168.253.3', '2014-05-07 16:54:29', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452869937');
INSERT INTO `e_log` VALUES ('461c1b0e-4112-47a0-8fc7-5481c78ca9ee', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:14', ':get', '/getSalesByChannel/0/1399446507875', null, '1399446554250');
INSERT INTO `e_log` VALUES ('473a90dc-3e97-4a0a-9570-341b4d7cb39b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:38', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399451078015');
INSERT INTO `e_log` VALUES ('484a0649-a747-410a-8047-ce8a4dee0acd', null, '13651083480', '192.168.253.3', '2014-05-07 15:17:00', ':post', '/login', '{:phone \"13651083480\"}', '1399447020343');
INSERT INTO `e_log` VALUES ('487ede92-3649-4bd7-a46e-8442cc72be0e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:49', ':get', '/getSalesByChannel/0/1399452486671', null, '1399452889609');
INSERT INTO `e_log` VALUES ('48836c88-7756-48eb-bf65-6a9561f3233d', null, null, '192.168.253.3', '2014-05-07 17:01:25', ':get', '/getImageFile/50489896_1399453226535.png', null, '1399453285000');
INSERT INTO `e_log` VALUES ('496dce09-c0e2-4b89-8463-43c0df282aa0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:18', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450998453');
INSERT INTO `e_log` VALUES ('4a8befe6-1eb7-4f45-94ce-e7c19eb613c9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:51:58', ':post', '/registerShop', '{\"1259860143_1399452716068.png\" {:size 68674, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7107816321588269714.tmp>, :content-type \"image/pjpeg\", :filename \"1259860143_1399452716068.png\"}, :desc \"%E6%AC%A2%E8%BF%8E%E5%85%89%E4%B8%B4\", :shop_img \"1259860143_1399452716068.png\", :name \"%E4%B8%BD%E4%BD%B3%E5%AE%9D%E8%B4%9D%E6%B0%B8%E6%97%BA%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22radius%22%3A38.766666412353516%2C%22longitude%22%3A116.242444%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"1259860143_1399452716068.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"40%7C3\"}', '1399452718515');
INSERT INTO `e_log` VALUES ('4e072192-5e31-4358-8cc8-9142d5644deb', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:18', ':post', '/addSaleDiscuss', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"优惠多多\"}', '1399453518328');
INSERT INTO `e_log` VALUES ('53cd162b-44b1-4202-814c-9b84df1b961e', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870421');
INSERT INTO `e_log` VALUES ('59a88e49-0e6d-402f-bead-e3c79d0369c7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:54:49', ':get', '/getSalesByChannel/1/1399452889671', null, '1399452889968');
INSERT INTO `e_log` VALUES ('59c61822-9bca-48dc-886f-d0bf4ddf7f61', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:58', ':post', '/login', '{:phone \"13651083480\"}', '1399450738156');
INSERT INTO `e_log` VALUES ('59de5d42-18f7-4ae1-9bdc-3036058a3562', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:31', ':get', '/getSalesByChannel/0/1399448759234', null, '1399449031968');
INSERT INTO `e_log` VALUES ('5ab1c185-70a9-4b51-8149-9c0c1196b757', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:54', ':get', '/getShopsByDistance/40.073736/116.242445/2000/0', null, '1399448694828');
INSERT INTO `e_log` VALUES ('5ae1f378-6a6e-4341-9e65-10ea60b94a84', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:35', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399446575765');
INSERT INTO `e_log` VALUES ('5b026942-0340-427f-8a7f-2c01dce7ce1e', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:25', ':post', '/login', '{:phone \"13651083480\"}', '1399446445015');
INSERT INTO `e_log` VALUES ('5db04152-de07-4ddd-86d7-0d2a32a8d1f6', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:31', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453411437');
INSERT INTO `e_log` VALUES ('5f99772d-6ccc-4dca-85df-ecc9030f211d', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:32', ':get', '/getSalesByChannel/1/1399449032031', null, '1399449032468');
INSERT INTO `e_log` VALUES ('5fdec4c8-cbae-4aa5-b6e1-f62bf9af8058', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:08', ':get', '/getSalesByChannel/1/1399446608109', null, '1399446608468');
INSERT INTO `e_log` VALUES ('6197a5e8-f6b4-4997-bb9f-c573021e98c2', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284859');
INSERT INTO `e_log` VALUES ('61b8ee38-01fb-4ad5-bc39-6e7dbed88b8f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:00', ':get', '/getSalesByDistance/40.073712/116.242458/2000/0', null, '1399453620437');
INSERT INTO `e_log` VALUES ('657c5123-1edb-4db2-ad7b-705f33a84291', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:34', ':get', '/getSalesByChannel/1/1399450953734', null, '1399450954093');
INSERT INTO `e_log` VALUES ('67bf0954-f6eb-404c-927a-326f57db4f38', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:54:14', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399449254546');
INSERT INTO `e_log` VALUES ('67dc88a5-9c96-400b-8fe0-c5f7a8376523', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:40', ':post', '/searchShops', '{:search-word \"上\"}', '1399452940171');
INSERT INTO `e_log` VALUES ('6997a88e-f40f-4a23-808d-d1440307c248', null, '13651083480', '192.168.253.3', '2014-05-07 15:50:42', ':post', '/login', '{:phone \"13651083480\"}', '1399449042015');
INSERT INTO `e_log` VALUES ('6a703fbd-1244-4c6d-ade0-8ce36501c09f', null, null, '192.168.253.1', '2014-05-07 16:30:39', ':get', '/aa', null, '1399451439578');
INSERT INTO `e_log` VALUES ('6a811cfb-dbda-4d39-b448-f00871ca0f2f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':get', '/getSalesByChannel/0/1399446405843', null, '1399446470546');
INSERT INTO `e_log` VALUES ('6b37caec-3eaf-4d31-b3ae-d01bd42ef27f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:00', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448700703');
INSERT INTO `e_log` VALUES ('6c7fc3b6-b6b0-4183-b5f1-0c0a0f51f7e7', null, null, '192.168.253.1', '2014-05-07 16:34:43', ':get', '/aa', null, '1399451683328');
INSERT INTO `e_log` VALUES ('6e875a17-afb4-496a-bcff-68f4aeb062fc', null, '13651083480', '192.168.253.3', '2014-05-07 16:48:04', ':post', '/login', '{:phone \"13651083480\"}', '1399452484906');
INSERT INTO `e_log` VALUES ('6ea2bea2-e0b1-4cea-84ef-197758e6bc42', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:08:27', ':get', '/getSalesByChannel/0/1399446470734', null, '1399446507546');
INSERT INTO `e_log` VALUES ('6f56985c-44dd-4964-8e83-bfe9fc61b5cb', null, '13651083480', '192.168.253.3', '2014-05-07 16:14:05', ':post', '/login', '{:phone \"13651083480\"}', '1399450445187');
INSERT INTO `e_log` VALUES ('6f65d46b-35c3-48c1-8bc5-2e996a7be784', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:39', ':get', '/getTrades', null, '1399449099765');
INSERT INTO `e_log` VALUES ('6fd63d90-edca-4a43-b9f2-04acf8889512', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:28', ':get', '/getSalesByChannel/1/1399453348375', null, '1399453348671');
INSERT INTO `e_log` VALUES ('70c78bb3-2231-4929-85c4-949d4c5fb77b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:02:33', ':get', '/getSalesByChannel/0/1399453348703', null, '1399453353015');
INSERT INTO `e_log` VALUES ('7500a62e-39c2-4dbc-aba5-b0898ef4c8d6', null, null, '192.168.253.3', '2014-05-07 16:58:46', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453126062');
INSERT INTO `e_log` VALUES ('768d68c0-86f6-4d6e-aeea-706ac3a4bf33', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:19:39', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450779140');
INSERT INTO `e_log` VALUES ('7808da2c-bca7-4daf-afa5-6c9053ba9cdc', null, '13651083480', '192.168.253.3', '2014-05-07 15:17:00', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"%E4%BA%BA%E4%BA%BA\"}', '1399447020640');
INSERT INTO `e_log` VALUES ('79035535-c755-4dc7-83d5-a31613ab4abe', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780312');
INSERT INTO `e_log` VALUES ('79c6026d-9362-4e91-ab0d-2bdeb0d6b369', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:17', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453637250');
INSERT INTO `e_log` VALUES ('7a2f6967-ce5b-4635-bcf2-34f6f6a6519b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:33', ':get', '/getSalesByChannel/0/1399450447187', null, '1399450953703');
INSERT INTO `e_log` VALUES ('7a505088-693d-4b30-9c6f-ceb0cd9d9c47', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:50', ':post', '/addSaleDiscuss', '{:sale_id \"43b10a06-f46a-4816-a5cf-00eb257e6141\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :content \"优惠多多\"}', '1399453430421');
INSERT INTO `e_log` VALUES ('7d881f53-8504-4fa5-8a4e-eece80bb17e5', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:08', ':get', '/getSalesByChannel/0/1399446577046', null, '1399446608031');
INSERT INTO `e_log` VALUES ('7dbd9350-fa06-4f7b-bcd0-19b759c34a3d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:08:03', ':post', '/updateShop', '{:shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :field \"desc\", :value \"%E8%82%AF%E5%BE%B7%E5%9F%BA%E5%A4%A7%E5%93%81%E7%89%8C\", :fileNameList \"\"}', '1399453683718');
INSERT INTO `e_log` VALUES ('7ee507ea-2f19-4bba-9745-86aaa66c5d14', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:32', ':get', '/getSalesByChannel/0/1399448576921', null, '1399448672296');
INSERT INTO `e_log` VALUES ('7ef51083-7540-42f9-9d12-2b85f88ee47a', null, '13651083480', '192.168.253.3', '2014-05-07 16:23:18', ':post', '/login', '{:phone \"13651083480\"}', '1399450998015');
INSERT INTO `e_log` VALUES ('7f49b047-2931-47f6-aea0-f389b5a7b72d', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:20', ':get', '/getSettings', null, '1399446380453');
INSERT INTO `e_log` VALUES ('833dd651-f77a-499e-bb6b-a9ce0f8ba361', null, '13651083480', '192.168.253.3', '2014-05-07 15:16:33', ':get', '/getSalesByChannel/0/1399446608500', null, '1399446993046');
INSERT INTO `e_log` VALUES ('833e771d-6fdb-4e1f-b083-15cae12a6bb5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:31', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399448671234');
INSERT INTO `e_log` VALUES ('845a7bd7-a845-4f77-9f8a-fc6d8e313764', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:26', ':post', '/registerUser', '{:fileNameList \"13651083480_1399446443410.png\", :phone \"13651083480\", :type \"1\", :photo \"13651083480_1399446443410.png\", :name \"%E5%A6%9E%E5%A6%9E\", \"13651083480_1399446443410.png\" {:size 46837, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-7366176588694513618.tmp>, :content-type \"image/pjpeg\", :filename \"13651083480_1399446443410.png\"}}', '1399446446046');
INSERT INTO `e_log` VALUES ('84642af6-aa5d-447c-89a0-684194c6481f', null, '13651083480', '192.168.253.3', '2014-05-07 15:42:56', ':get', '/getSalesByChannel/1/1399448575968', null, '1399448576890');
INSERT INTO `e_log` VALUES ('84f74b1e-612e-413e-a967-d7c5d5d0cea1', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:10:32', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450232343');
INSERT INTO `e_log` VALUES ('853a20eb-33cc-4c6a-854d-4bedee37546e', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:03', ':get', '/getChannels', null, '1399446363593');
INSERT INTO `e_log` VALUES ('85683f3a-3122-44d4-aaae-dc2d0a476274', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:42', ':get', '/getSalesByChannel/0/1399449032515', null, '1399449042921');
INSERT INTO `e_log` VALUES ('8739bb2a-ab31-4c1c-8e64-60366a832fd8', null, '13651083480', '192.168.253.3', '2014-05-07 15:43:31', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"222\"}', '1399448611484');
INSERT INTO `e_log` VALUES ('8794b804-6c5a-4c35-9f7d-33960ec0d044', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:14', ':post', '/addSale', '{:content \"%E5%85%A8%E5%9C%BA%E6%B1%89%E5%A0%A1%E4%B9%B0%E4%B8%80%E9%80%81%E4%B8%80\", :end_date \"1401465600000\", \"50489896_1399453226535.png\" {:size 228877, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-2626007887600820125.tmp>, :content-type \"image/pjpeg\", :filename \"50489896_1399453226535.png\"}, :fileNameList \"50489896_1399453226535.png\", :title \"%E4%BA%94%E6%9C%88%E4%BC%98%E6%83%A0%E5%A4%A7%E6%94%BE%E9%80%81\", :trade_id \"1\", :start_date \"1398873600000\", :shop_id \"e162af86-f928-4ed1-8a7c-e6178d25a8d5\", :publisher \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399453274984');
INSERT INTO `e_log` VALUES ('87a942d2-3b3d-4193-a15a-18159dffa08d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:01:41', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453301359');
INSERT INTO `e_log` VALUES ('87d9f409-a37a-4047-a79f-3916f4b034b9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:58:52', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453132406');
INSERT INTO `e_log` VALUES ('8a588999-243d-44da-a7f9-5136a27aff9e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:29', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399451009109');
INSERT INTO `e_log` VALUES ('8c57173f-e258-40c3-8a78-5c55653bdd53', null, '13651083480', '192.168.253.3', '2014-05-07 16:39:45', ':post', '/login', '{:phone \"13651083480\"}', '1399451985312');
INSERT INTO `e_log` VALUES ('8ed066b0-7e13-42d3-bb25-755b533cc70e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:52', ':get', '/getSettings', null, '1399448692171');
INSERT INTO `e_log` VALUES ('8f98c5d4-df2e-4f98-b905-40f78f75d6de', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:05:31', ':get', '/getSaleData/43b10a06-f46a-4816-a5cf-00eb257e6141/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453531093');
INSERT INTO `e_log` VALUES ('904ab94f-6f17-4e55-a0cf-617ef3b5f31a', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780125');
INSERT INTO `e_log` VALUES ('90881ee6-fff2-49b2-8ddb-1143a6fd47a7', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:43', ':post', '/login', '{:phone \"13651083480\"}', '1399446643296');
INSERT INTO `e_log` VALUES ('9291175a-eeba-4530-86a3-9192d6fb1b9c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:18:59', ':post', '/registerShop', '{:desc \"%E6%8E%A2%E8%B7%AF%E8%80%85%E6%97%97%E8%88%B0%E5%BA%97\", :shop_img \"463517179_1399450736650.png\", \"463517179_1399450736650.png\" {:size 34743, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-6386821006836686561.tmp>, :content-type \"image/pjpeg\", :filename \"463517179_1399450736650.png\"}, :name \"%E4%B8%8A%E5%9C%B0%E5%8D%8E%E8%81%94%E6%8E%A2%E8%B7%AF%E8%80%85%E4%B8%93%E5%8D%96%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242447%2C%22radius%22%3A39.31818389892578%2C%22latitude%22%3A40.073715%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"463517179_1399450736650.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"2%7C40\"}', '1399450739031');
INSERT INTO `e_log` VALUES ('93021c0e-ee30-43f2-998e-556db4d4f850', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:52', ':get', '/getSalesByShop/e162af86-f928-4ed1-8a7c-e6178d25a8d5/1399449405468', null, '1399452952421');
INSERT INTO `e_log` VALUES ('935b3306-d0a6-4dfd-a266-205185f62e5d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:59', ':get', '/getSalesByChannel/1/1399448758515', null, '1399448759171');
INSERT INTO `e_log` VALUES ('93628f2c-1037-49b8-adce-9b3f69cabd48', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:59', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"妞妞\"}', '1399449059484');
INSERT INTO `e_log` VALUES ('9487d840-a498-4d94-b6f1-52685b743983', null, null, '192.168.253.1', '2014-05-07 16:31:20', ':get', '/aa', null, '1399451480281');
INSERT INTO `e_log` VALUES ('94f55592-5a11-414c-9acf-8b415473822b', null, null, '192.168.253.3', '2014-05-07 16:19:40', ':get', '/getImageFile/463517179_1399450736650.png', null, '1399450780531');
INSERT INTO `e_log` VALUES ('95de4614-a955-4907-a262-8df5b3b04a79', null, '13651083480', '192.168.253.3', '2014-05-07 16:11:12', ':post', '/login', '{:phone \"13651083480\"}', '1399450272234');
INSERT INTO `e_log` VALUES ('9665b07e-ce90-45d5-b460-42b250922cc4', null, '13651083480', '192.168.253.3', '2014-05-07 16:39:03', ':post', '/login', '{:phone \"13651083480\"}', '1399451943312');
INSERT INTO `e_log` VALUES ('99f00e38-264b-4164-b2c9-afc1e0dc9eba', null, '13651083480', '192.168.253.3', '2014-05-07 15:09:35', ':post', '/login', '{:phone \"13651083480\"}', '1399446575203');
INSERT INTO `e_log` VALUES ('9d6a7841-b562-4617-b239-45e2d3cc8fb7', null, '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':post', '/login', '{:phone \"13651083480\"}', '1399446470312');
INSERT INTO `e_log` VALUES ('9dd1f966-c30c-44dd-9dcd-3fbc8e83d394', null, '13651083480', '192.168.253.3', '2014-05-07 15:45:57', ':post', '/login', '{:phone \"13651083480\"}', '1399448757062');
INSERT INTO `e_log` VALUES ('a0b856c1-94ad-4ef1-a829-c5ff32023901', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:05', ':get', '/getSalesByChannel/0/-1', null, '1399446365015');
INSERT INTO `e_log` VALUES ('a3c5f7bc-9e46-4a79-9ae3-bada1f235b56', null, '13651083480', '192.168.253.3', '2014-05-07 15:16:33', ':get', '/getSalesByChannel/1/1399446993109', null, '1399446993390');
INSERT INTO `e_log` VALUES ('a4c887b6-7a21-4e26-832c-7cfc2d0e74ab', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:36', ':get', '/getSalesByChannel/0/1399446554718', null, '1399446576500');
INSERT INTO `e_log` VALUES ('a6217e4c-14da-4768-8084-69d41c5026e0', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:10', ':get', '/getSalesByChannel/0/1399453353109', null, '1399453390390');
INSERT INTO `e_log` VALUES ('a8ea01fa-5bf2-4401-b709-102ba9839d9f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:51:58', ':post', '/registerShop', '{\"1259860143_1399452716068.png\" {:size 68674, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3820336725498127850.tmp>, :content-type \"image/pjpeg\", :filename \"1259860143_1399452716068.png\"}, :desc \"%E6%AC%A2%E8%BF%8E%E5%85%89%E4%B8%B4\", :shop_img \"1259860143_1399452716068.png\", :name \"%E4%B8%BD%E4%BD%B3%E5%AE%9D%E8%B4%9D%E6%B0%B8%E6%97%BA%E5%BA%97\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22radius%22%3A38.766666412353516%2C%22longitude%22%3A116.242444%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"1259860143_1399452716068.png\", :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"40%7C3\"}', '1399452718562');
INSERT INTO `e_log` VALUES ('a9d01922-85f0-47f5-8b46-17686f48e4e7', null, '13651083480', '192.168.253.3', '2014-05-07 16:57:51', ':post', '/login', '{:phone \"13651083480\"}', '1399453071031');
INSERT INTO `e_log` VALUES ('aa7e22b0-eeb9-412f-93ec-ada7e850215f', null, '13651083480', '192.168.253.3', '2014-05-07 16:10:32', ':post', '/login', '{:phone \"13651083480\"}', '1399450232000');
INSERT INTO `e_log` VALUES ('ab321719-2ea1-4c71-a481-df1961e9d665', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:19', ':get', '/getSalesByChannel/1/1399450999187', null, '1399450999687');
INSERT INTO `e_log` VALUES ('aba66e4d-d0a7-44d2-83b8-4e470fc76b24', null, '13651083480', '192.168.253.3', '2014-05-07 17:05:18', ':post', '/login', '{:phone \"13651083480\"}', '1399453518125');
INSERT INTO `e_log` VALUES ('abe8ada8-bea6-4713-8734-5e5e75d4e04e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:58', ':get', '/getSalesByChannel/0/1399448710437', null, '1399448758468');
INSERT INTO `e_log` VALUES ('ad0a45eb-7b03-4a06-b677-60308f604cf0', null, null, '192.168.253.3', '2014-05-07 17:01:25', ':get', '/getImageFile/50489896_1399453226535.png', null, '1399453285000');
INSERT INTO `e_log` VALUES ('b23e3821-ff89-4feb-ae2b-d58297d8449c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:48', ':get', '/getModules/discover', null, '1399448688203');
INSERT INTO `e_log` VALUES ('b28c6937-65ed-4078-aae4-93b6e3ec79c9', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:16', ':get', '/getModules/me', null, '1399446376812');
INSERT INTO `e_log` VALUES ('b5b8ba6f-85c6-4cf7-9e78-4f5e005f065d', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:23:19', ':get', '/getSalesByChannel/0/1399450954234', null, '1399450999109');
INSERT INTO `e_log` VALUES ('b6007b9f-d2e6-4d10-b4af-5cbb921a678f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:09:36', ':get', '/getSalesByChannel/1/1399446576531', null, '1399446576937');
INSERT INTO `e_log` VALUES ('b6137f4d-a73d-4338-b613-05fc4fae150d', null, null, '192.168.253.1', '2014-05-07 16:29:22', ':get', '/aa', null, '1399451362000');
INSERT INTO `e_log` VALUES ('b61b2edd-2dee-45c6-8aac-c81a14885b97', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870015');
INSERT INTO `e_log` VALUES ('b73a7c1d-f128-4cd0-907e-7172c22a1449', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125796');
INSERT INTO `e_log` VALUES ('b7ef26ec-1ca9-4ad3-ad85-2ae8f7e2cba2', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:48:05', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399452485484');
INSERT INTO `e_log` VALUES ('b9480b9a-30a3-43dc-85c4-5880722a6205', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:07', ':post', '/searchShops', '{:search-word \"上地\"}', '1399452907718');
INSERT INTO `e_log` VALUES ('bd9fbd86-5148-4504-a485-a6a591a4024f', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:46:20', ':put', '/updateUserName', '{:uuid \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :name \"i妞妞\"}', '1399448780109');
INSERT INTO `e_log` VALUES ('bf03a998-7566-48bf-b76e-b66ef4e006bc', null, null, '192.168.253.1', '2014-05-07 16:34:59', ':get', '/aa', null, '1399451699296');
INSERT INTO `e_log` VALUES ('ce6c0389-7fea-4cd1-ac38-2b1e2a4e94fe', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:14:06', ':get', '/getSalesByChannel/0/1399450274265', null, '1399450446640');
INSERT INTO `e_log` VALUES ('ce9bc156-adb7-4bba-a39b-5fafdb5496f9', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:47', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450967562');
INSERT INTO `e_log` VALUES ('d00488c9-2208-4cce-b9fb-113eee52b3ff', null, null, '192.168.253.3', '2014-05-07 16:54:29', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452869968');
INSERT INTO `e_log` VALUES ('d078860d-753c-4730-bc43-df23b0bfa668', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125921');
INSERT INTO `e_log` VALUES ('d087fa21-977f-4cbd-8eca-47c8fbd8aedd', null, null, '192.168.253.3', '2014-05-07 15:07:42', ':get', '/getImageFile//storage/emulated/0/bluetooth/1.jpeg', null, '1399446462234');
INSERT INTO `e_log` VALUES ('d22ea171-a326-49dd-82cc-7e8eb7960f63', null, '13651083480', '192.168.253.3', '2014-05-07 15:43:30', ':post', '/login', '{:phone \"13651083480\"}', '1399448610968');
INSERT INTO `e_log` VALUES ('d4c34a4e-58a9-40dd-baad-45e8258a88f9', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:45', ':get', '/getSalesByChannel/1/1399446405671', null, '1399446405812');
INSERT INTO `e_log` VALUES ('da8df8a5-f3ae-42b9-b116-e89d218f31d4', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125828');
INSERT INTO `e_log` VALUES ('dfab29fe-e552-4736-a799-f4a46f59ef8e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:11:23', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399450283375');
INSERT INTO `e_log` VALUES ('dfff639b-2157-4dfd-8c22-b85cc36a3e4c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:24:29', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399451069250');
INSERT INTO `e_log` VALUES ('e14a4689-4c06-44fe-bc92-148952b22148', null, '13651083480', '192.168.253.3', '2014-05-07 15:10:43', ':post', '/registerUser', '{:fileNameList \"\", :phone \"13651083480\", :type \"1\", :name \"uuu\"}', '1399446643687');
INSERT INTO `e_log` VALUES ('e2b7379f-2ac2-4c06-9bd3-828226ef8de3', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284890');
INSERT INTO `e_log` VALUES ('e36e8bb7-679b-4246-852b-eeab6f1b9c73', null, null, '192.168.253.3', '2014-05-07 16:58:45', ':get', '/getImageFile/-1400089674_1399452074181.png', null, '1399453125968');
INSERT INTO `e_log` VALUES ('e49b2e07-527f-4a54-8351-b96e4800dbff', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:55:52', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399452952953');
INSERT INTO `e_log` VALUES ('e51180f3-0831-40f2-9836-645a2396e56b', null, '13651083480', '192.168.253.3', '2014-05-07 15:06:13', ':get', '/getSalesByChannel/0/1399446365375', null, '1399446373593');
INSERT INTO `e_log` VALUES ('e64a8942-a6b2-4e4d-b0fe-75af58a581db', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:45:57', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399448757500');
INSERT INTO `e_log` VALUES ('e82d8d13-e5a8-4327-a674-057771a6b97b', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:57', ':get', '/getSalesByDistance/40.073736/116.242445/2000/0', null, '1399448697125');
INSERT INTO `e_log` VALUES ('e891ed66-de04-4c2d-8c80-e5f325e0a54e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:43', ':get', '/checkShopEmp/e162af86-f928-4ed1-8a7c-e6178d25a8d5/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453663421');
INSERT INTO `e_log` VALUES ('e8ffd2a7-864c-40c2-8f03-164120525c35', null, '13651083480', '192.168.253.3', '2014-05-07 16:41:15', ':post', '/login', '{:phone \"13651083480\"}', '1399452075609');
INSERT INTO `e_log` VALUES ('ea153ff9-e174-4a07-81a4-f161447ca2f6', null, null, '192.168.253.3', '2014-05-07 16:11:24', ':get', '/getImageFile/602324364_1399449344230.png', null, '1399450284984');
INSERT INTO `e_log` VALUES ('ebba14c1-4a18-4ea0-b77a-0f2f0888d482', null, null, '192.168.253.3', '2014-05-07 15:09:48', ':get', '/getImageFile/13651083480_1399446443410.png', null, '1399446588859');
INSERT INTO `e_log` VALUES ('ec71d0fc-accd-4c4a-a734-319d70689389', null, null, '192.168.253.3', '2014-05-07 16:54:30', ':get', '/getImageFile/1259860143_1399452716068.png', null, '1399452870156');
INSERT INTO `e_log` VALUES ('f24a915e-cd28-4c5f-a857-fbe57ab4cf68', null, '13651083480', '192.168.253.3', '2014-05-07 16:18:52', ':post', '/login', '{:phone \"13651083480\"}', '1399450732421');
INSERT INTO `e_log` VALUES ('f2756af2-f1c4-4ddc-a7fc-9e3fd150c538', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:44:32', ':get', '/getSalesByChannel/1/1399448672375', null, '1399448672609');
INSERT INTO `e_log` VALUES ('f306d97d-2bda-40fa-bb08-0987dba161c8', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 16:22:33', ':get', '/getFriends/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399450953031');
INSERT INTO `e_log` VALUES ('f40990ee-fd0d-474f-a9ba-42abf5d2a0c3', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:07:50', ':get', '/getSalesByChannel/1/1399446470578', null, '1399446470718');
INSERT INTO `e_log` VALUES ('f906a65f-0d96-4037-bf9b-d1ca81c16c02', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:07:02', ':get', '/getShopsByDistance/40.073712/116.242458/2000/0', null, '1399453622796');
INSERT INTO `e_log` VALUES ('f9eda959-b2aa-451e-a755-361bda58fbf6', null, null, '192.168.253.1', '2014-05-07 16:28:59', ':get', '/aa', null, '1399451339046');
INSERT INTO `e_log` VALUES ('fa4a4311-a3b6-4bb0-bbc9-f348241f388e', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:03:34', ':get', '/getSaleDiscusses/43b10a06-f46a-4816-a5cf-00eb257e6141/1399453275062', null, '1399453414437');
INSERT INTO `e_log` VALUES ('fb314c60-962c-4efd-bdf9-c996c76d972b', null, null, '192.168.253.3', '2014-05-07 16:19:45', ':get', '/getImageFile/barcode_1641208558_1399450739125.png', null, '1399450785609');
INSERT INTO `e_log` VALUES ('fbb8fa86-6282-4e13-b3bb-c11630843ab5', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:50:43', ':get', '/getSalesByChannel/1/1399449042953', null, '1399449043375');
INSERT INTO `e_log` VALUES ('fd2b3f26-bb4d-4dbc-8f25-3ea1d8c86df7', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:06:48', ':post', '/searchUsers', '{:search-word \"12222222\"}', '1399453608531');
INSERT INTO `e_log` VALUES ('fea061d9-7429-43bd-a45c-dce729de14dd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 17:06:07', ':get', '/getUserProfile/5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', null, '1399453567750');
INSERT INTO `e_log` VALUES ('fec6c1c4-4263-42f3-9464-8ab75d86c7a4', null, '13651083480', '192.168.253.3', '2014-05-07 16:38:56', ':post', '/registerShop', '{:desc \"%E4%B8%93%E5%8D%96%E7%94%B5%E8%84%91%E5%92%8C%E4%B9%A6%E7%B1%8D\", :shop_img \"-1400089674_1399451933560.png\", :name \"%E5%8C%97%E6%B8%85%E8%B7%AF%E7%94%B5%E8%84%91%E5%9F%8E\", :location \"%7B%22address%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7%22%2C%22lontitude%22%3A116.242446%2C%22radius%22%3A43.61538314819336%2C%22latitude%22%3A40.073734%7D\", :owner \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\", :fileNameList \"-1400089674_1399451933560.png\", \"-1400089674_1399451933560.png\" {:size 50283, :tempfile #<File C:\\DOCUME~1\\ADMINI~1\\LOCALS~1\\Temp\\ring-multipart-3674141896022570713.tmp>, :content-type \"image/pjpeg\", :filename \"-1400089674_1399451933560.png\"}, :address \"%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E5%8C%97%E6%B8%85%E8%B7%AF68%E5%8F%B7\", :tradeList \"41%7C42\"}', '1399451936468');
INSERT INTO `e_log` VALUES ('ff3a9f3b-bc94-4af3-8c87-b1630540a246', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '13651083480', '192.168.253.3', '2014-05-07 15:51:34', ':post', '/loginShop', '{:user_id \"5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c\"}', '1399449094000');

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
INSERT INTO `e_sale` VALUES ('43b10a06-f46a-4816-a5cf-00eb257e6141', '五月优惠大放送', '全场汉堡买一送一', '1398873600000', '1401465600000', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1', '50489896_1399453226535.png', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399453275062', '2014-05-07', '1399453531140', '4', '1', '1');

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
INSERT INTO `e_sale_visit` VALUES ('1a5e06bc-e11d-413c-8607-6dd398f4ceef', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453531140');
INSERT INTO `e_sale_visit` VALUES ('23b9dd85-d4b9-41f5-9ca8-5f8ccaaa45dd', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453411515');
INSERT INTO `e_sale_visit` VALUES ('2d643aea-8580-44b4-9487-b318677b5f81', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453294906');
INSERT INTO `e_sale_visit` VALUES ('ba51257b-eed9-4849-80d7-e1b819569e04', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '43b10a06-f46a-4816-a5cf-00eb257e6141', '1399453301437');

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
INSERT INTO `e_share` VALUES ('56621832-eb80-42e6-b034-459796447087', '肯德基的优惠幅度真大', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399453071437', '2014-05-07', null, '0', 'e162af86-f928-4ed1-8a7c-e6178d25a8d5', '1399453071437');

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
INSERT INTO `e_shop` VALUES ('6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '北清路电脑城', null, '-1400089674_1399452074181.png', '{\"address\":\"北京市海淀区北清路68号\",\"longitude\":116.242455,\"radius\":30.53333282470703,\"latitude\":40.073713}', '北京市海淀区北清路68号', '专卖电脑和书籍', null, null, '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399452076203', '1399452076125', '0', 'barcode_-509784425_1399452076140.png', '40.073713', '116.242455');
INSERT INTO `e_shop` VALUES ('b7d34ff0-21db-44df-8626-04231feb078e', '上地华联探路者专卖店', null, '463517179_1399450736650.png', '{\"address\":\"北京市海淀区北清路68号\",\"longitude\":116.242447,\"radius\":39.31818389892578,\"latitude\":40.073715}', '北京市海淀区北清路68号', '探路者旗舰店', null, null, '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399450739187', '1399450739109', '0', 'barcode_1641208558_1399450739125.png', '40.073715', '116.242447');
INSERT INTO `e_shop` VALUES ('e162af86-f928-4ed1-8a7c-e6178d25a8d5', '肯德基上地店', null, '602324364_1399449344230.png', '{\"address\":\"北京市海淀区北清路68号\",\"longitude\":116.242443,\"radius\":44.83333206176758,\"latitude\":40.073733}', '北京市海淀区北清路68号', '肯德基大品牌', '898289355_1399449344232.png', null, '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1399453683734', '1399449405468', '1', 'barcode_-1897623607_1399449405500.png', '40.073733', '116.242443');

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
INSERT INTO `e_shop_trade` VALUES ('4e768631-e9f2-4a4e-8244-6bf125085ac1', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '41', '1399452076140');
INSERT INTO `e_shop_trade` VALUES ('4f824811-d8b8-4c62-bcc3-94c0a9a15f94', '6abbacc1-aa63-4175-bd3a-4fb96abbd19f', '42', '1399452076140');
INSERT INTO `e_shop_trade` VALUES ('5b15535f-044b-490d-8363-280a1d19cb28', 'b7d34ff0-21db-44df-8626-04231feb078e', '2', '1399450739125');
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
INSERT INTO `e_user` VALUES ('5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '妞妞', '1111', '1', '13651083480', '13651083480_1399446443410.png', null, null, '1399449059578', '1399446446109');

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
INSERT INTO `e_user_profile` VALUES ('5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '5d88b4f8-1d93-4481-ba4f-1425f2dbaf2c', '1', '1', '0', '0');

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
