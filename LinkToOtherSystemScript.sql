-- 12/11/2018 Link To Other system Feature
Create TABLE LinkOtherSystemFeature(
 SystemTypeID tinyint NOT NULL DEFAULT '0',
 SystemName varchar(50) NULL,
 IsAvailable tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY(SystemTypeID)
) ENGINE=InnoDB;  
INSERT INTO LinkOtherSystemFeature(SystemTypeID, SystemName, IsAvailable) VALUES(1, 'BuzzeBee Payment & Point', 0);


-- 12/11/2018 Link To BuzzeBee
Create TABLE BuzzeBee_ConfigSetting(
 ID int NOT NULL DEFAULT '0',
 WebService_URL VARCHAR(100) NULL,
 WebService_Token VARCHAR(200) NULL,
 BrandID varchar(20) NULL,
 PRIMARY KEY(ID)
) ENGINE=InnoDB;  
INSERT INTO BuzzeBee_ConfigSetting(ID, WebService_URL, WebService_Token, BrandID) 
VALUES(1, 'https://stgwallet.buzzebees.com/', '', '');

Create TABLE BuzzeBee_ShopSetting(
 ProductLevelID int NOT NULL DEFAULT '0',
 BuzzeBee_BranchID varchar(20) NULL,
 UpdateStaffID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL,
 PRIMARY KEY(ProductLevelID)
) ENGINE=InnoDB;  

Create TABLE BuzzeBee_ComputerSetting(
 ComputerID int NOT NULL DEFAULT '0',
 BuzzeBee_TerminalID varchar(20) NULL,
 UpdateStaffID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL,
 PRIMARY KEY(ComputerID)
) ENGINE=InnoDB;  

CREATE TABLE BuzzBee_LogInfo (
 LogID int NOT NULL Auto_Increment,
 ShopID int NOT NULL DEFAULT '0',
 SaleDate date NULL,
 APIType tinyint NOT NULL DEFAULT '0',
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 BranchID varchar(20) NULL,
 BranchName varchar(50) NULL,
 BrandID varchar(20) NULL,
 TerminalID varchar(20) NULL,
 Code varchar(30) NULL,
 CampaignID varchar(20) NULL, 
 Transaction_ID varchar(30) NULL,
 Amount varchar(20) NULL,
 Status varchar(10) NULL,
 Balance varchar(20) NULL,
 Issuer varchar(20) NULL,
 IssuerName varchar(50) NULL,
 UserID varchar(20) NULL,
 CardID varchar(20) NULL,

 Merchant varchar(20) NULL,
 MerchantName varchar(50) NULL,
 PointPerUnit varchar(20) NULL,
 ErrorCode varchar(30) NULL,
 ErrorMessage varchar(200) NULL,
 SendFromComputerID int NOT NULL DEFAULT '0',
 InsertDateTime datetime NULL,
 PRIMARY KEY  (LogID, ShopID),
 Index SaleShopIndex(ShopID, SaleDate)
) ENGINE=InnoDB;

CREATE TABLE BuzzBee_APIType (
 APIType tinyint NOT NULL DEFAULT '0',
 Description varchar(30) NULL,
 CallAPIURL varchar(100) NULL,
 PRIMARY KEY  (APIType)
) ENGINE=InnoDB;

INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(1, 'Topup', '/api/wallet/topup');
INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(2, 'Payment', '/api/wallet/pay');
INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(3, 'RefundPayment', '/api/wallet/refund');
INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(4, 'EarnPoint', '/api/earn/points');
INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(5, 'BurnPoint', '/api/wallet/burn/points');
INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(6, 'Query', '/api/wallet/query');
INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(7, 'Reverse', '/module/alibaba/tmnmerchant/reverse');
INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(8, 'SettlementPerDay', '/api/settlement/summary_daily');
INSERT INTO BuzzBee_APIType(APIType, Description, CallAPIURL) VALUES(9, 'RedeemPoint', '/api/wallet/pay');

