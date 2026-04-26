# -- AI对话功能菜单和权限配置SQL
#
# -- 插入AI对话主菜单
# INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# VALUES ('AI对话', 0, 10, 'ai', 'system/ai/index', 1, 0, 'C', '0', '0', 'system:ai:view', 'chat', 'admin', NOW(), '', NULL, 'AI对话管理');
#
# -- 获取刚插入的菜单ID（需要根据实际情况调整）
# SET @ai_menu_id = LAST_INSERT_ID();
#
# -- 插入发送消息权限按钮
# INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# VALUES ('发送消息', @ai_menu_id, 1, '#', '', 1, 0, 'F', '0', '0', 'system:ai:send', '#', 'admin', NOW(), '', NULL, '');
#
# -- 插入清除聊天记录权限按钮
# INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# VALUES ('清除记录', @ai_menu_id, 2, '#', '', 1, 0, 'F', '0', '0', 'system:ai:clear', '#', 'admin', NOW(), '', NULL, '');
#
# -- 为管理员角色分配AI对话菜单权限（假设管理员角色ID为1）
# INSERT INTO sys_role_menu (role_id, menu_id)
# SELECT 1, menu_id FROM sys_menu WHERE perms LIKE 'system:ai:%' OR menu_name = 'AI对话';
#
# -- 提交事务
# COMMIT;
