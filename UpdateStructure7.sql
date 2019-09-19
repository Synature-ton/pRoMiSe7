-- 12/07/2013 Flexible Product AmountPerUnit
ALTER TABLE OrderProductSetLinkDetailFront ADD AmountInFlexiblePerUnit decimal(18,4) NOT NULL DEFAULT '1' After SetGroupNo;
ALTER TABLE OrderProductLinkDetail ADD AmountInFlexiblePerUnit decimal(18,4) NOT NULL DEFAULT '1' After SetGroupNo;
ALTER TABLE OrderSpaProductSetLinkDetail ADD AmountInFlexiblePerUnit decimal(18,4) NOT NULL DEFAULT '1' After SetGroupNo;

ALTER TABLE OrderTransaction CHANGE ServiceCharge ServiceCharge decimal(18,4) NOT NULL DEFAULT '0';
ALTER TABLE OrderTransaction CHANGE ServiceChargeVAT ServiceChargeVAT decimal(18,4) NOT NULL DEFAULT '0';
ALTER TABLE OrderTransaction CHANGE TransactionExcludeVAT TransactionExcludeVAT decimal(18,4) NOT NULL DEFAULT '0';

ALTER TABLE OrderTransactionFront CHANGE ServiceCharge ServiceCharge decimal(18,4) NOT NULL DEFAULT '0';
ALTER TABLE OrderTransactionFront CHANGE ServiceChargeVAT ServiceChargeVAT decimal(18,4) NOT NULL DEFAULT '0';
ALTER TABLE OrderTransactionFront CHANGE TransactionExcludeVAT TransactionExcludeVAT decimal(18,4) NOT NULL DEFAULT '0';

-- 12/07/2013 KDS ProductSetting And OrderDetail
CREATE TABLE ComputerType (
  ComputerTypeID tinyint NOT NULL DEFAULT '0',
  Description varchar(100) NULL,
  PRIMARY KEY  (ComputerTypeID)
) TYPE=InnoDB;
INSERT INTO ComputerType(ComputerTypeID, Description) VALUES (0,'PC Computer');
INSERT INTO ComputerType(ComputerTypeID, Description) VALUES (1,'Tablet/ Mobile');
INSERT INTO ComputerType(ComputerTypeID, Description) VALUES (3,'KDS Station');

INSERT INTO CheckerType(CheckerTypeID, Description) VALUES (3,'KDS Station (KDS_OrderProcess)');
ALTER TABLE ComputerName ADD KDSID tinyint NOT NULL DEFAULT '0' After ComputerType;

CREATE TABLE KDS_ProductSetting (
  ProductID int NOT NULL DEFAULT '0',
  ProductLevelID int NOT NULL DEFAULT '0',
  KDSStep tinyint NOT NULL DEFAULT '0',
  PrinterID varchar(50) NULL,
  DelayMinute tinyint NOT NULL DEFAULT '0',
  KDSID int NOT NULL DEFAULT '0',
  UpdateDate datetime NULL,
  InsertDate datetime NULL,
  PRIMARY KEY  (ProductID, ProductLevelID, KDSStep)
) TYPE=InnoDB;

CREATE TABLE KDS_OrderProcessHeader (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ProcessID int NOT NULL DEFAULT '0',
  SubmitOrderStaffID int NOT NULL DEFAULT '0',
  ProcessStartTime datetime NULL,
  FinishStaffID int NOT NULL DEFAULT '0',
  ProcessFinishTime datetime NULL,
  SaleModeID tinyint NOT NULL DEFAULT '0',
  SaleModeName varchar(100) NULL,
  OrderDate date NULL,
  TableID int NOT NULL DEFAULT '0',
  DisplayTableName varchar(200) NULL,
  KDSStatus tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, ProcessID)
) TYPE=InnoDB;

CREATE TABLE KDS_OrderProcessDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  OrderDetailID int NOT NULL DEFAULT '0',
  ProcessID int NOT NULL DEFAULT '0',
  OrderKDSID  int NOT NULL DEFAULT '0',
  KDSStep tinyint NOT NULL DEFAULT '0',
  KDSID tinyint NOT NULL DEFAULT '0',
  ProductID int NOT NULL DEFAULT '0',
  ProductAmount decimal(18,4) NOT NULL DEFAULT '0',
  ProductHeaderName varchar(100) NULL,
  ProductName varchar(100) NULL,
  ProductComment varchar(1000) NULL,
  ProductSetType int NOT NULL DEFAULT '0',
  PrinterID varchar(50) NULL,
  SubmitOrderStaffID int NOT NULL DEFAULT '0',
  KDSStartTime datetime NULL,
  FinishStaffID int NOT NULL DEFAULT '0',
  KDSFinishTime datetime NULL,
  OrderDate date NULL,
  TableID int NOT NULL DEFAULT '0',
  DisplayTableName varchar(200) NULL,
  KDSStatus tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID, ProcessID, OrderKDSID, KDSStep)
) TYPE=InnoDB;

CREATE TABLE KDS_OrderProcessHeaderFront (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ProcessID int NOT NULL DEFAULT '0',
  SubmitOrderStaffID int NOT NULL DEFAULT '0',
  ProcessStartTime datetime NULL,
  FinishStaffID int NOT NULL DEFAULT '0',
  ProcessFinishTime datetime NULL,
  SaleModeID tinyint NOT NULL DEFAULT '0',
  SaleModeName varchar(100) NULL,
  OrderDate date NULL,
  TableID int NOT NULL DEFAULT '0',
  DisplayTableName varchar(200) NULL,
  KDSStatus tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, ProcessID)
) TYPE=InnoDB;

CREATE TABLE KDS_OrderProcessDetailFront (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  OrderDetailID int NOT NULL DEFAULT '0',
  ProcessID int NOT NULL DEFAULT '0',
  OrderKDSID  int NOT NULL DEFAULT '0',
  KDSStep tinyint NOT NULL DEFAULT '0',
  KDSID tinyint NOT NULL DEFAULT '0',
  ProductID int NOT NULL DEFAULT '0',
  ProductAmount decimal(18,4) NOT NULL DEFAULT '0',
  ProductHeaderName varchar(100) NULL,
  ProductName varchar(100) NULL,
  ProductComment varchar(1000) NULL,
  ProductSetType int NOT NULL DEFAULT '0',
  PrinterID varchar(50) NULL,
  SubmitOrderStaffID int NOT NULL DEFAULT '0',
  KDSStartTime datetime NULL,
  FinishStaffID int NOT NULL DEFAULT '0',
  KDSFinishTime datetime NULL,
  OrderDate date NULL,
  TableID int NOT NULL DEFAULT '0',
  DisplayTableName varchar(200) NULL,
  KDSStatus tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID, ProcessID, OrderKDSID, KDSStep)
) TYPE=InnoDB;

ALTER TABLE KDS_OrderProcessHeader ADD ShopID int NOT NULL DEFAULT '0' After SaleModeName;
ALTER TABLE KDS_OrderProcessHeaderFront ADD ShopID int NOT NULL DEFAULT '0' After SaleModeName;
ALTER TABLE KDS_OrderProcessDetail ADD ShopID int NOT NULL DEFAULT '0' After KDSFinishTime;
ALTER TABLE KDS_OrderProcessDetailFront ADD ShopID int NOT NULL DEFAULT '0' After KDSFinishTime;

ALTER TABLE KDS_OrderProcessHeader ADD SubmitOrderDateTime DateTime NULL After SubmitOrderStaffID;
ALTER TABLE KDS_OrderProcessHeaderFront ADD SubmitOrderDateTime DateTime NULL After SubmitOrderStaffID;

INSERT INTO KDSStatus(KDSStatusID, KDSStatus) VALUES (0,'Wait For Process');

-- 18/07/2013 Add Warning/CriteriaTime, Previous/ Current KDSID
ALTER TABLE KDS_ProductSetting ADD WarningTime tinyint NOT NULL DEFAULT '0' After DelayMinute;
ALTER TABLE KDS_ProductSetting ADD CriticalTime tinyint NOT NULL DEFAULT '0' After WarningTime;

ALTER TABLE KDS_OrderProcessDetail ADD PreviousKDSStep tinyint NOT NULL DEFAULT '0' After KDSID;
ALTER TABLE KDS_OrderProcessDetail ADD NextKDSStep tinyint NOT NULL DEFAULT '0' After PreviousKDSStep;
ALTER TABLE KDS_OrderProcessDetailFront ADD PreviousKDSStep tinyint NOT NULL DEFAULT '0' After KDSID;
ALTER TABLE KDS_OrderProcessDetailFront ADD NextKDSStep tinyint NOT NULL DEFAULT '0' After PreviousKDSStep;

-- HeaderGroupID 
ALTER TABLE KDS_OrderProcessHeader ADD HeaderGroupID tinyint NOT NULL DEFAULT '0' After KDSStatus;
ALTER TABLE KDS_OrderProcessHeaderFront ADD HeaderGroupID tinyint NOT NULL DEFAULT '0' After KDSStatus;
-- Summary KDSID
ALTER TABLE KDS_OrderProcessHeader ADD SummaryKDSID tinyint NOT NULL DEFAULT '0' After HeaderGroupID;
ALTER TABLE KDS_OrderProcessHeaderFront ADD SummaryKDSID tinyint NOT NULL DEFAULT '0' After HeaderGroupID;

-- KDS SaleMode Setting
CREATE TABLE KDS_SaleModePropertySetting (
  SaleMode tinyint NOT NULL DEFAULT '0',
  ProductLevelID int NOT NULL DEFAULT '0',
  KDSHeaderWarningTime tinyint NOT NULL DEFAULT '0',
  KDSHeaderCriticalTime tinyint NOT NULL DEFAULT '0',
  IsPrintToPrinter tinyint NOT NULL DEFAULT '0',
  AutoInsertDataToKDSTransactionTable tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (SaleMode, ProductLevelID)
) TYPE=InnoDB;
Insert INTO KDS_SaleModePropertySetting(SaleMode, ProductLevelID, KDSHeaderWarningTime, KDSHeaderCriticalTime, IsPrintToPrinter, AutoInsertDataToKDSTransactionTable)
Select SaleMode, ProductLevelID,0,0,1,0 From SaleModeProductLevelProperty;

-- 24/07/2013 PropertyID = 101 Assign seat When Order
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 101, 2, "Assign Seat No When Ordering", "1 = Assign Seat No When Ordering");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 101, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (101,1,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (101,1,2, 'Yes', 1, 1, 0);

CREATE TABLE SeatNoMapping (
  SeatID tinyint NOT NULL DEFAULT '0',
  SeatName varchar(10) NULL,
  PRIMARY KEY  (SeatID)
) TYPE=InnoDB;
Insert INTO SeatNoMapping(SeatID, SeatName) VALUES(1,'A'),(2,'B'),(3,'C'),(4,'D'),(5,'E'),(6,'F'),(7,'G'),(8,'H'),(9,'I'),(10,'J');

-- KDS TransactionDetail
ALTER TABLE KDSTransactionDetail ADD QueueName varchar(50) NULL After TransactionName;
ALTER TABLE KDSTransactionDetail ADD SaleMode tinyint NOT NULL DEFAULT '0' After QueueName;

ALTER TABLE KDSTransactionDetailFront ADD QueueName varchar(50) NULL After TransactionName;
ALTER TABLE KDSTransactionDetailFront ADD SaleMode tinyint NOT NULL DEFAULT '0' After QueueName;

ALTER TABLE KDSStatus ADD DisplayName varchar(50) NULL After KDSStatus;
Update KDSStatus Set DisplayName = KDSStatus Where DisplayName IS NULL;

ALTER TABLE KDS_SaleModePropertySetting ADD DisplayTimeInScreenAfterFinish tinyint NOT NULL DEFAULT '2' After AutoInsertDataToKDSTransactionTable;

-- Add SeatID, SeatNo In OrderProcessDetail
ALTER TABLE KDS_OrderProcessDetail ADD SeatID tinyint NOT NULL DEFAULT '0' After DisplayTableName;
ALTER TABLE KDS_OrderProcessDetail ADD SeatNo varchar(10) NULL After SeatID;

ALTER TABLE KDS_OrderProcessDetailFront ADD SeatID tinyint NOT NULL DEFAULT '0' After DisplayTableName;
ALTER TABLE KDS_OrderProcessDetailFront ADD SeatNo varchar(10) NULL After SeatID;

ALTER TABLE KDS_SaleModePropertySetting CHANGE AutoInsertDataToKDSTransactionTable InsertDataToKDSTransactionAfterPaid tinyint NOT NULL DEFAULT '0';
ALTER TABLE KDS_SaleModePropertySetting ADD IsPrintSummaryToPrinter tinyint NOT NULL DEFAULT '0' After IsPrintToPrinter;

-- 26/07/2013 Alter OrderPrinterDetailTemp Compatable For Print KDS_OrderProcess
ALTER TABLE OrderPrinterDetailTemp ADD ForPrintKDS tinyint NOT NULL DEFAULT '0' After PrinterID;
ALTER TABLE OrderPrinterDetailTemp ADD ProcessID int NOT NULL DEFAULT '0' After ForPrintKDS;
ALTER TABLE OrderPrinterDetailTemp ADD KDSStep tinyint NOT NULL DEFAULT '0' After ProcessID;
ALTER TABLE OrderPrinterDetailTemp ADD PrintFromComputerID int NOT NULL DEFAULT '0' After KDSStep;

-- 29/07/2013 Add Print For KDS Print Summary
ALTER TABLE KDS_SaleModePropertySetting ADD SummaryPrinterID varchar(50) NULL After IsPrintSummaryToPrinter;


INSERT INTO KDSStatus(KDSStatusID, KDSStatus, DisplayName) VALUES(88,'Already Click For Void','Already Click For Void');
INSERT INTO KDSStatus(KDSStatusID, KDSStatus, DisplayName) VALUES(89,'Already Click For Cancel','Already Click For Cancel');
INSERT INTO KDSStatus(KDSStatusID, KDSStatus, DisplayName) VALUES(98,'Void','Void');

-- 05/08/2013 VoucherReuseType
CREATE TABLE VoucherReuseType (
  ReuseType tinyint NOT NULL DEFAULT '0',
  Description varchar(50) NULL,
  PRIMARY KEY  (ReuseType)
) TYPE=InnoDB;
Insert INTO VoucherReuseType(ReuseType, Description) VALUES(0, 'One Time Coupon');
Insert INTO VoucherReuseType(ReuseType, Description) VALUES(1, 'Reused Coupon');
Insert INTO VoucherReuseType(ReuseType, Description) VALUES(2, 'Next Transaction Coupon');
Insert INTO VoucherReuseType(ReuseType, Description) VALUES(3, 'Auto Add Coupon');

-- 06/08/2013 Transfer DataType --> DocumentTemplate
INSERT INTO TransferDataType(DataTypeID, DataTypeCode, DataTypeName, DataTypeDescription) VALUES(29,'DOCTEM','Document Template','ข้อมูล Document Template');
INSERT INTO TransferDataTypeFor(DataTypeFor, DataTypeID) VALUES(1, 29);


-- 07/08/2013 KDS Print JobOrder
CREATE TABLE KDS_PrintJobOrderDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  OrderDetailID int NOT NULL DEFAULT '0',
  ProcessID int NOT NULL DEFAULT '0',
  KDSStep int NOT NULL DEFAULT '0',
  PrintNo int NOT NULL DEFAULT '0',
  IsPrintSummary tinyint NOT NULL DEFAULT '0',
  SaleMode tinyint NOT NULL DEFAULT '0',
  SaleModeName varchar(100) NULL,
  ProductHeader varchar(100) NULL,
  ProductName varchar(100) NULL,
  ProductComment varchar(1000) NULL,
  ProductSetType int NOT NULL DEFAULT '0',
  Amount decimal(18,4) NOT NULL DEFAULT '0',
  KDSDate date NULL,
  KDSStartTime datetime NULL,
  KDSFinishTime datetime NULL,
  ProcessStartTime datetime NULL,
  ProcessFinishTime datetime NULL,
  ProcessMinute int NOT NULL DEFAULT '0',
  DisplayTableName varchar(255) NULL,
  SeatNo varchar(100) NULL,
  KDSStatus tinyint NOT NULL DEFAULT '0',
  PrintStaffName varchar(100) NULL,
  InsertDateTime DateTime NULL,
  PrintDateTime DateTime NULL,
  FinishPrintDateTime DateTime NULL,
  PrinterID int NOT NULL DEFAULT '0',
  PrinterName varchar(100) NULL,
  PrinterProperty varchar(255) NULL,
  JobOrderFromComputerID int NOT NULL DEFAULT '0',
  JobOrderStatus tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID, ProcessID, KDSStep, PrintNo, PrinterID)
) TYPE=InnoDB;

CREATE TABLE KDS_PrintJobOrderDetailFront (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  OrderDetailID int NOT NULL DEFAULT '0',
  ProcessID int NOT NULL DEFAULT '0',
  KDSStep int NOT NULL DEFAULT '0',
  PrintNo int NOT NULL DEFAULT '0',
  IsPrintSummary tinyint NOT NULL DEFAULT '0',
  SaleMode tinyint NOT NULL DEFAULT '0',
  SaleModeName varchar(100) NULL,
  ProductHeader varchar(100) NULL,
  ProductName varchar(100) NULL,
  ProductComment varchar(1000) NULL,
  ProductSetType int NOT NULL DEFAULT '0',
  Amount decimal(18,4) NOT NULL DEFAULT '0',
  KDSDate date NULL,
  KDSStartTime datetime NULL,
  KDSFinishTime datetime NULL,
  ProcessStartTime datetime NULL,
  ProcessFinishTime datetime NULL,
  ProcessMinute int NOT NULL DEFAULT '0',
  DisplayTableName varchar(255) NULL,
  SeatNo varchar(100) NULL,
  KDSStatus tinyint NOT NULL DEFAULT '0',
  PrintStaffName varchar(100) NULL,
  InsertDateTime DateTime NULL,
  PrintDateTime DateTime NULL,
  FinishPrintDateTime DateTime NULL,
  PrinterID int NOT NULL DEFAULT '0',
  PrinterName varchar(100) NULL,
  PrinterProperty varchar(255) NULL,
  JobOrderFromComputerID int NOT NULL DEFAULT '0',
  JobOrderStatus tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID, ProcessID, KDSStep, PrintNo, PrinterID)
) TYPE=InnoDB;

-- 11/08/2013 KDS Note/ Acknowledge
ALTER TABLE KDS_ProductSetting ADD KDSStepComment varchar(100) NULL After KDSID;

ALTER TABLE KDS_OrderProcessDetail ADD KDSStepComment varchar(100) NULL After KDSFinishTime;
ALTER TABLE KDS_OrderProcessDetail ADD AcknowledgeStatus tinyint NOT NULL DEFAULT '0'After KDSStatus;

ALTER TABLE KDS_OrderProcessDetailFront ADD KDSStepComment varchar(100) NULL After KDSFinishTime;
ALTER TABLE KDS_OrderProcessDetailFront ADD AcknowledgeStatus tinyint NOT NULL DEFAULT '0'After KDSStatus;

-- Update KDS Primary Key For Support 1 KDSStep Multiple KDSID
ALTER TABLE KDS_OrderProcessDetailFront DROP Primary KEY, ADD Primary Key (TransactionID, ComputerID, OrderDetailID, ProcessID, OrderKDSID, KDSStep, KDSID);
ALTER TABLE KDS_OrderProcessDetail DROP Primary KEY, ADD Primary Key (TransactionID, ComputerID, OrderDetailID, ProcessID, OrderKDSID, KDSStep, KDSID);

ALTER TABLE KDS_ProductSetting DROP Primary KEY, ADD Primary Key (ProductID, ProductLevelID, KDSStep, KDSID);

ALTER TABLE OrderPrinterDetailTemp ADD KDSID int NOT NULL DEFAULT '0' After KDSStep;
ALTER TABLE OrderPrinterDetailTemp DROP Primary KEY, ADD Primary Key (TransactionID, ComputerID, OrderDetailID, PrinterID, ProcessID, KDSStep, KDSID);

ALTER TABLE KDS_PrintJobOrderDetailFront ADD KDSID int NOT NULL DEFAULT '0' After KDSStep;
ALTER TABLE KDS_PrintJobOrderDetailFront DROP Primary KEY, ADD Primary Key (TransactionID, ComputerID, OrderDetailID, ProcessID, KDSStep, KDSID, PrintNo);
ALTER TABLE KDS_PrintJobOrderDetail ADD KDSID int NOT NULL DEFAULT '0' After KDSStep;
ALTER TABLE KDS_PrintJobOrderDetail DROP Primary KEY, ADD Primary Key (TransactionID, ComputerID, OrderDetailID, ProcessID, KDSStep, KDSID, PrintNo);

-- 16/07/2013 Buffet Time For Each Product
ALTER TABLE ProductBuffetSetting ADD ProductBuffetTime int NOT NULL DEFAULT '0' After ExtentProductID;


-- 19/08/2013 Ordering In OrderDetail
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 102, 2, "Display Order In Ordering Page", "1 = Display Last Order At End of the List.");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 102, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,102,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,102,2, 'Yes', 1, 1, 0);

CREATE TABLE KDS_RefreshDisplayData (
  RefreshFromComputerID int NOT NULL DEFAULT '0',
  KDSID int NOT NULL DEFAULT '0',
  IPAddress varchar(50) NULL,
  IsForDisplayQueue tinyint NOT NULL DEFAULT '0',
  InsertDate datetime NULL
) TYPE=InnoDB;

Update ProgramProperty Set CanChangeAtBranch = 1 Where PropertyID = 4 AND ProgramTypeID = 2;

-- 27/08/2013 KDSSummaryType
ALTER TABLE KDS_SaleModePropertySetting ADD KDSSummaryType tinyint NOT NULL DEFAULT '0' After DisplayTimeInScreenAfterFinish;


-- KDS Setting
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) VALUES(40215,1,'KDSSetting','Preferences/settingKDS.aspx',1005,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,40215,'KDS Setting',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,40215,'ตั้งค่า KDS',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,40215);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,40215);

-- Delivery Address
CREATE TABLE Delivery_CustomerAddress (
  AddressID int NOT NULL DEFAULT '0',
  AddressTypeID int NOT NULL DEFAULT '0', 
  CustomerID int NOT NULL DEFAULT '0',
  ContactName varchar(100) NULL,
  PhoneType tinyint NOT NULL DEFAULT '0',
  PhoneNumber varchar(20) NULL,
  PhoneExt  varchar(10) NULL,
  AddressName varchar(255) NULL,
  BuildingNo varchar(20) NULL,
  Floor varchar(10) NULL,
  RoomNumber varchar(10) NULL,
  AddressArea varchar(200) NULL,
  AddressNumber varchar(10) NULL,
  Soi varchar(255) NULL,
  Moo varchar(10) NULL,
  Address1 varchar(255) NULL,
  Address2 varchar(255) NULL,
  District varchar(100) NULL,
  City varchar(100) NULL,
  ProvinceID int NOT NULL DEFAULT '0',
  CountryID int NOT NULL DEFAULT '0',
  ZipCode varchar(10) NULL,
  GeneralDirection varchar(500) NULL,
  LangID smallint NOT NULL DEFAULT '0',
  PRIMARY KEY  (AddressID)
) TYPE=InnoDB;

CREATE TABLE Delivery_CustomerDetail (
  CustomerID int NOT NULL DEFAULT '0',
  CustomerTypeID smallint NOT NULL DEFAULT '0', 
  CustomerTitleID tinyint NOT NULL DEFAULT '0',
  CustomerFirstName varchar(100) NULL,
  CustomerMiddelName varchar(50) NULL,
  CustomerLastName varchar(100) NULL,
  MemberCode varchar(50) NULL,
  DateOfBirth datetime NULL,
  Gender tinyint NOT NULL DEFAULT '0',
  MaritalStatus tinyint NOT NULL DEFAULT '0',
  RegistrationID varchar(100) NULL,
  LangID smallint NOT NULL DEFAULT '0',
  AddressID int NOT NULL DEFAULT '0',
  Deleted tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (CustomerID)
) TYPE=InnoDB;

CREATE TABLE Delivery_CustomerPhone (
  CustomerID int NOT NULL DEFAULT '0',
  PhoneNumber varchar(20) NULL,
  PhoneType tinyint NOT NULL DEFAULT '0',
  PhoneExt  varchar(10) NULL,
  PRIMARY KEY  (CustomerID, PhoneNumber)
) TYPE=InnoDB;

CREATE TABLE Delivery_CustomerType (
  CustomerTypeID int NOT NULL DEFAULT '0',
  CustomerTypeName varchar(100) NULL,
  Deleted tinyint NOT NULL DEFAULT '0', 
  PRIMARY KEY  (CustomerTypeID)
) TYPE=InnoDB;

CREATE TABLE Delivery_CustomerTitle (
  CustomerTitleID tinyint NOT NULL DEFAULT '0',
  CustomerTitleName varchar(100) NULL,
  PRIMARY KEY  (CustomerTitleID)
) TYPE=InnoDB;

CREATE TABLE Delivery_AddressCountry (
  CountryID int NOT NULL DEFAULT '0',
  CountryCode varchar(10) NULL,
  CountryName varchar(100) NULL,
  LangID int NOT NULL DEFAULT '0',
  Deleted tinyint NOT NULL DEFAULT '0', 
  PRIMARY KEY  (CountryID, LangID)
) TYPE=InnoDB;

CREATE TABLE Delivery_AddressProvince (
  ProvinceID int NOT NULL DEFAULT '0',
  ProvinceName varchar(100) NULL,
  CountryID int NOT NULL DEFAULT '0', 
  RegionID int NOT NULL DEFAULT '0', 
  LangID int NOT NULL DEFAULT '0', 
  Deleted tinyint NOT NULL DEFAULT '0', 
  PRIMARY KEY  (ProvinceID, LangID)
) TYPE=InnoDB;

CREATE TABLE Delivery_AddressRegion (
  RegionID int NOT NULL DEFAULT '0',
  RegionName varchar(100) NULL,
  CountryID int NOT NULL DEFAULT '0', 
  Deleted tinyint NOT NULL DEFAULT '0', 
  PRIMARY KEY  (RegionID)
) TYPE=InnoDB;

CREATE TABLE Delivery_PhoneType (
  PhoneTypeID int NOT NULL DEFAULT '0',
  PhoneTypeName varchar(100) NULL,
  Deleted tinyint NOT NULL DEFAULT '0', 
  PRIMARY KEY  (PhoneTypeID)
) TYPE=InnoDB;
INSERT INTO Delivery_PhoneType(PhoneTypeID, PhoneTypeName, Deleted) VALUES(1, 'Home', 0);
INSERT INTO Delivery_PhoneType(PhoneTypeID, PhoneTypeName, Deleted) VALUES(2, 'Office', 0);

-- Alter Table OrderTransactionDeliveryDetail
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryCustomerID int NOT NULL DEFAULT '0' After MemberID;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryAddressName varchar(255) NULL After DeliveryCustomerID;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryBuildingNo varchar(20) NULL After DeliveryAddressName;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryFloor varchar(10) NULL After DeliveryBuildingNo;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryRoomNumber varchar(10) NULL After DeliveryFloor;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryAddressArea varchar(200) NULL After DeliveryRoomNumber;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryAddressNumber varchar(10) NULL After DeliveryAddressArea;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliverySoi varchar(255) NULL After DeliveryAddressNumber;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryMoo varchar(10) NULL After DeliverySoi;

ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryDistrict varchar(100) NULL After DeliveryCity;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryCountry int NOT NULL DEFAULT '0' After DeliveryProvince;
ALTER TABLE OrderTransactionDeliveryDetail ADD DeliveryGeneralDirection varchar(500) NULL After DeliveryZipCode;

ALTER TABLE OrderTransactionDeliveryDetail ADD DispatchID int NOT NULL DEFAULT '0' After DeliveryStatus;
ALTER TABLE OrderTransactionDeliveryDetail ADD DispatchTime datetime NULL After DispatchID;
ALTER TABLE OrderTransactionDeliveryDetail ADD ToCustomerTime datetime NULL After DispatchTime;
ALTER TABLE OrderTransactionDeliveryDetail ADD CompleteTime datetime NULL After ToCustomerTime;

ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryCustomerID int NOT NULL DEFAULT '0' After MemberID;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryAddressName varchar(255) NULL After DeliveryCustomerID;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryBuildingNo varchar(20) NULL After DeliveryAddressName;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryFloor varchar(10) NULL After DeliveryBuildingNo;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryRoomNumber varchar(10) NULL After DeliveryFloor;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryAddressArea varchar(200) NULL After DeliveryRoomNumber;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryAddressNumber varchar(10) NULL After DeliveryAddressArea;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliverySoi varchar(255) NULL After DeliveryAddressNumber;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryMoo varchar(10) NULL After DeliverySoi;

ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryDistrict varchar(100) NULL After DeliveryCity;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryCountry int NOT NULL DEFAULT '0' After DeliveryProvince;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DeliveryGeneralDirection varchar(500) NULL After DeliveryZipCode;

ALTER TABLE OrderTransactionDeliveryDetailFront ADD DispatchID int NOT NULL DEFAULT '0' After DeliveryStatus;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD DispatchTime datetime NULL After DispatchID;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD ToCustomerTime datetime NULL After DispatchTime;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD CompleteTime datetime NULL After ToCustomerTime;

-- Delivery Addrees 3 Level
CREATE TABLE Delivery_AddressAreaLv1 (
  AreaLV1ID int NOT NULL DEFAULT '0',
  AreaLV1Name varchar(50) NULL,
  Deleted tinyint NOT NULL DEFAULT '0', 
  Ordering int NOT NULL DEFAULT '0',
  PRIMARY KEY  (AreaLV1ID)
) TYPE=InnoDB;

CREATE TABLE Delivery_AddressAreaLv2 (
  AreaLV2ID int NOT NULL DEFAULT '0',
  AreaLV1ID int NOT NULL DEFAULT '0',
  AreaLV2Name varchar(50) NULL,
  Deleted tinyint NOT NULL DEFAULT '0', 
  Ordering int NOT NULL DEFAULT '0',
  PRIMARY KEY  (AreaLV2ID)
) TYPE=InnoDB;

CREATE TABLE Delivery_AddressAreaLv3 (
  AreaLV3ID int NOT NULL DEFAULT '0',
  AreaLV2ID int NOT NULL DEFAULT '0',
  AreaLV3Name varchar(50) NULL,
  Soi varchar(255) NULL,
  Moo varchar(10) NULL,
  Address1 varchar(255) NULL,
  Address2 varchar(255) NULL,
  District varchar(100) NULL,
  City varchar(100) NULL,
  ProvinceID int NOT NULL DEFAULT '0',
  CountryID int NOT NULL DEFAULT '0',
  ZipCode varchar(10) NULL, 
  Deleted tinyint NOT NULL DEFAULT '0', 
  Ordering int NOT NULL DEFAULT '0',
  PRIMARY KEY  (AreaLV3ID)
) TYPE=InnoDB;

