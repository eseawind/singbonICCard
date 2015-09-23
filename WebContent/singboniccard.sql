/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : singboniccard

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2015-09-23 14:05:19
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `authgroup`
-- ----------------------------
DROP TABLE IF EXISTS `authgroup`;
CREATE TABLE `authgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupName` varchar(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `roles` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authgroup
-- ----------------------------
INSERT INTO `authgroup` VALUES ('1', '1', '管理员', null, null);
INSERT INTO `authgroup` VALUES ('2', '1', '出纳员', null, null);
INSERT INTO `authgroup` VALUES ('3', '1', '出纳员2', '', 'ROLE_SYSTEMSETTING,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_ACCOUNTINGCENTER,');
INSERT INTO `authgroup` VALUES ('6', '1', '好', null, 'ROLE_SYSTEMSETTING,ROLE_SYSTEMPARAMETER,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_USERDEPT,ROLE_USERDEPT_ADD,ROLE_USERDEPT_EDIT,ROLE_USERDEPT_DEL,ROLE_DISCOUNT,ROLE_DISCOUNT_ADD,ROLE_DISCOUNT_EDIT,ROLE_DISCOUNT_DEL,');
INSERT INTO `authgroup` VALUES ('7', '1', '出纳员23', null, 'ffsff');
INSERT INTO `authgroup` VALUES ('8', '1', '出纳员234', null, 'ROLE_SYSTEMSETTING,ROLE_SYSTEMPARAMETER,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_USERDEPT,ROLE_USERDEPT_ADD,ROLE_USERDEPT_EDIT,ROLE_USERDEPT_DEL,ROLE_DISCOUNT,ROLE_DISCOUNT_ADD,ROLE_DISCOUNT_EDIT,ROLE_DISCOUNT_DEL,ROLE_CARDCENTER,ROLE_FUNCCARD,ROLE_CARDMANAGER,ROLE_ACCOUNTINGCENTER,');

-- ----------------------------
-- Table structure for `authusergroup`
-- ----------------------------
DROP TABLE IF EXISTS `authusergroup`;
CREATE TABLE `authusergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `groupId` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authusergroup
-- ----------------------------
INSERT INTO `authusergroup` VALUES ('1', '1', '1');
INSERT INTO `authusergroup` VALUES ('2', '1', '2');
INSERT INTO `authusergroup` VALUES ('3', '2', '3');
INSERT INTO `authusergroup` VALUES ('4', '1', '4');

-- ----------------------------
-- Table structure for `batch`
-- ----------------------------
DROP TABLE IF EXISTS `batch`;
CREATE TABLE `batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batchName` varchar(255) DEFAULT NULL,
  `beginDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `invalidDate` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of batch
-- ----------------------------
INSERT INTO `batch` VALUES ('1', '11112', '2015-05-28 00:00:00', '2015-08-28 00:00:00', '2015-10-31 00:00:00', '1');
INSERT INTO `batch` VALUES ('2', '112', '2015-05-28 00:00:00', '2015-08-29 00:00:00', '2015-10-31 00:00:00', '1');
INSERT INTO `batch` VALUES ('3', '33341', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-05-30 00:00:00', '1');
INSERT INTO `batch` VALUES ('4', '11222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-10-28 00:00:00', '1');
INSERT INTO `batch` VALUES ('5', '111', '2015-05-28 00:00:00', '2015-05-29 00:00:00', null, '1');
INSERT INTO `batch` VALUES ('6', '33341', '2015-05-07 00:00:00', '2015-05-29 00:00:00', '2015-05-30 00:00:00', '1');
INSERT INTO `batch` VALUES ('7', '11222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-16 00:00:00', '1');
INSERT INTO `batch` VALUES ('8', '11222去去去', '2015-05-28 00:00:00', '2015-05-29 00:00:00', null, '1');
INSERT INTO `batch` VALUES ('9', '112222222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');
INSERT INTO `batch` VALUES ('10', '1122222223', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');
INSERT INTO `batch` VALUES ('11', '批次n1', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');
INSERT INTO `batch` VALUES ('12', 'fdf', '2015-07-02 00:00:00', '2015-07-08 00:00:00', '2015-07-22 00:00:00', '1');
INSERT INTO `batch` VALUES ('13', '112221233', '2015-05-28 00:00:00', '2015-05-29 00:00:00', null, '1');
INSERT INTO `batch` VALUES ('14', '0731', '2015-05-28 00:00:00', '2015-08-28 00:00:00', null, '1');
INSERT INTO `batch` VALUES ('15', 'sdssfsdf', '2015-05-07 00:00:00', '2015-05-29 00:00:00', null, '1');

-- ----------------------------
-- Table structure for `cardparam`
-- ----------------------------
DROP TABLE IF EXISTS `cardparam`;
CREATE TABLE `cardparam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cardCost` int(11) DEFAULT NULL,
  `cardDeposit` int(11) DEFAULT NULL,
  `prepayFare` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cardparam
-- ----------------------------
INSERT INTO `cardparam` VALUES ('1', '1', '10', '5', '20');

-- ----------------------------
-- Table structure for `cardparambase`
-- ----------------------------
DROP TABLE IF EXISTS `cardparambase`;
CREATE TABLE `cardparambase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardCost` int(11) DEFAULT NULL,
  `cardDeposit` int(11) DEFAULT NULL,
  `prepayFare` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cardparambase
-- ----------------------------
INSERT INTO `cardparambase` VALUES ('1', '0', '0', '0');

-- ----------------------------
-- Table structure for `company`
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyName` varchar(255) DEFAULT NULL,
  `serialNumber` varchar(50) DEFAULT NULL,
  `authNumber` varchar(50) DEFAULT NULL,
  `baseSection` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('1', '1', '0312', '0371', '1');

-- ----------------------------
-- Table structure for `consume`
-- ----------------------------
DROP TABLE IF EXISTS `consume`;
CREATE TABLE `consume` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` float DEFAULT NULL,
  `uploadTime` date DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_lb6mlnq6t18p7rmq1ydclckd8` (`company_id`),
  CONSTRAINT `FK_lb6mlnq6t18p7rmq1ydclckd8` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consume
-- ----------------------------

-- ----------------------------
-- Table structure for `consumeparam`
-- ----------------------------
DROP TABLE IF EXISTS `consumeparam`;
CREATE TABLE `consumeparam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cardMinFare` int(11) DEFAULT NULL,
  `cardMinFareCardTypes` varchar(16) DEFAULT NULL,
  `dayLimitFare` int(11) DEFAULT NULL,
  `dayLimitFareCardTypes` varchar(16) DEFAULT NULL,
  `timeLimitFare` int(11) DEFAULT NULL,
  `timeLimitFareCardTypes` varchar(16) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL COMMENT '补助钱包、大钱包、先补助后大钱包',
  `userPwd` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumeparam
-- ----------------------------
INSERT INTO `consumeparam` VALUES ('1', '1', '10', ',11,14,,', '100', ',11,,', '12', ',4,14,,', '1', '88887');

-- ----------------------------
-- Table structure for `consumeparambase`
-- ----------------------------
DROP TABLE IF EXISTS `consumeparambase`;
CREATE TABLE `consumeparambase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardMinFare` int(11) DEFAULT NULL,
  `cardMinFareCardTypes` varchar(16) DEFAULT NULL,
  `dayLimitFare` int(11) DEFAULT NULL,
  `dayLimitFareCardTypes` varchar(16) DEFAULT NULL,
  `timeLimitFare` int(11) DEFAULT NULL,
  `timeLimitFareCardTypes` varchar(16) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL COMMENT '补助钱包、大钱包、先补助后大钱包',
  `userPwd` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumeparambase
-- ----------------------------
INSERT INTO `consumeparambase` VALUES ('1', '0', ',,', '0', ',,', '0', ',,', '2', '88888');

-- ----------------------------
-- Table structure for `cookbook`
-- ----------------------------
DROP TABLE IF EXISTS `cookbook`;
CREATE TABLE `cookbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cookbookCode` int(11) DEFAULT NULL,
  `cookbookName` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=842 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cookbook
-- ----------------------------
INSERT INTO `cookbook` VALUES ('1', '1', '1', '胡辣汤1', '1', null, '');
INSERT INTO `cookbook` VALUES ('2', '1', '2', '胡辣汤2', '2', null, '');
INSERT INTO `cookbook` VALUES ('3', '1', '3', '胡辣汤3', '2', null, '');
INSERT INTO `cookbook` VALUES ('4', '1', '4', '胡辣汤4', '15', null, '');
INSERT INTO `cookbook` VALUES ('5', '1', '5', '胡辣汤5', '20', null, '');
INSERT INTO `cookbook` VALUES ('6', '1', '6', '胡辣汤6', '28', null, '');
INSERT INTO `cookbook` VALUES ('7', '1', '7', '胡辣汤7', '18', null, '');
INSERT INTO `cookbook` VALUES ('8', '1', '8', '胡辣汤8', '3', null, '');
INSERT INTO `cookbook` VALUES ('9', '1', '9', '胡辣汤9', '3', null, '');
INSERT INTO `cookbook` VALUES ('10', '1', '10', '胡辣汤10', '3', null, '');
INSERT INTO `cookbook` VALUES ('11', '1', '11', '胡辣汤11', '3', null, '');
INSERT INTO `cookbook` VALUES ('12', '1', '12', '胡辣汤12', '6', null, '');
INSERT INTO `cookbook` VALUES ('13', '1', '13', '胡辣汤13', '9', null, '');
INSERT INTO `cookbook` VALUES ('14', '1', '14', '胡辣汤14', '12', null, '');
INSERT INTO `cookbook` VALUES ('15', '1', '15', '胡辣汤15', '15', null, '');
INSERT INTO `cookbook` VALUES ('16', '1', '16', '胡辣汤16', '18', null, '');
INSERT INTO `cookbook` VALUES ('17', '1', '17', '胡辣汤17', '21', null, '');
INSERT INTO `cookbook` VALUES ('18', '1', '18', '胡辣汤18', '22', null, '');
INSERT INTO `cookbook` VALUES ('19', '1', '19', '胡辣汤19', '24', null, '');
INSERT INTO `cookbook` VALUES ('20', '1', '20', '胡辣汤20', '26', null, '');
INSERT INTO `cookbook` VALUES ('21', '1', '21', '胡辣汤21', '28', null, '');
INSERT INTO `cookbook` VALUES ('22', '1', '22', '胡辣汤22', '29', null, '');
INSERT INTO `cookbook` VALUES ('23', '1', '23', '胡辣汤23', '30', null, '');
INSERT INTO `cookbook` VALUES ('24', '1', '24', '胡辣汤24', '31', null, '');
INSERT INTO `cookbook` VALUES ('25', '1', '25', '胡辣汤25', '32', null, '');
INSERT INTO `cookbook` VALUES ('26', '1', '26', '胡辣汤26', '33', null, '');
INSERT INTO `cookbook` VALUES ('27', '1', '27', '胡辣汤27', '34', null, '');
INSERT INTO `cookbook` VALUES ('28', '1', '28', '胡辣汤28', '36', null, '');
INSERT INTO `cookbook` VALUES ('29', '1', '29', '胡辣汤29', '37', null, '');
INSERT INTO `cookbook` VALUES ('30', '1', '30', '胡辣汤30', '38', null, '');
INSERT INTO `cookbook` VALUES ('31', '1', '31', '胡辣汤31', '39', null, '');
INSERT INTO `cookbook` VALUES ('32', '1', '32', '胡辣汤32', '40', null, '');
INSERT INTO `cookbook` VALUES ('33', '1', '33', '胡辣汤33', '10', null, '');
INSERT INTO `cookbook` VALUES ('34', '1', '34', '胡辣汤34', '30', null, '');
INSERT INTO `cookbook` VALUES ('35', '1', '35', '胡辣汤35', '10', null, '');
INSERT INTO `cookbook` VALUES ('36', '1', '36', '胡辣汤36', '15', null, '');
INSERT INTO `cookbook` VALUES ('37', '1', '37', '胡辣汤37', '15', null, '');
INSERT INTO `cookbook` VALUES ('38', '1', '38', '胡辣汤38', '20', null, '');
INSERT INTO `cookbook` VALUES ('39', '1', '39', '胡辣汤39', '25', null, '');
INSERT INTO `cookbook` VALUES ('40', '1', '40', '胡辣汤40', '25', null, '');
INSERT INTO `cookbook` VALUES ('41', '1', '41', '胡辣汤41', '10', null, '');
INSERT INTO `cookbook` VALUES ('42', '1', '42', '胡辣汤42', '5', null, '');
INSERT INTO `cookbook` VALUES ('43', '1', '43', '胡辣汤43', '30', null, '');
INSERT INTO `cookbook` VALUES ('44', '1', '44', '胡辣汤44', '30', null, '');
INSERT INTO `cookbook` VALUES ('45', '1', '45', '胡辣汤45', '10', null, '');
INSERT INTO `cookbook` VALUES ('46', '1', '46', '胡辣汤46', '30', null, '');
INSERT INTO `cookbook` VALUES ('47', '1', '47', '胡辣汤47', '20', null, '');
INSERT INTO `cookbook` VALUES ('48', '1', '48', '胡辣汤48', '25', null, '');
INSERT INTO `cookbook` VALUES ('49', '1', '49', '胡辣汤49', '25', null, '');
INSERT INTO `cookbook` VALUES ('50', '1', '50', '胡辣汤50', '15', null, '');
INSERT INTO `cookbook` VALUES ('51', '1', '51', '胡辣汤51', '15', null, '');
INSERT INTO `cookbook` VALUES ('52', '1', '52', '胡辣汤52', '15', null, '');
INSERT INTO `cookbook` VALUES ('53', '1', '53', '胡辣汤53', '25', null, '');
INSERT INTO `cookbook` VALUES ('54', '1', '54', '胡辣汤54', '25', null, '');
INSERT INTO `cookbook` VALUES ('55', '1', '55', '胡辣汤55', '10', null, '');
INSERT INTO `cookbook` VALUES ('56', '1', '56', '胡辣汤56', '20', null, '');
INSERT INTO `cookbook` VALUES ('57', '1', '57', '胡辣汤57', '8', null, '');
INSERT INTO `cookbook` VALUES ('58', '1', '58', '胡辣汤58', '15', null, '');
INSERT INTO `cookbook` VALUES ('59', '1', '59', '胡辣汤59', '20', null, '');
INSERT INTO `cookbook` VALUES ('60', '1', '60', '胡辣汤60', '25', null, '');
INSERT INTO `cookbook` VALUES ('61', '1', '61', '胡辣汤61', '20', null, '');
INSERT INTO `cookbook` VALUES ('62', '1', '62', '胡辣汤62', '20', null, '');
INSERT INTO `cookbook` VALUES ('63', '1', '63', '胡辣汤63', '18', null, '');
INSERT INTO `cookbook` VALUES ('64', '1', '64', '胡辣汤64', '20', null, '');
INSERT INTO `cookbook` VALUES ('65', '1', '65', '胡辣汤65', '20', null, '');
INSERT INTO `cookbook` VALUES ('66', '1', '66', '胡辣汤66', '10', null, '');
INSERT INTO `cookbook` VALUES ('67', '1', '67', '胡辣汤67', '25', null, '');
INSERT INTO `cookbook` VALUES ('68', '1', '68', '胡辣汤68', '20', null, '');
INSERT INTO `cookbook` VALUES ('69', '1', '69', '胡辣汤69', '18', null, '');
INSERT INTO `cookbook` VALUES ('70', '1', '70', '胡辣汤70', '25', null, '');
INSERT INTO `cookbook` VALUES ('71', '1', '71', '胡辣汤71', '15', null, '');
INSERT INTO `cookbook` VALUES ('72', '1', '72', '胡辣汤72', '15', null, '');
INSERT INTO `cookbook` VALUES ('73', '1', '73', '胡辣汤73', '15', null, '');
INSERT INTO `cookbook` VALUES ('74', '1', '74', '胡辣汤74', '25', null, '');
INSERT INTO `cookbook` VALUES ('75', '1', '75', '胡辣汤75', '15', null, '');
INSERT INTO `cookbook` VALUES ('76', '1', '76', '胡辣汤76', '35', null, '');
INSERT INTO `cookbook` VALUES ('77', '1', '77', '胡辣汤77', '15', null, '');
INSERT INTO `cookbook` VALUES ('78', '1', '78', '胡辣汤78', '10', null, '');
INSERT INTO `cookbook` VALUES ('79', '1', '79', '胡辣汤79', '25', null, '');
INSERT INTO `cookbook` VALUES ('80', '1', '80', '胡辣汤80', '15', null, '');
INSERT INTO `cookbook` VALUES ('81', '1', '81', '胡辣汤81', '15', null, '');
INSERT INTO `cookbook` VALUES ('82', '1', '82', '胡辣汤82', '15', null, '');
INSERT INTO `cookbook` VALUES ('83', '1', '83', '胡辣汤83', '30', null, '');
INSERT INTO `cookbook` VALUES ('84', '1', '84', '胡辣汤84', '20', null, '');
INSERT INTO `cookbook` VALUES ('85', '1', '85', '胡辣汤85', '20', null, '');
INSERT INTO `cookbook` VALUES ('86', '1', '86', '胡辣汤86', '30', null, '');
INSERT INTO `cookbook` VALUES ('87', '1', '87', '胡辣汤87', '15', null, '');
INSERT INTO `cookbook` VALUES ('88', '1', '88', '胡辣汤88', '10', null, '');
INSERT INTO `cookbook` VALUES ('89', '1', '89', '胡辣汤89', '25', null, '');
INSERT INTO `cookbook` VALUES ('90', '1', '90', '胡辣汤90', '20', null, '');
INSERT INTO `cookbook` VALUES ('91', '1', '91', '胡辣汤91', '20', null, '');
INSERT INTO `cookbook` VALUES ('92', '1', '92', '胡辣汤92', '15', null, '');
INSERT INTO `cookbook` VALUES ('93', '1', '93', '胡辣汤93', '15', null, '');
INSERT INTO `cookbook` VALUES ('94', '1', '94', '胡辣汤94', '15', null, '');
INSERT INTO `cookbook` VALUES ('95', '1', '95', '胡辣汤95', '15', null, '');
INSERT INTO `cookbook` VALUES ('96', '1', '96', '胡辣汤96', '15', null, '');
INSERT INTO `cookbook` VALUES ('97', '1', '97', '胡辣汤97', '25', null, '');
INSERT INTO `cookbook` VALUES ('98', '1', '98', '胡辣汤98', '30', null, '');
INSERT INTO `cookbook` VALUES ('99', '1', '99', '胡辣汤99', '15', null, '');
INSERT INTO `cookbook` VALUES ('100', '1', '100', '胡辣汤100', '20', null, '');
INSERT INTO `cookbook` VALUES ('101', '1', '101', '胡辣汤101', '15', null, '');
INSERT INTO `cookbook` VALUES ('102', '1', '102', '胡辣汤102', '30', null, '');
INSERT INTO `cookbook` VALUES ('103', '1', '103', '胡辣汤103', '10', null, '');
INSERT INTO `cookbook` VALUES ('104', '1', '104', '胡辣汤104', '15', null, '');
INSERT INTO `cookbook` VALUES ('105', '1', '105', '胡辣汤105', '20', null, '');
INSERT INTO `cookbook` VALUES ('106', '1', '106', '胡辣汤106', '25', null, '');
INSERT INTO `cookbook` VALUES ('107', '1', '107', '胡辣汤107', '20', null, '');
INSERT INTO `cookbook` VALUES ('108', '1', '108', '胡辣汤108', '15', null, '');
INSERT INTO `cookbook` VALUES ('109', '1', '109', '胡辣汤109', '25', null, '');
INSERT INTO `cookbook` VALUES ('110', '1', '110', '胡辣汤110', '25', null, '');
INSERT INTO `cookbook` VALUES ('111', '1', '111', '胡辣汤111', '15', null, '');
INSERT INTO `cookbook` VALUES ('112', '1', '112', '胡辣汤112', '1', null, '');
INSERT INTO `cookbook` VALUES ('113', '1', '113', '胡辣汤113', '20', null, '');
INSERT INTO `cookbook` VALUES ('114', '1', '114', '胡辣汤114', '30', null, '');
INSERT INTO `cookbook` VALUES ('115', '1', '115', '胡辣汤115', '25', null, '');
INSERT INTO `cookbook` VALUES ('116', '1', '116', '胡辣汤116', '15', null, '');
INSERT INTO `cookbook` VALUES ('117', '1', '117', '胡辣汤117', '30', null, '');
INSERT INTO `cookbook` VALUES ('118', '1', '118', '胡辣汤118', '30', null, '');
INSERT INTO `cookbook` VALUES ('119', '1', '119', '胡辣汤119', '15', null, '');
INSERT INTO `cookbook` VALUES ('120', '1', '120', '胡辣汤120', '30', null, '');
INSERT INTO `cookbook` VALUES ('121', '1', '121', '胡辣汤121', '20', null, '');
INSERT INTO `cookbook` VALUES ('122', '1', '122', '胡辣汤122', '50', null, '');
INSERT INTO `cookbook` VALUES ('123', '1', '123', '胡辣汤123', '45', null, '');
INSERT INTO `cookbook` VALUES ('124', '1', '124', '胡辣汤124', '12', null, '');
INSERT INTO `cookbook` VALUES ('125', '1', '125', '胡辣汤125', '25', null, '');
INSERT INTO `cookbook` VALUES ('126', '1', '126', '胡辣汤126', '10', null, '');
INSERT INTO `cookbook` VALUES ('127', '1', '127', '胡辣汤127', '15', null, '');
INSERT INTO `cookbook` VALUES ('128', '1', '128', '胡辣汤128', '25', null, '');
INSERT INTO `cookbook` VALUES ('129', '1', '129', '胡辣汤129', '30', null, '');
INSERT INTO `cookbook` VALUES ('130', '1', '130', '胡辣汤130', '25', null, '');
INSERT INTO `cookbook` VALUES ('131', '1', '131', '胡辣汤131', '1', null, '');
INSERT INTO `cookbook` VALUES ('132', '1', '132', '胡辣汤132', '15', null, '');
INSERT INTO `cookbook` VALUES ('133', '1', '133', '胡辣汤133', '20', null, '');
INSERT INTO `cookbook` VALUES ('134', '1', '134', '胡辣汤134', '25', null, '');
INSERT INTO `cookbook` VALUES ('135', '1', '135', '胡辣汤135', '25', null, '');
INSERT INTO `cookbook` VALUES ('136', '1', '136', '胡辣汤136', '15', null, '');
INSERT INTO `cookbook` VALUES ('137', '1', '137', '胡辣汤137', '15', null, '');
INSERT INTO `cookbook` VALUES ('138', '1', '138', '胡辣汤138', '20', null, '');
INSERT INTO `cookbook` VALUES ('139', '1', '139', '胡辣汤139', '15', null, '');
INSERT INTO `cookbook` VALUES ('140', '1', '140', '胡辣汤140', '15', null, '');
INSERT INTO `cookbook` VALUES ('141', '1', '141', '胡辣汤141', '25', null, '');
INSERT INTO `cookbook` VALUES ('142', '1', '142', '胡辣汤142', '20', null, '');
INSERT INTO `cookbook` VALUES ('143', '1', '143', '胡辣汤143', '10', null, '');
INSERT INTO `cookbook` VALUES ('144', '1', '144', '胡辣汤144', '10', null, '');
INSERT INTO `cookbook` VALUES ('145', '1', '145', '胡辣汤145', '38', null, '');
INSERT INTO `cookbook` VALUES ('146', '1', '146', '胡辣汤146', '1', null, '');
INSERT INTO `cookbook` VALUES ('147', '1', '147', '胡辣汤147', '15', null, '');
INSERT INTO `cookbook` VALUES ('148', '1', '148', '胡辣汤148', '25', null, '');
INSERT INTO `cookbook` VALUES ('149', '1', '149', '胡辣汤149', '20', null, '');
INSERT INTO `cookbook` VALUES ('150', '1', '150', '胡辣汤150', '20', null, '');
INSERT INTO `cookbook` VALUES ('151', '1', '151', '胡辣汤151', '20', null, '');
INSERT INTO `cookbook` VALUES ('152', '1', '152', '胡辣汤152', '15', null, '');
INSERT INTO `cookbook` VALUES ('153', '1', '153', '胡辣汤153', '15', null, '');
INSERT INTO `cookbook` VALUES ('154', '1', '154', '胡辣汤154', '15', null, '');
INSERT INTO `cookbook` VALUES ('155', '1', '155', '胡辣汤155', '30', null, '');
INSERT INTO `cookbook` VALUES ('156', '1', '156', '胡辣汤156', '25', null, '');
INSERT INTO `cookbook` VALUES ('157', '1', '157', '胡辣汤157', '15', null, '');
INSERT INTO `cookbook` VALUES ('158', '1', '158', '胡辣汤158', '5', null, '');
INSERT INTO `cookbook` VALUES ('159', '1', '159', '胡辣汤159', '18', null, '');
INSERT INTO `cookbook` VALUES ('160', '1', '160', '胡辣汤160', '18', null, '');
INSERT INTO `cookbook` VALUES ('161', '1', '161', '胡辣汤161', '18', null, '');
INSERT INTO `cookbook` VALUES ('162', '1', '162', '胡辣汤162', '15', null, '');
INSERT INTO `cookbook` VALUES ('163', '1', '163', '胡辣汤163', '25', null, '');
INSERT INTO `cookbook` VALUES ('164', '1', '164', '胡辣汤164', '35', null, '');
INSERT INTO `cookbook` VALUES ('165', '1', '165', '胡辣汤165', '20', null, '');
INSERT INTO `cookbook` VALUES ('166', '1', '166', '胡辣汤166', '30', null, '');
INSERT INTO `cookbook` VALUES ('167', '1', '167', '胡辣汤167', '25', null, '');
INSERT INTO `cookbook` VALUES ('168', '1', '168', '胡辣汤168', '20', null, '');
INSERT INTO `cookbook` VALUES ('169', '1', '169', '胡辣汤169', '20', null, '');
INSERT INTO `cookbook` VALUES ('170', '1', '170', '胡辣汤170', '25', null, '');
INSERT INTO `cookbook` VALUES ('171', '1', '171', '胡辣汤171', '25', null, '');
INSERT INTO `cookbook` VALUES ('172', '1', '172', '胡辣汤172', '25', null, '');
INSERT INTO `cookbook` VALUES ('173', '1', '173', '胡辣汤173', '15', null, '');
INSERT INTO `cookbook` VALUES ('174', '1', '174', '胡辣汤174', '10', null, '');
INSERT INTO `cookbook` VALUES ('175', '1', '175', '胡辣汤175', '20', null, '');
INSERT INTO `cookbook` VALUES ('176', '1', '176', '胡辣汤176', '10', null, '');
INSERT INTO `cookbook` VALUES ('177', '1', '177', '胡辣汤177', '12', null, '');
INSERT INTO `cookbook` VALUES ('178', '1', '178', '胡辣汤178', '25', null, '');
INSERT INTO `cookbook` VALUES ('179', '1', '179', '胡辣汤179', '25', null, '');
INSERT INTO `cookbook` VALUES ('180', '1', '180', '胡辣汤180', '15', null, '');
INSERT INTO `cookbook` VALUES ('181', '1', '181', '胡辣汤181', '15', null, '');
INSERT INTO `cookbook` VALUES ('182', '1', '182', '胡辣汤182', '20', null, '');
INSERT INTO `cookbook` VALUES ('183', '1', '183', '胡辣汤183', '20', null, '');
INSERT INTO `cookbook` VALUES ('184', '1', '184', '胡辣汤184', '20', null, '');
INSERT INTO `cookbook` VALUES ('185', '1', '185', '胡辣汤185', '10', null, '');
INSERT INTO `cookbook` VALUES ('186', '1', '186', '胡辣汤186', '15', null, '');
INSERT INTO `cookbook` VALUES ('187', '1', '187', '胡辣汤187', '15', null, '');
INSERT INTO `cookbook` VALUES ('188', '1', '188', '胡辣汤188', '25', null, '');
INSERT INTO `cookbook` VALUES ('189', '1', '189', '胡辣汤189', '20', null, '');
INSERT INTO `cookbook` VALUES ('190', '1', '190', '胡辣汤190', '18', null, '');
INSERT INTO `cookbook` VALUES ('191', '1', '191', '胡辣汤191', '25', null, '');
INSERT INTO `cookbook` VALUES ('192', '1', '192', '胡辣汤192', '5', null, '');
INSERT INTO `cookbook` VALUES ('193', '1', '193', '胡辣汤193', '20', null, '');
INSERT INTO `cookbook` VALUES ('194', '1', '194', '胡辣汤194', '20', null, '');
INSERT INTO `cookbook` VALUES ('195', '1', '195', '胡辣汤195', '15', null, '');
INSERT INTO `cookbook` VALUES ('196', '1', '196', '胡辣汤196', '25', null, '');
INSERT INTO `cookbook` VALUES ('197', '1', '197', '胡辣汤197', '20', null, '');
INSERT INTO `cookbook` VALUES ('198', '1', '198', '胡辣汤198', '15', null, '');
INSERT INTO `cookbook` VALUES ('199', '1', '199', '胡辣汤199', '12', null, '');
INSERT INTO `cookbook` VALUES ('200', '1', '200', '胡辣汤200', '36', null, '');
INSERT INTO `cookbook` VALUES ('201', '1', '201', '胡辣汤201', '25', null, '');
INSERT INTO `cookbook` VALUES ('202', '1', '202', '胡辣汤202', '20', null, '');
INSERT INTO `cookbook` VALUES ('203', '1', '203', '胡辣汤203', '28', null, '');
INSERT INTO `cookbook` VALUES ('204', '1', '204', '胡辣汤204', '25', null, '');
INSERT INTO `cookbook` VALUES ('205', '1', '205', '胡辣汤205', '30', null, '');
INSERT INTO `cookbook` VALUES ('206', '1', '206', '胡辣汤206', '20', null, '');
INSERT INTO `cookbook` VALUES ('207', '1', '207', '胡辣汤207', '25', null, '');
INSERT INTO `cookbook` VALUES ('208', '1', '208', '胡辣汤208', '20', null, '');
INSERT INTO `cookbook` VALUES ('209', '1', '209', '胡辣汤209', '18', null, '');
INSERT INTO `cookbook` VALUES ('210', '1', '210', '胡辣汤210', '5', null, '');
INSERT INTO `cookbook` VALUES ('211', '1', '211', '胡辣汤211', '20', null, '');
INSERT INTO `cookbook` VALUES ('212', '1', '212', '胡辣汤212', '30', null, '');
INSERT INTO `cookbook` VALUES ('213', '1', '213', '胡辣汤213', '25', null, '');
INSERT INTO `cookbook` VALUES ('214', '1', '214', '胡辣汤214', '20', null, '');
INSERT INTO `cookbook` VALUES ('215', '1', '215', '胡辣汤215', '15', null, '');
INSERT INTO `cookbook` VALUES ('216', '1', '216', '胡辣汤216', '30', null, '');
INSERT INTO `cookbook` VALUES ('217', '1', '217', '胡辣汤217', '10', null, '');
INSERT INTO `cookbook` VALUES ('218', '1', '218', '胡辣汤218', '15', null, '');
INSERT INTO `cookbook` VALUES ('219', '1', '219', '胡辣汤219', '10', null, '');
INSERT INTO `cookbook` VALUES ('220', '1', '220', '胡辣汤220', '25', null, '');
INSERT INTO `cookbook` VALUES ('221', '1', '221', '胡辣汤221', '15', null, '');
INSERT INTO `cookbook` VALUES ('222', '1', '222', '胡辣汤222', '35', null, '');
INSERT INTO `cookbook` VALUES ('223', '1', '223', '胡辣汤223', '30', null, '');
INSERT INTO `cookbook` VALUES ('224', '1', '224', '胡辣汤224', '30', null, '');
INSERT INTO `cookbook` VALUES ('225', '1', '225', '胡辣汤225', '25', null, '');
INSERT INTO `cookbook` VALUES ('226', '1', '226', '胡辣汤226', '20', null, '');
INSERT INTO `cookbook` VALUES ('227', '1', '227', '胡辣汤227', '15', null, '');
INSERT INTO `cookbook` VALUES ('228', '1', '228', '胡辣汤228', '25', null, '');
INSERT INTO `cookbook` VALUES ('229', '1', '229', '胡辣汤229', '20', null, '');
INSERT INTO `cookbook` VALUES ('230', '1', '230', '胡辣汤230', '15', null, '');
INSERT INTO `cookbook` VALUES ('231', '1', '231', '胡辣汤231', '20', null, '');
INSERT INTO `cookbook` VALUES ('232', '1', '232', '胡辣汤232', '25', null, '');
INSERT INTO `cookbook` VALUES ('233', '1', '233', '胡辣汤233', '20', null, '');
INSERT INTO `cookbook` VALUES ('234', '1', '234', '胡辣汤234', '15', null, '');
INSERT INTO `cookbook` VALUES ('235', '1', '235', '胡辣汤235', '30', null, '');
INSERT INTO `cookbook` VALUES ('236', '1', '236', '胡辣汤236', '10', null, '');
INSERT INTO `cookbook` VALUES ('237', '1', '237', '胡辣汤237', '15', null, '');
INSERT INTO `cookbook` VALUES ('238', '1', '238', '胡辣汤238', '30', null, '');
INSERT INTO `cookbook` VALUES ('239', '1', '239', '胡辣汤239', '28', null, '');
INSERT INTO `cookbook` VALUES ('240', '1', '240', '胡辣汤240', '20', null, '');
INSERT INTO `cookbook` VALUES ('241', '1', '241', '胡辣汤241', '15', null, '');
INSERT INTO `cookbook` VALUES ('242', '1', '242', '胡辣汤242', '15', null, '');
INSERT INTO `cookbook` VALUES ('243', '1', '243', '胡辣汤243', '25', null, '');
INSERT INTO `cookbook` VALUES ('244', '1', '244', '胡辣汤244', '20', null, '');
INSERT INTO `cookbook` VALUES ('245', '1', '245', '胡辣汤245', '18', null, '');
INSERT INTO `cookbook` VALUES ('246', '1', '246', '胡辣汤246', '15', null, '');
INSERT INTO `cookbook` VALUES ('247', '1', '247', '胡辣汤247', '15', null, '');
INSERT INTO `cookbook` VALUES ('248', '1', '248', '胡辣汤248', '15', null, '');
INSERT INTO `cookbook` VALUES ('249', '1', '249', '胡辣汤249', '15', null, '');
INSERT INTO `cookbook` VALUES ('250', '1', '250', '胡辣汤250', '25', null, '');
INSERT INTO `cookbook` VALUES ('251', '1', '251', '胡辣汤251', '25', null, '');
INSERT INTO `cookbook` VALUES ('252', '1', '252', '胡辣汤252', '30', null, '');
INSERT INTO `cookbook` VALUES ('253', '1', '253', '胡辣汤253', '18', null, '');
INSERT INTO `cookbook` VALUES ('254', '1', '254', '胡辣汤254', '25', null, '');
INSERT INTO `cookbook` VALUES ('255', '1', '255', '胡辣汤255', '25', null, '');
INSERT INTO `cookbook` VALUES ('256', '1', '256', '胡辣汤256', '20', null, '');
INSERT INTO `cookbook` VALUES ('257', '1', '257', '胡辣汤257', '25', null, '');
INSERT INTO `cookbook` VALUES ('258', '1', '258', '胡辣汤258', '25', null, '');
INSERT INTO `cookbook` VALUES ('259', '1', '259', '胡辣汤259', '15', null, '');
INSERT INTO `cookbook` VALUES ('260', '1', '260', '胡辣汤260', '15', null, '');
INSERT INTO `cookbook` VALUES ('261', '1', '261', '胡辣汤261', '10', null, '');
INSERT INTO `cookbook` VALUES ('262', '1', '262', '胡辣汤262', '10', null, '');
INSERT INTO `cookbook` VALUES ('263', '1', '263', '胡辣汤263', '18', null, '');
INSERT INTO `cookbook` VALUES ('264', '1', '264', '胡辣汤264', '20', null, '');
INSERT INTO `cookbook` VALUES ('265', '1', '265', '胡辣汤265', '20', null, '');
INSERT INTO `cookbook` VALUES ('266', '1', '266', '胡辣汤266', '20', null, '');
INSERT INTO `cookbook` VALUES ('267', '1', '267', '胡辣汤267', '20', null, '');
INSERT INTO `cookbook` VALUES ('268', '1', '268', '胡辣汤268', '25', null, '');
INSERT INTO `cookbook` VALUES ('269', '1', '269', '胡辣汤269', '25', null, '');
INSERT INTO `cookbook` VALUES ('270', '1', '270', '胡辣汤270', '25', null, '');
INSERT INTO `cookbook` VALUES ('271', '1', '271', '胡辣汤271', '15', null, '');
INSERT INTO `cookbook` VALUES ('272', '1', '272', '胡辣汤272', '25', null, '');
INSERT INTO `cookbook` VALUES ('273', '1', '273', '胡辣汤273', '25', null, '');
INSERT INTO `cookbook` VALUES ('274', '1', '274', '胡辣汤274', '20', null, '');
INSERT INTO `cookbook` VALUES ('275', '1', '275', '胡辣汤275', '20', null, '');
INSERT INTO `cookbook` VALUES ('276', '1', '276', '胡辣汤276', '25', null, '');
INSERT INTO `cookbook` VALUES ('277', '1', '277', '胡辣汤277', '10', null, '');
INSERT INTO `cookbook` VALUES ('278', '1', '278', '胡辣汤278', '15', null, '');
INSERT INTO `cookbook` VALUES ('279', '1', '279', '胡辣汤279', '20', null, '');
INSERT INTO `cookbook` VALUES ('280', '1', '280', '胡辣汤280', '25', null, '');
INSERT INTO `cookbook` VALUES ('281', '1', '281', '胡辣汤281', '20', null, '');
INSERT INTO `cookbook` VALUES ('282', '1', '282', '胡辣汤282', '20', null, '');
INSERT INTO `cookbook` VALUES ('283', '1', '283', '胡辣汤283', '15', null, '');
INSERT INTO `cookbook` VALUES ('284', '1', '284', '胡辣汤284', '20', null, '');
INSERT INTO `cookbook` VALUES ('285', '1', '285', '胡辣汤285', '20', null, '');
INSERT INTO `cookbook` VALUES ('286', '1', '286', '胡辣汤286', '20', null, '');
INSERT INTO `cookbook` VALUES ('287', '1', '287', '胡辣汤287', '25', null, '');
INSERT INTO `cookbook` VALUES ('288', '1', '288', '胡辣汤288', '20', null, '');
INSERT INTO `cookbook` VALUES ('289', '1', '289', '胡辣汤289', '20', null, '');
INSERT INTO `cookbook` VALUES ('290', '1', '290', '胡辣汤290', '25', null, '');
INSERT INTO `cookbook` VALUES ('291', '1', '291', '胡辣汤291', '25', null, '');
INSERT INTO `cookbook` VALUES ('292', '1', '292', '胡辣汤292', '25', null, '');
INSERT INTO `cookbook` VALUES ('293', '1', '293', '胡辣汤293', '25', null, '');
INSERT INTO `cookbook` VALUES ('294', '1', '294', '胡辣汤294', '20', null, '');
INSERT INTO `cookbook` VALUES ('295', '1', '295', '胡辣汤295', '25', null, '');
INSERT INTO `cookbook` VALUES ('296', '1', '296', '胡辣汤296', '15', null, '');
INSERT INTO `cookbook` VALUES ('297', '1', '297', '胡辣汤297', '10', null, '');
INSERT INTO `cookbook` VALUES ('298', '1', '298', '胡辣汤298', '25', null, '');
INSERT INTO `cookbook` VALUES ('299', '1', '299', '胡辣汤299', '15', null, '');
INSERT INTO `cookbook` VALUES ('300', '1', '300', '胡辣汤300', '25', null, '');
INSERT INTO `cookbook` VALUES ('301', '1', '301', '胡辣汤301', '25', null, '');
INSERT INTO `cookbook` VALUES ('302', '1', '302', '胡辣汤302', '15', null, '');
INSERT INTO `cookbook` VALUES ('303', '1', '303', '胡辣汤303', '5', null, '');
INSERT INTO `cookbook` VALUES ('304', '1', '304', '胡辣汤304', '15', null, '');
INSERT INTO `cookbook` VALUES ('305', '1', '305', '胡辣汤305', '30', null, '');
INSERT INTO `cookbook` VALUES ('306', '1', '306', '胡辣汤306', '1', null, '');
INSERT INTO `cookbook` VALUES ('307', '1', '307', '胡辣汤307', '15', null, '');
INSERT INTO `cookbook` VALUES ('308', '1', '308', '胡辣汤308', '25', null, '');
INSERT INTO `cookbook` VALUES ('309', '1', '309', '胡辣汤309', '15', null, '');
INSERT INTO `cookbook` VALUES ('310', '1', '310', '胡辣汤310', '15', null, '');
INSERT INTO `cookbook` VALUES ('311', '1', '311', '胡辣汤311', '15', null, '');
INSERT INTO `cookbook` VALUES ('312', '1', '312', '胡辣汤312', '15', null, '');
INSERT INTO `cookbook` VALUES ('313', '1', '313', '胡辣汤313', '15', null, '');
INSERT INTO `cookbook` VALUES ('314', '1', '314', '胡辣汤314', '25', null, '');
INSERT INTO `cookbook` VALUES ('315', '1', '315', '胡辣汤315', '15', null, '');
INSERT INTO `cookbook` VALUES ('316', '1', '316', '胡辣汤316', '20', null, '');
INSERT INTO `cookbook` VALUES ('317', '1', '317', '胡辣汤317', '20', null, '');
INSERT INTO `cookbook` VALUES ('318', '1', '318', '胡辣汤318', '30', null, '');
INSERT INTO `cookbook` VALUES ('319', '1', '319', '胡辣汤319', '15', null, '');
INSERT INTO `cookbook` VALUES ('320', '1', '320', '胡辣汤320', '15', null, '');
INSERT INTO `cookbook` VALUES ('321', '1', '321', '胡辣汤321', '25', null, '');
INSERT INTO `cookbook` VALUES ('322', '1', '322', '胡辣汤322', '25', null, '');
INSERT INTO `cookbook` VALUES ('323', '1', '323', '胡辣汤323', '25', null, '');
INSERT INTO `cookbook` VALUES ('324', '1', '324', '胡辣汤324', '25', null, '');
INSERT INTO `cookbook` VALUES ('325', '1', '325', '胡辣汤325', '15', null, '');
INSERT INTO `cookbook` VALUES ('326', '1', '326', '胡辣汤326', '25', null, '');
INSERT INTO `cookbook` VALUES ('327', '1', '327', '胡辣汤327', '15', null, '');
INSERT INTO `cookbook` VALUES ('328', '1', '328', '胡辣汤328', '25', null, '');
INSERT INTO `cookbook` VALUES ('329', '1', '329', '胡辣汤329', '15', null, '');
INSERT INTO `cookbook` VALUES ('330', '1', '330', '胡辣汤330', '20', null, '');
INSERT INTO `cookbook` VALUES ('331', '1', '331', '胡辣汤331', '20', null, '');
INSERT INTO `cookbook` VALUES ('332', '1', '332', '胡辣汤332', '20', null, '');
INSERT INTO `cookbook` VALUES ('333', '1', '333', '胡辣汤333', '20', null, '');
INSERT INTO `cookbook` VALUES ('334', '1', '334', '胡辣汤334', '20', null, '');
INSERT INTO `cookbook` VALUES ('335', '1', '335', '胡辣汤335', '20', null, '');
INSERT INTO `cookbook` VALUES ('336', '1', '336', '胡辣汤336', '15', null, '');
INSERT INTO `cookbook` VALUES ('337', '1', '337', '胡辣汤337', '20', null, '');
INSERT INTO `cookbook` VALUES ('338', '1', '338', '胡辣汤338', '15', null, '');
INSERT INTO `cookbook` VALUES ('339', '1', '339', '胡辣汤339', '45', null, '');
INSERT INTO `cookbook` VALUES ('340', '1', '340', '胡辣汤340', '30', null, '');
INSERT INTO `cookbook` VALUES ('341', '1', '341', '胡辣汤341', '10', null, '');
INSERT INTO `cookbook` VALUES ('342', '1', '342', '胡辣汤342', '15', null, '');
INSERT INTO `cookbook` VALUES ('343', '1', '343', '胡辣汤343', '15', null, '');
INSERT INTO `cookbook` VALUES ('344', '1', '344', '胡辣汤344', '25', null, '');
INSERT INTO `cookbook` VALUES ('345', '1', '345', '胡辣汤345', '20', null, '');
INSERT INTO `cookbook` VALUES ('346', '1', '346', '胡辣汤346', '20', null, '');
INSERT INTO `cookbook` VALUES ('347', '1', '347', '胡辣汤347', '20', null, '');
INSERT INTO `cookbook` VALUES ('348', '1', '348', '胡辣汤348', '25', null, '');
INSERT INTO `cookbook` VALUES ('349', '1', '349', '胡辣汤349', '30', null, '');
INSERT INTO `cookbook` VALUES ('350', '1', '350', '胡辣汤350', '25', null, '');
INSERT INTO `cookbook` VALUES ('351', '1', '351', '胡辣汤351', '10', null, '');
INSERT INTO `cookbook` VALUES ('352', '1', '352', '胡辣汤352', '20', null, '');
INSERT INTO `cookbook` VALUES ('353', '1', '353', '胡辣汤353', '25', null, '');
INSERT INTO `cookbook` VALUES ('354', '1', '354', '胡辣汤354', '25', null, '');
INSERT INTO `cookbook` VALUES ('355', '1', '355', '胡辣汤355', '25', null, '');
INSERT INTO `cookbook` VALUES ('356', '1', '356', '胡辣汤356', '15', null, '');
INSERT INTO `cookbook` VALUES ('357', '1', '357', '胡辣汤357', '30', null, '');
INSERT INTO `cookbook` VALUES ('358', '1', '358', '胡辣汤358', '15', null, '');
INSERT INTO `cookbook` VALUES ('359', '1', '359', '胡辣汤359', '15', null, '');
INSERT INTO `cookbook` VALUES ('360', '1', '360', '胡辣汤360', '25', null, '');
INSERT INTO `cookbook` VALUES ('361', '1', '361', '胡辣汤361', '20', null, '');
INSERT INTO `cookbook` VALUES ('362', '1', '362', '胡辣汤362', '25', null, '');
INSERT INTO `cookbook` VALUES ('363', '1', '363', '胡辣汤363', '10', null, '');
INSERT INTO `cookbook` VALUES ('364', '1', '364', '胡辣汤364', '25', null, '');
INSERT INTO `cookbook` VALUES ('365', '1', '365', '胡辣汤365', '15', null, '');
INSERT INTO `cookbook` VALUES ('366', '1', '366', '胡辣汤366', '20', null, '');
INSERT INTO `cookbook` VALUES ('367', '1', '367', '胡辣汤367', '20', null, '');
INSERT INTO `cookbook` VALUES ('368', '1', '368', '胡辣汤368', '35', null, '');
INSERT INTO `cookbook` VALUES ('369', '1', '369', '胡辣汤369', '15', null, '');
INSERT INTO `cookbook` VALUES ('370', '1', '370', '胡辣汤370', '12', null, '');
INSERT INTO `cookbook` VALUES ('371', '1', '371', '胡辣汤371', '12', null, '');
INSERT INTO `cookbook` VALUES ('372', '1', '372', '胡辣汤372', '20', null, '');
INSERT INTO `cookbook` VALUES ('373', '1', '373', '胡辣汤373', '12', null, '');
INSERT INTO `cookbook` VALUES ('374', '1', '374', '胡辣汤374', '25', null, '');
INSERT INTO `cookbook` VALUES ('375', '1', '375', '胡辣汤375', '20', null, '');
INSERT INTO `cookbook` VALUES ('376', '1', '376', '胡辣汤376', '20', null, '');
INSERT INTO `cookbook` VALUES ('377', '1', '377', '胡辣汤377', '15', null, '');
INSERT INTO `cookbook` VALUES ('378', '1', '378', '胡辣汤378', '15', null, '');
INSERT INTO `cookbook` VALUES ('379', '1', '379', '胡辣汤379', '15', null, '');
INSERT INTO `cookbook` VALUES ('380', '1', '380', '胡辣汤380', '15', null, '');
INSERT INTO `cookbook` VALUES ('381', '1', '381', '胡辣汤381', '25', null, '');
INSERT INTO `cookbook` VALUES ('382', '1', '382', '胡辣汤382', '15', null, '');
INSERT INTO `cookbook` VALUES ('383', '1', '383', '胡辣汤383', '15', null, '');
INSERT INTO `cookbook` VALUES ('384', '1', '384', '胡辣汤384', '15', null, '');
INSERT INTO `cookbook` VALUES ('385', '1', '385', '胡辣汤385', '15', null, '');
INSERT INTO `cookbook` VALUES ('386', '1', '386', '胡辣汤386', '15', null, '');
INSERT INTO `cookbook` VALUES ('387', '1', '387', '胡辣汤387', '15', null, '');
INSERT INTO `cookbook` VALUES ('388', '1', '388', '胡辣汤388', '15', null, '');
INSERT INTO `cookbook` VALUES ('389', '1', '389', '胡辣汤389', '15', null, '');
INSERT INTO `cookbook` VALUES ('390', '1', '390', '胡辣汤390', '15', null, '');
INSERT INTO `cookbook` VALUES ('391', '1', '391', '胡辣汤391', '20', null, '');
INSERT INTO `cookbook` VALUES ('392', '1', '392', '胡辣汤392', '25', null, '');
INSERT INTO `cookbook` VALUES ('393', '1', '393', '胡辣汤393', '12', null, '');
INSERT INTO `cookbook` VALUES ('394', '1', '394', '胡辣汤394', '45', null, '');
INSERT INTO `cookbook` VALUES ('395', '1', '395', '胡辣汤395', '12', null, '');
INSERT INTO `cookbook` VALUES ('396', '1', '396', '胡辣汤396', '15', null, '');
INSERT INTO `cookbook` VALUES ('397', '1', '397', '胡辣汤397', '20', null, '');
INSERT INTO `cookbook` VALUES ('398', '1', '398', '胡辣汤398', '15', null, '');
INSERT INTO `cookbook` VALUES ('399', '1', '399', '胡辣汤399', '15', null, '');
INSERT INTO `cookbook` VALUES ('400', '1', '400', '胡辣汤400', '25', null, '');
INSERT INTO `cookbook` VALUES ('401', '1', '401', '胡辣汤401', '25', null, '');
INSERT INTO `cookbook` VALUES ('402', '1', '402', '胡辣汤402', '25', null, '');
INSERT INTO `cookbook` VALUES ('403', '1', '403', '胡辣汤403', '25', null, '');
INSERT INTO `cookbook` VALUES ('404', '1', '404', '胡辣汤404', '20', null, '');
INSERT INTO `cookbook` VALUES ('405', '1', '405', '胡辣汤405', '20', null, '');
INSERT INTO `cookbook` VALUES ('406', '1', '406', '胡辣汤406', '20', null, '');
INSERT INTO `cookbook` VALUES ('407', '1', '407', '胡辣汤407', '25', null, '');
INSERT INTO `cookbook` VALUES ('408', '1', '408', '胡辣汤408', '15', null, '');
INSERT INTO `cookbook` VALUES ('409', '1', '409', '胡辣汤409', '15', null, '');
INSERT INTO `cookbook` VALUES ('410', '1', '410', '胡辣汤410', '15', null, '');
INSERT INTO `cookbook` VALUES ('411', '1', '411', '胡辣汤411', '15', null, '');
INSERT INTO `cookbook` VALUES ('412', '1', '412', '胡辣汤412', '20', null, '');
INSERT INTO `cookbook` VALUES ('413', '1', '413', '胡辣汤413', '15', null, '');
INSERT INTO `cookbook` VALUES ('414', '1', '414', '胡辣汤414', '15', null, '');
INSERT INTO `cookbook` VALUES ('415', '1', '415', '胡辣汤415', '15', null, '');
INSERT INTO `cookbook` VALUES ('416', '1', '416', '胡辣汤416', '15', null, '');
INSERT INTO `cookbook` VALUES ('417', '1', '417', '胡辣汤417', '15', null, '');
INSERT INTO `cookbook` VALUES ('418', '1', '418', '胡辣汤418', '15', null, '');
INSERT INTO `cookbook` VALUES ('419', '1', '419', '胡辣汤419', '15', null, '');
INSERT INTO `cookbook` VALUES ('420', '1', '420', '胡辣汤420', '15', null, '');
INSERT INTO `cookbook` VALUES ('421', '1', '421', '胡辣汤421', '15', null, '');
INSERT INTO `cookbook` VALUES ('422', '1', '422', '胡辣汤422', '15', null, '');
INSERT INTO `cookbook` VALUES ('423', '1', '423', '胡辣汤423', '15', null, '');
INSERT INTO `cookbook` VALUES ('424', '1', '424', '胡辣汤424', '15', null, '');
INSERT INTO `cookbook` VALUES ('425', '1', '425', '胡辣汤425', '15', null, '');
INSERT INTO `cookbook` VALUES ('426', '1', '426', '胡辣汤426', '15', null, '');
INSERT INTO `cookbook` VALUES ('427', '1', '427', '胡辣汤427', '15', null, '');
INSERT INTO `cookbook` VALUES ('428', '1', '428', '胡辣汤428', '15', null, '');
INSERT INTO `cookbook` VALUES ('429', '1', '429', '胡辣汤429', '15', null, '');
INSERT INTO `cookbook` VALUES ('430', '1', '430', '胡辣汤430', '10', null, '');
INSERT INTO `cookbook` VALUES ('431', '1', '431', '胡辣汤431', '15', null, '');
INSERT INTO `cookbook` VALUES ('432', '1', '432', '胡辣汤432', '20', null, '');
INSERT INTO `cookbook` VALUES ('433', '1', '433', '胡辣汤433', '15', null, '');
INSERT INTO `cookbook` VALUES ('434', '1', '434', '胡辣汤434', '25', null, '');
INSERT INTO `cookbook` VALUES ('435', '1', '435', '胡辣汤435', '5', null, '');
INSERT INTO `cookbook` VALUES ('436', '1', '436', '胡辣汤436', '1', null, '');
INSERT INTO `cookbook` VALUES ('437', '1', '437', '胡辣汤437', '18', null, '');
INSERT INTO `cookbook` VALUES ('438', '1', '438', '胡辣汤438', '25', null, '');
INSERT INTO `cookbook` VALUES ('439', '1', '439', '胡辣汤439', '15', null, '');
INSERT INTO `cookbook` VALUES ('440', '1', '440', '胡辣汤440', '20', null, '');
INSERT INTO `cookbook` VALUES ('441', '1', '441', '胡辣汤441', '30', null, '');
INSERT INTO `cookbook` VALUES ('442', '1', '442', '胡辣汤442', '20', null, '');
INSERT INTO `cookbook` VALUES ('443', '1', '443', '胡辣汤443', '20', null, '');
INSERT INTO `cookbook` VALUES ('444', '1', '444', '胡辣汤444', '10', null, '');
INSERT INTO `cookbook` VALUES ('445', '1', '445', '胡辣汤445', '20', null, '');
INSERT INTO `cookbook` VALUES ('446', '1', '446', '胡辣汤446', '25', null, '');
INSERT INTO `cookbook` VALUES ('447', '1', '447', '胡辣汤447', '15', null, '');
INSERT INTO `cookbook` VALUES ('448', '1', '448', '胡辣汤448', '20', null, '');
INSERT INTO `cookbook` VALUES ('449', '1', '449', '胡辣汤449', '15', null, '');
INSERT INTO `cookbook` VALUES ('450', '1', '450', '胡辣汤450', '25', null, '');
INSERT INTO `cookbook` VALUES ('451', '1', '451', '胡辣汤451', '15', null, '');
INSERT INTO `cookbook` VALUES ('452', '1', '452', '胡辣汤452', '20', null, '');
INSERT INTO `cookbook` VALUES ('453', '1', '453', '胡辣汤453', '40', null, '');
INSERT INTO `cookbook` VALUES ('454', '1', '454', '胡辣汤454', '15', null, '');
INSERT INTO `cookbook` VALUES ('455', '1', '455', '胡辣汤455', '20', null, '');
INSERT INTO `cookbook` VALUES ('456', '1', '456', '胡辣汤456', '45', null, '');
INSERT INTO `cookbook` VALUES ('457', '1', '457', '胡辣汤457', '20', null, '');
INSERT INTO `cookbook` VALUES ('458', '1', '458', '胡辣汤458', '12', null, '');
INSERT INTO `cookbook` VALUES ('459', '1', '459', '胡辣汤459', '20', null, '');
INSERT INTO `cookbook` VALUES ('460', '1', '460', '胡辣汤460', '15', null, '');
INSERT INTO `cookbook` VALUES ('461', '1', '461', '胡辣汤461', '20', null, '');
INSERT INTO `cookbook` VALUES ('462', '1', '462', '胡辣汤462', '15', null, '');
INSERT INTO `cookbook` VALUES ('463', '1', '463', '胡辣汤463', '10', null, '');
INSERT INTO `cookbook` VALUES ('464', '1', '464', '胡辣汤464', '10', null, '');
INSERT INTO `cookbook` VALUES ('465', '1', '465', '胡辣汤465', '10', null, '');
INSERT INTO `cookbook` VALUES ('466', '1', '466', '胡辣汤466', '25', null, '');
INSERT INTO `cookbook` VALUES ('467', '1', '467', '胡辣汤467', '20', null, '');
INSERT INTO `cookbook` VALUES ('468', '1', '468', '胡辣汤468', '15', null, '');
INSERT INTO `cookbook` VALUES ('469', '1', '469', '胡辣汤469', '20', null, '');
INSERT INTO `cookbook` VALUES ('470', '1', '470', '胡辣汤470', '1', null, '');
INSERT INTO `cookbook` VALUES ('471', '1', '471', '胡辣汤471', '30', null, '');
INSERT INTO `cookbook` VALUES ('472', '1', '472', '胡辣汤472', '10', null, '');
INSERT INTO `cookbook` VALUES ('473', '1', '473', '胡辣汤473', '15', null, '');
INSERT INTO `cookbook` VALUES ('474', '1', '474', '胡辣汤474', '20', null, '');
INSERT INTO `cookbook` VALUES ('475', '1', '475', '胡辣汤475', '20', null, '');
INSERT INTO `cookbook` VALUES ('476', '1', '476', '胡辣汤476', '25', null, '');
INSERT INTO `cookbook` VALUES ('477', '1', '477', '胡辣汤477', '15', null, '');
INSERT INTO `cookbook` VALUES ('478', '1', '478', '胡辣汤478', '15', null, '');
INSERT INTO `cookbook` VALUES ('479', '1', '479', '胡辣汤479', '25', null, '');
INSERT INTO `cookbook` VALUES ('480', '1', '480', '胡辣汤480', '15', null, '');
INSERT INTO `cookbook` VALUES ('481', '1', '481', '胡辣汤481', '18', null, '');
INSERT INTO `cookbook` VALUES ('482', '1', '482', '胡辣汤482', '5', null, '');
INSERT INTO `cookbook` VALUES ('483', '1', '483', '胡辣汤483', '15', null, '');
INSERT INTO `cookbook` VALUES ('484', '1', '484', '胡辣汤484', '15', null, '');
INSERT INTO `cookbook` VALUES ('485', '1', '485', '胡辣汤485', '20', null, '');
INSERT INTO `cookbook` VALUES ('486', '1', '486', '胡辣汤486', '25', null, '');
INSERT INTO `cookbook` VALUES ('487', '1', '487', '胡辣汤487', '15', null, '');
INSERT INTO `cookbook` VALUES ('488', '1', '488', '胡辣汤488', '15', null, '');
INSERT INTO `cookbook` VALUES ('489', '1', '489', '胡辣汤489', '25', null, '');
INSERT INTO `cookbook` VALUES ('490', '1', '490', '胡辣汤490', '25', null, '');
INSERT INTO `cookbook` VALUES ('491', '1', '491', '胡辣汤491', '15', null, '');
INSERT INTO `cookbook` VALUES ('492', '1', '492', '胡辣汤492', '20', null, '');
INSERT INTO `cookbook` VALUES ('493', '1', '493', '胡辣汤493', '25', null, '');
INSERT INTO `cookbook` VALUES ('494', '1', '494', '胡辣汤494', '35', null, '');
INSERT INTO `cookbook` VALUES ('495', '1', '495', '胡辣汤495', '25', null, '');
INSERT INTO `cookbook` VALUES ('496', '1', '496', '胡辣汤496', '20', null, '');
INSERT INTO `cookbook` VALUES ('497', '1', '497', '胡辣汤497', '20', null, '');
INSERT INTO `cookbook` VALUES ('498', '1', '498', '胡辣汤498', '15', null, '');
INSERT INTO `cookbook` VALUES ('499', '1', '499', '胡辣汤499', '10', null, '');
INSERT INTO `cookbook` VALUES ('500', '1', '500', '胡辣汤500', '20', null, '');
INSERT INTO `cookbook` VALUES ('501', '1', '501', '胡辣汤501', '20', null, '');
INSERT INTO `cookbook` VALUES ('502', '1', '502', '胡辣汤502', '15', null, '');
INSERT INTO `cookbook` VALUES ('503', '1', '503', '胡辣汤503', '15', null, '');
INSERT INTO `cookbook` VALUES ('504', '1', '504', '胡辣汤504', '30', null, '');
INSERT INTO `cookbook` VALUES ('505', '1', '505', '胡辣汤505', '10', null, '');
INSERT INTO `cookbook` VALUES ('506', '1', '506', '胡辣汤506', '20', null, '');
INSERT INTO `cookbook` VALUES ('507', '1', '507', '胡辣汤507', '15', null, '');
INSERT INTO `cookbook` VALUES ('508', '1', '508', '胡辣汤508', '25', null, '');
INSERT INTO `cookbook` VALUES ('509', '1', '509', '胡辣汤509', '15', null, '');
INSERT INTO `cookbook` VALUES ('510', '1', '510', '胡辣汤510', '15', null, '');
INSERT INTO `cookbook` VALUES ('511', '1', '511', '胡辣汤511', '15', null, '');
INSERT INTO `cookbook` VALUES ('512', '1', '512', '胡辣汤512', '15', null, '');
INSERT INTO `cookbook` VALUES ('513', '1', '513', '胡辣汤513', '15', null, '');
INSERT INTO `cookbook` VALUES ('514', '1', '514', '胡辣汤514', '20', null, '');
INSERT INTO `cookbook` VALUES ('515', '1', '515', '胡辣汤515', '15', null, '');
INSERT INTO `cookbook` VALUES ('516', '1', '516', '胡辣汤516', '30', null, '');
INSERT INTO `cookbook` VALUES ('517', '1', '517', '胡辣汤517', '15', null, '');
INSERT INTO `cookbook` VALUES ('518', '1', '518', '胡辣汤518', '15', null, '');
INSERT INTO `cookbook` VALUES ('519', '1', '519', '胡辣汤519', '25', null, '');
INSERT INTO `cookbook` VALUES ('520', '1', '520', '胡辣汤520', '15', null, '');
INSERT INTO `cookbook` VALUES ('521', '1', '521', '胡辣汤521', '15', null, '');
INSERT INTO `cookbook` VALUES ('522', '1', '522', '胡辣汤522', '25', null, '');
INSERT INTO `cookbook` VALUES ('523', '1', '523', '胡辣汤523', '15', null, '');
INSERT INTO `cookbook` VALUES ('524', '1', '524', '胡辣汤524', '15', null, '');
INSERT INTO `cookbook` VALUES ('525', '1', '525', '胡辣汤525', '15', null, '');
INSERT INTO `cookbook` VALUES ('526', '1', '526', '胡辣汤526', '5', null, '');
INSERT INTO `cookbook` VALUES ('527', '1', '527', '胡辣汤527', '10', null, '');
INSERT INTO `cookbook` VALUES ('528', '1', '528', '胡辣汤528', '10', null, '');
INSERT INTO `cookbook` VALUES ('529', '1', '529', '胡辣汤529', '20', null, '');
INSERT INTO `cookbook` VALUES ('530', '1', '530', '胡辣汤530', '20', null, '');
INSERT INTO `cookbook` VALUES ('531', '1', '531', '胡辣汤531', '15', null, '');
INSERT INTO `cookbook` VALUES ('532', '1', '532', '胡辣汤532', '18', null, '');
INSERT INTO `cookbook` VALUES ('533', '1', '533', '胡辣汤533', '15', null, '');
INSERT INTO `cookbook` VALUES ('534', '1', '534', '胡辣汤534', '20', null, '');
INSERT INTO `cookbook` VALUES ('535', '1', '535', '胡辣汤535', '20', null, '');
INSERT INTO `cookbook` VALUES ('536', '1', '536', '胡辣汤536', '15', null, '');
INSERT INTO `cookbook` VALUES ('537', '1', '537', '胡辣汤537', '20', null, '');
INSERT INTO `cookbook` VALUES ('538', '1', '538', '胡辣汤538', '25', null, '');
INSERT INTO `cookbook` VALUES ('539', '1', '539', '胡辣汤539', '15', null, '');
INSERT INTO `cookbook` VALUES ('540', '1', '540', '胡辣汤540', '15', null, '');
INSERT INTO `cookbook` VALUES ('541', '1', '541', '胡辣汤541', '20', null, '');
INSERT INTO `cookbook` VALUES ('542', '1', '542', '胡辣汤542', '15', null, '');
INSERT INTO `cookbook` VALUES ('543', '1', '543', '胡辣汤543', '15', null, '');
INSERT INTO `cookbook` VALUES ('544', '1', '544', '胡辣汤544', '25', null, '');
INSERT INTO `cookbook` VALUES ('545', '1', '545', '胡辣汤545', '15', null, '');
INSERT INTO `cookbook` VALUES ('546', '1', '546', '胡辣汤546', '15', null, '');
INSERT INTO `cookbook` VALUES ('547', '1', '547', '胡辣汤547', '15', null, '');
INSERT INTO `cookbook` VALUES ('548', '1', '548', '胡辣汤548', '25', null, '');
INSERT INTO `cookbook` VALUES ('549', '1', '549', '胡辣汤549', '15', null, '');
INSERT INTO `cookbook` VALUES ('550', '1', '550', '胡辣汤550', '30', null, '');
INSERT INTO `cookbook` VALUES ('551', '1', '551', '胡辣汤551', '15', null, '');
INSERT INTO `cookbook` VALUES ('552', '1', '552', '胡辣汤552', '15', null, '');
INSERT INTO `cookbook` VALUES ('553', '1', '553', '胡辣汤553', '15', null, '');
INSERT INTO `cookbook` VALUES ('554', '1', '554', '胡辣汤554', '15', null, '');
INSERT INTO `cookbook` VALUES ('555', '1', '555', '胡辣汤555', '15', null, '');
INSERT INTO `cookbook` VALUES ('556', '1', '556', '胡辣汤556', '10', null, '');
INSERT INTO `cookbook` VALUES ('557', '1', '557', '胡辣汤557', '15', null, '');
INSERT INTO `cookbook` VALUES ('558', '1', '558', '胡辣汤558', '25', null, '');
INSERT INTO `cookbook` VALUES ('559', '1', '559', '胡辣汤559', '20', null, '');
INSERT INTO `cookbook` VALUES ('560', '1', '560', '胡辣汤560', '20', null, '');
INSERT INTO `cookbook` VALUES ('561', '1', '561', '胡辣汤561', '20', null, '');
INSERT INTO `cookbook` VALUES ('562', '1', '562', '胡辣汤562', '30', null, '');
INSERT INTO `cookbook` VALUES ('563', '1', '563', '胡辣汤563', '15', null, '');
INSERT INTO `cookbook` VALUES ('564', '1', '564', '胡辣汤564', '20', null, '');
INSERT INTO `cookbook` VALUES ('565', '1', '565', '胡辣汤565', '25', null, '');
INSERT INTO `cookbook` VALUES ('566', '1', '566', '胡辣汤566', '25', null, '');
INSERT INTO `cookbook` VALUES ('567', '1', '567', '胡辣汤567', '20', null, '');
INSERT INTO `cookbook` VALUES ('568', '1', '568', '胡辣汤568', '1', null, '');
INSERT INTO `cookbook` VALUES ('569', '1', '569', '胡辣汤569', '20', null, '');
INSERT INTO `cookbook` VALUES ('570', '1', '570', '胡辣汤570', '25', null, '');
INSERT INTO `cookbook` VALUES ('571', '1', '571', '胡辣汤571', '25', null, '');
INSERT INTO `cookbook` VALUES ('572', '1', '572', '胡辣汤572', '20', null, '');
INSERT INTO `cookbook` VALUES ('573', '1', '573', '胡辣汤573', '20', null, '');
INSERT INTO `cookbook` VALUES ('574', '1', '574', '胡辣汤574', '25', null, '');
INSERT INTO `cookbook` VALUES ('575', '1', '575', '胡辣汤575', '20', null, '');
INSERT INTO `cookbook` VALUES ('576', '1', '576', '胡辣汤576', '25', null, '');
INSERT INTO `cookbook` VALUES ('577', '1', '577', '胡辣汤577', '15', null, '');
INSERT INTO `cookbook` VALUES ('578', '1', '578', '胡辣汤578', '10', null, '');
INSERT INTO `cookbook` VALUES ('579', '1', '579', '胡辣汤579', '25', null, '');
INSERT INTO `cookbook` VALUES ('580', '1', '580', '胡辣汤580', '30', null, '');
INSERT INTO `cookbook` VALUES ('581', '1', '581', '胡辣汤581', '30', null, '');
INSERT INTO `cookbook` VALUES ('582', '1', '582', '胡辣汤582', '20', null, '');
INSERT INTO `cookbook` VALUES ('583', '1', '583', '胡辣汤583', '15', null, '');
INSERT INTO `cookbook` VALUES ('584', '1', '584', '胡辣汤584', '25', null, '');
INSERT INTO `cookbook` VALUES ('585', '1', '585', '胡辣汤585', '30', null, '');
INSERT INTO `cookbook` VALUES ('586', '1', '586', '胡辣汤586', '25', null, '');
INSERT INTO `cookbook` VALUES ('587', '1', '587', '胡辣汤587', '15', null, '');
INSERT INTO `cookbook` VALUES ('588', '1', '588', '胡辣汤588', '25', null, '');
INSERT INTO `cookbook` VALUES ('589', '1', '589', '胡辣汤589', '20', null, '');
INSERT INTO `cookbook` VALUES ('590', '1', '590', '胡辣汤590', '45', null, '');
INSERT INTO `cookbook` VALUES ('591', '1', '591', '胡辣汤591', '15', null, '');
INSERT INTO `cookbook` VALUES ('592', '1', '592', '胡辣汤592', '25', null, '');
INSERT INTO `cookbook` VALUES ('593', '1', '593', '胡辣汤593', '15', null, '');
INSERT INTO `cookbook` VALUES ('594', '1', '594', '胡辣汤594', '38', null, '');
INSERT INTO `cookbook` VALUES ('595', '1', '595', '胡辣汤595', '20', null, '');
INSERT INTO `cookbook` VALUES ('596', '1', '596', '胡辣汤596', '20', null, '');
INSERT INTO `cookbook` VALUES ('597', '1', '597', '胡辣汤597', '20', null, '');
INSERT INTO `cookbook` VALUES ('598', '1', '598', '胡辣汤598', '20', null, '');
INSERT INTO `cookbook` VALUES ('599', '1', '599', '胡辣汤599', '20', null, '');
INSERT INTO `cookbook` VALUES ('600', '1', '600', '胡辣汤600', '25', null, '');
INSERT INTO `cookbook` VALUES ('601', '1', '601', '胡辣汤601', '30', null, '');
INSERT INTO `cookbook` VALUES ('602', '1', '602', '胡辣汤602', '10', null, '');
INSERT INTO `cookbook` VALUES ('603', '1', '603', '胡辣汤603', '20', null, '');
INSERT INTO `cookbook` VALUES ('604', '1', '604', '胡辣汤604', '50', null, '');
INSERT INTO `cookbook` VALUES ('605', '1', '605', '胡辣汤605', '20', null, '');
INSERT INTO `cookbook` VALUES ('606', '1', '606', '胡辣汤606', '12', null, '');
INSERT INTO `cookbook` VALUES ('607', '1', '607', '胡辣汤607', '1', null, '');
INSERT INTO `cookbook` VALUES ('608', '1', '608', '胡辣汤608', '25', null, '');
INSERT INTO `cookbook` VALUES ('609', '1', '609', '胡辣汤609', '35', null, '');
INSERT INTO `cookbook` VALUES ('610', '1', '610', '胡辣汤610', '25', null, '');
INSERT INTO `cookbook` VALUES ('611', '1', '611', '胡辣汤611', '15', null, '');
INSERT INTO `cookbook` VALUES ('612', '1', '612', '胡辣汤612', '25', null, '');
INSERT INTO `cookbook` VALUES ('613', '1', '613', '胡辣汤613', '25', null, '');
INSERT INTO `cookbook` VALUES ('614', '1', '614', '胡辣汤614', '10', null, '');
INSERT INTO `cookbook` VALUES ('615', '1', '615', '胡辣汤615', '10', null, '');
INSERT INTO `cookbook` VALUES ('616', '1', '616', '胡辣汤616', '25', null, '');
INSERT INTO `cookbook` VALUES ('617', '1', '617', '胡辣汤617', '15', null, '');
INSERT INTO `cookbook` VALUES ('618', '1', '618', '胡辣汤618', '10', null, '');
INSERT INTO `cookbook` VALUES ('619', '1', '619', '胡辣汤619', '25', null, '');
INSERT INTO `cookbook` VALUES ('620', '1', '620', '胡辣汤620', '15', null, '');
INSERT INTO `cookbook` VALUES ('621', '1', '621', '胡辣汤621', '15', null, '');
INSERT INTO `cookbook` VALUES ('622', '1', '622', '胡辣汤622', '15', null, '');
INSERT INTO `cookbook` VALUES ('623', '1', '623', '胡辣汤623', '20', null, '');
INSERT INTO `cookbook` VALUES ('624', '1', '624', '胡辣汤624', '45', null, '');
INSERT INTO `cookbook` VALUES ('625', '1', '625', '胡辣汤625', '20', null, '');
INSERT INTO `cookbook` VALUES ('626', '1', '626', '胡辣汤626', '35', null, '');
INSERT INTO `cookbook` VALUES ('627', '1', '627', '胡辣汤627', '15', null, '');
INSERT INTO `cookbook` VALUES ('628', '1', '628', '胡辣汤628', '15', null, '');
INSERT INTO `cookbook` VALUES ('629', '1', '629', '胡辣汤629', '10', null, '');
INSERT INTO `cookbook` VALUES ('630', '1', '630', '胡辣汤630', '20', null, '');
INSERT INTO `cookbook` VALUES ('631', '1', '631', '胡辣汤631', '30', null, '');
INSERT INTO `cookbook` VALUES ('632', '1', '632', '胡辣汤632', '30', null, '');
INSERT INTO `cookbook` VALUES ('633', '1', '633', '胡辣汤633', '10', null, '');
INSERT INTO `cookbook` VALUES ('634', '1', '634', '胡辣汤634', '1', null, '');
INSERT INTO `cookbook` VALUES ('635', '1', '635', '胡辣汤635', '18', null, '');
INSERT INTO `cookbook` VALUES ('636', '1', '636', '胡辣汤636', '20', null, '');
INSERT INTO `cookbook` VALUES ('637', '1', '637', '胡辣汤637', '20', null, '');
INSERT INTO `cookbook` VALUES ('638', '1', '638', '胡辣汤638', '25', null, '');
INSERT INTO `cookbook` VALUES ('639', '1', '639', '胡辣汤639', '15', null, '');
INSERT INTO `cookbook` VALUES ('640', '1', '640', '胡辣汤640', '20', null, '');
INSERT INTO `cookbook` VALUES ('641', '1', '641', '胡辣汤641', '20', null, '');
INSERT INTO `cookbook` VALUES ('642', '1', '642', '胡辣汤642', '20', null, '');
INSERT INTO `cookbook` VALUES ('643', '1', '643', '胡辣汤643', '20', null, '');
INSERT INTO `cookbook` VALUES ('644', '1', '644', '胡辣汤644', '20', null, '');
INSERT INTO `cookbook` VALUES ('645', '1', '645', '胡辣汤645', '15', null, '');
INSERT INTO `cookbook` VALUES ('646', '1', '646', '胡辣汤646', '15', null, '');
INSERT INTO `cookbook` VALUES ('647', '1', '647', '胡辣汤647', '25', null, '');
INSERT INTO `cookbook` VALUES ('648', '1', '648', '胡辣汤648', '20', null, '');
INSERT INTO `cookbook` VALUES ('649', '1', '649', '胡辣汤649', '8', null, '');
INSERT INTO `cookbook` VALUES ('650', '1', '650', '胡辣汤650', '15', null, '');
INSERT INTO `cookbook` VALUES ('651', '1', '651', '胡辣汤651', '20', null, '');
INSERT INTO `cookbook` VALUES ('652', '1', '652', '胡辣汤652', '25', null, '');
INSERT INTO `cookbook` VALUES ('653', '1', '653', '胡辣汤653', '15', null, '');
INSERT INTO `cookbook` VALUES ('654', '1', '654', '胡辣汤654', '15', null, '');
INSERT INTO `cookbook` VALUES ('655', '1', '655', '胡辣汤655', '20', null, '');
INSERT INTO `cookbook` VALUES ('656', '1', '656', '胡辣汤656', '20', null, '');
INSERT INTO `cookbook` VALUES ('657', '1', '657', '胡辣汤657', '15', null, '');
INSERT INTO `cookbook` VALUES ('658', '1', '658', '胡辣汤658', '15', null, '');
INSERT INTO `cookbook` VALUES ('659', '1', '659', '胡辣汤659', '30', null, '');
INSERT INTO `cookbook` VALUES ('660', '1', '660', '胡辣汤660', '20', null, '');
INSERT INTO `cookbook` VALUES ('661', '1', '661', '胡辣汤661', '25', null, '');
INSERT INTO `cookbook` VALUES ('662', '1', '662', '胡辣汤662', '40', null, '');
INSERT INTO `cookbook` VALUES ('663', '1', '663', '胡辣汤663', '20', null, '');
INSERT INTO `cookbook` VALUES ('664', '1', '664', '胡辣汤664', '10', null, '');
INSERT INTO `cookbook` VALUES ('665', '1', '665', '胡辣汤665', '30', null, '');
INSERT INTO `cookbook` VALUES ('666', '1', '666', '胡辣汤666', '15', null, '');
INSERT INTO `cookbook` VALUES ('667', '1', '667', '胡辣汤667', '28', null, '');
INSERT INTO `cookbook` VALUES ('668', '1', '668', '胡辣汤668', '40', null, '');
INSERT INTO `cookbook` VALUES ('669', '1', '669', '胡辣汤669', '20', null, '');
INSERT INTO `cookbook` VALUES ('670', '1', '670', '胡辣汤670', '20', null, '');
INSERT INTO `cookbook` VALUES ('671', '1', '671', '胡辣汤671', '25', null, '');
INSERT INTO `cookbook` VALUES ('672', '1', '672', '胡辣汤672', '15', null, '');
INSERT INTO `cookbook` VALUES ('673', '1', '673', '胡辣汤673', '15', null, '');
INSERT INTO `cookbook` VALUES ('674', '1', '674', '胡辣汤674', '15', null, '');
INSERT INTO `cookbook` VALUES ('675', '1', '675', '胡辣汤675', '30', null, '');
INSERT INTO `cookbook` VALUES ('676', '1', '676', '胡辣汤676', '10', null, '');
INSERT INTO `cookbook` VALUES ('677', '1', '677', '胡辣汤677', '30', null, '');
INSERT INTO `cookbook` VALUES ('678', '1', '678', '胡辣汤678', '40', null, '');
INSERT INTO `cookbook` VALUES ('679', '1', '679', '胡辣汤679', '30', null, '');
INSERT INTO `cookbook` VALUES ('680', '1', '680', '胡辣汤680', '15', null, '');
INSERT INTO `cookbook` VALUES ('681', '1', '681', '胡辣汤681', '15', null, '');
INSERT INTO `cookbook` VALUES ('682', '1', '682', '胡辣汤682', '30', null, '');
INSERT INTO `cookbook` VALUES ('683', '1', '683', '胡辣汤683', '15', null, '');
INSERT INTO `cookbook` VALUES ('684', '1', '684', '胡辣汤684', '20', null, '');
INSERT INTO `cookbook` VALUES ('685', '1', '685', '胡辣汤685', '20', null, '');
INSERT INTO `cookbook` VALUES ('686', '1', '686', '胡辣汤686', '20', null, '');
INSERT INTO `cookbook` VALUES ('687', '1', '687', '胡辣汤687', '15', null, '');
INSERT INTO `cookbook` VALUES ('688', '1', '688', '胡辣汤688', '10', null, '');
INSERT INTO `cookbook` VALUES ('689', '1', '689', '胡辣汤689', '10', null, '');
INSERT INTO `cookbook` VALUES ('690', '1', '690', '胡辣汤690', '25', null, '');
INSERT INTO `cookbook` VALUES ('691', '1', '691', '胡辣汤691', '25', null, '');
INSERT INTO `cookbook` VALUES ('692', '1', '692', '胡辣汤692', '25', null, '');
INSERT INTO `cookbook` VALUES ('693', '1', '693', '胡辣汤693', '25', null, '');
INSERT INTO `cookbook` VALUES ('694', '1', '694', '胡辣汤694', '25', null, '');
INSERT INTO `cookbook` VALUES ('695', '1', '695', '胡辣汤695', '25', null, '');
INSERT INTO `cookbook` VALUES ('696', '1', '696', '胡辣汤696', '15', null, '');
INSERT INTO `cookbook` VALUES ('697', '1', '697', '胡辣汤697', '25', null, '');
INSERT INTO `cookbook` VALUES ('698', '1', '698', '胡辣汤698', '25', null, '');
INSERT INTO `cookbook` VALUES ('699', '1', '699', '胡辣汤699', '25', null, '');
INSERT INTO `cookbook` VALUES ('700', '1', '700', '胡辣汤700', '25', null, '');
INSERT INTO `cookbook` VALUES ('701', '1', '701', '胡辣汤701', '25', null, '');
INSERT INTO `cookbook` VALUES ('702', '1', '702', '胡辣汤702', '25', null, '');
INSERT INTO `cookbook` VALUES ('703', '1', '703', '胡辣汤703', '25', null, '');
INSERT INTO `cookbook` VALUES ('704', '1', '704', '胡辣汤704', '25', null, '');
INSERT INTO `cookbook` VALUES ('705', '1', '705', '胡辣汤705', '25', null, '');
INSERT INTO `cookbook` VALUES ('706', '1', '706', '胡辣汤706', '25', null, '');
INSERT INTO `cookbook` VALUES ('707', '1', '707', '胡辣汤707', '25', null, '');
INSERT INTO `cookbook` VALUES ('708', '1', '708', '胡辣汤708', '25', null, '');
INSERT INTO `cookbook` VALUES ('709', '1', '709', '胡辣汤709', '25', null, '');
INSERT INTO `cookbook` VALUES ('710', '1', '710', '胡辣汤710', '25', null, '');
INSERT INTO `cookbook` VALUES ('711', '1', '711', '胡辣汤711', '25', null, '');
INSERT INTO `cookbook` VALUES ('712', '1', '712', '胡辣汤712', '25', null, '');
INSERT INTO `cookbook` VALUES ('713', '1', '713', '胡辣汤713', '25', null, '');
INSERT INTO `cookbook` VALUES ('714', '1', '714', '胡辣汤714', '25', null, '');
INSERT INTO `cookbook` VALUES ('715', '1', '715', '胡辣汤715', '25', null, '');
INSERT INTO `cookbook` VALUES ('716', '1', '716', '胡辣汤716', '25', null, '');
INSERT INTO `cookbook` VALUES ('717', '1', '717', '胡辣汤717', '25', null, '');
INSERT INTO `cookbook` VALUES ('718', '1', '718', '胡辣汤718', '10', null, '');
INSERT INTO `cookbook` VALUES ('719', '1', '719', '胡辣汤719', '20', null, '');
INSERT INTO `cookbook` VALUES ('720', '1', '720', '胡辣汤720', '25', null, '');
INSERT INTO `cookbook` VALUES ('721', '1', '721', '胡辣汤721', '25', null, '');
INSERT INTO `cookbook` VALUES ('722', '1', '722', '胡辣汤722', '25', null, '');
INSERT INTO `cookbook` VALUES ('723', '1', '723', '胡辣汤723', '25', null, '');
INSERT INTO `cookbook` VALUES ('724', '1', '724', '胡辣汤724', '15', null, '');
INSERT INTO `cookbook` VALUES ('725', '1', '725', '胡辣汤725', '25', null, '');
INSERT INTO `cookbook` VALUES ('726', '1', '726', '胡辣汤726', '25', null, '');
INSERT INTO `cookbook` VALUES ('727', '1', '727', '胡辣汤727', '25', null, '');
INSERT INTO `cookbook` VALUES ('728', '1', '728', '胡辣汤728', '25', null, '');
INSERT INTO `cookbook` VALUES ('729', '1', '729', '胡辣汤729', '25', null, '');
INSERT INTO `cookbook` VALUES ('730', '1', '730', '胡辣汤730', '25', null, '');
INSERT INTO `cookbook` VALUES ('731', '1', '731', '胡辣汤731', '20', null, '');
INSERT INTO `cookbook` VALUES ('732', '1', '732', '胡辣汤732', '25', null, '');
INSERT INTO `cookbook` VALUES ('733', '1', '733', '胡辣汤733', '25', null, '');
INSERT INTO `cookbook` VALUES ('734', '1', '734', '胡辣汤734', '25', null, '');
INSERT INTO `cookbook` VALUES ('735', '1', '735', '胡辣汤735', '25', null, '');
INSERT INTO `cookbook` VALUES ('736', '1', '736', '胡辣汤736', '25', null, '');
INSERT INTO `cookbook` VALUES ('737', '1', '737', '胡辣汤737', '25', null, '');
INSERT INTO `cookbook` VALUES ('738', '1', '738', '胡辣汤738', '25', null, '');
INSERT INTO `cookbook` VALUES ('739', '1', '739', '胡辣汤739', '25', null, '');
INSERT INTO `cookbook` VALUES ('740', '1', '740', '胡辣汤740', '25', null, '');
INSERT INTO `cookbook` VALUES ('741', '1', '741', '胡辣汤741', '25', null, '');
INSERT INTO `cookbook` VALUES ('742', '1', '742', '胡辣汤742', '35', null, '');
INSERT INTO `cookbook` VALUES ('743', '1', '743', '胡辣汤743', '30', null, '');
INSERT INTO `cookbook` VALUES ('744', '1', '744', '胡辣汤744', '25', null, '');
INSERT INTO `cookbook` VALUES ('745', '1', '745', '胡辣汤745', '25', null, '');
INSERT INTO `cookbook` VALUES ('746', '1', '746', '胡辣汤746', '25', null, '');
INSERT INTO `cookbook` VALUES ('747', '1', '747', '胡辣汤747', '25', null, '');
INSERT INTO `cookbook` VALUES ('748', '1', '748', '胡辣汤748', '25', null, '');
INSERT INTO `cookbook` VALUES ('749', '1', '749', '胡辣汤749', '25', null, '');
INSERT INTO `cookbook` VALUES ('750', '1', '750', '胡辣汤750', '20', null, '');
INSERT INTO `cookbook` VALUES ('751', '1', '751', '胡辣汤751', '20', null, '');
INSERT INTO `cookbook` VALUES ('752', '1', '752', '胡辣汤752', '15', null, '');
INSERT INTO `cookbook` VALUES ('753', '1', '753', '胡辣汤753', '25', null, '');
INSERT INTO `cookbook` VALUES ('754', '1', '754', '胡辣汤754', '25', null, '');
INSERT INTO `cookbook` VALUES ('755', '1', '755', '胡辣汤755', '20', null, '');
INSERT INTO `cookbook` VALUES ('756', '1', '756', '胡辣汤756', '15', null, '');
INSERT INTO `cookbook` VALUES ('757', '1', '757', '胡辣汤757', '25', null, '');
INSERT INTO `cookbook` VALUES ('758', '1', '758', '胡辣汤758', '25', null, '');
INSERT INTO `cookbook` VALUES ('759', '1', '759', '胡辣汤759', '15', null, '');
INSERT INTO `cookbook` VALUES ('760', '1', '760', '胡辣汤760', '20', null, '');
INSERT INTO `cookbook` VALUES ('761', '1', '761', '胡辣汤761', '25', null, '');
INSERT INTO `cookbook` VALUES ('762', '1', '762', '胡辣汤762', '25', null, '');
INSERT INTO `cookbook` VALUES ('763', '1', '763', '胡辣汤763', '25', null, '');
INSERT INTO `cookbook` VALUES ('764', '1', '764', '胡辣汤764', '25', null, '');
INSERT INTO `cookbook` VALUES ('765', '1', '765', '胡辣汤765', '20', null, '');
INSERT INTO `cookbook` VALUES ('766', '1', '766', '胡辣汤766', '25', null, '');
INSERT INTO `cookbook` VALUES ('767', '1', '767', '胡辣汤767', '25', null, '');
INSERT INTO `cookbook` VALUES ('768', '1', '768', '胡辣汤768', '25', null, '');
INSERT INTO `cookbook` VALUES ('769', '1', '769', '胡辣汤769', '25', null, '');
INSERT INTO `cookbook` VALUES ('770', '1', '770', '胡辣汤770', '25', null, '');
INSERT INTO `cookbook` VALUES ('771', '1', '771', '胡辣汤771', '15', null, '');
INSERT INTO `cookbook` VALUES ('772', '1', '772', '胡辣汤772', '15', null, '');
INSERT INTO `cookbook` VALUES ('773', '1', '773', '胡辣汤773', '15', null, '');
INSERT INTO `cookbook` VALUES ('774', '1', '774', '胡辣汤774', '15', null, '');
INSERT INTO `cookbook` VALUES ('775', '1', '775', '胡辣汤775', '15', null, '');
INSERT INTO `cookbook` VALUES ('776', '1', '776', '胡辣汤776', '20', null, '');
INSERT INTO `cookbook` VALUES ('777', '1', '777', '胡辣汤777', '1', null, '');
INSERT INTO `cookbook` VALUES ('778', '1', '778', '胡辣汤778', '15', null, '');
INSERT INTO `cookbook` VALUES ('779', '1', '779', '胡辣汤779', '15', null, '');
INSERT INTO `cookbook` VALUES ('780', '1', '780', '胡辣汤780', '15', null, '');
INSERT INTO `cookbook` VALUES ('781', '1', '781', '胡辣汤781', '25', null, '');
INSERT INTO `cookbook` VALUES ('782', '1', '782', '胡辣汤782', '25', null, '');
INSERT INTO `cookbook` VALUES ('783', '1', '783', '胡辣汤783', '25', null, '');
INSERT INTO `cookbook` VALUES ('784', '1', '784', '胡辣汤784', '25', null, '');
INSERT INTO `cookbook` VALUES ('785', '1', '785', '胡辣汤785', '25', null, '');
INSERT INTO `cookbook` VALUES ('786', '1', '786', '胡辣汤786', '15', null, '');
INSERT INTO `cookbook` VALUES ('787', '1', '787', '胡辣汤787', '25', null, '');
INSERT INTO `cookbook` VALUES ('788', '1', '788', '胡辣汤788', '20', null, '');
INSERT INTO `cookbook` VALUES ('789', '1', '789', '胡辣汤789', '20', null, '');
INSERT INTO `cookbook` VALUES ('790', '1', '790', '胡辣汤790', '20', null, '');
INSERT INTO `cookbook` VALUES ('791', '1', '791', '胡辣汤791', '15', null, '');
INSERT INTO `cookbook` VALUES ('792', '1', '792', '胡辣汤792', '15', null, '');
INSERT INTO `cookbook` VALUES ('793', '1', '793', '胡辣汤793', '20', null, '');
INSERT INTO `cookbook` VALUES ('794', '1', '794', '胡辣汤794', '15', null, '');
INSERT INTO `cookbook` VALUES ('795', '1', '795', '胡辣汤795', '30', null, '');
INSERT INTO `cookbook` VALUES ('796', '1', '796', '胡辣汤796', '15', null, '');
INSERT INTO `cookbook` VALUES ('797', '1', '797', '胡辣汤797', '15', null, '');
INSERT INTO `cookbook` VALUES ('798', '1', '798', '胡辣汤798', '15', null, '');
INSERT INTO `cookbook` VALUES ('799', '1', '799', '胡辣汤799', '15', null, '');
INSERT INTO `cookbook` VALUES ('800', '1', '800', '胡辣汤800', '15', null, '');
INSERT INTO `cookbook` VALUES ('801', '1', '801', '胡辣汤801', '15', null, '');
INSERT INTO `cookbook` VALUES ('802', '1', '802', '胡辣汤802', '15', null, '');
INSERT INTO `cookbook` VALUES ('803', '1', '803', '胡辣汤803', '15', null, '');
INSERT INTO `cookbook` VALUES ('804', '1', '804', '胡辣汤804', '15', null, '');
INSERT INTO `cookbook` VALUES ('805', '1', '805', '胡辣汤805', '15', null, '');
INSERT INTO `cookbook` VALUES ('806', '1', '806', '胡辣汤806', '25', null, '');
INSERT INTO `cookbook` VALUES ('807', '1', '807', '胡辣汤807', '15', null, '');
INSERT INTO `cookbook` VALUES ('808', '1', '808', '胡辣汤808', '15', null, '');
INSERT INTO `cookbook` VALUES ('809', '1', '809', '胡辣汤809', '15', null, '');
INSERT INTO `cookbook` VALUES ('810', '1', '810', '胡辣汤810', '15', null, '');
INSERT INTO `cookbook` VALUES ('811', '1', '811', '胡辣汤811', '15', null, '');
INSERT INTO `cookbook` VALUES ('812', '1', '812', '胡辣汤812', '15', null, '');
INSERT INTO `cookbook` VALUES ('813', '1', '813', '胡辣汤813', '15', null, '');
INSERT INTO `cookbook` VALUES ('814', '1', '814', '胡辣汤814', '15', null, '');
INSERT INTO `cookbook` VALUES ('815', '1', '815', '胡辣汤815', '15', null, '');
INSERT INTO `cookbook` VALUES ('816', '1', '816', '胡辣汤816', '25', null, '');
INSERT INTO `cookbook` VALUES ('817', '1', '817', '胡辣汤817', '25', null, '');
INSERT INTO `cookbook` VALUES ('818', '1', '818', '胡辣汤818', '15', null, '');
INSERT INTO `cookbook` VALUES ('819', '1', '819', '胡辣汤819', '15', null, '');
INSERT INTO `cookbook` VALUES ('820', '1', '820', '胡辣汤820', '15', null, '');
INSERT INTO `cookbook` VALUES ('821', '1', '821', '胡辣汤821', '15', null, '');
INSERT INTO `cookbook` VALUES ('822', '1', '822', '胡辣汤822', '15', null, '');
INSERT INTO `cookbook` VALUES ('823', '1', '823', '胡辣汤823', '25', null, '');
INSERT INTO `cookbook` VALUES ('824', '1', '824', '胡辣汤824', '15', null, '');
INSERT INTO `cookbook` VALUES ('825', '1', '825', '胡辣汤825', '15', null, '');
INSERT INTO `cookbook` VALUES ('826', '1', '826', '胡辣汤826', '15', null, '');
INSERT INTO `cookbook` VALUES ('827', '1', '827', '胡辣汤827', '15', null, '');
INSERT INTO `cookbook` VALUES ('828', '1', '828', '胡辣汤828', '15', null, '');
INSERT INTO `cookbook` VALUES ('829', '1', '829', '胡辣汤829', '15', null, '');
INSERT INTO `cookbook` VALUES ('830', '1', '830', '胡辣汤830', '15', null, '');
INSERT INTO `cookbook` VALUES ('831', '1', '831', '胡辣汤831', '15', null, '');
INSERT INTO `cookbook` VALUES ('832', '1', '832', '胡辣汤832', '15', null, '');
INSERT INTO `cookbook` VALUES ('833', '1', '833', '胡辣汤833', '15', null, '');
INSERT INTO `cookbook` VALUES ('834', '1', '834', '胡辣汤834', '15', null, '');
INSERT INTO `cookbook` VALUES ('835', '1', '835', '胡辣汤835', '15', null, '');
INSERT INTO `cookbook` VALUES ('836', '1', '836', '胡辣汤836', '15', null, '');
INSERT INTO `cookbook` VALUES ('837', '1', '837', '胡辣汤837', '15', null, '');
INSERT INTO `cookbook` VALUES ('838', '1', '838', '胡辣汤838', '25', null, '');
INSERT INTO `cookbook` VALUES ('839', '1', '839', '胡辣汤839', '2', null, '');
INSERT INTO `cookbook` VALUES ('840', '1', '840', '胡辣汤840', '10', null, '');
INSERT INTO `cookbook` VALUES ('841', '1', '841', '胡辣汤841', '10', null, '');

-- ----------------------------
-- Table structure for `dept`
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(255) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('10', '00', '1', '0');
INSERT INTO `dept` VALUES ('13', '西校区', '1', '0');
INSERT INTO `dept` VALUES ('14', '食堂', '1', '13');
INSERT INTO `dept` VALUES ('16', '食堂', '1', '10');
INSERT INTO `dept` VALUES ('17', '老食堂', '1', '16');
INSERT INTO `dept` VALUES ('18', '新食堂', '1', '16');
INSERT INTO `dept` VALUES ('20', '食堂0', '1', '14');
INSERT INTO `dept` VALUES ('21', '澡堂', '1', '13');
INSERT INTO `dept` VALUES ('22', '男澡堂', '1', '21');
INSERT INTO `dept` VALUES ('23', '1', '1', '0');
INSERT INTO `dept` VALUES ('24', '0', '1', '0');
INSERT INTO `dept` VALUES ('27', '01', '1', '23');
INSERT INTO `dept` VALUES ('28', '02', '1', '23');
INSERT INTO `dept` VALUES ('29', '03', '1', '23');
INSERT INTO `dept` VALUES ('30', '11', '1', '24');

-- ----------------------------
-- Table structure for `device`
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  `operId` int(11) DEFAULT NULL,
  `deviceName` varchar(255) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  `deviceType` int(11) DEFAULT '0' COMMENT '1读卡器,2点餐机,3水控,4手持机',
  `enable` int(11) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES ('1', '1', '1', '1', '读卡机', '12345678', '0', '1', '4159a96e838e4df5bdecd4e2d8e940f1');
INSERT INTO `device` VALUES ('2', '1', '1', null, '点餐机1', '12345678', '1', '1', '2974e70c3c9e11e5839fd4bed9804c01');

-- ----------------------------
-- Table structure for `devicegroup`
-- ----------------------------
DROP TABLE IF EXISTS `devicegroup`;
CREATE TABLE `devicegroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupName` varchar(255) DEFAULT NULL,
  `groupType` int(11) DEFAULT '0' COMMENT '1读卡器,2点餐机,3水控,4手持机',
  `operId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of devicegroup
-- ----------------------------
INSERT INTO `devicegroup` VALUES ('1', '1', '东校区', '0', '1');
INSERT INTO `devicegroup` VALUES ('2', '1', '西校区', '0', '1');

-- ----------------------------
-- Table structure for `discount`
-- ----------------------------
DROP TABLE IF EXISTS `discount`;
CREATE TABLE `discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `discountType` int(255) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `subsidy` int(11) DEFAULT NULL,
  `giveCash` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discount
-- ----------------------------
INSERT INTO `discount` VALUES ('4', '1', '0', '1', '0', '10');
INSERT INTO `discount` VALUES ('5', '1', '1', '1', '0', '100');
INSERT INTO `discount` VALUES ('6', '1', '2', '1', '0', '0');
INSERT INTO `discount` VALUES ('7', '1', '3', '1', '0', '12');
INSERT INTO `discount` VALUES ('8', '1', '4', '1', '0', '0');
INSERT INTO `discount` VALUES ('9', '1', '5', '1', '0', '1');
INSERT INTO `discount` VALUES ('10', '1', '6', '100', '0', '0');
INSERT INTO `discount` VALUES ('11', '1', '7', '1', '1', '20');
INSERT INTO `discount` VALUES ('12', '1', '8', '100', '0', '0');
INSERT INTO `discount` VALUES ('13', '1', '9', '100', '0', '0');
INSERT INTO `discount` VALUES ('14', '1', '10', '100', '0', '0');
INSERT INTO `discount` VALUES ('15', '1', '11', '100', '0', '0');
INSERT INTO `discount` VALUES ('16', '1', '12', '100', '0', '0');
INSERT INTO `discount` VALUES ('17', '1', '13', '100', '0', '0');
INSERT INTO `discount` VALUES ('18', '1', '14', '100', '0', '0');
INSERT INTO `discount` VALUES ('19', '1', '15', '100', '0', '0');

-- ----------------------------
-- Table structure for `discountbase`
-- ----------------------------
DROP TABLE IF EXISTS `discountbase`;
CREATE TABLE `discountbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountType` int(255) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `subsidy` int(11) DEFAULT NULL,
  `giveCash` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discountbase
-- ----------------------------
INSERT INTO `discountbase` VALUES ('1', '0', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('2', '1', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('3', '2', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('4', '3', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('5', '4', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('6', '5', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('7', '6', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('8', '7', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('9', '8', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('10', '9', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('11', '10', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('12', '11', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('13', '12', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('14', '13', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('15', '14', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('16', '15', '100', '0', '0');

-- ----------------------------
-- Table structure for `entranceguard`
-- ----------------------------
DROP TABLE IF EXISTS `entranceguard`;
CREATE TABLE `entranceguard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `openDelay` int(11) DEFAULT NULL,
  `cardPwdType` int(11) DEFAULT NULL,
  `recordType` int(11) DEFAULT NULL,
  `authType` int(11) DEFAULT NULL,
  `openStatus` int(11) DEFAULT NULL,
  `operPwd` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entranceguard
-- ----------------------------
INSERT INTO `entranceguard` VALUES ('1', '1', '10', '0', '1', '1', '2', '000000');

-- ----------------------------
-- Table structure for `entranceguardbase`
-- ----------------------------
DROP TABLE IF EXISTS `entranceguardbase`;
CREATE TABLE `entranceguardbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openDelay` int(11) DEFAULT NULL,
  `cardPwdType` int(11) DEFAULT NULL,
  `recordType` int(11) DEFAULT NULL,
  `authType` int(11) DEFAULT NULL,
  `openStatus` int(11) DEFAULT NULL,
  `operPwd` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entranceguardbase
-- ----------------------------
INSERT INTO `entranceguardbase` VALUES ('1', '10', '1', '0', '0', '0', '000000');

-- ----------------------------
-- Table structure for `meal`
-- ----------------------------
DROP TABLE IF EXISTS `meal`;
CREATE TABLE `meal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `mealName` varchar(255) DEFAULT NULL,
  `beginTime` varchar(8) DEFAULT NULL,
  `endTime` varchar(8) DEFAULT NULL,
  `timeLimit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of meal
-- ----------------------------
INSERT INTO `meal` VALUES ('18', '1', '早餐', '06:30:00', '10:30:00', '1');
INSERT INTO `meal` VALUES ('19', '1', '午餐', '10:30:01', '15:30:00', '0');
INSERT INTO `meal` VALUES ('20', '1', '晚餐', '15:30:01', '18:30:00', '0');
INSERT INTO `meal` VALUES ('21', '1', '夜宵', '18:30:01', '20:30:00', '0');
INSERT INTO `meal` VALUES ('22', '1', '加班一', '20:30:01', '22:30:00', '0');
INSERT INTO `meal` VALUES ('23', '1', '加班二', '22:00:01', '23:59:59', '10');
INSERT INTO `meal` VALUES ('24', '2', '早餐', '06:30:00', '10:30:00', '0');
INSERT INTO `meal` VALUES ('25', '2', '午餐', '10:30:01', '15:30:00', '0');
INSERT INTO `meal` VALUES ('26', '2', '晚餐', '15:30:01', '18:30:00', '0');
INSERT INTO `meal` VALUES ('27', '2', '夜宵', '18:30:01', '20:30:00', '0');
INSERT INTO `meal` VALUES ('28', '2', '加班一', '20:30:01', '22:30:00', '0');
INSERT INTO `meal` VALUES ('29', '2', '加班二', '22:00:01', '23:59:59', '0');

-- ----------------------------
-- Table structure for `mealbase`
-- ----------------------------
DROP TABLE IF EXISTS `mealbase`;
CREATE TABLE `mealbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mealName` varchar(255) DEFAULT NULL,
  `beginTime` varchar(8) DEFAULT NULL,
  `endTime` varchar(8) DEFAULT NULL,
  `timeLimit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mealbase
-- ----------------------------
INSERT INTO `mealbase` VALUES ('1', '早餐', '06:30:00', '10:30:00', '0');
INSERT INTO `mealbase` VALUES ('2', '午餐', '10:30:01', '15:30:00', '0');
INSERT INTO `mealbase` VALUES ('3', '晚餐', '15:30:01', '18:30:00', '0');
INSERT INTO `mealbase` VALUES ('4', '夜宵', '18:30:01', '20:30:00', '0');
INSERT INTO `mealbase` VALUES ('5', '加班一', '20:30:01', '22:30:00', '0');
INSERT INTO `mealbase` VALUES ('6', '加班二', '22:00:01', '23:59:59', '0');

-- ----------------------------
-- Table structure for `multiwaterrate`
-- ----------------------------
DROP TABLE IF EXISTS `multiwaterrate`;
CREATE TABLE `multiwaterrate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL,
  `chargeType` int(11) DEFAULT NULL,
  `rate1Status` int(11) DEFAULT NULL,
  `rate1DeductFare` int(11) DEFAULT NULL,
  `rate1DeductCycle` int(11) DEFAULT NULL,
  `rate2Status` int(11) DEFAULT NULL,
  `rate2DeductFare` int(11) DEFAULT NULL,
  `rate2DeductCycle` int(11) DEFAULT NULL,
  `rate3Status` int(11) DEFAULT NULL,
  `rate3DeductFare` int(11) DEFAULT NULL,
  `rate3DeductCycle` int(11) DEFAULT NULL,
  `rate4Status` int(11) DEFAULT NULL,
  `rate4DeductFare` int(11) DEFAULT NULL,
  `rate4DeductCycle` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of multiwaterrate
-- ----------------------------
INSERT INTO `multiwaterrate` VALUES ('1', '1', '0', '0', '1', '10', '1', '0', '12', '6', '1', '13', '2', '1', '16', '3');

-- ----------------------------
-- Table structure for `multiwaterratebase`
-- ----------------------------
DROP TABLE IF EXISTS `multiwaterratebase`;
CREATE TABLE `multiwaterratebase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumeType` int(11) DEFAULT NULL,
  `chargeType` int(11) DEFAULT NULL,
  `rate1Status` int(11) DEFAULT NULL,
  `rate1DeductFare` int(11) DEFAULT NULL,
  `rate1DeductCycle` int(11) DEFAULT NULL,
  `rate2Status` int(11) DEFAULT NULL,
  `rate2DeductFare` int(11) DEFAULT NULL,
  `rate2DeductCycle` int(11) DEFAULT NULL,
  `rate3Status` int(11) DEFAULT NULL,
  `rate3DeductFare` int(11) DEFAULT NULL,
  `rate3DeductCycle` int(11) DEFAULT NULL,
  `rate4Status` int(11) DEFAULT NULL,
  `rate4DeductFare` int(11) DEFAULT NULL,
  `rate4DeductCycle` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of multiwaterratebase
-- ----------------------------
INSERT INTO `multiwaterratebase` VALUES ('1', '0', '0', '1', '10', '5', '1', '10', '5', '1', '10', '5', '1', '10', '5');

-- ----------------------------
-- Table structure for `ordertime`
-- ----------------------------
DROP TABLE IF EXISTS `ordertime`;
CREATE TABLE `ordertime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `orderTimeName` varchar(50) DEFAULT NULL,
  `beginTime` varchar(50) DEFAULT NULL,
  `endTime` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordertime
-- ----------------------------
INSERT INTO `ordertime` VALUES ('1', '1', '早餐', '06:00', '08:30', '111', '');
INSERT INTO `ordertime` VALUES ('2', '1', '中餐', '11:30', '14:00', null, '');
INSERT INTO `ordertime` VALUES ('3', '1', '晚餐', '17:00', '19:00', null, '');
INSERT INTO `ordertime` VALUES ('4', '1', '夜宵', '19:01', '20:30', null, '');
INSERT INTO `ordertime` VALUES ('5', '1', '加班1', '20:31', '23:59', null, '');
INSERT INTO `ordertime` VALUES ('6', '1', '加班2', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('7', '1', '加班3', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('8', '1', '加班4', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('9', '1', '加班5', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('10', '1', '加班6', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('11', '1', '加班7', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('12', '1', '加班8', '00:00', '00:00', null, '');

-- ----------------------------
-- Table structure for `ordertimebase`
-- ----------------------------
DROP TABLE IF EXISTS `ordertimebase`;
CREATE TABLE `ordertimebase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderTimeName` varchar(50) DEFAULT NULL,
  `beginTime` varchar(50) DEFAULT NULL,
  `endTime` varchar(50) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordertimebase
-- ----------------------------
INSERT INTO `ordertimebase` VALUES ('1', '早餐', '06:00', '08:30', '');
INSERT INTO `ordertimebase` VALUES ('2', '中餐', '11:30', '14:00', '');
INSERT INTO `ordertimebase` VALUES ('3', '晚餐', '17:00', '19:00', '');
INSERT INTO `ordertimebase` VALUES ('4', '夜宵', '19:01', '20:30', '');
INSERT INTO `ordertimebase` VALUES ('5', '加班1', '20:31', '23:59', '');
INSERT INTO `ordertimebase` VALUES ('6', '加班2', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('7', '加班3', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('8', '加班4', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('9', '加班5', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('10', '加班6', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('11', '加班7', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('12', '加班8', '00:00', '00:00', '');

-- ----------------------------
-- Table structure for `sysuser`
-- ----------------------------
DROP TABLE IF EXISTS `sysuser`;
CREATE TABLE `sysuser` (
  `operId` int(11) NOT NULL AUTO_INCREMENT,
  `operName` varchar(255) DEFAULT NULL,
  `loginName` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL,
  `superAdmin` varchar(255) DEFAULT NULL,
  `userType` int(11) DEFAULT NULL COMMENT '1管理员,2出纳员',
  `cardSN` varchar(255) DEFAULT NULL,
  `cardNO` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `deviceId` int(11) DEFAULT NULL,
  `enabled` int(11) DEFAULT NULL,
  `invalidDate` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`operId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysuser
-- ----------------------------
INSERT INTO `sysuser` VALUES ('1', null, '1', '1', null, '0', '', null, '1', '1', '1', null, '0');
INSERT INTO `sysuser` VALUES ('2', '222', '2', '2', null, '1', 'a48a2a41', '13', '1', '1', '1', '2015-10-31 00:00:00', '2');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `deptId` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `shortName` varchar(255) DEFAULT NULL,
  `userNO` varchar(255) DEFAULT NULL,
  `cardID` varchar(255) DEFAULT NULL,
  `cardNO` int(255) DEFAULT NULL,
  `cardSN` varchar(255) DEFAULT NULL,
  `cardSeq` int(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `cardTypeId` int(11) DEFAULT NULL,
  `cardFunc` int(11) DEFAULT NULL,
  `cardIdentity` int(11) DEFAULT NULL,
  `beginDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `invalidDate` date DEFAULT NULL,
  `cardMakeDate` date DEFAULT NULL,
  `consumePwd` varchar(255) DEFAULT NULL,
  `identityPwd` varchar(255) DEFAULT NULL,
  `totalFare` int(11) DEFAULT '0',
  `oddFare` int(11) DEFAULT '0',
  `lastConsumeTime` datetime DEFAULT NULL,
  `daySumFare` int(11) DEFAULT '0',
  `opCount` int(11) DEFAULT '0',
  `subsidyOddFare` float DEFAULT '0',
  `lastSubsidyConsumeTime` datetime DEFAULT NULL,
  `subsidydaySum` int(11) DEFAULT '0',
  `subsidyOpCount` int(11) DEFAULT '0',
  `subsidyVersion` int(11) DEFAULT '0',
  `subsidyInvalidDate` date DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('48', '1', '14', '001', '001', '001', '123456789012345678', '1', 'bca6552f', '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2018-07-01', '2002-01-30', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('51', '1', '10', '005', '005', '005', '123456789012345678', '30', '7025f025', '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2018-07-01', '2015-09-20', '8888', '8888', '101000', '101000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('52', '1', '14', '006', '006', '006', '123456789012345678', null, null, '1', '0', '0', '0', '0', '1', '2015-05-28', null, '2018-07-01', '2002-01-29', '8888', '8888', '124400', '124400', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('53', '1', '13', '王亮', 'WL', '1001', '123456789012345678', '32', 'a48a2a41', '2', '1', '0', '0', '0', '1', '2015-07-20', null, '2018-07-01', '2015-08-19', '8888', '8888', '132000', '132000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('55', '1', '13', '党晓菲', 'DXF', '1003', '123456789012345678', '31', '90d24626', '2', '1', '0', '0', '0', '1', '2015-07-20', null, '2018-07-01', '2002-01-09', '8888', '8888', '101000', '101000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('56', '1', '13', '王真平', 'WZP', '1004', '123456789012345678', '28', '24fa5a41', '1', '1', '0', '0', '0', '1', '2015-07-20', null, '2018-07-01', '2015-09-14', '8888', '8888', '11000', '11000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('60', '1', '18', '任鸿飞', 'RHF', '4001', '123456789012345678', '29', 'd4841941', '1', '1', '0', '0', '0', '1', '2015-07-06', null, '2018-07-01', '2015-09-16', '8888', '8888', '101000', '101000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('61', '1', '18', '王晓光', 'WXG', '4002', '123456789012345678', null, null, '0', '0', '0', '0', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('62', '1', '18', '郭永帅', 'GYS', '4003', '123456789012345678', null, null, '0', '0', '0', '0', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('63', '1', '18', '董山园', 'DSY', '4004', '123456789012345678', null, null, '0', '0', '0', '0', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('64', '1', '18', '曹翠翠', 'CCC', '4005', '123456789012345678', null, null, '0', '0', '0', '0', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('65', '1', '18', '李全政', 'LQZ', '4006', '123456789012345678', null, null, '0', '0', '0', '0', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('71', '1', '19', '王勤', 'WQ', '5001', '123456789012345678', null, null, '0', '0', '0', '3', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('72', '1', '19', '詹广阳', 'ZGY', '5002', '123456789012345678', null, null, '0', '0', '0', '3', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('73', '1', '19', '朱留升', 'ZLS', '5003', '123456789012345678', null, null, '0', '0', '0', '5', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('74', '1', '19', '周浩', 'ZH', '5004', '123456789012345678', null, null, '0', '0', '0', '5', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('75', '1', '19', '张翠娟', 'ZCJ', '5005', '123456789012345678', null, null, '0', '0', '0', '5', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('83', '1', '16', '王宇', 'WY', '2001', '123456789012345678', null, null, '0', '0', '0', '3', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('84', '1', '16', '颜贝', 'YB', '2002', '123456789012345678', null, null, '0', '0', '0', '3', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('85', '1', '16', '申妞妞', 'SNN', '2003', '123456789012345678', null, null, '0', '0', '0', '3', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('86', '1', '16', '马慧丹', 'MHD', '2004', '123456789012345678', null, null, '0', '0', '0', '3', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('88', '1', '17', '周金平', 'ZJP', '3001', '123456789012345678', null, null, '0', '0', '0', '4', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('89', '1', '17', '张丹丹', 'ZDD', '3002', '123456789012345678', null, null, '0', '0', '0', '4', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('90', '1', '17', '司文文', 'SWW', '3003', '123456789012345678', null, null, '0', '0', '0', '4', '0', '1', '2015-07-06', null, '2018-07-01', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('92', '1', '17', '崔连杰', 'CLJ', '3005', '123456789012345678', null, null, '0', '0', '0', '4', '0', '1', '2015-07-06', null, '2018-07-01', '2002-01-02', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('93', '1', '17', '3006', '3006', '3006', '123456789012345678', null, null, '0', '0', '0', '3', '0', '4', '2015-07-06', null, '2018-07-01', '2002-01-02', '8888', '8888', '11000', '11000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('96', '1', '22', '3', '3', '3', '123456789012345678', '2', '450f671d', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-19', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('97', '1', '22', '4', '4', '4', '123456789012345678', '3', '7511401c', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-19', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('98', '1', '22', '5', '5', '5', '123456789012345678', '4', 'd57e6c1c', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-19', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('99', '1', '22', '6', '6', '6', '123456789012345678', '5', '319992d5', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-19', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('100', '1', '22', '7', '7', '7', '123456789012345678', '6', 'c4883641', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-19', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('101', '1', '22', '8', '8', '8', '123456789012345678', '7', 'b0195a99', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-19', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('102', '1', '22', '9', '9', '9', '123456789012345678', '11', 'cdcde79b', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('103', '1', '22', '10', '10', '10', '123456789012345678', '12', 'c5ed2b20', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '120000', '120000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('104', '1', '22', '11', '11', '11', '123456789012345678', '13', 'd4b5f940', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('105', '1', '22', '12', '12', '12', '123456789012345678', '14', '0a6ad304', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('106', '1', '22', '13', '13', '13', '123456789012345678', '15', '204d6d99', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('107', '1', '22', '14', '14', '14', '123456789012345678', '16', 'a417cf24', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('108', '1', '22', '15', '15', '15', '123456789012345678', '23', 'c1f775d5', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2015-08-21', '2015-08-19', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('109', '1', '22', '16', '16', '16', '123456789012345678', '9', '1c924e2f', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-19', '8888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('110', '1', '22', '17', '17', '17', '123456789012345678', '17', '000df125', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('111', '1', '22', '18', '18', '18', '123456789012345678', '18', 'b10759d6', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('112', '1', '22', '19', '19', '19', '123456789012345678', '19', '54683e41', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('113', '1', '22', '20', '20', '20', '123456789012345678', '20', '746c3c41', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('114', '1', '22', '21', '21', '21', '123456789012345678', '21', '40d7f125', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '10000', '10000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('115', '1', '22', '22', '22', '22', '123456789012345678', '22', 'c4314441', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2015-08-21', '8888', '8888', '20000', '20000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('116', '1', '22', '23', '23', '23', '123456789012345678', '24', '60795231', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2002-01-09', '8888', '8888', '11000', '11000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('117', '1', '22', '24', '24', '24', '123456789012345678', '26', 'c4283b41', '1', '1', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', '2002-01-09', '8888', '8888', '11000', '11000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('118', '1', '22', '25', '25', '25', '123456789012345678', null, null, null, '0', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('119', '1', '22', '26', '26', '26', '123456789012345678', null, null, null, '0', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('120', '1', '22', '27', '27', '27', '123456789012345678', null, null, null, '0', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('121', '1', '22', '28', '28', '28', '123456789012345678', null, null, null, '0', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('122', '1', '22', '29', '29', '29', '123456789012345678', null, null, null, '0', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('123', '1', '22', '30', '30', '30', '123456789012345678', null, null, null, '0', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('124', '1', '22', '31', '31', '31', '123456789012345678', null, null, null, '0', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('125', '1', '22', '32', '32', '32', '123456789012345678', null, null, null, '0', '0', '0', '0', '1', '2015-08-17', null, '2099-12-30', null, '8888', '8888', null, null, null, '0', null, '0', null, '0', '0', '0', null);

-- ----------------------------
-- Table structure for `userdept`
-- ----------------------------
DROP TABLE IF EXISTS `userdept`;
CREATE TABLE `userdept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(255) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `batchId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userdept
-- ----------------------------
INSERT INTO `userdept` VALUES ('13', '第四部门', '1', '0', '2');
INSERT INTO `userdept` VALUES ('14', '第5部门', '1', '13', '1');
INSERT INTO `userdept` VALUES ('16', '销售部', '1', '0', '1');
INSERT INTO `userdept` VALUES ('17', '客服部', '1', '0', '12');
INSERT INTO `userdept` VALUES ('18', '技术部', '1', '0', '12');
INSERT INTO `userdept` VALUES ('19', '生产部', '1', '0', '12');
INSERT INTO `userdept` VALUES ('20', '财务部', '1', '0', '12');
INSERT INTO `userdept` VALUES ('21', '财务部0', '1', '20', '1');
INSERT INTO `userdept` VALUES ('22', '1', '1', '0', '13');
INSERT INTO `userdept` VALUES ('23', '0', '1', '0', '1');
INSERT INTO `userdept` VALUES ('24', '2', '1', '0', '1');
INSERT INTO `userdept` VALUES ('25', '3', '1', '0', '1');
INSERT INTO `userdept` VALUES ('26', '4', '1', '0', '1');
INSERT INTO `userdept` VALUES ('27', '5', '1', '0', '1');
INSERT INTO `userdept` VALUES ('28', '6', '1', '0', '1');
INSERT INTO `userdept` VALUES ('29', '7', '1', '0', '1');
INSERT INTO `userdept` VALUES ('30', '生产部0', '1', '19', '1');
INSERT INTO `userdept` VALUES ('31', '2', '1', '19', '1');
INSERT INTO `userdept` VALUES ('32', '技术部0', '1', '18', '1');
INSERT INTO `userdept` VALUES ('33', '2', '1', '18', '1');
INSERT INTO `userdept` VALUES ('34', '3', '1', '18', '1');
INSERT INTO `userdept` VALUES ('35', '财务部1', '1', '20', '1');

-- ----------------------------
-- Table structure for `waterrate`
-- ----------------------------
DROP TABLE IF EXISTS `waterrate`;
CREATE TABLE `waterrate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL,
  `goWaterType` int(11) DEFAULT NULL,
  `stopWaterType` int(11) DEFAULT NULL,
  `rate1Status` int(11) DEFAULT NULL,
  `rate1ConsumeFare` int(11) DEFAULT NULL,
  `rate1ConsumeCycle` int(11) DEFAULT NULL,
  `rate1NextDayReset` int(11) DEFAULT NULL,
  `rate2Status` int(11) DEFAULT NULL,
  `rate2BeginTime` varchar(255) DEFAULT NULL,
  `rate2EndTime` varchar(255) DEFAULT NULL,
  `rate2Value1` int(11) DEFAULT NULL,
  `rate2Value2` int(11) DEFAULT NULL,
  `rate2CardTypes` varchar(255) DEFAULT NULL,
  `rate3Status` int(11) DEFAULT NULL,
  `rate3BeginTime` varchar(255) DEFAULT NULL,
  `rate3EndTime` varchar(255) DEFAULT NULL,
  `rate3Value1` int(11) DEFAULT NULL,
  `rate3Value2` int(11) DEFAULT NULL,
  `rate3CardTypes` varchar(255) DEFAULT NULL,
  `rate4Status` int(11) DEFAULT NULL,
  `rate4BeginTime` varchar(255) DEFAULT NULL,
  `rate4EndTime` varchar(255) DEFAULT NULL,
  `rate4Value1` int(11) DEFAULT NULL,
  `rate4Value2` int(11) DEFAULT NULL,
  `rate4CardTypes` varchar(255) DEFAULT NULL,
  `rate5DeductFare` int(11) DEFAULT NULL,
  `rate5DeductCycle` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waterrate
-- ----------------------------
INSERT INTO `waterrate` VALUES ('1', '1', '0', '1', '1', '0', '101', '6', '0', '0', '00:00', '00:00', '0', '1', ',0,1,3,4,5,6,7,8,9,10,11,13,14,15,,', '1', '00:46', '00:49', '0', '2', ',0,2,3,4,5,6,7,8,9,10,11,12,13,14,15,,', '1', '00:00', '00:00', '0', '3', ',0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,,', '10', '50');

-- ----------------------------
-- Table structure for `waterratebase`
-- ----------------------------
DROP TABLE IF EXISTS `waterratebase`;
CREATE TABLE `waterratebase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumeType` int(11) DEFAULT NULL,
  `goWaterType` int(11) DEFAULT NULL,
  `stopWaterType` int(11) DEFAULT NULL,
  `rate1Status` int(11) DEFAULT NULL,
  `rate1ConsumeFare` int(11) DEFAULT NULL,
  `rate1ConsumeCycle` int(11) DEFAULT NULL,
  `rate1NextDayReset` int(11) DEFAULT NULL,
  `rate2Status` int(11) DEFAULT NULL,
  `rate2BeginTime` varchar(255) DEFAULT NULL,
  `rate2EndTime` varchar(255) DEFAULT NULL,
  `rate2Value1` int(11) DEFAULT NULL,
  `rate2Value2` int(11) DEFAULT NULL,
  `rate2CardTypes` varchar(255) DEFAULT NULL,
  `rate3Status` int(11) DEFAULT NULL,
  `rate3BeginTime` varchar(255) DEFAULT NULL,
  `rate3EndTime` varchar(255) DEFAULT NULL,
  `rate3Value1` int(11) DEFAULT NULL,
  `rate3Value2` int(11) DEFAULT NULL,
  `rate3CardTypes` varchar(255) DEFAULT NULL,
  `rate4Status` int(11) DEFAULT NULL,
  `rate4BeginTime` varchar(255) DEFAULT NULL,
  `rate4EndTime` varchar(255) DEFAULT NULL,
  `rate4Value1` int(11) DEFAULT NULL,
  `rate4Value2` int(11) DEFAULT NULL,
  `rate4CardTypes` varchar(255) DEFAULT NULL,
  `rate5DeductFare` int(11) DEFAULT NULL,
  `rate5DeductCycle` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waterratebase
-- ----------------------------
INSERT INTO `waterratebase` VALUES ('1', '0', '0', '0', '0', '10', '5', '0', '0', '00:00', '00:00', '0', '0', ',0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,', '0', '00:00', '00:00', '0', '0', ',0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,', '0', '00:00', '00:00', '0', '0', ',0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,', '10', '5');
