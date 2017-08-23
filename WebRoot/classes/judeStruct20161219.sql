
DROP TABLE IF EXISTS `t_address`;
-- 地区信息表
CREATE TABLE `t_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `fullId` varchar(20) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL,
  `underlingFlag` int(11) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3520 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_certification`;
-- 实名认证表
CREATE TABLE `t_certification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT '平台用户',
  `idcard` varchar(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_commodity_type`;
-- 商品分类表
CREATE TABLE `t_commodity_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `typeName` varchar(30) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_dlb_account`;
-- 聚财宝账户
CREATE TABLE `t_dlb_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountNo` varchar(30) DEFAULT NULL,
  `accountBalance` double(9,2) DEFAULT NULL,
  `totalPlatformIncomings` double(9,2) DEFAULT NULL,	--	累计收入（奖励）
  `totalPlatformOutgoings` double(9,2) DEFAULT NULL,	--	累计支出（消费）
  `totalUserIncomings` double(9,2) DEFAULT NULL,	--	累计转入（用户转入）
  `totalUserOutgoings` double(9,2) DEFAULT NULL,	--  累计转出（用户转出->提现）
  `totalReturnCash` double(9,2) DEFAULT '0.00',		--  当前得利宝累计返还额
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_dlb_account_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_dlb_record`;
-- 聚财宝记录表
CREATE TABLE `t_dlb_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation` int(11) DEFAULT NULL,		-- 操作类型（0转入,1转出）
  `operateTime` datetime DEFAULT NULL,		-- 操作时间
  `operateNum` double DEFAULT NULL,		-- 数量
  `operateDesc` varchar(30) DEFAULT NULL,	-- 描述信息
  `accountId` int(11) DEFAULT NULL,		-- 对应Account
  `operateObjId` int(11) DEFAULT NULL,		-- 操作对象
  PRIMARY KEY (`id`),
  KEY `accountId` (`accountId`),
  KEY `operateObjId` (`operateObjId`),
  CONSTRAINT `t_dlb_record_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `t_dlb_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_indent`;