CREATE TABLE Delivery_AddressAreaLVShopLink (
  ProductLevelID int NOT NULL DEFAULT '0',
  AreaLV1ID int NOT NULL DEFAULT '0',
  PRIMARY KEY  (AreaLV1ID, ProductLevelID)
) TYPE=InnoDB;

ALTER TABLE Delivery_AddressAreaLV3 ADD DeliveryQuoteTime int NOT NULL DEFAULT '30' After ZipCode;

ALTER TABLE OrderTransactionDeliveryDetailFront ADD QuoteTime int NOT NULL DEFAULT '0' After OrderDateTime;
ALTER TABLE OrderTransactionDeliveryDetail ADD QuoteTime int NOT NULL DEFAULT '0' After OrderDateTime;

ALTER TABLE SaleMode ADD SaleModeType int NOT NULL DEFAULT '0' After HasServiceCharge;

-- 09/09/2013 Cancel Bill Transaction Status
INSERT INTO OrderTransactionStatus(TransactionStatusID, Description) VALUES (16,'Cancel Bill');

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)VALUES (193,6,'Cancel_Current_Sale','',12,0,NULL,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES(30007,193,'Cancel Current Sale Order',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES (30006,193,'ยกเลิกรายการที่กำลังขาย',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=193) OR (StaffRoleID=2 AND PermissionItemID=193);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,193);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,193);

INSERT INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionGroupID, FrontFunctionCode, Description, Description_TH, DisplayInReport) VALUES(36, 3, 'PVTRANS', 'Print Void Transaction', 'พิมพ์ใบเสร็จที่ยกเลิก', 1);
INSERT INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionGroupID, FrontFunctionCode, Description, Description_TH, DisplayInReport) VALUES(37, 3, 'PVBILL', 'Print Cancel Transaction', 'พิมพ์ใบรายการที่ยกเลิกการขาย', 1);

-- 10/09/2013 Clear Table Access History
ALTER TABLE HistoryOfFeatureOnComputer ADD TableID int NOT NULL DEFAULT '0' After ProductLevelID;

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)VALUES (194,6,'ClearAccessTable','',69,0,NULL,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES(1,194,'Clear Current Access Table',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES (2,194,'ปลดการเข้าใช้โต๊ะจากโปรแกรม',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=194) OR (StaffRoleID=2 AND PermissionItemID=194);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,194);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,194);

INSERT INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionGroupID, FrontFunctionCode, Description, Description_TH, DisplayInReport) VALUES(38, 6, 'CLACCTAB', 'Clear Access Computer', 'ปลดการเข้าใช้โต๊ะจากโปรแกรม', 1);
INSERT INTO ReasonTextGroup(ReasonGroupID, ReasonGroupName, Enabled) VALUE(10, 'Clear Access Table', 1);

-- Show Tab Table Grid
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1064, 3, "Show Tab Table Grid", "0=Not show (Default), 1=Show tab Table Grid");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) 
Select 1, 1064, ComputerID, 1, '', NULL From ComputerName c LEFT OUTER JOIN ProgramPropertyValue pv ON pv.PropertyID = 1064 AND pv.ProgramTypeID = 1 AND pv.KeyID = c.ComputerID Where c.Deleted = 0 AND pv.PropertyID IS NULL;

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1064,1, 'Not Show', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1064,2, 'Show Tab', 1, 1, 0);

-- 10/09/2013 Change Table Grid From 1064 To 1065
Update ProgramProperty Set PropertyID = 1065 Where PropertyID = 1064 AND ProgramTypeID = 1;
Update ProgramPropertyValue Set PropertyID = 1065 Where PropertyID = 1064 AND ProgramTypeID = 1;
Update PropertyOption Set PropertyID = 1065 Where PropertyID = 1064 AND PropertyTypeID = 1;

-- TakeAway Tab
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1062, 2, "Show Tab TakeAway", "0=Not show (Default), 1=Show tab Take Away");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1062, 1, 0, '', NULL);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1062,1, 'Not Show', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1062,2, 'Show Tab', 1, 1, 0);
-- Delivery Tab
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1063, 2, "Show Tab Delivery", "0=Not show (Default), 1=Show tab Delivery");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1063, 1, 0, '', NULL);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1063,1, 'Not Show', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1063,2, 'Show Tab', 1, 1, 0);
-- KDS Delay Tab
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1064, 3, "Show Tab KDS Delay", "0=Not show (Default), 1=Show tab KDS Delay");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1064, 1, 1, '', NULL);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1064,1, 'Not Show', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1064,2, 'Show Tab', 1, 1, 0);


-- 16/09/2013 SourceID For Delivery
ALTER TABLE SaleModeProductLevelProperty ADD MaxTaskForDeliveryDispatcher tinyint NOT NULL DEFAULT '1' After SaleModeProperty;

ALTER TABLE OrderTransactionDeliveryDetail ADD SourceID tinyint NOT NULL DEFAULT '0' After SaleMode;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD SourceID tinyint NOT NULL DEFAULT '0' After SaleMode;

CREATE TABLE Delivery_SourceDescription (
  SourceID int NOT NULL DEFAULT '0',
  Description varchar(100) NULL,
  PRIMARY KEY  (SourceID)
) TYPE=InnoDB;
INSERT INTO Delivery_SourceDescription(SourceID, Description) VALUES (1,'Transfer Order To Other Shop');
INSERT INTO Delivery_SourceDescription(SourceID, Description) VALUES (2,'Transfer Order From Other Shop');

-- Delivery Transfer
CREATE TABLE Delivery_TransferOutTransactionFront (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ShopID int NOT NULL DEFAULT '0',
  ToShopID int NOT NULL DEFAULT '0',
  TransferOutName varchar(100) NULL,
  TransferOutTelephone varchar(100) NULL,
  TransferOutMobile varchar(100) NULL,
  TransferOutNote varchar(255) NULL,
  IPAddress varchar(100) NULL,
  DatabaseName varchar(100) NULL,
  SendToStatus tinyint NOT NULL DEFAULT '0',
  SendTime datetime NULL,
  PRIMARY KEY  (TransactionID, ComputerID)
) TYPE=InnoDB;

CREATE TABLE Delivery_TransferOutTransaction (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ShopID int NOT NULL DEFAULT '0',
  ToShopID int NOT NULL DEFAULT '0',
  TransferOutName varchar(100) NULL,
  TransferOutTelephone varchar(100) NULL,
  TransferOutMobile varchar(100) NULL,
  TransferOutNote varchar(255) NULL,
  IPAddress varchar(100) NULL,
  DatabaseName varchar(100) NULL,
  SendToStatus tinyint NOT NULL DEFAULT '0',
  SendTime datetime NULL,
  PRIMARY KEY  (TransactionID, ComputerID)
) TYPE=InnoDB;

-- Delivery Transfer At Destination
CREATE TABLE Delivery_TransferInTransactionFront (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ShopID int NOT NULL DEFAULT '0',
  FromShopID int NOT NULL DEFAULT '0',
  FromTransactionID int NOT NULL DEFAULT '0',
  FromComputerID int NOT NULL DEFAULT '0',
  TransferOutName varchar(100) NULL,
  TransferOutTelephone varchar(100) NULL,
  TransferOutMobile varchar(100) NULL,
  TransferOutNote varchar(255) NULL,
  InsertTime datetime NULL,
  PRIMARY KEY  (TransactionID, ComputerID)
) TYPE=InnoDB;

CREATE TABLE Delivery_TransferInTransaction (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ShopID int NOT NULL DEFAULT '0',
  FromShopID int NOT NULL DEFAULT '0',
  FromTransactionID int NOT NULL DEFAULT '0',
  FromComputerID int NOT NULL DEFAULT '0',
  TransferOutName varchar(100) NULL,
  TransferOutTelephone varchar(100) NULL,
  TransferOutMobile varchar(100) NULL,
  TransferOutNote varchar(255) NULL,
  InsertTime datetime NULL,
  PRIMARY KEY  (TransactionID, ComputerID)
) TYPE=InnoDB;

CREATE TABLE Delivery_TransferToOtherShopProperty (
  ID tinyint NOT NULL DEFAULT '0',
  PayIDForTransferTo int NOT NULL DEFAULT '0',
  PRIMARY KEY  (ID)
) TYPE=InnoDB;
INSERT INTO Delivery_TransferToOtherShopProperty(ID, PayIDForTransferTo) VALUES (1,0);

ALTER TABLE OrderTransactionDeliveryDetailFront ADD TotalTaskForDispatcher tinyint NOT NULL DEFAULT '1' After DispatchID;
ALTER TABLE OrderTransactionDeliveryDetail ADD TotalTaskForDispatcher tinyint NOT NULL DEFAULT '1' After DispatchID;

CREATE TABLE Delivery_DispatcherTaskLinkFront (
  TaskID varchar(50) NOT NULL DEFAULT '',
  DispatchID int NOT NULL DEFAULT '0',
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ShopID int NOT NULL DEFAULT '0',
  DeliveryDate date NULL,
  InsertDateTime datetime NULL,
  PRIMARY KEY  (TaskID, DispatchID, TransactionID, ComputerID)
) TYPE=InnoDB;

CREATE TABLE Delivery_DispatcherTaskLink (
  TaskID varchar(50) NOT NULL DEFAULT '',
  DispatchID int NOT NULL DEFAULT '0',
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ShopID int NOT NULL DEFAULT '0',
  DeliveryDate date NULL,  
  InsertDateTime datetime NULL,
  PRIMARY KEY  (TaskID, DispatchID, TransactionID, ComputerID)
) TYPE=InnoDB;



-- 20/09/2013
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1066, 3, "Show Tab Table Transfer Out", "0=Not show (Default), 1=Show tab Table Transfer Out");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1066, 1, 1, '', NULL);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1066,1, 'Not Show', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1066,2, 'Show Tab', 1, 1, 0);

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1079, 3, "Set default tab table", "0=First tab always, 1=Layout, 2=Simple List, 3=Table List, 4=Grid, 5=Sale Mode, 6=Check Order, 7= Printer Status, 8=Search Table, 9=Search Order, 10=Queue Waiting, 11=Take Away, 12=Delivery, 13=Transfer Out, 14= Kds Delay");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1079, 1, 0, '', NULL);

-- 24/09/2013
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1080, 2, "Delivery QuoteTime (Minute)", "Default 30 Minutes");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1080, 1, 30, '', NULL);

-- 27/09/2013
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1081, 2, "Staff Role for Delivery Rider", "String with comma of Staff Role for Delivery Rider");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1081, 1, 0, '', NULL);

ALTER TABLE KDS_SaleModePropertySetting ADD KDSPrintForm tinyint NOT NULL DEFAULT '0';

-- Default CreditCardType/ BankName PayType
ALTER TABLE PayType ADD DefaultCreditCardType int NOT NULL DEFAULT '0' After MaximumCanPayPrice;
ALTER TABLE PayType ADD DefaultBankName int NOT NULL DEFAULT '0' After DefaultCreditCardType;

ALTER TABLE PayDetail ADD CardHolderName varchar(100) NOT NULL DEFAULT '' AFTER CreditCardNo;
ALTER TABLE PayDetailFront ADD CardHolderName varchar(100) NOT NULL DEFAULT '' AFTER CreditCardNo;

-- ShopID In Delivery_Customer/ Address
ALTER TABLE Delivery_CustomerDetail ADD InsertAtShopID int NOT NULL DEFAULT '0' After LangID;
ALTER TABLE Delivery_CustomerAddress ADD InsertAtShopID int NOT NULL DEFAULT '0' After LangID;

INSERT INTO IDRangeType(IDRangeTypeID, Description) VALUES(16, 'Delivery Customer');
INSERT INTO IDRange(ProductLevelID, IDRangeTypeID, MinID, MaxID, UpdateDate) Select ProductLevelID, 16, MinID, MaxID, UpdateDate From IDRange Where IDRangeTypeID = 1;

ALTER TABLE Delivery_AddressAreaLV1 ADD AreaLV1Code varchar(20) NULL After AreaLV1ID;
ALTER TABLE Delivery_AddressAreaLV2 ADD AreaLV2Code varchar(20) NULL After AreaLV1ID;
ALTER TABLE Delivery_AddressAreaLV3 ADD AreaLV3Code varchar(20) NULL After AreaLV2ID;

ALTER TABLE Delivery_CustomerAddress ADD AreaLV1ID int NOT NULL DEFAULT '0' After GeneralDirection;
ALTER TABLE Delivery_CustomerAddress ADD AreaLV2ID int NOT NULL DEFAULT '0' After AreaLV1ID;
ALTER TABLE Delivery_CustomerAddress ADD AreaLV3ID int NOT NULL DEFAULT '0' After AreaLV2ID;

ALTER TABLE OrderTransactionDeliveryDetail ADD AreaLV1ID int NOT NULL DEFAULT '0' After DeliveryGeneralDirection;
ALTER TABLE OrderTransactionDeliveryDetail ADD AreaLV2ID int NOT NULL DEFAULT '0' After AreaLV1ID;
ALTER TABLE OrderTransactionDeliveryDetail ADD AreaLV3ID int NOT NULL DEFAULT '0' After AreaLV2ID;

ALTER TABLE OrderTransactionDeliveryDetailFront ADD AreaLV1ID int NOT NULL DEFAULT '0' After DeliveryGeneralDirection;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD AreaLV2ID int NOT NULL DEFAULT '0' After AreaLV1ID;
ALTER TABLE OrderTransactionDeliveryDetailFront ADD AreaLV3ID int NOT NULL DEFAULT '0' After AreaLV2ID;

-- 26/09/2013
-- #KDS Sale Mode Property Setting
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID)
VALUES(40216,1,'KDSSetting','Preferences/settingKDSSaleModeProperty.aspx',1006,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,40216,'KDS Sale Mode Property Setting',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,40216,'ตั้งค่า KDS Sale Mode Property',2);
INSERT INTO staffpermission(StaffPermissionID,StaffRoleID,PermissionItemID) VALUES(40222,1,40216);
INSERT INTO staffpermission(StaffPermissionID,StaffRoleID,PermissionItemID) VALUES(40223,2,40216);

-- #Delivery Address Area Setting
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID)
VALUES(40217,1,'DeliveryAddressAreaSetting','Preferences/settingDeliveryAddress.aspx',1007,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,40217,'Delivery Address Area Setting',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,40217,'ตั้งค่า Delivery Address Area',2);
INSERT INTO staffpermission(StaffPermissionID,StaffRoleID,PermissionItemID) VALUES(40224,1,40217);
INSERT INTO staffpermission(StaffPermissionID,StaffRoleID,PermissionItemID) VALUES(40225,2,40217);

-- #Other Income Setting
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID)
VALUES(40218,1,'OtherIncomeSetting','Preferences/settingOtherIncome.aspx',1008,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,40218,'Other Income Setting',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,40218,'ตั้งค่า Other Income',2);
INSERT INTO staffpermission(StaffPermissionID,StaffRoleID,PermissionItemID) VALUES(40226,1,40218);
INSERT INTO staffpermission(StaffPermissionID,StaffRoleID,PermissionItemID) VALUES(40227,2,40218);

-- PromotionCode
ALTER TABLE PromotionPriceGroup ADD PromotionCode varchar(20) NULL After TypeID;
Update PromotionPriceGroup Set PromotionCode = '' Where PromotionCode IS NULL;

ALTER TABLE StaffLogInOutTime ADD SaleDate date NULL After LogOutTime;

ALTER TABLE Delivery_CustomerDetail ADD UpdateDate datetime NULL After InsertAtShopID;
ALTER TABLE Delivery_CustomerAddress ADD UpdateDate datetime NULL After InsertAtShopID;

-- OrderLinkID In KDS
ALTER TABLE KDS_PrintJobOrderDetail ADD OrderLinkID int NOT NULL DEFAULT '0' After ProductSetType;
ALTER TABLE KDS_PrintJobOrderDetailFront ADD OrderLinkID int NOT NULL DEFAULT '0' After ProductSetType;

ALTER TABLE KDS_OrderProcessDetail ADD OrderLinkID int NOT NULL DEFAULT '0' After ProductSetType;
ALTER TABLE KDS_OrderProcessDetailFront ADD OrderLinkID int NOT NULL DEFAULT '0' After ProductSetType;


-- 01/11/2013
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1083, 3, "Login Lock Type", "0=Only Key Pad, 1=Only Finger Print, 2=Both Key pad and Finger print, 3=Face detection, 4=Gesture Pattern");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1083, 1, 0, '', NULL);

-- 08/11/2013 Assign Group Of Add Order 
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 104, 2, "Assign Group No When Ordering", "1 = Assign Group No When Ordering");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 104, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,104,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,104,2, 'Yes', 1, 1, 0);

ALTER TABLE OrderDetail ADD OrderGroupID int NOT NULL DEFAULT '0' After StaffID;
ALTER TABLE OrderDetailFront ADD OrderGroupID int NOT NULL DEFAULT '0' After StaffID;

CREATE TABLE OrderGroupNoMapping (
  GroupNo tinyint NOT NULL DEFAULT '0',
  GroupNoName varchar(20) NULL,
  GroupNoShortName varchar(10) NULL,
  GroupNoPrintName varchar(20) NULL,
  PRIMARY KEY  (GroupNo)
) TYPE=InnoDB;

-- 15/10/2013
ALTER TABLE loyaltymemberinfo ADD AuthenStatus TINYINT(2) NULL DEFAULT 0;
-- 26/10/2013 FullTax BranchType
ALTER TABLE OrderTransactionFullTaxInvoice ADD InvoiceCompanyType tinyint NOT NULL DEFAULT '0' After InvoiceName;
ALTER TABLE OrderTransactionFullTaxInvoice ADD InvoiceCompanyBranchNo varchar(100) NULL After InvoiceCompanyType;

ALTER TABLE OrderTransactionFullTaxInvoiceTemp ADD InvoiceCompanyType tinyint NOT NULL DEFAULT '0' After InvoiceName;
ALTER TABLE OrderTransactionFullTaxInvoiceTemp ADD InvoiceCompanyBranchNo varchar(100) NULL After InvoiceCompanyType;

-- 18/11/2013 SeatPrintName For Print To Kitchen
ALTER TABLE SeatNoMapping ADD SeatPrintName varchar(20) NULL;

-- 09/12/2013 PayByVoucher
ALTER TABLE PayByVoucher CHANGE OriginalAmount OriginalAmount decimal(18,4) NOT NULL DEFAULT '0';
ALTER TABLE PayByVoucher CHANGE UsedAmount UsedAmount decimal(18,4) NOT NULL DEFAULT '0';


-- 04/01/2014 CRM Script 
-- Member
ALTER TABLE Members ADD MemberUDID varchar(50) NULL after MemberID;

ALTER TABLE Members ADD MemberStatus tinyint NOt NULL DEFAULT '1' after Activated;

ALTER TABLE Members ADD InsertAtProductLevelCode varchar(20) NULL after InsertAtProductLevelID;
ALTER TABLE Members ADD InsertAtProductLevelName varchar(100) NULL after InsertAtProductLevelCode;

ALTER TABLE Members ADD AcitvateAtProductLevelID int NOT NULL DEFAULT '0' after InsertAtProductLevelName;
ALTER TABLE Members ADD AcitvateAtProductLevelCode varchar(20) NULL after AcitvateAtProductLevelID;
ALTER TABLE Members ADD ActivateAtProductLevelName varchar(100) NULL after AcitvateAtProductLevelCode;

ALTER TABLE Members ADD UpdateAtProductLevelID int NOT NULL DEFAULT '0' after ActivateAtProductLevelName;
ALTER TABLE Members ADD UpdateAtProductLevelCode varchar(20) NULL after UpateAtProductLevelID;
ALTER TABLE Members ADD UpdateAtProductLevelName varchar(100) NULL after UpdateAtProductLevelCode;


CREATE TABLE MemberStatusDescription (
  MemberStatus tinyint NOT NULL DEFAULT '0',
  Description varchar(100) NULL,
  AllowActivateAtBranch tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY  (MemberStatus)
) TYPE=InnoDB;
INSERT INTO MemberStatusDescription(MemberStatus, Description, AllowActivateAtBranch) VALUES(1, 'Normal', 1);
INSERT INTO MemberStatusDescription(MemberStatus, Description, AllowActivateAtBranch) VALUES(2, 'Blacklist', 0);

CREATE TABLE SyncDataLogFront (
  SyncID int NOT NULL Auto_Increment,
  ProductLevelID int NOT NULL DEFAULT '0',
  SyncType tinyint NOT NULL DEFAULT '0',
  SyncTime datetime NULL,
  SyncSuccess tinyint NOT NULL DEFAULT '0',
  KeyID1 int NOT NULL DEFAULT '0',
  KeyID2 int NOT NULL DEFAULT '0',
  KeyID3 int NOT NULL DEFAULT '0',
  KeyID4 int NOT NULL DEFAULT '0',
  KeyText varchar(50) NULL,
  SyncNote varchar(255) NULL,
  InsertDate datetime NULL,
  UpdateDate datetime NULL,
  PRIMARY KEY  (SyncID, ProductLevelID)
) TYPE=InnoDB;

CREATE TABLE SyncDataLog (
  SyncID int NOT NULL Auto_Increment,
  ProductLevelID int NOT NULL DEFAULT '0',
  SyncType tinyint NOT NULL DEFAULT '0',
  SyncTime datetime NULL,
  SyncSuccess tinyint NOT NULL DEFAULT '0',
  KeyID1 int NOT NULL DEFAULT '0',
  KeyID2 int NOT NULL DEFAULT '0',
  KeyID3 int NOT NULL DEFAULT '0',
  KeyID4 int NOT NULL DEFAULT '0',
  KeyText varchar(50) NULL,
  SyncNote varchar(255) NULL,
  InsertDate datetime NULL,
  UpdateDate datetime NULL,
  PRIMARY KEY  (SyncID, ProductLevelID)
) TYPE=InnoDB;

CREATE TABLE SyncDataType (
  SyncType tinyint NOT NULL DEFAULT '0',
  Description varchar(100) NULL,
  PRIMARY KEY  (SyncType)
) TYPE=InnoDB;
INSERT INTO SyncDataType(SyncType, Description) VALUES(1, 'Activate Member');
INSERT INTO SyncDataType(SyncType, Description) VALUES(2, 'Update Member Detail');
INSERT INTO SyncDataType(SyncType, Description) VALUES(3, 'RewardPointHistory');
INSERT INTO SyncDataType(SyncType, Description) VALUES(4, 'Update Status Coupon/ Voucher');

CREATE TABLE SyncDataForExport (
  ExportID varchar(15) NULL,
  SyncID int NOT NULL DEFAULT '0',
  ProductLevelID int NOT NULL DEFAULT '0',
  SyncType tinyint NOT NULL DEFAULT '0',
  Index (SyncID, ProductLevelID),
  Primary Key (ExportID, SyncID, ProductLevelID)
) TYPE=InnoDB;

-- Action Log
CREATE TABLE ActionDataLog (
  ActionUDID varchar(50) NULL,
  ActionType tinyint NOT NULL DEFAULT '0',
  ActionTime datetime NULL,
  KeyID1 int NOT NULL DEFAULT '0',
  KeyID2 int NOT NULL DEFAULT '0',
  KeyID3 int NOT NULL DEFAULT '0',
  KeyID4 int NOT NULL DEFAULT '0',
  KeyText varchar(50) NULL,
  ActionAtShopID int NOT NULL DEFAULT '0',
  ActionNote varchar(255) NULL,
  ActionStaffID int NOT NULL DEFAULT '0',
  PRIMARY KEY  (ActionUDID)
) TYPE=InnoDB;

CREATE TABLE ActionDataType (
  ActionType tinyint NOT NULL DEFAULT '0',
  Description varchar(100) NULL,
  PRIMARY KEY  (ActionType)
) TYPE=InnoDB;
INSERT INTO ActionDataType(ActionType, Description) VALUES(1, 'Add New Member');
INSERT INTO ActionDataType(ActionType, Description) VALUES(2, 'Update Member Info');
INSERT INTO ActionDataType(ActionType, Description) VALUES(3, 'Activate Member');
INSERT INTO ActionDataType(ActionType, Description) VALUES(4, 'Delete Member');
INSERT INTO ActionDataType(ActionType, Description) VALUES(5, 'Set Blacklist Member');
INSERT INTO ActionDataType(ActionType, Description) VALUES(6, 'Import Member From File');

-- CRM Feature Proeprty
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 105, 1, "CRM At HQ Feature", "1 = Use CRM Feature");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 105, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,105,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,105,2, 'Yes', 1, 1, 0);


-- 09/01/2014 PaymentCashAmount
CREATE TABLE PayDetailDefaultPayAmount (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  DefaultPayAmount decimal(18,4) NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID)
) TYPE=InnoDB;

ALTER TABLE KDS_OrderProcessHeaderFront ADD TransactionReferenceNo varchar(20) NULL After DisplayTableName;
ALTER TABLE KDS_OrderProcessHeader ADD TransactionReferenceNo varchar(20) NULL After DisplayTableName;

ALTER TABLE KDS_OrderProcessHeaderFront ADD IsPaid tinyint NOT NULL DEFAULT '0' After TransactionReferenceNo;
ALTER TABLE KDS_OrderProcessHeader ADD IsPaid tinyint NOT NULL DEFAULT '0' After TransactionReferenceNo;

-- 25/01/2014 
-- DocDetail PricePerUnit To Decimal
ALTER TABLE DocDetail CHANGE ProductPricePerUnit ProductPricePerUnit decimal(18,4) NOT NULL DEFAULT '0';

INSERT INTO PrintJobOrderStatus(JobOrderStatus, Description) VALUES(4, 'Printing');
INSERT INTO PrinterTypeDescription(PrinterTypeID, Description) VALUES(3, 'Printer For Queue System');



-- 03/02/2014 - ExportDataForEachTerminal
CREATE TABLE TransferDataToComputer_TableName (
  TableName varchar(255) NULL
) TYPE=InnoDB;
INSERT INTO TransferDataToComputer_TableName(TableName) 
VALUES('AccountData'),('ComputerAccess'),('ComputerName'),('CompanyProfile'),('BankName'),('CashOutProductDept'),('CashOutProducts'),
('CreditCardType'),('DailyStockMaterial'),('DiscountButton'),('DiscountPriority'),('DocumentType'),('DocumentTypeProperty'),
('DocumentTypeTransferGroupProperty'),('EDC_MappingBankDetail'),('EDC_TypeName'),('FavoriteProductPageIndex'),('FavoriteProducts'),
('FeedCategory'),('FeedContent'),('FeedLink'),('FeedProperty'),('FeedSection'),('FingerPrintDetailMember'),('FingerPrintDetailStaff'),
('IDRange'),('InventoryView'),('KDS_ProductSetting'),('KDS_SaleModePropertySetting'),('Language'),('MagneticCardReaderSetting'),
('MaterialDept'),('MaterialGroup'),('Materials'),('MaterialDocumentTypeSelectSetting'),('MaterialDocumentTypeSelectSettingGroup'),
('MaterialDocumentTypeSelectSettingShop'),('MaterialDocumentTypeUnitSetting'),('MaterialDocumentTypeUnitSettingGroup'),('MaterialDocumentTypeUnitSettingShop'),
('MemberGroup'),('MemberGroupAccess'),('Members'),('OtherIncomeType'),('PaymentAmountButton'),('PayType'),('PayTypeGroup'),
('PermissionCategory'),('PermissionCategoryName'),('PermissionGroup'),('PermissionGroupName'),('PermissionItem'),('PermissionItemName'),
('PrinterByTableZone'),('Printers'),('PComponentGroup'),('Products'),('ProductPrice'),('ProductDept'),('ProductGroup'),
('ProductComponent'),('ProductBuffetSetting'),('ProductFixCommentData'),('ProductGroupByComputer'),('ProductLevel'),('ProductLevelLinkProductGroup'),
('ProductRegion'),('ProductStockInvSetting'),('ProgramProperty'),('ProgramPropertyValue'),('PromotionBonusProduct'),('PromotionDiscount'),
('PromotionLevels'),('PromotionPriceGroup'),('PromotionProducts'),('PromotionShopLink'),('Property'),('QuestionDefineData'),('QuestionDefineDataGroup'),
('QuestionDefineOption'),('QuestionShopLink'),('ReasonText'),('ReasonTextGroup'),('ReceiptHeaderFooter'),('ReceiptPromotionHeaderFooter'),
('RedeemPointProduct'),('RedeemPointSetting'),('RedeemPointShopLink'),('RewardPointSetting'),('RewardPointShopLink'),('RewardPointProductSetting'),
('SaleMode'),('SaleModeProductLevelProperty'),('SeatNoMapping'),('StaffAccess'),('StaffPermission'),('StaffRole'),('StaffRoleAccessInventory'),
('StaffRoleAccessUser'),('StaffRoleViewInventory'),('Staffs'),('TableNo'),('TableZone'),('TextParam'),('TextParamCategory'),('TextParamValue'),
('UserDefineData'),('UserDefineDataGroup'),('UserDefineOption'),('UserDefineValue'),('VoucherDetail'),('VoucherRange'),('Vouchers');

CREATE TABLE TransferDataToComputer_Log (
 LogID int NOT NULL DEFAULT '0',
 FromShopID int NOT NULL DEFAULT '0',
 ExportToComputerID int NOT NULL DEFAULT '0',
 LogDateTime datetime NULL,
 ExportDateTime datetime NULL,
 ImportDateTime datetime NULL,
 FileName varchar(50) NULL,
 PRIMARY KEY  (LogID, FromShopID, ExportToComputerID)
) TYPE=InnoDB;

CREATE TABLE TransferDataToComputer_Setting (
 MySQLDumpFileLocation varchar(255) NULL
) TYPE=InnoDB;
INSERT INTO TransferDataToComputer_Setting(MySQLDumpFileLocation) VALUES('D:\\MySQL5\\bin\\mysqldump');

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 106, 2, "Use Database at Each Terminal", "1 = Use database at its terminal.");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 106, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,106,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,106,2, 'Yes', 1, 1, 0);

CREATE TABLE SessionTerminalEndDayDetail (
 SessionDate date NULL,
 ProductLevelID int NOT NULL DEFAULT '0',
 FromComputerID int NOT NULL DEFAULT '0',
 IsEndDay tinyint NOT NULL DEFAULT '0',
 EndDayStaffID int NOT NULL DEFAULT '0',
 EndDayDateTime datetime NULL,
 TotalReceipt smallint NOT NULL DEFAULT '0',
 TotalPayPrice decimal(18,4) NOT NULL DEFAULT '0',
 EndDayComputerID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (SessionDate, ProductLevelID, FromComputerID)
) TYPE=InnoDB;

-- 12/02/2014 Void RewardPoint Criteria
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 107, 1, "Void Reward Point < 0 Setting", "0 = Not Allow Point < 0, 1 = Allow Point < 0, 2 = Reset Point = 0 When Point < 0.");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 107, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,107,1, 'Not Allow Point < 0', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,107,2, 'Allow Point < 0', 1, 1, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,107,3, 'Reset Point To 0 When Point < 0', 2, 2, 0);

-- 03/02/2014 ReserveDetail
ALTER TABLE ReserveDetail ADD PreOrderTotalPrice decimal(18,4) NOT NULL DEFAULT '0' After ReserveTelephone;
ALTER TABLE ReserveDetail ADD PreOrderDeposit decimal(18,4) NOT NULL DEFAULT '0' After ReserveTelephone;

