CREATE DEFINER=`slava`@`%` PROCEDURE `registerToken`(IN accountID INT(20), IN tokenFromApp VARCHAR(2100))
BEGIN
    INSERT INTO RegistrationTokens (ID, Token)
		VALUES (accountID, tokenFromApp);
END