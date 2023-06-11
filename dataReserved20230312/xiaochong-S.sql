/*
 Navicat Premium Data Transfer

 Source Server         : TXYun-S
 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Host           : 43.138.81.135:3306
 Source Schema         : xiaochong

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 11/06/2023 22:24:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES (1, 'iii', 'ooo');
INSERT INTO `person` VALUES (2, 'tt', 'hh');
INSERT INTO `person` VALUES (3, '', '');

-- ----------------------------
-- Table structure for projectInfo
-- ----------------------------
DROP TABLE IF EXISTS `projectInfo`;
CREATE TABLE `projectInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `parent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目父级',
  `status` enum('打开','关闭','暂停') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目状态',
  `userInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目组成员',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '项目简介',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `parent`(`parent`) USING BTREE,
  INDEX `userInfo`(`userInfo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of projectInfo
-- ----------------------------
INSERT INTO `projectInfo` VALUES (1, '中科海芯发电机配置', NULL, '打开', '2,3,4', '中科海芯发电机配置简介');
INSERT INTO `projectInfo` VALUES (2, '中科海芯项目打包配置', NULL, '打开', '1,2,3', '中科海芯项目打包配置简介');
INSERT INTO `projectInfo` VALUES (3, '国家电网潮流仿真', NULL, '暂停', '1,2', '国家电网潮流仿真简介');
INSERT INTO `projectInfo` VALUES (4, 'antd pro组件库', NULL, '关闭', '1,3', 'antd pro组件库简介');
INSERT INTO `projectInfo` VALUES (5, '中科海芯管脚配置项目', NULL, '打开', '2,4', '中科海芯管脚配置项目简介');
INSERT INTO `projectInfo` VALUES (6, '石墨工厂工艺流程平台', NULL, '关闭', '1,2,3', '石墨工厂工艺流程平台简介');
INSERT INTO `projectInfo` VALUES (7, '在线课堂学习系统', NULL, '暂停', '4,5,6', '在线课堂学习系统简介');
INSERT INTO `projectInfo` VALUES (8, '开放平台', NULL, '打开', '2', '开放平台简介');
INSERT INTO `projectInfo` VALUES (9, 'Chat GPT智能AI平台', NULL, '打开', '3,5', 'Chat GPT智能AI平台简介');
INSERT INTO `projectInfo` VALUES (10, 'Chat AI智能助手', NULL, '打开', '2', 'Chat AI智能助手简介');

-- ----------------------------
-- Table structure for roleInfo
-- ----------------------------
DROP TABLE IF EXISTS `roleInfo`;
CREATE TABLE `roleInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `routerInfo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '路由权限',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roleInfo
-- ----------------------------
INSERT INTO `roleInfo` VALUES (1, 'admin', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16', NULL);
INSERT INTO `roleInfo` VALUES (2, 'user', '1,2,3,4,5,6,7,8,9,10,11,13,14,15', NULL);
INSERT INTO `roleInfo` VALUES (3, 'staff', '1,2', NULL);

-- ----------------------------
-- Table structure for routerInfo
-- ----------------------------
DROP TABLE IF EXISTS `routerInfo`;
CREATE TABLE `routerInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `component` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端对应界面入口路径',
  `path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面访问路径',
  `type` enum('project','wiki','task','user','home') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由所属类型（控制左侧菜单栏显示）',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ROUTERINFO_PATH`(`path`) USING BTREE COMMENT '唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of routerInfo
-- ----------------------------
INSERT INTO `routerInfo` VALUES (1, 'login', './User/Login', '/user/login', NULL, '登录页');
INSERT INTO `routerInfo` VALUES (2, 'welcome', './Welcome', '/welcome', 'home', '欢迎页');
INSERT INTO `routerInfo` VALUES (4, 'project', './Project', '/project/list', 'project', '项目列表页');
INSERT INTO `routerInfo` VALUES (5, 'task', './Task', '/task/list', 'task', '任务列表页');
INSERT INTO `routerInfo` VALUES (6, NULL, './Task/components/TaskDetail.tsx', '/task/list/detail', 'task', '任务详情页');
INSERT INTO `routerInfo` VALUES (7, 'wiki', './Wiki', '/wiki/list', 'wiki', 'wiki页');
INSERT INTO `routerInfo` VALUES (8, 'appointme', './Task/components/AppointMe.tsx', '/task/appointme', 'task', '分配给我');
INSERT INTO `routerInfo` VALUES (9, 'createdbyme', './Task/components/CreatedByMe.tsx', '/task/createdbyme', 'task', '由我创建');
INSERT INTO `routerInfo` VALUES (10, NULL, './Task/components/TaskDetail.tsx', '/task/createdbyme/detail', 'task', '由我创建详情页');
INSERT INTO `routerInfo` VALUES (11, NULL, './Task/components/TaskDetail.tsx', '/task/appointme/detail', 'task', '分配给我详情页');
INSERT INTO `routerInfo` VALUES (12, NULL, './User/Manager', '/userManagement/list', 'user', '用户管理页');
INSERT INTO `routerInfo` VALUES (13, NULL, './User/Personal', '/personal', 'user', '个人中心页');
INSERT INTO `routerInfo` VALUES (14, NULL, './Wiki/components/WikiDetail.tsx', '/wiki/list/detail', 'wiki', 'wiki详情页');
INSERT INTO `routerInfo` VALUES (15, NULL, './Project/components/ProjectDetail.tsx', '/project/list/detail', 'project', '项目详情页');
INSERT INTO `routerInfo` VALUES (16, NULL, './User/Add', '/user/add', 'user', '用户添加页');

-- ----------------------------
-- Table structure for taskInfo
-- ----------------------------
DROP TABLE IF EXISTS `taskInfo`;
CREATE TABLE `taskInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一识别、主键自增',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `type` enum('会议','代码开发','BUG','环境搭建','文档编写','其他任务') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务类型',
  `status` enum('新建','进行中','已完成','暂停中','待办任务','已关闭') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `leval` enum('高','中','低','最高级') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优先级',
  `createdBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `createdTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `endTime` datetime NULL DEFAULT NULL COMMENT '结束日期',
  `appoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '指定人',
  `project` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属项目',
  `taskUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '更新表ID',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '最新的更新时间',
  `estimatedTime` int(11) NULL DEFAULT NULL COMMENT '预估时间',
  `consumeTime` int(11) NULL DEFAULT NULL COMMENT '已耗时间',
  `leftTime` int(11) NULL DEFAULT NULL COMMENT '剩余时间',
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '任务详情',
  `parent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级任务',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `taskInfo_appoint_userinfo_name`(`appoint`) USING BTREE,
  INDEX `taskInfo_createdBy_userinfo_name`(`createdBy`) USING BTREE,
  INDEX `taskInfo_parent_taskInfo_name`(`parent`) USING BTREE,
  INDEX `taskInfo_project_projectInfo_name`(`project`) USING BTREE,
  CONSTRAINT `taskInfo_appoint_userinfo_name` FOREIGN KEY (`appoint`) REFERENCES `userInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `taskInfo_createdBy_userinfo_name` FOREIGN KEY (`createdBy`) REFERENCES `userInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `taskInfo_parent_taskInfo_name` FOREIGN KEY (`parent`) REFERENCES `taskInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of taskInfo
-- ----------------------------
INSERT INTO `taskInfo` VALUES (2, '定义平台的产品和业务范围', '会议', '已完成', '高', 'root', '2023-03-02 21:46:35', '2023-03-05 00:00:00', 'test', '开放平台', NULL, '2023-05-21 21:53:00', 5, 4, 1, '<h1><span style=\"color:#24292f\"><span style=\"background-color:#f4f6f8\"><strong><span style=\"font-size:30px\">明确平台的定位、目标用户和服务领域，为后续开发和推广工作做好铺垫。</span></strong></span></span></h1><p style=\"text-align:start;text-indent:2em;\"><strong>定义平台的产品和业务范围是一个非常重要的步骤，它涉及到平台的定位、目标用户和服务领域等关键因素。下面是详细的解释：</strong></p><ol><li>定位：平台的定位是指明确平台所处的市场位置以及与其他竞争对手的差异化。例如，你可能会选择将平台定位为某个行业的专业平台，或者是为广大消费者提供多种服务的全能性平台。</li><li>目标用户：平台的目标用户是指针对哪些人群提供服务。在定义目标用户时，你需要考虑他们的需求、痛点、购买力等因素，以便更好地满足他们的需求。例如，如果你的平台是定位于家长和孩子的在线教育平台，那么你的目标用户就是家长和有学习需求的孩子。</li><li>服务领域：平台的服务领域是指平台所提供服务的范围。例如，你可能会选择将平台定位为一个电商平台，提供各种商品和服务；或者你可能会选择将平台定位为一个社交平台，提供用户之间的交流、分享和娱乐等服务。</li></ol><p style=\"text-align:start;text-indent:2em;\">总之，定义平台的产品和业务范围需要仔细考虑市场需求、用户需求和竞争环境等因素，以便确定平台的目标定位和服务方向，从而更好地满足用户需求并提高平台的市场竞争力。</p><p></p><p> 相关链接：<a href=\"https://www.processon.com/diagrams\" target=\"_blank\">https://www.processon.com/diagrams</a></p><p></p><p></p><p></p><p>😲</p>', NULL);
INSERT INTO `taskInfo` VALUES (3, '设计系统架构', '环境搭建', '新建', '中', 'user', '2023-03-02 22:11:02', '2023-05-21 00:00:00', 'user', '中科海芯项目打包配置', NULL, '2023-05-21 20:22:00', 2, 1, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">根据业务需求，设计合理的系统架构，包括前后端技术选型、数据库设计、API 接口定义等。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (4, '用户注册和登录功能开发', '代码开发', '暂停中', '低', 'test', '2023-03-04 15:16:40', '2023-05-01 00:00:00', 'test', '中科海芯发电机配置', NULL, '2023-05-21 20:22:48', 4, 3, 2, '<ol><li><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">实现用户注册、登录、找回密码等基本功能，并保证用户信息的安全存储和传输。</span></span></span></li></ol>', NULL);
INSERT INTO `taskInfo` VALUES (5, '设计系统架构', '其他任务', '新建', '中', 'staff1', '2023-03-04 15:19:26', '2023-05-07 00:00:00', 'test2', '开放平台', NULL, '2023-05-21 20:18:33', 4, 2, 3, '<p>天天</p>', NULL);
INSERT INTO `taskInfo` VALUES (6, '商品管理功能开发', '代码开发', '已完成', '高', 'staff2', '2023-03-19 12:31:18', '2023-03-30 00:00:00', 'user', '国家电网潮流仿真', NULL, '2023-05-21 20:23:36', 4, 3, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">商家可以发布、编辑、下架商品，上传图片和设置规格等信息，并保障数据的准确性。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (7, '订单管理功能开发', '会议', '新建', '中', 'root', '2023-03-19 15:25:00', '2023-05-21 00:00:00', 'user', 'antd pro组件库', NULL, '2023-05-21 20:24:02', 4, 2, 2, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">商家可以管理订单，查看订单详情、修改发货状态，用户也可以查看订单状态和历史记录。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (8, '数据统计和分析功能开发', '代码开发', '进行中', '低', 'root', '2023-03-19 15:26:40', '2023-05-21 00:00:00', 'user', '中科海芯项目打包配置', NULL, '2023-05-21 20:24:25', 3, 2, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">实时监控数据，对访问量、销售额、用户行为等指标进行统计和分析，并提供可视化报告。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (9, '营销活动功能开发', 'BUG', '进行中', '中', 'test', '2023-03-19 15:54:22', '2023-04-05 00:00:00', 'root', '中科海芯发电机配置', NULL, '2023-05-21 20:24:43', 1, 2, 3, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">商家可以创建促销活动，比如限时特价、满减折扣等，以吸引用户关注和购买。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (10, '支付功能开发', '会议', '已关闭', '中', 'user', '2023-03-19 15:55:47', '2023-04-11 21:56:14', 'staff2', '中科海芯发电机配置', NULL, '2023-05-21 20:25:10', 4, 3, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">支持多种支付方式，包括微信、支付宝、银联等主流支付方式，并确保交易过程的安全性和稳定性。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (11, '物流跟踪功能开发', '会议', '进行中', '中', 'staff1', '2023-05-05 00:00:00', '2023-05-06 00:00:00', 'staff3', '中科海芯发电机配置', NULL, '2023-05-21 20:25:36', 1, 2, 3, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">与各大物流公司对接，能够实时查询物流信息并通知用户订单状态，提高用户体验。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (12, '客户服务功能开发', '会议', '进行中', '高', 'root', '2023-05-13 00:00:00', '2023-05-21 00:00:00', 'user', '中科海芯项目打包配置', NULL, '2023-05-21 20:26:17', 5, 2, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">提供在线客服功能，解答用户问题和反馈，并支持售后服务，提升用户满意度。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (13, '定义配置数据结构', '代码开发', '进行中', '中', 'root', '2023-05-21 00:00:00', '2023-05-24 00:00:00', 'user', '中科海芯项目打包配置', NULL, '2023-06-07 10:18:33', 3, 2, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">明确芯片配置的属性和参数，设计合理的数据结构，并提供合适的接口对其进行增删改查操作。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (14, '实现数据存储', '代码开发', '进行中', '中', 'user', '2023-05-01 00:00:00', '2023-05-02 00:00:00', 'root', '中科海芯项目打包配置', NULL, '2023-05-21 20:28:26', 3, 1, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">选择合适的数据库方案，将芯片配置数据存储在数据库中。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (15, '设计用户界面', '会议', '进行中', '高', 'test1', '2023-05-20 00:00:00', '2023-05-25 00:00:00', 'test2', '中科海芯项目打包配置', NULL, '2023-05-21 20:28:54', 4, 2, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">根据需求设计可视化界面，包括布局、样式、交互等。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (16, '开发绘图组件', '环境搭建', '进行中', '高', 'test', '2023-05-21 00:00:00', '2023-05-23 00:00:00', 'test', '中科海芯发电机配置', NULL, '2023-05-21 20:29:16', 4, 2, 2, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">实现绘图组件，支持画线、圆形、矩形等基本图形，并能够响应用户的操作事件。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (17, '实现拖拽功能', '文档编写', '进行中', '中', 'staff2', '2023-05-19 00:00:00', '2023-05-26 00:00:00', 'staff1', '中科海芯发电机配置', NULL, '2023-05-21 20:29:42', 4, 2, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">支持芯片和连接线元素的拖拽操作，用户可以通过鼠标拖动元素来进行布局调整。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (18, '实现缩放功能', 'BUG', '待办任务', '低', 'staff3', '2023-05-04 00:00:00', '2023-05-31 00:00:00', 'test1', '中科海芯发电机配置', NULL, '2023-05-21 20:30:04', 5, 2, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">支持缩放画布和元素大小，以便用户能够更加方便地查看和编辑芯片配置。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (19, '实现对齐和分布功能', '会议', '已完成', '中', 'user', '2023-05-20 00:00:00', '2023-05-27 00:00:00', 'test', '中科海芯发电机配置', NULL, '2023-05-21 20:30:25', 5, 1, 1, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">支持对元素进行对齐和分布，以保证芯片配置的布局更加整齐美观。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (20, '实现撤销和重做功能', '代码开发', '已完成', '中', 'root', '2023-05-15 19:48:24', '2023-05-17 00:00:00', 'user', '中科海芯发电机配置', NULL, '2023-05-21 20:30:44', 1, 2, 3, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">支持撤销和重做操作，以便用户能够及时修正错误或者回退操作。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (21, '提供导入导出功能', '会议', '进行中', '中', 'test2', '2023-05-26 00:00:00', '2023-05-27 00:00:00', 'test1', '中科海芯发电机配置', NULL, '2023-05-21 20:31:05', 1, 1, 1, '<p>内容<span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">支持导入和导出芯片配置数据，比如JSON格式或者XML格式，以方便用户共享和备份数据。</span></span></span></p>', NULL);
INSERT INTO `taskInfo` VALUES (22, '提供交互式调试功能', '代码开发', '已完成', '低', 'root', '2023-05-02 00:00:00', '2023-05-10 00:00:00', 'staff3', '开放平台', NULL, '2023-05-21 20:32:12', 5, 2, 4, '<p><span style=\"color:#24292f\"><span style=\"font-size:14px\"><span style=\"background-color:#f4f6f8\">支持在可视化界面中进行芯片配置参数的实时调整和调试，以便用户可以更方便地优化芯片配置。</span></span></span></p>', NULL);

-- ----------------------------
-- Table structure for taskupdateInfo
-- ----------------------------
DROP TABLE IF EXISTS `taskupdateInfo`;
CREATE TABLE `taskupdateInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updateBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `taskUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '后续更新的信息ID',
  `updateContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新后的内容',
  `changeContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变更的内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `taskupdateInfo_updateBy_userInfo_name`(`updateBy`) USING BTREE,
  CONSTRAINT `taskupdateInfo_updateBy_userInfo_name` FOREIGN KEY (`updateBy`) REFERENCES `userInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of taskupdateInfo
-- ----------------------------
INSERT INTO `taskupdateInfo` VALUES (1, 'root', '2023-03-01 22:05:03', NULL, '更改内容一', NULL);
INSERT INTO `taskupdateInfo` VALUES (2, 'user', '2023-03-04 15:05:33', NULL, '更改内容二', NULL);
INSERT INTO `taskupdateInfo` VALUES (3, 'test', '2023-03-02 22:05:55', NULL, '更改内容三', NULL);

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test
-- ----------------------------

-- ----------------------------
-- Table structure for userInfo
-- ----------------------------
DROP TABLE IF EXISTS `userInfo`;
CREATE TABLE `userInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一识别、主键自增',
  `account` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码（加密）',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `avatar` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `roleInfo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应角色ID',
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐（用于加密）',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `job` enum('前端工程师','后端工程师','实习生') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职位',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `USERINFO_NAME`(`name`) USING BTREE COMMENT '值唯一',
  INDEX `USERINFO_ROLEINFO_ROLEINFO`(`roleInfo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of userInfo
-- ----------------------------
INSERT INTO `userInfo` VALUES (1, 'admin', 'ant.design', 'root', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', '123@qq.conmm', '15030077895', 'admin', '1', '2023-04-21', '前端工程师');
INSERT INTO `userInfo` VALUES (2, 'user', 'ant.design', 'user', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', '449', '13230009184', 'user', NULL, '2023-04-06', '前端工程师');
INSERT INTO `userInfo` VALUES (3, 'test', 'ant.design', 'test', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, '13230009584', 'staff', NULL, NULL, '实习生');
INSERT INTO `userInfo` VALUES (4, 'staff1', 'staff', 'staff1', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'staff', NULL, NULL, '前端工程师');
INSERT INTO `userInfo` VALUES (5, 'staff2', 'staff', 'staff2', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'staff', NULL, NULL, '后端工程师');
INSERT INTO `userInfo` VALUES (6, 'staff3', 'staff', 'staff3', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'admin', NULL, NULL, '实习生');
INSERT INTO `userInfo` VALUES (7, 'test1', '123456', 'test1', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'user', NULL, NULL, '前端工程师');
INSERT INTO `userInfo` VALUES (8, 'test2', '123456', 'test2', NULL, NULL, NULL, 'user', NULL, NULL, '实习生');
INSERT INTO `userInfo` VALUES (9, 'account', '123456', 'zhiming-Wang', NULL, NULL, NULL, 'admin', NULL, NULL, '后端工程师');
INSERT INTO `userInfo` VALUES (10, 'admin1', '123456', 'dawei-Zhang', NULL, NULL, NULL, 'admin', NULL, NULL, '前端工程师');

-- ----------------------------
-- Table structure for wikiInfo
-- ----------------------------
DROP TABLE IF EXISTS `wikiInfo`;
CREATE TABLE `wikiInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'HTML内容',
  `project` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属项目',
  `createdBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `createdTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateInfo` int(11) NULL DEFAULT NULL COMMENT '更新的信息ID',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '最新的更新时间',
  `parent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级wiki',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `title`(`title`) USING BTREE,
  INDEX `wikiInfo_createdBy_userInfo_name`(`createdBy`) USING BTREE,
  INDEX `wikiInfo_parent_wikiInfo_title`(`parent`) USING BTREE,
  INDEX `wikiInfo_project_projectInfo_name`(`project`) USING BTREE,
  INDEX `wikiInfo_updateInfo_wikiupdateInfo_id`(`updateInfo`) USING BTREE,
  CONSTRAINT `wikiInfo_createdBy_userInfo_name` FOREIGN KEY (`createdBy`) REFERENCES `userInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wikiInfo_parent_wikiInfo_title` FOREIGN KEY (`parent`) REFERENCES `wikiInfo` (`title`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wikiInfo_project_projectInfo_name` FOREIGN KEY (`project`) REFERENCES `projectInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wikiInfo_updateInfo_wikiupdateInfo_id` FOREIGN KEY (`updateInfo`) REFERENCES `wikiupdateInfo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wikiInfo
-- ----------------------------
INSERT INTO `wikiInfo` VALUES (1, 'cmakelist cmakefile 概念', '<h2><span style=\"font-size:30px\">cmakelist cmakefile 概念</span></h2><p style=\"text-indent:2em;\">CMake 是一个跨平台的构建工具，用于管理软件项目的构建过程。CMake 的主要功能是生成用于不同构建系统（如 Make、Ninja、Visual Studio 等）的构建文件，其中最常见的是生成 Makefile 或 Visual Studio 的解决方案文件。<br/>        CMakeLists.txt 是一个用于描述项目构建过程的文本文件，它包含了项目的配置信息、目录结构、依赖项、编译选项等内容。CMakeLists.txt 文件通过 CMake 解析，根据其中的指令和参数生成相应的构建文件。</p><p><br/><strong>CMakeLists.txt 文件通常包含以下常用指令：</strong><br/></p><ol><li><code>cmake_minimum_required(VERSION &lt;version&gt;)</code>：指定项目所需的最低 CMake 版本。</li><li><code>project(&lt;project_name&gt;)</code>：定义项目的名称。</li><li><code>add_executable(&lt;executable_name&gt; &lt;source_files&gt;)</code>：添加可执行文件，并指定源代码文件。</li><li><code>add_library(&lt;library_name&gt; &lt;source_files&gt;)</code>：添加库文件，并指定源代码文件。</li><li><code>target_link_libraries(&lt;target&gt; &lt;libraries&gt;)</code>：指定目标（可执行文件或库文件）所依赖的库文件。</li><li><code>include_directories(&lt;directory&gt;)</code>：添加头文件搜索路径。</li><li><code>link_directories(&lt;directory&gt;)</code>：添加库文件搜索路径。</li><li><code>add_subdirectory(&lt;directory&gt;)</code>：添加子目录，用于组织和构建多模块项目。</li><li><code>set(&lt;variable&gt; &lt;value&gt;)</code>：设置变量的值。</li></ol><p style=\"text-indent:2em;\">CMakeLists.txt 文件中的指令和参数可以根据项目的需求进行调整和扩展。使用 CMake 和 CMakeLists.txt，您可以实现跨平台的项目构建、依赖管理和可配置的构建选项，使项目的构建过程更加简化和灵活。<br/>      CMakeFiles.txt 是一个自动生成的目录，其中包含由 CMake 生成的临时文件和构建文件。在构建过程中，CMake 会生成构建所需的中间文件和目标文件，并将它们放置在 CMakeFiles.txt 目录中。这些文件在构建完成后可以被清理或忽略，不需要手动编辑或修改。</p><p></p><p></p><p></p>', NULL, 'root', '2023-03-17 22:55:42', 1, '2023-05-21 20:51:28', NULL);
INSERT INTO `wikiInfo` VALUES (2, '如何根据json文件生成对应的CMakelists.txt文件', '<p><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">要根据 JSON 文件生成对应的 CMakeLists.txt 文件，您可以编写一个脚本或程序来处理 JSON 文件并生成 CMakeLists.txt 文件。以下是一个示例 Python 脚本，它使用 JSON 模块解析 JSON 文件并生成对应的 CMakeLists.txt 文件：</span></span></span></p><p></p><pre><code><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">import json</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">def generate_cmakelists(json_data, output_file):</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">    with open(output_file, &#x27;w&#x27;) as f:</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        # 写入 CMake 文件的头部信息</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        f.write(&#x27;cmake_minimum_required(VERSION 3.5)\\n&#x27;)</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        f.write(&#x27;project(MyProject)\\n\\n&#x27;)</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        # 解析 JSON 数据</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        data = json.loads(json_data)</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        # 写入 CMake 的目标和源文件</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        f.write(&#x27;add_executable(MyExecutable &#x27;)</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        for source_file in data[&#x27;source_files&#x27;]:</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">            f.write(source_file + &#x27; &#x27;)</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        f.write(&#x27;)\\n&#x27;)</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        # 写入其他需要的 CMake 设置和依赖项</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        # ...</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        # 写入 CMake 的尾部信息</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        f.write(&#x27;\\n&#x27;)</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        f.write(&#x27;target_link_libraries(MyExecutable &#x27;)</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        for library in data[&#x27;libraries&#x27;]:</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">            f.write(library + &#x27; &#x27;)</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        f.write(&#x27;)\\n&#x27;)</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">        print(&quot;CMakeLists.txt 文件已生成！&quot;)</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\"># 从 JSON 文件中读取数据</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">with open(&#x27;input.json&#x27;, &#x27;r&#x27;) as json_file:</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">    json_data = json_file.read()</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\"># 生成 CMakeLists.txt 文件</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">generate_cmakelists(json_data, &#x27;CMakeLists.txt&#x27;)</span></span></span><br/><br/><br/></code></pre><p style=\"text-align:start;text-indent:2em;\">在上述示例中，您需要将输入的 JSON 文件命名为 <code>input.json</code>，脚本将根据该文件生成 <code>CMakeLists.txt</code> 文件。您可以根据自己的 JSON 数据结构和需求进行调整。请确保在脚本中提供正确的 JSON 数据键名和相应的 CMake 设置。</p><p style=\"text-align:start;text-indent:2em;\">运行此脚本后，将生成一个名为 <code>CMakeLists.txt</code> 的文件，其中包含根据 JSON 数据生成的相应 CMake 设置。请根据需要进行修改和扩展以满足您的项目要求。</p>', NULL, 'user', '2023-03-16 22:55:47', 1, '2023-05-21 20:52:41', NULL);
INSERT INTO `wikiInfo` VALUES (3, '在js字符串中如何遍历一个数组并且数组的每一项值添加到字符串中', '<p><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">在JavaScript中，您可以使用循环结构（如</span></span></span><code>for</code><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">循环或</span></span></span><code>forEach</code><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">方法）来遍历数组，并将数组的每个值添加到字符串中。以下是两种常见的方法：</span></span></span></p><pre><code><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">// 示例数组</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">var myArray = [1, 2, 3, 4, 5];</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">// 字符串变量</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">var myString = &quot;&quot;;</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">// 遍历数组并将每个值添加到字符串中</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">for (var i = 0; i &lt; myArray.length; i++) {</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">  myString += myArray[i];</span></span></span><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">}</span></span></span><br/><br/><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">console.log(myString);</span></span></span></code></pre><p><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">上述代码通过循环遍历数组，将每个数组元素添加到字符串</span></span></span><code>myString</code><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">中。最后，使用</span></span></span><code>console.log</code><span style=\"color:#374151\"><span style=\"font-size:16px\"><span style=\"background-color:#f7f7f8\">输出字符串的值。</span></span></span></p>', NULL, 'test', '2023-03-15 22:55:51', 1, '2023-05-21 20:53:32', NULL);
INSERT INTO `wikiInfo` VALUES (4, 'User cmake tools插件在setting.json中配置项目的源文件并生成CMakeList.txt文件', '<p style=\"text-align:start;text-indent:2em;\">在Visual Studio Code中使用CMake Tools插件，你可以通过在<code>.vscode/settings.json</code>文件中配置项目的源文件，并生成CMakeLists.txt文件。</p><p style=\"text-align:start;text-indent:2em;\">在你的项目文件夹下，打开<code>.vscode</code>文件夹（如果没有，请创建一个），然后在该文件夹下创建一个名为<code>settings.json</code>的文件（如果已经存在，请打开该文件）。</p><p style=\"text-align:start;text-indent:2em;\">在<code>settings.json</code>文件中，你可以使用以下格式来配置项目的源文件和生成的CMakeLists.txt文件：</p><pre><code>{<br/>  &quot;cmake.configureSettings&quot;: {<br/>    &quot;CMAKE_EXPORT_COMPILE_COMMANDS&quot;: &quot;YES&quot;<br/>  },<br/>  &quot;cmake.sourceDirectory&quot;: &quot;${workspaceFolder}&quot;,<br/>  &quot;cmake.buildDirectory&quot;: &quot;${workspaceFolder}/build&quot;,<br/>  &quot;cmake.configureOnOpen&quot;: false,<br/>  &quot;cmake.generator&quot;: &quot;Unix Makefiles&quot;,<br/>  &quot;cmake.configureArgs&quot;: [<br/>    &quot;-DCMAKE_BUILD_TYPE=Debug&quot;<br/>  ],<br/>  &quot;cmake.preferredGenerators&quot;: [<br/>    &quot;Ninja&quot;,<br/>    &quot;Unix Makefiles&quot;,<br/>    &quot;Visual Studio&quot;<br/>  ],<br/>  &quot;cmake.debugConfig&quot;: {<br/>    &quot;type&quot;: &quot;cppdbg&quot;,<br/>    &quot;request&quot;: &quot;launch&quot;,<br/>    &quot;program&quot;: &quot;${workspaceFolder}/build/my_program&quot;,<br/>    &quot;args&quot;: [],<br/>    &quot;stopAtEntry&quot;: false,<br/>    &quot;cwd&quot;: &quot;${workspaceFolder}/build&quot;,<br/>    &quot;environment&quot;: [],<br/>    &quot;externalConsole&quot;: false<br/>  },<br/>  &quot;cmake.configureSettings&quot;: {},<br/>  &quot;cmake.configureOnEdit&quot;: false<br/>}</code></pre><p style=\"text-align:start;text-indent:2em;\">在上述示例中，你可以根据你的项目需求进行调整。你可以配置以下选项：</p><ul><li><code>&quot;cmake.sourceDirectory&quot;</code>: 指定项目的源代码目录。</li><li><code>&quot;cmake.buildDirectory&quot;</code>: 指定生成的构建文件的目录。</li><li><code>&quot;cmake.configureOnOpen&quot;</code>: 设置为<code>true</code>将在打开项目时自动配置CMake，否则设置为<code>false</code>。</li><li><code>&quot;cmake.generator&quot;</code>: 指定用于生成CMake构建系统的生成器。</li><li><code>&quot;cmake.configureArgs&quot;</code>: 提供额外的配置参数，例如定义CMAKE_BUILD_TYPE等。</li><li><code>&quot;cmake.preferredGenerators&quot;</code>: 指定CMake首选生成器的列表，按优先级排序。</li><li><code>&quot;cmake.debugConfig&quot;</code>: 配置用于调试的调试器设置。</li></ul><p style=\"text-align:start;text-indent:2em;\">完成配置后，保存并重新加载Visual Studio Code，CMake Tools插件将根据你的设置自动生成CMakeLists.txt文件，并配置项目。</p><p style=\"text-align:start;text-indent:2em;\">注意：确保你已经在工作区文件夹中有适当的CMakeLists.txt文件或配置文件。CMake Tools插件将使用这些文件作为起点来配置你的项目。</p>', NULL, 'staff1', '2023-03-18 22:55:55', 1, '2023-05-21 20:54:42', NULL);
INSERT INTO `wikiInfo` VALUES (5, 'vscode文件浏览器选择本地文件后读取选取文件的路径', '<p style=\"text-align:start;text-indent:2em;\">要在 VS Code 文件浏览器中选择本地文件并获取选中文件的路径，您需要使用 <code>vscode.window.showOpenDialog</code> 组件。该组件会打开一个对话框，允许用户选择文件或文件夹。它返回一个 <code>Thenable&lt;Uri[]&gt;</code> 类型的 Promise 对象，该对象包含一个或多个选中的文件或文件夹的 <code>Uri</code> 对象。</p><p style=\"text-align:start;text-indent:2em;\">以下是使用 <code>vscode.window.showOpenDialog</code> 选择文件并获取选中文件路径的示例代码：</p><pre><code>import * as vscode from &#x27;vscode&#x27;;<br/><br/>async function selectFile() {<br/>    const options: vscode.OpenDialogOptions = {<br/>        canSelectFiles: true, // 允许选择文件<br/>        canSelectFolders: false, // 不允许选择文件夹<br/>        canSelectMany: false, // 只能选择一个文件<br/>    };<br/>    const uris = await vscode.window.showOpenDialog(options);<br/>    if (uris &amp;&amp; uris.length &gt; 0) {<br/>        const uri = uris[0];<br/>        console.log(&#x60;已选择文件：${uri.fsPath}&#x60;);<br/>    } else {<br/>        console.log(&#x27;未选择任何文件&#x27;);<br/>    }<br/>}</code></pre><p style=\"text-align:start;text-indent:2em;\">在这个示例中，我们定义了一个名为 <code>selectFile</code> 的异步函数。该函数使用 <code>vscode.window.showOpenDialog</code> 组件打开文件选择对话框，并配置对话框选项以仅允许选择文件。然后，它等待用户选择文件并返回一个包含选中文件 <code>Uri</code> 对象的数组。如果未选择任何文件，则输出一条消息到控制台。</p><p style=\"text-align:start;text-indent:2em;\">请注意，在这个示例中，我们只能选择一个文件（<code>canSelectMany: false</code>）。如果您想要选择多个文件，请将 <code>canSelectMany</code> 选项设置为 <code>true</code> 并使用返回的 <code>Uri</code> 对象数组。</p>', NULL, 'staff2', '2023-03-19 22:55:58', 1, '2023-05-21 20:55:21', NULL);
INSERT INTO `wikiInfo` VALUES (6, '创建webview的规范使用方法', '<p><span style=\"font-size:30px\">在创建 Webview 的过程中，我们可以遵循以下规范和使用方法：</span><br/></p><ol><li>在您的扩展程序中创建一个名为 &quot;webview&quot; 的子目录。这将是您存放 Webview 相关文件的地方。</li><li>在 &quot;webview&quot; 目录中创建一个名为 &quot;index.html&quot; 的文件。这将是您的 Webview 的主要 HTML 文件。在此文件中，可以包含您需要的 JavaScript、CSS、图像等文件。</li><li>将您的 Webview 视为与其他 Web 页面相同的 Web 页面，遵循 Web 标准和最佳实践。这包括：<br/></li><ul><li>使用 HTML5 DOCTYPE。</li><li>使用语义化的 HTML 标记来描述内容。</li><li>使用外部 CSS 文件来样式化内容。</li><li>使用 JavaScript 来添加交互性和动态性。</li><li>考虑 Web 可访问性（Web Accessibility）的最佳实践，以确保您的 Webview 对于残障用户也可以使用。</li></ul></ol><p></p><ol><li>在创建 WebviewPanel 实例时，要指定正确的 viewType。这可以帮助您管理多个 Webview，并确保每个 Webview 只在需要时打开。</li><li>将您的 Webview 与扩展程序的其他部分隔离开来，以避免不必要的耦合。在 Webview 中，您可以使用 postMessage API 与扩展程序之间进行通信，以实现必要的交互。</li><li>在 Webview 中使用 CSP（Content Security Policy）以保护用户免受跨站点脚本攻击。CSP 是一种安全机制，它限制了浏览器加载和执行的内容类型。</li><li>在 Webview 中不要使用与扩展程序不兼容的 Web API。例如，某些 API（例如 eval() 和 document.write()）可能不适用于 Webview。</li></ol>', NULL, 'staff3', '2023-03-20 22:56:02', 1, '2023-05-21 20:55:57', NULL);
INSERT INTO `wikiInfo` VALUES (7, '如何取消VSCodeDropdown组件的键盘监听事件', '<p style=\"text-align:start;text-indent:2em;\">要取消 VSCode Dropdown 组件的键盘监听事件，可以使用 VS Code API 中的 <code>Disposable</code> 对象来取消事件监听器的注册。您可以按照以下步骤进行操作：</p><ol><li>获取 VSCode Dropdown 组件的实例。您可以使用 <code>vscode.window.createQuickPick()</code> 方法创建一个 Dropdown 实例。</li><li>调用 Dropdown 实例的 <code>onDidAccept()</code> 方法，以便取消默认的键盘监听事件。<code>onDidAccept()</code> 方法会返回一个 <code>Disposable</code> 对象。</li><li>将 <code>Disposable</code> 对象存储在变量中。</li><li>如果您需要重新启用键盘监听事件，则可以调用 <code>Disposable</code> 对象的 <code>dispose()</code> 方法以取消注册的取消键盘监听事件的操作。</li></ol><p style=\"text-align:start;text-indent:2em;\">下面是一个简单的示例代码，演示如何取消 VSCode Dropdown 组件的键盘监听事件：</p><pre><code>let dropdown = vscode.window.createQuickPick();<br/>let disposable = dropdown.onDidAccept(() =&gt; {<br/>  // 这里是事件监听器的代码<br/>});<br/><br/>// 取消默认的键盘监听事件<br/>disposable.dispose();</code></pre><p style=\"text-align:start;text-indent:2em;\">在上面的代码中，我们首先使用 <code>vscode.window.createQuickPick()</code> 方法创建一个 Dropdown 实例，并将其存储在 <code>dropdown</code> 变量中。然后，我们注册一个事件监听器，用于处理用户按下“Enter”键时的操作。</p><p style=\"text-align:start;text-indent:2em;\">接下来，我们调用 <code>dropdown.onDidAccept()</code> 方法，并将其返回的 <code>Disposable</code> 对象存储在 <code>disposable</code> 变量中。最后，我们调用 <code>disposable.dispose()</code> 方法来取消默认的键盘监听事件。</p><p style=\"text-align:start;text-indent:2em;\">请注意，这个例子中的代码只是一个示例。具体实现方式可能因您的应用程序结构而有所不同。</p>', '中科海芯发电机配置', 'test1', '2023-05-21 21:00:00', 1, '2023-05-21 20:56:33', NULL);
INSERT INTO `wikiInfo` VALUES (8, 'vscode差价开发如何获取是否为调试模式', '<p style=\"text-align:start;text-indent:2em;\">在 VS Code 插件开发中，你可以使用 <code>vscode.ExtensionContext</code> 上的 <code>extensionMode</code> 属性来获取当前插件是否处于调试模式。<code>extensionMode</code> 属性返回一个字符串，表示插件的运行模式，可能的取值为 <code>&quot;production&quot;</code>（生产模式）或 <code>&quot;development&quot;</code>（调试模式）。</p><p style=\"text-align:start;text-indent:2em;\">以下是一个示例代码，展示如何获取插件是否处于调试模式：</p><pre><code>function checkDebugMode(context) {<br/>  const isDebugMode = context.extensionMode === vscode.ExtensionMode.Development;<br/><br/>  if (isDebugMode) {<br/>    console.log(&#x27;插件处于调试模式&#x27;);<br/>  } else {<br/>    console.log(&#x27;插件处于生产模式&#x27;);<br/>  }<br/>}<br/><br/>// 在扩展的 activate 方法中调用 checkDebugMode 函数，并传入 extensionContext 对象<br/>function activate(context) {<br/>  checkDebugMode(context);<br/>  // 其他扩展逻辑<br/>}</code></pre><p style=\"text-align:start;text-indent:2em;\">在上述示例中，<code>checkDebugMode</code> 函数接收一个 <code>vscode.ExtensionContext</code> 对象作为参数，并使用 <code>extensionMode</code> 属性检查插件的运行模式。如果插件处于调试模式，<code>extensionMode</code> 属性将返回 <code>vscode.ExtensionMode.Development</code>，则 <code>isDebugMode</code> 变量将为 <code>true</code>，打印 &quot;插件处于调试模式&quot;；否则，打印 &quot;插件处于生产模式&quot;。</p><p style=\"text-align:start;text-indent:2em;\">请确保在你的插件的 <code>activate</code> 方法中调用 <code>checkDebugMode</code> 函数，并将 <code>vscode.ExtensionContext</code> 对象传递给它。</p><p style=\"text-align:start;text-indent:2em;\">这样，你就可以根据插件的运行模式判断是否处于调试模式。</p>', 'Chat AI智能助手', 'user', '2023-05-21 21:00:03', 1, '2023-05-21 20:58:38', NULL);

-- ----------------------------
-- Table structure for wikiupdateInfo
-- ----------------------------
DROP TABLE IF EXISTS `wikiupdateInfo`;
CREATE TABLE `wikiupdateInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updateBy` int(11) NULL DEFAULT NULL COMMENT '更新人',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `wikiUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '后续更新的信息ID',
  `updateContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新后的内容',
  `changeContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变更的内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `WIKIUPDATEINFO_UPDATEBY_USERINFO`(`updateBy`) USING BTREE,
  INDEX `WIKIUPDATEINFO_WIKIUPDATEINFO_WIKIUPDATEINFO`(`wikiUpdateInfo`) USING BTREE,
  CONSTRAINT `WIKIUPDATEINFO_UPDATEBY_USERINFO` FOREIGN KEY (`updateBy`) REFERENCES `userInfo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `WIKIUPDATEINFO_WIKIUPDATEINFO_WIKIUPDATEINFO` FOREIGN KEY (`wikiUpdateInfo`) REFERENCES `wikiupdateInfo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wikiupdateInfo
-- ----------------------------
INSERT INTO `wikiupdateInfo` VALUES (1, 1, '2023-03-19 22:56:24', NULL, '更新内容一', '改变内容一');
INSERT INTO `wikiupdateInfo` VALUES (2, 2, '2023-03-18 22:57:03', NULL, '更新内容二', '改变内容二');
INSERT INTO `wikiupdateInfo` VALUES (3, 3, '2023-03-19 22:58:18', 2, '更新内容三', '改变内容三');
INSERT INTO `wikiupdateInfo` VALUES (4, 2, '2023-03-19 22:59:17', 3, '更新内容四', '改变内容四');
INSERT INTO `wikiupdateInfo` VALUES (5, 3, '2023-03-19 22:59:53', NULL, '更新内容五', '改变内容五');

SET FOREIGN_KEY_CHECKS = 1;