ALTER TABLE ReserveDetailHistory ADD PreOrderTotalPrice decimal(18,4) NOT NULL DEFAULT '0' After ReserveTelephone;
ALTER TABLE ReserveDetailHistory ADD PreOrderDeposit decimal(18,4) NOT NULL DEFAULT '0' After ReserveTelephone;

Delete From ComputerType Where ComputerTypeID IN (1,2);
INSERT INTO ComputerType(ComputerTypeID, Description) VALUES (1,'Pocket PC');
INSERT INTO ComputerType(ComputerTypeID, Description) VALUES (2,'Tablet/ Mobile');

-- ComputerType For Queue System
Insert INTO ComputerType(ComputerTypeID, Description) VALUES(4, 'Queue Display');

-- 14/03/2014 KDS Setting By Zone
CREATE TABLE KDS_KDSIDByTableZone (
 ZoneID int NOT NULL DEFAULT '0',
 FromKDSID int NOT NULL DEFAULT '0',
 ToKDSID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (ZoneID, FromKDSID, ToKDSID)
) TYPE=InnoDB;

-- 17/03/2014 Text
Update TextUserNameBarCodeReadingType Set Description = 'Split Text From Position For Text From Magnetic' Where ReadTextID = 1;
Update TextUserNameBarCodeReadingType Set Description = 'Split Text From Delimeter For Text From Magnetic' Where ReadTextID = 2;
Insert INTO TextUserNameBarCodeReadingType(ReadTextID, Description) VALUES(1,'Split Text From Position For Text From Input');
Insert INTO TextUserNameBarCodeReadingType(ReadTextID, Description) VALUES(2,'Split Text From Delimeter For Text From Input');

-- 18/03/2014 Mapping TableID For FastFood
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 1086, 2, "Fast Food - Mapping TableID when Open Transaction", "0=No use (Default), 1=Must map table id alway");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1086, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1086,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1086,2, 'Map TableID', 1, 1, 0);

-- Property For PrintToKitchen using PrinterByComputer Table, not Printers
INSERT INTO ProgramProperty(ProgramTypeID, PropertyID, KeyTypeID, PropertyName, Description) VALUES (1, 10, 2, 'Print To Kitchen by PrinterByComputer', 'Print To Kitchen use printer device name from PrinterByComputer');
INSERT INTO ProgramPropertyValue(ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue) VALUES (1, 10, 1, 0,'');
 
Update PermissionItem set permissionshoptype=0 where permissionitemid=63;


-- 21/02/2014 KDS Payment Before Check out Item
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1085, 2, "KDS - Payment before Check out item", "0=No use (Default), 1=Want payment before check out item");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1085, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1085,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1085,2, 'Yes', 1, 1, 0);

-- 07/03/2014 Exchange Price Feature
CREATE TABLE ExchangeRate_Currency (
 CurrencyID int NOT NULL DEFAULT '0',
 CurrencyName varchar(100) NULL,
 CurrencyShortName varchar(10) NULL,
 CountryName varchar(100) NULL,
 Ordering int NOT NULL DEFAULT '0',
 Deleted tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (CurrencyID)
) TYPE=InnoDB;

CREATE TABLE ExchangeRate_ShopLink (
 ExchangeGroupID int NOT NULL DEFAULT '0',
 ProductLevelID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (ExchangeGroupID, ProductLevelID)
) TYPE=InnoDB;

CREATE TABLE ExchangeRate_ExchangeGroup (
 ExchangeGroupID int NOT NULL DEFAULT '0',
 ExchangeGroupName varchar(100) NULL,
 MainCurrencyID int NOT NULL DEFAULT '0',
 StartDate date NULL,
 EndDate date NULL,
 InsertStaffID int NOT NULL DEFAULT '0',
 InsertDate datetime NULL,
 UpdateStaffID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL, 
 PRIMARY KEY  (ExchangeGroupID)
) TYPE=InnoDB;

CREATE TABLE ExchangeRate_ExchangeTable (
 ExchangeGroupID int NOT NULL DEFAULT '0',
 CurrencyID int NOT NULL DEFAULT '0',
 ExchangeRate decimal(18,4) NOT NULL DEFAULT '0',
 MainCurrencyRatio decimal(18,4) NOT NULL DEFAULT '0',
 PRIMARY KEY  (ExchangeGroupID, CurrencyID)
) TYPE=InnoDB;

-- Add PayDetail
ALTER TABLE PayDetail ADD FromCurrencyID int NOT NULL DEFAULT '0' After IsFromEDC;
ALTER TABLE PayDetail ADD FromCurrencyPrice decimal(18,4) NOT NULL DEFAULT '0' After FromCurrencyID;
ALTER TABLE PayDetail ADD ExchangeRate decimal(18,4) NOT NULL DEFAULT '0' After FromCurrencyPrice;
ALTER TABLE PayDetail ADD MainCurrencyRatio decimal(18,4) NOT NULL DEFAULT '0' After ExchangeRate;
ALTER TABLE PayDetailFront ADD FromCurrencyID int NOT NULL DEFAULT '0' After IsFromEDC;
ALTER TABLE PayDetailFront ADD FromCurrencyPrice decimal(18,4) NOT NULL DEFAULT '0' After FromCurrencyID;
ALTER TABLE PayDetailFront ADD ExchangeRate decimal(18,4) NOT NULL DEFAULT '0' After FromCurrencyPrice;
ALTER TABLE PayDetailFront ADD MainCurrencyRatio decimal(18,4) NOT NULL DEFAULT '0' After ExchangeRate;

-- MultiCurrency Feature
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 108, 2, "Multi Currency Feature", "0 = No, 1 = Has Multi Currency");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 108, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,108,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,108,2, 'Yes', 1, 1, 0);

-- Transfer DataType --> ExchangeRate
INSERT INTO TransferDataType(DataTypeID, DataTypeCode, DataTypeName, DataTypeDescription) VALUES(30,'EXCHAN','Exchange Currency','ข้อมูลอัตราแลกเปลี่ยนเงินตราต่างประเทศ');
INSERT INTO TransferDataTypeFor(DataTypeFor, DataTypeID) VALUES(1, 30);
INSERT INTO TransferDataTypeSetting(DataTypeGroupID, DataTypeGroupFor, DataTypeID, Ordering) VALUES(1, 2, 30, 30);

-- 08/04/2014 Permission Exchange Rate 
INSERT INTO permissiongroup(permissiongroupid,permissiongrouporder)VALUES(31,12);
INSERT INTO permissiongroupname(permissiongroupnameid,permissiongroupid,permissiongroupname,langid)VALUES(15000,31,'Exchange Rate',1);
INSERT INTO permissiongroupname(permissiongroupnameid,permissiongroupid,permissiongroupname,langid)VALUES(15001,31,'อัตตราแลกเปลี่ยนเงินตรา',2);

INSERT INTO permissionitem(permissionitemid,permissiongroupid,permissionitemparam,permissionitemurl,permissionitemorder,permissionitemidparent,permissionitemassign,deleted) VALUES(15147,31,'ExchangeRateCurrency','Preferences/ExchangeRateCurrency.aspx',10,0,0,0);
INSERT INTO permissionitemname(permissionitemnameid,permissionitemid,permissionitemname,langid) VALUES(1,15147,'Currency',1);
INSERT INTO permissionitemname(permissionitemnameid,permissionitemid,permissionitemname,langid) VALUES(2,15147,'กำหนดสกุลเงิน ',2);
INSERT INTO staffpermission(staffpermissionid,staffroleid,permissionitemid) VALUES(15150,1,15147);
INSERT INTO staffpermission(staffpermissionid,staffroleid,permissionitemid) VALUES(15151,2,15147);

INSERT INTO permissionitem(permissionitemid,permissiongroupid,permissionitemparam,permissionitemurl,permissionitemorder,permissionitemidparent,permissionitemassign,deleted) VALUES(15146,31,'ExchangeRateCurrencyGroup','Preferences/ExchangeRateCurrencyGroup.aspx',15,0,0,0);
INSERT INTO permissionitemname(permissionitemnameid,permissionitemid,permissionitemname,langid) VALUES(1,15146,'Currency Group',1);
INSERT INTO permissionitemname(permissionitemnameid,permissionitemid,permissionitemname,langid) VALUES(2,15146,'กำหนดกลุ่มอัตตราแลกเปลี่ยน',2);
INSERT INTO staffpermission(staffpermissionid,staffroleid,permissionitemid) VALUES(15148,1,15146);
INSERT INTO staffpermission(staffpermissionid,staffroleid,permissionitemid) VALUES(15149,2,15146);

INSERT INTO permissionitem(permissionitemid,permissiongroupid,permissionitemparam,permissionitemurl,permissionitemorder,permissionitemidparent,permissionitemassign,deleted) VALUES(15148,31,'ExchangeRate','Preferences/ExchangeRate.aspx',20,0,0,0);
INSERT INTO permissionitemname(permissionitemnameid,permissionitemid,permissionitemname,langid) VALUES(1,15148,'Exchange Rate',1);
INSERT INTO permissionitemname(permissionitemnameid,permissionitemid,permissionitemname,langid) VALUES(2,15148,'กำหนดอัตตราแลกเปลี่ยน ',2);
INSERT INTO staffpermission(staffpermissionid,staffroleid,permissionitemid) VALUES(15152,1,15148);
INSERT INTO staffpermission(staffpermissionid,staffroleid,permissionitemid) VALUES(15153,2,15148);

-- 09/04/2014 Permission For KDSID By Table Zone Setting
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID)
VALUES(40231,1,'KDSSettingTableZone','Preferences/settingKDSTableZone.aspx',1018,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,40231,'KDS Table Zone Setting',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,40231,'ตั้งค่า KDS Table Zone',2);
INSERT INTO staffpermission(StaffPermissionID,StaffRoleID,PermissionItemID) VALUES(40246,1,40231);
INSERT INTO staffpermission(StaffPermissionID,StaffRoleID,PermissionItemID) VALUES(40247,2,40231);

-- 11/04/2014 Authorize Window Staff When Approve/ Cancel Document - Property = 18
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(3, 18, 1, "Use Authorize Window When Approve/Cancel Document", "0=No use (Default), 1=Use Authoize Window");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (3, 18, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,18,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,18,2, 'Use Authorize', 1, 1, 0);

-- 13/04/2014 Use No Rounding Price For PayType
ALTER TABLE PayType ADD UseNoRoundingPrice tinyint NOT NULL DEFAULT '0' After PrintSignatureInReceipt;

ALTER TABLE OrderTransaction ADD IsNoRoundingPriceForPayment tinyint NOT NULL DEFAULT '0' After IsCalculateServiceCharge;
ALTER TABLE OrderTransactionFront ADD IsNoRoundingPriceForPayment tinyint NOT NULL DEFAULT '0' After IsCalculateServiceCharge;

ALTER TABLE ShopCategoryInfo ADD ShopCatOrdering smallint NOT NULL Default '0' AFTER ShopCategoryDesp;
CREATE TABLE ShopCategoryMappingData (ShopID int,ShopCategoryID int,ShopCategoryDataID int);

-- 15/05/2014 KDS To Printer Setting
CREATE TABLE PrinterTemporaryRedirectTo (
 ProductLevelID int NOT NULL DEFAULT '0',
 IsForKDS tinyint NOT NULL DEFAULT '0',
 FromPrinterID int NOT NULL DEFAULT '0',
 ToPrinterID int NOT NULL DEFAULT '0',
 StaffID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL, 
 PRIMARY KEY  (ProductLevelID, IsForKDS, FromPrinterID)
) TYPE=InnoDB;

CREATE TABLE PrinterTemporaryRedirectTo_History (
 HistoryID int NOT NULL Auto_Increment,
 ProductLevelID int NOT NULL DEFAULT '0',
 IsForKDS tinyint NOT NULL DEFAULT '0',
 FromPrinterID int NOT NULL DEFAULT '0',
 ToPrinterID int NOT NULL DEFAULT '0',
 IsRedirectToOtherPrinter tinyint NOT NULL DEFAULT '0',
 StaffID int NOT NULL DEFAULT '0', 
 UpdateDate datetime NULL, 
 PRIMARY KEY  (HistoryID, ProductLevelID)
) TYPE=InnoDB;


INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, 
PermissionItemIDParent,PermissionItemAssign,Deleted)VALUES (195,6,'RedirectToOtherPrinter','',13,0,NULL,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES(1,195,'Redirect KDS/ Printer To Other Printer',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES (2,195,'เปลี่ยนแปลงเครื่องพิมพ์หรือ KDS ที่เสีย',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=195) OR (StaffRoleID=2 AND PermissionItemID=195);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,195);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,195);


INSERT INTO ComputerType(ComputerTypeID, Description) VALUES (5,'Second Display');

-- 11/06/2014 - Property For Print TableNo not QueueNo When Print Job Order
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (102,4,'Print From QueueNo Before Print From TableNo', 'For Restaurant Interface Only, 1 = Print QueueNo if QueueNo <> empty string.',0,0,0);


-- 21/05/2014 MaxTransactionID For CashInOut
CREATE TABLE MaxIDByComputer (
 ComputerID int NOT NULL DEFAULT '0',
 ForIDType tinyint NOT NULL DEFAULT '0',
 MaxID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (ComputerID, ForIDType)
) TYPE=InnoDB;

CREATE TABLE MaxIDByComputerIDType (
 ForIDType tinyint NOT NULL DEFAULT '0',
 Description varchar(50) NULL,
 PRIMARY KEY  (ForIDType)
) TYPE=InnoDB;
INSERT INTO MaxIDByComputerIDType(ForIDType, Description) VALUES(0, 'Cash Out Transaction');

-- 24/06/2014 Register and LicenseCode
ALTER TABLE ShopExtData ADD UUID varchar(50) After ShopID;
ALTER TABLE ShopExtData ADD DeviceCode varchar(50) After UUID;
ALTER TABLE ShopExtData ADD LicenseCode varchar(50) After DeviceCode;
ALTER TABLE ShopExtData ADD RegisterCode varchar(50) After LicenseCode;
ALTER TABLE ShopExtData ADD LicenseExpireDate datetime After RegisterCode;
ALTER TABLE ShopExtData ADD LicenseStatus tinyint NOT NULL Default '0' After LicenseExpireDate;

-- 25/06/2014 Write XML File For AutoImport DataSet For ManageData
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(7, 5, 1, "Write XML File For AutoImport DataSet", "0=Not Write, 1=Write XML File (File zip with 000_)");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (7, 5, 1, 1, '', NULL);

-- 25/06/2014 - Property For Print CreditCard Type (0 = Format xxxx-xxx, 1 = Format show all creditcardno)
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,6,'Print CreditCard Format No', '0 = xxxx, 1 = Show All CreditCard No',0,0,0);

ALTER TABLE EDC_VoidTransaction Drop Primary Key, Add Primary Key(TransactionID, ComputerID, ShopID, EDC_InvoiceNo);


Update PropertyTextDesp Set PropertyPosition = 8 Where PropertyPosition = 9 AND PropertyName = 'Always Print Close Session When End Day';
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,8,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,8,2, 'Yes', 1, 1, 0);

CREATE TABLE ConvertMPOSLog (
 ID tinyint NOT NULL DEFAULT '0' Auto_Increment,
 MPOSLog varchar(255) NULL,
 LogTime datetime NULL,
 PRIMARY KEY  (ID)
) TYPE=InnoDB;

-- 21/07/2014 Print 3 Column Amount First Full Name
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,21,4, 'Amount First(Amount, Full ProductName, TotalPrice)', 3, 3, 0);

-- 21/07/2014 Discount Authorize
ALTER TABLE VoucherDetail ADD RequireAuthorize tinyint NOT NULL DEFAULT '0' After RequireReferenceNo;

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (196,6,'AuthorizeDiscountPromotion','',14,0,NULL,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES(1,196,'Can Authorize Special Discount Promotion',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES (2,196,'มีสิทธิในการให้ส่วนลดที่ต้องการ authorize',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=195) OR (StaffRoleID=2 AND PermissionItemID=196);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,196);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,196);


CREATE TABLE VoucherStaffPermission (
 StaffRoleID int NOT NULL DEFAULT '0',
 VoucherTypeID int NOT NULL DEFAULT '0', 
 PRIMARY KEY  (StaffRoleID, VoucherTypeID)
) TYPE=InnoDB;

INSERT INTO ReasonTextGroup(ReasonGroupID, ReasonGroupName, Enabled, RequireAmount, EnableManualReason) VALUES (11,'Applied Promotion', 1, 0, 1);

-- 24/07/2014 - AuthorizeStaff/ Reason For PayByVoucher
ALTER TABLE PayByVoucherFront ADD AuthorizeStaffID int NOT NULL DEFAULT '0' After ReferenceNo;
ALTER TABLE PayByVoucherFront ADD AuthorizeReason varchar(255) NULL After AuthorizeStaffID;

ALTER TABLE PayByVoucher ADD AuthorizeStaffID int NOT NULL DEFAULT '0' After ReferenceNo;
ALTER TABLE PayByVoucher ADD AuthorizeReason varchar(255) NULL After AuthorizeStaffID;

-- 24/07/2014 - Property For Print AuthorizeStaffPromotion
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,7,'Print Authorize By For Authorize Promotion', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,7,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,7,2, 'Yes', 1, 1, 0);

ALTER TABLE HistoryOfMoveOrderDetail ADD INDEX MoveOrderToTransIndex(ToTransactionID, ToComputerID, ToOrderDetailID);


-- 06/08/2014 Skip Import Inventory Data From WebService
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(7, 6, 1, "Skip Import Inventory Data From WebService", "0=Alway Import, 1=Skip Import");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (7, 6, 1, 0, '', NULL);

-- 07/08/2014 Display Warning Stock Count Dialog When Login
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1088, 2, "Check & Warning Count Stock Inventory when login", "0=No use (Default), 1=Check and Warning");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1088, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1088,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1088,2, 'Check & Warning Count Stock', 1, 1, 0);

ALTER TABLE PComponentGroup ADD RequireAddMinimumAmountForProduct tinyint NOT NULL DEFAULT '0' After RequireAddAmountForProduct;
ALTER TABLE PComponentGroupOverWrite ADD RequireAddMinimumAmountForProduct tinyint NOT NULL DEFAULT '0' After RequireAddAmountForProduct;

-- 28/08/2014 Set AutoForwardStock With Real Amount
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (3, 19, 1, "Use Current Stock When Auto Forward Monthly Stock", "0= Forward 0 if Stock <0, 1=Use Current Stock even Stock < 0");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (3, 19, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,19,1, 'Forward 0 if Stock < 0', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,19,2, 'Use Current Stock', 1, 1, 0);

-- 16/09/2014 Calculate No Customer By Buffet Product Type
Update PropertyOption Set OptionName = 'Record By Buffet Product At Submit Order' Where PropertyTypeID = 1 AND PropertyID = 80 AND OptionID = 2;
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,80,3, 'Record By Buffet Product At Refresh Order', 2, 2, 0);

-- 07/08/2014 Display Warning Stock Count Dialog When Login
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1084, 2, "Table - Show comment transaction feature", "0=No Show, 1=Show Button");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1084, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1084,1, 'No show', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1084,2, 'Show button', 1, 1, 0);

-- 30/09/2014 Exchange Currency Config
CREATE TABLE ExchangeRate_Config (
 ConfigID tinyint NOT NULL DEFAULT '0',
 PrintExchangeRateInBillDetail tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (ConfigID)
) ENGINE=InnoDB;
INSERT INTO ExchangeRate_Config(ConfigID, PrintExchangeRateInBillDetail) VALUES(1,0);

-- 07/11/2014
Update ProgramProperty Set PropertyName = 'Auto Send RewardPoint To HQ After Paid (LIM Feature)', Description = '0 = No, 1 = Auto Send' Where ProgramTypeID = 1 AND PropertyID = 1042;
INSERT INTO ProgramPropertyProgramDescription(ProgramTypeID, Description, GroupID) VALUES (107, 'Print Summary To Kitchen Property(Seconde : In TextValue For Property 44,59', 2);
Delete From PropertyTextDesp Where PropertyTypeID = 107 AND PropertyPosition = 2;
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (107,1,'No Copy For Print Void Order','> 1, Print Additional Copy For Print Summary',0,0,0);
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (107,2,'Print Reason For Void Order','',0,0,0);
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (107,3,'Include Order Comment','',0,0,0);

-- Property For Export Transaction Text File For Other Member System (for SushiTei Indo)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 110, 2, "Create Member's Transaction Text File for Indo", "0=No, 1=Yes. Create Text File When Finish Payment");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 110, 2, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,110,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,110,2, 'Yes', 1, 1, 0);




-- 13/11/2014 - Not Print VAT/ Service Charge Percent In Receipt
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,8,'Not Print VAT % and ServiceCharge %', '0 = Print, 1 = Not Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,8,1, 'Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,8,2, 'Not Print', 1, 1, 0);
-- Print Void Order In Session
Delete From PropertyTextDesp Where PropertyTypeID = 105 AND PropertyPosition = 9;
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (105,9,'Print Void Order Detail', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,9,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,9,2, 'Print', 1, 1, 0);
-- Print Sale By Product Report When End Day
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (105,10,'Print Sale By Product Report When End Day', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,10,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,10,2, 'Print', 1, 1, 0);
-- Credit Card Property
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 111, 2, "Hide Credit Card Number Text Box In Payment", "0=No, 1=Yes.");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 111, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,111,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,111,2, 'Yes', 1, 1, 0);

-- Print Customer No In Receipt
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,1,4, 'Not Print Customer and Queue Name', 3, 3, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,1,5, 'Print No Customer At Right', 4, 4, 0);

-- Print Open Staff In Receipt
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,9,'Print Open Staff Name', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,9,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,9,2, 'Print', 1, 1, 0);

INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (102,4,'Print From QueueNo Before Print From TableNo', 'For Restaurant Interface Only, 1 = Print QueueNo if QueueNo <> empty string.',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (102,4,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (102,4,2, 'Print Queue No', 1, 1, 0);

INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (102,5,'Print Order Computer Name', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (102,5,1, 'Not Print', 0, 0, 1);	
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (102,5,2, 'Print Order Computer', 1, 1, 0);

ALTER TABLE OrderTransaction ADD TransactionAdditionalType tinyint NOT NULL DEFAULT '0' After IsFromOtherTransaction;
ALTER TABLE OrderTransactionFront ADD TransactionAdditionalType tinyint NOT NULL DEFAULT '0' After IsFromOtherTransaction;

CREATE TABLE TransactionAddtionalTypeDescription (
 AdditionalType tinyint NOT NULL DEFAULT '0',
 Description varchar(100) NULL,
 PRIMARY KEY  (AdditionalType)
) ENGINE=InnoDB;
INSERT INTO TransactionAddtionalTypeDescription(AdditionalType, Description) VALUES(1,'CAC Counter Service Transaction');
INSERT INTO TransactionAddtionalTypeDescription(AdditionalType, Description) VALUES(2,'CAC Use Member Privilege');

-- Add Amounted ProductSetType From HardWare
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 112, 2, "Add Amounted Product From Scale (Hardware)", "0=No, 1=Yes. TextValue = factor amount from scale (X 1000 For Kg to g.)");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 112, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,112,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,112,2, 'Yes', 1, 1, 0);

-- 17/12/2014 Session Average Price Per Bill/ Customer --> Use Price Before ServiceCharge/ ExcludeVAT
Update PropertyTextDesp Set Description = '0 = Avg. After Discount, 1 = Avg. Before Discount, 2 = Avg. Before VAT, Servicecharge.' Where PropertyTypeID = 105 AND PropertyPosition = 3;
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,3,3, 'Average Price Before VAT and Servicecharge', 2, 2, 0);

-- Print Stock Only As Normal Receipt
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 113, 2, "Print Stock Only Receipt as Normal Receipt", "0=No, 1=Yes. TextValue = Stock Only PayType that need to print as Noral Receipt (Not Insert mean all stock only)");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 113, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,113,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,113,2, 'Yes.', 1, 1, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,113,3, 'Yes. Using Normal Receipt Header/ Footer', 2, 2, 0);

-- 18/12/2014 TimeRangeReport Setting
CREATE TABLE TimeRangeSettingForReport (
 TimeRangeID int NOT NULL AUTO_Increment,
 ReportID tinyint NOT NULL DEFAULt '0',
 StartTime datetime NULL,
 EndTime datetime NULL,
 PRIMARY KEY  (TimeRangeID)
) ENGINE=InnoDB;

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(197,6,'FrontReport_SummarySaleByTimeRange','',108,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,197,'Summary Sale By Time Range',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,197,'รายการสรุปยอดขายตามช่วงเวลา',2);
Delete From StaffPermission Where PermissionItemID = 197 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,197);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,197);


-- Inventory Yield Document
ALTER TABLE DocumentTypeProperty ADD YieldDocumentTypeWhenApproveRODocument int NOT NULL DEFAULT '0' After CanReceiveAmountUpToPercent;

CREATE TABLE MaterialYieldSetting (
 MaterialID int NOT NULL DEFAULT '0',
 ReceiveLargeAmount decimal(18,4) NOT NULL DEFAULT '0',
 YieldLargeAmount decimal(18,4) NOT NULL DEFAULT '0',
 MaterialUnitLargeID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (MaterialID)
) ENGINE=InnoDB;

INSERT INTO DocumentType (DocumentTypeID, LangID, ShopID, ComputerID, DocumentTypeHeader, DocumentTypeName, ShowOnSearch, MovementInStock, IsAddReduceDoc, CalculateInProfitLoss, CalculateNetUse, CalculateStandardProfitLoss) VALUES (64,1,1,0,'YMA','Yield Material Document',0,-1,0,1,0,0);
INSERT INTO DocumentType (DocumentTypeID, LangID, ShopID, ComputerID, DocumentTypeHeader, DocumentTypeName, ShowOnSearch, MovementInStock, IsAddReduceDoc, CalculateInProfitLoss, CalculateNetUse, CalculateStandardProfitLoss) VALUES (64,2,1,0,'YMA','เอกสารตัดแต่งจากการรับ',0,-1,0,1,0,0);
INSERT INTO DocumentTypeGroupValue(DocumentTypeGroupID, DocumentTypeID) VALUES (1,64);

-- RewardPoint Setting V.2
-- 06/11/2014 RewardPointSetting For MemberGroup/ Payment/ Birthday
CREATE TABLE RewardPointMemberGroupSetting (
 RewardSettingID int NOT NULL DEFAULT '0',
 MemberGroupID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (RewardSettingID, MemberGroupID)
) ENGINE=InnoDB;

CREATE TABLE RewardPointSpecialDaySetting (
 RewardSettingID int NOT NULL DEFAULT '0',
 SpecialSettingID tinyint NOT NULL DEFAULT '0',
 FromDate date NULL,
 ToDate date NULL,
 ForMemberBirthday tinyint NOT NULL DEFAULT '0',
 DayBeforeBirthDay tinyint NOT NULL DEFAULT '0',
 DayAfterBirthDay tinyint NOT NULL DEFAULT '0',
 IsInMonthOfBirthDay tinyint NOT NULL DEFAULT '0',
 CalculatePrice decimal(18,4) NOT NULL DEFAULT '0',
 PerPoint decimal(18,4) NOT NULL DEFAULT '0',
 PRIMARY KEY  (RewardSettingID, SpecialSettingID)
) ENGINE=InnoDB;

INSERT INTO RewardPointBaseOn(BaseOnID, Description) VALUES(3, 'Base On Receipt Pay Price');

CREATE TABLE RewardPointPaymentSetting (
 RewardSettingID int NOT NULL DEFAULT '0',
 PayTypeID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (RewardSettingID, PayTypeID)
) ENGINE=InnoDB;

-- 08/01/2015 Deposit Product/ Transaction
CREATE TABLE DepositProductSetting (
  DepositProductID int NOT NULL DEFAULT '0',
  DepositToProductID int NOT NULL DEFAULT '0'
) ENGINE=InnoDB;

CREATE TABLE DepositOrderDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  DepositOrderID int NOT NULL DEFAULT '0',
  ProductID int NOT NULL DEFAULT '0',
  ProductSetType int NOT NULL DEFAULT '0',
  Amount decimal(18,4) NOT NULL DEFAULT '0',
  OrderStatusID smallint NOT NULL DEFAULT '0',
  OtherProductName varchar(50) NULL,
  Price decimal(18,4) NOT NULL DEFAULT '0',
  TotalPrice decimal(18,4) NOT NULL DEFAULT '0',
  SalePrice decimal(18,4) NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, DepositOrderID)
) ENGINE=InnoDB;

CREATE TABLE DepositOrderProductLinkDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  OrderDetailID int NOT NULL DEFAULT '0',
  ProductID int NOT NULL DEFAULT '0',
  OrderLinkID int NOT NULL DEFAULT '0',
  CommissionPrice decimal(18,4) NOT NULL DEFAULT '0',
  CommissionPriceVAT decimal(18,4) NOT NULL DEFAULT '0',
  PGroupID int NOT NULL DEFAULT '0',
  SetGroupNo tinyint NOT NULL DEFAULT '0',
  AmountInFlexiblePerUnit decimal(18,4) NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID)
) ENGINE=InnoDB;

CREATE TABLE DepositOrderPromotionDiscountDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  OrderDetailID int NOT NULL DEFAULT '0',
  TypeID tinyint NOT NULL DEFAULT '0',
  PriceGroupID int NOT NULL DEFAULT '0',
  DiscountNo smallint NOT NULL DEFAULT '0',
  LinkID int NOT NULL DEFAULT '0',
  VoucherID int NOT NULL DEFAULT '0',
  CalculateOrder tinyint NOT NULL DEFAULT '0',
  OtherPercentDiscount decimal(18,4) NOT NULL DEFAULT '0',
  DiscountPrice decimal(18,4) NOT NULL DEFAULT '0',
  PriceAfterDiscount decimal(18,4) NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID, TypeID, PriceGroupID, DiscountNo)
) ENGINE=InnoDB;

ALTER TABLE DepositTransaction ADD DepositToTransactionID int NOT  NULL DEFAULT '0' After ComputerID;
ALTER TABLE DepositTransaction ADD DepositToComputerID int NOT  NULL DEFAULT '0' After DepositToTransactionID;
ALTER TABLE DepositTransaction CHANGE DepositStatusID DepositStatus tinyint NOT  NULL DEFAULT '0';
ALTER TABLE DepositTransaction CHANGE TotalPrice SalePrice decimal(18,4) NOT NULL DEFAULT '0';
ALTER TABLE DepositTransaction CHANGE MemberDiscountID MemberID int NOT NULL DEFAULT '0';

ALTER TABLE DepositTransaction ADD InsertDate datetime NULL After TransactionNote;
ALTER TABLE DepositTransaction ADD InsertStaffID int NOT  NULL DEFAULT '0' After InsertDate;
ALTER TABLE DepositTransaction ADD UpdateStaffID int NOT  NULL DEFAULT '0' After UpdateDate;