CREATE TABLE BuzzBee_SettlementInfo (
 SettleID int NOT NULL Auto_Increment,
 ShopID int NOT NULL DEFAULT '0',
 SaleDate date NULL,
 SettlementDateTime varchar(20) NULL,
 Merchant varchar(20) NULL,
 MerchantName varchar(50) NULL,
 BranchID varchar(20) NULL,
 BrandID varchar(20) NULL,
 TerminalID varchar(20) NULL,
 TotalRedeemCount int NOT NULL DEFAULT '0',
 TotalPayCount int NOT NULL DEFAULT '0',
 TotalPayAmount decimal(18,4) NOT NULL DEFAULT '0',
 TotalRefundCount int NOT NULL DEFAULT '0',
 TotalRefundAmount decimal(18,4) NOT NULL DEFAULT '0',
 TotalEarnPoint int NOT NULL DEFAULT '0',
 TotalBurnPoint int NOT NULL DEFAULT '0',
 SendFromComputerID int NOT NULL DEFAULT '0',
 InsertDateTime datetime NULL,
 PRIMARY KEY  (SettleID, ShopID)
) ENGINE=InnoDB;

INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName, Deleted) VALUES(15, 'BuzzeBee - Payment', 1);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1136,'BuzzeBeePayment','BBPay','BuzzeBee - Payment',1,0,1,0,15,1,1,0,0,0,0,0,0,0,0,0,0,0,1136);

Create TABLE BuzzeBee_TestJSon(
 APIType int NOT NULL DEFAULT '0',
 JSonText Text NULL,
 PRIMARY KEY(APIType)
) ENGINE=InnoDB;  

-- 08/02/2019 - Payment Validation - 3 Button For BuzzeBee Payment
Update PayType Set Deleted = 1 Where TypeID = 1136 AND EDCType = 15;

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1143,'AliPay','ALIPAY','AliPay',1,0,1,0,15,1,1,0,0,0,100,0,1,0,0,0,0,0,1143);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1144,'True Wallet','TMN','True Wallet',1,0,1,0,15,1,1,0,0,0,100,0,1,0,0,0,0,0,1144);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1145,'Air Pay','AIRPAY','Air Pay',1,0,1,0,15,1,1,0,0,0,100,0,1,0,0,0,0,0,1145);

INSERT INTO PayTypeGroup(PayTypeGroupID, LangID, PayTypeGroupName) VALUES(100, 1, 'E Payment');
INSERT INTO PayTypeGroup(PayTypeGroupID, LangID, PayTypeGroupName) VALUES(100, 2, 'E Payment');

Create TABLE BuzzeBee_PayTypeCheckCodeCondition(
 PayTypeID int NOT NULL DEFAULT '0',
 StartCharacter varchar(10) NULL,
 ValidLength_Start tinyint NOT NULL DEFAULT '0',
 ValidLength_End tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY(PayTypeID)
) ENGINE=InnoDB;  
INSERT INTO BuzzeBee_PayTypeCheckCodeCondition(PayTypeID, StartCharacter, ValidLength_Start, ValidLength_End) VALUES(1143, '', 0, 0);
INSERT INTO BuzzeBee_PayTypeCheckCodeCondition(PayTypeID, StartCharacter, ValidLength_Start, ValidLength_End) VALUES(1144, '', 0, 0);
INSERT INTO BuzzeBee_PayTypeCheckCodeCondition(PayTypeID, StartCharacter, ValidLength_Start, ValidLength_End) VALUES(1145, 'APTH', 0, 0);

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(22008,6,'Manual_Void_BuzzeBee','',1, 0, 0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,22008,'Manual Void BuzzeBee Payment',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,22008,'ยกเลิกการจ่ายเงิน BuzzeBee แบบ manual',2);
Delete From StaffPermission Where PermissionItemID = 22008 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,22008);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,22008);

