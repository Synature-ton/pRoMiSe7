-- 25/10/2016 Export To Text File Sale Data For KingPower/ ProductCategoryCode For KingPower
-- 75 = Property Feature, 76 = Category Code (4 Char), VoucherDetail --> Add PromoCode For Promotion Code To KingPower For Using Promotion
INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) values (1,75,2,'Export Text File For KingPower','1 = Show Export Form and Export Sale To Text File For KingPower');
INSERT INTO ProgramPropertyValue(ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue) VALUES (1, 75, 1, 0,'');

INSERT INTO ProgramProperty (ProgramTypeID,PropertyID,KeyTypeID,PropertyName,Description) values (1,76,2,'Product Category Code For KingPower','Use Text Value For ProductCategory for KingPower');
INSERT INTO ProgramPropertyValue(ProgramTypeID, PropertyID, KeyID, PropertyValue, PropertyTextValue) VALUES (1, 76, 1, 0,'');

ALTER TABLE VoucherDetail ADD PromoCode varchar(50) NULL;