ALTER TABLE DepositTransaction DROP OpenTime;
ALTER TABLE DepositTransaction DROP OpenStaffID;
ALTER TABLE DepositTransaction DROP PaidTime;
ALTER TABLE DepositTransaction DROP PaidStaffID;
ALTER TABLE DepositTransaction DROP OtherPercentDiscount;
ALTER TABLE DepositTransaction DROP OtherAmountDiscount;
ALTER TABLE DepositTransaction DROP SaleMode;
ALTER TABLE DepositTransaction DROP NoCustomer;
ALTER TABLE DepositTransaction DROP DocType;
ALTER TABLE DepositTransaction DROP ReceiptYear;
ALTER TABLE DepositTransaction DROP ReceiptMonth;
ALTER TABLE DepositTransaction DROP ReceiptID;
ALTER TABLE DepositTransaction DROP TransactionVAT;
ALTER TABLE DepositTransaction DROP TransactionVATAble;
ALTER TABLE DepositTransaction DROP IsCalculateServiceCharge;
ALTER TABLE DepositTransaction DROP SessionID;
ALTER TABLE DepositTransaction DROP CloseComputerID;
ALTER TABLE DepositTransaction DROP VoidStaffID;
ALTER TABLE DepositTransaction DROP VoidReason;
ALTER TABLE DepositTransaction DROP VoidTime;
ALTER TABLE DepositTransaction DROP MemberPriceGroupID;
ALTER TABLE DepositTransaction DROP StaffDiscountID;
ALTER TABLE DepositTransaction DROP StaffPriceGroupID;
ALTER TABLE DepositTransaction DROP CalculateProductFromMainPrice;
ALTER TABLE DepositTransaction DROP NoPrintBillDetail;
ALTER TABLE DepositTransaction DROP TableID;

ALTER TABLE DepositOrderDetail ADD TotalRetailPrice decimal(18, 4) NOT NULL DEFAULT '0' After Price;
ALTER TABLE DepositOrderDetail ADD VATType tinyint NOT NULL DEFAULT '0' After SalePrice;
ALTER TABLE DepositOrderDetail ADD DiscountAllow tinyint NOT NULL DEFAULT '0'  After VATType;
ALTER TABLE DepositOrderDetail ADD PromotionPriceID int NOT NULL DEFAULT '0'  After DiscountAllow;
ALTER TABLE DepositOrderDetail ADD PromotionNPriceID int NOT NULL DEFAULT '0'  After PromotionPriceID;
ALTER TABLE DepositOrderDetail ADD HasServiceCharge tinyint NOT NULL DEFAULT '0'  After PromotionNPriceID;
ALTER TABLE DepositOrderDetail ADD VoidStaffID int NOT NULL DEFAULT '0' After HasServiceCharge;
ALTER TABLE DepositOrderDetail ADD SubmitOrderDateTime datetime NULL After VoidStaffID;

-- Other Income
CREATE TABLE DepositOtherIncomeDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  IncomeDetailID int NOT NULL DEFAULT '0',
  IncomeTypeID int NOT NULL DEFAULT '0',
  Income decimal(18,4) NOT NULL DEFAULT '0',
  IncomeVAT decimal(18,4) NOT NULL DEFAULT '0',
  IncomeNote varchar(250) NULL,
  VATType tinyint NOT NULL DEFAULT '0',
  IncomePercent decimal(5,2) NOT NULL DEFAULT '0',
  IncomeStatus tinyint NOT NULL DEFAULT '0',
  VoidStaffID int NOT NULL DEFAULT '0',
  VoidDateTime datetime NULL,
  VoidNote varchar(255) NULL,
  AddDateTime datetime NULL,
  PRIMARY KEY  (TransactionID, ComputerID, IncomeDetailID)
) ENGINE=InnoDB;

CREATE TABLE DepositPayByVoucher (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  VoucherID int NOT NULL DEFAULT '0',
  VouchertypeID int NOT NULL DEFAULT '0',  
  CouponVoucherNo varchar(30) NULL,
  ReferenceNo varchar(50) NULL,
  AuthorizeStaffID int NOT NULL DEFAULT '0',
  AuthorizeReason varchar(255) NULL,
  OriginalAmount decimal(18,4) NOT NULL DEFAULT '0',
  UsedAmount decimal(18,4) NOT NULL DEFAULT '0',
  IsSale tinyint NOT NULL DEFAULT '0',
  PriceGroupID int NOT NULL DEFAULT '0',
  TypeID tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, VoucherID, VoucherTypeID)
) ENGINE=InnoDB;

ALTER TABLE ReceiptPromotionHeaderFooter ADD PrintPosition tinyint NOT NULL DEFAULT '0' After LineOrder;
-- 14/01/2015
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1067, 3, "Show Tab Deposit", "0=Not show (Default), 1=Show tab Deposit");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1067, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1067,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1067,2, 'Yes', 1, 1, 0);

-- 20/01/2015 Yield Setting Permission
INSERT INTO permissionitem(permissionitemid,permissiongroupid,permissionitemparam,permissionitemurl,permissionitemorder,permissionitemidparent,permissionitemassign,deleted) VALUES(15145,3,'ListYield','Preferences/ListYield.aspx',1002,0,0,0);
INSERT INTO permissionitemname(permissionitemnameid,permissionitemid,permissionitemname,langid) VALUES(1,15145,'Material Setting Yield',1);
INSERT INTO permissionitemname(permissionitemnameid,permissionitemid,permissionitemname,langid) VALUES(2,15145,'กำหนดค่าตัดแต่งของวัตถุดิบ(Yield)',2);
INSERT INTO staffpermission(staffpermissionid,staffroleid,permissionitemid) VALUES(15146,1,15145);
INSERT INTO staffpermission(staffpermissionid,staffroleid,permissionitemid) VALUES(15147,2,15145);

-- 26/01/2015 Other Income Amount
ALTER TABLE OrderTransactionOtherIncomeDetail ADD IncomeAmount decimal(18,4) NOT NULL DEFAULT '1' After IncomeTypeID;
ALTER TABLE OrderTransactionOtherIncomeDetailFront ADD IncomeAmount decimal(18,4) NOT NULL DEFAULT '1' After IncomeTypeID;

-- 27/01/2015 Adjust Payment For Default Price > PayPrice (Voucher Adjust)
ALTER TABLE PayType ADD AdjustAmountToPayType int NOT NULL DEFAULT '0' After ConvertPayTypeTo;
ALTER TABLE PayType ADD OtherReceiptSkipExcludeVATAndServicecharge tinyint NOT NULL DEFAULT '0' After IncludeInMultiplePayment;
ALTER TABLE PayType ADD OtherReceiptHasCashInProductID int NOT NULL DEFAULT '0' After OtherReceiptSkipExcludeVATAndServicecharge;

ALTER TABLE CashOutOrderTransaction ADD ReferenceTransactionID int NOT NULL DEFAULT '0' After UpdateDate;
ALTER TABLE CashOutOrderTransaction ADD ReferenceComputerID int NOT NULL DEFAULT '0' After ReferenceTransactionID;

-- 02/02/2015 Print Short Receipt 
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 114, 2, "Print Short Receipt To Customer", "0=No, 1=Yes with print normal receipt., 2=Yes with not print normal receipt");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 114, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,114,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,114,2, 'Yes. Also print normal receipt', 1, 1, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,114,3, 'Yes. Not print normal receipt', 1, 1, 0);

-- Check New Change For Print Bill Detail
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 115, 2, "Check New Change When Print Another Bill Detail", "0=No, 1=Yes. User can print another print bill detail when there is some change in order");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 115, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,115,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,115,2, 'Yes.', 1, 1, 0);

-- DepositSaleModeSetting
ALTER TABLE DepositProductSetting ADD DefaultSelectDepositDay smallint NOT NULL DEFAULT '30' After DepositToProductID;
ALTER TABLE DepositProductSetting ADD IsFixDepositDay tinyint NOT NULL DEFAULT '0' After DefaultSelectDepositDay;
ALTER TABLE DepositProductSetting ADD MaxNoDepositDay smallint NOT NULL DEFAULT '30' After IsFixDepositDay;
ALTER TABLE DepositProductSetting ADD CheckPickupDepositWhenEndDay smallint NOT NULL DEFAULT '0' After MaxNoDepositDay;
ALTER TABLE DepositProductSetting ADD ApplyDiscountAtPickupType tinyint NOT NULL DEFAULT '1' After CheckPickupDepositWhenEndDay;
ALTER TABLE DepositProductSetting ADD PrintDepositDetailInJobOrder tinyint NOT NULL DEFAULT '0' After ApplyDiscountAtPickupType;
ALTER TABLE DepositProductSetting ADD PrinterIDForJobOrder varchar(50) NULL After PrintDepositDetailInJobOrder;

CREATE TABLE DepositApplyDiscountPickupType (
  ApplyDiscountPickupType int NOT NULL DEFAULT '0',
  Description varchar(255) NULL,
  PRIMARY KEY  (ApplyDiscountPickupType)
) ENGINE=InnoDB;
INSERT INTO DepositApplyDiscountPickupType(ApplyDiscountPickupType, Description) VALUES(1, 'Can Not Discount');
INSERT INTO DepositApplyDiscountPickupType(ApplyDiscountPickupType, Description) VALUES(2, 'Can Discount');
INSERT INTO DepositApplyDiscountPickupType(ApplyDiscountPickupType, Description) VALUES(3, 'Can Discount Only No Discount From Deposit Transaction and 0 Deposit Price');

-- Print Job Order For Deposit Order
ALTER TABLE DepositOrderDetail ADD OrderStaffID int NOT NULL DEFAULT '0' NULL After HasServiceCharge;
ALTER TABLE DepositOrderDetail ADD OrderComputerID int NOT NULL DEFAULT '0' NULL After OrderStaffID;
ALTER TABLE DepositOrderDetail ADD OrderTableID int NOT NULL DEFAULT '0' NULL After OrderComputerID;

ALTER TABLE DepositOrderDetail ADD PrintStatus tinyint NOT NULL DEFAULT '0' NULL After VoidStaffID;
ALTER TABLE DepositOrderDetail ADD PrinterID varchar(50) NULL After PrintStatus;
ALTER TABLE DepositOrderDetail ADD PrintGroup tinyint NOT NULL DEFAULT '0' After PrinterID;
ALTER TABLE DepositOrderDetail ADD NoReprintOrder tinyint NOT NULL DEFAULT '0' After PrintGroup;

ALTER TABLE DepositTransaction ADD CanDiscountWhenPickup tinyint NOT NULL DEFAULT '0' After TransactionNote;

ALTER TABLE ReceiptPromotionHeaderFooter CHANGE ID ID INT NOT NULL DEFAULT '0';

-- 03/03/2015 Vendor Field
ALTER TABLE Vendors CHANGE VendorTelephone VendorTelephone varchar(50) NULL;
ALTER TABLE Vendors CHANGE VendorMobile VendorMobile varchar(50) NULL;
ALTER TABLE Vendors CHANGE VendorFax VendorFax varchar(50) NULL;

-- 09/03/2015 Print Close Computer Name In Receipt
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,10,'Print Close Computer Name', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,10,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,10,2, 'Print', 1, 1, 0);

update permissionitem set permissionitemparam='CreateDocument' Where permissionitemid=17;
update permissionitemname set permissionitemname='Create Document' where permissionitemid=17;
update permissionitemname set permissionitemname='สร้างเอกสาร' where permissionitemid=17;

-- 25/03/2015 3rd party RewardPoint System
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 116, 1, "Using 3rd party Reward Point System.", "0=No, 1=Ponta System");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 116, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,116,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,116,2, 'Ponta Point System', 1, 1, 0);

-- For Print Specific Printer When Delete/ Move Transaction
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue,OptionOrdering, OptionDefault) VALUES(1,81,3,'Print To Specific Printer and not Print Summary',2,0,0);

-- 30/03/2015 BackupPrinter In Printer
ALTER TABLE Printers ADD BackupPrinterDeviceName varchar(100) NULL After PrinterDeviceNameFor98;
CREATE TABLE HistoryOfChangePrinterDevice (
  HistoryID int NOT NULL AUTO_INCREMENT,
  ProductLevelID int NOT NULL DEFAULT '0',
  ChangeStaffID int NOT NULL DEFAULT '0',
  ChangeComputerID int NOT NULL DEFAULT '0',
  HistoryDateTime datetime NULL,
  FromPrinterDeviceName varchar(100) NULL,
  ToPrinterDeviceName varchar(100) NULL,
  FrontFunctionID int NOT NULL DEFAULT '0',
  HistoryNote text NULL,  
  PRIMARY KEY  (HistoryID, ProductLevelID)
) ENGINE=InnoDB;
INSERT INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionGroupID, FrontFunctionCode, Description, Description_TH, DisplayInReport) VALUES(39, 9, 'CPRINTER', 'Change Printer Name', 'เปลี่ยน printer ไปที่ครัว', 0);

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(198,6,'ChangePrinterDevice','',193,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,198,'Change Printer',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,198,'เปลี่ยนเครื่องพิมพ์ไปที่ครัว',2);
Delete From StaffPermission Where PermissionItemID = 198 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,198);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,198);

-- 05/04/2015 DiffAmount For CloneTransaction
ALTER TABLE SessionEndDayDetail ADD CloneTotalReceipt smallint NOT NULL DEFAULT '0' After TotalPayPrice;
ALTER TABLE SessionEndDayDetail ADD CloneTotalPayPrice decimal(18,4) NOT NULL DEFAULT '0' After CloneTotalReceipt;
ALTER TABLE SessionEndDayDetail ADD CloneTotalDiffPayPrice decimal(18,4) NOT NULL DEFAULT '0' After CloneTotalPayPrice;

-- 07/04/2015 Print Prefix VAT In Receipt
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,11,'Print VATType In Receipt', '0=Not Print, 1=Print Before ProductName, 2=Print After Price',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,11,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,11,2, 'Print VATType Before ProductName', 1, 1, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,11,3, 'Print VATType After Price', 2, 2, 0);

-- 10/04/2015 PrintSummeryByComputer
CREATE TABLE PrinterForSummaryByComputer (
  ComputerID int NOT NULL DEFAULT '0',
  IsForCustomerSummary tinyint NOT NULL DEFAULT '0',
  PropertyPrinterDeviceName varchar(100) NULL,
  ComputerPrinterDeviceName varchar(100) NULL,
  PRIMARY KEY  (ComputerID, IsForCustomerSummary, PropertyPrinterDeviceName)
) ENGINE=InnoDB;

-- 11/04/2015 TransactionData_ForImport
CREATE TABLE TransactionData_ForImport (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  InsertDateTime datetime NULL,
  PRIMARY KEY  (TransactionID, ComputerID)
) ENGINE=InnoDB;

CREATE TABLE TransactionDataImport_ForImport (
  IsCalculate tinyint NOT NULL DEFAULT '0',
  LastImportTime datetime
) ENGINE=InnoDB;

-- 16/04/2015 Cash In Drawer In Session End Day
Update PropertyTextDesp Set Description = '0=Not Print, 1=Print By All Open/Close Amount 2= Open Amount From First Session/ Close Amount From Last Session' Where PropertyTypeID = 105 AND PropertyPosition = 11;
Delete From PropertyOption Where PropertyTypeID = 105 AND PropertyID = 2;

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,2,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,2,2, 'Print By Sum Open/Close Amount All Session', 1, 1, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,2,3, 'Print Open Amount From First Session, Close Amount From Last Session', 2, 1, 0);

-- 13/05/2015 QuestionDefineDetail TransactionIndex
ALTER TABLE QuestionDefineDetail ADD INDEX TransactionID (TransactionID, ComputerID);
-- 11/06/2015 Print Other Product Detail In Session
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (105,11,'Print Other Product Detail In Session', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,11,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,11,2, 'Print', 1, 1, 0);
-- Print Question Data In Session
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (105,12,'Print Question Data', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,12,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,12,2, 'Print', 1, 1, 0);

-- 15/06/2015 Set StockCountMaterialSetting Primary Key
Delete From StockCountMaterialSetting Where StockCountTypeID = 4;
ALTER TABLE StockCountMaterialSetting ADD Primary key (StockCountTypeID, LangID);

Insert INTO StockCountMaterialSetting(StockCountTypeID, StockCountName, DocumentTypeID, LangID, StockCountTypeTableName) Values(4, 'Adjust Stock', 57, 1, 'StockCountMaterial');
Insert INTO StockCountMaterialSetting(StockCountTypeID, StockCountName, DocumentTypeID, LangID, StockCountTypeTableName) Values(4, 'ปรับสต๊อก', 57, 2, 'StockCountMaterial');

INSERT INTO TransferDataTypeSetting(DataTypeGroupID, DataTypeGroupFor, DataTypeID, Ordering) VALUES(1,1,29,29);

-- 17/07/2015 Index For OrderSpaProductSetLink
ALTER TABLE OrderSpaProductSetLinkDetail ADD INDEX LinkIndex(TransactionID, ComputerID,OrderLinkID);
ALTER TABLE OrderProductLinkDetail ADD INDEX LinkIndex(TransactionID, ComputerID,OrderLinkID);


-- 20/07/2015 SushiTei - Printer Type For Other Receipt Printer
INSERT INTO PrinterTypeDescription(PrinterTypeID, Description) VALUES(4, 'Other Receipt Printer');

CREATE TABLE PayType_OtherReceiptSkipPriceDescription (
  OtherReceiptSkipID tinyint NOT NULL DEFAULT '0',
  Description varchar(100) NULL,
  PRIMARY KEY  (OtherReceiptSkipID)
) ENGINE=InnoDB;
INSERT INTO PayType_OtherReceiptSkipPriceDescription(OtherReceiptSkipID, Description) VALUES(0, 'No Skip Calculate');
INSERT INTO PayType_OtherReceiptSkipPriceDescription(OtherReceiptSkipID, Description) VALUES(1, 'Skip Calculate VAT and Servicecharge');
INSERT INTO PayType_OtherReceiptSkipPriceDescription(OtherReceiptSkipID, Description) VALUES(2, 'Skip Calculate Servicecharge');
INSERT INTO PayType_OtherReceiptSkipPriceDescription(OtherReceiptSkipID, Description) VALUES(3, 'Skip Calculate VAT');

ALTER TABLE PayType ADD OtherReceiptPrinterID tinyint NOT NULL DEFAULT '0' After OtherReceiptHasCashInProductID;


-- 10/08/2015 Promotion Discount Calculate From SubmitOrderDateTime
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(1, 117, 2, "Calculate Promotion Base On SubmitOrderDateTime", "0=No, 1=Yes");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 117, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,117,1, 'By Transaction Open Time', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,117,2, 'By Order Submit Date Time', 1, 1, 0);

-- 07/12/2015 Prepaid Product and Payment
ALTER TABLE PrepaidCardInfo DROP Primary Key, ADD Primary Key(CardID, ProductLevelID);
ALTER TABLE PrepaidCardInfo CHANGE LastUpdate UpdateDate datetime NULL;

ALTER TABLE PrepaidCardHistory CHANGE HistoryID HistoryID varchar(50) NOT NULL DEFAULT '';
ALTER TABLE PrepaidCardHistory ADD HistoryComputerID int NOT NULL DEFAULT '0' After HistoryID;
ALTER TABLE PrepaidCardHistory DROP Primary Key, ADD Primary Key(HistoryID, HistoryComputerID);

ALTER TABLE PrepaidCardHistory ADD PrepaidType tinyint NOT NULL DEFAULT '0' After ProductLevelID;
ALTER TABLE PrepaidCardHistory ADD OrderID int NOT NULL DEFAULT '0' After ComputerID;
ALTER TABLE PrepaidCardHistory ADD PrepaidDate date NULL After PreviousAmount;
ALTER TABLE PrepaidCardHistory ADD ReceiptNumber varchar(30) NULL After PrepaidDate;
ALTER TABLE PrepaidCardHistory ADD MemberID int NOT NULL DEFAULT '0' After ComputerID;
ALTER TABLE PrepaidCardHistory ADD InsertAtHQDateTime datetime NULL After HistoryDateTime;
ALTER TABLE PrepaidCardHistory ADD AlreadyExportToHQ tinyint NOT NULL DEFAULT '0' After InsertProductLevelID;

ALTER TABLE PrepaidCardHistory ADD Index CardIndex(CardID, ProductLevelID);
ALTER TABLE PrepaidCardHistory ADD Index TransactionIndex(TransactionID, ComputerID);

CREATE TABLE PrepaidType (
 PrepaidType tinyint NOT NULL DEFAULT '0',
 Description varchar(50) NULL,
 PRIMARY KEY  (PrepaidType)
) ENGINE=InnoDB;
INSERT INTO PrepaidType(PrepaidType, Description) VALUES(1, 'Topup Prepaid');
INSERT INTO PrepaidType(PrepaidType, Description) VALUES(2, 'Prepaid Payment');
INSERT INTO PrepaidType(PrepaidType, Description) VALUES(3, 'Void Topup Prepaid');
INSERT INTO PrepaidType(PrepaidType, Description) VALUES(4, 'Void Prepaid Payment');
INSERT INTO PrepaidType(PrepaidType, Description) VALUES(5, 'Manual Adjust');

CREATE TABLE ProductPrepaidSetting (
 ProductPrepaidID int NOT NULL DEFAULT '0',
 AddPrepaidAmount decimal(18,4) NOT NULL DEFAULT '0',
 ExpireDate date NULL,
 ExpireDateAfterCreate int NOT NULL DEFAULT '-1',
 ForMemberOnly tinyint NOT NULL DEFAULT '0',
 Updatedate datetime NULL,
 PRIMARY KEY  (ProductPrepaidID)
) ENGINE=InnoDB;

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 120, 2, "Prepaid Card Feature", "0=No, 1=Yes", 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 120, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,120,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,120,2, 'Yes', 1, 1, 0);

CREATE TABLE OrderPrepaidTopupInfoFront (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 CardID int NOT NULL DEFAULT '0',
 CardProductLevelID int NOT NULL DEFAULT '0',
 CardNo varchar(30) NULL,
 DepositAmount decimal(18,4) NOT NULL DEFAULT '0',
 TopupAmount decimal(18,4) NOT NULL DEFAULT '0',
 SalePrice decimal(18,4) NOT NULL DEFAULT '0', 
 MemberID int NOT NULL DEFAULT '0',
 ExpireDate date NULL,
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID)
) ENGINE=InnoDB;

CREATE TABLE OrderPrepaidTopupInfo (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 CardID int NOT NULL DEFAULT '0',
 CardProductLevelID int NOT NULL DEFAULT '0',
 CardNo varchar(30) NULL,
 DepositAmount decimal(18,4) NOT NULL DEFAULT '0',
 TopupAmount decimal(18,4) NOT NULL DEFAULT '0',
 SalePrice decimal(18,4) NOT NULL DEFAULT '0', 
 MemberID int NOT NULL DEFAULT '0',
 ExpireDate date NULL,
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID)
) ENGINE=InnoDB;

Update PayType Set IsVAT = 0 Where TypeID = 9;

-- 15/12/2015 Display Cash Change In PayType
ALTER TABLE PayType ADD IsDisplayCashChange tinyint NOT NULL DEFAULT '0' After IsOpenDrawer;


-- 21/12/2015 Link With PMS Hotel System
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 121, 2, "PMS Hotel System Feature", "0=No, 1=Yes", 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 121, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,121,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,121,2, 'Yes', 1, 1, 0);

CREATE TABLE PMS_PaymentRoomInfo (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 PaymentAmount decimal(18,4) NOT NULL DEFAULT '0',
 ReferenceNo varchar(100) NULL,
 AccountNo varchar(100) NULL,
 GuestName varchar(100) NULL,
 RoomNo varchar(100) NULL,
 UpdateDate datetime NULL,
 PRIMARY KEY (TransactionID, ComputerID)
) ENGINE=InnoDB;

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1120,'Charge To Room','PMS','Charge To Room',1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1120);

CREATE TABLE PMS_MappingCreditCardType (
 CreditCardType tinyint NOT NULL DEFAULT '0',
 PMSPayType tinyint NOT NULL DEFAULT '0',
 PMSPayTypeName varchar(50) NULL,
 PRIMARY KEY (CreditCardType, PMSPayType)
) ENGINE=InnoDB;
INSERT INTO PMS_MappingCreditCardType(CreditCardType, PMSPayType, PMSPayTypeName) VALUES(1, 10, 'Visa');
INSERT INTO PMS_MappingCreditCardType(CreditCardType, PMSPayType, PMSPayTypeName) VALUES(2, 9, 'Master');
INSERT INTO PMS_MappingCreditCardType(CreditCardType, PMSPayType, PMSPayTypeName) VALUES(3, 6, 'AMEX');
INSERT INTO PMS_MappingCreditCardType(CreditCardType, PMSPayType, PMSPayTypeName) VALUES(5, 8, 'JCB');

-- 08/01/2016 Redeem Point For Discount - Applied To Current Transaction
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 122, 2, "Redeem Point Discount To Current Transaction Feature", "0=No, 1=Yes", 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 122, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,122,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,122,2, 'Yes', 1, 1, 0);


INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1096, 2, "Show cash change popup windows mode", "0=No show cash change when cash change=0(Default), 1=Show cash change always");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1096, 1, 0, '', NULL);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1096,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1096,2, 'Yes', 1, 1, 0);


-- 08/07/2015
ALTER TABLE EDC_PaymentInfo ADD EDC_EmvAppID VARCHAR(20) DEFAULT NULL AFTER EDC_NII;
ALTER TABLE EDC_PaymentInfo ADD EDC_EmvAppName VARCHAR(20) DEFAULT NULL AFTER EDC_EmvAppID;
ALTER TABLE EDC_PaymentInfo ADD EDC_EmvAppCryptogram VARCHAR(20) DEFAULT NULL AFTER EDC_EmvAppName;
ALTER TABLE EDC_PaymentInfo ADD EDC_EmvTerminalVerifyResult VARCHAR(20) DEFAULT NULL AFTER EDC_EmvAppCryptogram;
ALTER TABLE EDC_PaymentInfo ADD EDC_POSEntryMode VARCHAR(10) DEFAULT NULL AFTER EDC_EmvTerminalVerifyResult;



-- 14/10/2015
-- Skip Customer Info in Delivery Sale Mode Setting
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1092, 2, "Skip customer info of SaleMode Delivery", "0=Show customer info (Default), 1=Skip customer info of delivery mode");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1092, 1, 0, '', NULL);

-- 15/10/2015
-- Fast Food Generate Queue Mode Setting (Only 6.3 for KDS)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1093, 2, "Fast Food Generate Queue Mode Setting", "0=Generate queue of each sales mode (Default), 1=Generate queue of all sales mode");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1093, 1, 0, '', NULL);

-- 17/11/2015
-- Table Mode -> Sale Mode -> Delivery -> Input Customer Type 
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1094, 2, "Input Customer Type in Delivery SalesMode for Table Mode", "0=No input, auto queue , 1=Full customer same delivery fast food (Default), 2=Only Customer Name");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1094, 1, 1, '', NULL);

-- 18/11/2015
-- Auto Send E-mail when End Day
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1095, 2, "Auto Send E-mail when end day", "0=No send e-mail (Default), 1=Auto Send E-mail");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1095, 1, 0, '', NULL);

-- 25/10/2015 Picket Transaction With 2 Database (Report DB)
ALTER TABLE PickTransactionDetail ADD ReceiptNumber varchar(50) NULL AFTER ReceiptID;
ALTER TABLE PickTransactionDetail ADD AlreadySyncData tinyint NOT NULL DEFAULT '0' AFTER ReceiptNumber;
ALTER TABLE PickTransactionPaymentSetting ADD PickAmount decimal(18,4) NOT NULL DEFAULT '0' AFTER SettingType;
ALTER TABLE PickTransactionPaymentSetting ADD PickAmountType tinyint NOT NULL DEFAULT '0' AFTER PickAmount;

-- Transfer Sync Data For POS Cloud/ PickTransaction To Second DB
CREATE TABLE TransferSyncDataLog (
 SyncID varchar(50) NOT NULL,
 FromShopID int NOT NULL DEFAULT '0',
 DestinationShopID int NOT NULL DEFAULT '0',
 CriteriaStartTime datetime NULL,
 CriteriaEndTime datetime NULL,
 IsFromLastUpdate tinyint NOT NULL DEFAULT '0',
 ExportDateTime datetime NULL,
 ImportDateTime datetime NULL,
 UpdateDate datetime NULL,
 LogResult tinyint NOT NULL DEFAULT '0',
 LogError text NULL,
 PRIMARY KEY  (SyncID)
) ENGINE=InnoDB;

CREATE TABLE TransferSyncDataLogDetail (
 SyncID varchar(50) NOT NULL,
 DataType tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (SyncID, DataType)
) ENGINE=InnoDB;
ALTER TABLE TransferSyncDataLog ADD SyncType tinyint NOT NULL DEFAULT '0' After SyncID;

-- 02/11/2015 Property For FullTax --> Cancel Receipt When Create New FullTax
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(4, 10, 1, "Cancel Normal Receipt When Create New FullTax", "0=No, 1=Yes.");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (4, 10, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,10,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,10,2, 'Yes', 1, 1, 0);

INSERT INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionGroupID, FrontFunctionCode, Description, Description_TH, DisplayInReport) VALUES(40, 3, 'PCFBILL', 'Print Cancel For Create New FullTax', 'พิมพ์ยกเลิกใบรายการเพื่อออกใบกำกับภาษี', 1);

Update ProgramProperty Set PropertyName = 'Hide service charge option for each transaction',Description = '0 = Show check box option whether calculating service charge or not, 1 = Hide check box option and always calculate service charge' Where ProgramTypeID = 1 AND PropertyID = 66;
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,66,1, 'Show check box whether calculate service charge or not', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,66,2, 'Hide check box and alwasy calculate servicehcarge', 1, 1, 0);

ALTER TABLE DocumentTypeProperty ADD CheckStockWhenApprovePrefinish tinyint NOT NULL DEFAULT '0' NULL AFTER CanReceiveAmountUpToPercent;
ALTER TABLE KDS_OrderProcessDetail Add Index ShopDateIndex(ShopID, OrderDate);

CREATE TABLE PMS_PaymentToPMSSystem (
 PayTypeID int NOT NULL DEFAULT '0',
 PMSPayType int NOT NULL DEFAULT '0',
 PRIMARY KEY (PaytypeID)
) ENGINE=InnoDB;
INSERT INTO PMS_PaymentToPMSSystem(PayTypeID, PMSPayType) VALUES(1,5),(2,0),(1120,0);

-- 08/04/2016 - Add field for RewardPointCalculatePointDetail --> SpecialSetting and MemberBirthDay
ALTER TABLE RewardPointCalculatePointDetail ADD SpecialSettingID int NOT NULL DEFAULT '0' After	RewardSettingID;
ALTER TABLE RewardPointCalculatePointDetail ADD ForMemberBirthDay date NULL After LevelID;

-- 11/04/2016 - Convert N Promotion To Bonus Product
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 123, 2, "Convert N Promotion Amount Discount To Bonus Product", "0=No, 1=Yes", 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 123, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,123,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,123,2, 'Yes', 1, 1, 0);