CREATE TABLE BuzzBee_ManualVoidPayDetail (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 PayDetailID int NOT NULL DEFAULT '0',
 VoidStaffID int NOT NULL DEFAULT '0',
 VoidDateTime datetime NULL,
 PRIMARY KEY  (TransactionID, ComputerID, PayDetailID)
) ENGINE=InnoDB;


-- 26/02/2019 - For Manual Payment
INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, RequireAuthorize, PayTypeOrdering) 
VALUES (1146,'Manual- AliPay','M-ALIPAY','Manual - AliPay',1,0,1,0,15,1,1,0,0,0,101,0,1,0,0,0,0,0,1,1146);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, RequireAuthorize, PayTypeOrdering) 
VALUES (1147,'Manual - True Wallet','M-TMN','Manual - True Wallet',1,0,1,0,15,1,1,0,0,0,101,0,1,0,0,0,0,0,1,1147);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, RequireAuthorize, PayTypeOrdering) 
VALUES (1148,'Manual - Air Pay','M-AIRPAY','Manual - Air Pay',1,0,1,0,15,1,1,0,0,0,101,0,1,0,0,0,0,0,1,1148);

INSERT INTO PayTypeGroup(PayTypeGroupID, LangID, PayTypeGroupName) VALUES(101, 1, 'Manual E Payment');
INSERT INTO PayTypeGroup(PayTypeGroupID, LangID, PayTypeGroupName) VALUES(101, 2, 'Manual E Payment');

ALTER TABLE BuzzeBee_PayTypeCheckCodeCondition ADD NumericOnly tinyint NOT NULL DEFAULT '0' After ValidLength_End;

ALTER TABLE BuzzeBee_PayTypeCheckCodeCondition ADD IsManualPayment tinyint NOT NULL DEFAULT '0';

INSERT INTO BuzzeBee_PayTypeCheckCodeCondition(PayTypeID, StartCharacter, ValidLength_Start, ValidLength_End, NumericOnly, IsManualPayment) VALUES(1146, '', 0, 0, 1, 1);
INSERT INTO BuzzeBee_PayTypeCheckCodeCondition(PayTypeID, StartCharacter, ValidLength_Start, ValidLength_End, NumericOnly, IsManualPayment) VALUES(1147, '', 0, 0, 1, 1);
INSERT INTO BuzzeBee_PayTypeCheckCodeCondition(PayTypeID, StartCharacter, ValidLength_Start, ValidLength_End, NumericOnly, IsManualPayment) VALUES(1148, 'APTH', 0, 0, 0, 1);

ALTER TABLE BuzzeBee_ConfigSetting ADD MessageForVoidManualPayment varchar(255) NULL;
Update BuzzeBee_ConfigSetting Set MessageForVoidManualPayment = 'กรุณาติดต่อ call center เพื่อ refund  โทร  1240 ต่อ 2 ต่อ 5' Where MessageForVoidManualPayment IS NULL;



-- 01/12/2018 Link To ValueDesign - CashCard
INSERT INTO LinkOtherSystemFeature(SystemTypeID, SystemName, IsAvailable) VALUES(2, 'Value Design Cash Card', 0);

INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName, Deleted) VALUES(16, 'Value Design Cash Card', 1);
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName, Deleted) VALUES(17, 'Value Design Point', 1);

Create TABLE ValueDesign_ConfigSetting(
 ID int NOT NULL DEFAULT '0',
 Host_IPAddress VARCHAR(50) NULL,
 Host_PortNo VARCHAR(20) NULL,
 PRIMARY KEY(ID)
) ENGINE=InnoDB;  
INSERT INTO ValueDesign_ConfigSetting(ID, Host_IPAddress, Host_PortNo) 
VALUES(1, '210.254.36.152', '9912');

Create TABLE ValueDesign_ComputerSetting(
 ComputerID int NOT NULL DEFAULT '0',
 ValueDesign_TerminalID varchar(20) NULL,
 UpdateStaffID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL,
 PRIMARY KEY(ComputerID)
) ENGINE=InnoDB;  