-- 线下单据表
CREATE TABLE `t_indent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `indentNo` varchar(20) DEFAULT NULL,
  `flag` int(11) DEFAULT '0',		--  是否使用  0未使用  1已使用
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6010 DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `t_jf_account`;
-- 积分账户表
CREATE TABLE `t_jf_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountNo` varchar(30) DEFAULT NULL,		--	帐号
  `accountBalance` double(9,2) DEFAULT NULL,	--	余额
  `totalPlatformIncomings` double(9,2) DEFAULT NULL,	--	平台累计收入（奖励）
  `totalPlatformOutgoings` double(9,2) DEFAULT NULL,	--	平台累计支出（消费）
  `totalUserIncomings` double(9,2) DEFAULT NULL,	--	用户累计转入（用户转入）
  `totalUserOutgoings` double(9,2) DEFAULT NULL,	--  用户累计转出（用户转出->提现）
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_jf_account_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_jf_record`;
-- 积分记录表
CREATE TABLE `t_jf_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation` int(11) DEFAULT NULL,		-- 操作类型（0转入,1转出）
  `operateTime` datetime DEFAULT NULL,		-- 操作时间
  `operateNum` double DEFAULT NULL,		 -- 数量
  `operateDesc` varchar(30) DEFAULT NULL,	-- 描述信息
  `accountId` int(11) DEFAULT NULL,		-- 对应Account
  `operateObjId` int(11) DEFAULT NULL,		-- 操作对象
  PRIMARY KEY (`id`),	
  KEY `accountId` (`accountId`),
  KEY `operateObjId` (`operateObjId`),
  CONSTRAINT `t_jf_record_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `t_jf_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=678 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_journal_book`;
-- 线下保单表
CREATE TABLE `t_journal_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `indentId` int(11) DEFAULT NULL,			-- 订单号  由平台下发单据生成
  `businessId` int(11) DEFAULT NULL,			-- 商户id
  `clientId` int(11) DEFAULT NULL,			-- 客户id
  `rewardId` int(11) DEFAULT NULL,			-- 奖励用户id
  `commodityTypeId` int(11) DEFAULT NULL,		--	商品类型
  `commodityName` varchar(50) DEFAULT NULL,		-- 商品名称
  `amount` double DEFAULT NULL,				-- 交易金额
  `premiumRates` float(4,2) DEFAULT NULL,		--  优惠率
  `giftJf` float(9,1) DEFAULT NULL,			--  获赠积分(用户)
  `rewardJf` float(9,1) DEFAULT NULL,			--	奖励积分(商家)
  `journalTime` datetime DEFAULT NULL,			-- 报单时间
  `flag` int(11) DEFAULT '1',				-- 是否处理  0未审核  1通过审核但未处理 2通过审核且已处理  3未通过审核
  PRIMARY KEY (`id`),
  KEY `commodityTypeId` (`commodityTypeId`),
  KEY `rewardId` (`rewardId`),
  KEY `businessId` (`businessId`),
  KEY `clientId` (`clientId`),
  KEY `indentId` (`indentId`),
  CONSTRAINT `t_journal_book_ibfk_1` FOREIGN KEY (`commodityTypeId`) REFERENCES `t_commodity_type` (`id`),
  CONSTRAINT `t_journal_book_ibfk_2` FOREIGN KEY (`rewardId`) REFERENCES `t_user` (`id`),
  CONSTRAINT `t_journal_book_ibfk_3` FOREIGN KEY (`businessId`) REFERENCES `t_user` (`id`),
  CONSTRAINT `t_journal_book_ibfk_4` FOREIGN KEY (`clientId`) REFERENCES `t_user` (`id`),
  CONSTRAINT `t_journal_book_ibfk_5` FOREIGN KEY (`indentId`) REFERENCES `t_indent` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_money_account`;
-- 现金账户表
CREATE TABLE `t_money_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountNo` varchar(30) DEFAULT NULL,
  `accountBalance` double(9,2) DEFAULT NULL,
  `totalPlatformIncomings` double(9,2) DEFAULT NULL,	--	累计收入（奖励）
  `totalPlatformOutgoings` double(9,2) DEFAULT NULL,	--	累计支出（消费）
  `totalUserIncomings` double(9,2) DEFAULT NULL,	--	累计转入（用户转入）
  `totalUserOutgoings` double(9,2) DEFAULT NULL,	--  累计转出（用户转出->提现）
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_money_account_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_money_record`;
-- 现金账户记录表
CREATE TABLE `t_money_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation` int(11) DEFAULT NULL,		-- 操作类型（0转入,1转出）
  `operateTime` datetime DEFAULT NULL,		 -- 操作时间
  `operateNum` double DEFAULT NULL,		-- 数量
  `operateDesc` varchar(30) DEFAULT NULL,	-- 描述信息
  `accountId` int(11) DEFAULT NULL,		-- 对应Account
  `operateObjId` int(11) DEFAULT NULL,		-- 操作对象
  PRIMARY KEY (`id`),
  KEY `accountId` (`accountId`),
  KEY `operateObjId` (`operateObjId`),
  CONSTRAINT `t_money_record_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `t_money_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2744 DEFAULT CHARSET=utf8;





DROP TABLE IF EXISTS `t_operation`;

