CREATE DEFINER=`slava`@`%` PROCEDURE `changeNumber`(IN newNumber VARCHAR(20), IN idFromApp INT(20))
BEGIN
	UPDATE Accounts SET PhoneNumber=newNumber WHERE ID=idFromApp;
END