CREATE TABLE ValueDesign_FunctionType (
 FunctionType tinyint NOT NULL DEFAULT '0',
 Description varchar(30) NULL,
 PRIMARY KEY  (FunctionType)
) ENGINE=InnoDB;

INSERT INTO ValueDesign_FunctionType(FunctionType, Description) VALUES(1, 'Check Balance');
INSERT INTO ValueDesign_FunctionType(FunctionType, Description) VALUES(2, 'Topup');
INSERT INTO ValueDesign_FunctionType(FunctionType, Description) VALUES(3, 'Use');
INSERT INTO ValueDesign_FunctionType(FunctionType, Description) VALUES(4, 'Cancel Topup');
INSERT INTO ValueDesign_FunctionType(FunctionType, Description) VALUES(5, 'Cancel Use');
INSERT INTO ValueDesign_FunctionType(FunctionType, Description) VALUES(6, 'Refund');

CREATE TABLE ValueDesign_LogInfo (
 LogID int NOT NULL Auto_Increment,
 ShopID int NOT NULL DEFAULT '0',
 SaleDate date NULL,
 FunctionType tinyint NOT NULL DEFAULT '0',
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 TerminalID varchar(20) NULL,
 RequestID varchar(10) NULL,
 POSProcessNo varchar(15) NULL,
 TransactionNo varchar(20) NULL,
 RefPOSProcessNo varchar(15) NULL,
 RefTransactionNo varchar(20) NULL,
 CardID varchar(20) NULL,
 Amount varchar(10) NULL,
 BonusAmount varchar(10) NULL,
 PointAmount varchar(10) NULL, 
 TotalBalance varchar(10) NULL,
 BasicBalance varchar(10) NULL,
 BonusBalance varchar(10) NULL,
 CouponBalance varchar(10) NULL,
 PointBalance varchar(10) NULL,
 BasicExpireDate varchar(8) NULL,
 BonusExpireDate varchar(8) NULL,
 CouponExpireDate varchar(8) NULL,
 PointExpireDate varchar(8) NULL, 
 ErrorCode varchar(5) NULL,
 ErrorMessage varchar(256) NULL,
 ErrorCode_Center varchar(5) NULL,
 ErrorMessage_Center varchar(256) NULL,
 FromComputerID int NOT NULL,
 InsertDateTime datetime NULL,
 UpdateDate datetime NULL,
 UpdateStaffID int NOT NULL,
 IsAlreadyVoid tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (LogID, ShopID),
 Index SaleShopIndex(ShopID, SaleDate),
 Index TransIndex(TransactionID, ComputerID)
) ENGINE=InnoDB;

Create TABLE ValueDesign_MaxRequestID(
 ComputerID int NOT NULL DEFAULT '0',
 MaxRequestID int NOT NULL DEFAULT '0',
 PRIMARY KEY(ComputerID)
) ENGINE=InnoDB;  

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1137,'ValueDesign Cash Card','VDCard','Value Design Cash Card',1,0,1,0,16,1,1,0,0,0,0,0,0,0,0,0,0,0,1137);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1138,'ValueDesign Point','VDPoint','Value Design Point',1,0,1,0,17,1,1,0,0,0,0,0,0,0,0,0,0,0,1138);

-- LinkToOtherSystem Config
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(22007,1,'LinkOtherSystemFeature','Preferences/LinkOtherSystemFeature.aspx',501,0, 0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,22007,'Link To Other System Feature',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,22007,'ตั้งค่าการเชื่อมต่อกับระบบอื่น',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,22007);

-- PermissionGroup for LinkToOtherSystem
INSERT INTO PermissionGroup(PermissionGroupID, PermissionCategoryID, PermissionGroupOrder, Deleted) VALUES(32, 0, 18, 0);
INSERT INTO PermissionGroupName(PermissionGroupNameID, PermissionGroupID, PermissionGroupName, LangID) VALUES(15002, 32, 'Link to Other System', 1);
INSERT INTO PermissionGroupName(PermissionGroupNameID, PermissionGroupID, PermissionGroupName, LangID) VALUES(15003, 32, 'เชื่อมต่อกับระบบอื่น', 2);