CREATE TABLE `t_operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(33) DEFAULT NULL,
  `url` varchar(256) DEFAULT NULL,
  `imgUrl` varchar(33) DEFAULT NULL,    --	 菜单图标
  `style` varchar(33) DEFAULT NULL,	-- 显示样式
  `seqnum` int(11) DEFAULT NULL,	--  序号（用于显示排号）
  `isMenu` int(11) DEFAULT NULL,	--	是否作为左栏菜单显示
  `parentId` int(11) DEFAULT NULL,	--	父菜单ID
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `t_operation_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `t_operation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_para_config`;
-- 参数信息表
CREATE TABLE `t_para_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cashRatio` float(5,2) DEFAULT NULL,		-- 现金返还比例
  `yljRatio` float(5,2) DEFAULT NULL,		-- 养老金返还比例
  `totalReCash` float(9,2) DEFAULT NULL,	-- 每日返还总额
  `cashByOneDlb` float(5,2) DEFAULT NULL,	-- 每日每个聚财宝返还金额
  `vipJfRatio` float(5,2) DEFAULT NULL,		--  会员积分获得比例
  `busJfRatio` float(5,2) DEFAULT NULL,		 --  商家积分获得比例
  `oneDlbTotalIncom` float(9,2) DEFAULT NULL,	 -- 得利宝收入上限
  `checkLimitAmount` float(9,2) DEFAULT NULL,	-- 报单审核上限阈值
  `beginTime` datetime DEFAULT NULL,		-- 启用时间
  `endTime` datetime DEFAULT NULL,		-- 停用时间
  `flag` int(11) DEFAULT '0',			 -- 启用标志  0为启用，1为停用 只能有一条记录为0
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `t_permission`;

CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(33) NOT NULL,
  `operationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `operationId` (`operationId`),
  CONSTRAINT `t_permission_ibfk_1` FOREIGN KEY (`operationId`) REFERENCES `t_operation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_platform_dlb_distributed_record`;
-- 平台得利宝下发记录，暂时还没想好字段
CREATE TABLE `t_platform_dlb_distributed_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `t_platform_ylj_saved_record`;
-- 平台养老金转存记录
CREATE TABLE `t_platform_ylj_saved_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `savedDate` date DEFAULT NULL,		-- 操作年月
  `prevMonthBalance` double DEFAULT NULL,	-- 上月转入
  `currMonthDistributed` double DEFAULT NULL,	-- 当月累计
  `currMonthSaved` double DEFAULT NULL,		-- 当月转存
  `currMonthBalance` double DEFAULT NULL,	-- 当月结余
  `userId` int(11) DEFAULT NULL,		-- 对应Account
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_platform_ylj_saved_record_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_recharge_withdraw_record`;
-- 充值提现记录表
CREATE TABLE `t_recharge_withdraw_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operateType` int(11) DEFAULT NULL,		-- 0 充值 1 提现
  `orderNo` varchar(33) DEFAULT NULL,		-- 单号
  `operateNum` double DEFAULT NULL,		-- num yuan
  `serviceNum` double DEFAULT NULL,		-- 提现手续费
  `operateTime` datetime DEFAULT NULL,		-- 操作时间
  `operateState` int(11) DEFAULT NULL,		-- 0 已报单待支付  1支付失败  2支付成功
  `operateUserIp` varchar(33) DEFAULT NULL,	-- 用户ip地址
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderNo` (`orderNo`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_recharge_withdraw_record_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=360 DEFAULT CHARSET=utf8;





DROP TABLE IF EXISTS `t_role`;
-- 角色表
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(30) DEFAULT NULL,
  `roleGrade` int(11) DEFAULT NULL,
  `seqNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_role_perm`;

CREATE TABLE `t_role_perm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) DEFAULT NULL,
  `permId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roleId` (`roleId`),
  KEY `permId` (`permId`),
  CONSTRAINT `t_role_perm_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `t_role` (`id`),
  CONSTRAINT `t_role_perm_ibfk_2` FOREIGN KEY (`permId`) REFERENCES `t_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `t_shopping_mall`;
