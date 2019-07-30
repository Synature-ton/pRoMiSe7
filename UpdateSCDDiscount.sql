-- 02/01/2018 - SCD Discount
ALTER TABLE PromotionPriceGroup ADD IsSCDExemptVAT tinyint NOT NULL DEFAULT '0' After PrintSignatureInReceipt;

CREATE TABLE SCDDiscount_Detail (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 SCDID int NOT NULL DEFAULT '0',
 FirstName varchar(50) NULL,
 LastName varchar(50) NULL,
 CitizenID varchar(30) NULL,
 ZipCode varchar(20) NULL,
 PriceGroupID int NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, SCDID)
) ENGINE=InnoDB;

CREATE TABLE SCDDiscount_OrderDetail (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 PriceGroupID int NOT NULL DEFAULT '0',
 ProductID int NOT NULL DEFAULT '0',
 VATType tinyint NOT NULL DEFAULT '0',
 SalePrice decimal(18,4) NOT NULL DEFAULT '0',
 SalePriceBeforeVAT decimal(18,4) NOT NULL DEFAULT '0',
 SalePriceVAT decimal(18,4) NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID)
) ENGINE=InnoDB;

ALTER TABLE OrderTransactionFront ADD TransactionExemptVAT decimal(18,4) NOT NULL DEFAULT '0' After OtherIncomeVAT;
ALTER TABLE OrderTransaction ADD TransactionExemptVAT decimal(18,4) NOT NULL DEFAULT '0' After OtherIncomeVAT;


-- 26/4/2018 - X/Z Reading Report - Philippin
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(213,6,'FrontReport_XReading','',109,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,213,'POS X Reading Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,213,'รายการ POS X Reading',2);
Delete From StaffPermission Where PermissionItemID = 213 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,213);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,213);

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(214,6,'FrontReport_ZReading','',110,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,214,'POS Z Reading Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,214,'รายการ POS Z Reading',2);
Delete From StaffPermission Where PermissionItemID = 214 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,214);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,214);













