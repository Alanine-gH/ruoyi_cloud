/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : localhost:3306
 Source Schema         : slim_camp

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 26/04/2026 16:08:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ai_model_config
-- ----------------------------
DROP TABLE IF EXISTS `ai_model_config`;
CREATE TABLE `ai_model_config`  (
  `model_id` bigint NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `model_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模型名称',
  `model_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模型类型',
  `model_version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模型版本号',
  `endpoint_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模型服务Endpoint URL',
  `api_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'API密钥',
  `timeout` int NULL DEFAULT 30 COMMENT '超时时间（秒）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0停用 1启用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`model_id`) USING BTREE,
  UNIQUE INDEX `uk_model_type_version`(`model_type` ASC, `model_version` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'AI模型配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ai_model_config
-- ----------------------------
INSERT INTO `ai_model_config` VALUES (100, '阿里云食物识别模型', 'food_recognition', 'v1.0', 'https://dtplus-cn-shanghai.data.aliyuncs.com/food-recognition', 'your-aliyun-api-key-here', 30, '1', 'system', '2024-01-01 00:00:00', 'admin', '2024-12-01 10:00:00', '阿里云食物识别服务配置');
INSERT INTO `ai_model_config` VALUES (101, 'DeepSeek情绪分析模型', 'emotion_analysis', 'v1.0', 'https://api.deepseek.com/v1/chat/completions', 'your-deepseek-api-key-here', 60, '1', 'system', '2024-01-01 00:00:00', 'admin', '2024-12-01 10:05:00', 'DeepSeek大模型用于情绪分析和智能推荐');

-- ----------------------------
-- Table structure for community_comment
-- ----------------------------
DROP TABLE IF EXISTS `community_comment`;
CREATE TABLE `community_comment`  (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `post_id` bigint NOT NULL COMMENT '帖子ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父评论ID',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0正常 1删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社区评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of community_comment
-- ----------------------------

-- ----------------------------
-- Table structure for community_like
-- ----------------------------
DROP TABLE IF EXISTS `community_like`;
CREATE TABLE `community_like`  (
  `like_id` bigint NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `target_id` bigint NOT NULL COMMENT '目标ID（帖子ID或评论ID）',
  `target_type` tinyint(1) NOT NULL COMMENT '目标类型（1帖子 2评论）',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`like_id`) USING BTREE,
  UNIQUE INDEX `uk_target_user`(`target_id` ASC, `target_type` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社区点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of community_like
-- ----------------------------

-- ----------------------------
-- Table structure for community_post
-- ----------------------------
DROP TABLE IF EXISTS `community_post`;
CREATE TABLE `community_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '帖子内容',
  `images` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片地址（逗号分隔）',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `comment_count` int NULL DEFAULT 0 COMMENT '评论数',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览数',
  `is_top` tinyint(1) NULL DEFAULT 0 COMMENT '是否置顶',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0正常 1审核中 2审核失败 3删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`post_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社区帖子表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of community_post
-- ----------------------------

-- ----------------------------
-- Table structure for fitness_checkin
-- ----------------------------
DROP TABLE IF EXISTS `fitness_checkin`;
CREATE TABLE `fitness_checkin`  (
  `checkin_id` bigint NOT NULL AUTO_INCREMENT COMMENT '打卡ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `checkin_time` datetime NOT NULL COMMENT '打卡时间',
  `course_id` bigint NULL DEFAULT NULL COMMENT '关联课程ID（gym_course_template.template_id）',
  `recipe_id` bigint NULL DEFAULT NULL COMMENT '关联食谱ID（fitness_recipe.recipe_id）',
  `checkin_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '打卡类型（运动打卡,饮食打卡,冥想打卡）',
  `continuous_days` int NULL DEFAULT 1 COMMENT '连续打卡天数',
  `reward_id` bigint NULL DEFAULT NULL COMMENT '关联奖励ID（fitness_reward.reward_id）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`checkin_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_checkin_time`(`checkin_time` ASC) USING BTREE,
  INDEX `idx_user_id_checkin_time`(`user_id` ASC, `checkin_time` ASC) USING BTREE,
  INDEX `idx_checkin_type`(`checkin_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户打卡记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_checkin
-- ----------------------------
INSERT INTO `fitness_checkin` VALUES (100, 200, '2025-12-18 10:00:00', 100, NULL, '运动打卡', 1, NULL, '基础瑜伽', 'member_zhao', '2025-12-18 10:00:00', 'member_zhao', '2025-12-18 10:00:00', 0);
INSERT INTO `fitness_checkin` VALUES (101, 200, '2025-12-19 11:00:00', 101, NULL, '运动打卡', 2, NULL, '3D运动', 'member_zhao', '2025-12-19 11:00:00', 'member_zhao', '2025-12-19 11:00:00', 0);
INSERT INTO `fitness_checkin` VALUES (102, 200, '2025-12-20 09:30:00', 100, NULL, '运动打卡', 3, NULL, '瑜伽晨练', 'member_zhao', '2025-12-20 09:30:00', 'member_zhao', '2025-12-20 09:30:00', 0);
INSERT INTO `fitness_checkin` VALUES (103, 200, '2025-12-21 15:30:00', 102, NULL, '冥想打卡', 4, NULL, '深度冥想', 'member_zhao', '2025-12-21 15:30:00', 'member_zhao', '2025-12-21 15:30:00', 0);
INSERT INTO `fitness_checkin` VALUES (104, 200, '2025-12-22 10:00:00', 100, NULL, '运动打卡', 5, NULL, '持续训练', 'member_zhao', '2025-12-22 10:00:00', 'member_zhao', '2025-12-22 10:00:00', 0);
INSERT INTO `fitness_checkin` VALUES (105, 201, '2025-12-20 10:30:00', 101, NULL, '运动打卡', 1, NULL, '3D体验', 'member_qian', '2025-12-20 10:30:00', 'member_qian', '2025-12-20 10:30:00', 0);
INSERT INTO `fitness_checkin` VALUES (106, 201, '2025-12-21 11:00:00', 104, NULL, '运动打卡', 2, NULL, '动感单车', 'member_qian', '2025-12-21 11:00:00', 'member_qian', '2025-12-21 11:00:00', 0);
INSERT INTO `fitness_checkin` VALUES (107, 202, '2025-12-21 10:00:00', 100, NULL, '运动打卡', 1, NULL, '瑜伽入门', 'member_sun', '2025-12-21 10:00:00', 'member_sun', '2025-12-21 10:00:00', 0);
INSERT INTO `fitness_checkin` VALUES (108, 202, '2025-12-22 15:30:00', 102, NULL, '冥想打卡', 2, NULL, '午后冥想', 'member_sun', '2025-12-22 15:30:00', 'member_sun', '2025-12-22 15:30:00', 0);

-- ----------------------------
-- Table structure for fitness_emotion_intervention
-- ----------------------------
DROP TABLE IF EXISTS `fitness_emotion_intervention`;
CREATE TABLE `fitness_emotion_intervention`  (
  `intervention_id` bigint NOT NULL AUTO_INCREMENT COMMENT '干预ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `emotion_record_id` bigint NOT NULL COMMENT '情绪记录ID',
  `intervention_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '干预类型',
  `intervention_content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '干预内容',
  `intervention_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '干预结果',
  `effectiveness_rating` int NULL DEFAULT NULL COMMENT '效果评分（1-5分）',
  `intervention_time` datetime NOT NULL COMMENT '干预时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`intervention_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_intervention_time`(`intervention_time` ASC) USING BTREE,
  INDEX `idx_user_id_intervention_time`(`user_id` ASC, `intervention_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '情绪干预记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_emotion_intervention
-- ----------------------------

-- ----------------------------
-- Table structure for fitness_emotion_record
-- ----------------------------
DROP TABLE IF EXISTS `fitness_emotion_record`;
CREATE TABLE `fitness_emotion_record`  (
  `emotion_id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `analysis_time` datetime NOT NULL COMMENT '分析时间',
  `emotion_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '情绪状态（0正面 1负面）',
  `analysis_basis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分析依据（语音语调,睡眠质量,饮食频率）',
  `push_course_id` bigint NULL DEFAULT NULL COMMENT '推送课程ID（冥想课程）',
  `push_recipe_id` bigint NULL DEFAULT NULL COMMENT '推送食谱ID（解压食谱）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`emotion_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_analysis_time`(`analysis_time` ASC) USING BTREE,
  INDEX `idx_user_id_analysis_time`(`user_id` ASC, `analysis_time` ASC) USING BTREE,
  INDEX `idx_emotion_status`(`emotion_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '情绪分析记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_emotion_record
-- ----------------------------
INSERT INTO `fitness_emotion_record` VALUES (100, 200, '2025-12-20 22:00:00', '0', '睡眠质量良好,运动频率稳定', NULL, NULL, 'system', '2025-12-20 22:00:00', 'system', '2025-12-20 22:00:00', 0);
INSERT INTO `fitness_emotion_record` VALUES (101, 201, '2025-12-21 22:00:00', '1', '睡眠质量一般,工作压力大', 102, 103, 'system', '2025-12-21 22:00:00', 'system', '2025-12-21 22:00:00', 0);
INSERT INTO `fitness_emotion_record` VALUES (102, 202, '2025-12-22 22:00:00', '0', '运动打卡连续2天,心情愉悦', NULL, NULL, 'system', '2025-12-22 22:00:00', 'system', '2025-12-22 22:00:00', 0);

-- ----------------------------
-- Table structure for fitness_environment_detection
-- ----------------------------
DROP TABLE IF EXISTS `fitness_environment_detection`;
CREATE TABLE `fitness_environment_detection`  (
  `detection_id` bigint NOT NULL AUTO_INCREMENT COMMENT '检测ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `environment_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '环境类型',
  `space_size` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '空间大小',
  `available_equipment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '可用器械',
  `lighting_condition` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '光线条件',
  `location_lat` decimal(10, 8) NULL DEFAULT NULL COMMENT '纬度',
  `location_lng` decimal(11, 8) NULL DEFAULT NULL COMMENT '经度',
  `location_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '位置地址',
  `recommended_course_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '推荐课程ID列表',
  `detection_time` datetime NOT NULL COMMENT '检测时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`detection_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_detection_time`(`detection_time` ASC) USING BTREE,
  INDEX `idx_user_id_detection_time`(`user_id` ASC, `detection_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '环境检测记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_environment_detection
-- ----------------------------

-- ----------------------------
-- Table structure for fitness_food_recognition
-- ----------------------------
DROP TABLE IF EXISTS `fitness_food_recognition`;
CREATE TABLE `fitness_food_recognition`  (
  `recognition_id` bigint NOT NULL AUTO_INCREMENT COMMENT '识别ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `food_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '食物名称',
  `food_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '食物类别',
  `calorie` int NOT NULL COMMENT '热量（大卡）',
  `protein` decimal(5, 2) NULL DEFAULT NULL COMMENT '蛋白质（g）',
  `carbohydrate` decimal(5, 2) NULL DEFAULT NULL COMMENT '碳水化合物（g）',
  `fat` decimal(5, 2) NULL DEFAULT NULL COMMENT '脂肪（g）',
  `recognition_confidence` decimal(4, 2) NULL DEFAULT NULL COMMENT '识别置信度（%）',
  `ar_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'AR图像URL',
  `meal_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '餐次类型',
  `recognition_time` datetime NOT NULL COMMENT '识别时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`recognition_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_recognition_time`(`recognition_time` ASC) USING BTREE,
  INDEX `idx_user_id_recognition_time`(`user_id` ASC, `recognition_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'AI食物识别记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_food_recognition
-- ----------------------------
INSERT INTO `fitness_food_recognition` VALUES (100, 200, '鸡胸肉沙拉', '轻食', 280, 35.50, 12.00, 10.20, 95.50, 'https://ar-img.com/food100.jpg', 'lunch', '2025-12-18 12:30:00', 'member_zhao', '2025-12-18 12:30:00', 'member_zhao', '2025-12-18 12:30:00', 0);
INSERT INTO `fitness_food_recognition` VALUES (101, 200, '全麦三明治', '主食', 320, 18.00, 45.00, 8.50, 92.00, 'https://ar-img.com/food101.jpg', 'breakfast', '2025-12-19 08:00:00', 'member_zhao', '2025-12-19 08:00:00', 'member_zhao', '2025-12-19 08:00:00', 0);

-- ----------------------------
-- Table structure for fitness_game
-- ----------------------------
DROP TABLE IF EXISTS `fitness_game`;
CREATE TABLE `fitness_game`  (
  `game_id` bigint NOT NULL AUTO_INCREMENT COMMENT '游戏ID',
  `game_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '游戏名称',
  `game_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '游戏类型（有氧运动类,敏捷训练类）',
  `calorie` int NOT NULL COMMENT '消耗热量（大卡/局）',
  `game_rule` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏规则',
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏封面图',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`game_id`) USING BTREE,
  INDEX `idx_game_type`(`game_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '趣味游戏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_game
-- ----------------------------
INSERT INTO `fitness_game` VALUES (100, '跑酷挑战', '有氧运动类', 180, '在虚拟场景中奔跑跳跃,躲避障碍物,坚持5分钟为一局', 'https://game.com/parkour.jpg', 'admin', '2024-01-01 00:00:00', 'admin', '2024-12-01 00:00:00', 0);
INSERT INTO `fitness_game` VALUES (101, '拳击训练', '敏捷训练类', 220, '对准虚拟靶子出拳,根据节奏击打,3分钟为一局', 'https://game.com/boxing.jpg', 'admin', '2024-01-05 00:00:00', 'admin', '2024-12-01 00:00:00', 0);
INSERT INTO `fitness_game` VALUES (102, '节奏舞蹈', '有氧运动类', 200, '跟随音乐节奏做出指定动作,4分钟为一局', 'https://game.com/dance.jpg', 'admin', '2024-01-10 00:00:00', 'admin', '2024-12-01 00:00:00', 0);
INSERT INTO `fitness_game` VALUES (103, '篮球投篮', '敏捷训练类', 150, '模拟投篮动作,在规定时间内投中篮筐,2分钟为一局', 'https://game.com/basketball.jpg', 'admin', '2024-01-15 00:00:00', 'admin', '2024-12-01 00:00:00', 0);

-- ----------------------------
-- Table structure for fitness_game_record
-- ----------------------------
DROP TABLE IF EXISTS `fitness_game_record`;
CREATE TABLE `fitness_game_record`  (
  `game_record_id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `game_id` bigint NOT NULL COMMENT '游戏ID',
  `participate_time` datetime NOT NULL COMMENT '参与时间',
  `score` int NULL DEFAULT 0 COMMENT '游戏得分',
  `consume_calorie` int NULL DEFAULT 0 COMMENT '消耗热量（大卡）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`game_record_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_game_id`(`game_id` ASC) USING BTREE,
  INDEX `idx_user_id_game_id`(`user_id` ASC, `game_id` ASC) USING BTREE,
  INDEX `idx_participate_time`(`participate_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户游戏记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_game_record
-- ----------------------------
INSERT INTO `fitness_game_record` VALUES (100, 200, 100, '2025-12-20 16:00:00', 850, 180, 'member_zhao', '2025-12-20 16:00:00', 'member_zhao', '2025-12-20 16:00:00', 0);
INSERT INTO `fitness_game_record` VALUES (101, 200, 102, '2025-12-21 17:00:00', 920, 200, 'member_zhao', '2025-12-21 17:00:00', 'member_zhao', '2025-12-21 17:00:00', 0);
INSERT INTO `fitness_game_record` VALUES (102, 201, 101, '2025-12-20 15:00:00', 780, 220, 'member_qian', '2025-12-20 15:00:00', 'member_qian', '2025-12-20 15:00:00', 0);
INSERT INTO `fitness_game_record` VALUES (103, 201, 103, '2025-12-21 16:00:00', 24, 150, 'member_qian', '2025-12-21 16:00:00', 'member_qian', '2025-12-21 16:00:00', 0);
INSERT INTO `fitness_game_record` VALUES (104, 202, 102, '2025-12-21 18:00:00', 880, 200, 'member_sun', '2025-12-21 18:00:00', 'member_sun', '2025-12-21 18:00:00', 0);

-- ----------------------------
-- Table structure for fitness_posture_correction
-- ----------------------------
DROP TABLE IF EXISTS `fitness_posture_correction`;
CREATE TABLE `fitness_posture_correction`  (
  `correction_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `correction_time` datetime NOT NULL COMMENT '纠错时间',
  `error_posture` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '错误动作（深蹲膝盖内扣,平板支撑塌腰）',
  `correction_suggest` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '纠正建议（膝盖与脚尖方向一致,收紧核心）',
  `ai_analysis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'AI分析结果（动作标准度60%）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`correction_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_course_id`(`course_id` ASC) USING BTREE,
  INDEX `idx_user_id_course_id`(`user_id` ASC, `course_id` ASC) USING BTREE,
  INDEX `idx_correction_time`(`correction_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '运动姿态纠错日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_posture_correction
-- ----------------------------
INSERT INTO `fitness_posture_correction` VALUES (100, 200, 100, '2025-12-20 09:35:00', '下犬式-腰部下沉', '收紧核心,保持背部平直,臀部向上', 'AI动作标准度:65%', 'member_zhao', '2025-12-20 09:35:00', 'member_zhao', '2025-12-20 09:35:00', 0);
INSERT INTO `fitness_posture_correction` VALUES (101, 200, 100, '2025-12-20 09:45:00', '战士二式-前膝内扣', '前膝与脚尖方向一致,大腿与地面平行', 'AI动作标准度:70%', 'member_zhao', '2025-12-20 09:45:00', 'member_zhao', '2025-12-20 09:45:00', 0);
INSERT INTO `fitness_posture_correction` VALUES (102, 201, 101, '2025-12-20 10:40:00', '3D跳跃动作-落地膝盖僵直', '落地时微屈膝盖,缓冲冲击力', 'AI动作标准度:68%', 'member_qian', '2025-12-20 10:40:00', 'member_qian', '2025-12-20 10:40:00', 0);
INSERT INTO `fitness_posture_correction` VALUES (103, 202, 100, '2025-12-21 10:20:00', '平板支撑-塌腰', '收紧核心,保持身体一条直线', 'AI动作标准度:62%', 'member_sun', '2025-12-21 10:20:00', 'member_sun', '2025-12-21 10:20:00', 0);

-- ----------------------------
-- Table structure for fitness_recipe
-- ----------------------------
DROP TABLE IF EXISTS `fitness_recipe`;
CREATE TABLE `fitness_recipe`  (
  `recipe_id` bigint NOT NULL AUTO_INCREMENT COMMENT '食谱ID',
  `recipe_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '食谱名称',
  `recipe_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '食谱类型（减脂食谱,解压食谱,普通食谱）',
  `ingredients` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '食材（鸡胸肉200g,西兰花100g）',
  `cooking_method` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '做法步骤',
  `calorie` int NOT NULL COMMENT '热量（大卡）',
  `suitable_crowd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '适用人群（减脂人群,压力大人群）',
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '食谱封面图',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`recipe_id`) USING BTREE,
  INDEX `idx_recipe_type`(`recipe_type` ASC) USING BTREE,
  INDEX `idx_calorie`(`calorie` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '智能食谱表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_recipe
-- ----------------------------
INSERT INTO `fitness_recipe` VALUES (100, '鸡胸肉沙拉', '减脂食谱', '鸡胸肉200g,生菜100g,番茄50g,黄瓜50g,橄榄油10ml', '1.鸡胸肉煎熟切片；2.蔬菜洗净切块；3.混合后淋橄榄油', 280, '减脂人群,健身爱好者', 'https://recipe.com/chicken_salad.jpg', 'admin', '2024-01-01 10:00:00', 'admin', '2024-12-01 10:00:00', 0);
INSERT INTO `fitness_recipe` VALUES (101, '三文鱼藜麦饭', '减脂食谱', '三文鱼150g,藜麦100g,西兰花80g,柠檬半个', '1.藜麦煮熟；2.三文鱼煎至八分熟；3.西兰花焯水；4.摆盘淋柠檬汁', 420, '减脂人群,追求低脂高蛋白', 'https://recipe.com/salmon_quinoa.jpg', 'admin', '2024-01-05 10:00:00', 'admin', '2024-12-01 10:05:00', 0);
INSERT INTO `fitness_recipe` VALUES (102, '牛油果吐司', '普通食谱', '全麦面包2片,牛油果1个,鸡蛋1个,黑胡椒适量', '1.牛油果捣成泥；2.鸡蛋煎熟；3.涂抹在吐司上；4.撒黑胡椒', 350, '上班族,早餐推荐', 'https://recipe.com/avocado_toast.jpg', 'admin', '2024-01-10 10:00:00', 'admin', '2024-12-01 10:10:00', 0);
INSERT INTO `fitness_recipe` VALUES (103, '香蕉燕麦粥', '解压食谱', '燕麦50g,香蕉1根,牛奶200ml,蜂蜜10g', '1.燕麦加牛奶煮熟；2.香蕉切片；3.加入蜂蜜搅拌', 320, '压力大人群,失眠人群', 'https://recipe.com/banana_oat.jpg', 'admin', '2024-01-15 10:00:00', 'admin', '2024-12-01 10:15:00', 0);

-- ----------------------------
-- Table structure for fitness_reward
-- ----------------------------
DROP TABLE IF EXISTS `fitness_reward`;
CREATE TABLE `fitness_reward`  (
  `reward_id` bigint NOT NULL AUTO_INCREMENT COMMENT '奖励ID',
  `reward_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '奖励名称',
  `reward_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '奖励类型（实物奖励,课程解锁,优惠券）',
  `required_days` int NOT NULL COMMENT '所需连续打卡天数',
  `reward_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '奖励描述（健身瑜伽垫,解锁高级3D课程）',
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '奖励图片',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`reward_id`) USING BTREE,
  INDEX `idx_required_days`(`required_days` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '奖励表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_reward
-- ----------------------------
INSERT INTO `fitness_reward` VALUES (100, '7天连续打卡奖励', '实物奖励', 7, '瘦瘦营定制运动毛巾1条', 'https://reward.com/towel.jpg', 'admin', '2024-01-01 00:00:00', 'admin', '2024-12-01 00:00:00', 0);
INSERT INTO `fitness_reward` VALUES (101, '15天连续打卡奖励', '课程解锁', 15, '解锁1节高级3D课程', 'https://reward.com/course.jpg', 'admin', '2024-01-01 00:00:00', 'admin', '2024-12-01 00:00:00', 0);
INSERT INTO `fitness_reward` VALUES (102, '30天连续打卡奖励', '实物奖励', 30, '瘦瘦营定制瑜伽垫1张', 'https://reward.com/yoga_mat.jpg', 'admin', '2024-01-01 00:00:00', 'admin', '2024-12-01 00:00:00', 0);
INSERT INTO `fitness_reward` VALUES (103, '60天连续打卡奖励', '优惠券', 60, '会员卡续费98折优惠券', 'https://reward.com/coupon.jpg', 'admin', '2024-01-01 00:00:00', 'admin', '2024-12-01 00:00:00', 0);

-- ----------------------------
-- Table structure for fitness_weight_record
-- ----------------------------
DROP TABLE IF EXISTS `fitness_weight_record`;
CREATE TABLE `fitness_weight_record`  (
  `record_id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `record_time` datetime NOT NULL COMMENT '记录时间',
  `weight` decimal(5, 2) NOT NULL COMMENT '体重（kg）',
  `body_fat_rate` decimal(4, 2) NULL DEFAULT NULL COMMENT '体脂率（%）',
  `waistline` decimal(5, 2) NULL DEFAULT NULL COMMENT '腰围（cm）',
  `hip_circumference` decimal(5, 2) NULL DEFAULT NULL COMMENT '臀围（cm）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_record_time`(`record_time` ASC) USING BTREE,
  INDEX `idx_user_id_record_time`(`user_id` ASC, `record_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户体重记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_weight_record
-- ----------------------------
INSERT INTO `fitness_weight_record` VALUES (100, 200, '2024-03-01 08:00:00', 60.00, 28.00, 75.00, 95.00, '开始健身', 'member_zhao', '2024-03-01 08:00:00', 'member_zhao', '2024-03-01 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (101, 200, '2024-06-01 08:00:00', 57.00, 26.00, 72.00, 93.00, '3个月成果', 'member_zhao', '2024-06-01 08:00:00', 'member_zhao', '2024-06-01 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (102, 200, '2024-09-01 08:00:00', 55.00, 25.00, 71.00, 92.00, '半年效果', 'member_zhao', '2024-09-01 08:00:00', 'member_zhao', '2024-09-01 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (103, 200, '2025-12-22 08:00:00', 54.00, 24.00, 70.00, 91.00, '接近目标', 'member_zhao', '2025-12-22 08:00:00', 'member_zhao', '2025-12-22 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (104, 201, '2024-03-05 08:00:00', 85.00, 24.00, 92.00, 102.00, '开始', 'member_qian', '2024-03-05 08:00:00', 'member_qian', '2024-03-05 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (105, 201, '2024-08-05 08:00:00', 80.00, 21.50, 87.00, 98.00, '5个月', 'member_qian', '2024-08-05 08:00:00', 'member_qian', '2024-08-05 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (106, 201, '2025-12-22 08:00:00', 76.00, 20.00, 83.00, 95.00, '稳步前进', 'member_qian', '2025-12-22 08:00:00', 'member_qian', '2025-12-22 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (107, 202, '2024-03-10 08:00:00', 62.00, 25.50, 70.00, 96.00, '初始', 'member_sun', '2024-03-10 08:00:00', 'member_sun', '2024-03-10 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (108, 202, '2024-09-10 08:00:00', 59.00, 23.50, 68.00, 94.00, '半年', 'member_sun', '2024-09-10 08:00:00', 'member_sun', '2024-09-10 08:00:00', 0);
INSERT INTO `fitness_weight_record` VALUES (109, 202, '2025-12-23 08:00:00', 56.00, 22.50, 66.00, 92.00, '目标接近', 'member_sun', '2025-12-23 08:00:00', 'member_sun', '2025-12-23 08:00:00', 0);

-- ----------------------------
-- Table structure for gym_booking
-- ----------------------------
DROP TABLE IF EXISTS `gym_booking`;
CREATE TABLE `gym_booking`  (
  `booking_id` bigint NOT NULL AUTO_INCREMENT COMMENT '预约ID',
  `schedule_id` bigint NOT NULL COMMENT '排期ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `user_card_id` bigint NULL DEFAULT NULL COMMENT '用户卡ID（扣卡次数）',
  `booking_time` datetime NOT NULL COMMENT '预约时间',
  `booking_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '预约状态（0已预约 1已签到 2已完成 3已取消 4爽约）',
  `checkin_time` datetime NULL DEFAULT NULL COMMENT '签到时间',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '取消时间',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '取消原因',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`booking_id`) USING BTREE,
  INDEX `idx_schedule_id`(`schedule_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_user_card_id`(`user_card_id` ASC) USING BTREE,
  INDEX `idx_schedule_id_booking_status`(`schedule_id` ASC, `booking_status` ASC) USING BTREE,
  INDEX `idx_user_id_booking_time`(`user_id` ASC, `booking_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '课程预约表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gym_booking
-- ----------------------------
INSERT INTO `gym_booking` VALUES (100, 100, 200, 100, '2025-12-20 10:00:00', '1', '2025-12-23 08:50:00', NULL, NULL, 'member_zhao', '2025-12-20 10:00:00', 'member_zhao', '2025-12-23 08:50:00', 0);
INSERT INTO `gym_booking` VALUES (101, 101, 200, 100, '2025-12-21 09:15:00', '0', NULL, NULL, NULL, 'member_zhao', '2025-12-21 09:15:00', 'member_zhao', '2025-12-21 09:15:00', 0);
INSERT INTO `gym_booking` VALUES (102, 100, 201, 101, '2025-12-20 11:00:00', '1', '2025-12-23 08:55:00', NULL, NULL, 'member_qian', '2025-12-20 11:00:00', 'member_qian', '2025-12-23 08:55:00', 0);
INSERT INTO `gym_booking` VALUES (103, 100, 202, 102, '2025-12-20 12:00:00', '1', '2025-12-23 08:58:00', NULL, NULL, 'member_sun', '2025-12-20 12:00:00', 'member_sun', '2025-12-23 08:58:00', 0);

-- ----------------------------
-- Table structure for gym_card_type
-- ----------------------------
DROP TABLE IF EXISTS `gym_card_type`;
CREATE TABLE `gym_card_type`  (
  `card_type_id` bigint NOT NULL AUTO_INCREMENT COMMENT '卡类型ID',
  `gym_id` bigint NOT NULL COMMENT '所属场馆ID',
  `card_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员卡名称',
  `card_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '卡类型（次卡,期限卡,储值卡）',
  `validity_days` int NULL DEFAULT NULL COMMENT '有效期（天）',
  `total_times` int NULL DEFAULT NULL COMMENT '总次数（次卡专用）',
  `price` decimal(10, 2) NOT NULL COMMENT '售价',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原价',
  `card_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '卡状态（0在售 1停售）',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '卡片说明',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`card_type_id`) USING BTREE,
  INDEX `idx_gym_id`(`gym_id` ASC) USING BTREE,
  INDEX `idx_gym_id_card_type`(`gym_id` ASC, `card_type` ASC) USING BTREE,
  INDEX `idx_card_status`(`card_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 160 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员卡类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gym_card_type
-- ----------------------------
INSERT INTO `gym_card_type` VALUES (100, 100, '30次健身次卡', '次卡', NULL, 30, 1999.00, 2599.00, '0', '30次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-01-10 14:00:00', 'admin', '2024-06-15 16:00:00', 0);
INSERT INTO `gym_card_type` VALUES (101, 100, '年卡会员', '期限卡', 365, NULL, 5999.00, 7999.00, '0', '全年不限次数健身，含免费私教课2节，优先预约课程', 'admin', '2024-01-10 14:30:00', 'admin', '2024-06-15 16:05:00', 0);
INSERT INTO `gym_card_type` VALUES (102, 100, '储值2000元卡', '储值卡', NULL, NULL, 2000.00, NULL, '0', '储值2000元，消费享9折优惠，累计储值升级会员等级', 'admin', '2024-01-10 15:00:00', 'admin', '2024-06-15 16:10:00', 0);
INSERT INTO `gym_card_type` VALUES (103, 101, '50次健身次卡', '次卡', NULL, 50, 2999.00, 3699.00, '0', '50次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-01-15 10:30:00', 'admin', '2024-07-20 11:50:00', 0);
INSERT INTO `gym_card_type` VALUES (104, 101, '半年卡会员', '期限卡', 180, NULL, 3299.00, 4299.00, '0', '半年不限次数健身，含免费私教课1节，优先预约课程', 'admin', '2024-01-15 11:00:00', 'admin', '2024-07-20 11:55:00', 0);
INSERT INTO `gym_card_type` VALUES (105, 101, '储值3000元卡', '储值卡', NULL, NULL, 3000.00, NULL, '0', '储值3000元，消费享8.5折优惠，累计储值升级会员等级', 'admin', '2024-01-15 11:30:00', 'admin', '2024-07-20 12:00:00', 0);
INSERT INTO `gym_card_type` VALUES (106, 102, '20次健身次卡', '次卡', NULL, 20, 1299.00, 1699.00, '0', '20次通用次卡，可预约所有常规课程，有效期6个月', 'admin', '2024-02-15 10:00:00', 'admin', '2024-07-20 14:20:00', 0);
INSERT INTO `gym_card_type` VALUES (107, 102, '季卡会员', '期限卡', 90, NULL, 1999.00, 2599.00, '0', '季度不限次数健身，优先预约课程，赠送运动背包', 'admin', '2024-02-15 10:30:00', 'admin', '2024-07-20 14:25:00', 0);
INSERT INTO `gym_card_type` VALUES (108, 102, '储值1000元卡', '储值卡', NULL, NULL, 1000.00, NULL, '0', '储值1000元，消费享9.5折优惠，累计储值升级会员等级', 'admin', '2024-02-15 11:00:00', 'admin', '2024-07-20 14:30:00', 0);
INSERT INTO `gym_card_type` VALUES (109, 103, '40次健身次卡', '次卡', NULL, 40, 2499.00, 3199.00, '0', '40次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-02-20 10:30:00', 'admin', '2024-08-05 15:00:00', 0);
INSERT INTO `gym_card_type` VALUES (110, 103, '年卡会员Pro', '期限卡', 365, NULL, 6999.00, 8999.00, '0', '全年不限次数健身，含免费私教课4节，专属教练指导', 'admin', '2024-02-20 11:00:00', 'admin', '2024-08-05 15:05:00', 0);
INSERT INTO `gym_card_type` VALUES (111, 103, '储值5000元卡', '储值卡', NULL, NULL, 5000.00, NULL, '0', '储值5000元，消费享8折优惠，赠送高级瑜伽垫', 'admin', '2024-02-20 11:30:00', 'admin', '2024-08-05 15:10:00', 0);
INSERT INTO `gym_card_type` VALUES (112, 104, '30次健身次卡', '次卡', NULL, 30, 1899.00, 2499.00, '0', '30次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-03-05 12:00:00', 'admin', '2024-08-10 16:20:00', 0);
INSERT INTO `gym_card_type` VALUES (113, 104, '年卡会员', '期限卡', 365, NULL, 5799.00, 7599.00, '0', '全年不限次数健身，含免费私教课3节，优先预约课程', 'admin', '2024-03-05 12:30:00', 'admin', '2024-08-10 16:25:00', 0);
INSERT INTO `gym_card_type` VALUES (114, 104, '储值2500元卡', '储值卡', NULL, NULL, 2500.00, NULL, '0', '储值2500元，消费享8.8折优惠，累计储值升级会员等级', 'admin', '2024-03-05 13:00:00', 'admin', '2024-08-10 16:30:00', 0);
INSERT INTO `gym_card_type` VALUES (115, 105, '60次健身次卡', '次卡', NULL, 60, 3499.00, 4299.00, '0', '60次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-03-10 14:30:00', 'admin', '2024-08-15 17:10:00', 0);
INSERT INTO `gym_card_type` VALUES (116, 105, '年卡会员Plus', '期限卡', 365, NULL, 6499.00, 8299.00, '0', '全年不限次数健身，含免费私教课5节，专属教练服务', 'admin', '2024-03-10 15:00:00', 'admin', '2024-08-15 17:15:00', 0);
INSERT INTO `gym_card_type` VALUES (117, 105, '储值4000元卡', '储值卡', NULL, NULL, 4000.00, NULL, '0', '储值4000元，消费享8.2折优惠，赠送运动水壶', 'admin', '2024-03-10 15:30:00', 'admin', '2024-08-15 17:20:00', 0);
INSERT INTO `gym_card_type` VALUES (118, 106, '25次健身次卡', '次卡', NULL, 25, 1599.00, 2099.00, '0', '25次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-03-15 09:50:00', 'admin', '2024-09-01 10:50:00', 0);
INSERT INTO `gym_card_type` VALUES (119, 106, '半年卡会员', '期限卡', 180, NULL, 3199.00, 4199.00, '0', '半年不限次数健身，含免费私教课2节，优先预约课程', 'admin', '2024-03-15 10:20:00', 'admin', '2024-09-01 10:55:00', 0);
INSERT INTO `gym_card_type` VALUES (120, 106, '储值1500元卡', '储值卡', NULL, NULL, 1500.00, NULL, '0', '储值1500元，消费享9.2折优惠，累计储值升级会员等级', 'admin', '2024-03-15 10:50:00', 'admin', '2024-09-01 11:00:00', 0);
INSERT INTO `gym_card_type` VALUES (121, 107, '40次健身次卡', '次卡', NULL, 40, 2399.00, 3099.00, '0', '40次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-03-20 11:20:00', 'admin', '2024-09-05 11:50:00', 0);
INSERT INTO `gym_card_type` VALUES (122, 107, '年卡会员', '期限卡', 365, NULL, 5899.00, 7699.00, '0', '全年不限次数健身，含免费私教课3节，优先预约课程', 'admin', '2024-03-20 11:50:00', 'admin', '2024-09-05 11:55:00', 0);
INSERT INTO `gym_card_type` VALUES (123, 107, '储值3500元卡', '储值卡', NULL, NULL, 3500.00, NULL, '0', '储值3500元，消费享8.3折优惠，赠送运动手环', 'admin', '2024-03-20 12:20:00', 'admin', '2024-09-05 12:00:00', 0);
INSERT INTO `gym_card_type` VALUES (124, 108, '35次健身次卡', '次卡', NULL, 35, 2099.00, 2699.00, '0', '35次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-04-01 14:50:00', 'admin', '2024-09-10 15:10:00', 0);
INSERT INTO `gym_card_type` VALUES (125, 108, '季卡会员', '期限卡', 90, NULL, 1899.00, 2499.00, '0', '季度不限次数健身，优先预约课程，赠送运动背包', 'admin', '2024-04-01 15:20:00', 'admin', '2024-09-10 15:15:00', 0);
INSERT INTO `gym_card_type` VALUES (126, 108, '储值2000元卡', '储值卡', NULL, NULL, 2000.00, NULL, '0', '储值2000元，消费享9折优惠，累计储值升级会员等级', 'admin', '2024-04-01 15:50:00', 'admin', '2024-09-10 15:20:00', 0);
INSERT INTO `gym_card_type` VALUES (127, 109, '45次健身次卡', '次卡', NULL, 45, 2699.00, 3499.00, '0', '45次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-04-05 16:20:00', 'admin', '2024-09-15 16:10:00', 0);
INSERT INTO `gym_card_type` VALUES (128, 109, '年卡会员', '期限卡', 365, NULL, 6199.00, 7999.00, '0', '全年不限次数健身，含免费私教课4节，专属教练指导', 'admin', '2024-04-05 16:50:00', 'admin', '2024-09-15 16:15:00', 0);
INSERT INTO `gym_card_type` VALUES (129, 109, '储值4500元卡', '储值卡', NULL, NULL, 4500.00, NULL, '0', '储值4500元，消费享8折优惠，赠送高级运动套装', 'admin', '2024-04-05 17:20:00', 'admin', '2024-09-15 16:20:00', 0);
INSERT INTO `gym_card_type` VALUES (130, 110, '30次健身次卡', '次卡', NULL, 30, 1799.00, 2399.00, '0', '30次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-04-10 10:20:00', 'admin', '2024-09-20 11:30:00', 0);
INSERT INTO `gym_card_type` VALUES (131, 110, '半年卡会员', '期限卡', 180, NULL, 3099.00, 4099.00, '0', '半年不限次数健身，含免费私教课2节，优先预约课程', 'admin', '2024-04-10 10:50:00', 'admin', '2024-09-20 11:35:00', 0);
INSERT INTO `gym_card_type` VALUES (132, 110, '储值2200元卡', '储值卡', NULL, NULL, 2200.00, NULL, '0', '储值2200元，消费享8.9折优惠，累计储值升级会员等级', 'admin', '2024-04-10 11:20:00', 'admin', '2024-09-20 11:40:00', 0);
INSERT INTO `gym_card_type` VALUES (133, 111, '50次健身次卡', '次卡', NULL, 50, 2899.00, 3599.00, '0', '50次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-04-15 10:50:00', 'admin', '2024-09-25 11:50:00', 0);
INSERT INTO `gym_card_type` VALUES (134, 111, '年卡会员Pro', '期限卡', 365, NULL, 6799.00, 8699.00, '0', '全年不限次数健身，含免费私教课5节，专属教练服务', 'admin', '2024-04-15 11:20:00', 'admin', '2024-09-25 11:55:00', 0);
INSERT INTO `gym_card_type` VALUES (135, 111, '储值5500元卡', '储值卡', NULL, NULL, 5500.00, NULL, '0', '储值5500元，消费享7.8折优惠，赠送高级瑜伽垫套装', 'admin', '2024-04-15 11:50:00', 'admin', '2024-09-25 12:00:00', 0);
INSERT INTO `gym_card_type` VALUES (136, 112, '20次健身次卡', '次卡', NULL, 20, 1399.00, 1799.00, '0', '20次通用次卡，可预约所有常规课程，有效期6个月', 'admin', '2024-04-20 15:20:00', 'admin', '2024-10-01 14:50:00', 0);
INSERT INTO `gym_card_type` VALUES (137, 112, '季卡会员', '期限卡', 90, NULL, 1999.00, 2599.00, '0', '季度不限次数健身，优先预约课程，赠送运动背包', 'admin', '2024-04-20 15:50:00', 'admin', '2024-10-01 14:55:00', 0);
INSERT INTO `gym_card_type` VALUES (138, 112, '储值1200元卡', '储值卡', NULL, NULL, 1200.00, NULL, '0', '储值1200元，消费享9.3折优惠，累计储值升级会员等级', 'admin', '2024-04-20 16:20:00', 'admin', '2024-10-01 15:00:00', 0);
INSERT INTO `gym_card_type` VALUES (139, 113, '35次健身次卡', '次卡', NULL, 35, 2199.00, 2799.00, '0', '35次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-04-25 16:00:00', 'admin', '2024-10-05 16:00:00', 0);
INSERT INTO `gym_card_type` VALUES (140, 113, '半年卡会员', '期限卡', 180, NULL, 3299.00, 4299.00, '0', '半年不限次数健身，含免费私教课2节，优先预约课程', 'admin', '2024-04-25 16:30:00', 'admin', '2024-10-05 16:05:00', 0);
INSERT INTO `gym_card_type` VALUES (141, 113, '储值2800元卡', '储值卡', NULL, NULL, 2800.00, NULL, '0', '储值2800元，消费享8.6折优惠，赠送运动毛巾', 'admin', '2024-04-25 17:00:00', 'admin', '2024-10-05 16:10:00', 0);
INSERT INTO `gym_card_type` VALUES (142, 114, '40次健身次卡', '次卡', NULL, 40, 2499.00, 3199.00, '0', '40次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-05-01 10:00:00', 'admin', '2024-10-10 11:10:00', 0);
INSERT INTO `gym_card_type` VALUES (143, 114, '年卡会员', '期限卡', 365, NULL, 6099.00, 7899.00, '0', '全年不限次数健身，含免费私教课4节，专属教练指导', 'admin', '2024-05-01 10:30:00', 'admin', '2024-10-10 11:15:00', 0);
INSERT INTO `gym_card_type` VALUES (144, 114, '储值4000元卡', '储值卡', NULL, NULL, 4000.00, NULL, '0', '储值4000元，消费享8.2折优惠，赠送运动水壶', 'admin', '2024-05-01 11:00:00', 'admin', '2024-10-10 11:20:00', 0);
INSERT INTO `gym_card_type` VALUES (145, 115, '55次健身次卡', '次卡', NULL, 55, 3199.00, 3999.00, '0', '55次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-05-05 11:30:00', 'admin', '2024-10-15 12:10:00', 0);
INSERT INTO `gym_card_type` VALUES (146, 115, '年卡会员Plus', '期限卡', 365, NULL, 6899.00, 8799.00, '0', '全年不限次数健身，含免费私教课6节，专属教练服务', 'admin', '2024-05-05 12:00:00', 'admin', '2024-10-15 12:15:00', 0);
INSERT INTO `gym_card_type` VALUES (147, 115, '储值6000元卡', '储值卡', NULL, NULL, 6000.00, NULL, '0', '储值6000元，消费享7.5折优惠，赠送高级运动套装', 'admin', '2024-05-05 12:30:00', 'admin', '2024-10-15 12:20:00', 0);
INSERT INTO `gym_card_type` VALUES (148, 116, '25次健身次卡', '次卡', NULL, 25, 1699.00, 2199.00, '0', '25次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-05-10 14:50:00', 'admin', '2024-10-20 15:30:00', 0);
INSERT INTO `gym_card_type` VALUES (149, 116, '季卡会员', '期限卡', 90, NULL, 2099.00, 2699.00, '0', '季度不限次数健身，优先预约课程，赠送运动背包', 'admin', '2024-05-10 15:20:00', 'admin', '2024-10-20 15:35:00', 0);
INSERT INTO `gym_card_type` VALUES (150, 116, '储值1800元卡', '储值卡', NULL, NULL, 1800.00, NULL, '0', '储值1800元，消费享9.1折优惠，累计储值升级会员等级', 'admin', '2024-05-10 15:50:00', 'admin', '2024-10-20 15:40:00', 0);
INSERT INTO `gym_card_type` VALUES (151, 117, '30次健身次卡', '次卡', NULL, 30, 1899.00, 2499.00, '0', '30次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-05-15 16:20:00', 'admin', '2024-10-25 15:50:00', 0);
INSERT INTO `gym_card_type` VALUES (152, 117, '半年卡会员', '期限卡', 180, NULL, 3199.00, 4199.00, '0', '半年不限次数健身，含免费私教课2节，优先预约课程', 'admin', '2024-05-15 16:50:00', 'admin', '2024-10-25 15:55:00', 0);
INSERT INTO `gym_card_type` VALUES (153, 117, '储值2500元卡', '储值卡', NULL, NULL, 2500.00, NULL, '0', '储值2500元，消费享8.8折优惠，赠送运动手环', 'admin', '2024-05-15 17:20:00', 'admin', '2024-10-25 16:00:00', 0);
INSERT INTO `gym_card_type` VALUES (154, 118, '45次健身次卡', '次卡', NULL, 45, 2799.00, 3599.00, '0', '45次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-05-20 10:00:00', 'admin', '2024-11-01 10:40:00', 0);
INSERT INTO `gym_card_type` VALUES (155, 118, '年卡会员', '期限卡', 365, NULL, 6299.00, 8099.00, '0', '全年不限次数健身，含免费私教课4节，专属教练指导', 'admin', '2024-05-20 10:30:00', 'admin', '2024-11-01 10:45:00', 0);
INSERT INTO `gym_card_type` VALUES (156, 118, '储值4200元卡', '储值卡', NULL, NULL, 4200.00, NULL, '0', '储值4200元，消费享8.1折优惠，赠送运动水壶', 'admin', '2024-05-20 11:00:00', 'admin', '2024-11-01 10:50:00', 0);
INSERT INTO `gym_card_type` VALUES (157, 119, '30次健身次卡', '次卡', NULL, 30, 1899.00, 2499.00, '0', '30次通用次卡，可预约所有常规课程，有效期1年', 'admin', '2024-05-25 10:50:00', 'admin', '2024-11-05 11:50:00', 0);
INSERT INTO `gym_card_type` VALUES (158, 119, '半年卡会员', '期限卡', 180, NULL, 3299.00, 4299.00, '0', '半年不限次数健身，含免费私教课3节，优先预约课程', 'admin', '2024-05-25 11:20:00', 'admin', '2024-11-05 11:55:00', 0);
INSERT INTO `gym_card_type` VALUES (159, 119, '储值3000元卡', '储值卡', NULL, NULL, 3000.00, NULL, '0', '储值3000元，消费享8.5折优惠，累计储值升级会员等级', 'admin', '2024-05-25 11:50:00', 'admin', '2024-11-05 12:00:00', 0);

-- ----------------------------
-- Table structure for gym_classroom
-- ----------------------------
DROP TABLE IF EXISTS `gym_classroom`;
CREATE TABLE `gym_classroom`  (
  `classroom_id` bigint NOT NULL AUTO_INCREMENT COMMENT '教室ID',
  `gym_id` bigint NOT NULL COMMENT '所属场馆ID',
  `classroom_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '教室名称',
  `classroom_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '教室类型（瑜伽室,单车房,操房）',
  `max_capacity` int NULL DEFAULT 0 COMMENT '最大容纳人数',
  `classroom_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '教室状态（0正常 1维护中）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`classroom_id`) USING BTREE,
  INDEX `idx_gym_id`(`gym_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 160 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '教室表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gym_classroom
-- ----------------------------
INSERT INTO `gym_classroom` VALUES (100, 100, '瑜伽一室', '瑜伽室', 25, '0', 'admin', '2024-01-10 10:30:00', 'admin', '2024-06-15 15:00:00', 0);
INSERT INTO `gym_classroom` VALUES (101, 100, '3D运动室', '3D运动室', 30, '0', 'admin', '2024-01-10 11:00:00', 'admin', '2024-06-15 15:05:00', 0);
INSERT INTO `gym_classroom` VALUES (102, 100, '冥想室', '冥想室', 20, '0', 'admin', '2024-01-10 11:30:00', 'admin', '2024-06-15 15:10:00', 0);
INSERT INTO `gym_classroom` VALUES (103, 101, '瑜伽二室', '瑜伽室', 25, '0', 'admin', '2024-01-15 10:00:00', 'admin', '2024-07-20 11:30:00', 0);
INSERT INTO `gym_classroom` VALUES (104, 101, '单车房', '单车房', 35, '0', 'admin', '2024-01-15 10:30:00', 'admin', '2024-07-20 11:35:00', 0);
INSERT INTO `gym_classroom` VALUES (105, 101, '操房', '操房', 40, '0', 'admin', '2024-01-15 11:00:00', 'admin', '2024-07-20 11:40:00', 0);
INSERT INTO `gym_classroom` VALUES (106, 102, '瑜伽三室', '瑜伽室', 25, '0', 'admin', '2024-02-15 10:00:00', 'admin', '2024-07-20 14:00:00', 0);
INSERT INTO `gym_classroom` VALUES (107, 102, '3D运动二室', '3D运动室', 30, '0', 'admin', '2024-02-15 10:30:00', 'admin', '2024-07-20 14:05:00', 0);
INSERT INTO `gym_classroom` VALUES (108, 102, '冥想二室', '冥想室', 20, '0', 'admin', '2024-02-15 11:00:00', 'admin', '2024-07-20 14:10:00', 0);
INSERT INTO `gym_classroom` VALUES (109, 103, '瑜伽四室', '瑜伽室', 25, '0', 'admin', '2024-02-20 10:30:00', 'admin', '2024-08-05 14:40:00', 0);
INSERT INTO `gym_classroom` VALUES (110, 103, '单车二房', '单车房', 35, '0', 'admin', '2024-02-20 11:00:00', 'admin', '2024-08-05 14:45:00', 0);
INSERT INTO `gym_classroom` VALUES (111, 103, '操二房', '操房', 40, '0', 'admin', '2024-02-20 11:30:00', 'admin', '2024-08-05 14:50:00', 0);
INSERT INTO `gym_classroom` VALUES (112, 104, '瑜伽五室', '瑜伽室', 25, '0', 'admin', '2024-03-05 11:50:00', 'admin', '2024-08-10 15:50:00', 0);
INSERT INTO `gym_classroom` VALUES (113, 104, '3D运动三室', '3D运动室', 30, '0', 'admin', '2024-03-05 12:20:00', 'admin', '2024-08-10 15:55:00', 0);
INSERT INTO `gym_classroom` VALUES (114, 104, '冥想三室', '冥想室', 20, '0', 'admin', '2024-03-05 12:50:00', 'admin', '2024-08-10 16:00:00', 0);
INSERT INTO `gym_classroom` VALUES (115, 105, '瑜伽六室', '瑜伽室', 25, '0', 'admin', '2024-03-10 14:30:00', 'admin', '2024-08-15 16:50:00', 0);
INSERT INTO `gym_classroom` VALUES (116, 105, '单车三房', '单车房', 35, '0', 'admin', '2024-03-10 15:00:00', 'admin', '2024-08-15 16:55:00', 0);
INSERT INTO `gym_classroom` VALUES (117, 105, '操三房', '操房', 40, '0', 'admin', '2024-03-10 15:30:00', 'admin', '2024-08-15 17:00:00', 0);
INSERT INTO `gym_classroom` VALUES (118, 106, '瑜伽七室', '瑜伽室', 25, '0', 'admin', '2024-03-15 09:30:00', 'admin', '2024-09-01 10:30:00', 0);
INSERT INTO `gym_classroom` VALUES (119, 106, '3D运动四室', '3D运动室', 30, '0', 'admin', '2024-03-15 10:00:00', 'admin', '2024-09-01 10:35:00', 0);
INSERT INTO `gym_classroom` VALUES (120, 106, '冥想四室', '冥想室', 20, '0', 'admin', '2024-03-15 10:30:00', 'admin', '2024-09-01 10:40:00', 0);
INSERT INTO `gym_classroom` VALUES (121, 107, '瑜伽八室', '瑜伽室', 25, '0', 'admin', '2024-03-20 11:00:00', 'admin', '2024-09-05 11:40:00', 0);
INSERT INTO `gym_classroom` VALUES (122, 107, '单车四房', '单车房', 35, '0', 'admin', '2024-03-20 11:30:00', 'admin', '2024-09-05 11:45:00', 0);
INSERT INTO `gym_classroom` VALUES (123, 107, '操四房', '操房', 40, '0', 'admin', '2024-03-20 12:00:00', 'admin', '2024-09-05 11:50:00', 0);
INSERT INTO `gym_classroom` VALUES (124, 108, '瑜伽九室', '瑜伽室', 25, '0', 'admin', '2024-04-01 14:30:00', 'admin', '2024-09-10 14:50:00', 0);
INSERT INTO `gym_classroom` VALUES (125, 108, '3D运动五室', '3D运动室', 30, '0', 'admin', '2024-04-01 15:00:00', 'admin', '2024-09-10 14:55:00', 0);
INSERT INTO `gym_classroom` VALUES (126, 108, '冥想五室', '冥想室', 20, '0', 'admin', '2024-04-01 15:30:00', 'admin', '2024-09-10 15:00:00', 0);
INSERT INTO `gym_classroom` VALUES (127, 109, '瑜伽十室', '瑜伽室', 25, '0', 'admin', '2024-04-05 16:00:00', 'admin', '2024-09-15 15:50:00', 0);
INSERT INTO `gym_classroom` VALUES (128, 109, '单车五房', '单车房', 35, '0', 'admin', '2024-04-05 16:30:00', 'admin', '2024-09-15 15:55:00', 0);
INSERT INTO `gym_classroom` VALUES (129, 109, '操五房', '操房', 40, '0', 'admin', '2024-04-05 17:00:00', 'admin', '2024-09-15 16:00:00', 0);
INSERT INTO `gym_classroom` VALUES (130, 110, '瑜伽十一室', '瑜伽室', 25, '0', 'admin', '2024-04-10 10:00:00', 'admin', '2024-09-20 11:10:00', 0);
INSERT INTO `gym_classroom` VALUES (131, 110, '3D运动六室', '3D运动室', 30, '0', 'admin', '2024-04-10 10:30:00', 'admin', '2024-09-20 11:15:00', 0);
INSERT INTO `gym_classroom` VALUES (132, 110, '冥想六室', '冥想室', 20, '0', 'admin', '2024-04-10 11:00:00', 'admin', '2024-09-20 11:20:00', 0);
INSERT INTO `gym_classroom` VALUES (133, 111, '瑜伽十二室', '瑜伽室', 25, '0', 'admin', '2024-04-15 10:30:00', 'admin', '2024-09-25 11:30:00', 0);
INSERT INTO `gym_classroom` VALUES (134, 111, '单车六房', '单车房', 35, '0', 'admin', '2024-04-15 11:00:00', 'admin', '2024-09-25 11:35:00', 0);
INSERT INTO `gym_classroom` VALUES (135, 111, '操六房', '操房', 40, '0', 'admin', '2024-04-15 11:30:00', 'admin', '2024-09-25 11:40:00', 0);
INSERT INTO `gym_classroom` VALUES (136, 112, '瑜伽十三室', '瑜伽室', 25, '0', 'admin', '2024-04-20 15:00:00', 'admin', '2024-10-01 14:30:00', 0);
INSERT INTO `gym_classroom` VALUES (137, 112, '3D运动七室', '3D运动室', 30, '0', 'admin', '2024-04-20 15:30:00', 'admin', '2024-10-01 14:35:00', 0);
INSERT INTO `gym_classroom` VALUES (138, 112, '冥想七室', '冥想室', 20, '0', 'admin', '2024-04-20 16:00:00', 'admin', '2024-10-01 14:40:00', 0);
INSERT INTO `gym_classroom` VALUES (139, 113, '瑜伽十四室', '瑜伽室', 25, '0', 'admin', '2024-04-25 15:30:00', 'admin', '2024-10-05 15:40:00', 0);
INSERT INTO `gym_classroom` VALUES (140, 113, '单车七房', '单车房', 35, '0', 'admin', '2024-04-25 16:00:00', 'admin', '2024-10-05 15:45:00', 0);
INSERT INTO `gym_classroom` VALUES (141, 113, '操七房', '操房', 40, '0', 'admin', '2024-04-25 16:30:00', 'admin', '2024-10-05 15:50:00', 0);
INSERT INTO `gym_classroom` VALUES (142, 114, '瑜伽十五室', '瑜伽室', 25, '0', 'admin', '2024-05-01 09:30:00', 'admin', '2024-10-10 10:50:00', 0);
INSERT INTO `gym_classroom` VALUES (143, 114, '3D运动八室', '3D运动室', 30, '0', 'admin', '2024-05-01 10:00:00', 'admin', '2024-10-10 10:55:00', 0);
INSERT INTO `gym_classroom` VALUES (144, 114, '冥想八室', '冥想室', 20, '0', 'admin', '2024-05-01 10:30:00', 'admin', '2024-10-10 11:00:00', 0);
INSERT INTO `gym_classroom` VALUES (145, 115, '瑜伽十六室', '瑜伽室', 25, '0', 'admin', '2024-05-05 11:00:00', 'admin', '2024-10-15 11:50:00', 0);
INSERT INTO `gym_classroom` VALUES (146, 115, '单车八房', '单车房', 35, '0', 'admin', '2024-05-05 11:30:00', 'admin', '2024-10-15 11:55:00', 0);
INSERT INTO `gym_classroom` VALUES (147, 115, '操八房', '操房', 40, '0', 'admin', '2024-05-05 12:00:00', 'admin', '2024-10-15 12:00:00', 0);
INSERT INTO `gym_classroom` VALUES (148, 116, '瑜伽十七室', '瑜伽室', 25, '0', 'admin', '2024-05-10 14:30:00', 'admin', '2024-10-20 15:10:00', 0);
INSERT INTO `gym_classroom` VALUES (149, 116, '3D运动九室', '3D运动室', 30, '0', 'admin', '2024-05-10 15:00:00', 'admin', '2024-10-20 15:15:00', 0);
INSERT INTO `gym_classroom` VALUES (150, 116, '冥想九室', '冥想室', 20, '0', 'admin', '2024-05-10 15:30:00', 'admin', '2024-10-20 15:20:00', 0);
INSERT INTO `gym_classroom` VALUES (151, 117, '瑜伽十八室', '瑜伽室', 25, '0', 'admin', '2024-05-15 16:00:00', 'admin', '2024-10-25 15:30:00', 0);
INSERT INTO `gym_classroom` VALUES (152, 117, '单车九房', '单车房', 35, '0', 'admin', '2024-05-15 16:30:00', 'admin', '2024-10-25 15:35:00', 0);
INSERT INTO `gym_classroom` VALUES (153, 117, '操九房', '操房', 40, '0', 'admin', '2024-05-15 17:00:00', 'admin', '2024-10-25 15:40:00', 0);
INSERT INTO `gym_classroom` VALUES (154, 118, '瑜伽十九室', '瑜伽室', 25, '0', 'admin', '2024-05-20 10:00:00', 'admin', '2024-11-01 10:30:00', 0);
INSERT INTO `gym_classroom` VALUES (155, 118, '3D运动十室', '3D运动室', 30, '0', 'admin', '2024-05-20 10:30:00', 'admin', '2024-11-01 10:35:00', 0);
INSERT INTO `gym_classroom` VALUES (156, 118, '冥想十室', '冥想室', 20, '0', 'admin', '2024-05-20 11:00:00', 'admin', '2024-11-01 10:40:00', 0);
INSERT INTO `gym_classroom` VALUES (157, 119, '瑜伽二十室', '瑜伽室', 25, '0', 'admin', '2024-05-25 10:30:00', 'admin', '2024-11-05 11:40:00', 0);
INSERT INTO `gym_classroom` VALUES (158, 119, '单车十房', '单车房', 35, '0', 'admin', '2024-05-25 11:00:00', 'admin', '2024-11-05 11:45:00', 0);
INSERT INTO `gym_classroom` VALUES (159, 119, '操十房', '操房', 40, '0', 'admin', '2024-05-25 11:30:00', 'admin', '2024-11-05 11:50:00', 0);

-- ----------------------------
-- Table structure for gym_course_schedule
-- ----------------------------
DROP TABLE IF EXISTS `gym_course_schedule`;
CREATE TABLE `gym_course_schedule`  (
  `schedule_id` bigint NOT NULL AUTO_INCREMENT COMMENT '排期ID',
  `gym_id` bigint NOT NULL COMMENT '所属场馆ID',
  `classroom_id` bigint NOT NULL COMMENT '教室ID',
  `template_id` bigint NOT NULL COMMENT '课程模板ID',
  `coach_id` bigint NOT NULL COMMENT '教练ID（关联sys_user）',
  `schedule_date` date NOT NULL COMMENT '排期日期',
  `start_time` time NOT NULL COMMENT '开始时间',
  `end_time` time NOT NULL COMMENT '结束时间',
  `max_attendees` int NULL DEFAULT 0 COMMENT '最大预约人数',
  `current_attendees` int NULL DEFAULT 0 COMMENT '当前已预约人数',
  `schedule_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '排期状态（0待开课 1进行中 2已结束 3已取消）',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '课程价格（单次）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`schedule_id`) USING BTREE,
  INDEX `idx_gym_id`(`gym_id` ASC) USING BTREE,
  INDEX `idx_classroom_id`(`classroom_id` ASC) USING BTREE,
  INDEX `idx_template_id`(`template_id` ASC) USING BTREE,
  INDEX `idx_coach_id`(`coach_id` ASC) USING BTREE,
  INDEX `idx_schedule_date`(`schedule_date` ASC) USING BTREE,
  INDEX `idx_gym_id_schedule_date`(`gym_id` ASC, `schedule_date` ASC) USING BTREE,
  INDEX `idx_template_id_schedule_date`(`template_id` ASC, `schedule_date` ASC) USING BTREE,
  INDEX `idx_schedule_status`(`schedule_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 301 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '课程排期表（核心关联表）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gym_course_schedule
-- ----------------------------
INSERT INTO `gym_course_schedule` VALUES (100, 100, 100, 100, 120, '2025-12-23', '09:00:00', '10:00:00', 25, 22, '0', 199.00, 'admin', '2024-12-01 08:00:00', 'admin', '2025-12-20 10:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (101, 100, 101, 101, 121, '2025-12-23', '10:30:00', '11:15:00', 30, 25, '0', 259.00, 'admin', '2024-12-01 08:30:00', 'admin', '2025-12-21 09:15:00', 0);
INSERT INTO `gym_course_schedule` VALUES (102, 100, 102, 102, 122, '2025-12-23', '15:00:00', '15:30:00', 20, 18, '0', 129.00, 'admin', '2024-12-01 09:00:00', 'admin', '2025-12-22 14:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (103, 100, 100, 105, 120, '2025-12-24', '19:00:00', '20:15:00', 25, 19, '0', 299.00, 'admin', '2024-12-01 09:30:00', 'admin', '2025-12-22 16:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (104, 100, 101, 106, 121, '2025-12-24', '10:00:00', '10:50:00', 30, 23, '0', 279.00, 'admin', '2024-12-01 10:00:00', 'admin', '2025-12-23 09:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (105, 100, 102, 107, 122, '2025-12-24', '16:00:00', '16:25:00', 20, 15, '0', 109.00, 'admin', '2024-12-01 10:30:00', 'admin', '2025-12-23 14:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (106, 100, 100, 109, 120, '2025-12-25', '09:30:00', '10:30:00', 25, 20, '0', 179.00, 'admin', '2024-12-01 11:00:00', 'admin', '2025-12-23 10:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (107, 100, 101, 110, 121, '2025-12-25', '14:00:00', '14:35:00', 30, 18, '0', 239.00, 'admin', '2024-12-01 11:30:00', 'admin', '2025-12-24 11:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (108, 100, 102, 111, 122, '2025-12-25', '19:30:00', '20:10:00', 20, 16, '0', 159.00, 'admin', '2024-12-01 12:00:00', 'admin', '2025-12-24 15:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (109, 100, 100, 113, 120, '2025-12-26', '10:00:00', '11:05:00', 25, 21, '0', 229.00, 'admin', '2024-12-01 12:30:00', 'admin', '2025-12-24 16:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (110, 100, 101, 114, 121, '2025-12-26', '15:30:00', '16:15:00', 30, 24, '0', 249.00, 'admin', '2024-12-01 13:00:00', 'admin', '2025-12-25 10:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (111, 101, 103, 100, 123, '2025-12-23', '08:30:00', '09:30:00', 25, 20, '0', 189.00, 'admin', '2024-12-01 13:30:00', 'admin', '2025-12-20 08:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (112, 101, 104, 104, 124, '2025-12-23', '10:00:00', '10:40:00', 35, 30, '0', 219.00, 'admin', '2024-12-01 14:00:00', 'admin', '2025-12-21 09:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (113, 101, 105, 102, 125, '2025-12-23', '14:30:00', '15:00:00', 40, 35, '0', 139.00, 'admin', '2024-12-01 14:30:00', 'admin', '2025-12-22 13:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (114, 101, 103, 105, 123, '2025-12-24', '19:00:00', '20:15:00', 25, 18, '0', 289.00, 'admin', '2024-12-01 15:00:00', 'admin', '2025-12-22 16:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (115, 101, 104, 108, 124, '2025-12-24', '09:00:00', '09:55:00', 35, 28, '0', 249.00, 'admin', '2024-12-01 15:30:00', 'admin', '2025-12-23 08:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (116, 101, 105, 107, 125, '2025-12-24', '15:30:00', '15:55:00', 40, 32, '0', 119.00, 'admin', '2024-12-01 16:00:00', 'admin', '2025-12-23 14:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (117, 101, 103, 109, 123, '2025-12-25', '10:00:00', '11:00:00', 25, 22, '0', 169.00, 'admin', '2024-12-01 16:30:00', 'admin', '2025-12-23 10:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (118, 101, 104, 112, 124, '2025-12-25', '14:00:00', '15:00:00', 35, 29, '0', 299.00, 'admin', '2024-12-01 17:00:00', 'admin', '2025-12-24 11:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (119, 101, 105, 111, 125, '2025-12-25', '19:30:00', '20:10:00', 40, 33, '0', 149.00, 'admin', '2024-12-01 17:30:00', 'admin', '2025-12-24 15:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (120, 101, 103, 113, 123, '2025-12-26', '09:30:00', '10:35:00', 25, 21, '0', 219.00, 'admin', '2024-12-01 18:00:00', 'admin', '2025-12-24 16:30:00', 0);
INSERT INTO `gym_course_schedule` VALUES (299, 119, 157, 149, 239, '2025-12-26', '15:00:00', '15:55:00', 25, 20, '0', 239.00, 'admin', '2024-12-05 17:30:00', 'admin', '2025-12-25 14:00:00', 0);
INSERT INTO `gym_course_schedule` VALUES (300, 119, 158, 142, 240, '2025-12-26', '19:00:00', '19:40:00', 35, 28, '0', 259.00, 'admin', '2024-12-05 18:00:00', 'admin', '2025-12-25 16:30:00', 0);

-- ----------------------------
-- Table structure for gym_course_template
-- ----------------------------
DROP TABLE IF EXISTS `gym_course_template`;
CREATE TABLE `gym_course_template`  (
  `template_id` bigint NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称',
  `course_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程类型（3D运动,冥想课程,解压课程）',
  `duration` int NOT NULL COMMENT '课程时长（分钟）',
  `difficulty` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '难度（1初级 2中级 3高级）',
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图地址',
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '视频地址',
  `gesture_control` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手势控制说明',
  `calorie` int NULL DEFAULT 0 COMMENT '消耗热量（大卡）',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程描述',
  `publish_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '发布状态（0草稿 1待审核 2已审核 3已发布 4已下架）',
  `reviewer` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核人',
  `review_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `review_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核意见',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `unpublish_time` datetime NULL DEFAULT NULL COMMENT '下架时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`template_id`) USING BTREE,
  INDEX `idx_course_type`(`course_type` ASC) USING BTREE,
  INDEX `idx_course_type_difficulty`(`course_type` ASC, `difficulty` ASC) USING BTREE,
  INDEX `idx_publish_status`(`publish_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '课程模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gym_course_template
-- ----------------------------
INSERT INTO `gym_course_template` VALUES (100, '基础瑜伽入门', '瑜伽课程', 60, '1', 'https://course-img.com/yoga1.jpg', 'https://video.com/yoga1.mp4', '双手合十，跟随引导调整呼吸', 200, '适合瑜伽新手，从基础体式开始，培养身体柔韧性和呼吸节奏', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-01-01 00:00:00', 'admin', '2024-12-01 16:00:00', 0);
INSERT INTO `gym_course_template` VALUES (101, '3D太空漫步', '3D运动', 45, '2', 'https://course-img.com/3d1.jpg', 'https://video.com/3d1.mp4', '通过手势控制前进、转向、跳跃', 350, '沉浸式3D运动，模拟太空场景，锻炼心肺功能和肢体协调性', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-01-05 09:00:00', 'admin', '2024-12-01 16:05:00', 0);
INSERT INTO `gym_course_template` VALUES (102, '深度冥想放松', '冥想课程', 30, '1', 'https://course-img.com/meditation1.jpg', 'https://video.com/meditation1.mp4', '坐姿放松，双手自然放置膝盖，跟随语音引导', 80, '缓解压力，改善睡眠，适合职场人群和压力较大的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-01-10 10:00:00', 'admin', '2024-12-01 16:10:00', 0);
INSERT INTO `gym_course_template` VALUES (103, '普拉提核心训练', '普拉提课程', 50, '2', 'https://course-img.com/pilates1.jpg', 'https://video.com/pilates1.mp4', '核心收紧，跟随动作节奏控制发力', 280, '专注核心肌群训练，提升身体稳定性和肌肉线条', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-01-15 11:00:00', 'admin', '2024-12-01 16:15:00', 0);
INSERT INTO `gym_course_template` VALUES (104, '动感单车燃脂', '解压课程', 40, '2', 'https://course-img.com/spin1.jpg', 'https://video.com/spin1.mp4', '双手握把，跟随音乐节奏调整蹬踏频率', 420, '高强度有氧运动，快速燃脂，释放压力', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-01-20 14:00:00', 'admin', '2024-12-01 16:20:00', 0);
INSERT INTO `gym_course_template` VALUES (105, '高级瑜伽流', '瑜伽课程', 75, '3', 'https://course-img.com/yoga2.jpg', 'https://video.com/yoga2.mp4', '连贯体式转换，注重呼吸与动作配合', 320, '适合有瑜伽基础的用户，提升身体柔韧性和力量', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-01-25 15:00:00', 'admin', '2024-12-01 16:25:00', 0);
INSERT INTO `gym_course_template` VALUES (106, '3D丛林探险', '3D运动', 50, '2', 'https://course-img.com/3d2.jpg', 'https://video.com/3d2.mp4', '手势控制攀爬、跨越障碍，模拟丛林探险', 380, '趣味与运动结合，锻炼反应力和耐力', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-02-01 09:30:00', 'admin', '2024-12-01 16:30:00', 0);
INSERT INTO `gym_course_template` VALUES (107, '职场解压冥想', '冥想课程', 25, '1', 'https://course-img.com/meditation2.jpg', 'https://video.com/meditation2.mp4', '坐姿或站姿均可，专注呼吸缓解职场压力', 60, '短时间高效解压，适合工作间隙放松', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-02-05 10:30:00', 'admin', '2024-12-01 16:35:00', 0);
INSERT INTO `gym_course_template` VALUES (108, '普拉提拉伸塑形', '普拉提课程', 55, '2', 'https://course-img.com/pilates2.jpg', 'https://video.com/pilates2.mp4', '缓慢拉伸，注重肌肉控制和线条塑造', 250, '改善身体姿态，缓解肌肉紧张，塑造优美线条', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-02-10 11:30:00', 'admin', '2024-12-01 16:40:00', 0);
INSERT INTO `gym_course_template` VALUES (109, '舒缓瑜伽修复', '瑜伽课程', 60, '1', 'https://course-img.com/yoga3.jpg', 'https://video.com/yoga3.mp4', '轻柔体式，注重身体修复和放松', 180, '适合运动后恢复或身体疲劳时练习', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-02-15 14:30:00', 'admin', '2024-12-01 16:45:00', 0);
INSERT INTO `gym_course_template` VALUES (110, '3D极速赛车', '3D运动', 35, '3', 'https://course-img.com/3d3.jpg', 'https://video.com/3d3.mp4', '手势控制方向和加速，模拟赛车场景', 300, '高强度间歇运动，提升爆发力和反应速度', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-02-20 15:30:00', 'admin', '2024-12-01 16:50:00', 0);
INSERT INTO `gym_course_template` VALUES (111, '助眠冥想引导', '冥想课程', 40, '1', 'https://course-img.com/meditation3.jpg', 'https://video.com/meditation3.mp4', '平躺放松，跟随语音引导进入深度睡眠状态', 50, '改善睡眠质量，适合失眠或睡眠浅的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-02-25 09:00:00', 'admin', '2024-12-01 16:55:00', 0);
INSERT INTO `gym_course_template` VALUES (112, '核心力量普拉提', '普拉提课程', 60, '3', 'https://course-img.com/pilates3.jpg', 'https://video.com/pilates3.mp4', '高强度核心训练，提升肌肉力量和耐力', 330, '适合有普拉提基础，追求进阶训练的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-03-01 10:00:00', 'admin', '2024-12-01 17:00:00', 0);
INSERT INTO `gym_course_template` VALUES (113, '燃脂瑜伽课程', '瑜伽课程', 65, '2', 'https://course-img.com/yoga4.jpg', 'https://video.com/yoga4.mp4', '动态瑜伽体式，结合燃脂动作', 310, '兼顾柔韧性和燃脂需求，适合减脂人群', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-03-05 11:00:00', 'admin', '2024-12-01 17:05:00', 0);
INSERT INTO `gym_course_template` VALUES (114, '3D海底漫游', '3D运动', 45, '2', 'https://course-img.com/3d4.jpg', 'https://video.com/3d4.mp4', '手势控制潜水、游动，探索海底世界', 290, '低强度有氧运动，适合所有人群', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-03-10 14:00:00', 'admin', '2024-12-01 17:10:00', 0);
INSERT INTO `gym_course_template` VALUES (115, '情绪调节冥想', '冥想课程', 30, '1', 'https://course-img.com/meditation4.jpg', 'https://video.com/meditation4.mp4', '专注情绪感知，通过呼吸调节情绪状态', 70, '缓解焦虑、易怒等负面情绪', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-03-15 15:00:00', 'admin', '2024-12-01 17:15:00', 0);
INSERT INTO `gym_course_template` VALUES (116, '产后普拉提修复', '普拉提课程', 50, '1', 'https://course-img.com/pilates4.jpg', 'https://video.com/pilates4.mp4', '温和动作，帮助产后恢复盆底肌和核心', 220, '适合产后3个月以上的女性用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-03-20 09:30:00', 'admin', '2024-12-01 17:20:00', 0);
INSERT INTO `gym_course_template` VALUES (117, '空中瑜伽体验', '瑜伽课程', 60, '2', 'https://course-img.com/yoga5.jpg', 'https://video.com/yoga5.mp4', '借助吊床完成体式，注重平衡和核心控制', 270, '趣味瑜伽形式，提升身体协调性', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-03-25 10:30:00', 'admin', '2024-12-01 17:25:00', 0);
INSERT INTO `gym_course_template` VALUES (118, '3D篮球挑战', '3D运动', 40, '2', 'https://course-img.com/3d5.jpg', 'https://video.com/3d5.mp4', '手势控制投篮、运球，模拟篮球比赛', 340, '锻炼上肢力量和反应力', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-04-01 11:30:00', 'admin', '2024-12-01 17:30:00', 0);
INSERT INTO `gym_course_template` VALUES (119, '晨间唤醒冥想', '冥想课程', 20, '1', 'https://course-img.com/meditation5.jpg', 'https://video.com/meditation5.mp4', '快速唤醒身体和大脑，开启活力一天', 40, '适合早上起床后练习', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-04-05 14:30:00', 'admin', '2024-12-01 17:35:00', 0);
INSERT INTO `gym_course_template` VALUES (120, '办公室普拉提', '普拉提课程', 30, '1', 'https://course-img.com/pilates5.jpg', 'https://video.com/pilates5.mp4', '无需器械，适合办公室场景练习', 150, '缓解久坐疲劳，改善办公体态', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-04-10 15:30:00', 'admin', '2024-12-01 17:40:00', 0);
INSERT INTO `gym_course_template` VALUES (121, '高温瑜伽训练', '瑜伽课程', 70, '3', 'https://course-img.com/yoga6.jpg', 'https://video.com/yoga6.mp4', '高温环境下练习，加速代谢和排毒', 400, '适合身体健康，无基础疾病的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-04-15 09:00:00', 'admin', '2024-12-01 17:45:00', 0);
INSERT INTO `gym_course_template` VALUES (122, '3D足球射门', '3D运动', 35, '2', 'https://course-img.com/3d6.jpg', 'https://video.com/3d6.mp4', '手势控制传球、射门，模拟足球场景', 320, '锻炼下肢力量和精准度', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-04-20 10:00:00', 'admin', '2024-12-01 17:50:00', 0);
INSERT INTO `gym_course_template` VALUES (123, '减压冥想课程', '冥想课程', 35, '1', 'https://course-img.com/meditation6.jpg', 'https://video.com/meditation6.mp4', '通过意象引导，释放心理压力', 90, '适合高压工作人群', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-04-25 11:00:00', 'admin', '2024-12-01 17:55:00', 0);
INSERT INTO `gym_course_template` VALUES (124, '普拉提器械训练', '普拉提课程', 55, '2', 'https://course-img.com/pilates6.jpg', 'https://video.com/pilates6.mp4', '借助普拉提器械，提升训练效果', 290, '适合场馆内练习，有教练指导更佳', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-05-01 14:00:00', 'admin', '2024-12-01 18:00:00', 0);
INSERT INTO `gym_course_template` VALUES (125, '亲子瑜伽互动', '瑜伽课程', 45, '1', 'https://course-img.com/yoga7.jpg', 'https://video.com/yoga7.mp4', '家长与孩子共同练习，注重互动和趣味', 190, '增进亲子关系，培养孩子运动习惯', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-05-05 15:00:00', 'admin', '2024-12-01 18:05:00', 0);
INSERT INTO `gym_course_template` VALUES (126, '3D跑步挑战', '3D运动', 50, '2', 'https://course-img.com/3d7.jpg', 'https://video.com/3d7.mp4', '模拟不同地形跑步，调整速度和坡度', 370, '提升心肺功能和耐力', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-05-10 09:30:00', 'admin', '2024-12-01 18:10:00', 0);
INSERT INTO `gym_course_template` VALUES (127, '睡前放松冥想', '冥想课程', 30, '1', 'https://course-img.com/meditation7.jpg', 'https://video.com/meditation7.mp4', '舒缓音乐配合语音引导，放松身心', 60, '帮助快速入睡，提升睡眠质量', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-05-15 10:30:00', 'admin', '2024-12-01 18:15:00', 0);
INSERT INTO `gym_course_template` VALUES (128, '老年普拉提保健', '普拉提课程', 40, '1', 'https://course-img.com/pilates7.jpg', 'https://video.com/pilates7.mp4', '温和动作，注重关节保护和平衡训练', 180, '适合中老年人群，增强身体机能', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-05-20 11:30:00', 'admin', '2024-12-01 18:20:00', 0);
INSERT INTO `gym_course_template` VALUES (129, '力量瑜伽训练', '瑜伽课程', 65, '3', 'https://course-img.com/yoga8.jpg', 'https://video.com/yoga8.mp4', '结合力量训练的瑜伽体式，提升肌肉力量', 350, '适合有一定瑜伽基础，追求力量提升的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-05-25 14:30:00', 'admin', '2024-12-01 18:25:00', 0);
INSERT INTO `gym_course_template` VALUES (130, '3D网球对决', '3D运动', 40, '2', 'https://course-img.com/3d8.jpg', 'https://video.com/3d8.mp4', '手势控制击球、移动，模拟网球比赛', 330, '锻炼反应力和上肢力量', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-06-01 15:30:00', 'admin', '2024-12-01 18:30:00', 0);
INSERT INTO `gym_course_template` VALUES (131, '正念冥想练习', '冥想课程', 25, '1', 'https://course-img.com/meditation8.jpg', 'https://video.com/meditation8.mp4', '专注当下，培养正念思维', 50, '提升专注力和情绪稳定性', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-06-05 09:00:00', 'admin', '2024-12-01 18:35:00', 0);
INSERT INTO `gym_course_template` VALUES (132, '青少年普拉提', '普拉提课程', 45, '1', 'https://course-img.com/pilates8.jpg', 'https://video.com/pilates8.mp4', '适合青少年的趣味普拉提动作，促进骨骼发育', 210, '帮助青少年改善体态，增强体质', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-06-10 10:00:00', 'admin', '2024-12-01 18:40:00', 0);
INSERT INTO `gym_course_template` VALUES (133, '双人瑜伽配合', '瑜伽课程', 60, '2', 'https://course-img.com/yoga9.jpg', 'https://video.com/yoga9.mp4', '两人配合完成体式，注重默契和平衡', 260, '适合情侣、朋友共同练习', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-06-15 11:00:00', 'admin', '2024-12-01 18:45:00', 0);
INSERT INTO `gym_course_template` VALUES (134, '3D滑雪冒险', '3D运动', 45, '3', 'https://course-img.com/3d9.jpg', 'https://video.com/3d9.mp4', '模拟滑雪场景，控制方向和速度', 380, '高强度运动，提升平衡感和爆发力', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-06-20 14:00:00', 'admin', '2024-12-01 18:50:00', 0);
INSERT INTO `gym_course_template` VALUES (135, '创伤后应激冥想', '冥想课程', 40, '1', 'https://course-img.com/meditation9.jpg', 'https://video.com/meditation9.mp4', '温和引导，帮助缓解创伤后心理压力', 100, '适合经历创伤后需要心理调节的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-06-25 15:00:00', 'admin', '2024-12-01 18:55:00', 0);
INSERT INTO `gym_course_template` VALUES (136, '精英普拉提进阶', '普拉提课程', 60, '3', 'https://course-img.com/pilates9.jpg', 'https://video.com/pilates9.mp4', '高阶普拉提动作，挑战肌肉极限', 360, '适合专业普拉提爱好者', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-07-01 09:30:00', 'admin', '2024-12-01 19:00:00', 0);
INSERT INTO `gym_course_template` VALUES (137, '理疗瑜伽修复', '瑜伽课程', 55, '1', 'https://course-img.com/yoga10.jpg', 'https://video.com/yoga10.mp4', '针对颈椎、腰椎问题的修复体式', 200, '缓解颈肩腰腿痛，改善亚健康状态', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-07-05 10:30:00', 'admin', '2024-12-01 19:05:00', 0);
INSERT INTO `gym_course_template` VALUES (138, '3D拳击训练', '3D运动', 35, '2', 'https://course-img.com/3d10.jpg', 'https://video.com/3d10.mp4', '手势控制出拳、防守，模拟拳击训练', 340, '释放压力，锻炼上肢力量和反应力', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-07-10 11:30:00', 'admin', '2024-12-01 19:10:00', 0);
INSERT INTO `gym_course_template` VALUES (139, '感恩冥想引导', '冥想课程', 25, '1', 'https://course-img.com/meditation10.jpg', 'https://video.com/meditation10.mp4', '培养感恩心态，提升幸福感', 50, '适合日常心理调节', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-07-15 14:30:00', 'admin', '2024-12-01 19:15:00', 0);
INSERT INTO `gym_course_template` VALUES (140, '普拉提平衡训练', '普拉提课程', 45, '2', 'https://course-img.com/pilates10.jpg', 'https://video.com/pilates10.mp4', '专注平衡训练，提升身体稳定性', 240, '适合所有人群，预防跌倒', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-07-20 15:30:00', 'admin', '2024-12-01 19:20:00', 0);
INSERT INTO `gym_course_template` VALUES (141, '活力瑜伽流', '瑜伽课程', 60, '2', 'https://course-img.com/yoga11.jpg', 'https://video.com/yoga11.mp4', '快速连贯的体式转换，提升活力', 300, '适合早上练习，开启一天活力', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-07-25 09:00:00', 'admin', '2024-12-01 19:25:00', 0);
INSERT INTO `gym_course_template` VALUES (142, '3D游泳模拟', '3D运动', 40, '2', 'https://course-img.com/3d11.jpg', 'https://video.com/3d11.mp4', '模拟自由泳、蛙泳，锻炼全身肌肉', 310, '低冲击运动，适合关节不好的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-08-01 10:00:00', 'admin', '2024-12-01 19:30:00', 0);
INSERT INTO `gym_course_template` VALUES (143, '焦虑缓解冥想', '冥想课程', 30, '1', 'https://course-img.com/meditation11.jpg', 'https://video.com/meditation11.mp4', '针对性缓解焦虑情绪，平复心情', 80, '适合焦虑症患者或容易焦虑的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-08-05 11:00:00', 'admin', '2024-12-01 19:35:00', 0);
INSERT INTO `gym_course_template` VALUES (144, '普拉提燃脂塑形', '普拉提课程', 50, '2', 'https://course-img.com/pilates11.jpg', 'https://video.com/pilates11.mp4', '结合燃脂和塑形的普拉提动作', 280, '适合减脂塑形需求的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-08-10 14:00:00', 'admin', '2024-12-01 19:40:00', 0);
INSERT INTO `gym_course_template` VALUES (145, '古典瑜伽传承', '瑜伽课程', 70, '3', 'https://course-img.com/yoga12.jpg', 'https://video.com/yoga12.mp4', '传统瑜伽体式，注重呼吸和冥想结合', 270, '适合追求瑜伽本源的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-08-15 15:00:00', 'admin', '2024-12-01 19:45:00', 0);
INSERT INTO `gym_course_template` VALUES (146, '3D舞蹈练习', '3D运动', 45, '2', 'https://course-img.com/3d12.jpg', 'https://video.com/3d12.mp4', '模拟不同舞蹈风格，跟随节奏练习', 290, '趣味运动，提升身体协调性和节奏感', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-08-20 09:30:00', 'admin', '2024-12-01 19:50:00', 0);
INSERT INTO `gym_course_template` VALUES (147, '自信建立冥想', '冥想课程', 25, '1', 'https://course-img.com/meditation12.jpg', 'https://video.com/meditation12.mp4', '通过积极心理暗示，建立自信心', 60, '适合缺乏自信的用户', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-08-25 10:30:00', 'admin', '2024-12-01 19:55:00', 0);
INSERT INTO `gym_course_template` VALUES (148, '普拉提核心稳定', '普拉提课程', 40, '1', 'https://course-img.com/pilates12.jpg', 'https://video.com/pilates12.mp4', '基础核心稳定训练，适合新手', 200, '为后续普拉提训练打基础', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-09-01 11:30:00', 'admin', '2024-12-01 20:00:00', 0);
INSERT INTO `gym_course_template` VALUES (149, '户外瑜伽体验', '瑜伽课程', 55, '2', 'https://course-img.com/yoga13.jpg', 'https://video.com/yoga13.mp4', '模拟户外场景，结合自然环境的瑜伽练习', 260, '放松身心，感受自然与运动的结合', '0', NULL, NULL, NULL, NULL, NULL, 'admin', '2024-09-05 14:30:00', 'admin', '2024-12-01 20:05:00', 0);

-- ----------------------------
-- Table structure for gym_info
-- ----------------------------
DROP TABLE IF EXISTS `gym_info`;
CREATE TABLE `gym_info`  (
  `gym_id` bigint NOT NULL AUTO_INCREMENT COMMENT '场馆ID',
  `gym_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '场馆名称',
  `gym_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '场馆编码（唯一）',
  `gym_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '场馆地址',
  `contact_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `gym_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '场馆状态（0正常 1停用）',
  `owner_id` bigint NULL DEFAULT NULL COMMENT '场馆负责人ID（关联sys_user）',
  `expire_date` datetime NULL DEFAULT NULL COMMENT 'SaaS到期时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`gym_id`) USING BTREE,
  UNIQUE INDEX `uk_gym_code`(`gym_code` ASC) USING BTREE,
  INDEX `idx_owner_id`(`owner_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '场馆信息表（SaaS租户）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gym_info
-- ----------------------------
INSERT INTO `gym_info` VALUES (100, '北京朝阳健身中心', 'GYM-BJ-CY001', '北京市朝阳区建国路88号现代城5层', '张三', '13800138001', '0', 101, '2026-12-23 23:59:59', 'admin', '2024-01-10 10:00:00', 'admin', '2024-06-15 14:30:00', 0);
INSERT INTO `gym_info` VALUES (101, '北京海淀健身馆', 'GYM-BJ-HD002', '北京市海淀区中关村大街1号海龙大厦B1层', '周八', '13400134006', '0', 102, '2026-10-15 23:59:59', 'admin', '2024-01-15 09:30:00', 'admin', '2024-07-20 11:10:00', 0);
INSERT INTO `gym_info` VALUES (102, '上海浦东运动馆', 'GYM-SH-PD003', '上海市浦东新区张江高科技园区科苑路88号', '李四', '13900139002', '0', 103, '2026-08-10 23:59:59', 'admin', '2024-02-15 09:30:00', 'admin', '2024-07-20 11:15:00', 0);
INSERT INTO `gym_info` VALUES (103, '上海徐汇健身中心', 'GYM-SH-XH004', '上海市徐汇区淮海中路199号环贸广场6层', '吴九', '13300133007', '0', 104, '2026-09-20 23:59:59', 'admin', '2024-02-20 10:00:00', 'admin', '2024-08-05 14:20:00', 0);
INSERT INTO `gym_info` VALUES (104, '广州天河健身馆', 'GYM-GZ-TH005', '广州市天河区天河路385号太古汇3层', '王五', '13700137003', '0', 105, '2026-11-30 23:59:59', 'admin', '2024-03-05 11:20:00', 'admin', '2024-08-10 15:30:00', 0);
INSERT INTO `gym_info` VALUES (105, '广州荔湾健身中心', 'GYM-GZ-LW006', '广州市荔湾区上下九路33号名汇广场B1层', '郑十', '13200132008', '0', 106, '2026-07-15 23:59:59', 'admin', '2024-03-10 14:00:00', 'admin', '2024-08-15 16:40:00', 0);
INSERT INTO `gym_info` VALUES (106, '深圳南山健身馆', 'GYM-SZ-NS007', '深圳市南山区科技园南区科苑南路288号', '赵六', '13600136004', '0', 107, '2026-12-10 23:59:59', 'admin', '2024-03-15 09:00:00', 'admin', '2024-09-01 10:10:00', 0);
INSERT INTO `gym_info` VALUES (107, '深圳福田健身中心', 'GYM-SZ-FT008', '深圳市福田区福田街道深南中路3031号', '王十一', '13100131009', '0', 108, '2026-11-05 23:59:59', 'admin', '2024-03-20 10:30:00', 'admin', '2024-09-05 11:20:00', 0);
INSERT INTO `gym_info` VALUES (108, '杭州西湖健身馆', 'GYM-HZ-XH009', '杭州市西湖区西湖大道148号伟星世纪大厦5层', '陈十二', '13800138010', '0', 109, '2026-08-25 23:59:59', 'admin', '2024-04-01 14:00:00', 'admin', '2024-09-10 14:30:00', 0);
INSERT INTO `gym_info` VALUES (109, '杭州滨江健身中心', 'GYM-HZ-BJ010', '杭州市滨江区江南大道100号星光国际广场3层', '林十三', '13900139011', '0', 110, '2026-09-15 23:59:59', 'admin', '2024-04-05 15:30:00', 'admin', '2024-09-15 15:40:00', 0);
INSERT INTO `gym_info` VALUES (110, '成都锦江健身馆', 'GYM-CD-JJ011', '成都市锦江区东大街下东大街段99号晶融汇2层', '黄十四', '13700137012', '0', 111, '2026-10-20 23:59:59', 'admin', '2024-04-10 09:30:00', 'admin', '2024-09-20 10:50:00', 0);
INSERT INTO `gym_info` VALUES (111, '成都武侯健身中心', 'GYM-CD-WH012', '成都市武侯区武侯大道顺江段77号吾悦广场4层', '杨十五', '13600136013', '0', 112, '2026-12-05 23:59:59', 'admin', '2024-04-15 10:00:00', 'admin', '2024-09-25 11:00:00', 0);
INSERT INTO `gym_info` VALUES (112, '武汉江汉健身馆', 'GYM-WH-JH013', '武汉市江汉区江汉路129号中心百货5层', '刘十六', '13500135014', '0', 113, '2026-07-30 23:59:59', 'admin', '2024-04-20 14:30:00', 'admin', '2024-10-01 14:10:00', 0);
INSERT INTO `gym_info` VALUES (113, '武汉武昌健身中心', 'GYM-WH-WC014', '武汉市武昌区中南路99号中商广场B1层', '邓十七', '13400134015', '0', 114, '2026-08-15 23:59:59', 'admin', '2024-04-25 15:00:00', 'admin', '2024-10-05 15:20:00', 0);
INSERT INTO `gym_info` VALUES (114, '重庆渝中区健身馆', 'GYM-CQ-YZ015', '重庆市渝中区解放碑步行街88号环球金融中心6层', '何十八', '13300133016', '0', 115, '2026-11-20 23:59:59', 'admin', '2024-05-01 09:00:00', 'admin', '2024-10-10 10:30:00', 0);
INSERT INTO `gym_info` VALUES (115, '重庆江北区健身中心', 'GYM-CQ-JB016', '重庆市江北区观音桥步行街9号北城天街4层', '罗十九', '13200132017', '0', 116, '2026-10-10 23:59:59', 'admin', '2024-05-05 10:30:00', 'admin', '2024-10-15 11:40:00', 0);
INSERT INTO `gym_info` VALUES (116, '西安雁塔健身馆', 'GYM-XA-YT017', '西安市雁塔区长安南路196号会展国际大厦5层', '梁二十', '13100131018', '0', 117, '2026-09-30 23:59:59', 'admin', '2024-05-10 14:00:00', 'admin', '2024-10-20 14:50:00', 0);
INSERT INTO `gym_info` VALUES (117, '西安莲湖健身中心', 'GYM-XA-LH018', '西安市莲湖区北大街88号民生百货B1层', '宋二十一', '13800138019', '0', 118, '2026-08-05 23:59:59', 'admin', '2024-05-15 15:30:00', 'admin', '2024-10-25 15:00:00', 0);
INSERT INTO `gym_info` VALUES (118, '南京秦淮健身馆', 'GYM-NJ-QH019', '南京市秦淮区中山南路1号新百商场6层', '唐二十二', '13900139020', '0', 119, '2026-12-15 23:59:59', 'admin', '2024-05-20 09:30:00', 'admin', '2024-11-01 10:10:00', 0);
INSERT INTO `gym_info` VALUES (119, '南京建邺健身中心', 'GYM-NJ-JY020', '南京市建邺区江东中路303号金鹰世界5层', '许二十三', '13700137021', '0', 120, '2026-11-25 23:59:59', 'admin', '2024-05-25 10:00:00', 'admin', '2024-11-05 11:20:00', 0);

-- ----------------------------
-- Table structure for gym_user_card
-- ----------------------------
DROP TABLE IF EXISTS `gym_user_card`;
CREATE TABLE `gym_user_card`  (
  `user_card_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户卡ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `card_type_id` bigint NOT NULL COMMENT '卡类型ID',
  `gym_id` bigint NOT NULL COMMENT '所属场馆ID',
  `remaining_times` int NULL DEFAULT NULL COMMENT '剩余次数（次卡）',
  `start_date` datetime NOT NULL COMMENT '生效时间',
  `expire_date` datetime NULL DEFAULT NULL COMMENT '到期时间',
  `card_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '卡状态（0正常 1冻结 2过期）',
  `purchase_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '购买价格',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`user_card_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_card_type_id`(`card_type_id` ASC) USING BTREE,
  INDEX `idx_gym_id`(`gym_id` ASC) USING BTREE,
  INDEX `idx_user_id_gym_id`(`user_id` ASC, `gym_id` ASC) USING BTREE,
  INDEX `idx_card_status_expire_date`(`card_status` ASC, `expire_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户会员卡表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gym_user_card
-- ----------------------------
INSERT INTO `gym_user_card` VALUES (100, 200, 101, 100, NULL, '2024-03-01 00:00:00', '2025-03-01 23:59:59', '0', 5999.00, 'admin', '2024-03-01 14:00:00', 'member_zhao', '2025-12-22 18:00:00', 0);
INSERT INTO `gym_user_card` VALUES (101, 201, 100, 100, 18, '2024-03-05 00:00:00', '2025-03-05 23:59:59', '0', 1999.00, 'admin', '2024-03-05 14:00:00', 'member_qian', '2025-12-22 19:30:00', 0);
INSERT INTO `gym_user_card` VALUES (102, 202, 100, 100, 22, '2024-03-10 00:00:00', '2025-03-10 23:59:59', '0', 1999.00, 'admin', '2024-03-10 14:00:00', 'member_sun', '2025-12-23 08:00:00', 0);

-- ----------------------------
-- Table structure for sc_ai_token_usage
-- ----------------------------
DROP TABLE IF EXISTS `sc_ai_token_usage`;
CREATE TABLE `sc_ai_token_usage`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `question` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户提问（截取前500字）',
  `answer` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'AI回答（截取前500字）',
  `prompt_tokens` int NOT NULL DEFAULT 0 COMMENT '输入token数',
  `completion_tokens` int NOT NULL DEFAULT 0 COMMENT '输出token数',
  `total_tokens` int NOT NULL DEFAULT 0 COMMENT '总token数',
  `model` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用的模型',
  `with_user_data` tinyint NOT NULL DEFAULT 0 COMMENT '是否携带用户健康数据 0否1是',
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ai' COMMENT '来源: local/ai/filter/offtopic',
  `cost_ms` bigint NULL DEFAULT NULL COMMENT '请求耗时ms',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_user_date`(`user_id` ASC, `create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI对话Token使用记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_ai_token_usage
-- ----------------------------

-- ----------------------------
-- Table structure for sc_check_in
-- ----------------------------
DROP TABLE IF EXISTS `sc_check_in`;
CREATE TABLE `sc_check_in`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `check_date` date NOT NULL,
  `completed` tinyint NOT NULL DEFAULT 1,
  `earned_points` int NOT NULL DEFAULT 20,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_date`(`user_id` ASC, `check_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '每日打卡记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_check_in
-- ----------------------------
INSERT INTO `sc_check_in` VALUES (4000000001, 1000000001, '2025-01-10', 1, 20, '2026-03-22 10:33:32');
INSERT INTO `sc_check_in` VALUES (4000000002, 1000000001, '2025-01-11', 1, 20, '2026-03-22 10:33:32');
INSERT INTO `sc_check_in` VALUES (4000000003, 1000000001, '2025-01-12', 1, 20, '2026-03-22 10:33:32');
INSERT INTO `sc_check_in` VALUES (4000000004, 1000000001, '2025-01-13', 1, 20, '2026-03-22 10:33:32');
INSERT INTO `sc_check_in` VALUES (4000000005, 1000000001, '2025-01-14', 1, 20, '2026-03-22 10:33:32');
INSERT INTO `sc_check_in` VALUES (2035547408927916034, 1000000002, '2026-03-22', 1, 20, '2026-03-22 10:41:36');
INSERT INTO `sc_check_in` VALUES (2035704537341104129, 2035558243645648897, '2026-03-22', 1, 20, '2026-03-22 21:05:58');
INSERT INTO `sc_check_in` VALUES (2035962693149483010, 2035558243645648897, '2026-03-23', 1, 20, '2026-03-23 14:11:47');

-- ----------------------------
-- Table structure for sc_diet_record
-- ----------------------------
DROP TABLE IF EXISTS `sc_diet_record`;
CREATE TABLE `sc_diet_record`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `record_date` date NOT NULL,
  `food_id` bigint NULL DEFAULT NULL,
  `food_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `meal_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'breakfast/lunch/dinner/snack',
  `amount` double NULL DEFAULT 1,
  `calories` double NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_date`(`user_id` ASC, `record_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '饮食记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_diet_record
-- ----------------------------

-- ----------------------------
-- Table structure for sc_emotion_record
-- ----------------------------
DROP TABLE IF EXISTS `sc_emotion_record`;
CREATE TABLE `sc_emotion_record`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `record_date` date NOT NULL,
  `score` int NULL DEFAULT NULL COMMENT '0-100',
  `level_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'good/medium/poor',
  `level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pressure` int NULL DEFAULT NULL,
  `anxiety` int NULL DEFAULT NULL,
  `positivity` int NULL DEFAULT NULL,
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `voice_features` json NULL,
  `sleep_quality` int NULL DEFAULT NULL,
  `diet_frequency` int NULL DEFAULT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_date`(`user_id` ASC, `record_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '情绪记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_emotion_record
-- ----------------------------
INSERT INTO `sc_emotion_record` VALUES (5000000001, 1000000001, '2025-01-08', 72, 'medium', '一般', 45, 40, 65, '工作压力较大', NULL, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_emotion_record` VALUES (5000000002, 1000000001, '2025-01-09', 85, 'good', '良好', 25, 20, 82, '心情愉快，运动后感觉很好', NULL, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_emotion_record` VALUES (5000000003, 1000000001, '2025-01-10', 78, 'good', '良好', 30, 25, 78, '状态不错', NULL, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_emotion_record` VALUES (5000000004, 1000000001, '2025-01-11', 60, 'medium', '一般', 55, 50, 60, '有些疲劳', NULL, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_emotion_record` VALUES (5000000005, 1000000001, '2025-01-12', 80, 'good', '良好', 28, 22, 80, '休息充分，状态好', NULL, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_emotion_record` VALUES (2035669928381423617, 2035558243645648897, '2026-03-22', 78, 'good', '良好', 25, 30, 85, '情绪稳定，压力水平低', NULL, NULL, NULL, 0, '2026-03-22 18:48:27', '2026-03-22 18:48:27');
INSERT INTO `sc_emotion_record` VALUES (2044055009932247041, 1000000002, '2026-04-14', 78, 'good', '良好', 25, 30, 85, '情绪稳定，压力水平低', NULL, NULL, NULL, 0, '2026-04-14 22:07:46', '2026-04-14 22:07:46');

-- ----------------------------
-- Table structure for sc_health_profile
-- ----------------------------
DROP TABLE IF EXISTS `sc_health_profile`;
CREATE TABLE `sc_health_profile`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `height` double NULL DEFAULT NULL,
  `weight` double NULL DEFAULT NULL,
  `target_weight` double NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `birthday` date NULL DEFAULT NULL,
  `blood_type` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `activity_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `health_goal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `allergies` json NULL,
  `chronic_diseases` json NULL,
  `emergency_contact` json NULL,
  `weekly_training_target` int NULL DEFAULT 4,
  `daily_calorie_target` int NULL DEFAULT 1600,
  `sleep_target` int NULL DEFAULT 8,
  `water_target` int NULL DEFAULT 2000,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健康档案表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_health_profile
-- ----------------------------
INSERT INTO `sc_health_profile` VALUES (2000000001, 1000000001, 170, 75, 65, 25, 'male', NULL, 'A', 'moderate', 'lose_weight', NULL, NULL, NULL, 4, 1800, 8, 2000, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_health_profile` VALUES (2000000002, 1000000002, 175, 70, 66, 28, 'male', NULL, 'O', 'active', 'maintain', NULL, NULL, NULL, 5, 2000, 7, 2500, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_health_profile` VALUES (2035741200360546305, 2035558243645648897, 175, 54, 60, 20, 'male', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 1600, 8, 2000, '2026-03-22 23:31:39', '2026-03-22 23:31:39');

-- ----------------------------
-- Table structure for sc_medal
-- ----------------------------
DROP TABLE IF EXISTS `sc_medal`;
CREATE TABLE `sc_medal`  (
  `id` bigint NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `bg` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unlock_condition` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `target_value` int NULL DEFAULT NULL,
  `condition_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sort_order` int NULL DEFAULT 0,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '勋章定义表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_medal
-- ----------------------------
INSERT INTO `sc_medal` VALUES (1, '破冰者', '完成第一次训练', '🏅', '#f97316', '#fff7ed', '完成第一次训练', 1, 'workout_count', 1, 0, '2026-03-22 09:51:23');
INSERT INTO `sc_medal` VALUES (2, '坚持一周', '连续打卡7天', '🔥', '#ef4444', '#fef2f2', '连续打卡7天', 7, 'checkin_days', 2, 0, '2026-03-22 09:51:23');
INSERT INTO `sc_medal` VALUES (3, '减脂先锋', '成功减重3kg', '⚡', '#eab308', '#fefce8', '成功减重3kg', 3, 'weight_lost', 3, 0, '2026-03-22 09:51:23');
INSERT INTO `sc_medal` VALUES (4, 'AR探索者', '完成10次食物扫描', '📷', '#3b82f6', '#eff6ff', '完成10次食物扫描', 10, 'food_scan_count', 4, 0, '2026-03-22 09:51:23');
INSERT INTO `sc_medal` VALUES (5, '情绪大师', '完成20次情绪分析', '🧠', '#a855f7', '#faf5ff', '完成20次情绪分析', 20, 'emotion_count', 5, 0, '2026-03-22 09:51:23');
INSERT INTO `sc_medal` VALUES (6, '月度冠军', '单月训练超过20次', '🏆', '#f59e0b', '#fffbeb', '单月训练超过20次', 20, 'monthly_workout', 6, 0, '2026-03-22 09:51:23');
INSERT INTO `sc_medal` VALUES (7, '马拉松精神', '累计训练超过50小时', '🏃', '#22c55e', '#f0fdf4', '累计训练超过50小时', 50, 'total_hours', 7, 0, '2026-03-22 09:51:23');
INSERT INTO `sc_medal` VALUES (8, '瘦身达人', '成功减重10kg', '💎', '#06b6d4', '#ecfeff', '成功减重10kg', 10, 'weight_lost', 8, 0, '2026-03-22 09:51:23');

-- ----------------------------
-- Table structure for sc_notification
-- ----------------------------
DROP TABLE IF EXISTS `sc_notification`;
CREATE TABLE `sc_notification`  (
  `id` bigint NOT NULL,
  `user_id` bigint NULL DEFAULT NULL COMMENT 'NULL=全体通知',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'workout/diet/emotion/reward/weight/system',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_read` tinyint NOT NULL DEFAULT 0,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_read`(`user_id` ASC, `is_read` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_notification
-- ----------------------------
INSERT INTO `sc_notification` VALUES (7000000001, NULL, 'system', '欢迎使用瘦瘦营', '欢迎加入瘦瘦营！开始您的健康减脂之旅，坚持打卡赢取丰厚奖励。', '🎉', 0, 0, '2026-03-22 10:33:32');
INSERT INTO `sc_notification` VALUES (7000000002, NULL, 'workout', '新课程上线', '4套全新训练课程已上线，包含居家训练、有氧运动、瑜伽等多种类型。', '🏃', 0, 0, '2026-03-22 10:33:32');
INSERT INTO `sc_notification` VALUES (7000000003, NULL, 'reward', '打卡奖励提醒', '坚持打卡30天可获得专业健身器材奖励，已有超过1000人参与！', '🏅', 0, 0, '2026-03-22 10:33:32');

-- ----------------------------
-- Table structure for sc_points_record
-- ----------------------------
DROP TABLE IF EXISTS `sc_points_record`;
CREATE TABLE `sc_points_record`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `record_date` date NOT NULL,
  `action` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `points` int NOT NULL COMMENT '正=获得 负=消耗',
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'earn/spend',
  `workout_title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `related_id` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '积分明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_points_record
-- ----------------------------
INSERT INTO `sc_points_record` VALUES (6000000001, 1000000001, '2025-01-10', '打卡签到', 20, 'earn', NULL, NULL, '2026-03-22 10:33:32');
INSERT INTO `sc_points_record` VALUES (6000000002, 1000000001, '2025-01-10', '完成训练', 50, 'earn', NULL, NULL, '2026-03-22 10:33:32');
INSERT INTO `sc_points_record` VALUES (6000000003, 1000000001, '2025-01-11', '打卡签到', 20, 'earn', NULL, NULL, '2026-03-22 10:33:32');
INSERT INTO `sc_points_record` VALUES (6000000004, 1000000001, '2025-01-12', '情绪记录', 10, 'earn', NULL, NULL, '2026-03-22 10:33:32');
INSERT INTO `sc_points_record` VALUES (6000000005, 1000000001, '2025-01-13', '打卡签到', 20, 'earn', NULL, NULL, '2026-03-22 10:33:32');
INSERT INTO `sc_points_record` VALUES (2035547408978247681, 1000000002, '2026-03-22', '打卡签到', 20, 'earn', NULL, NULL, '2026-03-22 10:41:36');
INSERT INTO `sc_points_record` VALUES (2035704537341104130, 2035558243645648897, '2026-03-22', '打卡签到', 20, 'earn', NULL, NULL, '2026-03-22 21:05:58');
INSERT INTO `sc_points_record` VALUES (2035962693170454529, 2035558243645648897, '2026-03-23', '打卡签到', 20, 'earn', NULL, NULL, '2026-03-23 14:11:47');
INSERT INTO `sc_points_record` VALUES (2044055009957412866, 1000000002, '2026-04-14', '情绪记录', 10, 'earn', NULL, 2044055009932247041, '2026-04-14 22:07:46');

-- ----------------------------
-- Table structure for sc_reward_order
-- ----------------------------
DROP TABLE IF EXISTS `sc_reward_order`;
CREATE TABLE `sc_reward_order`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'reward/exchange',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT 'pending/shipped/delivered/locked',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `points_cost` int NULL DEFAULT 0,
  `item_id` bigint NULL DEFAULT NULL,
  `address` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unlock_condition` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `delivery_time` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '奖励订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_reward_order
-- ----------------------------

-- ----------------------------
-- Table structure for sc_shop_item
-- ----------------------------
DROP TABLE IF EXISTS `sc_shop_item`;
CREATE TABLE `sc_shop_item`  (
  `id` bigint NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `points` int NOT NULL,
  `image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tag` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tag_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `stock` int NULL DEFAULT 0,
  `category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sort_order` int NULL DEFAULT 0,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_on_sale` tinyint NOT NULL DEFAULT 1 COMMENT '上架状态 1上架 0下架',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '积分商城商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_shop_item
-- ----------------------------
INSERT INTO `sc_shop_item` VALUES (1, '弹力带套装', 80, 'https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=400', '热门', '#ef4444', 50, '健身器材', 1, 0, '2026-03-22 09:51:23', '2026-03-23 22:49:29', 1);
INSERT INTO `sc_shop_item` VALUES (2, '运动水壶', 120, 'https://images.unsplash.com/photo-1575377427642-087cf684ad04?w=400', '新品', '#3b82f6', 30, '运动配件', 2, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23', 1);
INSERT INTO `sc_shop_item` VALUES (3, '运动毛巾', 60, 'https://images.unsplash.com/photo-1616279969096-54b228f4e2b6?w=400', '实用', '#22c55e', 100, '运动配件', 3, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23', 1);
INSERT INTO `sc_shop_item` VALUES (4, '专业跳绳', 150, 'https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=400', '推荐', '#f97316', 20, '健身器材', 4, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23', 1);
INSERT INTO `sc_shop_item` VALUES (5, '运动袜3双', 45, 'https://images.unsplash.com/photo-1616279969096-54b228f4e2b6?w=400', '超值', '#8b5cf6', 200, '运动服饰', 5, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23', 1);
INSERT INTO `sc_shop_item` VALUES (6, '蛋白质摇摇杯', 90, 'https://images.unsplash.com/photo-1575377427642-087cf684ad04?w=400', '健康', '#22c55e', 60, '营养补给', 6, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23', 1);

-- ----------------------------
-- Table structure for sc_user
-- ----------------------------
DROP TABLE IF EXISTS `sc_user`;
CREATE TABLE `sc_user`  (
  `id` bigint NOT NULL,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名/手机号',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码MD5',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'male/female',
  `birthday` date NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `height` double NULL DEFAULT NULL COMMENT '身高cm',
  `weight` double NULL DEFAULT NULL COMMENT '体重kg',
  `target_weight` double NULL DEFAULT NULL COMMENT '目标体重kg',
  `bio` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `join_date` date NULL DEFAULT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_user
-- ----------------------------
INSERT INTO `sc_user` VALUES (1000000001, 'testuser', 'e10adc3949ba59abbe56e057f20f883e', '小明', NULL, 'male', NULL, 25, 170, 75, 65, NULL, NULL, '', '2024-09-01', 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23');
INSERT INTO `sc_user` VALUES (1000000002, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员Alanine', NULL, 'male', NULL, 28, 175, 70, 65, NULL, NULL, '19100471675', '2024-01-01', 0, '2026-03-22 10:08:50', '2026-03-22 10:08:50');
INSERT INTO `sc_user` VALUES (2035558243645648897, 'alanine', 'e10adc3949ba59abbe56e057f20f883e', 'alanine', NULL, 'male', NULL, 20, 175, 55, 60, NULL, NULL, '19100471675', NULL, 1, '2026-03-22 11:24:39', '2026-03-23 21:54:37');

-- ----------------------------
-- Table structure for sc_user_medal
-- ----------------------------
DROP TABLE IF EXISTS `sc_user_medal`;
CREATE TABLE `sc_user_medal`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `medal_id` bigint NOT NULL,
  `unlocked_date` date NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_medal`(`user_id` ASC, `medal_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户已解锁勋章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_user_medal
-- ----------------------------

-- ----------------------------
-- Table structure for sc_weight_record
-- ----------------------------
DROP TABLE IF EXISTS `sc_weight_record`;
CREATE TABLE `sc_weight_record`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `record_date` date NOT NULL,
  `weight` double NOT NULL COMMENT 'kg',
  `bmi` double NULL DEFAULT NULL,
  `body_fat` double NULL DEFAULT NULL COMMENT '体脂率%',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_date`(`user_id` ASC, `record_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体重记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_weight_record
-- ----------------------------
INSERT INTO `sc_weight_record` VALUES (3000000001, 1000000001, '2024-09-01', 80, 27.7, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_weight_record` VALUES (3000000002, 1000000001, '2024-10-01', 78.5, 27.2, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_weight_record` VALUES (3000000003, 1000000001, '2024-11-01', 77, 26.6, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_weight_record` VALUES (3000000004, 1000000001, '2024-12-01', 76, 26.3, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_weight_record` VALUES (3000000005, 1000000001, '2025-01-01', 75, 26, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_weight_record` VALUES (3000000006, 1000000002, '2024-01-01', 72, 23.5, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_weight_record` VALUES (3000000007, 1000000002, '2024-06-01', 71, 23.2, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');
INSERT INTO `sc_weight_record` VALUES (3000000008, 1000000002, '2025-01-01', 70, 22.9, NULL, NULL, 0, '2026-03-22 10:33:32', '2026-03-22 10:33:32');

-- ----------------------------
-- Table structure for sc_workout_course
-- ----------------------------
DROP TABLE IF EXISTS `sc_workout_course`;
CREATE TABLE `sc_workout_course`  (
  `id` bigint NOT NULL,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '初级/中级/高级',
  `duration` int NULL DEFAULT NULL COMMENT '分钟',
  `calories` int NULL DEFAULT NULL,
  `cover_image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rating` double NULL DEFAULT 5,
  `reviews` int NULL DEFAULT 0,
  `pose_support` tinyint NULL DEFAULT 0,
  `gesture_control` tinyint NULL DEFAULT 0,
  `steps` json NULL,
  `pose_tips` json NULL,
  `sort_order` int NULL DEFAULT 0,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '运动课程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_workout_course
-- ----------------------------
INSERT INTO `sc_workout_course` VALUES (1, '无器械全身训练', '初级', 30, 250, 'https://images.unsplash.com/photo-1679769706345-da57a319c25f?w=600', '无需器械的全身训练，适合在家中进行。', '居家训练', 4.8, 324, 1, 1, NULL, NULL, 1, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23');
INSERT INTO `sc_workout_course` VALUES (2, '燃脂有氧跑步训练', '中级', 45, 400, 'https://images.unsplash.com/photo-1679769706345-da57a319c25f?w=600', '高效燃脂有氧运动，提升心肺功能。', '有氧运动', 4.9, 512, 1, 1, NULL, NULL, 2, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23');
INSERT INTO `sc_workout_course` VALUES (3, '瑜伽柔韧性训练', '初级', 40, 180, 'https://images.unsplash.com/photo-1758274539654-23fa349cc090?w=600', '改善身体柔韧性，减轻压力，舒缓身心。', '瑜伽', 4.7, 289, 1, 1, NULL, NULL, 3, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23');
INSERT INTO `sc_workout_course` VALUES (4, '深蹲强化训练', '高级', 35, 320, 'https://images.unsplash.com/photo-1645810809381-97f6fd2f7d10?w=600', '专注下肢力量训练，塑造完美臀腿线条。', '力量训练', 4.6, 178, 1, 1, NULL, NULL, 4, 0, '2026-03-22 09:51:23', '2026-03-22 09:51:23');

-- ----------------------------
-- Table structure for sc_workout_record
-- ----------------------------
DROP TABLE IF EXISTS `sc_workout_record`;
CREATE TABLE `sc_workout_record`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `course_id` bigint NULL DEFAULT NULL,
  `duration` int NULL DEFAULT NULL COMMENT '分钟',
  `calories` int NULL DEFAULT NULL,
  `earned_points` int NULL DEFAULT 50,
  `completed_at` datetime NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '运动记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc_workout_record
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (100, '系统名称', 'sys.name', '瘦瘦营SlimCamp', 'Y', 'system', '2024-01-01 00:00:00', 'admin', '2024-12-01 09:00:00', '系统显示名称');
INSERT INTO `sys_config` VALUES (101, '系统版本', 'sys.version', 'V3.0', 'Y', 'system', '2024-01-01 00:10:00', 'admin', '2024-12-01 09:05:00', '系统版本号');
INSERT INTO `sys_config` VALUES (102, '登录失效时间', 'sys.login.invalid.time', '7200', 'N', 'system', '2024-01-01 00:20:00', 'admin', '2024-12-01 09:10:00', '单位：秒');
INSERT INTO `sys_config` VALUES (103, '密码加密次数', 'sys.password.encrypt.count', '10', 'Y', 'system', '2024-01-01 00:30:00', 'admin', '2024-12-01 09:15:00', 'BCrypt加密次数');
INSERT INTO `sys_config` VALUES (104, '默认头像地址', 'sys.user.default.avatar', 'https://slimcamp-avatar.com/default.jpg', 'N', 'system', '2024-01-01 00:40:00', 'admin', '2024-12-01 09:20:00', '用户默认头像');
INSERT INTO `sys_config` VALUES (105, '单次预约最大人数', 'gym.booking.max.person', '30', 'N', 'system', '2024-01-01 00:50:00', 'admin', '2024-12-01 09:25:00', '单节课程最大预约数');
INSERT INTO `sys_config` VALUES (106, '连续打卡奖励天数', 'fitness.checkin.reward.days', '7,15,30', 'N', 'system', '2024-01-01 01:00:00', 'admin', '2024-12-01 09:30:00', '逗号分隔的奖励节点');
INSERT INTO `sys_config` VALUES (107, 'AI姿态纠错频率', 'ai.posture.correction.frequency', '30', 'N', 'system', '2024-01-01 01:10:00', 'admin', '2024-12-01 09:35:00', '单位：秒/次');
INSERT INTO `sys_config` VALUES (108, '情绪分析周期', 'ai.emotion.analysis.cycle', '24', 'N', 'system', '2024-01-01 01:20:00', 'admin', '2024-12-01 09:40:00', '单位：小时');
INSERT INTO `sys_config` VALUES (109, '图片上传大小限制', 'sys.upload.image.max.size', '5', 'N', 'system', '2024-01-01 01:30:00', 'admin', '2024-12-01 09:45:00', '单位：MB');
INSERT INTO `sys_config` VALUES (110, '视频上传大小限制', 'sys.upload.video.max.size', '100', 'N', 'system', '2024-01-01 01:40:00', 'admin', '2024-12-01 09:50:00', '单位：MB');
INSERT INTO `sys_config` VALUES (111, '默认课程时长', 'gym.course.default.duration', '60', 'N', 'system', '2024-01-01 01:50:00', 'admin', '2024-12-01 09:55:00', '单位：分钟');
INSERT INTO `sys_config` VALUES (112, '会员卡默认有效期', 'gym.card.default.validity', '365', 'N', 'system', '2024-01-01 02:00:00', 'admin', '2024-12-01 10:00:00', '期限卡默认天数');
INSERT INTO `sys_config` VALUES (113, '次卡默认次数', 'gym.card.default.times', '30', 'N', 'system', '2024-01-01 02:10:00', 'admin', '2024-12-01 10:05:00', '次卡默认总次数');
INSERT INTO `sys_config` VALUES (114, '体重记录间隔限制', 'fitness.weight.record.interval', '24', 'N', 'system', '2024-01-01 02:20:00', 'admin', '2024-12-01 10:10:00', '单位：小时');
INSERT INTO `sys_config` VALUES (115, '预约取消提前时间', 'gym.booking.cancel.advance', '2', 'N', 'system', '2024-01-01 02:30:00', 'admin', '2024-12-01 10:15:00', '单位：小时');
INSERT INTO `sys_config` VALUES (116, '爽约次数限制', 'gym.booking.no.show.limit', '3', 'N', 'system', '2024-01-01 02:40:00', 'admin', '2024-12-01 10:20:00', '月度最大爽约次数');
INSERT INTO `sys_config` VALUES (117, 'SaaS默认到期时间', 'saas.default.expire.days', '365', 'N', 'system', '2024-01-01 02:50:00', 'admin', '2024-12-01 10:25:00', '新场馆默认有效期');
INSERT INTO `sys_config` VALUES (118, 'AI课程推送数量', 'ai.course.push.count', '3', 'N', 'system', '2024-01-01 03:00:00', 'admin', '2024-12-01 10:30:00', '每次推送课程数');
INSERT INTO `sys_config` VALUES (119, 'AI食谱推送数量', 'ai.recipe.push.count', '2', 'N', 'system', '2024-01-01 03:10:00', 'admin', '2024-12-01 10:35:00', '每次推送食谱数');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 210 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (200, 0, '0', '总管理部', 1, 'admin', '13888888888', 'admin_dept@slimcamp.com', '0', '0', 'system', '2024-01-01 00:00:00', 'admin', '2024-06-01 10:00:00');
INSERT INTO `sys_dept` VALUES (201, 200, '0,200', '北京区域部', 2, '张三', '13800138001', 'bj_dept@slimcamp.com', '0', '0', 'system', '2024-01-10 09:00:00', 'admin', '2024-07-15 14:30:00');
INSERT INTO `sys_dept` VALUES (202, 200, '0,200', '上海区域部', 3, '李四', '13900139002', 'sh_dept@slimcamp.com', '0', '0', 'system', '2024-01-10 09:30:00', 'admin', '2024-07-15 14:35:00');
INSERT INTO `sys_dept` VALUES (203, 200, '0,200', '广州区域部', 4, '王五', '13700137003', 'gz_dept@slimcamp.com', '0', '0', 'system', '2024-01-10 10:00:00', 'admin', '2024-07-15 14:40:00');
INSERT INTO `sys_dept` VALUES (204, 200, '0,200', '深圳区域部', 5, '赵六', '13600136004', 'sz_dept@slimcamp.com', '0', '0', 'system', '2024-01-10 10:30:00', 'admin', '2024-07-15 14:45:00');
INSERT INTO `sys_dept` VALUES (205, 201, '0,200,201', '朝阳场馆部', 1, '孙七', '13500135005', 'cy_gym_dept@slimcamp.com', '0', '0', 'admin', '2024-02-01 09:00:00', 'admin', '2024-08-01 11:00:00');
INSERT INTO `sys_dept` VALUES (206, 201, '0,200,201', '海淀场馆部', 2, '周八', '13400134006', 'hd_gym_dept@slimcamp.com', '0', '0', 'admin', '2024-02-01 09:30:00', 'admin', '2024-08-01 11:05:00');
INSERT INTO `sys_dept` VALUES (207, 202, '0,200,202', '浦东场馆部', 1, '吴九', '13300133007', 'pd_gym_dept@slimcamp.com', '0', '0', 'admin', '2024-02-01 10:00:00', 'admin', '2024-08-01 11:10:00');
INSERT INTO `sys_dept` VALUES (208, 203, '0,200,203', '天河场馆部', 1, '郑十', '13200132008', 'th_gym_dept@slimcamp.com', '0', '0', 'admin', '2024-02-01 10:30:00', 'admin', '2024-08-01 11:15:00');
INSERT INTO `sys_dept` VALUES (209, 204, '0,200,204', '南山场馆部', 1, '王十一', '13100131009', 'ns_gym_dept@slimcamp.com', '0', '0', 'admin', '2024-02-01 11:00:00', 'admin', '2024-08-01 11:20:00');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '样式属性',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE,
  INDEX `idx_dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (100, 1, '男', '0', 'sys_user_sex', 'label-blue', '', 'Y', '0', 'system', '2024-01-01 00:00:00', 'admin', '2024-12-01 15:30:00', '男性用户');
INSERT INTO `sys_dict_data` VALUES (101, 2, '女', '1', 'sys_user_sex', 'label-pink', '', 'N', '0', 'system', '2024-01-01 00:10:00', 'admin', '2024-12-01 15:35:00', '女性用户');
INSERT INTO `sys_dict_data` VALUES (102, 3, '未知', '2', 'sys_user_sex', 'label-gray', '', 'N', '0', 'system', '2024-01-01 00:20:00', 'admin', '2024-12-01 15:40:00', '性别未知');
INSERT INTO `sys_dict_data` VALUES (103, 1, '正常', '0', 'sys_user_status', 'label-green', '', 'Y', '0', 'system', '2024-01-01 00:30:00', 'admin', '2024-12-01 15:45:00', '账号正常可用');
INSERT INTO `sys_dict_data` VALUES (104, 2, '停用', '1', 'sys_user_status', 'label-red', '', 'N', '0', 'system', '2024-01-01 00:40:00', 'admin', '2024-12-01 15:50:00', '账号暂停使用');
INSERT INTO `sys_dict_data` VALUES (105, 1, '未开始', '0', 'sys_user_fitness_status', 'label-gray', '', 'Y', '0', 'system', '2024-01-01 00:50:00', 'admin', '2024-12-01 15:55:00', '未开始健身计划');
INSERT INTO `sys_dict_data` VALUES (106, 2, '进行中', '1', 'sys_user_fitness_status', 'label-green', '', 'N', '0', 'system', '2024-01-01 01:00:00', 'admin', '2024-12-01 16:00:00', '正在进行健身');
INSERT INTO `sys_dict_data` VALUES (107, 3, '暂停', '2', 'sys_user_fitness_status', 'label-yellow', '', 'N', '0', 'system', '2024-01-01 01:10:00', 'admin', '2024-12-01 16:05:00', '健身计划暂停');
INSERT INTO `sys_dict_data` VALUES (108, 1, '正常', '0', 'gym_status', 'label-green', '', 'Y', '0', 'system', '2024-01-01 01:20:00', 'admin', '2024-12-01 16:10:00', '场馆正常运营');
INSERT INTO `sys_dict_data` VALUES (109, 2, '停用', '1', 'gym_status', 'label-red', '', 'N', '0', 'system', '2024-01-01 01:30:00', 'admin', '2024-12-01 16:15:00', '场馆暂停运营');
INSERT INTO `sys_dict_data` VALUES (110, 1, '瑜伽室', '瑜伽室', 'gym_classroom_type', '', '', 'N', '0', 'system', '2024-01-01 01:40:00', 'admin', '2024-12-01 16:20:00', '瑜伽课程专用');
INSERT INTO `sys_dict_data` VALUES (111, 2, '单车房', '单车房', 'gym_classroom_type', '', '', 'N', '0', 'system', '2024-01-01 01:50:00', 'admin', '2024-12-01 16:25:00', '动感单车课程');
INSERT INTO `sys_dict_data` VALUES (112, 3, '操房', '操房', 'gym_classroom_type', '', '', 'N', '0', 'system', '2024-01-01 02:00:00', 'admin', '2024-12-01 16:30:00', '团体操课程');
INSERT INTO `sys_dict_data` VALUES (113, 4, '3D运动室', '3D运动室', 'gym_classroom_type', '', '', 'N', '0', 'system', '2024-01-01 02:10:00', 'admin', '2024-12-01 16:35:00', '3D运动课程');
INSERT INTO `sys_dict_data` VALUES (114, 5, '冥想室', '冥想室', 'gym_classroom_type', '', '', 'N', '0', 'system', '2024-01-01 02:20:00', 'admin', '2024-12-01 16:40:00', '冥想课程专用');
INSERT INTO `sys_dict_data` VALUES (115, 1, '正常', '0', 'gym_classroom_status', 'label-green', '', 'Y', '0', 'system', '2024-01-01 02:30:00', 'admin', '2024-12-01 16:45:00', '可正常使用');
INSERT INTO `sys_dict_data` VALUES (116, 2, '维护中', '1', 'gym_classroom_status', 'label-yellow', '', 'N', '0', 'system', '2024-01-01 02:40:00', 'admin', '2024-12-01 16:50:00', '设备维护中');
INSERT INTO `sys_dict_data` VALUES (117, 1, '3D运动', '3D运动', 'gym_course_type', '', '', 'N', '0', 'system', '2024-01-01 02:50:00', 'admin', '2024-12-01 16:55:00', '3D互动运动');
INSERT INTO `sys_dict_data` VALUES (118, 2, '冥想课程', '冥想课程', 'gym_course_type', '', '', 'N', '0', 'system', '2024-01-01 03:00:00', 'admin', '2024-12-01 17:00:00', '放松冥想类');
INSERT INTO `sys_dict_data` VALUES (119, 3, '解压课程', '解压课程', 'gym_course_type', '', '', 'N', '0', 'system', '2024-01-01 03:10:00', 'admin', '2024-12-01 17:05:00', '压力缓解类');
INSERT INTO `sys_dict_data` VALUES (120, 4, '瑜伽课程', '瑜伽课程', 'gym_course_type', '', '', 'N', '0', 'system', '2024-01-01 03:20:00', 'admin', '2024-12-01 17:10:00', '传统瑜伽类');
INSERT INTO `sys_dict_data` VALUES (121, 5, '普拉提课程', '普拉提课程', 'gym_course_type', '', '', 'N', '0', 'system', '2024-01-01 03:30:00', 'admin', '2024-12-01 17:15:00', '核心训练类');
INSERT INTO `sys_dict_data` VALUES (122, 1, '初级', '1', 'gym_course_difficulty', 'label-green', '', 'Y', '0', 'system', '2024-01-01 03:40:00', 'admin', '2024-12-01 17:20:00', '适合新手');
INSERT INTO `sys_dict_data` VALUES (123, 2, '中级', '2', 'gym_course_difficulty', 'label-yellow', '', 'N', '0', 'system', '2024-01-01 03:50:00', 'admin', '2024-12-01 17:25:00', '有基础者');
INSERT INTO `sys_dict_data` VALUES (124, 3, '高级', '3', 'gym_course_difficulty', 'label-red', '', 'N', '0', 'system', '2024-01-01 04:00:00', 'admin', '2024-12-01 17:30:00', '资深爱好者');
INSERT INTO `sys_dict_data` VALUES (125, 1, '待开课', '0', 'gym_schedule_status', 'label-blue', '', 'Y', '0', 'system', '2024-01-01 04:10:00', 'admin', '2024-12-01 17:35:00', '未到开课时间');
INSERT INTO `sys_dict_data` VALUES (126, 2, '进行中', '1', 'gym_schedule_status', 'label-green', '', 'N', '0', 'system', '2024-01-01 04:20:00', 'admin', '2024-12-01 17:40:00', '课程进行中');
INSERT INTO `sys_dict_data` VALUES (127, 3, '已结束', '2', 'gym_schedule_status', 'label-gray', '', 'N', '0', 'system', '2024-01-01 04:30:00', 'admin', '2024-12-01 17:45:00', '课程已完成');
INSERT INTO `sys_dict_data` VALUES (128, 4, '已取消', '3', 'gym_schedule_status', 'label-red', '', 'N', '0', 'system', '2024-01-01 04:40:00', 'admin', '2024-12-01 17:50:00', '课程已取消');
INSERT INTO `sys_dict_data` VALUES (129, 1, '次卡', '次卡', 'gym_card_type', '', '', 'N', '0', 'system', '2024-01-01 04:50:00', 'admin', '2024-12-01 17:55:00', '按次数消费');
INSERT INTO `sys_dict_data` VALUES (130, 2, '期限卡', '期限卡', 'gym_card_type', '', '', 'N', '0', 'system', '2024-01-01 05:00:00', 'admin', '2024-12-01 18:00:00', '按时间周期');
INSERT INTO `sys_dict_data` VALUES (131, 3, '储值卡', '储值卡', 'gym_card_type', '', '', 'N', '0', 'system', '2024-01-01 05:10:00', 'admin', '2024-12-01 18:05:00', '预存金额消费');
INSERT INTO `sys_dict_data` VALUES (132, 1, '正常', '0', 'gym_card_status', 'label-green', '', 'Y', '0', 'system', '2024-01-01 05:20:00', 'admin', '2024-12-01 18:10:00', '正常使用');
INSERT INTO `sys_dict_data` VALUES (133, 2, '冻结', '1', 'gym_card_status', 'label-yellow', '', 'N', '0', 'system', '2024-01-01 05:30:00', 'admin', '2024-12-01 18:15:00', '暂时冻结');
INSERT INTO `sys_dict_data` VALUES (134, 3, '过期', '2', 'gym_card_status', 'label-red', '', 'N', '0', 'system', '2024-01-01 05:40:00', 'admin', '2024-12-01 18:20:00', '已过有效期');
INSERT INTO `sys_dict_data` VALUES (135, 1, '已预约', '0', 'gym_booking_status', 'label-blue', '', 'Y', '0', 'system', '2024-01-01 05:50:00', 'admin', '2024-12-01 18:25:00', '已预约未签到');
INSERT INTO `sys_dict_data` VALUES (136, 2, '已签到', '1', 'gym_booking_status', 'label-green', '', 'N', '0', 'system', '2024-01-01 06:00:00', 'admin', '2024-12-01 18:30:00', '已签到上课');
INSERT INTO `sys_dict_data` VALUES (137, 3, '已完成', '2', 'gym_booking_status', 'label-gray', '', 'N', '0', 'system', '2024-01-01 06:10:00', 'admin', '2024-12-01 18:35:00', '课程已完成');
INSERT INTO `sys_dict_data` VALUES (138, 4, '已取消', '3', 'gym_booking_status', 'label-red', '', 'N', '0', 'system', '2024-01-01 06:20:00', 'admin', '2024-12-01 18:40:00', '已取消预约');
INSERT INTO `sys_dict_data` VALUES (139, 5, '爽约', '4', 'gym_booking_status', 'label-orange', '', 'N', '0', 'system', '2024-01-01 06:30:00', 'admin', '2024-12-01 18:45:00', '未签到未取消');
INSERT INTO `sys_dict_data` VALUES (140, 1, '运动打卡', '运动打卡', 'fitness_checkin_type', '', '', 'N', '0', 'system', '2024-01-01 06:40:00', 'admin', '2024-12-01 18:50:00', '运动后打卡');
INSERT INTO `sys_dict_data` VALUES (141, 2, '饮食打卡', '饮食打卡', 'fitness_checkin_type', '', '', 'N', '0', 'system', '2024-01-01 06:50:00', 'admin', '2024-12-01 18:55:00', '饮食记录打卡');
INSERT INTO `sys_dict_data` VALUES (142, 3, '冥想打卡', '冥想打卡', 'fitness_checkin_type', '', '', 'N', '0', 'system', '2024-01-01 07:00:00', 'admin', '2024-12-01 19:00:00', '冥想后打卡');
INSERT INTO `sys_dict_data` VALUES (143, 4, '游戏打卡', '游戏打卡', 'fitness_checkin_type', '', '', 'N', '0', 'system', '2024-01-01 07:10:00', 'admin', '2024-12-01 19:05:00', '趣味游戏打卡');
INSERT INTO `sys_dict_data` VALUES (144, 1, '减脂食谱', '减脂食谱', 'fitness_recipe_type', '', '', 'N', '0', 'system', '2024-01-01 07:20:00', 'admin', '2024-12-01 19:10:00', '减脂专用食谱');
INSERT INTO `sys_dict_data` VALUES (145, 2, '解压食谱', '解压食谱', 'fitness_recipe_type', '', '', 'N', '0', 'system', '2024-01-01 07:30:00', 'admin', '2024-12-01 19:15:00', '缓解压力食谱');
INSERT INTO `sys_dict_data` VALUES (146, 3, '普通食谱', '普通食谱', 'fitness_recipe_type', '', '', 'N', '0', 'system', '2024-01-01 07:40:00', 'admin', '2024-12-01 19:20:00', '日常健康食谱');
INSERT INTO `sys_dict_data` VALUES (147, 4, '增肌食谱', '增肌食谱', 'fitness_recipe_type', '', '', 'N', '0', 'system', '2024-01-01 07:50:00', 'admin', '2024-12-01 19:25:00', '肌肉增长食谱');
INSERT INTO `sys_dict_data` VALUES (148, 1, '正面', '0', 'fitness_emotion_status', 'label-green', '', 'Y', '0', 'system', '2024-01-01 08:00:00', 'admin', '2024-12-01 19:30:00', '积极情绪');
INSERT INTO `sys_dict_data` VALUES (149, 2, '负面', '1', 'fitness_emotion_status', 'label-red', '', 'N', '0', 'system', '2024-01-01 08:10:00', 'admin', '2024-12-01 19:35:00', '消极情绪');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (100, '用户性别', 'sys_user_sex', '0', 'system', '2024-01-01 00:00:00', 'admin', '2024-12-01 14:00:00', '用户性别字典');
INSERT INTO `sys_dict_type` VALUES (101, '用户状态', 'sys_user_status', '0', 'system', '2024-01-01 00:30:00', 'admin', '2024-12-01 14:05:00', '用户账号状态');
INSERT INTO `sys_dict_type` VALUES (102, '健身状态', 'sys_user_fitness_status', '0', 'system', '2024-01-01 01:00:00', 'admin', '2024-12-01 14:10:00', '用户健身状态');
INSERT INTO `sys_dict_type` VALUES (103, '场馆状态', 'gym_status', '0', 'system', '2024-01-01 01:30:00', 'admin', '2024-12-01 14:15:00', '场馆运营状态');
INSERT INTO `sys_dict_type` VALUES (104, '教室类型', 'gym_classroom_type', '0', 'system', '2024-01-01 02:00:00', 'admin', '2024-12-01 14:20:00', '教室功能类型');
INSERT INTO `sys_dict_type` VALUES (105, '教室状态', 'gym_classroom_status', '0', 'system', '2024-01-01 02:30:00', 'admin', '2024-12-01 14:25:00', '教室使用状态');
INSERT INTO `sys_dict_type` VALUES (106, '课程类型', 'gym_course_type', '0', 'system', '2024-01-01 03:00:00', 'admin', '2024-12-01 14:30:00', '课程内容类型');
INSERT INTO `sys_dict_type` VALUES (107, '课程难度', 'gym_course_difficulty', '0', 'system', '2024-01-01 03:30:00', 'admin', '2024-12-01 14:35:00', '课程难度等级');
INSERT INTO `sys_dict_type` VALUES (108, '排期状态', 'gym_schedule_status', '0', 'system', '2024-01-01 04:00:00', 'admin', '2024-12-01 14:40:00', '课程排期状态');
INSERT INTO `sys_dict_type` VALUES (109, '会员卡类型', 'gym_card_type', '0', 'system', '2024-01-01 04:30:00', 'admin', '2024-12-01 14:45:00', '会员卡类型');
INSERT INTO `sys_dict_type` VALUES (110, '会员卡状态', 'gym_card_status', '0', 'system', '2024-01-01 05:00:00', 'admin', '2024-12-01 14:50:00', '会员卡使用状态');
INSERT INTO `sys_dict_type` VALUES (111, '预约状态', 'gym_booking_status', '0', 'system', '2024-01-01 05:30:00', 'admin', '2024-12-01 14:55:00', '课程预约状态');
INSERT INTO `sys_dict_type` VALUES (112, '打卡类型', 'fitness_checkin_type', '0', 'system', '2024-01-01 06:00:00', 'admin', '2024-12-01 15:00:00', '用户打卡类型');
INSERT INTO `sys_dict_type` VALUES (113, '食谱类型', 'fitness_recipe_type', '0', 'system', '2024-01-01 06:30:00', 'admin', '2024-12-01 15:05:00', '智能食谱类型');
INSERT INTO `sys_dict_type` VALUES (114, '情绪状态', 'fitness_emotion_status', '0', 'system', '2024-01-01 07:00:00', 'admin', '2024-12-01 15:10:00', '用户情绪状态');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (100, 'AI情绪分析任务', 'AI_TASK', 'com.slimcamp.ai.task.EmotionAnalysisTask.execute', '0 0 1 * * ?', '3', '1', '0', 'system', '2024-01-01 00:00:00', 'admin', '2024-12-01 13:00:00', '每天凌晨1点执行情绪分析');
INSERT INTO `sys_job` VALUES (101, 'AI课程推送任务', 'AI_TASK', 'com.slimcamp.ai.task.CoursePushTask.execute', '0 0 8 * * ?', '3', '1', '0', 'system', '2024-01-01 00:30:00', 'admin', '2024-12-01 13:05:00', '每天早上8点推送课程');
INSERT INTO `sys_job` VALUES (102, 'AI食谱推送任务', 'AI_TASK', 'com.slimcamp.ai.task.RecipePushTask.execute', '0 0 18 * * ?', '3', '1', '0', 'system', '2024-01-01 01:00:00', 'admin', '2024-12-01 13:10:00', '每天晚上6点推送食谱');
INSERT INTO `sys_job` VALUES (103, '数据统计任务', 'STATS_TASK', 'com.slimcamp.stats.task.DailyStatsTask.execute', '0 0 2 * * ?', '3', '1', '0', 'system', '2024-01-01 01:30:00', 'admin', '2024-12-01 13:15:00', '每天凌晨2点统计前日数据');
INSERT INTO `sys_job` VALUES (104, '会员到期提醒任务', 'NOTIFY_TASK', 'com.slimcamp.notify.task.MemberExpireNotifyTask.execute', '0 0 10 * * ?', '3', '1', '0', 'system', '2024-01-01 02:00:00', 'admin', '2024-12-01 13:20:00', '每天早上10点提醒到期会员');
INSERT INTO `sys_job` VALUES (105, '课程预约提醒任务', 'NOTIFY_TASK', 'com.slimcamp.notify.task.CourseBookingNotifyTask.execute', '0 0 16 * * ?', '3', '1', '0', 'system', '2024-01-01 02:30:00', 'admin', '2024-12-01 13:25:00', '每天下午4点提醒次日预约用户');
INSERT INTO `sys_job` VALUES (106, '连续打卡奖励任务', 'REWARD_TASK', 'com.slimcamp.reward.task.CheckinRewardTask.execute', '0 0 0 * * ?', '3', '1', '0', 'system', '2024-01-01 03:00:00', 'admin', '2024-12-01 13:30:00', '每天凌晨0点发放连续打卡奖励');
INSERT INTO `sys_job` VALUES (107, '数据备份任务', 'SYSTEM_TASK', 'com.slimcamp.system.task.DataBackupTask.execute', '0 0 3 ? * SUN', '3', '1', '0', 'system', '2024-01-01 03:30:00', 'admin', '2024-12-01 13:35:00', '每周日凌晨3点备份数据');
INSERT INTO `sys_job` VALUES (108, '爽约记录清理任务', 'SYSTEM_TASK', 'com.slimcamp.system.task.NoShowCleanTask.execute', '0 0 4 1 * ?', '3', '1', '0', 'system', '2024-01-01 04:00:00', 'admin', '2024-12-01 13:40:00', '每月1日凌晨4点清理过期爽约记录');
INSERT INTO `sys_job` VALUES (109, 'AI姿态纠错日志清理', 'AI_TASK', 'com.slimcamp.ai.task.PostureLogCleanTask.execute', '0 0 5 15 * ?', '3', '1', '0', 'system', '2024-01-01 04:30:00', 'admin', '2024-12-01 13:45:00', '每月15日凌晨5点清理纠错日志');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, '/system', 'Layout', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '健身房管理', 0, 2, '/gym', 'Layout', NULL, '', 1, 0, 'M', '0', '0', '', 'nested', 'admin', '2024-01-01 00:05:00', 'admin', '2024-01-01 00:05:00', '健身房管理目录');
INSERT INTO `sys_menu` VALUES (3, '课程管理', 0, 3, '/course', 'Layout', NULL, '', 1, 0, 'M', '0', '0', '', 'guide', 'admin', '2024-01-01 00:10:00', 'admin', '2024-01-01 00:10:00', '课程管理目录');
INSERT INTO `sys_menu` VALUES (4, '健身管理', 0, 4, '/fitness', 'Layout', NULL, '', 1, 0, 'M', '0', '0', '', 'peoples', 'admin', '2024-01-01 00:15:00', 'admin', '2024-01-01 00:15:00', '健身管理目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', '/views/system/user/index', NULL, '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2024-01-01 00:20:00', 'admin', '2024-01-01 00:20:00', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', '/views/system/role/index', NULL, '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2024-01-01 00:25:00', 'admin', '2024-01-01 00:25:00', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', '/views/system/menu/index', NULL, '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2024-01-01 00:30:00', 'admin', '2024-01-01 00:30:00', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', '/views/system/dept/index', NULL, '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2024-01-01 00:35:00', 'admin', '2024-01-01 00:35:00', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', '/views/system/post/index', NULL, '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2024-01-01 00:40:00', 'admin', '2024-01-01 00:40:00', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', '/views/system/dict/index', NULL, '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2024-01-01 00:45:00', 'admin', '2024-01-01 00:45:00', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', '/views/system/config/index', NULL, '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2024-01-01 00:50:00', 'admin', '2024-01-01 00:50:00', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', '/views/system/notice/index', NULL, '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2024-01-01 00:55:00', 'admin', '2024-01-01 00:55:00', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '/views/system/log/index', NULL, '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2024-01-01 01:00:00', 'admin', '2024-01-01 01:00:00', '日志管理目录');
INSERT INTO `sys_menu` VALUES (109, '操作日志', 108, 1, 'operlog', '/views/system/log/operlog', NULL, '', 1, 0, 'C', '0', '0', 'system:operlog:list', 'form', 'admin', '2024-01-01 01:05:00', 'admin', '2024-01-01 01:05:00', '操作日志菜单');
INSERT INTO `sys_menu` VALUES (110, '登录日志', 108, 2, 'logininfor', '/views/system/log/logininfor', NULL, '', 1, 0, 'C', '0', '0', 'system:logininfor:list', 'logininfor', 'admin', '2024-01-01 01:10:00', 'admin', '2024-01-01 01:10:00', '登录日志菜单');
INSERT INTO `sys_menu` VALUES (200, '场馆管理', 2, 1, 'gym-info', '/views/gym/info/index', NULL, '', 1, 0, 'C', '0', '0', 'gym:info:list', 'form', 'admin', '2024-01-01 01:15:00', 'admin', '2024-01-01 01:15:00', '场馆管理菜单');
INSERT INTO `sys_menu` VALUES (201, '教室管理', 2, 2, 'classroom', '/views/gym/classroom/index', NULL, '', 1, 0, 'C', '0', '0', 'gym:classroom:list', 'table', 'admin', '2024-01-01 01:20:00', 'admin', '2024-01-01 01:20:00', '教室管理菜单');
INSERT INTO `sys_menu` VALUES (202, '课程模板', 3, 1, 'course-template', '/views/course/template/index', NULL, '', 1, 0, 'C', '0', '0', 'course:template:list', 'form', 'admin', '2024-01-01 01:25:00', 'admin', '2024-01-01 01:25:00', '课程模板菜单');
INSERT INTO `sys_menu` VALUES (203, '课程排期', 3, 2, 'course-schedule', '/views/course/schedule/index', NULL, '', 1, 0, 'C', '0', '0', 'course:schedule:list', 'date', 'admin', '2024-01-01 01:30:00', 'admin', '2024-01-01 01:30:00', '课程排期菜单');
INSERT INTO `sys_menu` VALUES (204, '会员卡类型', 2, 3, 'card-type', '/views/gym/card-type/index', NULL, '', 1, 0, 'C', '0', '0', 'gym:card-type:list', 'money', 'admin', '2024-01-01 01:35:00', 'admin', '2024-01-01 01:35:00', '会员卡类型菜单');
INSERT INTO `sys_menu` VALUES (205, '用户会员卡', 2, 4, 'user-card', '/views/gym/user-card/index', NULL, '', 1, 0, 'C', '0', '0', 'gym:user-card:list', 'user', 'admin', '2024-01-01 01:40:00', 'admin', '2024-01-01 01:40:00', '用户会员卡菜单');
INSERT INTO `sys_menu` VALUES (206, '课程预约', 3, 3, 'booking', '/views/booking/index', NULL, '', 1, 0, 'C', '0', '0', 'gym:booking:list', 'guide', 'admin', '2024-01-01 01:45:00', 'admin', '2024-01-01 01:45:00', '课程预约菜单');
INSERT INTO `sys_menu` VALUES (300, '体重记录', 4, 1, 'weight-record', '/views/fitness/weight-record/index', NULL, '', 1, 0, 'C', '0', '0', 'fitness:weight-record:list', 'chart', 'admin', '2024-01-01 01:50:00', 'admin', '2024-01-01 01:50:00', '体重记录菜单');
INSERT INTO `sys_menu` VALUES (301, '智能食谱', 4, 2, 'recipe', '/views/fitness/recipe/index', NULL, '', 1, 0, 'C', '0', '0', 'fitness:recipe:list', 'food', 'admin', '2024-01-01 01:55:00', 'admin', '2024-01-01 01:55:00', '智能食谱菜单');
INSERT INTO `sys_menu` VALUES (302, '打卡记录', 4, 3, 'checkin', '/views/fitness/checkin/index', NULL, '', 1, 0, 'C', '0', '0', 'fitness:checkin:list', 'date', 'admin', '2024-01-01 02:00:00', 'admin', '2024-01-01 02:00:00', '打卡记录菜单');
INSERT INTO `sys_menu` VALUES (303, '奖励管理', 4, 4, 'reward', '/views/fitness/reward/index', NULL, '', 1, 0, 'C', '0', '0', 'fitness:reward:list', 'star', 'admin', '2024-01-01 02:05:00', 'admin', '2024-01-01 02:05:00', '奖励管理菜单');
INSERT INTO `sys_menu` VALUES (304, '姿态纠错', 4, 5, 'posture', '/views/fitness/posture/index', NULL, '', 1, 0, 'C', '0', '0', 'fitness:posture:list', 'eye-open', 'admin', '2024-01-01 02:10:00', 'admin', '2024-01-01 02:10:00', '姿态纠错菜单');
INSERT INTO `sys_menu` VALUES (305, '情绪分析', 4, 6, 'emotion', '/views/fitness/emotion/index', NULL, '', 1, 0, 'C', '0', '0', 'fitness:emotion:list', 'emoji', 'admin', '2024-01-01 02:15:00', 'admin', '2024-01-01 02:15:00', '情绪分析菜单');
INSERT INTO `sys_menu` VALUES (306, '趣味游戏', 4, 7, 'game', '/views/fitness/game/index', NULL, '', 1, 0, 'C', '0', '0', 'fitness:game:list', 'gamepad', 'admin', '2024-01-01 02:20:00', 'admin', '2024-01-01 02:20:00', '趣味游戏菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2024-01-01 02:25:00', 'admin', '2024-01-01 02:25:00', '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2024-01-01 02:30:00', 'admin', '2024-01-01 02:30:00', '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2024-01-01 02:35:00', 'admin', '2024-01-01 02:35:00', '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2024-01-01 02:40:00', 'admin', '2024-01-01 02:40:00', '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2024-01-01 02:45:00', 'admin', '2024-01-01 02:45:00', '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2024-01-01 02:50:00', 'admin', '2024-01-01 02:50:00', '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2024-01-01 02:55:00', 'admin', '2024-01-01 02:55:00', '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2024-01-01 03:00:00', 'admin', '2024-01-01 03:00:00', '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2024-01-01 03:05:00', 'admin', '2024-01-01 03:05:00', '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2024-01-01 03:10:00', 'admin', '2024-01-01 03:10:00', '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2024-01-01 03:15:00', 'admin', '2024-01-01 03:15:00', '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2024-01-01 03:20:00', 'admin', '2024-01-01 03:20:00', '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2024-01-01 03:25:00', 'admin', '2024-01-01 03:25:00', '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2024-01-01 03:30:00', 'admin', '2024-01-01 03:30:00', '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2024-01-01 03:35:00', 'admin', '2024-01-01 03:35:00', '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2024-01-01 03:40:00', 'admin', '2024-01-01 03:40:00', '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2024-01-01 03:45:00', 'admin', '2024-01-01 03:45:00', '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2024-01-01 03:50:00', 'admin', '2024-01-01 03:50:00', '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2024-01-01 03:55:00', 'admin', '2024-01-01 03:55:00', '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2024-01-01 04:00:00', 'admin', '2024-01-01 04:00:00', '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2024-01-01 04:05:00', 'admin', '2024-01-01 04:05:00', '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2024-01-01 04:10:00', 'admin', '2024-01-01 04:10:00', '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2024-01-01 04:15:00', 'admin', '2024-01-01 04:15:00', '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2024-01-01 04:20:00', 'admin', '2024-01-01 04:20:00', '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2024-01-01 04:25:00', 'admin', '2024-01-01 04:25:00', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '公告状态（0草稿 1待发布 2已发布 3已撤回 4已过期）',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `notice_scope` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '通知范围（1全部用户 2指定角色 3指定用户）',
  `receive_role_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '接收角色IDs（逗号分隔）',
  `receive_user_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '接收用户IDs（逗号分隔）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_publish_time`(`publish_time` ASC) USING BTREE,
  INDEX `idx_notice_type`(`notice_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (10, '瘦瘦营V3.0系统上线公告', '2', 0xE59084E4BD8DE794A8E688B7EFBC9AE798A6E798A6E890A5536C696D43616D702056332E30E78988E69CACE5B7B2E4BA8E32303234E5B9B431E69C8831E697A5E6ADA3E5BC8FE4B88AE7BABFEFBC8CE696B0E5A29E4149E5A7BFE68081E7BAA0E99499E38081E68385E7BBAAE58886E69E90E38081E699BAE883BDE9A39FE8B0B1E68EA8E98081E7AD89E58A9FE883BDEFBC8CE6ACA2E8BF8EE4BD93E9AA8CEFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-01-01 00:00:00', 'admin', '2024-12-01 11:00:00', '系统版本更新公告');
INSERT INTO `sys_notice` VALUES (11, '春节场馆营业时间调整', '1', 0xE698A5E88A82E69C9FE997B4EFBC8832303234E5B9B432E69C883130E697A52D32E69C883137E697A5EFBC89EFBC8CE59084E59CBAE9A686E890A5E4B89AE697B6E997B4E8B083E695B4E4B8BA31303A30302D31383A3030EFBC8C32E69C883138E697A5E681A2E5A48DE6ADA3E5B8B8E890A5E4B89AE697B6E997B4EFBC88383A30302D32323A3030EFBC89EFBC8CE7BB99E682A8E5B8A6E69DA5E4B88DE4BEBFE695ACE8AFB7E8B085E8A7A3EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-01-20 10:00:00', 'admin', '2024-02-01 14:30:00', '假期营业时间通知');
INSERT INTO `sys_notice` VALUES (12, '3D运动课程新上线', '1', 0xE696B0E5A29EE3808CE5A4AAE7A9BAE6BCABE6ADA53344E3808DE3808CE4B89BE69E97E68EA2E999A93344E3808DE4B8A4E997A8E783ADE997A8E8AFBEE7A88BEFBC8CE7BB93E590885652E68A80E69CAFE68993E980A0E6B289E6B5B8E5BC8FE8BF90E58AA8E4BD93E9AA8CEFBC8CE4BC9AE59198E58FAFE4BC98E58588E9A284E7BAA6EFBC8CE99D9EE4BC9AE59198E58FAFE4BAABE4BD93E9AA8CE4BBB73939E585832FE88A82EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-03-15 09:30:00', 'admin', '2024-03-20 11:10:00', '新课程通知');
INSERT INTO `sys_notice` VALUES (13, '4月减脂挑战赛报名启动', '1', 0x32303234E5B9B434E69C88E5878FE88482E68C91E68898E8B59BE5BC80E5A78BE68AA5E5908DEFBC81E68AA5E5908DE697B6E997B4EFBC9A33E69C883230E697A52D33E69C883331E697A5EFBC8CE6AF94E8B59BE697B6E997B4EFBC9A34E69C8831E697A52D34E69C883330E697A5EFBC8CE586A0E5869BE58FAFE88EB7E5BE97E4BBB7E580BC35303030E58583E581A5E8BAABE5A4A7E7A4BCE58C85EFBC8CE5BFABE69DA5E58F82E4B88EE590A7EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-03-20 15:00:00', 'admin', '2024-03-25 16:40:00', '活动通知');
INSERT INTO `sys_notice` VALUES (14, '会员卡充值优惠活动', '1', 0xE58DB3E697A5E8B5B7E887B335E69C883331E697A5EFBC8CE4BC9AE59198E58DA1E58585E580BCE6BBA132303030E58583E98081353030E58583EFBC8CE6BBA135303030E58583E9808131353030E58583EFBC8CE58585E580BCE8B68AE5A49AE4BC98E683A0E8B68AE5A49AEFBC8CE4BC98E683A0E4B88DE58FA0E58AA0EFBC8CE8AFA6E68385E58FAFE592A8E8AFA2E59CBAE9A686E9A1BEE997AEEFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-04-10 10:00:00', 'admin', '2024-04-15 14:20:00', '充值优惠通知');
INSERT INTO `sys_notice` VALUES (15, '场馆设备维护通知', '1', 0xE58C97E4BAACE69C9DE998B3E581A5E8BAABE4B8ADE5BF83E5B086E4BA8E35E69C883130E697A5E8BF9BE8A18CE8AEBEE5A487E7BBB4E68AA4EFBC8CE5BD93E5A4A93344E8BF90E58AA8E5AEA4E69A82E5819CE4BDBFE794A8EFBC8CE585B6E4BB96E58CBAE59F9FE6ADA3E5B8B8E5BC80E694BEEFBC8CE5BBBAE8AEAEE4BC9AE59198E59088E79086E5AE89E68E92E581A5E8BAABE697B6E997B4EFBC8CE6849FE8B0A2E9858DE59088EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-05-01 09:00:00', 'admin', '2024-05-05 11:30:00', '设备维护通知');
INSERT INTO `sys_notice` VALUES (16, '6月冥想课程主题月', '1', 0x36E69C88E4B8BAE586A5E683B3E8AFBEE7A88BE4B8BBE9A298E69C88EFBC8CE696B0E5A29EE3808CE699A8E997B4E594A4E98692E586A5E683B3E3808DE3808CE5A49CE997B4E58AA9E79CA0E586A5E683B3E3808DE3808CE8818CE59CBAE8A7A3E58E8BE586A5E683B3E3808D33E997A8E8AFBEE7A88BEFBC8CE4BC9AE59198E58FAFE5858DE8B4B9E9A284E7BAA6EFBC8CE99D9EE4BC9AE59198E4BD93E9AA8CE4BBB73639E585832FE88A82EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-05-20 15:30:00', 'admin', '2024-05-25 16:10:00', '主题月活动通知');
INSERT INTO `sys_notice` VALUES (17, '安全健身温馨提示', '1', 0xE5A48FE5ADA3E581A5E8BAABE6B3A8E6848FE4BA8BE9A1B9EFBC9A312E20E8BF90E58AA8E5898DE5819AE5A5BDE783ADE8BAABEFBC8CE981BFE5858DE8828CE88289E68B89E4BCA4EFBC9B322E20E58F8AE697B6E8A1A5E58585E6B0B4E58886EFBC8CE5BBBAE8AEAEE9A5AEE794A8E6B8A9E6B0B4EFBC9B332E20E981BFE5858DE9AB98E6B8A9E697B6E6AEB5EFBC8831313A30302D31353A3030EFBC89E589A7E78388E8BF90E58AA8EFBC9B342E20E8BF90E58AA8E5908EE58F8AE697B6E68B89E4BCB8EFBC8CE694BEE69DBEE8828CE88289E38082, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-06-01 10:00:00', 'admin', '2024-06-05 14:00:00', '安全提示');
INSERT INTO `sys_notice` VALUES (18, '新增3家合作场馆通知', '1', 0xE798A6E798A6E890A5E696B0E5A29EE4B88AE6B5B7E5BE90E6B187E59CBAE9A686E38081E5B9BFE5B79EE88D94E6B9BEE59CBAE9A686E38081E6B7B1E59CB3E7A68FE794B0E59CBAE9A686EFBC8C37E69C8831E697A5E6ADA3E5BC8FE890A5E4B89AEFBC8CE4BC9AE59198E58FAFE8B7A8E59CBAE9A686E4BDBFE794A8E4BC9AE59198E58DA1EFBC8CE6ACA2E8BF8EE5B0B1E8BF91E4BD93E9AA8CEFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-06-15 09:30:00', 'admin', '2024-06-20 11:20:00', '新场馆通知');
INSERT INTO `sys_notice` VALUES (19, '7月趣味运动嘉年华', '1', 0x37E69C883230E697A5E5B086E4B8BEE58A9EE8B6A3E591B3E8BF90E58AA8E59889E5B9B4E58D8EEFBC8CE58C85E590ABE3808CE58AA8E6849FE58D95E8BDA6E68C91E68898E8B59BE3808DE3808CE7919CE4BCBDE68EA5E58A9BE8B59BE3808DE3808C3344E6B8B8E6888FE997AFE585B3E3808DE7AD89E9A1B9E79BAEEFBC8CE68AA5E5908DE58DB3E98081E5AE9AE588B6E8BF90E58AA8E58C85EFBC8CE88EB7E8839CE88085E58FAFE88EB7E4B887E58583E5A4A7E5A596EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-07-01 15:00:00', 'admin', '2024-07-05 16:30:00', '嘉年华活动通知');
INSERT INTO `sys_notice` VALUES (20, '会员等级制度升级', '1', 0xE887AA38E69C8831E697A5E8B5B7EFBC8CE4BC9AE59198E7AD89E7BAA7E58886E4B8BAE99D92E9939CE38081E799BDE993B6E38081E9BB84E98791E38081E99382E98791E38081E992BBE79FB335E7BAA7EFBC8CE6A0B9E68DAEE7B4AFE8AEA1E6B688E8B4B9E98791E9A29DE5928CE68993E58DA1E6ACA1E695B0E58D87E7BAA7EFBC8CE7AD89E7BAA7E8B68AE9AB98E69D83E79B8AE8B68AE5A49AEFBC88E4BC98E58588E9A284E7BAA6E38081E4B893E5B19EE69599E7BB83E38081E5858DE8B4B9E8AFBEE7A88BE7AD89EFBC89, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-07-15 10:00:00', 'admin', '2024-07-20 14:40:00', '会员制度升级通知');
INSERT INTO `sys_notice` VALUES (21, '秋季健身计划制定指南', '1', 0xE7A78BE5ADA3E698AFE581A5E8BAABE9BB84E98791E69C9FEFBC8CE68EA8E88D90E8AFBEE7A88BEFBC9A312E20E5A29EE8828CE7B1BBEFBC9AE699AEE68B89E68F90E38081E58A9BE9878FE8AEADE7BB83EFBC9B322E20E5878FE88482E7B1BBEFBC9A3344E8BF90E58AA8E38081E58AA8E6849FE58D95E8BDA6EFBC9B332E20E585BBE7949FE7B1BBEFBC9AE7919CE4BCBDE38081E586A5E683B3E38082E4BC9AE59198E58FAFE88194E7B3BBE581A5E8BAABE9A1BEE997AEE5AE9AE588B6E4B893E5B19EE8AEA1E58892EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-09-01 09:30:00', 'admin', '2024-09-05 11:10:00', '健身指南通知');
INSERT INTO `sys_notice` VALUES (22, '国庆场馆营业时间调整', '1', 0xE59BBDE5BA86E69C9FE997B4EFBC883130E69C8831E697A52D3130E69C8837E697A5EFBC89EFBC8CE59084E59CBAE9A686E890A5E4B89AE697B6E997B4E4B8BA393A30302D32303A3030EFBC8C3130E69C8838E697A5E681A2E5A48DE6ADA3E5B8B8E890A5E4B89AE697B6E997B4EFBC8CE7A59DE5A4A7E5AEB6E59BBDE5BA86E5BFABE4B990EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-09-20 10:00:00', 'admin', '2024-09-25 14:20:00', '假期营业时间通知');
INSERT INTO `sys_notice` VALUES (23, 'AI智能健身助手上线', '1', 0xE696B0E5A29E4149E699BAE883BDE581A5E8BAABE58AA9E6898BEFBC8CE58FAFE5AE9EE697B6E7BAA0E6ADA3E8BF90E58AA8E5A7BFE68081E38081E58886E69E90E8BAABE4BD93E695B0E68DAEE38081E68EA8E98081E4B8AAE680A7E58C96E8AFBEE7A88BE5928CE9A39FE8B0B1EFBC8CE4BC9AE59198E58FAFE59CA8415050E9A696E9A1B5E782B9E587BBE4BDBFE794A8EFBC8CE585A8E7A88BE5858DE8B4B9EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-10-15 09:30:00', 'admin', '2024-10-20 11:30:00', '新功能通知');
INSERT INTO `sys_notice` VALUES (24, '双11会员卡优惠活动', '1', 0xE58F8C3131E69C9FE997B4EFBC883131E69C8831E697A52D3131E69C883131E697A5EFBC89EFBC8CE4BC9AE59198E58DA1E585A8E59CBA38E68A98E4BC98E683A0EFBC8CE696B0E794A8E688B7E58A9EE58DA1E9A29DE5A496E8B5A0E9808131E4B8AAE69C88E69C89E69588E69C9FEFBC8CE88081E794A8E688B7E7BBADE58DA1E8B5A0E9808132E6ACA1E7A781E69599E8AFBEEFBC8CE99499E8BF87E5868DE7AD89E4B880E5B9B4EFBC81, '0', NULL, NULL, 0, '1', NULL, NULL, 'admin', '2024-10-25 15:00:00', 'admin', '2024-11-01 14:00:00', '双11优惠通知');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (100, 'POST_ADMIN', '系统管理员', 1, '0', 'system', '2024-01-01 00:00:00', 'admin', '2024-12-01 11:00:00', '系统核心运维岗位');
INSERT INTO `sys_post` VALUES (101, 'POST_AREA_MANAGER', '区域经理', 2, '0', 'system', '2024-01-01 00:30:00', 'admin', '2024-12-01 11:05:00', '负责区域内场馆管理');
INSERT INTO `sys_post` VALUES (102, 'POST_GYM_MANAGER', '场馆经理', 3, '0', 'system', '2024-01-01 01:00:00', 'admin', '2024-12-01 11:10:00', '单场馆全面管理');
INSERT INTO `sys_post` VALUES (103, 'POST_YOGA_COACH', '瑜伽教练', 4, '0', 'system', '2024-01-01 01:30:00', 'admin', '2024-12-01 11:15:00', '瑜伽课程教学');
INSERT INTO `sys_post` VALUES (104, 'POST_PILATES_COACH', '普拉提教练', 5, '0', 'system', '2024-01-01 02:00:00', 'admin', '2024-12-01 11:20:00', '普拉提课程教学');
INSERT INTO `sys_post` VALUES (105, 'POST_3D_SPORT_COACH', '3D运动教练', 6, '0', 'system', '2024-01-01 02:30:00', 'admin', '2024-12-01 11:25:00', '3D运动课程教学');
INSERT INTO `sys_post` VALUES (106, 'POST_MEDITATION_COACH', '冥想教练', 7, '0', 'system', '2024-01-01 03:00:00', 'admin', '2024-12-01 11:30:00', '冥想课程教学');
INSERT INTO `sys_post` VALUES (107, 'POST_COURSE_CONSULT', '课程顾问', 8, '0', 'system', '2024-01-01 03:30:00', 'admin', '2024-12-01 11:35:00', '课程销售与咨询');
INSERT INTO `sys_post` VALUES (108, 'POST_FITNESS_CONSULT', '健身顾问', 9, '0', 'system', '2024-01-01 04:00:00', 'admin', '2024-12-01 11:40:00', '健身计划制定');
INSERT INTO `sys_post` VALUES (109, 'POST_DATA_ANALYST', '数据分析师', 10, '0', 'system', '2024-01-01 04:30:00', 'admin', '2024-12-01 11:45:00', '业务数据统计分析');
INSERT INTO `sys_post` VALUES (110, 'POST_EQUIPMENT_MANAGER', '设备管理员', 11, '0', 'system', '2024-01-01 05:00:00', 'admin', '2024-12-01 11:50:00', '场馆设备维护');
INSERT INTO `sys_post` VALUES (111, 'POST_CLEANER', '保洁人员', 12, '0', 'system', '2024-01-01 05:30:00', 'admin', '2024-12-01 11:55:00', '场馆清洁服务');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (100, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'system', '2024-01-01 00:00:00', 'admin', '2024-12-01 10:00:00', '系统最高权限角色');
INSERT INTO `sys_role` VALUES (101, '区域管理员', 'area_admin', 2, '2', 1, 1, '0', '0', 'system', '2024-01-01 00:30:00', 'admin', '2024-12-01 10:05:00', '管理对应区域场馆');
INSERT INTO `sys_role` VALUES (102, '场馆负责人', 'gym_manager', 3, '2', 1, 1, '0', '0', 'system', '2024-01-01 01:00:00', 'admin', '2024-12-01 10:10:00', '管理单个场馆所有业务');
INSERT INTO `sys_role` VALUES (103, '健身教练', 'fitness_coach', 4, '2', 1, 1, '0', '0', 'system', '2024-01-01 01:30:00', 'admin', '2024-12-01 10:15:00', '负责课程教学、学员指导');
INSERT INTO `sys_role` VALUES (104, '课程顾问', 'course_consultant', 5, '2', 1, 1, '0', '0', 'system', '2024-01-01 02:00:00', 'admin', '2024-12-01 10:20:00', '负责课程推广、学员咨询');
INSERT INTO `sys_role` VALUES (105, '普通健身用户', 'normal_user', 6, '2', 1, 1, '0', '0', 'system', '2024-01-01 02:30:00', 'admin', '2024-12-01 10:25:00', '普通学员，可预约课程、打卡');
INSERT INTO `sys_role` VALUES (106, 'VIP健身用户', 'vip_user', 7, '2', 1, 1, '0', '0', 'system', '2024-01-01 03:00:00', 'admin', '2024-12-01 10:30:00', 'VIP学员，优先预约、专属服务');
INSERT INTO `sys_role` VALUES (107, '数据分析师', 'data_analyst', 8, '1', 1, 1, '0', '0', 'system', '2024-01-01 03:30:00', 'admin', '2024-12-01 10:35:00', '负责数据统计、报表生成');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (100, 1);
INSERT INTO `sys_role_menu` VALUES (100, 2);
INSERT INTO `sys_role_menu` VALUES (100, 3);
INSERT INTO `sys_role_menu` VALUES (100, 4);
INSERT INTO `sys_role_menu` VALUES (100, 100);
INSERT INTO `sys_role_menu` VALUES (100, 101);
INSERT INTO `sys_role_menu` VALUES (100, 102);
INSERT INTO `sys_role_menu` VALUES (100, 103);
INSERT INTO `sys_role_menu` VALUES (100, 104);
INSERT INTO `sys_role_menu` VALUES (100, 105);
INSERT INTO `sys_role_menu` VALUES (100, 106);
INSERT INTO `sys_role_menu` VALUES (100, 107);
INSERT INTO `sys_role_menu` VALUES (100, 108);
INSERT INTO `sys_role_menu` VALUES (100, 109);
INSERT INTO `sys_role_menu` VALUES (100, 110);
INSERT INTO `sys_role_menu` VALUES (100, 200);
INSERT INTO `sys_role_menu` VALUES (100, 201);
INSERT INTO `sys_role_menu` VALUES (100, 202);
INSERT INTO `sys_role_menu` VALUES (100, 203);
INSERT INTO `sys_role_menu` VALUES (100, 204);
INSERT INTO `sys_role_menu` VALUES (100, 205);
INSERT INTO `sys_role_menu` VALUES (100, 206);
INSERT INTO `sys_role_menu` VALUES (100, 207);
INSERT INTO `sys_role_menu` VALUES (100, 300);
INSERT INTO `sys_role_menu` VALUES (100, 301);
INSERT INTO `sys_role_menu` VALUES (100, 302);
INSERT INTO `sys_role_menu` VALUES (100, 303);
INSERT INTO `sys_role_menu` VALUES (100, 304);
INSERT INTO `sys_role_menu` VALUES (100, 305);
INSERT INTO `sys_role_menu` VALUES (100, 306);
INSERT INTO `sys_role_menu` VALUES (100, 1000);
INSERT INTO `sys_role_menu` VALUES (100, 1001);
INSERT INTO `sys_role_menu` VALUES (100, 1002);
INSERT INTO `sys_role_menu` VALUES (100, 1003);
INSERT INTO `sys_role_menu` VALUES (100, 1004);
INSERT INTO `sys_role_menu` VALUES (100, 1005);
INSERT INTO `sys_role_menu` VALUES (100, 1006);
INSERT INTO `sys_role_menu` VALUES (100, 1007);
INSERT INTO `sys_role_menu` VALUES (100, 1008);
INSERT INTO `sys_role_menu` VALUES (100, 1009);
INSERT INTO `sys_role_menu` VALUES (100, 1010);
INSERT INTO `sys_role_menu` VALUES (100, 1011);
INSERT INTO `sys_role_menu` VALUES (100, 1012);
INSERT INTO `sys_role_menu` VALUES (100, 1013);
INSERT INTO `sys_role_menu` VALUES (100, 1014);
INSERT INTO `sys_role_menu` VALUES (100, 1015);
INSERT INTO `sys_role_menu` VALUES (100, 1016);
INSERT INTO `sys_role_menu` VALUES (100, 1017);
INSERT INTO `sys_role_menu` VALUES (100, 1018);
INSERT INTO `sys_role_menu` VALUES (100, 1019);
INSERT INTO `sys_role_menu` VALUES (100, 1020);
INSERT INTO `sys_role_menu` VALUES (100, 1021);
INSERT INTO `sys_role_menu` VALUES (100, 1022);
INSERT INTO `sys_role_menu` VALUES (100, 1023);
INSERT INTO `sys_role_menu` VALUES (100, 1024);
INSERT INTO `sys_role_menu` VALUES (100, 1025);
INSERT INTO `sys_role_menu` VALUES (100, 1026);
INSERT INTO `sys_role_menu` VALUES (100, 1027);
INSERT INTO `sys_role_menu` VALUES (100, 1028);
INSERT INTO `sys_role_menu` VALUES (100, 1029);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户 01健身用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `fitness_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '健身状态（0未开始 1进行中 2暂停）',
  `last_checkin_time` datetime NULL DEFAULT NULL COMMENT '最后打卡时间',
  `gym_id` bigint NULL DEFAULT NULL COMMENT 'SaaS租户-所属场馆ID',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `idx_user_name`(`user_name` ASC) USING BTREE,
  INDEX `idx_dept_id`(`dept_id` ASC) USING BTREE,
  INDEX `idx_gym_id`(`gym_id` ASC) USING BTREE,
  INDEX `idx_gym_id_user_id`(`gym_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_fitness_status`(`fitness_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 203 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (100, 200, 'admin', '超级管理员', '00', 'admin@slimcamp.com', '13888888888', '0', 'https://avatar.com/admin.jpg', '$2a$10$euh/qHx.WTysjW/NYZeyde9ZgVlkiEVRPwtE4scSgUPdOFzgKFnv2', '0', '0', '127.0.0.1', '2025-12-23 10:00:00', '2024-01-01 00:00:00', 'system', '2024-01-01 00:00:00', 'admin', '2025-12-23 10:00:00', '系统管理员账号', '0', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (101, 201, 'area_admin_bj', '北京区域管理员', '00', 'area_bj@slimcamp.com', '19100471675', '0', 'https://avatar.com/user101.jpg', '$2a$10$euh/qHx.WTysjW/NYZeyde9ZgVlkiEVRPwtE4scSgUPdOFzgKFnv2', '0', '0', '192.168.1.100', '2025-12-22 14:30:00', '2024-01-10 09:00:00', 'admin', '2024-01-10 09:00:00', 'admin', '2025-12-22 14:30:00', '北京区域负责人', '0', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (120, 205, 'coach_zhang', '张教练', '00', 'coach_zhang@slimcamp.com', '13500135001', '0', 'https://avatar.com/coach120.jpg', '$2a$10$euh/qHx.WTysjW/NYZeyde9ZgVlkiEVRPwtE4scSgUPdOFzgKFnv2', '0', '0', '192.168.1.120', '2025-12-23 08:30:00', '2024-02-01 10:00:00', 'admin', '2024-02-01 10:00:00', 'admin', '2025-12-23 08:30:00', '瑜伽教练', '1', '2025-12-22 19:00:00', 100, NULL);
INSERT INTO `sys_user` VALUES (121, 205, 'coach_li', '李教练', '00', 'coach_li@slimcamp.com', '13500135002', '1', 'https://avatar.com/coach121.jpg', '$2a$10$euh/qHx.WTysjW/NYZeyde9ZgVlkiEVRPwtE4scSgUPdOFzgKFnv2', '0', '0', '192.168.1.121', '2025-12-23 09:00:00', '2024-02-05 10:00:00', 'admin', '2024-02-05 10:00:00', 'admin', '2025-12-23 09:00:00', '3D运动教练', '1', '2025-12-22 20:00:00', 100, NULL);
INSERT INTO `sys_user` VALUES (122, 205, 'coach_wang', '王教练', '00', 'coach_wang@slimcamp.com', '13500135003', '1', 'https://avatar.com/coach122.jpg', '$2a$10$euh/qHx.WTysjW/NYZeyde9ZgVlkiEVRPwtE4scSgUPdOFzgKFnv2', '0', '0', '192.168.1.122', '2025-12-23 07:30:00', '2024-02-10 10:00:00', 'admin', '2024-02-10 10:00:00', 'admin', '2025-12-23 07:30:00', '冥想教练', '1', '2025-12-22 21:00:00', 100, NULL);
INSERT INTO `sys_user` VALUES (200, 205, 'member_zhao', '赵小美', '01', 'zhao@example.com', '13600136001', '1', 'https://avatar.com/member200.jpg', '$2a$10$euh/qHx.WTysjW/NYZeyde9ZgVlkiEVRPwtE4scSgUPdOFzgKFnv2', '0', '0', '192.168.1.200', '2025-12-22 18:00:00', '2024-03-01 14:00:00', 'admin', '2024-03-01 14:00:00', 'member_zhao', '2025-12-22 18:00:00', 'VIP会员', '1', '2025-12-22 18:30:00', 100, NULL);
INSERT INTO `sys_user` VALUES (201, 205, 'member_qian', '钱大力', '01', 'qian@example.com', '13600136002', '0', 'https://avatar.com/member201.jpg', '$2a$10$euh/qHx.WTysjW/NYZeyde9ZgVlkiEVRPwtE4scSgUPdOFzgKFnv2', '0', '0', '192.168.1.201', '2025-12-22 19:30:00', '2024-03-05 14:00:00', 'admin', '2024-03-05 14:00:00', 'member_qian', '2025-12-22 19:30:00', '普通会员', '1', '2025-12-22 19:45:00', 100, NULL);
INSERT INTO `sys_user` VALUES (202, 205, 'member_sun', '孙娜娜', '01', 'sun@example.com', '13600136003', '1', 'https://avatar.com/member202.jpg', '$2a$10$euh/qHx.WTysjW/NYZeyde9ZgVlkiEVRPwtE4scSgUPdOFzgKFnv2', '0', '0', '192.168.1.202', '2025-12-23 08:00:00', '2024-03-10 14:00:00', 'admin', '2024-03-10 14:00:00', 'member_sun', '2025-12-23 08:00:00', '普通会员', '1', '2025-12-23 08:20:00', 100, NULL);

-- ----------------------------
-- Table structure for sys_user_fitness
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_fitness`;
CREATE TABLE `sys_user_fitness`  (
  `fitness_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '关联sys_user的user_id',
  `height` decimal(5, 2) NULL DEFAULT NULL COMMENT '身高（cm）',
  `target_weight` decimal(5, 2) NULL DEFAULT NULL COMMENT '目标体重（kg）',
  `current_weight` decimal(5, 2) NULL DEFAULT NULL COMMENT '当前体重（kg）',
  `body_fat_rate` decimal(4, 2) NULL DEFAULT NULL COMMENT '体脂率（%）',
  `waistline` decimal(5, 2) NULL DEFAULT NULL COMMENT '腰围（cm）',
  `fitness_preference` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '运动偏好（3D运动,冥想,趣味游戏）',
  `diet_taboo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '饮食禁忌（海鲜,辛辣,甜食）',
  `sleep_quality` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '睡眠质量（0一般 1良好 2较差）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（0未删除 1已删除）',
  PRIMARY KEY (`fitness_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_body_fat_rate`(`body_fat_rate` ASC) USING BTREE,
  INDEX `idx_fitness_preference`(`fitness_preference` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户健身扩展表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_fitness
-- ----------------------------
INSERT INTO `sys_user_fitness` VALUES (100, 200, 165.00, 52.00, 54.00, 24.00, 70.00, '3D运动,瑜伽课程,冥想课程', '辛辣,海鲜', '1', 'member_zhao', '2024-03-01 14:30:00', 'member_zhao', '2025-12-22 18:00:00', 0);
INSERT INTO `sys_user_fitness` VALUES (101, 201, 178.00, 75.00, 76.00, 20.00, 83.00, '3D运动,普拉提课程', '甜食', '0', 'member_qian', '2024-03-05 14:30:00', 'member_qian', '2025-12-22 19:30:00', 0);
INSERT INTO `sys_user_fitness` VALUES (102, 202, 168.00, 55.00, 56.00, 22.50, 66.00, '瑜伽课程,冥想课程', '辛辣', '1', 'member_sun', '2024-03-10 14:30:00', 'member_sun', '2025-12-23 08:00:00', 0);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (100, 100);
INSERT INTO `sys_user_post` VALUES (101, 101);
INSERT INTO `sys_user_post` VALUES (120, 103);
INSERT INTO `sys_user_post` VALUES (121, 105);
INSERT INTO `sys_user_post` VALUES (122, 106);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (100, 100);
INSERT INTO `sys_user_role` VALUES (101, 101);
INSERT INTO `sys_user_role` VALUES (120, 103);
INSERT INTO `sys_user_role` VALUES (121, 103);
INSERT INTO `sys_user_role` VALUES (122, 103);
INSERT INTO `sys_user_role` VALUES (200, 106);
INSERT INTO `sys_user_role` VALUES (201, 105);
INSERT INTO `sys_user_role` VALUES (202, 105);

SET FOREIGN_KEY_CHECKS = 1;
