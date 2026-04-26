-- 1. 书籍信息表（主表）
CREATE TABLE book
(
    book_id     BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '书籍ID',
    book_name   VARCHAR(100)       NOT NULL COMMENT '书籍名称',
    author      VARCHAR(50) COMMENT '作者',
    isbn        VARCHAR(20) UNIQUE NOT NULL COMMENT 'ISBN编号',
    category    VARCHAR(20) COMMENT '书籍分类',
    stock       INT                NOT NULL DEFAULT 0 COMMENT '库存数量',
    cover_img   VARCHAR(255) COMMENT '书籍封面图片地址',
    create_time DATETIME                    DEFAULT NOW() COMMENT '创建时间',
    update_time DATETIME                    DEFAULT NOW() COMMENT '更新时间'
) COMMENT ='书籍信息表';

-- 2. 借阅记录表（主表）
CREATE TABLE borrow_record
(
    record_id        BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '借阅记录ID',
    user_id          BIGINT      NOT NULL COMMENT '借阅人ID',
    user_name        VARCHAR(50) NOT NULL COMMENT '借阅人姓名',
    borrow_time      DATETIME COMMENT '借阅时间',
    plan_return_time DATETIME COMMENT '预计归还时间',
    return_time      DATETIME COMMENT '实际归还时间',
    status           CHAR(2)  DEFAULT '0' COMMENT '借阅状态 0=待借阅 1=已借出 2=已归还 3=逾期',
    create_time      DATETIME DEFAULT NOW() COMMENT '创建时间',
    update_time      DATETIME DEFAULT NOW() COMMENT '更新时间'
) COMMENT ='借阅记录表';

-- 3. 借阅子表（书籍-记录关联表）
CREATE TABLE borrow_item
(
    item_id   BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '明细ID',
    record_id BIGINT       NOT NULL COMMENT '借阅记录ID',
    book_id   BIGINT       NOT NULL COMMENT '书籍ID',
    book_name VARCHAR(100) NOT NULL COMMENT '书籍名称',
    CONSTRAINT fk_record FOREIGN KEY (record_id) REFERENCES borrow_record (record_id),
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES book (book_id)
) COMMENT ='借阅明细子表';

-- 4. 操作日志表（若依自带，无需新建）
-- 5. 用户表、角色表（若依自带，无需新建）
-- 菜单 SQL

-- 书籍信息菜单
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('书籍信息', '0', '1', 'book', 'book/detail/index', 1, 0, 'C', '0', '0', 'book:detail:list', '#', 'admin',
        sysdate(),
        '', null, '书籍信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('书籍信息查询', @parentId, '1', '#', '', 1, 0, 'F', '0', '0', 'book:detail:query', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('书籍信息新增', @parentId, '2', '#', '', 1, 0, 'F', '0', '0', 'book:detail:add', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('书籍信息修改', @parentId, '3', '#', '', 1, 0, 'F', '0', '0', 'book:detail:edit', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('书籍信息删除', @parentId, '4', '#', '', 1, 0, 'F', '0', '0', 'book:detail:remove', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('书籍信息导出', @parentId, '5', '#', '', 1, 0, 'F', '0', '0', 'book:detail:export', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('书籍信息导入', @parentId, '6', '#', '', 1, 0, 'F', '0', '0', 'book:detail:import', '#', 'admin', sysdate(), '',
        null, '');

-- 借阅明细菜单
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅明细', '2000', '1', 'item', 'book/item/index', 1, 0, 'C', '0', '0', 'book:item:list', '#', 'admin',
        sysdate(), '', null, '借阅明细菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅明细查询', @parentId, '1', '#', '', 1, 0, 'F', '0', '0', 'book:item:query', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅明细新增', @parentId, '2', '#', '', 1, 0, 'F', '0', '0', 'book:item:add', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅明细修改', @parentId, '3', '#', '', 1, 0, 'F', '0', '0', 'book:item:edit', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅明细删除', @parentId, '4', '#', '', 1, 0, 'F', '0', '0', 'book:item:remove', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅明细导出', @parentId, '5', '#', '', 1, 0, 'F', '0', '0', 'book:item:export', '#', 'admin', sysdate(), '',
        null, '');

-- 借阅记录菜单
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅记录', '2000', '2', 'record', 'book/record/index', 1, 0, 'C', '0', '0', 'book:record:list', '#', 'admin',
        sysdate(), '', null, '借阅记录菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅记录查询', @parentId, '1', '#', '', 1, 0, 'F', '0', '0', 'book:record:query', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅记录新增', @parentId, '2', '#', '', 1, 0, 'F', '0', '0', 'book:record:add', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅记录修改', @parentId, '3', '#', '', 1, 0, 'F', '0', '0', 'book:record:edit', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅记录删除', @parentId, '4', '#', '', 1, 0, 'F', '0', '0', 'book:record:remove', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅记录导出', @parentId, '5', '#', '', 1, 0, 'F', '0', '0', 'book:record:export', '#', 'admin', sysdate(), '',
        null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status,
                      perms, icon, create_by, create_time, update_by, update_time, remark)