CREATE TABLE OrderCalculateNPromotionToBonusProductTemp (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 PriceGroupID int NOT NULL DEFAULT '0',
 PromoAmount decimal(18,4) NOT NULL DEFAULT '0',
 DiscountPrice decimal(18,4) NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID, PriceGroupID)
) ENGINE=InnoDB;

-- 12/04/2016 - Add Amount for CashOutOrderDetail
ALTER TABLE CashOutOrderDetail ADD CashOutAmount int NOT NULL DEFAULT '1' After	CashOutPrice;
ALTER TABLE CashOutOrderDetail ADD OrderNote varchar(200) NULL After OrderStatusID;
Update CashOutOrderDetail Set CashOutAmount = 1 Where CashOutAmount = 0;

-- 13/04/2016 PMS Mapping ProductGroup/ PMSCode
CREATE TABLE PMS_MappingProductGroupChargeType (
 ProductGroupCode varchar(50) NOT NULL,
 PMSChargeTypeCode varchar(20) NOT NULL,
 PRIMARY KEY (ProductGroupCode)
) ENGINE=InnoDB;

-- 20/04/2016 MultiplePayment For StockOnly
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 124, 2, 'Multiple Payment For Stock Only', '1 = Use multiple payment for Stock Only', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 124, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,124,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,124,2, 'Yes', 1, 1, 0);

-- 22/04/2016 Currency Exchange
ALTER TABLE ExchangeRate_Currency ADD CashChange_MainCurrencyID int NOT NULL DEFAULT '0' AFTER Deleted;
ALTER TABLE ExchangeRate_Currency ADD CashChange_SubCurrencyID int NOT NULL DEFAULT '0' AFTER CashChange_MainCurrencyID;
ALTER TABLE ExchangeRate_Currency ADD CashChange_SubCurrencyForAmountLessThan int NOT NULL DEFAULT '0' AFTER CashChange_SubCurrencyID;

-- 25/04/2016 Back Date Sale As Clone Transaction
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(199,6,'BackDateSaleAsEditVoidTransaction','',183,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,199,'Back date sale as edit void transaction',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,199,'ขายย้อนวันเหมือนแก้ไขใบเสร็จ',2);
Delete From StaffPermission Where PermissionItemID = 199 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,199);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,199);

-- 18/05/2016 UnitName For Currency (In Language)
ALTER TABLE Language ADD LargeCurrencyUnit varchar(20) NULL;
ALTER TABLE Language ADD SmallCurrencyUnit varchar(20) NULL;

-- 26/05/2016 PMS Mapping MealCode
CREATE TABLE PMS_MappingMealCode (
 ProductLevelID int NOT NULL DEFAULT '0',
 MealCode varchar(10) NULL,
 MealName varchar(100) NULL,
 StartMealTime datetime NULL,
 EndMealTime datetime NULL,
 Deleted tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY (ProductLevelID, MealCode)
) ENGINE=InnoDB;

-- PMS Setting
CREATE TABLE PMS_OutletSetting (
 ProductLevelID int NOT NULL DEFAULT '0',
 OutletID varchar(10) NULL,
 PRIMARY KEY (ProductLevelID)
) ENGINE=InnoDB;

CREATE TABLE PMS_TransactionInfo (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 OutletID varchar(10) NULL,
 ReceiptPayAmount decimal(18,4) NOT NULL DEFAULT '0',
 MealCode varchar(10) NULL,
 UpdateDate datetime NULL,
 PRIMARY KEY (TransactionID, ComputerID)
) ENGINE=InnoDB;

ALTER TABLE ProductGroupOverWrite ADD ProductGroupType TINYINT NOT NULL DEFAULT '0' AFTER ProductGroupTakeAway;

ALTER TABLE PMS_PaymentToPMSSystem ADD IsChargeToRoom TINYINT NOT NULL DEFAULT '0' AFTER PMSPayType;


-- 18/07/2016 Oishi - Customize History Of ChangeDetail/ MoveOrder/ MoveTable
ALTER TABLE HistoryOfChangeDetailSubmitOrder ADD OrderDateTime datetime NULL After ChangeDateTime;

ALTER TABLE HistoryOfMoveOrderDetail ADD ProductPrice decimal(18,4) NOT NULL DEFAULT '0' After OrderAmount;
ALTER TABLE HistoryOfMoveOrderDetail ADD OrderDateTime datetime NULL After MoveDateTime;

ALTER TABLE HistoryOfMoveTable ADD TotalPrice decimal(18,4) NOT NULL DEFAULT '0' After ToTableID;
ALTER TABLE HistoryOfMoveTable ADD OpenTime datetime NULL After MoveDateTime;

-- Property For Print Rounding Line Option
Update PropertyOption Set OptionName = 'Print Only Before Rounding' Where PropertyTypeID = 103 AND PropertyID = 5 AND OptionId = 2;
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,5,3, 'Not Print All Rounding Line', 2, 0, 0);

-- Report By PMS Meal Code
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(700,8,'Reports_Sale_PMSMealCode','Reports/report_sale_pmsmealcode.aspx',9,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(700,700,'Sale Report By MealCode',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(701,700,'รายงานการขายตาม Meal Code',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,700);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,700);

Update PermissionItem Set Deleted= 1 Where PermissionItemID = 700;

-- Report - Cash In/Out and Member/Staff Discount
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(701,8,'Reports_CashInOut','Reports/report_cashincashout.aspx',701,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(702,701,'Cash In/Out Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(703,701,'รายงานการ Cash In/Out',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,701);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,701);

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(702,19,'Reports_MemberDiscount','Reports/report_memberstaff_discount.aspx',702,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(704,702,'Member Discount Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(705,702,'รายงานการส่วนลดสมาชิก',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,702);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,702);

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(703,19,'Reports_StaffDiscount','Reports/report_memberstaff_discount.aspx',703,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(706,703,'Staff Discount Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(707,703,'รายงานการส่วนลดพนักงาน',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,703);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,703);

-- 16/08/2016 iOrder Print JobOrderSummary From Owns Printer
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 125, 2, 'iOrder Print Job Order Summary From its printer.', '1 = Print Job Order Summary from iOrder printer', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 125, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,125,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,125,2, 'Yes', 1, 1, 0);

-- E Voucher
-- 16/08/2016 EVoucher Feature
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 126, 2, 'E Voucher Feature', '1 = Use Feature', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 126, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,126,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,126,2, 'Yes', 1, 1, 0);

ALTER TABLE PayDetail ADD IsFromEVoucher tinyint NOT NULL DEFAULT '0' After Paid;
ALTER TABLE PayDetailFront ADD IsFromEVoucher tinyint NOT NULL DEFAULT '0' After Paid;

CREATE TABLE EVoucher_UseInfoFront (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0', 
 SaleDate date NULL,
 POS_ShopID int NOT NULL DEFAULT '0',
 BrandID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 IsOnline tinyint NOT NULL DEFAULT '0',
 VoucherType tinyint NOT NULL DEFAULT '0',
 VoucherID int NOT NULL DEFAULT '0',
 VoucherSerialNumber varchar(50) NULL,
 PromoCode varchar(50) NULL,
 UseAmount decimal(18,4) NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, VoucherSerialNumber)
) ENGINE=InnoDB;

CREATE TABLE EVoucher_UseInfo (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0', 
 SaleDate date NULL,
 POS_ShopID int NOT NULL DEFAULT '0',
 BrandID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 IsOnline tinyint NOT NULL DEFAULT '0',
 VoucherType tinyint NOT NULL DEFAULT '0',
 VoucherID int NOT NULL DEFAULT '0',
 VoucherSerialNumber varchar(50) NULL,
 PromoCode varchar(50) NULL,
 UseAmount decimal(18,4) NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, VoucherSerialNumber)
) ENGINE=InnoDB;

ALTER TABLE EVoucher_UseInfo ADD INDEX SaleDateIndex (SaleDate, POS_ShopID);
ALTER TABLE EVoucher_UseInfoFront ADD INDEX SaleDateIndex (SaleDate, POS_ShopID);

ALTER TABLE Property ADD BrandID int NOT NULL DEFAULT '0';
ALTER TABLE Property ADD BrandName varchar(50) NULL;

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(203,6,'EVoucher_AllowUseOffline','',203,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,203,'Allow use e-voucher offline',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,203,'อนุญาตให้ใช้ e-voucher แบบออฟไลน์',2);
Delete From StaffPermission Where PermissionItemID = 203 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,203);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,203);

-- Voucher SubType For Purchase Voucher
CREATE TABLE ProductEVoucherSetting (
  ProductID int NOT NULL DEFAULT '0',
  VoucherHeader varchar(10) NULL,
  PRIMARY KEY  (ProductID)
) ENGINE=InnoDB;

CREATE TABLE EVoucher_PurchaseVoucherDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  OrderDetailID int NOT NULL DEFAULT '0',
  VoucherSerialNumber varchar(50) NOT NULL, 
  VoucherHeader varchar(10) NULL,
  VoucherNo varchar(50) NOT NULL,
  VoucherID int NOT NULL DEFAULT '0',
  ShopID int NOT NULL DEFAULT '0',
  CustomerName varchar(50) NOT NULL,
  SaleDate date NULL,
  POS_ShopID int NOT NULL DEFAULT '0',  
  PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID, VoucherSerialNumber)    
) ENGINE=InnoDB;

CREATE TABLE EVoucher_PurchaseVoucherDetailFront (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  OrderDetailID int NOT NULL DEFAULT '0',
  VoucherSerialNumber varchar(50) NOT NULL,  
  VoucherHeader varchar(10) NULL,
  VoucherNo varchar(50) NOT NULL,  
  VoucherID int NOT NULL DEFAULT '0',
  ShopID int NOT NULL DEFAULT '0',
  CustomerName varchar(50) NOT NULL, 
  SaleDate date NULL,
  POS_ShopID int NOT NULL DEFAULT '0',  
  PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID, VoucherSerialNumber)    
) ENGINE=InnoDB;
Insert INTO VoucherReuseType(ReuseType, Description) VALUES(4, 'E Voucher');

ALTER TABLE PayType ADD IsManualEVoucher tinyint NOT NULL DEFAULT '0' After IsVoidFromEDC;


-- 23/08/2016 Currency Exchange - Display Format
ALTER TABLE ExchangeRate_Currency ADD CurrencyFormat varchar(20) NULL AFTER Deleted;
ALTER TABLE ExchangeRate_Currency ADD CurrencyRoundType tinyint NOT NULL DEFAULT '0' AFTER CurrencyFormat;
ALTER TABLE ExchangeRate_Currency ADD DigitForRoundingDecimal tinyint NOT NULL DEFAULT '0' AFTER CurrencyRoundType;

-- Permission For Merge-Combine Table, UnMergeTable
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(204,6,'MergeTable','',180,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,204,'Merge Table',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,204,'รวมโต๊ะ',2);
Delete From StaffPermission Where PermissionItemID = 204 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,204);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,204);

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(205,6,'UnMergeTable','',180,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,205,'Cancel Merge Table',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,205,'ยกเลิกการรวมโต๊ะ',2);
Delete From StaffPermission Where PermissionItemID = 205 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,205);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,205);

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(206,6,'MoveOrderBetweenTable','',180,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,206,'Move Order Between Table',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,206,'ย้ายรายการระหว่างโต๊ะ',2);
Delete From StaffPermission Where PermissionItemID = 206 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,206);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,206);

Update PermissionItemName Set PermissionItemName = 'Move Table' Where PermissionItemID = 180 AND LangID = 1;
Update PermissionItemName Set PermissionItemName = 'ย้ายโต๊ะ' Where PermissionItemID = 180 AND LangID = 2;

-- 14/09/2016 Display Change/Combine Table With OrderDetail
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 127, 2, 'Display OrderDetail In Change/ Combine Table Report', '1 = Display Detail', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 127, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,127,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,127,2, 'Yes', 1, 1, 0);

ALTER TABLE HistoryOfMoveOrderDetail ADD ToTransactionOriginalAmount decimal(18,4) NOT NULL DEFAULT '0' After ToOrderDetailID;

-- 09/09/2016 - DocumentType that not display in Alert Box
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(3, 20, 1, 'DocumentType that not display in Alert Box', 'text value = DocumentType that not display in Alert Box', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (3, 20, 1, 0, '', NULL);

-- 12/09/2016
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(704,8,'Reports_SessionConsolidate','Reports/report_session_consolidate.aspx',141,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(708,704,'Session Consolidate Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(709,704,'รายงาน Consolidate',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,704);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,704);

-- 03/10/2016 Table BarCode Number
CREATE TABLE TableBarCodeForOrderMapping (
  TableBarCodeID int NOT NULL DEFAULT '0',
  TableID int NOT NULL DEFAULT '0',
  TableBarCode varchar(20) NULL,
  MaximumNoOfOrderInProcess tinyint NOT NULL DEFAULT '0',
  Deleted tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (TableBarCodeID, TableID)    
) ENGINE=InnoDB;

CREATE TABLE TableBarCodeForOrderProperty (
  ProductLevelID int NOT NULL DEFAULT '0',
  MaximumNoOfOrderInProcess tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (ProductLevelID)      
) ENGINE=InnoDB;

ALTER TABLE FavoriteProducts CHANGE ComputerType ComputerType int NOT NULL DEFAULT '0';

CREATE TABLE FavoriteProductComputerUsingType (
  ComputerID int NOT NULL DEFAULT '0',
  ComputerType int NOT NULL DEFAULT '0',
  PRIMARY KEY  (ComputerID, ComputerType)
) ENGINE=InnoDB;

-- IsVAT In PayDetail
ALTER TABLE PayDetail ADD IsCalculateVAT tinyint NOT NULL DEFAULT '1' After PaymentVAT;
ALTER TABLE PayDetailFront ADD IsCalculateVAT tinyint NOT NULL DEFAULT '1' After PaymentVAT;

ALTER TABLE EVoucher_UseInfo ADD IsVAT tinyint NOT NULL DEFAULT '1' After IsOnline;
ALTER TABLE EVoucher_UseInfoFront ADD IsVAT tinyint NOT NULL DEFAULT '1' After IsOnline;

-- Summary Payment Report View In case there is other receipt that converse data to normal payment
Drop View Summary_PaymentReport;
CREATE VIEW Summary_PaymentReport AS 
SELECT
  `a`.`ShopID`         AS `ShopID`,
  `a`.`SaleDate`       AS `SaleDate`,
  `b`.`PayTypeID`      AS `PayTypeID`,
  `c`.`PayType`        AS `PayTypeName`,
  SUM(`b`.`Amount`)    AS `TotalPay`,
  SUM(ROUND(((`b`.`Amount` * `b`.`PrepaidDiscountPercent`) / 100),2)) AS `TotalPayDiscount`,
  SUM(`b`.`PaymentVAT`) AS `TotalVAT`,
  `c`.`IsSale`         AS `IsSale`,
  `c`.`IsVAT`          AS `IsVAT`,
  IF (a.TransactionStatusID = 11, 1, c.IsOtherReceipt) AS `IsOtherReceipt`,
  `a`.`DocType`        AS `DocType`
FROM ((`ordertransaction` `a`
    JOIN `paydetail` `b`)
   JOIN `paytype` `c`)
WHERE ((`a`.`TransactionID` = `b`.`TransactionID`)
       AND (`a`.`ComputerID` = `b`.`ComputerID`)
       AND (`b`.`PayTypeID` = `c`.`TypeID`)
       AND (`a`.`TransactionStatusID` IN(2,11))
       AND (`a`.`ReceiptID` > 0))
GROUP BY `b`.`PayTypeID`,`c`.`PayType`,`c`.`IsSale`,`c`.`IsVAT`,`c`.`IsOtherReceipt`,`a`.`ShopID`,`a`.`SaleDate`,`a`.`DocType`

-- 05/10/2016 - PMS ChargeTypeInfo - Save Data Send To PMS System
CREATE TABLE PMS_OrderChargeTypeDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  ChargeTypeCode varchar(20) NOT NULL DEFAULT '',
  BaseAmount decimal(18,4) NOT NULL DEFAULT '0',
  ServiceCharge decimal(18,4) NOT NULL DEFAULT '0',
  TaxAmount decimal(18,4) NOT NULL DEFAULT '0',
  OtherTax decimal(18,4) NOT NULL DEFAULT '0',
  ItemAmount int NOT NULL DEFAULT '0',
  PRIMARY KEY  (TransactionID, ComputerID, ChargeTypeCode)
) ENGINE=InnoDB;

-- Summary ProductReport --> Add VATPercent into this view
Drop View Summary_ProductReport;
CREATE VIEW `summary_productreport` AS 
SELECT `a`.`SaleDate` AS `SaleDate`,`a`.`ShopID` AS `ShopID`,`pl`.`ProductLevelCode` AS `ShopCode`,`pl`.`ProductLevelName` AS `ShopName`,`ld`.`ProductID` AS `ProductLinkID`,`a`.`TransactionStatusID` AS `TransactionStatusID`,`b`.`OtherFoodName` AS `OtherFoodName`,
`b`.`OrderStatusID` AS `OrderStatusID`,`b`.`ProductSetType` AS `ProductSetType`,
`b`.`VATType` AS `VATType`,a.VATPercent AS VATPercent, `a`.`DocType` AS `DocType`,`p`.`ProductID` AS `ProductID`,`p`.`ProductCode` AS `ProductCode`,`p`.`ProductName` AS `ProductName`,`p`.`ProductName1` AS `ProductName1`,`p`.`ProductDesp` AS `ProductDesp`,`pd`.`ProductDeptName` AS `ProductDeptName`,`pg`.`ProductGroupName` AS `ProductGroupName`,`pg`.`ProductGroupCode` AS `ProductGroupCode`,`pd`.`ProductDeptCode` AS `ProductDeptCode`,`g1`.`GroupOrdering` AS `GroupOrdering`,`d1`.`DeptOrdering` AS `DeptOrdering`,`b`.`SaleMode` AS `SaleMode`,`sm`.`SaleModeName` AS `SaleModeName`,`sm`.`PositionPrefix` AS `PositionPrefix`,`sm`.`PrefixText` AS `PrefixText`,
SUM(`b`.`Amount`) AS `Amount`,SUM(`c`.`TotalPrice`) AS `TotalPrice`,SUM(IF((`b`.`ProductSetType` >= 0),`c`.`TotalRetailPrice`,IF((`b`.`ProductSetType` = -(4)),`c`.`SalePrice`,0))) AS `TotalRetailPrice`,SUM(`c`.`SalePrice`) AS `SalePrice`,SUM(`c`.`MemberDiscount`) AS `MemberDiscount`,SUM(`c`.`StaffDiscount`) AS `StaffDiscount`,SUM(`c`.`CouponDiscount`) AS `CouponDiscount`,SUM(`c`.`VoucherDiscount`) AS `VoucherDiscount`,SUM(`c`.`OtherPercentDiscount`) AS `OtherPercentDiscount`,SUM(`c`.`EachProductOtherDiscount`) AS `EachProductOtherDiscount`,SUM(`c`.`PricePromotionDiscount`) AS `PricePromotionDiscount` 
FROM ((((((((((`ordertransaction` `a` JOIN `orderdetail` `b` ON(((`a`.`TransactionID` = `b`.`TransactionID`) AND (`a`.`ComputerID` = `b`.`ComputerID`)))) JOIN `orderdiscountdetail` `c` ON(((`b`.`TransactionID` = `c`.`TransactionID`) AND (`b`.`ComputerID` = `c`.`ComputerID`) AND (`b`.`OrderDetailID` = `c`.`OrderDetailID`)))) LEFT JOIN `products` `p` ON((`b`.`ProductID` = `p`.`ProductID`))) LEFT JOIN `productdept` `pd` ON((`p`.`ProductDeptID` = `pd`.`ProductDeptID`))) LEFT JOIN `productgroup` `pg` ON((`pd`.`ProductGroupID` = `pg`.`ProductGroupID`))) LEFT JOIN `dummygroupordering` `g1` ON((`pg`.`ProductGroupCode` = CONVERT(`g1`.`ProductGroupCode` USING utf8)))) LEFT JOIN `dummydeptordering` `d1` ON((`pd`.`ProductDeptCode` = CONVERT(`d1`.`ProductDeptCode` USING utf8)))) LEFT JOIN `salemode` `sm` ON((`b`.`SaleMode` = `sm`.`SaleModeID`))) LEFT JOIN `orderproductlinkdetail` `ld` ON(((`b`.`OrderDetailID` = `ld`.`OrderDetailID`) AND (`b`.`TransactionID` = `ld`.`TransactionID`) AND (`b`.`ComputerID` = `ld`.`ComputerID`)))) LEFT JOIN `productlevel` `pl` ON((`a`.`ShopID` = `pl`.`ProductLevelID`))) WHERE ((`a`.`ReceiptID` > 0) AND (`b`.`ProductSetType` NOT IN (-(1),-(3),14,16)) AND (`a`.`TransactionStatusID` = 2)) GROUP BY `ld`.`ProductID`,`a`.`TransactionStatusID`,`b`.`OtherFoodName`,`b`.`OrderStatusID`,`b`.`ProductSetType`,`b`.`VATType`,`a`.`DocType`,`p`.`ProductID`,`p`.`ProductCode`,`p`.`ProductName`,`p`.`ProductName1`,`p`.`ProductDesp`,`pd`.`ProductDeptName`,`pg`.`ProductGroupName`,`pg`.`ProductGroupCode`,`pd`.`ProductDeptCode`,`b`.`SaleMode`,`sm`.`SaleModeName`,`sm`.`PositionPrefix`,
`sm`.`PrefixText`,`a`.`SaleDate`,`a`.`ShopID`,`pl`.`ProductLevelCode`,`pl`.`ProductLevelName`;

-- 05/09/2016 RewardPoint for CRM
ALTER TABLE RewardPointHistory ADD ShopCode varchar(20) NULL After ShopID;
ALTER TABLE RewardPointHistory ADD ShopName varchar(50) NULL After ShopCode;
ALTER TABLE RewardPointHistory ADD BrandID int NOT NULL DEFAULT '0' After ShopName;

ALTER TABLE PrepaidCardHistory ADD ShopCode varchar(20) NULL After InsertProductLevelID;
ALTER TABLE PrepaidCardHistory ADD ShopName varchar(50) NULL After ShopCode;
ALTER TABLE PrepaidCardHistory ADD BrandID int NOT NULL DEFAULT '0' After ShopName;

-- 20/10/2016 Payment Authorize
ALTER TABLE PayType ADD RequireAuthorize tinyint NOT NULL DEFAULT '0' After IsRequire;

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (207,6,'AuthorizePaymentType','',15,0,NULL,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES(1,207,'Can Authorize Payment',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES (2,207,'มีสิทธิในการใช้การจ่ายเงินที่ต้องการ authorize',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=207) OR (StaffRoleID=2 AND PermissionItemID=207);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,207);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,207);

CREATE TABLE PaymentStaffPermission (
 StaffRoleID int NOT NULL DEFAULT '0',
 PayTypeID int NOT NULL DEFAULT '0', 
 PRIMARY KEY  (StaffRoleID, PayTypeID)
) ENGINE=InnoDB;

INSERT INTO ReasonTextGroup(ReasonGroupID, ReasonGroupName, Enabled, RequireAmount, EnableManualReason) VALUES (12,'Applied Payment', 1, 0, 1);

ALTER TABLE PayDetailFront ADD AuthorizeStaffID int NOT NULL DEFAULT '0' After IsFromEDC;
ALTER TABLE PayDetailFront ADD AuthorizeReason varchar(255) NULL After AuthorizeStaffID;

ALTER TABLE PayDetail ADD AuthorizeStaffID int NOT NULL DEFAULT '0' After IsFromEDC;
ALTER TABLE PayDetail ADD AuthorizeReason varchar(255) NULL After AuthorizeStaffID;

-- 25/10/2016 Export To Text File Sale Data For KingPower/ ProductCategoryCode For KingPower
-- 75 = Property Feature, 76 = Category Code (4 Char), VoucherDetail --> Add PromoCode For Promotion Code To KingPower For Using Promotion
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) values (1,75,2,'Export Text File For KingPower','1 = Show Export Form and Export Sale To Text File For KingPower');
INSERT INTO ProgramPropertyValue(ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue) VALUES (1, 75, 1, 0,'');

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) values (1,76,2,'Product Category Code For KingPower','Use Text Value For ProductCategory for KingPower');
INSERT INTO ProgramPropertyValue(ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue) VALUES (1, 76, 1, 0,'');

-- PromoCode For TextFile
ALTER TABLE VoucherDetail ADD PromoCode varchar(50) NULL;


CREATE TABLE ExportSaleToAirportShopSetting (
 ProductLevelID int NOT NULL DEFAULT '0',
 ShopCodeToTextFile varchar(20) NULL,
 BranchCodeToTextFile varchar(20) NULL,
 PRIMARY KEY  (ProductLevelID)
) ENGINE=InnoDB;

-- 29/10/2016 Edit Staff Detail At Branch
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(2, 17, 1, 'Edit Staff Detail at Branch database', '1 = Can Edit Staff Detail and Password at Brach Database.');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (2, 17, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,17,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,17,2, 'Yes. Edit Staff Detail and Password', 1, 1, 0);

-- 01/11/2016 - Update Sale By Product/ ProductGroup New
UPDATE PermissionItem SET PermissionItemURL = 'Reports/sale_byproductgroup_new.aspx' WHERE PermissionItemID = 40500;
UPDATE PermissionItem SET PermissionItemURL = 'Reports/sale_byproduct_new.aspx' WHERE PermissionItemID = 40501;

-- 14/11/2016 - Header/ Footer For CRM Register Member
INSERT INTO ReceiptHeaderFooterDescription(LineType, Description, HeaderOrFooter, AutoGen, GlobalConfig, Deleted) VALUES(33,'CRM Register Member Header',0,1,1,0);
INSERT INTO ReceiptHeaderFooterDescription(LineType, Description, HeaderOrFooter, AutoGen, GlobalConfig, Deleted) VALUES(34,'CRM Register Member Footer',1,1,1,0);

-- 14/11/2016 Buffet - Add Order After Paid (All Order Go to Buffet Product)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 128, 2, 'Buffet Add Order After Paid.', '1 = Add Order and convert order link to buffet order', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 128, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,128,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,128,2, 'Yes', 1, 1, 0);

-- 23/11/2016 - RedeemPoint
ALTER TABLE RedeemPointSetting ADD AutoSetMemberToTransactionWhenAppliedPayment tinyint NOT NULL DEFAULT '0';
ALTER TABLE RedeemPointSetting ADD AllowRedeemAmountMorethanPaymentAmount tinyint NOT NULL DEFAULT '1';

ALTER TABLE OrderTransaction CHANGE ReferenceNo ReferenceNo varchar(20) NULL;
ALTER TABLE OrderTransactionFront CHANGE ReferenceNo ReferenceNo varchar(20) NULL;

-- 27/11/2016 - PayTypeReferenceValidateSetting
CREATE TABLE PayTypeReferenceValidateSetting (
 PayTypeID int NOT NULL DEFAULT '0',
 FrontPart varchar(20) NULL,
 ReferenceValidLength  tinyint NOT NULL DEFAULT '0',
 ValidLengthIncludeFrontPart  tinyint NOT NULL DEFAULT '0',
 NumericOnlyForRearPart tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY (PayTypeID)
) ENGINE=InnoDB;

INSERT INTO RewardPointBaseOn(BaseOnID, Description) VALUES(4, 'Base On Activate Member');


-- 06/12/2016 FullTaxInvoice - Check And Required Filed
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) 
VALUES(4, 11, 2, 'Check required input field.', '1 = Check required input field', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (4, 11, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,11,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,11,2, 'Yes', 1, 1, 0);

INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(10, 'Gift Card MyKitchen');
INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) VALUES (1121,'Gift Card','GC','Gift Card',1,0,0,1121,10,1,1,0,0,0,0,0,0,0,0,0,0,0,1121);

ALTER TABLE PromotionPriceGroup CHANGE ProductAmount ProductAmount int NOT NULL DEFAULT '0';


-- UpdateView --> Add OrderStatusID 1,2,5 --> Not Include 3,4
-- View From SummaryPromotionReport2
Drop View Summary_PromotionReport2;
CREATE VIEW Summary_PromotionReport2 AS select a.ShopID,a.SaleDate,c.PriceGroupID As PromotionID,
	IF(d.PromotionPriceName is NULL,'Other Discount',d.PromotionPriceName) As PromotionName,SUM(c.DiscountPrice) As TotalDiscount,
	SUM(c.PriceAfterDiscount) As PriceAfterDiscount,COUNT(DISTINCT a.TransactionID,a.ComputerID) As TotalBill 
from ordertransaction a inner join orderdetail b on a.transactionid=b.transactionid and a.computerid=b.computerid 
	inner join orderpromotiondiscountdetail c on b.orderdetailid=c.orderdetailid and b.transactionid=c.transactionid and b.computerid=c.computerid 
	left outer join promotionpricegroup d ON c.PriceGroupID=d.PriceGroupID 
where a.TransactionStatusID=2 AND b.OrderStatusID IN (1,2,5) AND a.DocType=8 AND a.ReceiptID>0 
group by a.ShopID,a.SaleDate,c.PriceGroupID,d.PromotionPriceName;

-- Update View ---> Only 1 Union, the second union for NPromotion Discount which already include in OrderPromotionDiscountDetail
Drop View Summary_PromotionDiscountSummary;
CREATE VIEW Summary_PromotionDiscountSummary AS 
SELECT a.ShopID,a.SaleDate,c.PriceGroupID AS PromotionID,b.ProductID,p.ProductCode,p.ProductName,SUM(b.Amount) AS Amount,
b.RetailPrice AS PricePerUnit,SUM(DiscountPrice) AS Discount,SUM(IF(e.TotalCoupon IS NULL,0,e.TotalCoupon)) AS TotalCoupon,b.ProductSetType 
FROM ordertransaction a INNER JOIN orderdetail b ON a.transactionid=b.transactionid AND a.computerid=b.computerid 
INNER JOIN orderpromotiondiscountdetail c ON b.orderdetailid=c.orderdetailid AND b.transactionid=c.transactionid AND b.computerid=c.computerid 
LEFT OUTER JOIN promotionpricegroup d ON c.pricegroupid=d.pricegroupid LEFT OUTER JOIN Products p ON b.ProductID=p.ProductID 
LEFT OUTER JOIN Summary_DummyPromotion e ON a.TransactionID=e.TransactionID AND a.ComputerID=e.ComputerID AND e.PriceGroupID=c.pricegroupid 
WHERE b.OrderStatusID NOT IN (3,4) AND a.TransactionStatusID=2 AND a.ReceiptID>0 
GROUP BY a.ShopID,a.SaleDate,c.PriceGroupID,b.ProductID,p.ProductCode,p.ProductName,b.RetailPrice,b.ProductSetType 
UNION 
SELECT a.ShopID,a.SaleDate,b.PromotionNPriceID AS PriceGroupID,b.ProductID,p.ProductCode,p.ProductName,SUM(b.Amount),b.RetailPrice,SUM(c.TotalRetailPrice-c.SalePrice),0 AS TotalCoupon,b.ProductSetType 
FROM ordertransaction a INNER JOIN orderdetail b ON a.transactionid=b.transactionid AND a.computerid=b.computerid 
INNER JOIN orderdiscountdetail c ON b.orderdetailid=c.orderdetailid AND b.transactionid=c.transactionid AND b.computerid=c.computerid 
INNER JOIN promotionpricegroup d ON b.PromotionNPriceID=d.pricegroupid INNER JOIN Products p ON b.ProductID=p.ProductID
WHERE b.OrderStatusID=5 AND a.TransactionStatusID=2 AND a.ReceiptID>0 AND b.PromotionNPriceID<>0
GROUP BY a.ShopID,a.SaleDate,b.PromotionNPriceID,b.ProductID,p.ProductCode,p.ProductName,b.RetailPrice,b.ProductSetType ;

