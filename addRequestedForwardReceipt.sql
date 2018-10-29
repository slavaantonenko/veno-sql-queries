CREATE DEFINER=`slava`@`%` PROCEDURE `addRequestedForwardReceipt`(IN idFrom INT(20), IN receiptName VARCHAR(100), IN phoneNumberTo VARCHAR(20), 
																															OUT requestAlreadyExist BOOLEAN, OUT firstNameFrom VARCHAR(50), OUT lastNameFrom VARCHAR(50))
BEGIN
    SET @targetAccountID = (SELECT ID FROM Accounts WHERE PhoneNumber=phoneNumberTo);
	SET firstNameFrom = (SELECT FirstName FROM AccountInfo WHERE ID=idFrom);
    SET lastNameFrom = (SELECT LastName FROM AccountInfo WHERE ID=idFrom);
    SET @check1 = (SELECT 1 FROM RequestedForwards WHERE UserID=@targetAccountID AND Name=receiptName);
    SET @check2 = (SELECT 1 FROM Receipts WHERE UserID=@targetAccountID AND Name=receiptName AND IsForwarded=true);

	IF (@check1 IS NULL AND @check2 IS NULL) THEN
		INSERT INTO RequestedForwards (UserIDFrom, Name, FirstNameFrom, LastNameFrom, CreatedDate, StoreName, Category)
		SELECT UserID, Name, firstNameFrom, lastNameFrom, CreatedDate, StoreName, Category FROM Receipts WHERE UserID=idFrom AND Name=receiptName;
		
		UPDATE RequestedForwards
		SET UserID = @targetAccountID;
        
        SET requestAlreadyExist = FALSE;
	ELSE
		SET requestAlreadyExist = TRUE;
    END IF;
    SELECT requestAlreadyExist, firstNameFrom, lastNameFrom;
END