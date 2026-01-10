
create table dept (
  id int unsigned PRIMARY KEY AUTO_INCREMENT COMMENT 'ID, 主键',
  name varchar(10) NOT NULL UNIQUE COMMENT '部门名称',
  create_time datetime COMMENT '创建时间',
  update_time datetime COMMENT '修改时间'
) COMMENT '部门表';

INSERT INTO dept VALUES (1,'学工部','2023-09-25 09:47:40','2024-07-25 09:47:40'),
                        (2,'教研部','2023-09-25 09:47:40','2024-08-09 15:17:04'),
                        (3,'咨询部','2023-09-25 09:47:40','2024-07-30 21:26:24'),
                        (4,'就业部','2023-09-25 09:47:40','2024-07-25 09:47:40'),
                        (5,'人事部','2023-09-25 09:47:40','2024-07-25 09:47:40'),
                        (6,'行政部','2023-11-30 20:56:37','2024-07-30 20:56:37');
create table emp(
    id int unsigned primary key auto_increment comment 'ID,主键',
    username varchar(20) not null unique comment '用户名',
    password varchar(50) default '123456' comment '密码',
    name varchar(10) not null comment '姓名',
    gender tinyint unsigned not null comment '性别, 1:男, 2:女',
    phone char(11) not null unique comment '手机号',
    job tinyint unsigned comment '职位, 1 班主任, 2 讲师 , 3 学工主管, 4 教研主管, 5 咨询师',
    salary int unsigned comment '薪资',
    image varchar(300) comment '头像',
    entry_date date comment '入职日期',
    dept_id int unsigned comment '部门ID',
    create_time datetime comment '创建时间',
    update_time datetime comment '修改时间'
) comment '员工表';


