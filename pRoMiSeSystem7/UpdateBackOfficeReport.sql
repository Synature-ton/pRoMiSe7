-- 01/11/2016 - Update Sale By Product/ ProductGroup New
UPDATE PermissionItem SET PermissionItemURL = 'Reports/sale_byproductgroup_new.aspx' WHERE PermissionItemID = 40500;
UPDATE PermissionItem SET PermissionItemURL = 'Reports/sale_byproduct_new.aspx' WHERE PermissionItemID = 40501;

-- 23/04/2015 Display Payment Type From Original (In SmartCardType)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(2, 16, 1, "Display Payment Type Before Convert To In Sale Report", "0=No, 1=Yes. Display Payment Type Before Convert To");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (2, 16, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,16,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,16,2, 'Yes. Display Payment Type Before Convert To', 1, 1, 0);

-- 05/08/2017 Summary Payment Report View --> Add Original PayType
Drop View Summary_PaymentReport;
CREATE VIEW Summary_PaymentReport AS 
SELECT a.ShopID as ShopId, a.SaleDate as SaleDate, c.TypeID as PayTypeID, c.PayType as PayTypeName,
  d.TypeID as OriginalPayTypeID, d.PayType as OriginalPayTypeName, SUM(b.Amount) as TotalPay,
  SUM(ROUND(((b.Amount * b.PrepaidDiscountPercent) / 100),2)) AS TotalPayDiscount,
  SUM(b.PaymentVAT) AS TotalVAT, c.IsSale AS IsSale, c.IsVAT AS IsVAT, 
  IF (a.TransactionStatusID = 11, 1, c.IsOtherReceipt) AS IsOtherReceipt, a.DocType AS DocType
FROM OrderTransaction a JOIN PayDetail b JOIN PayType c JOIN PayType d
WHERE a.TransactionID = b.TransactionID AND a.ComputerID = b.ComputerID AND b.PayTypeID = c.TypeID AND 
	IF(SmartcardType > 0,b.SmartcardType,b.PayTypeID) = d.TypeID AND a.TransactionStatusID IN (2,11) AND a.ReceiptID > 0
GROUP BY c.TypeID,c.PayType,d.TypeID,d.PayType,c.IsSale,c.IsVAT,c.IsOtherReceipt,a.ShopID,a.SaleDate,a.DocType;



-- 09/04/2018 - Display Shop In Combo In Report By MasterShop
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(2, 20, 1, 'Display Shop In Combo In Report By MasterShop', '1 = Display By MasterShop.');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (2, 20, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,20,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,20,2, 'Yes.', 1, 1, 0);

-- 18/05/2018 - Member's Redeem Product Report
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(710,19,'Report_Member_RedeemProduct','Reports/report_memberredeemproduct.aspx',210,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(718,710,'Member''s Redeem Product Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(719,710,'รายงานการแลกสินค้าจากแต้มสะสมของสมาชิก',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,710);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,710);



-- 07/01/2019 - Product Cost Table (Same as Material Cost Table)
Create TABLE ProductCostGroup(
 ProductCostGroupID int NOT NULL DEFAULT '0',
 CostGroupName varchar(50) NULL,
 StartDate date NULL,
 EndDate date NULL,
 InsertStaffID int NOT NULL DEFAULT '0',
 InsertDate datetime NULL,
 UpdateStaffID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL,
 PRIMARY KEY(ProductCostGroupID)
) ENGINE=InnoDB;

Create TABLE ProductCostGroupLinkShop(
 ProductCostGroupID int NOT NULL DEFAULT '0',
 ProductLevelID int NOT NULL DEFAULT '0',
 PRIMARY KEY(ProductCostGroupID, ProductLevelID)
) ENGINE=InnoDB;

ALTER TABLE ProductCostTable ADD ProductID int NOT NULL DEFAULT '0' After ProductCode;
ALTER TABLE ProductCostTable ADD ProductCostGroupID int NOT NULL DEFAULT '0' After ProductID;

ALTER TABLE ProductCostTable DROP Primary Key, ADD Primary Key(ProductID, ProductCostGroupID);

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl, PermissionItemOrder, PermissionItemIDParent) 
VALUES  (530,13,'SetProductCostGroup','Inventory/Product_Cost_Group.aspx',1,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (5048,530,'Set Product Cost Group',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (5049,530,'ตั้งค่ากลุ่มต้นทุนสินค้า',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=530) Or (StaffRoleID=2 AND PermissionItemID=530);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,530);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,530);