CREATE TABLE SessionFormDescription(
 FormID INT NOT NULL DEFAULT '0',
 Description VARCHAR(100) NOT NULL,
 PRIMARY KEY (FormID)
) ENGINE=INNODB;
Insert INTO SessionFormDescription(FormID, Description) VALUES(0, 'Default');
Insert INTO SessionFormDescription(FormID, Description) VALUES(2, 'Doro');
Insert INTO SessionFormDescription(FormID, Description) VALUES(3, 'Oishi');
Insert INTO SessionFormDescription(FormID, Description) VALUES(4, 'Oishi Buffet');
Insert INTO SessionFormDescription(FormID, Description) VALUES(5, 'Daddy Dough');
Insert INTO SessionFormDescription(FormID, Description) VALUES(6, 'Ootoya V.6');
Insert INTO SessionFormDescription(FormID, Description) VALUES(7, 'Waketa');
Insert INTO SessionFormDescription(FormID, Description) VALUES(8, 'SushiTei');
Insert INTO SessionFormDescription(FormID, Description) VALUES(9, 'Cash Count Only');
Insert INTO SessionFormDescription(FormID, Description) VALUES(99, 'Not Print Session');

-- Print Cash By Each Paid Stafff
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (105,13,'Print Cash Detail by Paid Staff', '0 = Not Print, 1 = Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,13,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,13,2, 'Print', 1, 1, 0);

-- 09/01/2017 - Header For PTT Loyalty Redeem 
INSERT INTO ReceiptHeaderFooterDescription(LineType, Description, HeaderOrFooter, AutoGen, GlobalConfig, Deleted) VALUES(35,'PTT BlueCard Redeem Header',0,0,0,1);

-- Enable iOrder can set finish order in kds
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1100, 2, "Enable iOrder can set finish order in kds", "0=No use this feature (Default), 1=Use this feature for iOrder");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1100, 1, 0, '', NULL);
-- Send order with open multiple table
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1101, 2, "Send order with open multiple table", "0=No use this feature (Default), 1=Use this feature for iOrder, 2=Auto merge table, 3=Auto merge table and print long bill");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1101, 1, 3, '', NULL);
-- Enable show last order process of table
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1102, 2, "Enable show last order process of table", "0=No use this feature (Default), 1=Use this feature for iOrder");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1102, 1, 1, '', NULL);

-- 20/1/2017 Add Computer For Running ReceiptNo for Payment From Tablet/ iOrder
ALTER TABLE ComputerName ADD CashierComputerIDForiOrder int NOT NULL DEFAULT '0' After IsMainComputer;

CREATE TABLE PayDetailFromTabletLink(
 TransactionID INT NOT NULL DEFAULT '0',
 ComputerID INT NOT NULL DEFAULT '0',
 TabletComputerID INT NOT NULL DEFAULT '0',
 CashierComputerID INT NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID)
) ENGINE=INNODB;

-- 30/1/2017 KDS For Print BarCode
ALTER TABLE MaxCheckerOrderNumber ADD ForKDS tinyint NOT NULL DEFAULT '0' After OrderNo;
ALTER TABLE MaxCheckerOrderNumber DROP Primary Key, ADD Primary Key(ProductLevelID, OrderDate, ForKDS);

ALTER TABLE KDS_SaleModePropertySetting ADD IsPrintKDSOrderNo tinyint NOT NULL DEFAULT '0' After KDSPrintForm;

ALTER TABLE KDS_OrderProcessDetail ADD KDSOrderNo int NOT NULL DEFAULT '0' After OrderDate;
ALTER TABLE KDS_OrderProcessDetailFront ADD KDSOrderNo int NOT NULL DEFAULT '0' After OrderDate;

ALTER TABLE KDS_OrderProcessDetail ADD DisplayOrdering tinyint NOT NULL DEFAULT '0';
ALTER TABLE KDS_OrderProcessDetailFront ADD DisplayOrdering tinyint NOT NULL DEFAULT '0';

ALTER TABLE KDS_OrderProcessHeader ADD DisplayOrdering tinyint NOT NULL DEFAULT '0';
ALTER TABLE KDS_OrderProcessHeaderFront ADD DisplayOrdering tinyint NOT NULL DEFAULT '0';

ALTER TABLE KDS_PrintJobOrderDetail ADD PrintKDSOrderNo int NOT NULL DEFAULT '0' After SeatNo;
ALTER TABLE KDS_PrintJobOrderDetailFront ADD PrintKDSOrderNo int NOT NULL DEFAULT '0' After SeatNo;

-- Auto Submit When Add Product With No Print (PrinterID = -1)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 129, 2, 'Auto Submit When Add Product With No Print.', '1 = Auto Submit for product with no printer (PriterID = -1)', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 129, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,129,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,129,2, 'Yes', 1, 1, 0);
-- Has Jump To First Order When Display In KDS 
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 130, 2, 'Order can send To first order display In KDS.', '1 = Order can jump from current display to the first in KDS ', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 130, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,130,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,130,2, 'Yes', 1, 1, 0);

INSERT INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionGroupID, FrontFunctionCode, Description, Description_TH, DisplayInReport) VALUES(41, 4, 'JUMPKDS', 'Move Order In KDS To First', 'ย้ายรายการใน KDS เป็นรายการแรก', 0);

-- 16/2/2017 - CRM Permission - CRM Change/ Edit Member Detail
INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (208,6,'CRMEditMemberDetail','',18,0,NULL,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES(1,208,'CRM - Edit Member Detail',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES (2,208,'แก้ไขข้อมูลสมาชิกระบบ CRM',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=208) OR (StaffRoleID=2 AND PermissionItemID=208);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,208);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,208);

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (209,6,'ManualKeyMember','',19,0,NULL,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES(1,209,'Manual search member',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID)VALUES (2,209,'มีสิทธิ์ในการค้นหาสมาชิกแบบ manual',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=209) OR (StaffRoleID=2 AND PermissionItemID=209);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,209);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,209);

INSERT INTO ReasonTextGroup (ReasonGroupID, ReasonGroupName, Enabled) VALUES (10001,'CRM Edit Member', 1);
INSERT INTO ReasonTextGroup (ReasonGroupID, ReasonGroupName, Enabled) VALUES (10002,'Manual Search Member', 1);

-- 10/02/2017 - For CRM Feature
ALTER TABLE Members ADD MemberPassportNo VARCHAR(100) NULL AFTER MemberIDExpiration;
ALTER TABLE Members ADD MemberIDType TINYINT NOT NULL DEFAULT '0' AFTER MemberPassportNo;
ALTER TABLE Members ADD MemberPassportNoIssueDate DATETIME DEFAULT NULL AFTER MemberPassportNo;
ALTER TABLE Members ADD MemberPassportNoExpiration DATETIME DEFAULT NULL AFTER MemberPassportNoIssueDate;

-- 11/02/2017 Add feature Show/Hide Search Member Button
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1098, 2, "Show/Hide Search Member Button", "0=No show search member button, 1=Show search member button (Default)");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) 
Select 1, 1098, pl.ProductLevelID, 1, '', NULL 
From ProductLevel pl LEFT OUTER JOIN ProgramPropertyValue pv ON pl.ProductLevelID = pv.KeyID AND pv.PropertyID = 1098 AND pv.ProgramTypeID = 1 Where pv.PropertyID IS NULL;

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1098,1, 'Not show search button', 0, 0, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1098,2, 'Show search button', 1, 0, 1);

-- 16/02/2017 - KDS - Insert KDS When Add Order (Not When SubmitOrder)
ALTER TABLE KDS_SaleModePropertySetting ADD InsertKDSWhenAddOrder tinyint NOT NULL DEFAULT '0' After IsPrintKDSOrderNo;

ALTER TABLE KDS_OrderProcessHeader ADD CanInsertMoreDetail tinyint NOT NULL DEFAULT '0' After IsPaid;
ALTER TABLE KDS_OrderProcessHeaderFront ADD CanInsertMoreDetail tinyint NOT NULL DEFAULT '0' After IsPaid;

ALTER TABLE SaleModeProductLevelProperty ADD AutoSubmitOrderAfterHoldTransaction tinyint NOT NULL DEFAULT '0' After SaleModeProperty;

-- AutoSubmitOrder When Hold Order
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 131, 2, 'Auto Submit Order When Hold Order', '1 = Order can jump from current display to the first in KDS ', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 131, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,131,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,131,2, 'Yes', 1, 1, 0);

-- 25/02/2017 - CashDrawer Report
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(707,8,'Reports_OpenCashDrawer','Reports/report_opendrawer.aspx',236,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(712,707,'Open Cash Drawer Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(713,707,'รายงานเปิดลิ้นชักเก็บเงิน',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,707);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,707);

-- Not Open Cash Drawer When Payment = 0 
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 132, 2, 'Not Open Cash Drawer when Payment amount = 0', '1 = Not open cash drawer', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 132, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,132,1, 'Open cash drawer', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,132,2, 'Not open cash drawer when payment = 0', 1, 1, 0);

-- 27/2/2017 - Manual Search Member When count time setting
CREATE TABLE HistoryOfManualSearchMember(
 HistoryID int NOT NULL Auto_Increment,
 ProductLevelID INT NOT NULL DEFAULT '0',
 TransactionID INT NOT NULL DEFAULT '0',
 ComputerID INT NOT NULL DEFAULT '0',
 SearchForMemberID INT NOT NULL DEFAULT '0',
 SearchStaffID INT NOT NULL DEFAULT '0',
 SearchComputerID INT NOT NULL DEFAULT '0',
 SearchDateTime datetime NULL,
 FrontFunctionID INT NOT NULL DEFAULT '0',
 HistoryNote Text NULL,
 PRIMARY KEY (HistoryID, ProductLevelID)
) ENGINE=INNODB;
INSERT INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionGroupID, FrontFunctionCode, Description, Description_TH, DisplayInReport) VALUES(42, 9, 'MANUMEM', 'Manual search member when lock input time', 'ค้นหาสมาชิกแบบ manual ขณะที่ lock การค้นหา', 1);

-- Save Membercode for calculate RewardPoint Offline
CREATE TABLE RewardPointTransactionOfflineMember(
 TransactionID INT NOT NULL DEFAULT '0',
 ComputerID INT NOT NULL DEFAULT '0',
 MemberCode varchar(50) NULL,
 ForMemberID INT NOT NULL DEFAULT '0',
 ShopID INT NOT NULL DEFAULT '0',
 RewardPointHistoryID varchar(50) NULL,
 CalculateRewardStatus tinyint NOT NULL DEFAULT '0',
 HistoryDateTime datetime NULL,
 InsertAtHQDateTime datetime NULL,
 AlreadyExportToHQ tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID)
) ENGINE=INNODB;

ALTER TABLE RewardPointHistory Change ReceiptNumber ReceiptNumber varchar(75) NULL;
ALTER TABLE RewardPointHistoryBackUp Change ReceiptNumber ReceiptNumber varchar(75) NULL;

-- Property For RewardPoint For Offline Member
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 133, 2, 'Calculate Reward Point For Offline Member', '1 = Save Offline member and calculate point', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 133, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,133,1, 'No save offline member', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,133,2, 'Save offline member and calculate point', 1, 1, 0);

ALTER TABLE HistoryOfChangeDetailSubmitOrder Change ProductPrice ProductPrice decimal(18,4) NOT NULL DEFAULT '0';

-- DriveThru Sale Mode
INSERT INTO SaleMode(SaleModeID, SaleModeName, Deleted, PositionPrefix, PrefixText, PrefixTextPrinting, PrefixQueue) VALUES(5 ,'Drive Thru', 0, 0, '', '', '');

-- 08/03/2017 - Texas Drive Thru
-- Add feature Interface Hardware with Order Confirmation System (OCS)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (1, 1099, 3, "Enable interface OCS (Order Confirmation System)", "0=No use OCS (Default), 1=Use OCS feature/ Value=IP Server of OCS");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1099, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1099,1, 'No Use OCS', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,1099,2, 'Use OCS', 1, 0, 0);


-- 17/3/2017 - Permission For Insert Offline Member
ALTER TABLE RewardPointTransactionOfflineMember ADD InsertStaffID int NOT NULL DEFAULT '0' After CalculateRewardStatus;
ALTER TABLE RewardPointTransactionOfflineMember ADD InsertComputerID int NOT NULL DEFAULT '0' After InsertStaffID;
ALTER TABLE RewardPointTransactionOfflineMember ADD InsertNote varchar(100) NULL After InsertComputerID;

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (210,6,'OfflineMemberForRewardPoint','',20,0,NULL,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(210,210,'Input Offline Member For Reward Point',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(211,210,'ใส่สมาชิกแบบออฟไลน์สำหรับคำนวณแต้มสะสม',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,210);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,210);

-- ProgramType = 107, Property = 4 Print No. Submit Order At Queue Header
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (107,4,'Print No. Submit Order at Queue Header (Such as (TW)2 - 2 --> No. Submit = 2','',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (107,4,1, 'No', 0, 1, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (107,4,2, 'Yes', 1, 0, 0);

-- Generate Queue No For Each SaleMode
UPDATE ProgramProperty SET Description = '0=Generate queue of each sales mode (Default), 1=Generate queue of all sales mode. Text Value for sale mode that not include in setting'
WHERE ProgramTypeID = 1 AND PropertyID = 1093;

-- Drive Thru Feature
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 134, 3, 'Drive Thru Feature', '1 = Enable Drive Thru', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 134, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,134,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,134,2, 'Enable Drive Thrue', 1, 1, 0);

-- ProductName In Display 2nd Screeen
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 135, 2, 'Print menu name in other language in second screen', '0 = Use default name (ProductName), 1 = Alternative menu name (ProductName1)', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 135, 1, 0, '', NULL);

-- 04/04/2017 : SetMaterialCostTableWhenApproveBatch
ALTER TABLE DocumentTypeTransferGroupProperty ADD SetMaterialCostTableWhenApproveBatch tinyint NOT NULL DEFAULT '0' After DisplayCurrentStockInMatrix;

-- 09/06/2017 - DeActivate ProductSet 6
Update ProductType Set ProductType = 0 Where ProductTypeID = 6;

ALTER TABLE EDC_PAymentInfo CHANGE EDC_InvoiceNo EDC_InvoiceNo VARCHAR(30) NULL;
ALTER TABLE EDC_PAymentInfo CHANGE EDC_TerminalID EDC_TerminalID VARCHAR(20) NULL;
ALTER TABLE EDC_PAymentInfo CHANGE EDC_CardIssueName EDC_CardIssueName VARCHAR(30) NULL;

ALTER TABLE PrinterByTableZone CHANGE PrinterProperty PrinterProperty VARCHAR(255) NULL;





-- 08/05/2017 - SaleDetail_Transaction/ Order/ Promotion/ Payment
CREATE TABLE Export_Sale_Setting (
 ID int NOT NULL DEFAULT '0',
 NoDecimalDigitForCalculateVAT tinyint NOT NULL DEFAULT '4',
 ConvertToOriginalPayTypeID tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY (ID)
) ENGINE=InnoDB;
Insert INTO Export_Sale_Setting(ID, NoDecimalDigitForCalculateVAT, ConvertToOriginalPayTypeID) VALUES(1,4,0);

CREATE TABLE Export_Sale_OrderTransaction(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 ReceiptNo varchar(50) NULL,
 TransactionName varchar(50) NULL,
 QueueName varchar(50) NULL,
 TransactionStatusID int NOT NULL DEFAULT '0',
 SaleMode tinyint NOT NULL DEFAULT '0',
 NoCustomer int NOT NULL DEFAULT '0',
 TableID int NOT NULL DEFAULT '0',
 TableName varchar(50) NULL,
 ReferenceNo varchar(20) NULL,
 CloseComputerID int NOT NULL DEFAULT '0',
 ComputerRegisterNumber varchar(50) NULL,
 TotalRetailPrice decimal(18,6) NOT NULL DEFAULT '0',
 TotalRetailPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 TotalRetailPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPrice decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 OtherIncome decimal(18,6) NOT NULL DEFAULT '0',
 OtherIncomeBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 OtherIncomeVAT decimal(18,6) NOT NULL DEFAULT '0',
 ServiceCharge decimal(18,6) NOT NULL DEFAULT '0',
 ServiceChargeBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 ServiceChargeVAT decimal(18,6) NOT NULL DEFAULT '0',
 ReceiptSalePrice decimal(18,6) NOT NULL DEFAULT '0',
 ReceiptSalePriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 ReceiptSalePriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 TotalAmount decimal(18,6) NOT NULL DEFAULT '0',
 TransactionVAT decimal(18,6) NOT NULL DEFAULT '0',
 TransactionVATAble decimal(18,6) NOT NULL DEFAULT '0',
 SaleDate date NULL,
 ShopID int NOT NULL DEFAULT '0',
 Updatedate datetime NULL,
 PRIMARY KEY (TransactionID, ComputerID)
) ENGINE=InnoDB;
ALTER TABLE Export_Sale_OrderTransaction ADD INDEX SaleDateShopIndex (ShopID, SaleDate);

CREATE TABLE Export_Sale_OrderDetail(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 ProductID int NOT NULL DEFAULT '0',
 ProductCode varchar(50) NULL,
 ProductName varchar(200) NULL,
 ProductSetType tinyint NOT NULL DEFAULT '0',
 SaleMode tinyint NOT NULL DEFAULT '0',
 OrderStatusID tinyint NOT NULL DEFAULT '0',
 Amount decimal(10,2) NOT NULL DEFAULT '0',
 PricePerUnit decimal(18,6) NOT NULL DEFAULT '0',
 VATType tinyint NOT NULL DEFAULT '0',
 HasServiceCharge tinyint NOT NULL DEFAULT '0',
 TotalRetailPrice decimal(18,6) NOT NULL DEFAULT '0',
 TotalRetailPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 TotalRetailPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPrice decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 SalePrice decimal(18,6) NOT NULL DEFAULT '0',
 SalePriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 SalePriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 ServiceCharge decimal(18,6) NOT NULL DEFAULT '0',
 ServiceChargeBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 ServiceChargeVAT decimal(18,6) NOT NULL DEFAULT '0',
 SaleDate date NULL,
 ShopID int NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID)
) ENGINE=InnoDB;
ALTER TABLE Export_Sale_OrderDetail ADD INDEX SaleDateShopIndex (ShopID, SaleDate);

CREATE TABLE Export_Sale_OrderPromotionDiscountDetail(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 TypeID int NOT NULL DEFAULT '0',
 PriceGroupID int NOT NULL DEFAULT '0',
 DiscountPrice decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 SaleDate date NULL,
 ShopID int NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID, TypeID, PriceGroupID)
) ENGINE=InnoDB;
ALTER TABLE Export_Sale_OrderPromotionDiscountDetail ADD INDEX SaleDateShopIndex (ShopID, SaleDate);

CREATE TABLE Export_Sale_PaymentByOrderDetail(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 PayDetailID int NOT NULL DEFAULT '0',
 ProductID int NOT NULL DEFAULT '0',
 ProductName varchar(100) NULL,
 ProductSetType tinyint NOT NULL DEFAULT '0',
 PayTypeID int NOT NULL DEFAULT '0',
 PayPrice decimal(18,6) NOT NULL DEFAULT '0',
 PayPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 PayPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 CreditCardType int NOT NULL DEFAULT '0',
 CreditCardNo varchar(50) NULL,
 PaymentNote varchar(200) NULL,
 SaleDate date NULL,
 ShopID int NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID, PayDetailID)
) ENGINE=InnoDB;
ALTER TABLE Export_Sale_PaymentByOrderDetail ADD INDEX SaleDateShopIndex (ShopID, SaleDate);

CREATE TABLE Export_Sale_PaymentDetail(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 PayDetailID int NOT NULL DEFAULT '0',
 PayTypeID int NOT NULL DEFAULT '0',
 PayPrice decimal(18,6) NOT NULL DEFAULT '0',
 PayPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 PayPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 CreditCardType int NOT NULL DEFAULT '0',
 CreditCardNo varchar(50) NULL,
 PaymentNote varchar(200) NULL,
 SaleDate date NULL,
 ShopID int NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, PayDetailID)
) ENGINE=InnoDB;
ALTER TABLE Export_Sale_PaymentDetail ADD INDEX SaleDateShopIndex (ShopID, SaleDate);

ALTER TABLE Export_Sale_OrderDetail ADD ParentOrderDetailID int NOT NULL DEFAULT '0' After ServiceChargeVAT;

CREATE TABLE Export_Sale_OrderLinkDetail(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 ProductID int NOT NULL DEFAULT '0',
 ProductCode varchar(50) NULL,
 ProductName varchar(200) NULL,
 ProductSetType tinyint NOT NULL DEFAULT '0',
 SaleMode tinyint NOT NULL DEFAULT '0',
 OrderStatusID tinyint NOT NULL DEFAULT '0',
 Amount decimal(10,2) NOT NULL DEFAULT '0',
 PricePerUnit decimal(18,6) NOT NULL DEFAULT '0',
 VATType tinyint NOT NULL DEFAULT '0',
 HasServiceCharge tinyint NOT NULL DEFAULT '0',
 TotalRetailPrice decimal(18,6) NOT NULL DEFAULT '0',
 TotalRetailPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 TotalRetailPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPrice decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 SalePrice decimal(18,6) NOT NULL DEFAULT '0',
 SalePriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 SalePriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 ServiceCharge decimal(18,6) NOT NULL DEFAULT '0',
 ServiceChargeBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 ServiceChargeVAT decimal(18,6) NOT NULL DEFAULT '0',
 ParentOrderDetailID int NOT NULL DEFAULT '0',
 SaleDate date NULL,
 ShopID int NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID)
) ENGINE=InnoDB;
ALTER TABLE Export_Sale_OrderLinkDetail ADD INDEX SaleDateShopIndex (ShopID, SaleDate);

CREATE TABLE Export_Sale_OrderPromotionDiscountLinkDetail(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 TypeID int NOT NULL DEFAULT '0',
 PriceGroupID int NOT NULL DEFAULT '0',
 DiscountPrice decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceBeforeVAT decimal(18,6) NOT NULL DEFAULT '0',
 DiscountPriceVAT decimal(18,6) NOT NULL DEFAULT '0',
 SaleDate date NULL,
 ShopID int NOT NULL DEFAULT '0',
 PRIMARY KEY (TransactionID, ComputerID, OrderDetailID, TypeID, PriceGroupID)
) ENGINE=InnoDB;
ALTER TABLE Export_Sale_OrderPromotionDiscountLinkDetail ADD INDEX SaleDateShopIndex (ShopID, SaleDate);

ALTER TABLE Export_Sale_OrderTransaction ADD VATPercent decimal(5,2) NOT NULL DEFAULT '0' After CloseComputerID;
ALTER TABLE Export_Sale_OrderTransaction ADD ServiceChargePercent decimal(5,2) NOT NULL DEFAULT '0' After VATPercent;

-- 10/07/2017 RealTime SaleReport View Type 
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (2, 18, 1, "Display Real Time Sale Report Diff Column", "1 : Diff = Target - Estimate, 0 : Diff = Estimate - Target, TextValue = No Show Day");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (2, 18, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,18,1, 'Diff = Estimate - Target', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,18,2, 'Diff = Target - Estimate', 1, 1, 0);

-- 11/07/2017 Property For Export Data To Other System (From Front)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 136, 2, 'Export Data To Other System Type From Front', '1 = Export Sale to TRCloud', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 136, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,136,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,136,2, 'Export Sale To TRCloud', 1, 1, 0);

-- 14/07/2017 - Export To CenterDB Log
CREATE TABLE Export_Sale_AutoExportToCenterDBLog (
 ProductLevelID int NOT NULL DEFAULT '0',
 SaleDate date NOT NULL,
 ExportDateTime datetime NULL,
 PRIMARY KEY (ProductLevelID, SaleDate)
) ENGINE=InnoDB;

-- 17/07/2017 Property For Print Receipt Number as BarCode or QRCode
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 137, 2, 
'', '1 = Export Sale to TRCloud', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 137, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,137,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,137,2, '', 1, 1, 0);

CREATE TABLE PrintReferenceInReceiptType (
 PrintReferenceID tinyint NOT NULL DEFAULT '0',
 Description varchar(100) NULL,
 Deleted tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY (PrintReferenceID)
) ENGINE=InnoDB;
INSERT INTO PrintReferenceInReceiptType(PrintReferenceID, Description, Deleted) VALUES(0, 'No', 0);
INSERT INTO PrintReferenceInReceiptType(PrintReferenceID, Description, Deleted) VALUES(1, 'Auto Generate Reference - BarCode', 1);
INSERT INTO PrintReferenceInReceiptType(PrintReferenceID, Description, Deleted) VALUES(2, 'Auto Generate Reference - QR Code', 1);
INSERT INTO PrintReferenceInReceiptType(PrintReferenceID, Description, Deleted) VALUES(3, 'Reference Number - BarCode', 0);
INSERT INTO PrintReferenceInReceiptType(PrintReferenceID, Description, Deleted) VALUES(4, 'Reference Number - QR Code', 0);
INSERT INTO PrintReferenceInReceiptType(PrintReferenceID, Description, Deleted) VALUES(5, 'Receipt Number - BarCode', 0);
INSERT INTO PrintReferenceInReceiptType(PrintReferenceID, Description, Deleted) VALUES(6, 'Receipt Number - QRCode', 0);

-- 24/07/2017 - Export Sale --> Set Print Include Servicecharge/ ServiceChargePercent
CREATE TABLE Export_Sale_ShopConfigSetting (
 ProductLevelID int NOT NULL DEFAULT '0',
 PriceIncludeServiceCharge tinyint NOT NULL DEFAULT '0',
 ServiceChargePercent decimal(5,2) NOT NULL DEFAULT '0',
 PRIMARY KEY (ProductLevelID)
) ENGINE=InnoDB;

CREATE TABLE Export_Sale_PrinceIncludeServiceChargeType (
 PriceIncludeServiceChargeType tinyint NOT NULL DEFAULT '0',
 Description varchar(100) NULL,
 PRIMARY KEY (PriceIncludeServiceChargeType)
) ENGINE=InnoDB;
INSERT INTO Export_Sale_PrinceIncludeServiceChargeType(PriceIncludeServiceChargeType, Description) VALUES(0, 'No');
INSERT INTO Export_Sale_PrinceIncludeServiceChargeType(PriceIncludeServiceChargeType, Description) VALUES(1, 'All Product in Shop (Use Transaction ServiceCharge)');
INSERT INTO Export_Sale_PrinceIncludeServiceChargeType(PriceIncludeServiceChargeType, Description) VALUES(2, 'Only HasServicecharge = 1');

-- 31/07/2017 FullTaxInvoice Lock Customer TaxID Format/ Branch No
INSERT INTO ProgramProperty(ProgramTypeID, PropertyID, KeyTypeID, PropertyName, Description) VALUES (4, 9, 2, 'Lock Number of Customer TaxID', '1 = Lock Only 13 numeric digit can add in TaxID, 5 digit for Branch No.');
INSERT INTO ProgramPropertyValue(ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue) 
Select 4,9,pl.ProductLevelID,1,'' From ProductLevel pl LEFT OUTER JOIN ProgramPropertyValue pv ON pv.ProgramTypeID = 4 AND pv.PropertyID = 9 AND pv.KeyID = pl.ProductLevelID Where pv.PropertyID IS NULL;

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,9,1, 'No', 0, 0, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,9,2, 'Yes. Numeric Only 13 Digit', 1, 1, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,9,2, 'Yes. 13 Digit', 2, 2, 0);

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

-- 14/08/2017 Export Document To CenterDBLog
CREATE TABLE Export_Document_AutoExportToCenterDBLog (
 InventoryID int NOT NULL DEFAULT '0',
 LastExportDateTime datetime NULL,
 PRIMARY KEY (InventoryID)
) ENGINE=InnoDB;

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

CREATE TABLE PMSCMC_ProductGroupMapping (
 ProductLevelID int NOT NULL DEFAULT '0',
 ShiftID int NOT NULL DEFAULT '0',
 ProductGroupID int NOT NULL DEFAULT '0',
 ProductDeptID int NOT NULL DEFAULT '0',
 AccountCode varchar(10) NULL,
 PRIMARY KEY (ProductLevelID, ShiftID, ProductGroupID, ProductDeptID)
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

Update PropertyTextDesp Set Description = 'For Restaurant Interface Only, 1 = Print QueueNo if QueueNo <> empty string., 2 = Print CustomerName if <> empty string.' Where PropertyTypeID = 102 AND PropertyPosition = 4;
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (102,4,3, 'Print Customer Name', 2, 2, 0);

-- 02/10/2017 - Vendor TaxID/ CompanyType
ALTER TABLE Vendors ADD VendorTaxID varchar(50) NULL After VendorAdditional;
ALTER TABLE Vendors ADD VendorCompanyType tinyint NOT NULL DEFAULT '0' After VendorTaxID;
ALTER TABLE Vendors ADD VendorCompanyBranchNo varchar(100) NULL After VendorCompanyType;
ALTER TABLE Vendors ADD FromOtherSystem tinyint NOT NULL DEFAULT '0' After VendorCompanyBranchNo;
ALTER TABLE Vendors CHANGE VendorName VendorName varchar(100) NULL;

ALTER TABLE WelcomeImage ADD ImageFileName2 varchar(150) NULL After ImageFileName;

-- 21/11/2017 - SaleMode StockToInvID
ALTER TABLE SaleModeProductLevelProperty ADD StockToInvID int NOT NULL DEFAULT '0' After PrintToKitchen;

-- 28/11/2017 - Daily/ Weekly/ Monthly Document, use from Auto Create
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(3, 21, 1, 'Stock Count Document from Auto create from Front', '1 = from Auto create document (Can not create from Inventory)', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (3, 21, 1, 0, '', NULL);

-- Add New Staff At Branch
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(2, 19, 1, 'Add New Staff at Branch database', '1 = Can Add New Staff at Brach Database.');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (2, 19, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,19,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,19,2, 'Yes. Can Add New Staff', 1, 1, 0);

-- 25/12/2017 - FullTax Header For Computer
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(4, 12, 3, 'FullTax Header For Computer', 'TextValue = Header For Each Computer(use | for multiple line).');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (4, 12, 1, 0, '', NULL);
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(4, 13, 3, 'FullTax Footer For Computer', 'TextValue = Footer For Each Computer(use | for multiple line).');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (4, 13, 1, 0, '', NULL);

-- 02/12/2017 - Header/ Footer For QR Code Oishi
INSERT INTO ReceiptHeaderFooterDescription(LineType, Description, HeaderOrFooter, AutoGen, GlobalConfig, Deleted) VALUES(36,'QR Survey Header',0,1,1,1);
INSERT INTO ReceiptHeaderFooterDescription(LineType, Description, HeaderOrFooter, AutoGen, GlobalConfig, Deleted) VALUES(37,'QR Survey Footer',1,1,1,1);

-- 10/08/2018 พบว่ามีการเปลี่ยนแปลงโครงสร้าง
-- โครงสร้างเก่า
-- CREATE TABLE QRSurvey_ConfigSetting (
-- BrandCode varchar(10) NULL,
-- SurveyDomain varchar(250) NULL,
-- QRType tinyint NOT NULL DEFAULT '0',
-- Description varchar(100) NULL,
-- PRIMARY KEY (BrandCode)
-- ) ENGINE=InnoDB;

-- ปรับโครงสร้างเก่ากรณีไม่ Drop Table
ALTER TABLE QRSurvey_ConfigSetting ADD SettingID int NOT NULL DEFAULT '0' first,drop primary key,add primary key(SettingID);
ALTER TABLE QRSurvey_ConfigSetting drop column QRType;

-- โครงสร้างใหม่
CREATE TABLE QRSurvey_ConfigSetting (
 SettingID int NOT NULL DEFAULT '0',
 BrandCode varchar(10) NULL,
 SurveyDomain varchar(250) NULL,
 Description varchar(100) NULL,
 PRIMARY KEY (SettingID)
) ENGINE=InnoDB;

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 138, 2, 'Print QR Survey In Receipt For Oishi', '1 = Use QR Survey', 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 138, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,138,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,138,2, 'Print QR Survey in Receipt', 1, 1, 0);

CREATE TABLE Print_QRConfig (
 QRScale_ForQRSize tinyint NOT NULL DEFAULT '2',
 QRVersion tinyint NOT NULL DEFAULT '7',
) ENGINE=InnoDB;


-- 16/01/2018 - Select Bank/ CreditCard Type For EDC
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 139, 2, 'Manual Select Bank and CreditCard For Payment From EDC', '1 = Manual Select', 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 139, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,139,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,139,2, 'Manual Select', 1, 1, 0);