-- BuzzeBee Config
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(22005,32,'LinkToBuzzeBeeSetting','LinkOtherSystem/LinkBuzzeBeeSetting.aspx',1,0, 1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,22005,'Link BuzzeBee Setting',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,22005,'ตั้งค่า Link BuzzeBee',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,22005);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,22005);

-- ValueDesign Config
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(22006,32,'LinkToValueDesignSetting','LinkOtherSystem/LinkValueDesignSetting.aspx',2,0, 1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,22006,'Link ValueDesign Setting',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,22006,'ตั้งค่า Link ValueDesign',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,22006);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,22006);


-- 28/02/2019 - BuzzeBee Report
-- PermissionGroup for BuzzeBeeReport
INSERT INTO PermissionGroup(PermissionGroupID, PermissionCategoryID, PermissionGroupOrder, Deleted) VALUES(33, 0, 105, 0);
INSERT INTO PermissionGroupName(PermissionGroupNameID, PermissionGroupID, PermissionGroupName, LangID) VALUES(15004, 33, 'BuzzeBee Report', 1);
INSERT INTO PermissionGroupName(PermissionGroupNameID, PermissionGroupID, PermissionGroupName, LangID) VALUES(15005, 33, 'รายงานเกี่ยวกับ BuzzeBee', 2);

