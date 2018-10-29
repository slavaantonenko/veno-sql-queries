CREATE DEFINER=`slava`@`%` PROCEDURE `insertReceipts`(IN customerPhoneNumber VARCHAR(20), IN createdDate VARCHAR(50), IN formatedCreatedDate VARCHAR(50), IN store VARCHAR(50))
BEGIN
	SET @accountID = (SELECT ID FROM Accounts WHERE PhoneNumber=customerPhoneNumber);
    SET @category = (SELECT Category FROM Stores WHERE Name=store);
    SET @receiptName = CONCAT(store, '-', formatedCreatedDate, '.pdf');
	
	Insert into Receipts (UserID, Name, CreatedDate, StoreName, Category) values (@accountID, @receiptName, STR_TO_DATE(createdDate, '%d-%m-%Y %H:%i:%s'), store, @category);
    
    SELECT @accountID;
END