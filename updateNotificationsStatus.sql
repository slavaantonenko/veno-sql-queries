-- DEPRECATED --
CREATE DEFINER=`slava`@`%` PROCEDURE `updateNotificationsStatus`(IN accountID INT(20), IN notificationsStatus BOOLEAN)
BEGIN
	UPDATE AccountInfo SET Notifications=notificationsStatus WHERE ID=accountID;
END