-- 02/02/2018 - Edit Prepaid Card Info
INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (211,14,'EditPrepaidAmount_Front','',50,0,NULL,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,211,'Edit Prepaid Amount at POS',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,211,'แก้ไขจำนวนเงินของ Prepaid ที่ POS',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,211);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,211);

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (212,14,'MergeOrChangePrepaidCard_Front','',51,0,NULL,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,212,'Change/ Merge Prepaid Card at POS',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,212,'รวมหรือย้ายข้อมูล Prepaid ไปยังใบอื่นที่ POS',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,212);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,212);

ALTER TABLE PrepaidCardHistory CHANGE PrepaidComment PrepaidComment varchar(255) NULL;

CREATE TABLE PrepaidCard_MoveHistory (
 HistoryID varchar(50) NOT NULL,
 HistoryComputerID int NOT NULL DEFAULT '0',
 CardID int NOT NULL DEFAULT '0',
 ProductLevelID int NOT NULL DEFAULT '0',
 PrepaidAmount decimal(18,4) NOT NULL DEFAULT '0',
 ToCardID int NOT NULL DEFAULT '0',
 ToProductLevelID int NOT NULL DEFAULT '0',
 ToAmount decimal(18,4) NOT NULL DEFAULT '0',
 NewPrepaidAmount decimal(18,4) NOT NULL DEFAULT '0',
 MoveCardType tinyint NOT NULL DEFAULT '0',
 MoveDate date NULL,
 HistoryDateTime datetime NULL,
 InsertAtHQDateTime datetime NULL,
 StaffID int NOT NULL DEFAULT '0',
 MoveReason varchar(255) NULL,
 InsertAtProductLevelID int NOT NULL DEFAULT '0',
 ShopCode varchar(20) NULL,
 ShopName varchar(50) NULL,
 AlreadyExportToHQ tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY (HistoryID, HistoryComputerID)
) ENGINE=InnoDB;

CREATE TABLE PrepaidCard_MoveCardType (
 MoveCardType tinyint NOT NULL DEFAULT '0',
 Description varchar(50) NULL,
 PRIMARY KEY (MoveCardType)
) ENGINE=InnoDB;
INSERT INTO PrepaidCard_MoveCardType(MoveCardType, Description) VALUES(1, 'Change to new card');
INSERT INTO PrepaidCard_MoveCardType(MoveCardType, Description) VALUES(2, 'Merge with exist card');

ALTER TABLE PrepaidCardInfo ADD OldCardID int NOT NULL DEFAULT '0' After ExpireDate;
ALTER TABLE PrepaidCardInfo ADD OldProductLevelID int NOT NULL DEFAULT '0' After OldCardID;
ALTER TABLE PrepaidCardInfo ADD OldCardNo varchar(30) NULL After OldProductLevelID;


-- 28/02/2018 - Export To Airport --> Payment For Promotion
CREATE TABLE ExportSaleToAirport_PaymentPromoCode (
 PayTypeID int NOT NULL DEFAULT '0',
 AirportPromoCode varchar(10) NULL,
 PRIMARY KEY  (PayTypeID)
) ENGINE=InnoDB;

-- 26/03/2018 - Change documenttypegroupstockendingcolumn Onhand and Ending
update documenttypegroupstockendingcolumn set LeftMovementColumnSummaryColumnName='Onhand',AllSummaryColumnName='Ending';


-- 16/04/2018 - EDCType (6201)
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(3, 'HyperCom');
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(4, 'KTC - Loxbit');
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(5, 'BCA ECR - Indo');
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(6, 'Mandiri - Indo');
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(7, 'Mandiri eCash - Indo');
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(8, 'EDC BPS - BBL');
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(9, 'Rabbit BPS');
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(10, 'Gift Card MyKitchen');
INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName) VALUES(11, 'CIMB NINGA - Indo');
ALTER TABLE EDC_TypeName ADD Deleted tinyint NOT NULL DEFAULT '0';
Update EDC_TypeName Set Deleted = 1 Where EDCTypeID IN (5,6,7,8,9,10,11);

-- Patch 610511
-- 09/04/2018 - Display Shop In Combo In Report By MasterShop
-- INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(2, 20, 1, 'Display Shop In Combo In Report By MasterShop', '1 = Display By MasterShop.');
-- INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (2, 20, 1, 0, '', NULL);
-- INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,20,1, 'No', 0, 0, 1);
-- INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,20,2, 'Yes.', 1, 1, 0);

-- 23/04/2018 - Manual Select Promotion
ALTER TABLE PromotionPriceGroup ADD IsManualSelectPromotion tinyint NOT NULL DEFAULT '0' After PrintSignatureInReceipt;

-- patch610518

-- 07/05/2018 - QA Varince Report - Use Avg. Cost In Each Column From Setting In DocumentTypeGroup
INSERT INTO ProgramPropertyProgramDescription(ProgramTypeID, Description, GroupID) VALUES(9, 'BackOffice Report', 0);

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(9, 2, 1, 'QA Variance - Average Cost In Each Column', '1 = QA Varince Report - Use Avg. Cost In Each Column From Setting In DocumentTypeGroup');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (9, 2, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (9,2,1, 'Use Avg. Cost in All Column', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (9,2,2, 'Use Avg. Cost from setting in DocumentTypeGroup', 1, 1, 0);

-- 09/04/2018 - Display Shop In Combo In Report By MasterShop (Change Property From 20 To 1 ProgramType =8)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(9, 1, 1, 'Display Shop In Combo In Report By MasterShop', '1 = Display By MasterShop.');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (9, 1, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (9,1,1, 'No', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (9,1,2, 'Yes.', 1, 1, 0);

-- 10/05/2018 - Print Receipt Format - Print Current PrepaidAmount/ RewardPoint IN BillDetial
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,12,'Print Current RewardPoint In Bill Detail', '0=Not Print, 1=Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,12,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,12,2, 'Print', 1, 1, 0);

INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,13,'Print Current Prepaid Amount In Bill Detail', '0=Not Print, 1=Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,13,1, 'Not Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,13,2, 'Print', 1, 1, 0);

-- 18/05/2018 - Member's Redeem Product Report
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(710,19,'Report_Member_RedeemProduct','Reports/report_memberredeemproduct.aspx',210,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(718,710,'Member''s Redeem Product Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(719,710,'รายงานการแลกสินค้าจากแต้มสะสมของสมาชิก',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,710);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,710);
INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Member Redeem Product Report'));

-- Online Tax Report Prevent errors when view report.
DROP VIEW OnlineTax;
CREATE VIEW OnlineTax AS SELECT  CONCAT(IF(ISNULL(`dt`.`DocumentTypeHeader`),'',`dt`.`DocumentTypeHeader`),`a`.`ReceiptMonth`,`a`.`ReceiptYear`,'/',`a`.`ReceiptID`) AS `SaleNumber`,  CONCAT(IF(ISNULL(`dt`.`DocumentTypeHeader`),'',`dt`.`DocumentTypeHeader`),`a`.`ReceiptMonth`,`a`.`ReceiptYear`,'/',`a`.`ReceiptID`) AS `ReceiptNumber`,  CONCAT(DATE_FORMAT(`a`.`SaleDate`,'%m/%d/%Y'),' ',DATE_FORMAT(`a`.`PaidTime`,'%T')) AS `TransactionDate`,  ROUND((`a`.`ReceiptSalePrice` - `a`.`TransactionVAT` - a.ServiceCharge),0) AS `AmountTransaksi`,  `a`.`ServiceCharge` AS `AmountService`,  `a`.`TransactionVAT` AS `Tax`,  `a`.`SaleDate` AS `SaleDate`,  `pl`.`ProductLevelCode` AS `OutletCode`,  `pl`.`ProductLevelName` AS `OutletName`,  `a`.`ShopID` AS `ShopID` FROM ((`ordertransaction` `a`  LEFT JOIN `documenttype` `dt`  ON (((`a`.`DocType` = `dt`.`DocumentTypeID`)  AND (`a`.`CloseComputerID` = `dt`.`ComputerID`)  AND (`dt`.`LangID` = 1))))  LEFT JOIN `productlevel` `pl`  ON ((`a`.`ShopID` = `pl`.`ProductLevelID`))) WHERE ((`a`.`TransactionStatusID` = 2)  AND (`a`.`DocType` = 8)  AND (`a`.`ReceiptID` > 0)) ORDER BY `a`.`ReceiptYear`,`a`.`ReceiptMonth`,`a`.`ReceiptID`;
INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Online Tax Report Prevent errors when view report'));

-- Alter table promotionpricegroup
alter table promotionpricegroup drop IsManualSelectPromotion;
INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : alter table promotionpricegroup drop IsManualSelectPromotion'));
alter table promotionpricegroup drop IsSCDExemptVAT;
INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : alter table promotionpricegroup drop IsSCDExemptVAT'));
 
-- 22/05/2018 - Change StaffPassword CharactreSet
Alter table staffs modify StaffPasswordPocket varchar(100) Character set tis620;
INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Change StaffPassword CharactreSet=tis620'));

-- 30/05/2018 - PrepaidCard - HQ
Alter table PrepaidCardInfo Add UpdateAmountDateTime datetime NULL After UpdateDate;
Alter table PrepaidCardInfo Add OnlineStatus tinyint NOT NULL DEFAULT '0';

CREATE TABLE PrepaidCardCalculateCard (
   ID int NOT NULL Auto_Increment,
   CardID int NOT NULL DEFAULT '0',
   ProductLevelID int NOT NULL DEFAULT '0',
   AlreadyCalculate tinyint NOT NULL DEFAULT '0',
   PRIMARY KEY(ID)
) ENGINE=InnoDB;

CREATE TABLE PrepaidCardCalculateCardCurrentAccess (
   IsCalculate tinyint NOT NULL DEFAULT '0',
   CalculateTime datetime NULL
) ENGINE=InnoDB;

Insert INTO SyncDataType(SyncType, Description) VALUES(5, 'PrepaidHistory');

Update ProgramProperty Set Description = '0=No, 1=Yes(Stand alone), 2=Yes(HQ)' Where ProgramTypeID = 1 AND PropertyID = 120;
Update PropertyOption Set OptionName = 'Yes - Stand Alone' Where PropertyTypeID = 1 AND PropertyID = 120 ANd OptionID = 2;
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,120,3, 'Yes - Online', 2, 2, 0);

Insert INTO PrepaidType(PrepaidType, Description) VALUES(6, 'Payment That Cancel');

INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : PrepaidCard - HQ'));

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (711,7,'Prepaid_Management','Prepaid/PrepaidManagement.aspx',70,0,null,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (1,711,'Prepaid Product Setting',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (2,711,'กำหนดสินค้า Prepaid',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=711) Or (StaffRoleID=2 AND PermissionItemID=711);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,711);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,711);

INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Prepaid_Management'));

-- 13/06/2018 OrderTransactionProcessTime
CREATE TABLE OrderTransactionTimeDetail (
  TransactionID int NOT NULL DEFAULT '0',
  ComputerID int NOT NULL DEFAULT '0',
  SaleMode tinyint NOT NULL DEFAULT '0',
  SaleDate date NULL,
  ShopID int NOT NULL DEFAULT '0',
  OpenTime datetime NULL,
  PaidTime datetime NULL,
  FirstOrderTime datetime NULL,
  FirstSendToKDSTime datetime NULL,
  FirstFinishOrderTime datetime NULL,
  LastFinishOrderTime datetime NULL,
  InsertDateTime datetime NULL,
  PRIMARY KEY  (TransactionID, ComputerID),
  INDEX (SaleDate, ShopID)
) ENGINE=InnoDB;

INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : OrderTransactionProcessTime'));

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(712,8,'Report_QuickServiceProcessTime','Reports/report_quickserviceprocesstime.aspx',380,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(720,712,'Quick Service Time Report',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(721,712,'รายงานเวลาการทำรายการ',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=712) Or (StaffRoleID=2 AND PermissionItemID=712);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,712);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,712);

INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Report_QuickServiceProcessTime'));

-- 25/06/2018 - TextParam For Ordering In Add/ Edit Component
INSERT INTO TextParam(TextParamID, TextParamCatID, TextParamName, TextParamOrder) VALUES(1050, 8, 'AddPriceText', 66);
INSERT INTO TextParam(TextParamID, TextParamCatID, TextParamName, TextParamOrder) VALUES(1051, 8, 'AddAmountText', 67);
INSERT INTO TextParam(TextParamID, TextParamCatID, TextParamName, TextParamOrder) VALUES(1052, 8, 'NotNumbericText', 67);

INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2100, 1050, 1, 'Add Price');
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2101, 1050, 2, 'Add Price');
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2102, 1051, 1, 'Add Amount');
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2103, 1051, 2, 'Add Amount');
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2104, 1052, 1, 'Must be numeric');
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2105, 1052, 2, 'ต้องเป็นตัวเลข');

INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : TextParam For Ordering In Add/ Edit Component'));


-- 19/07/2018 - Not Auto Add StaffAccess/ View Inventory When Save As New Shop

Delete From ProgramProperty Where ProgramTypeID = 2 AND PropertyID = 20 AND KeyTypeID = 1;
Delete From ProgramPropertyValue Where ProgramTypeID = 2 AND PropertyID = 20 AND KeyID = 1;
Delete From PropertyOption Where PropertyTypeID = 2 AND PropertyID = 20 AND OptionID = 1;
Delete From PropertyOption Where PropertyTypeID = 2 AND PropertyID = 20 AND OptionID = 2; 
INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Delete Old Property 2,20,1 Display Shop In Combo In Report By MasterShop'));

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(2, 20, 1, 'Not Auto Add Staff Access Inventory When Save As Shop', '0 = Auto 1 = Not Auto Add Staff Access Inventory When save as shop.');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (2, 20, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,20,1, 'Auto Add Staff Access Inventory', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (2,20,2, 'Not Auto Add Staff Access Inventory', 1, 1, 0);

INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Not Auto Add StaffAccess/ View Inventory When Save As New Shop'));

alter table zz_historypatch change zz_historypatch zz_historypatch varchar(135);

-- Patch6111
-- 11/08/2018 - WebService - Property 142 iOrder Add Comment Qty = Comment Qty * Order Qty
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 142, 2, 'Add Qty For comment order from iOrder (Webservice)', '0 = comment qty., 1 = comment qty * order qty.', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 142, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,142,1, 'comment Qty', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,142,2, 'Comment Qty * Order Qty', 1, 1, 0);


-- 05/09/2018 - Session Module - Not Print Discount Detail By PromotionName
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (105,14,'Not Print Discount Summary By Promotion Name', '0 = Print, 1 = Not Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,14,1, 'Print', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,14,2, 'Not Print', 1, 1, 0);

-- Save Question To All Sale Mode
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 144, 2, 'Save Question Detail For All SaleMode', '1 = Save Data', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 144, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,144,1, 'Only for dine In', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,144,2, 'Save for all sale mode', 1, 1, 0);


-- 24/9/2018 - ExportSaleToOtherSystemType
CREATE TABLE ExportDataToOtherSystemType (
 ExportTypeID tinyint NOT NULL DEFAULT '0',
 Description varchar(50) NULL,
 PRIMARY KEY  (ExportTypeID)
) ENGINE=InnoDB;
INSERT INTO ExportDataToOtherSystemType(ExportTypeID, Description) VALUES(1, 'TR Cloud');
INSERT INTO ExportDataToOtherSystemType(ExportTypeID, Description) VALUES(2, 'BuzzBee');
INSERT INTO ExportDataToOtherSystemType(ExportTypeID, Description) VALUES(3, 'AOT RealTime');

-- 28/9/2018 - Display Customer No In TableGrid
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 1068, 2, 'Display No. Customer in Table Grid', '1 = Display No. Customer', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 1068, 1, 0, '', NULL);

-- 17/10/2018 Material MinimumStock
CREATE TABLE MaterialMinimumStockGroup (
 MinimumStockGroupID int NOT NULL DEFAULT '0',
 MinimumStockGroupName varchar(50) NULL,
 InsertStaffID int NOT NULL DEFAULT '0',
 InsertDate datetime NULL,
 UpdateStaffID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL,
 Deleted tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (MinimumStockGroupID)
) ENGINE=InnoDB;

CREATE TABLE MaterialMinimumStockGroupLinkInventory (
 MinimumStockGroupID int NOT NULL DEFAULT '0',
 InventoryID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (MinimumStockGroupID, InventoryID)
) ENGINE=InnoDB;

CREATE TABLE MaterialMinimumStockTable (
 MinimumStockGroupID int NOT NULL DEFAULT '0',
 MaterialID int NOT NULL DEFAULT '0',
 MinimumStock decimal(18,4) NOT NULL DEFAULT '0',
 DefaultForRefillStock decimal(18,4) NOT NULL DEFAULT '0',
 MaximumForRefillStock decimal(18,4) NOT NULL DEFAULT '0',
 SelectUnitLargeID int NOT NULL DEFAULT '0',
 UnitSmallID  int NOT NULL DEFAULT '0',
 UnitSmallRatio decimal(18,4) NOT NULL DEFAULT '0',
 PRIMARY KEY  (MinimumStockGroupID, MaterialID)
) ENGINE=InnoDB;

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl, PermissionItemOrder, PermissionItemIDParent) 
VALUES  (22002,3,'MaterialMinimumStockGroup','Inventory/Material_MinimumStock_Group.aspx',1005,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (22004,22002,'Set Minimum Stock Group',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (22005,22002,'กำหนดกลุ่มสต๊อกต่ำสุด',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=22002) Or (StaffRoleID=2 AND PermissionItemID=22002);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,22002);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,22002);

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl, PermissionItemOrder, PermissionItemIDParent) 
VALUES  (22003,3,'Set_MaterialMinimumStock','Inventory/Material_MinimumStock_Table.aspx',1006,0);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (22006,22003,'Set Minimum Stock',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (22007,22003,'กำหนดสต๊อกต่ำสุด',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=22003) Or (StaffRoleID=2 AND PermissionItemID=22003);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,22003);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (2,22003);


-- 25/10/208 - Skip Print FullTax Rounding Price Link
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES (4, 16, 2, "Skip Print Rounding Line", 
"0 = Print Runding Price, 1 = Skip Print Rounding Price Line");
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (4, 16, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,16,1, 'Print Rounding Price.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (4,16,2, 'Skip Print Rounding Price.', 1, 1, 0);


-- 10/11/2018 - Print Buffet Time Only (Can not Edit Time)
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(220,6,'Buffet_PrintTimeOnlyCanNotEdit','',191,0,NULL,0,0,1,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,220,'Print Buffet Time Only. Note edit buffet time',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,220,'พิมพ์เวลาบุฟเฟ่าอย่างเดียว ไม่สามารถแก้ไขเวลาได้',2);


-- 05/12/2018 - Printer Receipt Ref In Print Job Order
Update PropertyOption Set OptionName = 'Print #TransactionID/ComputerID-PrintBillNo In Receipt.' Where PropertyTypeID = 1 AND PropertyID = 82 AND OptionID = 2;
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,82,3, 'Print Both In Receipt and JobOrder', 2, 3, 0);

-- Print Total In Receipt
ALTER TABLE ExchangeRate_Config Add PrintTotalPriceInReceipt tinyint NOT NULL DEFAULT '0';


-- Prepaid Product Type
CREATE TABLE PrepaidProductSystemType (
 SystemType tinyint NOT NULL DEFAULT '0',
 Description varchar(30) NULL,
 PRIMARY KEY  (SystemType)
) ENGINE=InnoDB;
INSERT INTO PrepaidProductSystemType(SystemType, Description) VALUES(0, 'Synature Prepaid');
INSERT INTO PrepaidProductSystemType(SystemType, Description) VALUES(1, 'Value Design CashCard');

ALTER TABLE ProductPrepaidSetting ADD ForSystemType tinyint NOT NULL DEFAULT '0' After ForMemberOnly;

ALTER TABLE OrderPrepaidTopupInfo ADD ForSystemType tinyint NOT NULL DEFAULT '0';
ALTER TABLE OrderPrepaidTopupInfoFront ADD ForSystemType tinyint NOT NULL DEFAULT '0';

ALTER TABLE PayType CHANGE DisplayName DisplayName varchar(50) NULL;

-- 14/12/2018 - Buffet Print EndTime 
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 146, 2, 
'Print Buffet Change Time When end time > shop close time.', '1 = Print shop close time when change time > close time. PropertyDateValue = close time', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 146, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,146,1, 'Print real time', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,146,2, 'Print close time', 1, 1, 0);


-- 15/12/2018 - CreditCard Report - Display Column
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) VALUES(9, 3, 1, 'CreditCard Report - Display Column', 'TextValue : 1 - CardHolderName');
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (9, 3, 1, 0, '', NULL);


-- 18/12/2018 - Export Sale Stock Text file To Inventory On Cloud
Update ProgramProperty Set PropertyName = 'Export Sale Text File to Other System', Description = '1,2:KingPower/ 3,4:Donmeaung/ 5:RBSC/ 6:InvenOnCloud-Product, 7:InvenOnCloud-Material' Where ProgramTypeID = 1 AND PropertyID = 75;

Create TABLE ExportInvOnCloud_ConfigSetting(
 ID int NOT NULL DEFAULT '0',
 CSVDelimeterString varchar(1) DEFAULT '|',
 BrandCode varchar(5) NULL,
 QtyFormat varchar(20) NULL,
 PriceFormat varchar(20) NULL,
 DateFormat varchar(20) NULL,
 DateTimeFormat varchar(20) NULL,
 ExportIncludeHeader tinyint NOT NULL DEFAULT '0',
 DefaultDocumentTypeMappingCode varchar(50) NULL,
 PRIMARY KEY(ID)
) ENGINE=InnoDB;
INSERT INTO ExportInvOnCloud_ConfigSetting(ID, CSVDelimeterString, BrandCode, QtyFormat, PriceFormat, DateFormat, DateTimeFormat, 
ExportIncludeHeader, DefaultDocumentTypeMappingCode) VALUES(1, ',', '01', '0.##', '0.00##', 'dd/MM/yyyy', 'ddMMyyyy_HHmmss', 0, 'SALE_POS');

Create TABLE ExportInvOnCloud_MappingDocumentType(
 DocumentTypeID int NOT NULL DEFAULT '0',
 MappingCode varchar(50) NULL,
 PRIMARY KEY(DocumentTypeID)
) ENGINE=InnoDB;
INSERT INTO ExportInvOnCloud_MappingDocumentType(DocumentTypeID, MappingCode) VALUES(20, 'POS_SA') ;
INSERT INTO ExportInvOnCloud_MappingDocumentType(DocumentTypeID, MappingCode) VALUES(21, 'POS_SA_VOID') ;
INSERT INTO ExportInvOnCloud_MappingDocumentType(DocumentTypeID, MappingCode) VALUES(60, 'POS_SA') ;
INSERT INTO ExportInvOnCloud_MappingDocumentType(DocumentTypeID, MappingCode) VALUES(62, 'POS_SA_VOID') ;


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


ALTER TABLE Export_Sale_OrderTransaction ADD OpenTime datetime NULL After ComputerID;
ALTER TABLE Export_Sale_OrderTransaction ADD PaidTime datetime NULL After OpenTime;

-- INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Patch6201'));

-- 21/01/2019 - QR Payment From EDC
ALTER TABLE EDC_PaymentInfo ADD EDCType tinyint NOT NULL DEFAULT '0' After ShopID;
ALTER TABLE EDC_PaymentInfo ADD QRPaymentCode varchar(5) NULL After EDC_ResponseText;
ALTER TABLE EDC_PaymentInfo ADD HostID varchar(5) NULL After EDC_NII;

INSERT INTO EDC_TypeName(EDCTypeID, EDCTypeName, Deleted) VALUES(20, 'QR Payment', 0);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1140,'QR Ali','QRAli','QR - Ali',1,0,1,0,20,1,1,0,0,0,0,0,0,0,0,0,0,0,1140);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1141,'QR WeChat','QRWeChat','QR - WeChat',1,0,1,0,20,1,1,0,0,0,0,0,0,0,0,0,0,0,1141);

INSERT INTO PayType(TypeID, PayType, PayTypeCode, DisplayName, IsAvailable, SetDefault, Deleted, ConvertPayTypeTo, EDCType, IsSale, IsVAT, IsOtherReceipt, PrepaidDiscountPercent, DefaultPayPrice, PayTypeGroupID, IsRequire, IsFixPrice, IsOpenDrawer, MaxNoPayInTransaction, 
PayTypeFunction, CanEditDeletePaymentInMultiple, NotAllProducts, PayTypeOrdering) 
VALUES (1142,'QR Thai','QRThai','QR - Thai QR',1,0,1,0,20,1,1,0,0,0,0,0,0,0,0,0,0,0,1142);


CREATE TABLE PayType_QRPaymentConfig(
  PayTypeID int NOT NULL DEFAULT '0',
  CodeForQRPayment varchar(5) NULL,
  UseInquiryFeature tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY  (PayTypeID)
) ENGINE=InnoDB;
INSERT INTO PayType_QRPaymentConfig(PayTypeID, CodeForQRPayment, UseInquiryFeature) VALUES(1140, '01', 0);
INSERT INTO PayType_QRPaymentConfig(PayTypeID, CodeForQRPayment, UseInquiryFeature) VALUES(1141, '02', 0);
INSERT INTO PayType_QRPaymentConfig(PayTypeID, CodeForQRPayment, UseInquiryFeature) VALUES(1142, '03', 0);

ALTER TABLE PayType_QRPaymentConfig ADD UseInquiryFeature tinyint NOT NULL DEFAULT '0';

-- 09/01/2019
-- Inventory Property For Display Template Code In DocumentNumber (When Document from Template)
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(3, 25, 1, 'Display Template Code In Document Number.', '1 = Display Template Code in document number when document from template', 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (3, 25, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,25,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,25,2, 'Yes.', 1, 1, 0);

ALTER TABLE DocumentTemplateSetting ADD MaxLenTemplateCode tinyint NOT NULL DEFAULT '0';

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl, PermissionItemOrder, PermissionItemIDParent, PermissionItemAssign) 
VALUES  (18000,26,'DocumentTemplateSetting','DocumentSetting/DocumentTemplateSetting.aspx',50,0,3);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (1,18000,'Config Document Template',1);
INSERT INTO permissionitemname (PermissionItemNameID, PermissionItemID, PermissionItemName, LangID) VALUES (2,18000,'ตั้งค่าเอกสารเทมเพลท',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=18000);
INSERT INTO staffpermission (StaffRoleID,PermissionItemID) VALUES (1,18000);

