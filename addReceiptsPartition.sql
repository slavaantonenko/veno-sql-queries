CREATE DEFINER=`slava`@`%` PROCEDURE `addReceiptsPartition`(IN accountID INT(20))
BEGIN
	SET @nextPartitionName = ((accountID - 10000000) DIV 1000);
    
    IF NOT EXISTS ( SELECT  1 FROM information_schema.partitions 
								WHERE TABLE_SCHEMA='' AND TABLE_NAME = 'Receipts' AND PARTITION_NAME=@nextPartitionName ) THEN
		SET @command = concat('ALTER TABLE Receipts ADD PARTITION (PARTITION p', @nextPartitionName, ' VALUES LESS THAN (', accountID + 1000, '))');
		PREPARE stmt1 FROM @command; 
		EXECUTE stmt1; 
		DEALLOCATE PREPARE stmt1; 
    END IF;
END