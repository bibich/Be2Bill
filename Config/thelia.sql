
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- be2bill_config
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `be2bill_config`;

CREATE TABLE `be2bill_config`
(
    `name` VARCHAR(128) NOT NULL,
    `value` TEXT,
    PRIMARY KEY (`name`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- be2bill_transaction
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `be2bill_transaction`;

CREATE TABLE `be2bill_transaction`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `order_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `transaction_id` VARCHAR(255) NOT NULL,
    `method_name` VARCHAR(255) DEFAULT '',
    `operationtype` VARCHAR(255) NOT NULL,
    `dsecure` VARCHAR(255) NOT NULL,
    `execcode` VARCHAR(255) NOT NULL,
    `message` VARCHAR(255) NOT NULL,
    `amount` VARCHAR(255) NOT NULL,
    `clientemail` VARCHAR(255) NOT NULL,
    `cardcode` VARCHAR(255) NOT NULL,
    `cardvaliditydate` VARCHAR(255) NOT NULL,
    `cardfullname` VARCHAR(255) NOT NULL,
    `cardtype` VARCHAR(255) NOT NULL,
    `transaction` TEXT,
    `refunded` TINYINT(1) DEFAULT 0 NOT NULL,
    `refundedby` VARCHAR(255),
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`),
    INDEX `idx_be2bill_transaction_order_id` (`order_id`),
    INDEX `FI_be2bill_transaction_customer_id` (`customer_id`),
    CONSTRAINT `fk_be2bill_transaction_order_id`
        FOREIGN KEY (`order_id`)
        REFERENCES `order` (`id`)
        ON UPDATE RESTRICT
        ON DELETE CASCADE,
    CONSTRAINT `fk_be2bill_transaction_customer_id`
        FOREIGN KEY (`customer_id`)
        REFERENCES `customer` (`id`)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- be2bill_method
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `be2bill_method`;

CREATE TABLE `be2bill_method`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `order_id` INTEGER NOT NULL,
    `method` VARCHAR(255) NOT NULL,
    `data` TEXT,
    PRIMARY KEY (`id`),
    INDEX `FI_be2bill_method_order_id` (`order_id`),
    CONSTRAINT `fk_be2bill_method_order_id`
        FOREIGN KEY (`order_id`)
        REFERENCES `order` (`id`)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
) ENGINE=InnoDB;

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
