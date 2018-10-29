CREATE DEFINER=`slava`@`%` PROCEDURE `moveFromPSToReceipts`(IN accountID INT(20),IN idFrom INT(20), IN receiptName VARCHAR(100), IN approve BOOLEAN)
BEGIN
	IF (approve) THEN
		INSERT INTO Receipts (UserID, Name, CreatedDate, IsForwarded, StoreName, Category) 
			SELECT UserID, Name, CreatedDate, 1, StoreName, Category FROM RequestedForwards WHERE UserID=accountID AND UserIDFrom=idFrom AND Name=receiptName;
	END IF;
    
	DELETE FROM RequestedForwards WHERE UserID=accountID AND UserIDFrom=idFrom AND Name=receiptName;
END