-- BuzzeBee Redeem
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(716,33,'BZBReport_Redeem','LinkOtherSystemReports/Report_BZB_Redeem.aspx',10,0, 0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,716,'BZB Redeem Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,716,'รายงาน BZB Redeem',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,716);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,716);
-- BuzzeBee SaleReport
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(717,33,'BZBReport_SaleReport','LinkOtherSystemReports/Report_BZB_SaleReport.aspx',5,0, 0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,717,'BZB Sale Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,717,'รายงาน BZB Sale',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,717);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,717);

-- 15/03/2019 Value Design With API
ALTER TABLE ValueDesign_ConfigSetting ADD IsUseServiceAPI int NOT NULL DEFAULT '1' After Host_PortNo;
ALTER TABLE ValueDesign_ConfigSetting ADD API_ServiceURL varchar(200) NULL After IsUseServiceAPI;
ALTER TABLE ValueDesign_ConfigSetting ADD API_AccessKey varchar(30) NULL After API_ServiceURL;
ALTER TABLE ValueDesign_ConfigSetting ADD API_PINCode varchar(8) NULL After API_AccessKey;
ALTER TABLE ValueDesign_ConfigSetting ADD API_Version varchar(6) NULL After API_PINCode;

Update ValueDesign_ConfigSetting Set API_ServiceURL = 'https://sys.valuecardservice.net/en_soap/services/DealServiceWithPoint?wsdl' Where API_ServiceURL IS NULL;

CREATE TABLE ValueDesign_CardNoDetail (
 CardNo varchar(30) NOT NULL DEFAULT '',
 MemberID int NOT NULL DEFAULT '0',
 LastAmount decimal(18,4) NOT NULL DEFAULT '0',
 LastTransactionID int NOT NULL DEFAULT '0',
 LastComputerID int NOT NULL DEFAULT '0',
 LastUseShopID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL,
 AlreadyExportToHQ tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (CardNo) ,
 INDEX MemberIndex (MemberID),
 INDEX TransIndex (LastTransactionID, LastComputerID)
) ENGINE=InnoDB;

-- PermissionGroup for BuzzeBeeReport
INSERT INTO PermissionGroup(PermissionGroupID, PermissionCategoryID, PermissionGroupOrder, Deleted) VALUES(34, 0, 106, 0);
INSERT INTO PermissionGroupName(PermissionGroupNameID, PermissionGroupID, PermissionGroupName, LangID) VALUES(15006, 34, 'Value Design Report', 1);
INSERT INTO PermissionGroupName(PermissionGroupNameID, PermissionGroupID, PermissionGroupName, LangID) VALUES(15007, 34, 'รายงานเกี่ยวกับ Value Design', 2);

-- ValueDesign - Log Report
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(718,34,'VDReport_LogReport','LinkOtherSystemReports/Report_VD_LogReport.aspx',50,0, 0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,718,'Value Design Log Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,718,'รายงาน Value Design Log',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,718);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,718);

ALTER TABLE ValueDesign_FunctionType ADD DisplayInReport tinyint NOT NULL DEFAULT '0' After Description;
Update ValueDesign_FunctionType Set DisplayInReport = 1 Where FunctionType IN (2,3,4,5);

CREATE TABLE ValueDesign_APIResultCodeDescription (
 ResultCode varchar(10) NOT NULL DEFAULT '',
 Description varchar(100) NULL,
 DisplayText varchar(200) NULL,
 PRIMARY KEY  (ResultCode)
) ENGINE=InnoDB;
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('200', 'Success', 'Success');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('201', 'Normal', '');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('401', 'Invalid AccessKey or Terminal', 'Invalid Access Key or TerminalID');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('402', 'Invalid BIN', 'BIN is invalid');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('500', 'Arguement is invalid', 'Invalid arguement.');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('501', 'Card no. not exist', 'Card Number does not exist or invalid PIN.');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('502', 'Card is not available', 'Card is not not available to use.');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('503', 'Payment amount exceed balance.', 'จำนวนจ่ายมากกว่าจำนวนเงินในบัตร');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('504', 'Card is unused', 'บัตรยังไม่ได้เปิดใช้');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('505', 'Maximum deposit is exceeded.', 'จำนวนเงินที่เติมมากกว่าค่าสูงสุดที่สามารถเติมได้');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('506', 'Request cancellation from different terminalID is impossible', 'ไม่อนุญาตให้ยกเลิกรายการจากคนละเครื่องที่ทำรายการ');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('507', 'The cancellation amount does not match.', 'จำนวนเงินที่ยกเลิกไม่ตรงกับจำนวนที่บันทึกไว้');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('508', 'Cancellation processing has already been done.', 'การยกเลิกสำเร็จแล้ว');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('509', 'Cancellation from other shop is impossible', 'ไม่อนุญาตให้ยกเลิกรายการจากคนละร้าน');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('510', 'Other dealing is already in process. Cancellation is not possible', 'ไม่สามารถยกเลิกรายการได้เพราะมีการทำรายการอื่นไปแล้ว');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('511', 'There is not dealing to cancel', 'ไม่มีรายการที่ต้องการยกเลิก');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('512', 'Deposit to dispoable card is not possible', 'ไม่สามารถเติมเงินในบัตรนี้ได้');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('513', 'This card is already use', 'บัตรนี้ใช้ไปแล้ว');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('514', 'Incentives are 0.', 'Incentives are 0.');
INSERT INTO ValueDesign_APIResultCodeDescription(ResultCode, Description, DisplayText) VALUES('900', 'Processing was not executed due to system failure', 'ไม่สามารถทำรายการเนื่องจากระบบล้มเหลว');

-- Edit Name of BuzzeBees
UPDATE PermissionItemName SET PermissionItemName = 'Link BuzzeBees Setting' WHERE PermissionItemName = 'Link BuzzeBee Setting';
UPDATE PermissionItemName SET PermissionItemName = 'ตั้งค่า Link BuzzeBees' WHERE PermissionItemName = 'ตั้งค่า Link BuzzeBee';

UPDATE PermissionGroupName SET PermissionGroupName = 'BuzzeBees Report' WHERE PermissionGroupName = 'BuzzeBee Report';
UPDATE PermissionGroupName SET PermissionGroupName = 'รายงานเกี่ยวกับ BuzzeBees' WHERE PermissionGroupName = 'รายงานเกี่ยวกับ BuzzeBee';

UPDATE PermissionItemName SET PermissionItemName = 'BZBS Redeem Report' WHERE PermissionItemName = 'BZB Redeem Report';
UPDATE PermissionItemName SET PermissionItemName = 'รายงาน BZBS Redeem' WHERE PermissionItemName = 'รายงาน BZB Redeem';
UPDATE PermissionItemName SET PermissionItemName = 'BZBS Sale Report' WHERE PermissionItemName = 'BZB Sale Report';
UPDATE PermissionItemName SET PermissionItemName = 'รายงาน BZBS Sale' WHERE PermissionItemName = 'รายงาน BZB Sale';

ALTER TABLE BuzzBee_LogInfo ADD POSTransaction_ID varchar(30) NULL After Transaction_ID;


-- 08/05/2019 Link To iNet - Loga
INSERT INTO LinkOtherSystemFeature(SystemTypeID, SystemName, IsAvailable) VALUES(3, 'iNet - Loga', 0);

Create TABLE iNetLoga_ConfigSetting(
 ID int NOT NULL DEFAULT '0',
 WebService_URL VARCHAR(100) NULL,
 WebService_UserName VARCHAR(100) NULL,
 WebService_Password VARCHAR(100) NULL,
 LogaCardID varchar(30) NULL,
 BrandID varchar(20) NULL,
 PRIMARY KEY(ID)
) ENGINE=InnoDB;  
INSERT INTO iNetLoga_ConfigSetting(ID, WebService_URL, WebService_UserName, WebService_Password, LogaCardID, BrandID) 
VALUES(1, 'https://merchant.loga.app/', '', '', '', '');

Create TABLE iNetLoga_TestJSon(
 APIType int NOT NULL DEFAULT '0',
 JSonText Text NULL,
 PRIMARY KEY(APIType)
) ENGINE=InnoDB; 

-- iNetLoga Config
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(22009,32,'LinkToiNetLogaSetting','LinkOtherSystem/LinkiNetLogaSetting.aspx',3,0, 1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,22009,'Link iNet (Loga) Setting',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,22009,'ตั้งค่า Link iNet (Loga)',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,22009);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,22009);

CREATE TABLE iNetLoga_APIType (
 APIType tinyint NOT NULL DEFAULT '0',
 Description varchar(30) NULL,
 CallAPIURL varchar(100) NULL,
 PRIMARY KEY  (APIType)
) ENGINE=InnoDB;

INSERT INTO iNetLoga_APIType(APIType, Description, CallAPIURL) VALUES(1, 'LogIn', '/main/login');
INSERT INTO iNetLoga_APIType(APIType, Description, CallAPIURL) VALUES(2, 'LogOut', '/main/logout');
INSERT INTO iNetLoga_APIType(APIType, Description, CallAPIURL) VALUES(3, 'SearchMember', '/main/get_customer_info');
INSERT INTO iNetLoga_APIType(APIType, Description, CallAPIURL) VALUES(4, 'AddNewMember', '/main/add_member');
INSERT INTO iNetLoga_APIType(APIType, Description, CallAPIURL) VALUES(5, 'SendNewPoint', '/points/add_customer_point');
INSERT INTO iNetLoga_APIType(APIType, Description, CallAPIURL) VALUES(6, 'VoidPoint', '/points/use_customer_point');


ALTER TABLE Members ADD Loga_PCardID varchar(15) NULL After UpdateBy;
ALTER TABLE Members ADD Loga_UID varchar(15) NULL After Loga_PCardID;

CREATE TABLE iNetLoga_MemberLink (
 MemberID int NOT NULL DEFAULT '0',
 Loga_PCardID varchar(15) NULL,
 Loga_UID varchar(15) NULL,
 UpdateDate datetime NULL,
 PRIMARY KEY  (MemberID)
) ENGINE=InnoDB;


CREATE TABLE iNetLoga_MemberGroupLink (
 Loga_Level_ID int NOT NULL DEFAULT '0',
 MemberGroupID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (Loga_Level_ID, MemberGroupID)
) ENGINE=InnoDB;
