values ('借阅记录导入', @parentId, '6', '#', '', 1, 0, 'F', '0', '0', 'book:record:import', '#', 'admin', sysdate(), '',
        null, '');

-- 模拟数据

-- 书籍数据
INSERT INTO book (book_name, author, isbn, category, stock, cover_img, create_time, update_time)
VALUES ('昆仑约定', '毕淑敏', '9787020191635', '小说', 50,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d8d~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('海燕', '姚鄂梅', '9787020192335', '小说', 30,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d8e~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('咸的玩笑', '刘震云', '9787020197620', '小说', 40,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d8f~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('紫山', '孙惠芬', '9787020192113', '小说', 25,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d90~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('好天气', '苏童', '9787559495303', '小说', 35,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d91~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('换梅', '曹乃谦', '9787572621772', '小说', 15,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d92~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('蛋镇诗社', '朱山坡', '9787574905559', '小说', 22,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d93~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('桃花坞', '王尧', '9787506399999', '小说', 18,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d94~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('垦荒', '董立勃', '9787020196999', '小说', 28,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d95~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('人鱼之间', '张天翼', '9787020189690', '小说', 32,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d96~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('白象', '班宇', '9787559495310', '小说', 20,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d97~tplv-a9rns2rl98-image.png',
        NOW(), NOW()),
       ('飞行汽车百科全书', '交通运输部科学研究院', '9787520219631', '百科', 10,
        'https://p3-flow-imagex-sign.byteimg.com/ocean-cloud-tos/3b028f8d8d8b40519d0d8d8d8d8d8d98~tplv-a9rns2rl98-image.png',
        NOW(), NOW());

-- 借阅记录数据
INSERT INTO borrow_record (user_id, user_name, borrow_time, plan_return_time, return_time, status, create_time,
                           update_time)
VALUES (1001, '张三', '2026-03-01 10:00:00', '2026-03-15 10:00:00', '2026-03-12 14:30:00', '2', NOW(), NOW()),
       (1002, '李四', '2026-03-05 09:15:00', '2026-03-19 09:15:00', NULL, '1', NOW(), NOW()),
       (1003, '王五', '2026-02-20 14:00:00', '2026-03-06 14:00:00', '2026-03-08 10:00:00', '3', NOW(), NOW()),
       (1004, '赵六', '2026-03-10 11:30:00', '2026-03-24 11:30:00', NULL, '1', NOW(), NOW()),
       (1005, '孙七', '2026-02-15 08:45:00', '2026-03-01 08:45:00', '2026-02-28 16:20:00', '2', NOW(), NOW()),
       (1006, '周八', '2026-03-08 15:00:00', '2026-03-22 15:00:00', NULL, '1', NOW(), NOW()),
       (1007, '吴九', '2026-01-25 10:30:00', '2026-02-08 10:30:00', '2026-02-10 09:00:00', '3', NOW(), NOW()),
       (1008, '郑十', '2026-03-12 13:45:00', '2026-03-26 13:45:00', NULL, '1', NOW(), NOW()),
       (1009, '刘一', '2026-02-28 09:00:00', '2026-03-14 09:00:00', '2026-03-14 08:50:00', '2', NOW(), NOW()),
       (1010, '陈二', '2026-03-15 16:00:00', '2026-03-29 16:00:00', NULL, '1', NOW(), NOW()),
       (1011, '杨三', '2026-03-02 11:00:00', '2026-03-16 11:00:00', '2026-03-15 15:30:00', '2', NOW(), NOW()),
       (1012, '黄四', '2026-03-18 10:15:00', '2026-04-01 10:15:00', NULL, '0', NOW(), NOW());

-- 借阅明细数据
INSERT INTO borrow_item (record_id, book_id, book_name)
VALUES (1, 1, '昆仑约定'),
       (1, 2, '海燕'),
       (2, 3, '咸的玩笑'),
       (2, 11, '白象'),
       (3, 4, '紫山'),
       (4, 5, '好天气'),
       (4, 6, '换梅'),
       (4, 7, '蛋镇诗社'),
       (5, 8, '桃花坞'),
       (6, 9, '垦荒'),
       (6, 10, '人鱼之间'),
       (7, 1, '昆仑约定'),
       (8, 2, '海燕'),
       (8, 6, '咸的玩笑'),
       (9, 12, '飞行汽车百科全书'),
       (10, 4, '紫山'),
       (10, 7, '好天气'),
       (11, 6, '换梅'),
       (12, 7, '蛋镇诗社'),
       (12, 8, '桃花坞');