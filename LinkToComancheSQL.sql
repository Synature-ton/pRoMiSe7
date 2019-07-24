-- 15/08/2017 Link To Comanche PMS
CREATE TABLE PMSCMC_ConfigSetting (
 ID tinyint NOT NULL DEFAULT '0',
 CMCIPAddress varchar(50) NULL,
 CMCDBName varchar(50) NULL,
 DBPortNo varchar(50) NULL,
 UserName varchar(50) NULL,
 Password varchar(50) NULL,
 AmountFormat varchar(20) NULL, 
 PriceFormat varchar(20) NULL,
 DateFormat varchar(20) NULL,
 TimeFormat varchar(20) NULL,
 PRIMARY KEY (ID)
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_OutletMapping (
 ProductLevelID int NOT NULL DEFAULT '0',
 OutletCode varchar(4) NULL,
 PRIMARY KEY (ProductLevelID)
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_ShiftMapping (
 ProductLevelID int NOT NULL DEFAULT '0',
 ShiftID  int NOT NULL DEFAULT '0',
 ShiftCode varchar(10) NULL,
 ShiftName varchar(100) NULL,
 StartTime datetime NULL,
 EndTime datetime NULL,
 TranCode varchar(10) NULL,
 VAT_AccountCode varchar(10) NULL,
 Service_AccountCode varchar(10) NULL,
 Excise_AccountCode varchar(10) NULL, 
 Deleted tinyint NOT NULL DEFAULT '0',
 UpdateDate datetime NULL,
 PRIMARY KEY (ProductLevelID, ShiftID)
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_PaymentMapping (
 ProductLevelID int NOT NULL DEFAULT '0',
 PayTypeID int NOT NULL DEFAULT '0',
 IsChargeToRoom tinyint NOT NULL DEFAULT '0',
 DummyRoom varchar(10) NULL,
 TranCode varchar(10) NULL, 
 UpdateDate DateTime NULL,
 PRIMARY KEY (ProductLevelID, PayTypeID)
) ENGINE=InnoDB;

Create TABLE PMSCMC_ExportTransactionLog(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 SaleDate date NULL,
 ExportDateTime datetime NULL,
 PRIMARY KEY(TransactionID, ComputerID) 
) ENGINE=InnoDB;

Create TABLE PMSCMC_PaymentRoomInfo(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 PayDetailID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 SaleDate date NULL,
 PaymentAmount decimal(18,4) NOT NULL DEFAULT '0',
 PayTypeID int NOT NULL DEFAULT '0',
 IsChargeToRoom tinyint NOT NULL DEFAULT '0',
 CMC_TranCode varchar(3) NULL,
 CMC_VATAmount decimal(18,4) NOT NULL DEFAULT '0',
 CMC_ServiceChargeAmount decimal(18,4) NOT NULL DEFAULT '0',
 CMC_FolioSeq int NOT NULL DEFAULT '0',
 CMC_RevenueTranNo int NOT NULL DEFAULT '0',
 CMC_PaymentTranNo int NOT NULL DEFAULT '0',
 Room_RowID int NOT NULL DEFAULT '0',
 CMC_RoomNo varchar(10) NULL,
 PRIMARY KEY(TransactionID, ComputerID, PayDetailID) 
) ENGINE=InnoDB;

Create TABLE PMSCMC_MaxFolioSeq(
 ProductLevelID  int NOT NULL DEFAULT '0',
 FolioSeq int NOT NULL DEFAULT '0',
 PRIMARY KEY(ProductLevelID) 
) ENGINE=InnoDB;

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1130,'Comanche Charge To Room','CMCPMS','Comanche Charge To Room',1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1130);

Update ProgramProperty Set Description = '0=No, 1=PMS, 2=Comanche PMS' Where ProgramTypeID = 1 AND PropertyID = 121;
Delete From PropertyOption Where PropertyTypeID = 1 AND PropertyID = 121 AND OptionID = 2;
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,121,2, 'PMS', 1, 1, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,121,3, 'Comanche PMS', 2, 2, 0);

-- 14/08/2017 Export Document To Comanche 
CREATE TABLE PMSCMC_SyncDataLog (
 SyncID varchar(50) NOT NULL DEFAULT '',
 SyncType tinyint NOT NULL DEFAULT '0',
 StartDateTime datetime NULL,
 EndDateTime datetime NULL,
 Remark text NULL,
 PRIMARY KEY (SyncID)
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_SyncDataType (
 SyncType tinyint NOT NULL DEFAULT '0',
 Description varchar(100) NULL,
 PRIMARY KEY (SyncType)
) ENGINE=InnoDB;
Insert INTO PMSCMC_SyncDataType(SyncType, Description) VALUES(1, 'Vendor from CMC To POS');

Create TABLE PMSCMC_ExportDocumentLog(
 DocumentID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 DocumentTypeID int NOT NULL DEFAULT '0',
 DocumentDate date NULL,
 ProductLevelID int NOT NULL DEFAULT '0',
 DocumentStatus tinyint NOT NULL DEFAULT '0',
 ExportDateTime datetime NULL,
 PRIMARY KEY(DocumentID, ShopID) 
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_Inv_InventoryMapping (
 ProductLevelID int NOT NULL DEFAULT '0',
 StoreCode varchar(20) NULL,
 AccountCode varchar(20) NULL,
 UpdateDate DateTime NULL,
 PRIMARY KEY (ProductLevelID)
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_Inv_MaterialGroupMapping (
 MaterialGroupID int NOT NULL DEFAULT '0',
 MainID int NOT NULL DEFAULT '0',
 MajorCode varchar(5) NULL,
 UpdateDate DateTime NULL,
 PRIMARY KEY (MaterialGroupID)
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_Inv_MaterialDeptMapping (
 MaterialDeptID int NOT NULL DEFAULT '0',
 MinorCode varchar(5) NULL,
 UpdateDate DateTime NULL,
 PRIMARY KEY (MaterialDeptID)
) ENGINE=InnoDB;

-- ProductGroup/ Dept Account Mapping
CREATE TABLE PMSCMC_ProductGroupMapping (
 ProductLevelID int NOT NULL DEFAULT '0',
 ShiftID int NOT NULL DEFAULT '0',
 ProductGroupID int NOT NULL DEFAULT '0',
 Major varchar(10) NULL,
 MajorName varchar(100) NULL,
 TotalPrice_AccountCode varchar(30) NULL,
 DiscountPrice_AccountCode varchar(30) NULL,
 VAT_AccountCode varchar(30) NULL,
 Service_AccountCode varchar(30) NULL,
 UpdateDate datetime NULL,
 PRIMARY KEY (ProductLevelID, ShiftID, ProductGroupID)
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_ProductDeptMapping (
 ProductLevelID int NOT NULL DEFAULT '0',
 ShiftID int NOT NULL DEFAULT '0',
 ProductDeptID int NOT NULL DEFAULT '0',
 Minor varchar(10) NULL,
 MinorName varchar(100) NULL,
 TotalPrice_AccountCode varchar(30) NULL,
 DiscountPrice_AccountCode varchar(30) NULL,
 VAT_AccountCode varchar(30) NULL,
 Service_AccountCode varchar(30) NULL,
 UpdateDate datetime NULL,
 PRIMARY KEY (ProductLevelID, ShiftID, ProductDeptID)
) ENGINE=InnoDB;

-- 10/10/2017 AP/ GL DB Config
ALTER TABLE PMSCMC_ConfigSetting ADD AP_IPAddress varchar(50) NULL After Password;
ALTER TABLE PMSCMC_ConfigSetting ADD AP_DBName varchar(50) NULL After AP_IPAddress;
ALTER TABLE PMSCMC_ConfigSetting ADD AP_DBPortNo varchar(50) NULL After AP_DBName;
ALTER TABLE PMSCMC_ConfigSetting ADD AP_UserName varchar(50) NULL After AP_DBPortNo;
ALTER TABLE PMSCMC_ConfigSetting ADD AP_Password varchar(50) NULL After AP_UserName;

ALTER TABLE PMSCMC_ConfigSetting ADD GL_IPAddress varchar(50) NULL After AP_Password;
ALTER TABLE PMSCMC_ConfigSetting ADD GL_DBName varchar(50) NULL After GL_IPAddress;
ALTER TABLE PMSCMC_ConfigSetting ADD GL_DBPortNo varchar(50) NULL After GL_DBName;
ALTER TABLE PMSCMC_ConfigSetting ADD GL_UserName varchar(50) NULL After GL_DBPortNo;
ALTER TABLE PMSCMC_ConfigSetting ADD GL_Password varchar(50) NULL After GL_UserName;

ALTER TABLE PMSCMC_Inv_InventoryMapping ADD AP_ExportGRPType tinyint NOT NULL DEFAULT '0' After AccountCode;

CREATE TABLE PMSCMC_Inv_ExportGRPType(
 ExportGRPType tinyint NOT NULL DEFAULT '0',
 Description varchar(50) NULL,
 GLDescription varchar(50) NULL,
 PRIMARY KEY (ExportGRPType)
) ENGINE=InnoDB;
INSERT INTO PMSCMC_Inv_ExportGRPType(ExportGRPType, Description, GLDescription) VALUES(1, 'GP : Main', 'Main');
INSERT INTO PMSCMC_Inv_ExportGRPType(ExportGRPType, Description, GLDescription) VALUES(2, 'GS : Main+Major', 'Major');
INSERT INTO PMSCMC_Inv_ExportGRPType(ExportGRPType, Description, GLDescription) VALUES(3, 'GT : Main+Major+Minor', 'Minor');

ALTER TABLE PMSCMC_ConfigSetting ADD AP_ExportDocumentType varchar(100) NULL After GL_Password;
Update PMSCMC_ConfigSetting Set AP_ExportDocumentType = '2,39' Where AP_ExportDocumentType IS NULL;

-- 24/10/2017 - GL Mapping
ALTER TABLE PMSCMC_Inv_InventoryMapping ADD GL_ExportType tinyint NOT NULL DEFAULT '0' After AP_ExportGRPType;

CREATE TABLE PMSCMC_Inv_MaterialMainMapping (
 MaterialMainID int NOT NULL DEFAULT '0',
 MainCode varchar(5) NULL,
 MainName varchar(50) NULL,
 Deleted tinyint NOT NULL DEFAULT '0',
 UpdateDate DateTime NULL,
 PRIMARY KEY (MaterialMainID)
) ENGINE=InnoDB;

CREATE TABLE PMSCMC_Inv_GLAccountMapping(
 ProductLevelID int NOT NULL DEFAULT '0',
 GL_ExportType tinyint NOT NULL DEFAULT '0',
 GLCode varchar(15) NULL,
 Cost_AccountNo varchar(20) NULL,
 Invent_AccountNo varchar(20) NULL,
 UpdateDate DateTime NULL,
 PRIMARY KEY (ProductLevelID, GL_ExportType, GLCode)
) ENGINE=InnoDB;

-- 01/12/2017 - TranCodeForP
ALTER TABLE PMSCMC_PaymentMapping ADD TranCodeForP varchar(10) NULL After TranCode;
Update PMSCMC_PaymentMapping Set TranCodeForP = TranCode Where TranCodeForP IS NULL;

-- 30/12/2017 - Config Use Time For MappingShift
ALTER TABLE PMSCMC_ConfigSetting ADD UseTimeForMappingShift tinyint NOT NULL DEFAULT '0' After TimeFormat;

-- 02/10/2018 - Add TranCode For ProductGroupMapping
ALTER TABLE PMSCMC_ProductGroupMapping ADD TranCode varchar(10) NULL After MajorName;

-- 04/01/2019 - Send Void Transaction To Comanche
ALTER TABLE PMSCMC_ConfigSetting ADD SendVoidTransactionToCMC tinyint NOT NULL DEFAULT '0';


-- 18/02/2019 - Add CreditCardType In MappingPayment
ALTER TABLE PMSCMC_PaymentMapping ADD CreditCardTypeID tinyint NOT NULL DEFAULT '0' After PayTypeID;
ALTER TABLE PMSCMC_PaymentMapping Drop Primary Key, Add Primary Key(ProductLevelID, PayTypeID, CreditCardTypeID);

-- 18/02/2019 - Link To AR Database
ALTER TABLE PMSCMC_ConfigSetting ADD AR_IPAddress varchar(50) NULL After GL_Password;
ALTER TABLE PMSCMC_ConfigSetting ADD AR_DBName varchar(50) NULL After AR_IPAddress;
ALTER TABLE PMSCMC_ConfigSetting ADD AR_DBPortNo varchar(50) NULL After AR_DBName;
ALTER TABLE PMSCMC_ConfigSetting ADD AR_UserName varchar(50) NULL After AR_DBPortNo;
ALTER TABLE PMSCMC_ConfigSetting ADD Ar_Password varchar(50) NULL After AR_UserName;
ALTER TABLE PMSCMC_ConfigSetting ADD IsExportToAR tinyint NOT NULL DEFAULT '0' After AR_Password;

ALTER TABLE PMSCMC_PaymentMapping ADD IsSendPayTypeToAR tinyint NOT NULL DEFAULT '0' After IsChargeToRoom;

CREATE TABLE PMSCMC_IsChargeToRoomType(
 IsChargeToRoom tinyint NOT NULL DEFAULT '0',
 Description varchar(50) NULL,
 PRIMARY KEY (IsChargeToRoom)
) ENGINE=InnoDB;
INSERT INTO PMSCMC_IsChargeToRoomType(IsChargeToRoom, Description) VALUES(0, 'None');
INSERT INTO PMSCMC_IsChargeToRoomType(IsChargeToRoom, Description) VALUES(1, 'Charge To Room');
INSERT INTO PMSCMC_IsChargeToRoomType(IsChargeToRoom, Description) VALUES(2, 'Search from AR');

ALTER TABLE PMSCMC_PaymentMapping ADD AccountNoForAR varchar(10) NULL After TranCode;

ALTER TABLE PMSCMC_PaymentRoomInfo ADD IsSendToAR tinyint NOT NULL DEFAULT '0' After IsChargeToRoom;

-- 02/04/2019 - ExportSaleColumnToTextFile (At EndDay/ Manual)
ALTER TABLE PMSCMC_ConfigSetting ADD IsExportSaleUsageStockTextFileAtEndDay tinyint NOT NULL DEFAULT '0' After SendVoidTransactionToCMC;
ALTER TABLE PMSCMC_ConfigSetting ADD DelimeterForExportUsageStockTextFile varchar(1) NOT NULL DEFAULT '|' After IsExportSaleUsageStockTextFileAtEndDay;
ALTER TABLE PMSCMC_ConfigSetting ADD DefaultFolderExportUsageStockTextFile varchar(200) NULL After DelimeterForExportUsageStockTextFile;

CREATE TABLE PMSCMC_ExportUsageStockTextFileColumn(
 ProductLevelID int NOT NULL DEFAULT '0',
 DocumentTypeGroupID int NOT NULL DEFAULT '0',
 PRIMARY KEY (ProductLevelID, DocumentTypeGroupID)
) ENGINE=InnoDB;

ALTER TABLE PMSCMC_ConfigSetting ADD CheckHotelDateWhenSendCMC tinyint NOT NULL DEFAULT '1' After SendVoidTransactionToCMC;


ALTER TABLE PMSCMC_PaymentMapping ADD MST_ARNo varchar(10) NULL After AccountNoForAR;