-- 商铺信息表
CREATE TABLE `t_shopping_mall` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mallPos_lat` double DEFAULT NULL,		--	纬度
  `mallPos_lnt` double DEFAULT NULL,		--	经度
  `mallName` varchar(30) DEFAULT NULL,		--	商铺名称
  `mallDesc` varchar(255) DEFAULT '暂无简介',	--	商铺描述
  `mallMainPicUrl` varchar(255) DEFAULT NULL,	-- 商铺封面图片
  `mallPicUrl1` varchar(255) DEFAULT NULL,	-- 商铺图片1，最多支持五张图片
  `mallPicUrl2` varchar(255) DEFAULT NULL,	-- 商铺图片2
  `mallPicUrl3` varchar(255) DEFAULT NULL,	-- 商铺图片3
  `mallPicUrl4` varchar(255) DEFAULT NULL,	-- 商铺图片4
  `mallPicUrl5` varchar(255) DEFAULT NULL,	-- 商铺图片5
  `mallLinkMan` varchar(30) DEFAULT NULL,	-- 联系人
  `mallPhone` varchar(20) DEFAULT NULL,		--  联系电话
  `mallAddress` varchar(255) DEFAULT NULL,	-- 地址描述
  `locked` int(11) DEFAULT '0',			--  锁定状态
  `user_id` int(11) DEFAULT NULL,		--  卖家ID
  `proxy_user_id` int(11) DEFAULT NULL,		--	代理商ID
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `proxy_user_id` (`proxy_user_id`),
  CONSTRAINT `t_shopping_mall_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `t_shopping_mall_ibfk_2` FOREIGN KEY (`proxy_user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `t_user`;
-- 用户信息表
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openId` varchar(32) DEFAULT NULL,		-- Wechat openid
  `username` varchar(32) DEFAULT NULL,		-- email or phone
  `password` varchar(128) DEFAULT NULL,		-- password
  `province` varchar(32) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `area` varchar(32) DEFAULT NULL,
  `phone` varchar(22) DEFAULT NULL,
  `headImgUrl` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT '0',			-- 0正常 1禁用
  `certificationId` int(11) DEFAULT NULL,--	实名认证信息
  `roleId` int(11) DEFAULT '2',			-- 角色	
  `jfAccountId` int(11) DEFAULT NULL,		-- 积分账户
  `dlbAccountId` int(11) DEFAULT NULL,		-- 得利宝账户
  `moneyAccountId` int(11) DEFAULT NULL,	-- 现金账户
  `yljAccountId` int(11) DEFAULT NULL,		-- 养老金账户
  `proxy_user_id` int(11) DEFAULT NULL,		-- 代理商id
  `getCashFlag` int(11) DEFAULT '0',		-- 提现标志 0为允许 1未禁止
  `incomFlag` int(11) DEFAULT '0',		-- 分红标志 0为允许 1未禁止
  PRIMARY KEY (`id`),
  UNIQUE KEY `openId` (`openId`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8;





DROP TABLE IF EXISTS `t_user_account`;
-- 用户账户表
CREATE TABLE `t_user_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accoutType` int(11) DEFAULT NULL,		-- 账户类型：银行卡账户，养老金账户，微信账户
  `accountNo` varchar(30) DEFAULT NULL,		-- 账号
  `userId` int(11) DEFAULT NULL,		 -- 对应用户
  PRIMARY KEY (`id`),
  UNIQUE KEY `accountNo` (`accountNo`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_user_account_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_ylj_account`;
-- 养老金账户表
CREATE TABLE `t_ylj_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountNo` varchar(30) DEFAULT NULL,
  `accountBalance` double(9,2) DEFAULT NULL,
  `totalPlatformIncomings` double(9,2) DEFAULT NULL,	--	累计收入（奖励）
  `totalPlatformOutgoings` double(9,2) DEFAULT NULL,	--	累计支出（消费）
  `totalUserIncomings` double(9,2) DEFAULT NULL,	--	累计转入（用户转入）
  `totalUserOutgoings` double(9,2) DEFAULT NULL,	--  累计转出（用户转出->提现）
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_ylj_account_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `t_ylj_record`;
-- 养老金账户记录表
CREATE TABLE `t_ylj_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation` int(11) DEFAULT NULL,	-- 操作类型（0转入,1转出）
  `operateTime` datetime DEFAULT NULL,	-- 操作时间
  `operateNum` double DEFAULT NULL,	-- 数量
  `operateDesc` varchar(30) DEFAULT NULL,	-- 描述信息
  `accountId` int(11) DEFAULT NULL,		-- 对应Account
  `operateObjId` int(11) DEFAULT NULL,		 -- 操作对象
  PRIMARY KEY (`id`),
  KEY `accountId` (`accountId`),
  KEY `operateObjId` (`operateObjId`),
  CONSTRAINT `t_ylj_record_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `t_ylj_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1949 DEFAULT CHARSET=utf8;