-- 28/01/2019 - Edit Multiple DocDetail Button
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(3, 26, 1, 'Display Edit Multiple DocDetail Button.', '1 = Show Edit Multiple Button', 0);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (3, 26, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,26,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,26,2, 'Yes.', 1, 1, 0);
-- 11/02/2019 - Print Customize Receipt Form Type : 1 = PDS : SalePrice In Order Include ExcludeVAT/ ServiceCharge
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (103,14,'Print Receipt Form (Customize Form)', '0=Normal, 1=PDS - Print Price = Include Exclude/ SC ',0,0,1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,14,1, 'Normal Form', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (103,14,2, 'PDS - Print Price = SalePrice + ExcludeVAT + ServiceCharge', 1, 1, 0);

-- 12/02/2019 - Add Product VAT In Summary_ProductReport/ Summary_ProductAllReport 
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(9, 5, 1, 'Add VAT Price In Summary_ProductReport/ Summary_ProductAllReport', '1 = Add VAT Price In Summary_ProductReport/ Summary_ProductAllReport For Sale By Product', 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (9, 5, 1, 0, '', NULL);


-- 18/02/2019 - Symphony PMS Setting - SendVoidTransaction
ALTER TABLE PMS_OutletSetting ADD SendVoidTransactionToPMS tinyint NOT NULL DEFAULT '0';

-- 21/02/2019 - Update PurchaseRequest
UPDATE PermissionItem SET PermissionItemURL = 'Inventory/PurchaseRequest.aspx' WHERE PermissionItemID = 15140 AND PermissionItemURL Like '%Purcahse%';
Update ProgramProperty Set PropertyName = 'Source of Address For Print PO Document.', Description = '0 = Own Inventory/ 1 = Select From Company Profile, 2 = Select From AccountData.' 
Where ProgramTypeID = 3 AND PropertyID = 16;

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(3, 27, 1, 'Use Delivery Address in Company Profile for print Document', '1 = Use Delivery Address', 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (3, 27, 1, 0, '', NULL);

-- 04/03/2019
-- Inventory Property For Export PO Document When Approve
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(3, 28, 1, 
'Export Document To CSV/ Excel When Approve Document.', 'Value = ExportType : 1 = Oishi, 2 = Hachiban', 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (3, 28, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,28,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,28,2, 'For Oishi', 1, 1, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (3,28,3, 'For Hachiban', 2, 2, 0);

-- ManageData For Prepaid
INSERT INTO TransferDataType(DataTypeID, DataTypeCode, DataTypeName, DataTypeDescription, IsReStartProgram) VALUE(7, 'PPDSMD', 'Prepaid Data', 'Prepaid Card Info and History', 0);
INSERT INTO transferdatatypefor(DataTypeFor, DataTypeID) VALUES(1,7);
INSERT INTO transferdatatypefor(DataTypeFor, DataTypeID) VALUES(2,7);
INSERT INTO transferdatatypesetting(DataTypeGroupID, DataTypeGroupFor, DataTypeID, Ordering) VALUES(1, 2, 7, 3);
INSERT INTO transferdatatypesetting(DataTypeGroupID, DataTypeGroupFor, DataTypeID, Ordering) VALUES(2, 1, 7, 2);
INSERT INTO transferdatatypesetting(DataTypeGroupID, DataTypeGroupFor, DataTypeID, Ordering) VALUES(2, 2, 7, 1);

-- 08/03/2019 - ProductDetail In Flexible Product Report
INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent, Deleted)
VALUES(720,8,'Report_ProductInFlexibleSet','Reports/Report_ProductDetailInFlexibleSet.aspx',52,0, 0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,720,'Report Detail In Product Set',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,720,'รายงานรายละเอียดของชุดสินค้า',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,720);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,720);

-- 12/03/2019 - DocumentTypeProperty For DocumentDate/ MaterialDefaultTransferPrice
ALTER TABLE DocumentTypeProperty ADD DocumentDateAsCurrentDateWhenApprove tinyint NOT NULL DEFAULT '0' After YieldDocumentTypeWhenApproveRODocument;

CREATE TABLE MaterialDefaultTransferPrice(
  MaterialID int NOT NULL DEFAULT '0',
  InventoryID int NOT NULL DEFAULT '0',  
  ToInventoryID int NOT NULL DEFAULT '0',
  SelectUnitLargeID int NOT NULL DEFAULT '0',
  DefaultPrice decimal(20,10) NOT NULL DEFAULT '0',
  UnitSmallAmount decimal(18,4) NOT NULL DEFAULT '0',
  UnitSmallID int NOT NULL DEFAULT '0',
  UnitSmallRatio decimal(18,4) NOT NULL DEFAULT '0',
  PRIMARY KEY  (MaterialID, InventoryID, ToInventoryID)
) ENGINE=InnoDB;

CREATE TABLE DocumentDefaultPriceType(
  DefaultPriceType int NOT NULL DEFAULT '0',
  Description varchar(50) NULL,
  PRIMARY KEY  (DefaultPriceType)
) ENGINE=InnoDB;
INSERT INTO DocumentDefaultPriceType(DefaultPriceType, Description) VALUES(1, 'From MaterialDefaultPrice (From Receive)');
INSERT INTO DocumentDefaultPriceType(DefaultPriceType, Description) VALUES(2, 'From MaterialCostTable');
INSERT INTO DocumentDefaultPriceType(DefaultPriceType, Description) VALUES(3, 'From MaterialTransferPrice');
INSERT INTO DocumentDefaultPriceType(DefaultPriceType, Description) VALUES(4, 'From Average Price');
INSERT INTO DocumentDefaultPriceType(DefaultPriceType, Description) VALUES(5, 'MaterialDefaultTransferPrice(For TransferWithCost)');


INSERT INTO DocumentDefaultPriceType(DefaultPriceType, Description) VALUES(6, 'MaterialDefaultTransferPrice For Each To Inventory'); -- 11/07/2019

-- 22/10/2018 - CrytalReport Form For Inventory
ALTER TABLE DocumentTypeProperty ADD PrintFormFileName_Lang1 varchar(50) NULL;
ALTER TABLE DocumentTypeProperty ADD PrintFormFileName_Lang2 varchar(50) NULL;

Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRPurchase-EN.rpt', PrintFormFileName_Lang2 = 'CRPurchase-TH.rpt' Where DocumentTypeID = 1 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRReceivePurchase-EN.rpt', PrintFormFileName_Lang2 = 'CRReceivePurchase-TH.rpt' Where DocumentTypeID = 2 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRTransferDocument-EN.rpt', PrintFormFileName_Lang2 = 'CRTransferDocument-TH.rpt' Where DocumentTypeID = 3 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRTransferDocument-EN.rpt', PrintFormFileName_Lang2 = 'CRTransferDocument-TH.rpt' Where DocumentTypeID = 17 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRReceiveTransferDocument-EN.rpt', PrintFormFileName_Lang2 = 'CRReceiveTransferDocument-TH.rpt' Where DocumentTypeID = 25 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRTransferWithCostDocument-EN.rpt', PrintFormFileName_Lang2 = 'CRTransferWithCostDocument-TH.rpt' Where DocumentTypeID = 46 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRReceiveFromTransferWithCostDocument-EN.rpt', PrintFormFileName_Lang2 = 'CRReceiveFromTransferWithCostDocument-TH.rpt' Where DocumentTypeID = 47 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRReceiveOrder-EN.rpt', PrintFormFileName_Lang2 = 'CRReceiveOrder-TH.rpt' Where DocumentTypeID = 39 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRPurchase-EN.rpt', PrintFormFileName_Lang2 = 'CRPurchase-TH.rpt' Where DocumentTypeID = 63 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRTransferDocument-EN.rpt', PrintFormFileName_Lang2 = 'CRTransferDocument-TH.rpt' Where DocumentTypeID = 6 AND PrintFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintFormFileName_Lang1= 'CRTransferDocument-EN.rpt', PrintFormFileName_Lang2 = 'CRTransferDocument-TH.rpt' Where DocumentTypeID IN (12,27,28) AND PrintFormFileName_Lang1 IS NULL; 

ALTER TABLE DocumentTypeProperty ADD PrintCompareFormFileName_Lang1 varchar(50) NULL After PrintFormFileName_Lang2;
ALTER TABLE DocumentTypeProperty ADD PrintCompareFormFileName_Lang2 varchar(50) NULL After PrintCompareFormFileName_Lang1;

Update DocumentTypeProperty Set PrintCompareFormFileName_Lang1= 'CRReceivePurchase_Compare-EN.rpt', PrintCompareFormFileName_Lang2 = 'CRReceivePurchase_Compare-TH.rpt' Where DocumentTypeID = 2 AND PrintCompareFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintCompareFormFileName_Lang1= 'CRTransferDocument_Compare-EN.rpt', PrintCompareFormFileName_Lang2 = 'CRTransferDocument_Compare-TH.rpt' Where DocumentTypeID = 3 AND PrintCompareFormFileName_Lang1 IS NULL;  
Update DocumentTypeProperty Set PrintCompareFormFileName_Lang1= 'CRReceiveFromTransfer_Compare-EN.rpt', PrintCompareFormFileName_Lang2 = 'CRReceiveFromTransfer_Compare-TH.rpt' Where DocumentTypeID = 25 AND PrintCompareFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintCompareFormFileName_Lang1= 'CRTransferWithCostDocument_Compare-EN.rpt', PrintCompareFormFileName_Lang2 = 'CRTransferWithCostDocument_Compare-TH.rpt' Where DocumentTypeID = 46 AND PrintCompareFormFileName_Lang1 IS NULL; 
Update DocumentTypeProperty Set PrintCompareFormFileName_Lang1= 'CRReceiveFromTransferWithCost_Compare-EN.rpt', PrintCompareFormFileName_Lang2 = 'CRReceiveFromTransferWithCost_Compare-TH.rpt' Where DocumentTypeID = 47 AND PrintCompareFormFileName_Lang1 IS NULL; 

-- 27/03/2019 - DocumentProperty For RefreshCurrentStock When LoadDocument
ALTER TABLE DocumentTypeProperty ADD RefreshCurrentStockWhenLoadDocument tinyint NOT NULL DEFAULT '0' After DocumentDateAsCurrentDateWhenApprove;


INSERT INTO DocumentFormDescription(DocumentFormID, Description) VALUES(14, 'Add/ Reduce Document');

-- 10/04/2019 - Promotion Lock Payment Feature/ Check Product Can Order Together In Each Transaction
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 147, 1, 
'Promotion Lock Payment Feature', '1 = Promotion can be paid by specific payment. (There will be Lock Payment link in Promotion Setting)', 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 147, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,147,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,147,2, 'Use Promotion Lock Payment Feature.', 1, 1, 0);

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description, Deleted) VALUES(1, 148, 1, 
'Check Product Can Order Together Feature', '1 = Check For Product can be ordered together (Such as different buffet product)', 1);
INSERT INTO ProgramPropertyValue (ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue, PropertyDateValue) VALUES (1, 148, 1, 0, '', NULL);

INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,148,1, 'No.', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (1,148,2, 'Use Feature.', 1, 1, 0);


-- 30/10/2014 PromotionLockPayType
CREATE TABLE PromotionLockPayType (
 PriceGroupID int NOT NULL DEFAULT '0',
 PayTypeID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (PriceGroupID, PayTypeID)
) ENGINE=InnoDB;

-- 10/04/2019 ProductNotOrderTogether
CREATE TABLE ProductNotOrderTogether (
 ProductID int NOT NULL DEFAULT '0',
 NotTogetherProductID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (ProductID, NotTogetherProductID)
) ENGINE=InnoDB;

INSERT INTO TextParam(TextParamID, TextParamCatID, TextParamName, TextParamOrder) VALUES(881, 7, 'SetNotOrderTogetherText', 97);
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(1769, 881, 1, 'Product Not Order Together');
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(1770, 881, 2, 'รายการที่ไม่ให้สั่งด้วยกัน');

Update TextParam Set TextParamOrder = 68 Where TextParamID = 1052;

INSERT INTO TextParam(TextParamID, TextParamCatID, TextParamName, TextParamOrder) VALUES(1053, 8, 'ProductNotOrderTogetherHeader', 69);
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2106, 1053, 1, 'Set Product Not Order Together for');
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2107, 1053, 2, 'กำหนดสินค้าที่ไม่ให้สั่งร่วมกับ');

INSERT INTO TextParam(TextParamID, TextParamCatID, TextParamName, TextParamOrder) VALUES(1054, 8, 'ProductNotOrderTogetherHeader', 70);
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2108, 1054, 1, 'Are you sure you want delete');
INSERT INTO TextParamValue(TextParamValueID, TextParamID, LangID, TextParamValue) VALUES(2109, 1054, 2, 'คุณแน่ใจหรือไม่ว่าคุณต้องการลบสินค้า');


-- 03/05/2019 PrepaidCard Config
CREATE TABLE PrepaidCardConfig (
 ID int NOT NULL DEFAULT '0',
 SelectTopupReceiptWhenPayment tinyint NOT NULL DEFAULT '0',
 RefundFromTopupFeature tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (ID)
) ENGINE=InnoDB;
INSERT INTO PrepaidCardConfig(ID, SelectTopupReceiptWhenPayment, RefundFromTopupFeature) VALUES(1, 0, 0);

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (221,14,'RefundPrepaid','',52,0,NULL,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,221,'Refund Prepaid',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,221,'Refund Prepaid',2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,221);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,221);

INSERT INTO PrepaidType(PrepaidType, Description) VALUES(7, 'Refund Prepaid');

CREATE TABLE PrepaidCardTopupDetail (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 CardID int NOT NULL DEFAULT '0',
 CardProductLevelID int NOT NULL DEFAULT '0', 
 MemberID int NOT NULL DEFAULT '0',
 TopupDate date NULL,
 TotalTopupAmount decimal(18,4) NOT NULL DEFAULT '0',
 AlreadyRefundAmount decimal(18,4) NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 InsertDate datetime NULL,
 UpdateDate datetime NULL,
 TransactionStatusID int NOT NULL DEFAULT '0',
 AlreadyExportToHQ tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (TransactionID, ComputerID, CardID, CardProductLevelID)
) ENGINE=InnoDB;

-- Insert To PrepaidCardTopupDetail (Only For Topup Not In This Table yet)
INSERT INTO PrepaidCardTopupDetail(TransactionID, ComputerID, CardID, CardProductLevelID, MemberID, TopupDate, TotalTopupAmount, 
AlreadyRefundAmount, ShopID, InsertDate, UpdateDate, TransactionStatusID, AlreadyExportToHQ)
Select ph.TransactionID, ph.ComputerID, ph.CardID, ph.ProductLevelID,  ph.MemberID, ph.PrepaidDate,
Sum(Amount) as TotalTopupAmount, 0, ph.InsertProductLevelID, Max(HistoryDateTime), Max(HistoryDateTime), ot.TransactionStatusID, 0
From PrepaidCardHistory ph INNER JOIN OrderTransaction ot ON ph.ComputerID = ot.ComputerID AND ph.TransactionID = ot.TransactionID
LEFT OUTEr JOIN PrepaidCardTopupDetail ptd ON ph.ComputerID = ptd.ComputerID AND ph.TransactionID = ptd.TransactionID
Where ph.PrepaidType = 1 AND ptd.ComputerID IS NULL
Group By ph.CardID, ph.ProductLevelID, ph.TransactionID, ph.ComputerID, ph.MemberID, ph.PrepaidDate, ot.TransactionStatusID, ph.InsertProductLevelID;

CREATE TABLE PrepaidCardRefundDetail (
 RefundID int NOT NULL DEFAULT '0',
 RefundComputerID int NOT NULL DEFAULT '0',
 SessionID int NOT NULL DEFAULT '0',
 RefundDate date NULL,
 RefundStatus int NOT NULL DEFAULT '0', 
 DocType int NOT NULL DEFAULT '0',
 ReceiptYear int NOT NULL DEFAULT '0',
 ReceiptMonth int NOT NULL DEFAULT '0',
 ReceiptID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 MemberID int NOT NULL DEFAULT '0',
 CardID int NOT NULL DEFAULT '0',
 CardProductLevelID int NOT NULL DEFAULT '0',
 RefundAmount decimal(18,4) NULL,
 AfterRefundAmount decimal(18,4) NULL,
 RefundFromTransactionID int NOT NULL DEFAULT '0',
 RefundFromComputerID  int NOT NULL DEFAULT '0',
 RefundNote varchar(255) NULL,
 RefundStaffID int NOT NULL DEFAULT '0',
 RefundDateTime datetime NULL,
 UpdateDate datetime NULL,
 AlreadyExportToHQ tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (RefundID, RefundComputerID)
) ENGINE=InnoDB;

-- Refund Prepaid Receipt Header
INSERT INTO DocumentType (DocumentTypeID, LangID, ShopID, ComputerID, DocumentTypeHeader, DocumentTypeName, ShowOnSearch, MovementInStock, IsAddReduceDoc, CalculateInProfitLoss, CalculateNetUse, CalculateStandardProfitLoss, Deleted) VALUES (65, 1, 1, 0, 'RPR', 'Refund Prepaid Receipt Doc Type', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO DocumentType (DocumentTypeID, LangID, ShopID, ComputerID, DocumentTypeHeader, DocumentTypeName, ShowOnSearch, MovementInStock, IsAddReduceDoc, CalculateInProfitLoss, CalculateNetUse, CalculateStandardProfitLoss, Deleted) VALUES (65, 2, 1, 0, 'RPR', 'ใบเสร็จการคืนเงิน prepaid', 0, 0, 0, 0, 0, 0, 0);

INSERT INTO ReceiptHeaderFooterDescription(LineType, Description, HeaderOrFooter, AutoGen, GlobalConfig, Deleted) VALUES(38,'Prepaid Refund Header',0,1,1,0);
INSERT INTO ReceiptHeaderFooterDescription(LineType, Description, HeaderOrFooter, AutoGen, GlobalConfig, Deleted) VALUES(39,'Prepaid Refund Footer',1,1,1,0);

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionitemUrl,PermissionItemOrder,PermissionItemIDParent)
VALUES(722,34,'ReportPrepaid_TopupRefund','ReportPrepaid/PrepaidReportTopupRefund.aspx',1520,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(1,722,'Topup/ Refund Prepaid',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID)VALUES(2,722,'รายงาน Topup/ Refund Prepaid',2);
DELETE FROM staffpermission WHERE (StaffRoleID=1 AND PermissionItemID=722) Or (StaffRoleID=2 AND PermissionItemID=722);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(1,722);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID)VALUES(2,722);

-- PermissionGroup for PrepaidReport
INSERT INTO PermissionGroup(PermissionGroupID, PermissionCategoryID, PermissionGroupOrder, Deleted) VALUES(34, 0, 105, 0);
INSERT INTO PermissionGroupName(PermissionGroupNameID, PermissionGroupID, PermissionGroupName, LangID) VALUES(15006, 34, 'Prepaid Report', 1);
INSERT INTO PermissionGroupName(PermissionGroupNameID, PermissionGroupID, PermissionGroupName, LangID) VALUES(15007, 34, 'รายงาน Prepaid', 2);

Update PermissionItem Set PermissionGroupID = 34 Where PermissionItemID IN (722,60037,60038);

-- ลบ permissionitemname Lang ซ้ำ
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=30008 AND PermissionItemID=193);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7002032 AND PermissionItemID=203);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7002072 AND PermissionItemID=207);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7002082 AND PermissionItemID=208);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7002092 AND PermissionItemID=209);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7002102 AND PermissionItemID=210);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7007002 AND PermissionItemID=700);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7007022 AND PermissionItemID=701);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7007042 AND PermissionItemID=702);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7007062 AND PermissionItemID=703);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7007082 AND PermissionItemID=704);
DELETE FROM permissionitemname WHERE  (PermissionItemNameID=7007122 AND PermissionItemID=707);

-- 07/06/2019 - Session Module - Not Print Payment Detail/ Shop Summary
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (105,15,'Not Print Payment/ Summary Detail', '0 = Print, 1 = Not Print',0,0,0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,15,1, 'Print Both', 0, 0, 1);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,15,2, 'Not Print Payment', 1, 1, 0);
INSERT INTO PropertyOption(PropertyTypeID, PropertyID, OptionID, OptionName, OptionValue, OptionOrdering, OptionDefault) VALUES (105,15,3, 'Not Print Payment and Shop Summary', 2, 2, 0);

-- 02/08/2019 - Session Module - Number Decimal Digit For Display Price In Session
INSERT INTO PropertyTextDesp(PropertyTypeID, PropertyPosition, PropertyName, Description, PropertyOption, FunctionGroupID, Deleted) VALUES (105,16,'Number Decimal Digit For Display Price (Rounding)', '',0,0,0);

-- 12/06/2019 - Add DocumentTemplateHideMaterial
CREATE TABLE DocumentTemplateHideMaterial (
 TemplateID int NOT NULL DEFAULT '0',
 TemplateShopID int NOT NULL DEFAULT '0',
 DocDetailID int NOT NULL DEFAULT '0',
 MaterialID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (TemplateID, TemplateShopID, DocDetailID, MaterialID)
) ENGINE=InnoDB;

-- 24/07/2019 
-- Add structure link pms comanche

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

-- 24/07/2019 - AR Account
ALTER TABLE PMSCMC_PaymentMapping ADD MST_ARNo varchar(10) NULL After AccountNoForAR;

Create TABLE PMSCMC_PaymentARAccountInfo(
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 PayDetailID int NOT NULL DEFAULT '0',
 ShopID int NOT NULL DEFAULT '0',
 SaleDate date NULL,
 PaymentAmount decimal(18,4) NOT NULL DEFAULT '0',
 PayTypeID int NOT NULL DEFAULT '0',
 CMC_Dept varchar(3) NULL,
 CMC_Refer varchar(20) NULL,
 CMC_Desc varchar(150) NULL,
 CMC_Gst varchar(150) NULL,
 CMC_NVAT decimal(18,4) NOT NULL DEFAULT '0',
 CMC_VAT decimal(18,4) NOT NULL DEFAULT '0',
 CMC_Amount decimal(18,4) NOT NULL DEFAULT '0',
 CMC_Rmk varchar(200) NULL,
 CMC_MST_ARNo varchar(10) NULL,
 CMC_PayType varchar(2) NULL,
 CMC_FolioSeq int NOT NULL DEFAULT '0',
 CMC_CRCardNo  varchar(30) NULL,
 AR_RowID int NOT NULL DEFAULT '0',
 AR_DocNo varchar(10) NULL,
 PRIMARY KEY(TransactionID, ComputerID, PayDetailID) 
) ENGINE=InnoDB;

-- INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Patch6205'));
-- INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Patch6207'));
-- 12/07/2019

UPDATE DocumentTypeProperty SET PrintFormFileName_Lang1= 'CRReceiveFromTransfer-EN.rpt', PrintFormFileName_Lang2 = 'CRReceiveFromTransfer-TH.rpt' WHERE DocumentTypeID = 25 AND PrintFormFileName_Lang1= 'CRReceiveTransferDocument-EN.rpt';

-- INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Patch6208')); -- 30/07/2019
-- 21/08/2019 - Export InvOnCloud Via API
ALTER TABLE ExportInvOnCloud_ConfigSetting ADD ExportUseAPI tinyint NOT NULL DEFAULT '0' After DefaultDocumentTypeMappingCode;
ALTER TABLE ExportInvOnCloud_ConfigSetting ADD APIURLAddress varchar(200) NULL After ExportUseAPI;
ALTER TABLE ExportInvOnCloud_ConfigSetting ADD APIUserName varchar(50) NULL After APIURLAddress;
ALTER TABLE ExportInvOnCloud_ConfigSetting ADD APIPassword varchar(20) NULL After APIUserName;

CREATE TABLE ExportInvOnCloud_APIType (
 APIType tinyint NOT NULL DEFAULT '0',
 Description varchar(30) NULL,
 CallAPIURL varchar(100) NULL,
 PRIMARY KEY  (APIType)
) ENGINE=InnoDB;

INSERT INTO ExportInvOnCloud_APIType(APIType, Description, CallAPIURL) VALUES(1, 'Log In', '/api/auth/login');
INSERT INTO ExportInvOnCloud_APIType(APIType, Description, CallAPIURL) VALUES(2, 'Export To POS Data', '/api/menu/pos-data-import');
INSERT INTO ExportInvOnCloud_APIType(APIType, Description, CallAPIURL) VALUES(3, 'Log Out', '/api/auth/logout');

-- 23/07/2019 Change MemberCode History
CREATE TABLE HistoryOfChangeMemberCode (
  HistoryID int NOT NULL Auto_Increment,
  ProductLevelID int NOT NULL DEFAULT '0',
  MemberID int NOT NULL DEFAULT '0',
  ChangeFromMemberCode varchar(50) NULL,
  ChangeToMemberCode varchar(50) NULL,
  ChangePrice decimal(18,4) NOT NULL DEFAULT '0',
  ChangeFromComputerID int NOT NULL DEFAULT '0',
  ChangeStaffID int NOT NULL DEFAULT '0',
  ChangeNote varchar(255) NULL,
  HistoryDateTime datetime NULL,
  PRIMARY KEY  (HistoryID, ProductLevelID)
) ENGINE=InnoDB;
ALTER TABLE HistoryOfChangeMemberCode ADD FrontFunctionID int NOT NULL DEFAULT '0' After ChangeNote;
ALTER TABLE HistoryOfChangeMemberCode ADD MemberExpireDate date NULL After ChangeToMemberCode;
ALTER TABLE HistoryOfChangeMemberCode CHANGE ChangeDateTime HistoryDateTime datetime NULL;
ALTER TABLE HistoryOfChangeMemberCode ADD ChangeProductLevelCode varchar(20) NULL After HistoryDateTime;
ALTER TABLE HistoryOfChangeMemberCode ADD ChangeProductLevelName varchar(100) NULL After HistoryDateTime;

ALTER TABLE HistoryOfChangeMemberCode ADD INDEX MemberIndex (MemberID, FrontFunctionID);

CREATE TABLE MemberFrontFeature (
 SettingID tinyint NOT NULL DEFAULT '0',
 AddNewOrActivatedMember tinyint NOT NULL DEFAULT '0',
 CancelActivateMember tinyint NOT NULL DEFAULT '0',
 ReNewMember tinyint NOT NULL DEFAULT '0',
 CanEditMember tinyint NOT NULL DEFAULT '1' ,
 AllowEditExpireDate tinyint NOT NULL DEFAULT '1' ,
 PRIMARY KEY  (SettingID)
) ENGINE=InnoDB;
INSERT INTO MemberFrontFeature(SettingID, AddNewOrActivatedMember, CancelActivateMember, ReNewMember, CanEditMember, AllowEditExpireDate) VALUES(1, 0, 0, 0, 1, 1);

ALTER TABLE MemberFrontFeature ADD RetrieveFromHQ_UDD tinyint NOT NULL DEFAULT '0';
ALTER TABLE MemberFrontFeature ADD RetrieveFromHQ_HistoryChangeMember tinyint NOT NULL DEFAULT '0';

CREATE TABLE MemberActivateRenewSetting (
 SettingID int NOT NULL DEFAULT '0',
 SettingFor tinyint NOT NULL DEFAULT '0',
 Description varchar(200) NULL,
 MemberExpireDateType tinyint NOT NULL DEFAULT '0', 
 NumberOfExpireDate int NOT NULL DEFAULT '0', 
 IsAtEndOfMonthYear tinyint NOT NULL DEFAULT '0',  
 IsDefaultSetting tinyint NOT NULL DEFAULT '0',  
 Deleted tinyint NOT NULL DEFAULT '0',
 UpdateStaffID int NOT NULL DEFAULT '0',
 UpdateDate datetime NULL,
 PRIMARY KEY  (SettingID)
) ENGINE=InnoDB;

CREATE TABLE MemberActivateSetting_MemberGroup (
 SettingID int NOT NULL DEFAULT '0',
 MemberGroupID int NOT NULL DEFAULT '0',
 PRIMARY KEY  (SettingID, MemberGroupID)
) ENGINE=InnoDB;

CREATE TABLE MemberActivateReNewSettingFor (
 SettingFor int NOT NULL DEFAULT '0',
 Description varchar(30) NULL,
 PRIMARY KEY  (SettingFor)
) ENGINE=InnoDB;
INSERT INTO MemberActivateReNewSettingFor(SettingFor, Description) VALUES(1, 'Add New');
INSERT INTO MemberActivateReNewSettingFor(SettingFor, Description) VALUES(2, 'Activate');
INSERT INTO MemberActivateReNewSettingFor(SettingFor, Description) VALUES(3, 'Renew/ Change');

CREATE TABLE MemberActivateRenewExpireDateType (
 ExpireType tinyint NOT NULL DEFAULT '0',
 Description varchar(30) NULL,
 PRIMARY KEY  (ExpireType)
) ENGINE=InnoDB;
INSERT INTO MemberActivateRenewExpireDateType VALUES(0, 'Manual Set Expire');
INSERT INTO MemberActivateRenewExpireDateType VALUES(1, 'Expire Day (Lock)');
INSERT INTO MemberActivateRenewExpireDateType VALUES(2, 'Expire Month (Lock)');
INSERT INTO MemberActivateRenewExpireDateType VALUES(3, 'Expire Year (Lock)');
INSERT INTO MemberActivateRenewExpireDateType VALUES(4, 'Expire Day (Can Edit)');
INSERT INTO MemberActivateRenewExpireDateType VALUES(5, 'Expire Month (Can Edit)');
INSERT INTO MemberActivateRenewExpireDateType VALUES(6, 'Expire Year (Can Edit)');

Insert INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionCode, Description, Description_TH) VALUES(49,'MEM_ACT','Activate member', 'เปิดใช้งานสมาชิก');
Insert INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionCode, Description, Description_TH) VALUES(50,'MEM_RENEW','Renew/ Change member', 'ต่ออายุสมาชิก/เปลี่ยนบัตร');
Insert INTO FrontFunctionDescription(FrontFunctionID, FrontFunctionCode, Description, Description_TH) VALUES(51,'MEM_CACT','Cancel activate member', 'ปิดการใช้งานสมาชิก');

ALTER TABLE Members ADD ActivateAtProductLevelID int NOT NULL DEFAULT '0' after InsertAtProductLevelName;

INSERT INTO permissionitem(PermissionItemID,PermissionGroupID,PermissionItemParam,PermissionItemUrl,PermissionItemOrder,PermissionItemIDParent,PermissionItemAssign,PermissionShopType,PermissionFeature,Deleted,Remark,SystemEdition,ProgramTypeID) 
VALUES(222,6,'Member_CancelActivate','',21,0,NULL,0,0,0,NULL,0,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,222,'Cancel Activate Member at Front',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,222,'ยกเลิกสถานะ Activate ของ Member ที่ Front',2);
Delete From StaffPermission Where PermissionItemID = 222 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,222);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,222);

INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (22010,5,'Member_SetFrontFeature','Preferences/MemberSetFrontFeature.aspx',2,0,null,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,22010,'Set Member Feature at Front',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,22010,'ตั้งค่าการทำงานของหน้าสมาชิก ที่ Front',2);
Delete From StaffPermission Where PermissionItemID = 22010 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,22010);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,22010);

-- 07/09/2019 - Member Promotion Package Setting
INSERT INTO permissionitem (PermissionItemID, PermissionGroupID, PermissionItemParam, PermissionItemUrl,PermissionItemOrder, PermissionItemIDParent,PermissionItemAssign,Deleted)
VALUES (22011,7,'Member_PromotionPackage_Setup','Promotions/PromotionPackageManagement.aspx',32,0,null,0);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(1,22011,'Promotion Set for Member Management',1);
INSERT INTO permissionitemname(PermissionItemNameID,PermissionItemID,PermissionItemName,LangID) VALUES(2,22011,'ระบบจัดชุดโปรโมชั่นของสมาชิก',2);
Delete From StaffPermission Where PermissionItemID = 22011 AND StaffRoleID IN (1,2);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(1,22011);
INSERT INTO staffpermission(StaffRoleID,PermissionItemID) VALUES(2,22011);

-- 12/09/2019 -- ReferenceNo For PayByVoucher = 100
ALTER TABLE PayByVoucher CHANGE ReferenceNo ReferenceNo varchar(100) NULL;
ALTER TABLE PayByVoucherFront CHANGE ReferenceNo ReferenceNo varchar(100) NULL;

-- 17/09/2019 -- OrderUpdateDiscountPrice For Calculate Promotion 
CREATE TABLE OrderUpdateDiscountPriceCalculateTemp (
 TransactionID int NOT NULL DEFAULT '0',
 ComputerID int NOT NULL DEFAULT '0',
 OrderDetailID int NOT NULL DEFAULT '0',
 FromComputerID int NOT NULL DEFAULT '0',
 DiscountType tinyint NOT NULL DEFAULT '0',
 DiscountPrice decimal(18,4) NOT NULL DEFAULT '0',
 CalculatePrice decimal(18,4) NOT NULL DEFAULT '0',
 DiscountPercent decimal(8,4) NOT NULL DEFAULT '0',
 DiscountAmount decimal(18,4) NOT NULL DEFAULT '0',
 DiscountAllow tinyint NOT NULL DEFAULT '0',
 PRIMARY KEY  (TransactionID, ComputerID, OrderDetailID, FromComputerID, DiscountType),
 INDEX OrderIndex(TransactionID, ComputerID, OrderDetailID)
) ENGINE=InnoDB;


INSERT INTO zz_historypatch(zz_historypatch) VALUES(CONCAT(Now(),' : Patch6209')); -- 30/09/2019
