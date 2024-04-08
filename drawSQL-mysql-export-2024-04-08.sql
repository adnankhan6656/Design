CREATE TABLE `auction`(
    `auction_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `seller_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `winningBidId` INT NOT NULL,
    `startingPrice` DOUBLE(8, 2) NOT NULL,
    `startingTime` DATETIME NOT NULL,
    `endingTime` DATETIME NOT NULL,
    `bidPriceInterval` INT NOT NULL,
    `status` VARCHAR(255) NOT NULL
);
CREATE TABLE `products`(
    `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `prductName` VARCHAR(255) NOT NULL,
    `Description` VARCHAR(255) NOT NULL,
    `condition` VARCHAR(255) NOT NULL
);
CREATE TABLE `productImages`(
    `productImageId` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `productId` INT NOT NULL,
    `image_url` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `modified_at` TIMESTAMP NOT NULL
);
CREATE TABLE `orders`(
    `orderId` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `auctionId` INT NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL
);
CREATE TABLE `bids`(
    `bidId` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `auctionId` INT NOT NULL,
    `buyerId` INT NOT NULL,
    `bidAmount` INT NOT NULL,
    `created_at` TIMESTAMP NOT NULL
);
CREATE TABLE `parameter`(
    `parameterId` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` INT NOT NULL,
    `parameterName` VARCHAR(255) NOT NULL,
    `parameterValue` VARCHAR(255) NOT NULL
);
CREATE TABLE `users`(
    `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `firstName` VARCHAR(255) NOT NULL,
    `lastName` VARCHAR(255) NOT NULL,
    `role` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `activationStatus` TINYINT NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `profilePic` BLOB NOT NULL,
    `salt` VARCHAR(255) NOT NULL,
    `activation_code` VARCHAR(255) NOT NULL,
    `activation_expires` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `modified_at` TIMESTAMP NOT NULL
);
ALTER TABLE
    `bids` ADD CONSTRAINT `bids_buyerid_foreign` FOREIGN KEY(`buyerId`) REFERENCES `users`(`user_id`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_auctionid_foreign` FOREIGN KEY(`auctionId`) REFERENCES `auction`(`auction_id`);
ALTER TABLE
    `auction` ADD CONSTRAINT `auction_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`product_id`);
ALTER TABLE
    `products` ADD CONSTRAINT `products_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `parameter`(`parameterId`);
ALTER TABLE
    `productImages` ADD CONSTRAINT `productimages_productid_foreign` FOREIGN KEY(`productId`) REFERENCES `products`(`product_id`);
ALTER TABLE
    `bids` ADD CONSTRAINT `bids_auctionid_foreign` FOREIGN KEY(`auctionId`) REFERENCES `auction`(`auction_id`);
ALTER TABLE
    `auction` ADD CONSTRAINT `auction_winningbidid_foreign` FOREIGN KEY(`winningBidId`) REFERENCES `bids`(`bidId`);
ALTER TABLE
    `auction` ADD CONSTRAINT `auction_seller_id_foreign` FOREIGN KEY(`seller_id`) REFERENCES `users`(`user_id`);