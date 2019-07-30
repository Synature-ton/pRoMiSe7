-- 04/04/2017 : SetMaterialCostTableWhenApproveBatch
ALTER TABLE DocumentTypeTransferGroupProperty ADD SetMaterialCostTableWhenApproveBatch tinyint NOT NULL DEFAULT '0' After DisplayCurrentStockInMatrix;

-- 02/10/2017 - Vendor TaxID/ CompanyType
ALTER TABLE Vendors ADD VendorTaxID varchar(50) NULL After VendorAdditional;
ALTER TABLE Vendors ADD VendorCompanyType tinyint NOT NULL DEFAULT '0' After VendorTaxID;
ALTER TABLE Vendors ADD VendorCompanyBranchNo varchar(100) NULL After VendorCompanyType;
ALTER TABLE Vendors ADD FromOtherSystem tinyint NOT NULL DEFAULT '0' After VendorCompanyType;