INSERT INTO emp VALUES 
    (1,'shinaian','123456','施耐庵',1,'13309090001',4,15000,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2000-01-01',2,'2023-10-20 16:35:33','2023-11-16 16:11:26'),
    (2,'songjiang','123456','宋江',1,'13309090002',2,8600,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2015-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:35:37'),
    (3,'lujunyi','123456','卢俊义',1,'13309090003',2,8900,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2008-05-01',2,'2023-10-20 16:35:33','2023-10-20 16:35:39'),
    (4,'wuyong','123456','吴用',1,'13309090004',2,9200,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2007-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:35:41'),
    (5,'gongsunsheng','123456','公孙胜',1,'13309090005',2,9500,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2012-12-05',2,'2023-10-20 16:35:33','2023-10-20 16:35:43'),
    (6,'huosanniang','123456','扈三娘',2,'13309090006',3,6500,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2013-09-05',1,'2023-10-20 16:35:33','2023-10-20 16:35:45'),
    (7,'chaijin','123456','柴进',1,'13309090007',1,4700,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2005-08-01',1,'2023-10-20 16:35:33','2023-10-20 16:35:47'),
    (8,'likui','123456','李逵',1,'13309090008',1,4800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2014-11-09',1,'2023-10-20 16:35:33','2023-10-20 16:35:49'),
    (9,'wusong','123456','武松',1,'13309090009',1,4900,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2011-03-11',1,'2023-10-20 16:35:33','2023-10-20 16:35:51'),
    (10,'linchong','123456','林冲',1,'13309090010',1,5000,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2013-09-05',1,'2023-10-20 16:35:33','2023-10-20 16:35:53'),
    (11,'huyanzhuo','123456','呼延灼',1,'13309090011',2,9700,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2007-02-01',2,'2023-10-20 16:35:33','2023-10-20 16:35:55'),
    (12,'xiaoliguang','123456','小李广',1,'13309090012',2,10000,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2008-08-18',2,'2023-10-20 16:35:33','2023-10-20 16:35:57'),
    (13,'yangzhi','123456','杨志',1,'13309090013',1,5300,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2012-11-01',1,'2023-10-20 16:35:33','2023-10-20 16:35:59'),
    (14,'shijin','123456','史进',1,'13309090014',2,10600,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2002-08-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:01'),
    (15,'sunerniang','123456','孙二娘',2,'13309090015',2,10900,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2011-05-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:03'),
    (16,'luzhishen','123456','鲁智深',1,'13309090016',2,9600,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2010-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:05'),
    (17,'liying','12345678','李应',1,'13309090017',1,5800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2015-03-21',1,'2023-10-20 16:35:33','2023-10-20 16:36:07'),
    (18,'shiqian','123456','时迁',1,'13309090018',2,10200,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2015-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:09'),
    (19,'gudasao','123456','顾大嫂',2,'13309090019',2,10500,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2008-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:11'),
    (20,'ruanxiaoer','123456','阮小二',1,'13309090020',2,10800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2018-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:13'),
    (21,'ruanxiaowu','123456','阮小五',1,'13309090021',5,5200,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2015-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:15'),
    (22,'ruanxiaoqi','123456','阮小七',1,'13309090022',5,5500,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2016-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:17'),
    (23,'ruanji','123456','阮籍',1,'13309090023',5,5800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2012-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:19'),
    (24,'tongwei','123456','童威',1,'13309090024',5,5000,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2006-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:21'),
    (25,'tongmeng','123456','童猛',1,'13309090025',5,4800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2002-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:23'),
    (26,'yanshun','123456','燕顺',1,'13309090026',5,5400,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2011-01-01',3,'2023-10-20 16:35:33','2023-11-08 22:12:46'),
    (27,'lijun','123456','李俊',1,'13309090027',2,6600,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2004-01-01',2,'2023-10-20 16:35:33','2023-11-16 17:56:59'),
    (28,'lizhong','123456','李忠',1,'13309090028',5,5000,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2007-01-01',3,'2023-10-20 16:35:33','2023-11-17 16:34:22'),
    (30,'liyun','123456','李云',1,'13309090030',NULL,NULL,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2020-03-01',NULL,'2023-10-20 16:35:33','2023-10-20 16:36:31'),
    (36,'linghuchong','123456','令狐冲',1,'18809091212',2,6800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2023-10-19',2,'2023-10-20 20:44:54','2023-11-09 09:41:04');
    

create table emp_expr(
    id int unsigned primary key auto_increment comment 'ID, 主键',
    emp_id int unsigned comment '员工ID',
    begin date comment '开始时间',
    end  date comment '结束时间',
    company varchar(50) comment '公司名称',
    job varchar(50) comment '职位'
)comment '工作经历';



create table emp_log(
    id int unsigned primary key auto_increment comment 'ID, 主键',
    operate_time datetime comment '操作时间',
    info varchar(2000) comment '日志信息'
) comment '员工日志表';



DROP TABLE IF EXISTS `clazz`;
CREATE TABLE `clazz` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) NOT NULL COMMENT '班级名称',
  `room` varchar(20) DEFAULT NULL COMMENT '班级教室',
  `begin_date` date NOT NULL COMMENT '开课时间',
  `end_date` date NOT NULL COMMENT '结课时间',
  `master_id` int(11) DEFAULT NULL COMMENT '班主任ID (关联emp表)',
  `subject` tinyint(4) NOT NULL COMMENT '学科 (1:Java, 2:前端, 3:大数据, 4:Python)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班级信息表';


DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `no` varchar(20) DEFAULT NULL COMMENT '学号',
  `gender` tinyint(3) unsigned DEFAULT NULL COMMENT '性别 (1:男, 2:女)',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `id_card` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `is_college` tinyint(3) unsigned DEFAULT NULL COMMENT '是否来自于院校 (1:是, 0:否)',
  `address` varchar(200) DEFAULT NULL COMMENT '联系地址',
  `degree` tinyint(3) unsigned DEFAULT NULL COMMENT '最高学历 (1:初中, 2:高中, 3:大专, 4:本科, 5:硕士, 6:博士)',
  `graduation_date` date DEFAULT NULL COMMENT '毕业时间',
  `clazz_id` int(11) DEFAULT NULL COMMENT '班级ID (关联clazz表)',
  `violation_count` smallint(5) unsigned DEFAULT '0' COMMENT '违纪次数',
  `violation_score` smallint(5) unsigned DEFAULT '0' COMMENT '违纪扣分',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学员信息表';

INSERT INTO clazz (id, name, room, begin_date, end_date, master_id, subject, create_time, update_time) VALUES
(1, 'JavaEE就业166期', '101', '2023-05-01', '2023-11-01', 7, 1, NOW(), NOW()),
(2, 'JavaEE就业167期', '102', '2023-06-15', '2023-12-15', 8, 1, NOW(), NOW()),
(3, 'JavaEE就业168期', '103', '2023-11-01', '2024-05-01', 9, 1, NOW(), NOW()),
(4, '前端就业88期', '201', '2023-07-01', '2023-12-30', 10, 2, NOW(), NOW()),
(5, '前端就业89期', '202', '2023-09-01', '2024-02-28', 13, 2, NOW(), NOW()),
(6, '大数据就业40期', '301', '2023-08-01', '2024-02-01', 17, 3, NOW(), NOW()),
(7, 'Python就业25期', '302', '2023-10-01', '2024-03-01', 7, 4, NOW(), NOW()),
(8, 'JavaEE就业169期', '104', '2024-01-01', '2024-07-01', 8, 1, NOW(), NOW()),
(9, '前端就业90期', '203', '2024-02-15', '2024-08-15', 9, 2, NOW(), NOW()),
(10, '大数据就业41期', '303', '2024-03-01', '2024-09-01', 10, 3, NOW(), NOW());

INSERT INTO student (name, no, gender, phone, id_card, is_college, address, degree, graduation_date, clazz_id, violation_count, violation_score, create_time, update_time) VALUES
-- 班级1 (5人)
('赵一', 'S001', 1, '13800138001', '11010120000101001X', 1, '北京市海淀区', 4, '2022-06-30', 1, 0, 0, NOW(), NOW()),
('钱二', 'S002', 2, '13800138002', '11010120000101002X', 1, '上海市浦东新区', 4, '2022-06-30', 1, 0, 0, NOW(), NOW()),
('孙三', 'S003', 1, '13800138003', '11010120000101003X', 0, '广州市天河区', 3, '2021-06-30', 1, 1, 2, NOW(), NOW()),
('李四', 'S004', 1, '13800138004', '11010120000101004X', 1, '深圳市南山区', 5, '2023-06-30', 1, 0, 0, NOW(), NOW()),
('周五', 'S005', 2, '13800138005', '11010120000101005X', 1, '杭州市西湖区', 4, '2022-06-30', 1, 0, 0, NOW(), NOW()),

-- 班级2 (4人)
('吴六', 'S006', 1, '13800138006', '11010120000101006X', 1, '南京市鼓楼区', 4, '2022-06-30', 2, 0, 0, NOW(), NOW()),
('郑七', 'S007', 2, '13800138007', '11010120000101007X', 1, '武汉市洪山区', 3, '2021-06-30', 2, 0, 0, NOW(), NOW()),
('王八', 'S008', 1, '13800138008', '11010120000101008X', 0, '成都市武侯区', 2, '2020-06-30', 2, 2, 5, NOW(), NOW()),
('冯九', 'S009', 1, '13800138009', '11010120000101009X', 1, '西安市雁塔区', 4, '2023-06-30', 2, 0, 0, NOW(), NOW()),

-- 班级3 (3人)
('陈十', 'S010', 2, '13800138010', '11010120000101010X', 1, '重庆市渝北区', 4, '2022-06-30', 3, 0, 0, NOW(), NOW()),
('褚十一', 'S011', 1, '13800138011', '11010120000101011X', 1, '郑州市金水区', 5, '2023-06-30', 3, 0, 0, NOW(), NOW()),
('卫十二', 'S012', 1, '13800138012', '11010120000101012X', 1, '长沙市岳麓区', 4, '2022-06-30', 3, 0, 0, NOW(), NOW()),

-- 班级4 (5人)
('蒋十三', 'S013', 2, '13800138013', '11010120000101013X', 1, '苏州市姑苏区', 3, '2021-06-30', 4, 0, 0, NOW(), NOW()),
('沈十四', 'S014', 1, '13800138014', '11010120000101014X', 1, '天津市南开区', 4, '2022-06-30', 4, 0, 0, NOW(), NOW()),
('韩十五', 'S015', 1, '13800138015', '11010120000101015X', 0, '合肥市蜀山区', 2, '2020-06-30', 4, 1, 2, NOW(), NOW()),
('杨十六', 'S016', 2, '13800138016', '11010120000101016X', 1, '青岛市市南区', 4, '2023-06-30', 4, 0, 0, NOW(), NOW()),
('朱十七', 'S017', 1, '13800138017', '11010120000101017X', 1, '宁波市海曙区', 5, '2022-06-30', 4, 0, 0, NOW(), NOW()),

-- 班级5 (2人)
('秦十八', 'S018', 1, '13800138018', '11010120000101018X', 1, '无锡市滨湖区', 4, '2022-06-30', 5, 0, 0, NOW(), NOW()),
('尤十九', 'S019', 2, '13800138019', '11010120000101019X', 1, '大连市中山区', 3, '2021-06-30', 5, 0, 0, NOW(), NOW()),

-- 班级6 (6人)
('许二十', 'S020', 1, '13800138020', '11010120000101020X', 1, '厦门市思明区', 4, '2022-06-30', 6, 0, 0, NOW(), NOW()),
('何二一', 'S021', 1, '13800138021', '11010120000101021X', 1, '沈阳市和平区', 5, '2023-06-30', 6, 0, 0, NOW(), NOW()),
('吕二二', 'S022', 2, '13800138022', '11010120000101022X', 0, '哈尔滨市南岗区', 3, '2021-06-30', 6, 0, 0, NOW(), NOW()),
('施二三', 'S023', 1, '13800138023', '11010120000101023X', 1, '长春市朝阳区', 4, '2022-06-30', 6, 0, 0, NOW(), NOW()),
('张二四', 'S024', 1, '13800138024', '11010120000101024X', 1, '济南市历下区', 4, '2022-06-30', 6, 0, 0, NOW(), NOW()),
('孔二五', 'S025', 2, '13800138025', '11010120000101025X', 1, '石家庄市裕华区', 3, '2021-06-30', 6, 0, 0, NOW(), NOW()),

-- 班级7 (3人)
('曹二六', 'S026', 1, '13800138026', '11010120000101026X', 1, '福州市鼓楼区', 4, '2022-06-30', 7, 0, 0, NOW(), NOW()),
('严二七', 'S027', 1, '13800138027', '11010120000101027X', 1, '南宁市青秀区', 4, '2022-06-30', 7, 0, 0, NOW(), NOW()),
('华二八', 'S028', 2, '13800138028', '11010120000101028X', 1, '昆明市盘龙区', 3, '2021-06-30', 7, 3, 5, NOW(), NOW()),

-- 班级8 (4人)
('金二九', 'S029', 1, '13800138029', '11010120000101029X', 1, '太原市迎泽区', 4, '2022-06-30', 8, 0, 0, NOW(), NOW()),
('魏三十', 'S030', 2, '13800138030', '11010120000101030X', 1, '南昌市东湖区', 5, '2023-06-30', 8, 0, 0, NOW(), NOW()),
('陶三一', 'S031', 1, '13800138031', '11010120000101031X', 1, '贵阳市南明区', 4, '2022-06-30', 8, 0, 0, NOW(), NOW()),
('姜三二', 'S032', 1, '13800138032', '11010120000101032X', 0, '乌鲁木齐天山区', 2, '2020-06-30', 8, 0, 0, NOW(), NOW()),

-- 班级9 (1人)
('戚三三', 'S033', 1, '13800138033', '11010120000101033X', 1, '兰州市城关区', 4, '2022-06-30', 9, 0, 0, NOW(), NOW()),

-- 班级10 (2人)
('谢三四', 'S034', 2, '13800138034', '11010120000101034X', 1, '呼和浩特赛罕区', 3, '2021-06-30', 10, 0, 0, NOW(), NOW()),
('邹三五', 'S035', 1, '13800138035', '11010120000101035X', 1, '银川市兴庆区', 4, '2022-06-30', 10, 0, 0, NOW(), NOW());

-- 操作日志表
create table operate_log(
id int unsigned primary key auto_increment comment 'ID',
operate_emp_id int unsigned comment '操作人ID',
operate_time datetime comment '操作时间',
class_name varchar(100) comment '操作的类名',
method_name varchar(100) comment '操作的方法名',
method_params varchar(1000) comment '方法参数',
return_value varchar(2000) comment '返回值, 存储json格式',
cost_time int comment '方法执行耗时, 单位:ms'
) comment '操作日志表';