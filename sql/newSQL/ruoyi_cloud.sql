/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : localhost:3306
 Source Schema         : ruoyi_cloud

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 27/04/2026 16:17:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `book_id` bigint NOT NULL AUTO_INCREMENT COMMENT '书籍ID',
  `book_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书籍名称',
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `isbn` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'ISBN编号',
  `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '书籍分类',
  `stock` int NOT NULL DEFAULT 0 COMMENT '库存数量',
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '书籍封面图片地址',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`book_id`) USING BTREE,
  UNIQUE INDEX `isbn`(`isbn` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '书籍信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '昆仑约定', '毕淑敏', '9787020191635', '小说', 50, 'book/cover/2026/04/26/Screenshot_20241008_233521_tv.danmaku.bilibilihd_20260426155727A001.jpg', '2026-04-26 14:05:05', '2026-04-26 15:57:29');
INSERT INTO `book` VALUES (2, '海燕', '姚鄂梅', '9787020192335', '小说', 30, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (3, '咸的玩笑', '刘震云', '9787020197620', '小说', 40, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (4, '紫山', '孙惠芬', '9787020192113', '小说', 25, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (5, '好天气', '苏童', '9787559495303', '小说', 35, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (6, '换梅', '曹乃谦', '9787572621772', '小说', 15, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (7, '蛋镇诗社', '朱山坡', '9787574905559', '小说', 22, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (8, '桃花坞', '王尧', '9787506399999', '小说', 18, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (9, '垦荒', '董立勃', '9787020196999', '小说', 28, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (10, '人鱼之间', '张天翼', '9787020189690', '小说', 32, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (11, '白象', '班宇', '9787559495310', '小说', 20, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `book` VALUES (12, '飞行汽车百科全书', '交通运输部科学研究院', '9787520219631', '百科', 10, 'book/cover/2026/04/19/微信图片_2025-09-17_123021_110_20260419231859A001.jpg', '2026-04-26 14:05:05', '2026-04-26 14:05:05');

-- ----------------------------
-- Table structure for borrow_item
-- ----------------------------
DROP TABLE IF EXISTS `borrow_item`;
CREATE TABLE `borrow_item`  (
  `item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `record_id` bigint NOT NULL COMMENT '借阅记录ID',
  `book_id` bigint NOT NULL COMMENT '书籍ID',
  `book_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书籍名称',
  PRIMARY KEY (`item_id`) USING BTREE,
  INDEX `fk_record`(`record_id` ASC) USING BTREE,
  INDEX `fk_book`(`book_id` ASC) USING BTREE,
  CONSTRAINT `fk_book` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_record` FOREIGN KEY (`record_id`) REFERENCES `borrow_record` (`record_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '借阅明细子表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow_item
-- ----------------------------
INSERT INTO `borrow_item` VALUES (42, 1, 1, '昆仑约定');
INSERT INTO `borrow_item` VALUES (43, 1, 2, '海燕');
INSERT INTO `borrow_item` VALUES (44, 2, 3, '咸的玩笑');
INSERT INTO `borrow_item` VALUES (45, 2, 11, '白象');
INSERT INTO `borrow_item` VALUES (46, 3, 4, '紫山');
INSERT INTO `borrow_item` VALUES (47, 4, 5, '好天气');
INSERT INTO `borrow_item` VALUES (48, 4, 6, '换梅');
INSERT INTO `borrow_item` VALUES (49, 4, 7, '蛋镇诗社');
INSERT INTO `borrow_item` VALUES (50, 5, 8, '桃花坞');
INSERT INTO `borrow_item` VALUES (51, 6, 9, '垦荒');
INSERT INTO `borrow_item` VALUES (52, 6, 10, '人鱼之间');
INSERT INTO `borrow_item` VALUES (53, 7, 1, '昆仑约定');
INSERT INTO `borrow_item` VALUES (54, 8, 2, '海燕');
INSERT INTO `borrow_item` VALUES (55, 8, 6, '咸的玩笑');
INSERT INTO `borrow_item` VALUES (56, 9, 12, '飞行汽车百科全书');
INSERT INTO `borrow_item` VALUES (57, 10, 4, '紫山');
INSERT INTO `borrow_item` VALUES (58, 10, 7, '好天气');
INSERT INTO `borrow_item` VALUES (59, 11, 6, '换梅');
INSERT INTO `borrow_item` VALUES (60, 12, 7, '蛋镇诗社');
INSERT INTO `borrow_item` VALUES (61, 12, 8, '桃花坞');

-- ----------------------------
-- Table structure for borrow_record
-- ----------------------------
DROP TABLE IF EXISTS `borrow_record`;
CREATE TABLE `borrow_record`  (
  `record_id` bigint NOT NULL AUTO_INCREMENT COMMENT '借阅记录ID',
  `user_id` bigint NOT NULL COMMENT '借阅人ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '借阅人姓名',
  `borrow_time` datetime NULL DEFAULT NULL COMMENT '借阅时间',
  `plan_return_time` datetime NULL DEFAULT NULL COMMENT '预计归还时间',
  `return_time` datetime NULL DEFAULT NULL COMMENT '实际归还时间',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '借阅状态 0=待借阅 1=已借出 2=已归还 3=逾期',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '借阅记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow_record
-- ----------------------------
INSERT INTO `borrow_record` VALUES (1, 1001, '张三', '2026-03-01 10:00:00', '2026-03-15 10:00:00', '2026-03-12 14:30:00', '2', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `borrow_record` VALUES (2, 1002, '李四', '2026-03-05 08:00:00', '2026-03-19 08:00:00', NULL, '3', '2026-04-26 14:05:05', '2026-04-26 15:43:02');
INSERT INTO `borrow_record` VALUES (3, 1003, '王五', '2026-02-20 14:00:00', '2026-03-06 14:00:00', '2026-03-08 10:00:00', '3', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `borrow_record` VALUES (4, 1004, '赵六', '2026-03-10 08:00:00', '2026-03-24 08:00:00', NULL, '3', '2026-04-26 14:05:05', '2026-04-26 15:43:02');
INSERT INTO `borrow_record` VALUES (5, 1005, '孙七', '2026-02-15 08:45:00', '2026-03-01 08:45:00', '2026-02-28 16:20:00', '2', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `borrow_record` VALUES (6, 1006, '周八', '2026-03-08 08:00:00', '2026-03-22 08:00:00', NULL, '3', '2026-04-26 14:05:05', '2026-04-26 15:43:02');
INSERT INTO `borrow_record` VALUES (7, 1007, '吴九', '2026-01-25 10:30:00', '2026-02-08 10:30:00', '2026-02-10 09:00:00', '3', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `borrow_record` VALUES (8, 1008, '郑十', '2026-03-12 08:00:00', '2026-03-26 08:00:00', NULL, '3', '2026-04-26 14:05:05', '2026-04-27 16:11:56');
INSERT INTO `borrow_record` VALUES (9, 1009, '刘一', '2026-02-28 09:00:00', '2026-03-14 09:00:00', '2026-03-14 08:50:00', '2', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `borrow_record` VALUES (10, 1010, '陈二', '2026-03-15 08:00:00', '2026-03-29 08:00:00', NULL, '3', '2026-04-26 14:05:05', '2026-04-27 16:11:56');
INSERT INTO `borrow_record` VALUES (11, 1011, '杨三', '2026-03-02 11:00:00', '2026-03-16 11:00:00', '2026-03-15 15:30:00', '2', '2026-04-26 14:05:05', '2026-04-26 14:05:05');
INSERT INTO `borrow_record` VALUES (12, 1012, '黄四', '2026-03-18 10:15:00', '2026-04-01 10:15:00', NULL, '0', '2026-04-26 14:05:05', '2026-04-26 14:05:05');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'book', '书籍信息表', NULL, NULL, 'Book', 'crud', 'element-ui', 'com.ruoyi.book', 'book', 'detail', '书籍信息', 'Alanine', 1, '1', 'D:\\GaoHe\\Ruoyi-Cloud\\ruoyi-modules\\ruoyi-book\\src', '{\"genView\":\"0\",\"parentMenuId\":2003}', 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26', NULL);
INSERT INTO `gen_table` VALUES (2, 'borrow_item', '借阅明细子表', NULL, NULL, 'BorrowItem', 'crud', 'element-ui', 'com.ruoyi.book', 'book', 'item', '借阅明细', 'Alanine', 1, '1', 'D:\\GaoHe\\Ruoyi-Cloud\\ruoyi-modules\\ruoyi-book\\src', '{\"genView\":\"0\",\"parentMenuId\":2003}', 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:15:30', NULL);
INSERT INTO `gen_table` VALUES (3, 'borrow_record', '借阅记录表', NULL, NULL, 'BorrowRecord', 'crud', 'element-ui', 'com.ruoyi.book', 'book', 'record', '借阅记录', 'Alanine', 1, '1', 'D:\\GaoHe\\Ruoyi-Cloud\\ruoyi-modules\\ruoyi-book\\src', '{\"genView\":\"0\",\"parentMenuId\":2003}', 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'config_id', '参数主键', 'int', 'Long', 'configId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (2, 1, 'config_name', '参数名称', 'varchar(100)', 'String', 'configName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (3, 1, 'config_key', '参数键名', 'varchar(100)', 'String', 'configKey', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (4, 1, 'config_value', '参数键值', 'varchar(500)', 'String', 'configValue', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (5, 1, 'config_type', '系统内置（Y是 N否）', 'char(1)', 'String', 'configType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (6, 1, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (7, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (8, 1, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (9, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (10, 1, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (11, 2, 'dict_code', '字典编码', 'bigint', 'Long', 'dictCode', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (12, 2, 'dict_sort', '字典排序', 'int', 'Long', 'dictSort', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (13, 2, 'dict_label', '字典标签', 'varchar(100)', 'String', 'dictLabel', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (14, 2, 'dict_value', '字典键值', 'varchar(100)', 'String', 'dictValue', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (15, 2, 'dict_type', '字典类型', 'varchar(100)', 'String', 'dictType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (16, 2, 'css_class', '样式属性（其他样式扩展）', 'varchar(100)', 'String', 'cssClass', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (17, 2, 'list_class', '表格回显样式', 'varchar(100)', 'String', 'listClass', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (18, 2, 'is_default', '是否默认（Y是 N否）', 'char(1)', 'String', 'isDefault', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (19, 2, 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 9, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (20, 2, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (21, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (22, 2, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (23, 2, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (24, 2, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 14, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (25, 3, 'dict_id', '字典主键', 'bigint', 'Long', 'dictId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (26, 3, 'dict_name', '字典名称', 'varchar(100)', 'String', 'dictName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (27, 3, 'dict_type', '字典类型', 'varchar(100)', 'String', 'dictType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (28, 3, 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (29, 3, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 5, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (30, 3, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 6, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (31, 3, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (32, 3, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (33, 3, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 9, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (34, 4, 'job_id', '任务ID', 'bigint', 'Long', 'jobId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (35, 4, 'job_name', '任务名称', 'varchar(64)', 'String', 'jobName', '1', '0', NULL, '1', NULL, NULL, NULL, 'LIKE', 'input', '', 2, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (36, 4, 'job_group', '任务组名', 'varchar(64)', 'String', 'jobGroup', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (37, 4, 'invoke_target', '调用目标字符串', 'varchar(500)', 'String', 'invokeTarget', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (38, 4, 'cron_expression', 'cron执行表达式', 'varchar(255)', 'String', 'cronExpression', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (39, 4, 'misfire_policy', '计划执行错误策略（1立即执行 2执行一次 3放弃执行）', 'varchar(20)', 'String', 'misfirePolicy', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (40, 4, 'concurrent', '是否并发执行（0允许 1禁止）', 'char(1)', 'String', 'concurrent', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (41, 4, 'status', '状态（0正常 1暂停）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 8, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (42, 4, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (43, 4, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (44, 4, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (45, 4, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (46, 4, 'remark', '备注信息', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (47, 5, 'job_log_id', '任务日志ID', 'bigint', 'Long', 'jobLogId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (48, 5, 'job_name', '任务名称', 'varchar(64)', 'String', 'jobName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (49, 5, 'job_group', '任务组名', 'varchar(64)', 'String', 'jobGroup', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (50, 5, 'invoke_target', '调用目标字符串', 'varchar(500)', 'String', 'invokeTarget', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (51, 5, 'job_message', '日志信息', 'varchar(500)', 'String', 'jobMessage', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (52, 5, 'status', '执行状态（0正常 1失败）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 6, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (53, 5, 'exception_info', '异常信息', 'varchar(2000)', 'String', 'exceptionInfo', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (54, 5, 'start_time', '执行开始时间', 'datetime', 'Date', 'startTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 8, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (55, 5, 'end_time', '执行结束时间', 'datetime', 'Date', 'endTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (56, 5, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2026-04-26 11:48:56', '', NULL);
INSERT INTO `gen_table_column` VALUES (57, 6, 'info_id', '访问ID', 'bigint', 'Long', 'infoId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (58, 6, 'user_name', '用户账号', 'varchar(50)', 'String', 'userName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (59, 6, 'ipaddr', '登录IP地址', 'varchar(128)', 'String', 'ipaddr', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (60, 6, 'status', '登录状态（0成功 1失败）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (61, 6, 'msg', '提示信息', 'varchar(255)', 'String', 'msg', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (62, 6, 'access_time', '访问时间', 'datetime', 'Date', 'accessTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (63, 7, 'notice_id', '公告ID', 'int', 'Long', 'noticeId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (64, 7, 'notice_title', '公告标题', 'varchar(50)', 'String', 'noticeTitle', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (65, 7, 'notice_type', '公告类型（1通知 2公告）', 'char(1)', 'String', 'noticeType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (66, 7, 'notice_content', '公告内容', 'longblob', 'String', 'noticeContent', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'editor', '', 4, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (67, 7, 'status', '公告状态（0正常 1关闭）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (68, 7, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (69, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (70, 7, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (71, 7, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (72, 7, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (73, 8, 'read_id', '已读主键', 'bigint', 'Long', 'readId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (74, 8, 'notice_id', '公告id', 'int', 'Long', 'noticeId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (75, 8, 'user_id', '用户id', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (76, 8, 'read_time', '阅读时间', 'datetime', 'Date', 'readTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (77, 9, 'oper_id', '日志主键', 'bigint', 'Long', 'operId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (78, 9, 'title', '模块标题', 'varchar(50)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (79, 9, 'business_type', '业务类型（0其它 1新增 2修改 3删除）', 'int', 'Long', 'businessType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (80, 9, 'method', '方法名称', 'varchar(200)', 'String', 'method', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (81, 9, 'request_method', '请求方式', 'varchar(10)', 'String', 'requestMethod', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (82, 9, 'operator_type', '操作类别（0其它 1后台用户 2手机端用户）', 'int', 'Long', 'operatorType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 6, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (83, 9, 'oper_name', '操作人员', 'varchar(50)', 'String', 'operName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (84, 9, 'dept_name', '部门名称', 'varchar(50)', 'String', 'deptName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (85, 9, 'oper_url', '请求URL', 'varchar(255)', 'String', 'operUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (86, 9, 'oper_ip', '主机地址', 'varchar(128)', 'String', 'operIp', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (87, 9, 'oper_location', '操作地点', 'varchar(255)', 'String', 'operLocation', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (88, 9, 'oper_param', '请求参数', 'varchar(2000)', 'String', 'operParam', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 12, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (89, 9, 'json_result', '返回参数', 'varchar(2000)', 'String', 'jsonResult', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 13, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (90, 9, 'status', '操作状态（0正常 1异常）', 'int', 'Long', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 14, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (91, 9, 'error_msg', '错误消息', 'varchar(2000)', 'String', 'errorMsg', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 15, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (92, 9, 'oper_time', '操作时间', 'datetime', 'Date', 'operTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 16, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (93, 9, 'cost_time', '消耗时间', 'bigint', 'Long', 'costTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 17, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (94, 10, 'role_id', '角色ID', 'bigint', 'Long', 'roleId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (95, 10, 'dept_id', '部门ID', 'bigint', 'Long', 'deptId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:48:57', '', NULL);
INSERT INTO `gen_table_column` VALUES (96, 11, 'dept_id', '部门id', 'bigint', 'Long', 'deptId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (97, 11, 'parent_id', '父部门id', 'bigint', 'Long', 'parentId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (98, 11, 'ancestors', '祖级列表', 'varchar(50)', 'String', 'ancestors', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (99, 11, 'dept_name', '部门名称', 'varchar(30)', 'String', 'deptName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (100, 11, 'order_num', '显示顺序', 'int', 'Long', 'orderNum', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (101, 11, 'leader', '负责人', 'varchar(20)', 'String', 'leader', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (102, 11, 'phone', '联系电话', 'varchar(11)', 'String', 'phone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (103, 11, 'email', '邮箱', 'varchar(50)', 'String', 'email', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (104, 11, 'status', '部门状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 9, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (105, 11, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (106, 11, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (107, 11, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (108, 11, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (109, 11, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (110, 12, 'menu_id', '菜单ID', 'bigint', 'Long', 'menuId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (111, 12, 'menu_name', '菜单名称', 'varchar(50)', 'String', 'menuName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (112, 12, 'parent_id', '父菜单ID', 'bigint', 'Long', 'parentId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (113, 12, 'order_num', '显示顺序', 'int', 'Long', 'orderNum', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (114, 12, 'path', '路由地址', 'varchar(200)', 'String', 'path', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (115, 12, 'component', '组件路径', 'varchar(255)', 'String', 'component', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (116, 12, 'query', '路由参数', 'varchar(255)', 'String', 'query', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (117, 12, 'route_name', '路由名称', 'varchar(50)', 'String', 'routeName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (118, 12, 'is_frame', '是否为外链（0是 1否）', 'int', 'Long', 'isFrame', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (119, 12, 'is_cache', '是否缓存（0缓存 1不缓存）', 'int', 'Long', 'isCache', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (120, 12, 'menu_type', '菜单类型（M目录 C菜单 F按钮）', 'char(1)', 'String', 'menuType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 11, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (121, 12, 'visible', '菜单状态（0显示 1隐藏）', 'char(1)', 'String', 'visible', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (122, 12, 'status', '菜单状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 13, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (123, 12, 'perms', '权限标识', 'varchar(100)', 'String', 'perms', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (124, 12, 'icon', '菜单图标', 'varchar(100)', 'String', 'icon', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 15, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (125, 12, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (126, 12, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (127, 12, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 18, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (128, 12, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 19, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (129, 12, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 20, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (130, 13, 'post_id', '岗位ID', 'bigint', 'Long', 'postId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (131, 13, 'post_code', '岗位编码', 'varchar(64)', 'String', 'postCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (132, 13, 'post_name', '岗位名称', 'varchar(50)', 'String', 'postName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (133, 13, 'post_sort', '显示顺序', 'int', 'Long', 'postSort', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (134, 13, 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (135, 13, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (136, 13, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (137, 13, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (138, 13, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (139, 13, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (140, 14, 'role_id', '角色ID', 'bigint', 'Long', 'roleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (141, 14, 'role_name', '角色名称', 'varchar(30)', 'String', 'roleName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (142, 14, 'role_key', '角色权限字符串', 'varchar(100)', 'String', 'roleKey', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (143, 14, 'role_sort', '显示顺序', 'int', 'Long', 'roleSort', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (144, 14, 'data_scope', '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）', 'char(1)', 'String', 'dataScope', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (145, 14, 'menu_check_strictly', '菜单树选择项是否关联显示', 'tinyint(1)', 'Integer', 'menuCheckStrictly', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (146, 14, 'dept_check_strictly', '部门树选择项是否关联显示', 'tinyint(1)', 'Integer', 'deptCheckStrictly', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (147, 14, 'status', '角色状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 8, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (148, 14, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (149, 14, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (150, 14, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (151, 14, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (152, 14, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (153, 14, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 14, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (154, 15, 'role_id', '角色ID', 'bigint', 'Long', 'roleId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (155, 15, 'menu_id', '菜单ID', 'bigint', 'Long', 'menuId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (156, 16, 'user_id', '用户ID', 'bigint', 'Long', 'userId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (157, 16, 'dept_id', '部门ID', 'bigint', 'Long', 'deptId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (158, 16, 'user_name', '用户账号', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (159, 16, 'nick_name', '用户昵称', 'varchar(30)', 'String', 'nickName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (160, 16, 'user_type', '用户类型（00系统用户）', 'varchar(2)', 'String', 'userType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (161, 16, 'email', '用户邮箱', 'varchar(50)', 'String', 'email', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (162, 16, 'phonenumber', '手机号码', 'varchar(11)', 'String', 'phonenumber', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (163, 16, 'sex', '用户性别（0男 1女 2未知）', 'char(1)', 'String', 'sex', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 8, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (164, 16, 'avatar', '头像地址', 'varchar(100)', 'String', 'avatar', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (165, 16, 'password', '密码', 'varchar(100)', 'String', 'password', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (166, 16, 'status', '账号状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (167, 16, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (168, 16, 'login_ip', '最后登录IP', 'varchar(128)', 'String', 'loginIp', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (169, 16, 'login_date', '最后登录时间', 'datetime', 'Date', 'loginDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 14, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (170, 16, 'pwd_update_date', '密码最后更新时间', 'datetime', 'Date', 'pwdUpdateDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 15, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (171, 16, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (172, 16, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (173, 16, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 18, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (174, 16, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 19, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (175, 16, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 20, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (176, 17, 'user_id', '用户ID', 'bigint', 'Long', 'userId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (177, 17, 'post_id', '岗位ID', 'bigint', 'Long', 'postId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (178, 18, 'user_id', '用户ID', 'bigint', 'Long', 'userId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (179, 18, 'role_id', '角色ID', 'bigint', 'Long', 'roleId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 2, 'admin', '2026-04-26 11:49:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (180, 19, 'book_id', '书籍ID', 'bigint', 'Long', 'bookId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (181, 19, 'book_name', '书籍名称', 'varchar(100)', 'String', 'bookName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (182, 19, 'author', '作者', 'varchar(50)', 'String', 'author', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (183, 19, 'isbn', 'ISBN编号', 'varchar(20)', 'String', 'isbn', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (184, 19, 'category', '书籍分类', 'varchar(20)', 'String', 'category', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (185, 19, 'stock', '库存数量', 'int', 'Long', 'stock', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (186, 19, 'cover_img', '书籍封面图片地址', 'varchar(255)', 'String', 'coverImg', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (187, 19, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (188, 19, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:26');
INSERT INTO `gen_table_column` VALUES (189, 20, 'item_id', '明细ID', 'bigint', 'Long', 'itemId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:15:30');
INSERT INTO `gen_table_column` VALUES (190, 20, 'record_id', '借阅记录ID', 'bigint', 'Long', 'recordId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:15:30');
INSERT INTO `gen_table_column` VALUES (191, 20, 'book_id', '书籍ID', 'bigint', 'Long', 'bookId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:15:30');
INSERT INTO `gen_table_column` VALUES (192, 20, 'book_name', '书籍名称', 'varchar(100)', 'String', 'bookName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:15:30');
INSERT INTO `gen_table_column` VALUES (193, 21, 'record_id', '借阅记录ID', 'bigint', 'Long', 'recordId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');
INSERT INTO `gen_table_column` VALUES (194, 21, 'user_id', '借阅人ID', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');
INSERT INTO `gen_table_column` VALUES (195, 21, 'user_name', '借阅人姓名', 'varchar(50)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');
INSERT INTO `gen_table_column` VALUES (196, 21, 'borrow_time', '借阅时间', 'datetime', 'Date', 'borrowTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');
INSERT INTO `gen_table_column` VALUES (197, 21, 'plan_return_time', '预计归还时间', 'datetime', 'Date', 'planReturnTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');
INSERT INTO `gen_table_column` VALUES (198, 21, 'return_time', '实际归还时间', 'datetime', 'Date', 'returnTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');
INSERT INTO `gen_table_column` VALUES (199, 21, 'status', '借阅状态 0=待借阅 1=已借出 2=已归还 3=逾期', 'char(2)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');
INSERT INTO `gen_table_column` VALUES (200, 21, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');
INSERT INTO `gen_table_column` VALUES (201, 21, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-26 14:11:47', '', '2026-04-26 14:14:37');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-04-25 23:52:54', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-04-25 23:52:54', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-04-25 23:52:54', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-04-25 23:52:54', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-04-25 23:52:54', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (6, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-04-25 23:52:54', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (7, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-04-25 23:52:54', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2026-04-25 23:52:54', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-25 23:52:49', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (30, 0, '待借阅', '0', 'status', NULL, 'info', 'N', '0', 'admin', '2026-04-21 10:46:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (31, 1, '已借出', '1', 'status', NULL, 'primary', 'N', '0', 'admin', '2026-04-21 10:46:28', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (32, 2, '已归还', '2', 'status', NULL, 'success', 'N', '0', 'admin', '2026-04-21 10:46:41', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (33, 3, '逾期', '3', 'status', NULL, 'danger', 'N', '0', 'admin', '2026-04-21 10:46:55', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-04-25 23:52:54', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '借阅图书状态borrow_status', 'status', '0', 'admin', '2026-04-21 10:45:14', 'admin', '2026-04-24 12:41:58', '借阅图书状态');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-04-25 23:52:54', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-04-25 23:52:54', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-04-25 23:52:54', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示信息',
  `access_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`access_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '0', '登录成功', '2026-04-26 08:27:32');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '0', '退出成功', '2026-04-26 10:41:05');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '0', '登录成功', '2026-04-26 10:41:08');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '0', '登录成功', '2026-04-27 13:28:15');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2024 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-04-25 23:52:50', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-04-25 23:52:50', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-04-25 23:52:50', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-04-25 23:52:50', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-04-25 23:52:50', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-04-25 23:52:50', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-04-25 23:52:50', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-04-25 23:52:50', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-04-25 23:52:50', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-04-25 23:52:50', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-04-25 23:52:51', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-04-25 23:52:51', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-04-25 23:52:51', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-04-25 23:52:51', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-04-25 23:52:51', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-04-25 23:52:51', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-04-25 23:52:51', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'monitor', 'admin', '2026-04-25 23:52:51', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'list', 'admin', '2026-04-25 23:52:51', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, 'Sentinel控制台', 2, 8, 'http://localhost:8718', '', '', '', 0, 0, 'C', '0', '0', 'monitor:sentinel:list', 'sentinel', 'admin', '2026-04-25 23:52:51', 'admin', '2026-04-26 09:19:26', '流量控制菜单');
INSERT INTO `sys_menu` VALUES (116, 'Nacos控制台', 2, 9, 'http://localhost:8848/nacos', '', '', '', 0, 0, 'C', '0', '0', 'monitor:nacos:list', 'nacos', 'admin', '2026-04-25 23:52:51', 'admin', '2026-04-26 09:19:30', '服务治理菜单');
INSERT INTO `sys_menu` VALUES (117, 'Admin控制台', 2, 10, 'http://localhost:9100/login', '', '', '', 0, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-04-25 23:52:51', 'admin', '2026-04-26 09:19:34', '服务监控菜单');
INSERT INTO `sys_menu` VALUES (118, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-04-25 23:52:51', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (119, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-04-25 23:52:51', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (120, '系统接口', 3, 3, 'http://localhost:8080/swagger-ui/index.html', '', '', '', 0, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-04-25 23:52:51', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'system/operlog/index', '', '', 1, 0, 'C', '0', '0', 'system:operlog:list', 'form', 'admin', '2026-04-25 23:52:51', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'system/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'system:logininfor:list', 'logininfor', 'admin', '2026-04-25 23:52:51', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-04-25 23:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:query', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:remove', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:export', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:query', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:remove', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:export', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:unlock', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-04-25 23:52:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, 'minio控制台', 2, 11, 'http://localhost:9000', NULL, NULL, '', 0, 0, 'C', '0', '0', '', 'download', 'admin', '2026-04-26 09:18:17', 'admin', '2026-04-27 13:38:04', '');
INSERT INTO `sys_menu` VALUES (2001, 'minio列表', 2, 7, 'minio', 'monitor/minio/list', NULL, '', 1, 0, 'C', '0', '0', 'minitor:minio:list', 'code', 'admin', '2026-04-26 09:59:15', 'admin', '2026-04-26 10:01:26', '');
INSERT INTO `sys_menu` VALUES (2002, 'minio页面', 2001, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', NULL, '#', '', NULL, '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '书籍信息', 2023, 1, 'detail', 'book/detail/index', NULL, '', 1, 0, 'C', '0', '0', 'book:detail:list', 'education', 'admin', '2026-04-26 14:05:03', 'admin', '2026-04-26 15:39:17', '书籍信息菜单');
INSERT INTO `sys_menu` VALUES (2004, '书籍信息查询', 2003, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:detail:query', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '书籍信息新增', 2003, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:detail:add', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '书籍信息修改', 2003, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:detail:edit', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '书籍信息删除', 2003, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:detail:remove', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '书籍信息导出', 2003, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:detail:export', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '书籍信息导入', 2003, 6, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:detail:import', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '借阅明细', 2023, 1, 'item', 'book/item/index', NULL, '', 1, 0, 'C', '0', '0', 'book:item:list', 'date', 'admin', '2026-04-26 14:05:04', 'admin', '2026-04-26 15:39:22', '借阅明细菜单');
INSERT INTO `sys_menu` VALUES (2011, '借阅明细查询', 2010, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:item:query', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '借阅明细新增', 2010, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:item:add', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '借阅明细修改', 2010, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:item:edit', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '借阅明细删除', 2010, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:item:remove', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '借阅明细导出', 2010, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:item:export', '#', 'admin', '2026-04-26 14:05:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '借阅记录', 2023, 2, 'record', 'book/record/index', NULL, '', 1, 0, 'C', '0', '0', 'book:record:list', 'date', 'admin', '2026-04-26 14:05:04', 'admin', '2026-04-26 15:39:11', '借阅记录菜单');
INSERT INTO `sys_menu` VALUES (2017, '借阅记录查询', 2016, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:record:query', '#', 'admin', '2026-04-26 14:05:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '借阅记录新增', 2016, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:record:add', '#', 'admin', '2026-04-26 14:05:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '借阅记录修改', 2016, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:record:edit', '#', 'admin', '2026-04-26 14:05:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '借阅记录删除', 2016, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:record:remove', '#', 'admin', '2026-04-26 14:05:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '借阅记录导出', 2016, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:record:export', '#', 'admin', '2026-04-26 14:05:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '借阅记录导入', 2016, 6, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'book:record:import', '#', 'admin', '2026-04-26 14:05:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '书籍', 0, 0, 'book', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'dict', 'admin', '2026-04-26 14:17:57', 'admin', '2026-04-26 15:39:47', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-04-25 23:52:55', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-04-25 23:52:55', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '若依开源框架介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313737333933313834383334323433393033322F61346432323331335F313831353039352E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-04-25 23:52:55', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 143 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuName\":\"minio控制台\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:31508/browser\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 09:18:18', 144);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2026-04-26 09:18:17\",\"icon\":\"download\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2000,\"menuName\":\"minio控制台\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:31508/browser\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 09:19:13', 56);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2026-04-25 23:52:51\",\"icon\":\"sentinel\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":115,\"menuName\":\"Sentinel控制台\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:8718\",\"perms\":\"monitor:sentinel:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 09:19:26', 93);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2026-04-25 23:52:51\",\"icon\":\"nacos\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":116,\"menuName\":\"Nacos控制台\",\"menuType\":\"C\",\"orderNum\":9,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:8848/nacos\",\"perms\":\"monitor:nacos:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 09:19:30', 41);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2026-04-25 23:52:51\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":117,\"menuName\":\"Admin控制台\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:9100/login\",\"perms\":\"monitor:server:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 09:19:34', 25);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2026-04-26 09:18:17\",\"icon\":\"download\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2000,\"menuName\":\"minio控制台\",\"menuType\":\"C\",\"orderNum\":11,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:31508/browser\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 09:19:38', 45);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"monitor/minio/list\",\"createTime\":\"2026-04-26 09:59:15\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"minio列表\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2,\"path\":\"minio\",\"perms\":\"minitor:minio:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:01:26', 28);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"sys_notice,sys_notice_read,sys_config,sys_dict_data,sys_dict_type,sys_job,sys_job_log,sys_logininfor,sys_oper_log,sys_role_dept\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 11:48:58', 1076);
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"sys_user_post,sys_role_menu,sys_user_role,sys_menu,sys_post,sys_role,sys_user,sys_dept\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 11:49:23', 466);
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"book,borrow_item,borrow_record\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:11:47', 37);
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"record\",\"className\":\"BorrowRecord\",\"columns\":[{\"capJavaField\":\"RecordId\",\"columnComment\":\"借阅记录ID\",\"columnId\":193,\"columnName\":\"record_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"recordId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":21,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"借阅人ID\",\"columnId\":194,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":21,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserName\",\"columnComment\":\"借阅人姓名\",\"columnId\":195,\"columnName\":\"user_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":21,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BorrowTime\",\"columnComment\":\"借阅时间\",\"columnId\":196,\"columnName\":\"borrow_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"borr', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:13:45', 57);
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"detail\",\"className\":\"Book\",\"columns\":[{\"capJavaField\":\"BookId\",\"columnComment\":\"书籍ID\",\"columnId\":180,\"columnName\":\"book_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"bookId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":19,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BookName\",\"columnComment\":\"书籍名称\",\"columnId\":181,\"columnName\":\"book_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"bookName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":19,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Author\",\"columnComment\":\"作者\",\"columnId\":182,\"columnName\":\"author\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"author\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":19,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Isbn\",\"columnComment\":\"ISBN编号\",\"columnId\":183,\"columnName\":\"isbn\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"isbn\",\"javaType\":\"String\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:14:26', 16);
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"record\",\"className\":\"BorrowRecord\",\"columns\":[{\"capJavaField\":\"RecordId\",\"columnComment\":\"借阅记录ID\",\"columnId\":193,\"columnName\":\"record_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"recordId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":21,\"updateBy\":\"\",\"updateTime\":\"2026-04-26 14:13:45\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"借阅人ID\",\"columnId\":194,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":21,\"updateBy\":\"\",\"updateTime\":\"2026-04-26 14:13:45\",\"usableColumn\":false},{\"capJavaField\":\"UserName\",\"columnComment\":\"借阅人姓名\",\"columnId\":195,\"columnName\":\"user_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":21,\"updateBy\":\"\",\"updateTime\":\"2026-04-26 14:13:45\",\"usableColumn\":false},{\"capJavaField\":\"BorrowTime\",\"columnComment\":\"借阅时间\",\"columnId\":196,\"columnName\":\"borrow_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":t', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:14:37', 14);
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"item\",\"className\":\"BorrowItem\",\"columns\":[{\"capJavaField\":\"ItemId\",\"columnComment\":\"明细ID\",\"columnId\":189,\"columnName\":\"item_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"itemId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":20,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RecordId\",\"columnComment\":\"借阅记录ID\",\"columnId\":190,\"columnName\":\"record_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"recordId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":20,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BookId\",\"columnComment\":\"书籍ID\",\"columnId\":191,\"columnName\":\"book_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"bookId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":20,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BookName\",\"columnComment\":\"书籍名称\",\"columnId\":192,\"columnName\":\"book_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-26 14:11:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"bookName\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:15:30', 18);
INSERT INTO `sys_oper_log` VALUES (114, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.genCode()', 'GET', 1, 'admin', NULL, '/gen/genCode/borrow_record', '127.0.0.1', '', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:15:39', 66);
INSERT INTO `sys_oper_log` VALUES (115, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.genCode()', 'GET', 1, 'admin', NULL, '/gen/genCode/book', '127.0.0.1', '', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:15:39', 21);
INSERT INTO `sys_oper_log` VALUES (116, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.genCode()', 'GET', 1, 'admin', NULL, '/gen/genCode/borrow_item', '127.0.0.1', '', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:15:41', 24);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"书籍\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"book\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'书籍\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-04-26 14:17:29', 4);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"book/detail/index\",\"createTime\":\"2026-04-26 14:05:03\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"书籍信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"book/\",\"perms\":\"book:detail:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:17:39', 9);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"书籍\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"book\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:17:57', 8);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"book/detail/index\",\"createTime\":\"2026-04-26 14:05:03\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"书籍信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2023,\"path\":\"book/\",\"perms\":\"book:detail:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:18:11', 21);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"book/detail/index\",\"createTime\":\"2026-04-26 14:05:03\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"书籍信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2023,\"path\":\"detail\",\"perms\":\"book:detail:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 14:18:54', 18);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"book/record/index\",\"createTime\":\"2026-04-26 14:05:04\",\"icon\":\"date\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2016,\"menuName\":\"借阅记录\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2023,\"path\":\"record\",\"perms\":\"book:record:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:39:11', 33);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"book/detail/index\",\"createTime\":\"2026-04-26 14:05:03\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"书籍信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2023,\"path\":\"detail\",\"perms\":\"book:detail:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:39:17', 19);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"book/item/index\",\"createTime\":\"2026-04-26 14:05:04\",\"icon\":\"date\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"借阅明细\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2023,\"path\":\"item\",\"perms\":\"book:item:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:39:22', 22);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2026-04-26 14:17:57\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2023,\"menuName\":\"书籍\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"book\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:39:47', 18);
INSERT INTO `sys_oper_log` VALUES (126, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"曹乃谦\",\"bookId\":6,\"bookName\":\"换梅\",\"borrowTime\":\"2026-03-10\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787572621772\",\"params\":{},\"planReturnTime\":\"2026-03-24\",\"recordId\":4,\"status\":\"3\",\"updateTime\":\"2026-04-26 15:43:01\",\"userId\":1004,\"userName\":\"赵六\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:43:01', 5);
INSERT INTO `sys_oper_log` VALUES (127, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"朱山坡\",\"bookId\":7,\"bookName\":\"蛋镇诗社\",\"borrowTime\":\"2026-03-10\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787574905559\",\"params\":{},\"planReturnTime\":\"2026-03-24\",\"recordId\":4,\"status\":\"3\",\"updateTime\":\"2026-04-26 15:43:01\",\"userId\":1004,\"userName\":\"赵六\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:43:01', 5);
INSERT INTO `sys_oper_log` VALUES (128, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"班宇\",\"bookId\":11,\"bookName\":\"白象\",\"borrowTime\":\"2026-03-05\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787559495310\",\"params\":{},\"planReturnTime\":\"2026-03-19\",\"recordId\":2,\"status\":\"3\",\"updateTime\":\"2026-04-26 15:43:01\",\"userId\":1002,\"userName\":\"李四\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:43:01', 8);
INSERT INTO `sys_oper_log` VALUES (129, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"董立勃\",\"bookId\":9,\"bookName\":\"垦荒\",\"borrowTime\":\"2026-03-08\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787020196999\",\"params\":{},\"planReturnTime\":\"2026-03-22\",\"recordId\":6,\"status\":\"3\",\"updateTime\":\"2026-04-26 15:43:01\",\"userId\":1006,\"userName\":\"周八\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:43:01', 5);
INSERT INTO `sys_oper_log` VALUES (130, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"苏童\",\"bookId\":5,\"bookName\":\"好天气\",\"borrowTime\":\"2026-03-10\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787559495303\",\"params\":{},\"planReturnTime\":\"2026-03-24\",\"recordId\":4,\"status\":\"3\",\"updateTime\":\"2026-04-26 15:43:01\",\"userId\":1004,\"userName\":\"赵六\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:43:01', 5);
INSERT INTO `sys_oper_log` VALUES (131, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"刘震云\",\"bookId\":3,\"bookName\":\"咸的玩笑\",\"borrowTime\":\"2026-03-05\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787020197620\",\"params\":{},\"planReturnTime\":\"2026-03-19\",\"recordId\":2,\"status\":\"3\",\"updateTime\":\"2026-04-26 15:43:01\",\"userId\":1002,\"userName\":\"李四\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:43:01', 60);
INSERT INTO `sys_oper_log` VALUES (132, '用户头像', 2, 'com.ruoyi.system.controller.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/user/profile/avatar', '127.0.0.1', '', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"http://127.0.0.1:9300/statics/2026/04/26/avatar_20260426155043A001.png\",\"code\":200}', 0, NULL, '2026-04-26 15:50:44', 1846);
INSERT INTO `sys_oper_log` VALUES (133, '书籍封面', 2, 'com.ruoyi.book.controller.BookController.uploadCover()', 'POST', 1, 'admin', NULL, '/book/detail/uploadCover', '127.0.0.1', '', '', '{\"msg\":\"操作成功\",\"fileName\":\"book/cover/2026/04/26/Screenshot_20241008_233521_tv.danmaku.bilibilihd_20260426155727A001.jpg\",\"code\":200,\"newFileName\":\"Screenshot_20241008_233521_tv.danmaku.bilibilihd_20260426155727A001.jpg\",\"url\":\"http://localhost:9000/ruoyi/book/cover/2026/04/26/Screenshot_20241008_233521_tv.danmaku.bilibilihd_20260426155727A001.jpg\",\"originalFilename\":\"Screenshot_20241008_233521_tv.danmaku.bilibilihd.jpg\"}', 0, NULL, '2026-04-26 15:57:27', 242);
INSERT INTO `sys_oper_log` VALUES (134, '书籍信息', 2, 'com.ruoyi.book.controller.BookController.edit()', 'PUT', 1, 'admin', NULL, '/book/detail', '127.0.0.1', '', '{\"author\":\"毕淑敏\",\"bookId\":1,\"bookName\":\"昆仑约定\",\"category\":\"小说\",\"coverImg\":\"book/cover/2026/04/26/Screenshot_20241008_233521_tv.danmaku.bilibilihd_20260426155727A001.jpg\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787020191635\",\"params\":{},\"stock\":50,\"updateTime\":\"2026-04-26 15:57:29\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 15:57:29', 14);
INSERT INTO `sys_oper_log` VALUES (135, '用户头像', 2, 'com.ruoyi.system.controller.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/user/profile/avatar', '127.0.0.1', '', '', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'avatar\' at row 1\r\n### The error may exist in file [D:\\GaoHe\\Ruoyi-Cloud\\ruoyi-modules\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUserAvatar-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user set avatar = ?, update_time = sysdate() where user_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'avatar\' at row 1\n; Data truncation: Data too long for column \'avatar\' at row 1', '2026-04-26 16:01:30', 159);
INSERT INTO `sys_oper_log` VALUES (136, '用户头像', 2, 'com.ruoyi.system.controller.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/user/profile/avatar', '127.0.0.1', '', '', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'avatar\' at row 1\r\n### The error may exist in file [D:\\GaoHe\\Ruoyi-Cloud\\ruoyi-modules\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUserAvatar-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user set avatar = ?, update_time = sysdate() where user_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'avatar\' at row 1\n; Data truncation: Data too long for column \'avatar\' at row 1', '2026-04-26 16:01:50', 9);
INSERT INTO `sys_oper_log` VALUES (137, '用户头像', 2, 'com.ruoyi.system.controller.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/user/profile/avatar', '127.0.0.1', '', '', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'avatar\' at row 1\r\n### The error may exist in file [D:\\GaoHe\\Ruoyi-Cloud\\ruoyi-modules\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUserAvatar-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user set avatar = ?, update_time = sysdate() where user_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'avatar\' at row 1\n; Data truncation: Data too long for column \'avatar\' at row 1', '2026-04-26 16:02:21', 11);
INSERT INTO `sys_oper_log` VALUES (138, '用户头像', 2, 'com.ruoyi.system.controller.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/user/profile/avatar', '127.0.0.1', '', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"http://127.0.0.1:9300/statics/2026/04/26/微信图片_2025-09-17_123021_110_20260426160257A005.jpg\",\"code\":200}', 0, NULL, '2026-04-26 16:02:57', 47);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2026-04-26 09:18:17\",\"icon\":\"download\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2000,\"menuName\":\"minio控制台\",\"menuType\":\"C\",\"orderNum\":11,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:9000\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 13:38:04', 27);
INSERT INTO `sys_oper_log` VALUES (140, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"朱山坡\",\"bookId\":7,\"bookName\":\"好天气\",\"borrowTime\":\"2026-03-15\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787574905559\",\"params\":{},\"planReturnTime\":\"2026-03-29\",\"recordId\":10,\"status\":\"3\",\"updateTime\":\"2026-04-27 16:11:55\",\"userId\":1010,\"userName\":\"陈二\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:11:56', 49);
INSERT INTO `sys_oper_log` VALUES (141, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"姚鄂梅\",\"bookId\":2,\"bookName\":\"海燕\",\"borrowTime\":\"2026-03-12\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787020192335\",\"params\":{},\"planReturnTime\":\"2026-03-26\",\"recordId\":8,\"status\":\"3\",\"updateTime\":\"2026-04-27 16:11:55\",\"userId\":1008,\"userName\":\"郑十\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:11:56', 49);
INSERT INTO `sys_oper_log` VALUES (142, '借阅记录', 2, 'com.ruoyi.book.controller.BorrowRecordController.edit()', 'PUT', 1, 'admin', NULL, '/book/record', '127.0.0.1', '', '{\"author\":\"曹乃谦\",\"bookId\":6,\"bookName\":\"咸的玩笑\",\"borrowTime\":\"2026-03-12\",\"category\":\"小说\",\"createTime\":\"2026-04-26 14:05:05\",\"isbn\":\"9787572621772\",\"params\":{},\"planReturnTime\":\"2026-03-26\",\"recordId\":8,\"status\":\"3\",\"updateTime\":\"2026-04-27 16:11:55\",\"userId\":1008,\"userName\":\"郑十\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:11:56', 49);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-04-25 23:52:50', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-04-25 23:52:50', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-04-25 23:52:50', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-04-25 23:52:50', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-04-25 23:52:50', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-04-25 23:52:50', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 118);
INSERT INTO `sys_role_menu` VALUES (2, 119);
INSERT INTO `sys_role_menu` VALUES (2, 120);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', 'http://127.0.0.1:9300/statics/2026/04/26/微信图片_2025-09-17_123021_110_20260426160257A005.jpg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-04-27 13:28:15', '2026-04-25 23:52:50', 'admin', '2026-04-25 23:52:50', '', '2026-04-26 16:02:57', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-04-25 23:52:50', '2026-04-25 23:52:50', 'admin', '2026-04-25 23:52:50', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
