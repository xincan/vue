/*
Navicat MySQL Data Transfer

Source Server         : 本机-mysql
Source Server Version : 50722
Source Host           : localhost:3306
Source Database       : vue-xincan

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2019-02-19 19:23:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` varchar(64) NOT NULL COMMENT '地区id',
  `area_name` varchar(50) NOT NULL COMMENT '地区名称',
  `code` varchar(14) NOT NULL COMMENT '地区编码',
  `p_id` varchar(64) DEFAULT NULL COMMENT '地区父类id',
  `level` smallint(1) DEFAULT NULL COMMENT '地区级别(0：国家；1：省；2：市；3：县；4：乡镇)',
  `longitude` double DEFAULT NULL COMMENT '经度',
  `latitude` double DEFAULT NULL COMMENT '纬度',
  `altitude` double DEFAULT NULL COMMENT '海拔高度',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='地区表';

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('4c55dcdc970511e8a5ed8cec4b81c244', '庆阳市', '62100000000000', '9aaef2f0970011e8a5ed8cec4b81c244', '2', '106.00385', '35.41907', '234.34', '2018-10-12 10:53:07');
INSERT INTO `area` VALUES ('52db5b81970911e8a5ed8cec4b81c244', '华池县', '62102300000000', '4c55dcdc970511e8a5ed8cec4b81c244', '3', '108.00385', '107.98', '36.47', '2018-11-06 15:44:40');
INSERT INTO `area` VALUES ('9aaef2f0970011e8a5ed8cec4b81c244', '甘肃省', '62000000000000', '', '1', '2314.234', '2314.234', '2314.234', '2018-08-16 15:16:35');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `login_name` varchar(50) NOT NULL COMMENT '登录名称',
  `login_password` varchar(64) NOT NULL COMMENT '登录密码',
  `name` varchar(50) DEFAULT NULL COMMENT '登录用户真实名称',
  `area_id` varchar(64) DEFAULT NULL COMMENT '地区id外键',
  `organization_id` varchar(64) DEFAULT NULL COMMENT '机构外键',
  `phone` varchar(11) DEFAULT NULL COMMENT '电话号码',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `sex` int(1) DEFAULT NULL COMMENT '性别',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '当前系统时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工表';

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('0a61d9d433bb11e9a62868f7285847c8', 'wqc', '111111', '王启超', '测试5', '测试', '1345654567', '2@sa.com', '1', '2019-02-19 09:38:07');
INSERT INTO `employee` VALUES ('0a61d9e133bb11e9a62868f7285847c8', 'zf', '111111', '张飞', '测试6', '测试', '1345654567', '2@sa.com', '1', '2019-02-19 09:38:07');
INSERT INTO `employee` VALUES ('0a61d9f833bb11e9a62868f7285847c8', 'lb', '111111', '刘备', '测试8', '测试', '1345654567', '2@sa.com', '1', '2019-02-19 09:38:07');
INSERT INTO `employee` VALUES ('0a61da0033bb11e9a62868f7285847c8', 'cc', '111111', '曹操', '测试9', '测试', '1345654567', '2@sa.com', '1', '2019-02-19 09:38:07');
INSERT INTO `employee` VALUES ('0a61da0e33bb11e9a62868f7285847c8', 'smy', '111111', '司马懿', '测试', '测试', '1345654567', '2@sa.com', '1', '2019-02-19 09:38:07');
INSERT INTO `employee` VALUES ('0a61da1733bb11e9a62868f7285847c8', 'wxf', '111111', '王熙凤', '测试', '测试', '1345654567', '2@sa.com', '0', '2019-02-19 17:50:21');
INSERT INTO `employee` VALUES ('0a61da2d33bb11e9a62868f7285847c8', 'gly', '111111', '管理员', '测试', '测试', '1345654567', '2@sa.com', '1', '2019-02-19 09:38:07');
INSERT INTO `employee` VALUES ('28d3833433ba11e9a62868f7285847c8', 'wzc', '111111', '王芝草', '测试', '测试', '1345654567', '2@sa.com', '1', '2019-02-19 09:31:48');
INSERT INTO `employee` VALUES ('6ddd2841c2f011e89d3e8cec4b81c244', 'lxv', '4240f62bf61488766afb76402ab1340d', '李晓伟', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '13520070216', 'lxv@sina.com', '1', '2018-10-23 16:16:36');
INSERT INTO `employee` VALUES ('7ca2814a333711e9a62868f7285847c8', 'czy', '111111', '蔡宗昱', '北京市', '同创', '13545676567', 'czy@sina.com', '0', '2019-02-18 17:56:30');
INSERT INTO `employee` VALUES ('a2a3f670cbb211e89d3e8cec4b81c244', 'jxc', 'd89eed7ffaf469b365ec0d0bc2803a1b', '姜新灿', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '18501377889', 'alittlexincan@sina.com', '1', '2018-10-09 19:00:46');

-- ----------------------------
-- Table structure for employee_role
-- ----------------------------
DROP TABLE IF EXISTS `employee_role`;
CREATE TABLE `employee_role` (
  `id` varchar(64) NOT NULL COMMENT '用户角色ID',
  `employee_id` varchar(64) DEFAULT NULL COMMENT '用户ID',
  `role_id` varchar(64) DEFAULT NULL COMMENT '角色ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of employee_role
-- ----------------------------
INSERT INTO `employee_role` VALUES ('853478eb15fc11e9a0a268f7285847c8', 'a2a3f670cbb211e89d3e8cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '2019-01-12 18:48:53');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` varchar(64) NOT NULL COMMENT '菜单id',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `code` varchar(50) NOT NULL COMMENT '菜单编码',
  `url` varchar(50) NOT NULL COMMENT '菜单路径',
  `p_id` varchar(64) NOT NULL COMMENT '菜单父类id',
  `icon` varchar(50) DEFAULT '' COMMENT '菜单图标',
  `level` smallint(1) DEFAULT NULL COMMENT '菜单管理：1：一级；2：二级；3：三级',
  `area_id` varchar(64) DEFAULT NULL COMMENT '地区ID',
  `organization_id` varchar(64) DEFAULT NULL COMMENT '机构ID',
  `turn` smallint(3) DEFAULT NULL COMMENT '菜单排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('146a66e4ef0711e881078cec4b81c244', '员工管理', 'employee', 'page/sys/employee', '14ab4a7bef0711e881078cec4b81c244', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '3', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('1479e78cef0711e881078cec4b81c244', '导航', 'nav-manager', '', 'navigation', 'layui-icon layui-icon-home', '1', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '1', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('147f33aeef0711e881078cec4b81c244', '角色管理', 'role', 'page/sys/role', '14ab4a7bef0711e881078cec4b81c244', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '4', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('14871975ef0711e881078cec4b81c244', '权限管理', 'permission', 'page/sys/permission', '14ab4a7bef0711e881078cec4b81c244', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '5', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('148e8ce7ef0711e881078cec4b81c244', '主页', 'home', 'home', '1479e78cef0711e881078cec4b81c244', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '0', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('149454dbef0711e881078cec4b81c244', '菜单管理', 'menu', 'page/sys/menu', '14ab4a7bef0711e881078cec4b81c244', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '2', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('149fe6b3ef0711e881078cec4b81c244', '地区管理', 'area', 'page/sys/area', '14ab4a7bef0711e881078cec4b81c244', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '0', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('14ab4a7bef0711e881078cec4b81c244', '系统管理', 'system-manager', '', 'navigation', 'layui-icon layui-icon-app', '1', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '5', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('14c31d5eef0711e881078cec4b81c244', '机构管理', 'organization', 'page/sys/organization', '14ab4a7bef0711e881078cec4b81c244', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '1', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('22b2d5e1a5d6497383cad88955bd908c', '数据库管理', 'table-manager', '', 'navigation', 'layui-icon layui-icon-template-1', '1', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '4', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('258946874ee246a881197355bc6bc1d9', '类型管理', 'table-type', '/page/source/type', '22b2d5e1a5d6497383cad88955bd908c', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '1', '2018-10-09 19:00:46');
INSERT INTO `menu` VALUES ('52c6cf70c2e24941a8275fd808512b12', '表单管理', 'source-table', '/page/source/table', '22b2d5e1a5d6497383cad88955bd908c', '', '2', '52db5b81970911e8a5ed8cec4b81c244', 'ec936abf987811e8a5ed8cec4b81c244', '2', '2018-10-09 19:00:46');

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` varchar(64) NOT NULL COMMENT '机构id',
  `organization_name` varchar(50) NOT NULL COMMENT '机构名称',
  `code` varchar(14) DEFAULT NULL COMMENT '机构编码',
  `p_id` varchar(64) DEFAULT NULL COMMENT '机构父类id',
  `area_id` varchar(64) DEFAULT NULL COMMENT '地区id',
  `type` smallint(1) DEFAULT '0' COMMENT '机构类型:0:发布中心；1：预案单位；2：应急办',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='机构表';

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES ('4b876483ed5f11e881078cec4b81c244', '庆阳市气象局', '62100000000000', 'caa42816a6a611e8bee28cec4b81c244', '4c55dcdc970511e8a5ed8cec4b81c244', '1', '2018-11-21 15:30:06');
INSERT INTO `organization` VALUES ('caa42816a6a611e8bee28cec4b81c244', '甘肃省气象局', '62000000000000', '', '9aaef2f0970011e8a5ed8cec4b81c244', '0', '2018-08-23 15:33:01');
INSERT INTO `organization` VALUES ('ec936abf987811e8a5ed8cec4b81c244', '华池县气象局', '62102300000000', '4b876483ed5f11e881078cec4b81c244', '52db5b81970911e8a5ed8cec4b81c244', '1', '2018-11-21 15:30:28');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` varchar(64) NOT NULL COMMENT '权限主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限名称',
  `permission` varchar(100) DEFAULT NULL COMMENT '权限字符串,menu例子：role:*，button例子：role:create,role:update,role:delete,role:detail',
  `type` varchar(20) DEFAULT NULL COMMENT '资源类型，[menu、button]',
  `url` varchar(100) DEFAULT NULL COMMENT '资源路径.',
  `status` smallint(1) DEFAULT NULL COMMENT '是否可用：0：不可用；1：可用；如果不可用将不会添加给用户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统权限表';

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('3464441fc3ce11e89d3e8cec4b81c244', '菜单分配', 'menu', 'button', null, '1', '2018-09-29 17:58:13');
INSERT INTO `permission` VALUES ('38b4d465c3ce11e89d3e8cec4b81c244', '权限分配', 'permission', 'button', null, '1', '2018-09-29 17:58:21');
INSERT INTO `permission` VALUES ('3b5ee72ec3ce11e89d3e8cec4b81c244', '角色分配', 'role', 'button', null, '1', '2018-09-29 17:58:25');
INSERT INTO `permission` VALUES ('3e74ecbbc3ce11e89d3e8cec4b81c244', '下载操作', 'download', 'button', null, '1', '2018-09-29 17:58:30');
INSERT INTO `permission` VALUES ('41bde292c3ce11e89d3e8cec4b81c244', '上传操作', 'upload', 'button', null, '1', '2018-09-29 17:58:36');
INSERT INTO `permission` VALUES ('44a2eee4c3ce11e89d3e8cec4b81c244', '导出操作', 'export', 'button', null, '1', '2018-09-29 17:58:41');
INSERT INTO `permission` VALUES ('46c80075c3ce11e89d3e8cec4b81c244', '导入操作', 'import', 'button', null, '1', '2018-09-29 17:58:44');
INSERT INTO `permission` VALUES ('491bc1b0c3ce11e89d3e8cec4b81c244', '批量删除', 'batch', 'button', null, '1', '2018-09-29 17:58:48');
INSERT INTO `permission` VALUES ('4b327181c3ce11e89d3e8cec4b81c244', '删除操作', 'delete', 'button', null, '1', '2018-09-29 17:58:52');
INSERT INTO `permission` VALUES ('4d3f321dc3ce11e89d3e8cec4b81c244', '修改操作', 'update', 'button', null, '1', '2018-09-29 17:58:55');
INSERT INTO `permission` VALUES ('51ffa007c3ce11e89d3e8cec4b81c244', '添加操作', 'insert', 'button', null, '1', '2018-09-29 17:59:03');
INSERT INTO `permission` VALUES ('7d61054ccc6111e89d3e8cec4b81c244', '录入操作', 'edit', 'button', null, '1', '2018-10-10 15:52:26');
INSERT INTO `permission` VALUES ('816d533fcc6111e89d3e8cec4b81c244', '审核操作', 'verify', 'button', null, '1', '2018-10-10 15:52:32');
INSERT INTO `permission` VALUES ('85b57b3ecc6111e89d3e8cec4b81c244', '签发操作', 'issue', 'button', null, '1', '2018-10-10 15:52:40');
INSERT INTO `permission` VALUES ('896773f3cc6111e89d3e8cec4b81c244', '应急签发', 'emergency', 'button', null, '1', '2018-10-10 15:52:46');
INSERT INTO `permission` VALUES ('8c2a0f2bcc6111e89d3e8cec4b81c244', '发布操作', 'publish', 'button', null, '1', '2018-10-10 15:52:50');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` varchar(64) NOT NULL COMMENT '主键ID',
  `role` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `description` varchar(200) DEFAULT NULL COMMENT '角色描述',
  `status` smallint(1) DEFAULT NULL COMMENT '是否可用：0：不可用；1：可用；如果不可用将不会添加给用户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('3710ed75ee2711e881078cec4b81c244', '管理员', '', '1', '2018-11-22 15:21:05');
INSERT INTO `role` VALUES ('8f9d2a0ed68411e89a818cec4b81c244', '超级管理员', '超级管理员', '1', '2018-10-23 13:28:50');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` varchar(64) NOT NULL COMMENT '角色对应菜单ID',
  `role_id` varchar(64) DEFAULT NULL COMMENT '角色ID',
  `menu_id` varchar(64) DEFAULT NULL COMMENT '菜单ID',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色分配菜单';

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('7f802a8b168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '1479e78cef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802ae8168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '148e8ce7ef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802af6168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '149972b9ef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802aff168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '149fe6b3ef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b08168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '14c31d5eef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b15168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '22b2d5e1a5d6497383cad88955bd908c', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b2b168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '258946874ee246a881197355bc6bc1d9', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b39168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '52c6cf70c2e24941a8275fd808512b12', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b42168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '14ab4a7bef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b4f168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '149454dbef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b58168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '146a66e4ef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b61168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '147f33aeef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('7f802b6e168711e9a0a268f7285847c8', '8f9d2a0ed68411e89a818cec4b81c244', '14871975ef0711e881078cec4b81c244', '2019-01-13 11:23:36');
INSERT INTO `role_menu` VALUES ('96804975ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '10c35f0fcaa911e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049b9ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '367a914ccaae11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049bfee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '68aaab7acaa911e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049c4ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '6f014044caac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049caee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '7f720469caac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049d3ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '8cada440caac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049d8ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', 'a1d864dbcaac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049deee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', 'b2b2226ccaac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049e7ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', 'c8b0349ccaac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049ecee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '743364deee2211e881078cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('968049f5ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '9dc18cb1ee2211e881078cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('96804a06ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '7de8a3fbcaa911e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('96804a0cee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '51a018c1caaa11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('96804a11ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '0a79d9e2caac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('96804a17ee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '1adcb306caac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');
INSERT INTO `role_menu` VALUES ('96804a1dee2711e881078cec4b81c244', '3710ed75ee2711e881078cec4b81c244', '2afe6cb2caac11e89d3e8cec4b81c244', '2018-11-22 15:23:45');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` varchar(64) NOT NULL COMMENT '角色权限ID',
  `role_id` varchar(64) DEFAULT NULL COMMENT '角色ID',
  `permission_id` varchar(64) DEFAULT NULL COMMENT '权限ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统角色权限表';

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('edbb4d64d68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '8c2a0f2bcc6111e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb629ad68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '896773f3cc6111e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb6320d68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '85b57b3ecc6111e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb634ad68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '816d533fcc6111e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb6378d68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '7d61054ccc6111e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb639dd68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '51ffa007c3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb63bfd68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '4d3f321dc3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb63e4d68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '4b327181c3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb6409d68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '491bc1b0c3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb642bd68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '46c80075c3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb644ad68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '44a2eee4c3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb646dd68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '41bde292c3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb648fd68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '3e74ecbbc3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb6537d68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '3b5ee72ec3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb6559d68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '38b4d465c3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');
INSERT INTO `role_permission` VALUES ('edbb6578d68511e89a818cec4b81c244', '8f9d2a0ed68411e89a818cec4b81c244', '3464441fc3ce11e89d3e8cec4b81c244', '2018-10-23 13:38:37');

-- ----------------------------
-- Table structure for table_cell_show
-- ----------------------------
DROP TABLE IF EXISTS `table_cell_show`;
CREATE TABLE `table_cell_show` (
  `id` varchar(64) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `content` json DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of table_cell_show
-- ----------------------------
INSERT INTO `table_cell_show` VALUES ('45bc3e6d340311e9a62868f7285847c8', 'admin-user-table', '[{\"prop\": \"loginName\", \"isHide\": true}, {\"prop\": \"loginPassword\", \"isHide\": true}, {\"prop\": \"name\", \"isHide\": true}, {\"prop\": \"sex\", \"isHide\": false}, {\"prop\": \"phone\", \"isHide\": true}, {\"prop\": \"email\", \"isHide\": true}, {\"prop\": \"areaId\", \"isHide\": false}, {\"prop\": \"organizationId\", \"isHide\": false}, {\"prop\": \"createTime\", \"isHide\": true}]', '2019-02-19 18:15:10');

-- ----------------------------
-- Function structure for getAreaCList
-- ----------------------------
DROP FUNCTION IF EXISTS `getAreaCList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getAreaCList`(rootId VARCHAR(64)) RETURNS varchar(4000) CHARSET utf8mb4
BEGIN 

-- 根据当前id查询所有下级子节点，包含当前节点
-- （向下查询） 
-- 操作方式
-- select * From area where FIND_IN_SET(id, getAreaCList('5c8131f4883e11e8b73168f7285847c8'));
	DECLARE sChildList VARCHAR(4000);
	DECLARE sChildTemp VARCHAR(4000);
	SET sChildTemp =cast(rootId as CHAR);
	WHILE sChildTemp is not null DO
		IF (sChildList is not null) THEN
			SET sChildList = concat(sChildList,',',sChildTemp);
		ELSE
			SET sChildList = concat(sChildTemp);
		END IF;
				SELECT group_concat(id) INTO sChildTemp FROM area where FIND_IN_SET(p_id,sChildTemp)>0;
	END WHILE;
	RETURN sChildList;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getAreaPList
-- ----------------------------
DROP FUNCTION IF EXISTS `getAreaPList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getAreaPList`(rootId VARCHAR(64)) RETURNS varchar(4000) CHARSET utf8mb4
BEGIN


-- 根据当前id查询所有上级父节点，包含当前节点
-- （向上查询）
-- 操作方式
-- select * From area where FIND_IN_SET(id, getAreaPList('5c8131f4883e11e8b73168f7285847c8'));

    DECLARE sTemp VARCHAR(4000);
    DECLARE sTempPar VARCHAR(4000); 
    SET sTemp = ''; 
    SET sTempPar =rootId; 
 
    #循环递归
    WHILE sTempPar is not null DO 
        #判断是否是第一个，不加的话第一个会为空
        IF sTemp != '' THEN
            SET sTemp = concat(sTemp,',',sTempPar);
        ELSE
            SET sTemp = sTempPar;
        END IF;
        SET sTemp = concat(sTemp,',',sTempPar); 
        SELECT group_concat(p_id) INTO sTempPar FROM area where p_id<>id and FIND_IN_SET(id,sTempPar)>0; 
    END WHILE; 
 
RETURN sTemp; 
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getOrgCList
-- ----------------------------
DROP FUNCTION IF EXISTS `getOrgCList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getOrgCList`(rootId VARCHAR(64)) RETURNS varchar(4000) CHARSET utf8mb4
BEGIN 

-- 根据当前id查询所有下级子节点，包含当前节点
-- （向下查询） 
-- 操作方式
-- select * From area where FIND_IN_SET(id, getOrgCList('5c8131f4883e11e8b73168f7285847c8'));
	DECLARE sChildList VARCHAR(4000);
	DECLARE sChildTemp VARCHAR(4000);
	SET sChildTemp =cast(rootId as CHAR);
	WHILE sChildTemp is not null DO
		IF (sChildList is not null) THEN
			SET sChildList = concat(sChildList,',',sChildTemp);
		ELSE
			SET sChildList = concat(sChildTemp);
		END IF;
				SELECT group_concat(id) INTO sChildTemp FROM organization where FIND_IN_SET(p_id,sChildTemp)>0;
	END WHILE;
	RETURN sChildList;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getOrgPList
-- ----------------------------
DROP FUNCTION IF EXISTS `getOrgPList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getOrgPList`(rootId VARCHAR(64)) RETURNS varchar(4000) CHARSET utf8mb4
BEGIN


-- 根据当前id查询所有上级父节点，包含当前节点
-- （向上查询）
-- 操作方式
-- select * From area where FIND_IN_SET(id, getOrgPList('5c8131f4883e11e8b73168f7285847c8'));

    DECLARE sTemp VARCHAR(4000);
    DECLARE sTempPar VARCHAR(4000); 
    SET sTemp = ''; 
    SET sTempPar =rootId; 
 
    #循环递归
    WHILE sTempPar is not null DO 
        #判断是否是第一个，不加的话第一个会为空
        IF sTemp != '' THEN
            SET sTemp = concat(sTemp,',',sTempPar);
        ELSE
            SET sTemp = sTempPar;
        END IF;
        SET sTemp = concat(sTemp,',',sTempPar); 
        SELECT group_concat(p_id) INTO sTempPar FROM organization where p_id<>id and FIND_IN_SET(id,sTempPar)>0; 
    END WHILE; 
 
RETURN sTemp; 
END
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
