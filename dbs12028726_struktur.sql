-- Adminer 4.8.1 MySQL 5.5.5-10.6.15-MariaDB-1:10.6.15+maria~deb11-log dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `additional_fields`;
CREATE TABLE `additional_fields` (
  `additional_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `field_key` varchar(255) NOT NULL DEFAULT '',
  `item_type` enum('product') NOT NULL DEFAULT 'product',
  `multilingual` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`additional_field_id`),
  UNIQUE KEY `field_key` (`field_key`,`item_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `additional_fields_filter`;
CREATE TABLE `additional_fields_filter` (
  `additional_field_id` int(11) NOT NULL,
  `additional_fields_display_type` varchar(64) NOT NULL,
  KEY `additional_field_id` (`additional_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `additional_field_descriptions`;
CREATE TABLE `additional_field_descriptions` (
  `additional_field_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `name` text NOT NULL,
  PRIMARY KEY (`additional_field_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `additional_field_values`;
CREATE TABLE `additional_field_values` (
  `additional_field_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `additional_field_id` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`additional_field_value_id`),
  UNIQUE KEY `additional_field_id` (`additional_field_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `additional_field_value_descriptions`;
CREATE TABLE `additional_field_value_descriptions` (
  `additional_field_value_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `value` text NOT NULL,
  PRIMARY KEY (`additional_field_value_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `addon_values_storage`;
CREATE TABLE `addon_values_storage` (
  `addon_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `container_type` varchar(64) DEFAULT NULL,
  `container_id` int(11) DEFAULT NULL,
  `addon_key` varchar(255) DEFAULT NULL,
  `addon_value` text DEFAULT NULL,
  PRIMARY KEY (`addon_value_id`),
  UNIQUE KEY `container_type_container_id_addon_key` (`container_type`,`container_id`,`addon_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
  `address_book_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `entry_gender` char(1) NOT NULL DEFAULT '',
  `entry_company` varchar(255) NOT NULL DEFAULT '',
  `entry_firstname` varchar(32) NOT NULL DEFAULT '',
  `entry_lastname` varchar(32) NOT NULL DEFAULT '',
  `entry_street_address` varchar(64) NOT NULL DEFAULT '',
  `entry_house_number` varchar(64) NOT NULL DEFAULT '',
  `entry_additional_info` varchar(100) NOT NULL DEFAULT '',
  `entry_suburb` varchar(32) DEFAULT NULL,
  `entry_postcode` varchar(10) NOT NULL DEFAULT '',
  `entry_city` varchar(32) NOT NULL DEFAULT '',
  `entry_state` varchar(32) DEFAULT NULL,
  `entry_country_id` int(11) NOT NULL DEFAULT 0,
  `entry_zone_id` int(11) NOT NULL DEFAULT 0,
  `address_date_added` datetime DEFAULT '1000-01-01 00:00:00',
  `address_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `address_class` varchar(32) NOT NULL DEFAULT '',
  `amparex_id` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`address_book_id`),
  KEY `idx_address_book_customers_id` (`customers_id`),
  KEY `entry_country_id` (`entry_country_id`),
  KEY `entry_zone_id` (`entry_zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `address_format`;
CREATE TABLE `address_format` (
  `address_format_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_format` varchar(128) NOT NULL DEFAULT '',
  `address_summary` varchar(48) NOT NULL DEFAULT '',
  PRIMARY KEY (`address_format_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `admin_access_groups`;
CREATE TABLE `admin_access_groups` (
  `admin_access_group_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT 0,
  `sort_order` int(3) NOT NULL DEFAULT 0,
  `protected` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`admin_access_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `admin_access_group_descriptions`;
CREATE TABLE `admin_access_group_descriptions` (
  `admin_access_group_id` int(11) unsigned NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`admin_access_group_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `admin_access_group_items`;
CREATE TABLE `admin_access_group_items` (
  `admin_access_group_id` int(11) unsigned NOT NULL DEFAULT 0,
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `type` enum('CONTROLLER','PAGE','AJAX_HANDLER','ROUTE') NOT NULL DEFAULT 'CONTROLLER',
  PRIMARY KEY (`identifier`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `admin_access_permissions`;
CREATE TABLE `admin_access_permissions` (
  `admin_access_role_id` int(11) unsigned NOT NULL,
  `admin_access_group_id` int(11) unsigned NOT NULL,
  `reading_granted` smallint(5) unsigned NOT NULL DEFAULT 0,
  `writing_granted` smallint(5) unsigned NOT NULL DEFAULT 0,
  `deleting_granted` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`admin_access_group_id`,`admin_access_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `admin_access_roles`;
CREATE TABLE `admin_access_roles` (
  `admin_access_role_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sort_order` int(11) unsigned NOT NULL DEFAULT 0,
  `deleting_unknown_group_granted` smallint(5) unsigned NOT NULL DEFAULT 1,
  `reading_unknown_group_granted` smallint(5) unsigned NOT NULL DEFAULT 1,
  `writing_unknown_group_granted` smallint(5) unsigned NOT NULL DEFAULT 1,
  `protected` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`admin_access_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `admin_access_role_descriptions`;
CREATE TABLE `admin_access_role_descriptions` (
  `admin_access_role_id` int(11) unsigned NOT NULL DEFAULT 1,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`admin_access_role_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `admin_access_users`;
CREATE TABLE `admin_access_users` (
  `customer_id` int(11) NOT NULL DEFAULT 0,
  `admin_access_role_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`admin_access_role_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `afterbuy_catalogs`;
CREATE TABLE `afterbuy_catalogs` (
  `catalog_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `position` int(11) NOT NULL DEFAULT 0,
  `additionaltext` varchar(255) NOT NULL,
  `show_catalog` tinyint(1) NOT NULL DEFAULT 0,
  `picture1` varchar(255) NOT NULL,
  `picture2` varchar(255) NOT NULL,
  `titlepicture` varchar(255) NOT NULL,
  PRIMARY KEY (`catalog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `afterbuy_catalogs_to_categories`;
CREATE TABLE `afterbuy_catalogs_to_categories` (
  `catalog_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`catalog_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `afterbuy_orders`;
CREATE TABLE `afterbuy_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `afterbuy_order_id` int(11) NOT NULL,
  `state` enum('unprocessed','transmitted','paid') DEFAULT 'unprocessed',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_mapping` (`order_id`,`afterbuy_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `afterbuy_products`;
CREATE TABLE `afterbuy_products` (
  `products_id` int(11) NOT NULL,
  `combi_id` int(11) DEFAULT NULL,
  `afterbuy_product_id` int(11) NOT NULL,
  `data_origin` varchar(10) NOT NULL DEFAULT '',
  UNIQUE KEY `afterbuy_product_id` (`afterbuy_product_id`),
  UNIQUE KEY `products_id_2` (`products_id`,`combi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `afterbuy_products_to_catalogs`;
CREATE TABLE `afterbuy_products_to_catalogs` (
  `catalog_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  KEY `catalog_id` (`catalog_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `agreements`;
CREATE TABLE `agreements` (
  `agreements_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_name` varchar(128) NOT NULL DEFAULT '',
  `customers_email` varchar(128) NOT NULL DEFAULT '',
  `language_id` int(11) NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '',
  `text` text NOT NULL,
  `legal_text_version` varchar(255) NOT NULL DEFAULT '',
  `content_group` int(11) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`agreements_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `alkim_media_text`;
CREATE TABLE `alkim_media_text` (
  `alkim_media_text_id` int(11) NOT NULL AUTO_INCREMENT,
  `alkim_media_text_name` varchar(64) NOT NULL,
  `language_id` tinyint(2) NOT NULL,
  `alkim_media_text_value` text NOT NULL,
  `alkim_media_text_group` varchar(64) NOT NULL,
  PRIMARY KEY (`alkim_media_text_id`),
  UNIQUE KEY `alkim_media_text_name` (`alkim_media_text_name`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `alkim_module_configuration`;
CREATE TABLE `alkim_module_configuration` (
  `amc_id` int(11) NOT NULL AUTO_INCREMENT,
  `amc_key` varchar(50) NOT NULL,
  `amc_value` text NOT NULL,
  `amc_language` int(11) NOT NULL,
  PRIMARY KEY (`amc_id`),
  UNIQUE KEY `amc_key_language` (`amc_key`,`amc_language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `amazon_pay_transactions`;
CREATE TABLE `amazon_pay_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `merchant_id` varchar(32) DEFAULT NULL,
  `mode` varchar(16) DEFAULT NULL,
  `type` varchar(16) NOT NULL,
  `time` datetime NOT NULL,
  `expiration` datetime NOT NULL,
  `amount` float NOT NULL,
  `charge_amount` float NOT NULL,
  `captured_amount` float NOT NULL,
  `refunded_amount` float NOT NULL,
  `currency` varchar(16) DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `last_change` datetime NOT NULL,
  `last_update` datetime NOT NULL,
  `order_id` int(11) NOT NULL,
  `customer_informed` tinyint(1) NOT NULL,
  `admin_informed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `reference` (`reference`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `amzadvpay_authorizations`;
CREATE TABLE `amzadvpay_authorizations` (
  `amzadvpay_authorizations_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `order_reference_id` varchar(64) NOT NULL DEFAULT '',
  `authorization_reference_id` varchar(64) NOT NULL DEFAULT '',
  `state` varchar(20) NOT NULL DEFAULT '',
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_details` mediumtext NOT NULL,
  PRIMARY KEY (`amzadvpay_authorizations_id`),
  UNIQUE KEY `authorization_reference_id` (`authorization_reference_id`),
  KEY `orders_id` (`orders_id`),
  KEY `order_reference_id` (`order_reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `amzadvpay_captures`;
CREATE TABLE `amzadvpay_captures` (
  `amzadvpay_captures_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `order_reference_id` varchar(64) NOT NULL DEFAULT '',
  `authorization_reference_id` varchar(64) NOT NULL DEFAULT '',
  `capture_reference_id` varchar(64) NOT NULL DEFAULT '',
  `state` varchar(20) NOT NULL DEFAULT '',
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_details` mediumtext NOT NULL,
  PRIMARY KEY (`amzadvpay_captures_id`),
  KEY `orders_id` (`orders_id`,`order_reference_id`,`authorization_reference_id`,`capture_reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `amzadvpay_orders`;
CREATE TABLE `amzadvpay_orders` (
  `amzadvpay_orders_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `order_reference_id` varchar(64) NOT NULL DEFAULT '',
  `state` varchar(20) NOT NULL DEFAULT '',
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_details` mediumtext NOT NULL,
  PRIMARY KEY (`amzadvpay_orders_id`),
  UNIQUE KEY `orders_id_2` (`orders_id`),
  KEY `orders_id` (`orders_id`,`order_reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `amzadvpay_refunds`;
CREATE TABLE `amzadvpay_refunds` (
  `amzadvpay_refunds_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `order_reference_id` varchar(64) NOT NULL DEFAULT '',
  `authorization_reference_id` varchar(64) NOT NULL DEFAULT '',
  `capture_reference_id` varchar(64) NOT NULL DEFAULT '',
  `refund_reference_id` varchar(64) NOT NULL DEFAULT '',
  `state` varchar(20) NOT NULL DEFAULT '',
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_details` mediumtext DEFAULT NULL,
  PRIMARY KEY (`amzadvpay_refunds_id`),
  UNIQUE KEY `refund_reference_id` (`refund_reference_id`),
  KEY `orders_id` (`orders_id`),
  KEY `authorization_reference_id` (`authorization_reference_id`),
  KEY `capture_reference_id` (`capture_reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `am_config`;
CREATE TABLE `am_config` (
  `am_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `am_type` varchar(10) NOT NULL,
  `am_class` varchar(2) NOT NULL,
  `am_title` varchar(30) NOT NULL,
  `am_db_field` varchar(50) NOT NULL,
  PRIMARY KEY (`am_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `api_tokens`;
CREATE TABLE `api_tokens` (
  `api_tokens_id` int(11) NOT NULL AUTO_INCREMENT,
  `iss` varchar(255) NOT NULL,
  `exp` int(11) NOT NULL,
  `iat` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `token` varchar(1000) NOT NULL,
  PRIMARY KEY (`api_tokens_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `attr_profile`;
CREATE TABLE `attr_profile` (
  `attr_profile_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  `options_id` int(11) NOT NULL,
  `options_values_id` int(11) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `attributes_model` varchar(64) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  `attributes_stock` int(4) DEFAULT NULL,
  `options_values_weight` decimal(15,4) NOT NULL,
  `weight_prefix` char(1) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `sortorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`attr_profile_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `banktransfer`;
CREATE TABLE `banktransfer` (
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `banktransfer_owner` varchar(64) DEFAULT NULL,
  `banktransfer_number` varchar(24) DEFAULT NULL,
  `banktransfer_bankname` varchar(255) DEFAULT NULL,
  `banktransfer_blz` varchar(8) DEFAULT NULL,
  `banktransfer_status` int(11) DEFAULT NULL,
  `banktransfer_prz` char(2) DEFAULT NULL,
  `banktransfer_fax` char(2) DEFAULT NULL,
  KEY `orders_id` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `banktransfer_blz`;
CREATE TABLE `banktransfer_blz` (
  `blz` int(10) NOT NULL DEFAULT 0,
  `bankname` varchar(255) NOT NULL DEFAULT '',
  `bic` varchar(11) NOT NULL DEFAULT '',
  `prz` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`blz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `banners_id` int(11) NOT NULL AUTO_INCREMENT,
  `banners_title` varchar(64) NOT NULL DEFAULT '',
  `banners_url` varchar(255) NOT NULL DEFAULT '',
  `banners_image` varchar(255) NOT NULL DEFAULT '',
  `banners_group` varchar(10) NOT NULL DEFAULT '',
  `banners_html_text` text DEFAULT NULL,
  `expires_impressions` int(7) DEFAULT 0,
  `expires_date` datetime DEFAULT NULL,
  `date_scheduled` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`banners_id`),
  KEY `status` (`status`,`banners_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `banners_history`;
CREATE TABLE `banners_history` (
  `banners_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `banners_id` int(11) NOT NULL DEFAULT 0,
  `banners_shown` int(5) NOT NULL DEFAULT 0,
  `banners_clicked` int(5) NOT NULL DEFAULT 0,
  `banners_history_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`banners_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `campaigns`;
CREATE TABLE `campaigns` (
  `campaigns_id` int(11) NOT NULL AUTO_INCREMENT,
  `campaigns_name` varchar(32) NOT NULL DEFAULT '',
  `campaigns_refID` varchar(64) DEFAULT NULL,
  `campaigns_leads` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`campaigns_id`),
  KEY `IDX_CAMPAIGNS_NAME` (`campaigns_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `campaigns_ip`;
CREATE TABLE `campaigns_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_ip` varchar(15) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `campaign` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `campaign` (`campaign`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `card_blacklist`;
CREATE TABLE `card_blacklist` (
  `blacklist_id` int(5) NOT NULL AUTO_INCREMENT,
  `blacklist_card_number` varchar(20) NOT NULL DEFAULT '',
  `date_added` datetime DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  KEY `blacklist_id` (`blacklist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `categories_id` int(11) NOT NULL AUTO_INCREMENT,
  `categories_image` varchar(255) DEFAULT NULL,
  `categories_ogimage` varchar(255) DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `categories_status` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `categories_template` varchar(64) DEFAULT NULL,
  `group_permission_0` tinyint(1) NOT NULL DEFAULT 0,
  `group_permission_1` tinyint(1) NOT NULL DEFAULT 0,
  `group_permission_2` tinyint(1) NOT NULL DEFAULT 0,
  `group_permission_3` tinyint(1) NOT NULL DEFAULT 0,
  `listing_template` varchar(64) DEFAULT NULL,
  `sort_order` int(3) NOT NULL DEFAULT 0,
  `products_sorting` varchar(32) DEFAULT NULL,
  `products_sorting2` varchar(32) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `categories_icon` varchar(255) NOT NULL DEFAULT '',
  `categories_icon_w` int(11) NOT NULL DEFAULT 0,
  `categories_icon_h` int(11) NOT NULL DEFAULT 0,
  `group_ids` varchar(50) NOT NULL DEFAULT '',
  `gm_show_attributes` int(1) unsigned NOT NULL DEFAULT 0,
  `gm_show_graduated_prices` int(1) unsigned NOT NULL DEFAULT 0,
  `gm_show_qty` int(1) unsigned NOT NULL DEFAULT 1,
  `gm_priority` varchar(3) NOT NULL DEFAULT '0.5',
  `gm_changefreq` varchar(255) NOT NULL DEFAULT 'weekly',
  `gm_sitemap_entry` int(1) NOT NULL DEFAULT 1,
  `gm_show_qty_info` int(1) unsigned NOT NULL DEFAULT 0,
  `show_sub_categories` tinyint(1) NOT NULL DEFAULT 1,
  `show_sub_categories_images` tinyint(1) NOT NULL DEFAULT 1,
  `show_sub_categories_names` tinyint(1) NOT NULL DEFAULT 1,
  `show_categories_image_in_description` int(1) NOT NULL DEFAULT 1,
  `show_sub_products` tinyint(1) NOT NULL DEFAULT 0,
  `view_mode_tiled` tinyint(1) NOT NULL DEFAULT 0,
  `feature_mode` int(11) NOT NULL DEFAULT 0,
  `feature_display_mode` int(11) NOT NULL DEFAULT 0,
  `show_category_filter` tinyint(1) NOT NULL DEFAULT 0,
  `hide_filter` tinyint(1) NOT NULL,
  `no_filter` tinyint(1) NOT NULL,
  `filter_subcats` tinyint(1) NOT NULL,
  `no_filter_as_subcat` tinyint(1) NOT NULL,
  PRIMARY KEY (`categories_id`),
  KEY `idx_categories_parent_id` (`parent_id`),
  KEY `categories_id` (`categories_id`,`parent_id`,`categories_status`,`sort_order`),
  KEY `parent_id` (`parent_id`,`categories_status`,`sort_order`),
  KEY `categories_status` (`categories_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `categories_description`;
CREATE TABLE `categories_description` (
  `categories_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `categories_name` varchar(255) NOT NULL DEFAULT '',
  `categories_heading_title` varchar(255) NOT NULL DEFAULT '',
  `categories_description` text NOT NULL,
  `categories_description_bottom` text NOT NULL,
  `categories_meta_title` text NOT NULL,
  `categories_meta_description` text NOT NULL,
  `categories_meta_keywords` text NOT NULL,
  `gm_alt_text` varchar(255) NOT NULL DEFAULT '',
  `gm_url_keywords` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  PRIMARY KEY (`categories_id`,`language_id`),
  KEY `idx_categories_name` (`categories_name`),
  KEY `seo_boost_index` (`gm_url_keywords`,`categories_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `categories_filter`;
CREATE TABLE `categories_filter` (
  `categories_id` int(11) NOT NULL DEFAULT 0,
  `feature_id` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) DEFAULT NULL,
  `selection_preview_mode` varchar(45) DEFAULT NULL,
  `selection_template` varchar(45) DEFAULT NULL,
  `value_conjunction` int(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`categories_id`,`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `categories_index`;
CREATE TABLE `categories_index` (
  `products_id` int(11) NOT NULL DEFAULT 0,
  `categories_index` text NOT NULL,
  PRIMARY KEY (`products_id`),
  FULLTEXT KEY `categories_index` (`categories_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `cm_file_flags`;
CREATE TABLE `cm_file_flags` (
  `file_flag` int(11) NOT NULL DEFAULT 0,
  `file_flag_name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`file_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `configuration_group`;
CREATE TABLE `configuration_group` (
  `configuration_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `configuration_group_title` varchar(64) NOT NULL DEFAULT '',
  `configuration_group_description` varchar(255) NOT NULL DEFAULT '',
  `sort_order` int(5) DEFAULT NULL,
  `visible` int(1) DEFAULT 1,
  PRIMARY KEY (`configuration_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `content_manager`;
CREATE TABLE `content_manager` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `categories_id` int(11) NOT NULL DEFAULT 0,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `group_ids` text DEFAULT NULL,
  `languages_id` int(11) NOT NULL DEFAULT 0,
  `content_version` varchar(255) NOT NULL DEFAULT '',
  `content_name` text NOT NULL,
  `content_title` text NOT NULL,
  `content_heading` text NOT NULL,
  `content_text` mediumtext NOT NULL,
  `sort_order` int(4) NOT NULL DEFAULT 0,
  `file_flag` int(1) NOT NULL DEFAULT 0,
  `content_file` varchar(64) NOT NULL DEFAULT '',
  `download_file` varchar(64) NOT NULL DEFAULT '',
  `content_status` int(1) NOT NULL DEFAULT 0,
  `content_group` int(11) NOT NULL DEFAULT 0,
  `content_delete` int(1) NOT NULL DEFAULT 1,
  `gm_link` text NOT NULL,
  `gm_link_target` varchar(10) NOT NULL DEFAULT '',
  `gm_priority` varchar(3) NOT NULL DEFAULT '0.5',
  `gm_changefreq` varchar(255) NOT NULL DEFAULT 'weekly',
  `gm_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `gm_sitemap_entry` int(1) NOT NULL DEFAULT 1,
  `gm_robots_entry` int(1) NOT NULL DEFAULT 0,
  `gm_url_keywords` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `contents_meta_title` text NOT NULL,
  `contents_meta_description` text NOT NULL,
  `contents_meta_keywords` text NOT NULL,
  `opengraph_image` varchar(255) DEFAULT NULL,
  `content_position` varchar(64) NOT NULL,
  `content_type` varchar(64) NOT NULL,
  `protected` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`),
  KEY `languages_id` (`languages_id`,`file_flag`,`content_status`,`sort_order`),
  KEY `content_id` (`content_id`,`languages_id`),
  KEY `content_group` (`content_group`,`languages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `content_manager_aliases`;
CREATE TABLE `content_manager_aliases` (
  `content_group` int(16) NOT NULL,
  `content_alias` varchar(255) NOT NULL,
  PRIMARY KEY (`content_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `content_manager_history`;
CREATE TABLE `content_manager_history` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `categories_id` int(11) NOT NULL DEFAULT 0,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `group_ids` text DEFAULT NULL,
  `languages_id` int(11) NOT NULL DEFAULT 0,
  `content_version` varchar(255) NOT NULL DEFAULT '',
  `content_name` text NOT NULL,
  `content_title` text NOT NULL,
  `content_heading` text NOT NULL,
  `content_text` mediumtext NOT NULL,
  `sort_order` int(4) NOT NULL DEFAULT 0,
  `file_flag` int(1) NOT NULL DEFAULT 0,
  `content_file` varchar(64) NOT NULL DEFAULT '',
  `download_file` varchar(64) NOT NULL DEFAULT '',
  `content_status` int(1) NOT NULL DEFAULT 0,
  `content_group` int(11) NOT NULL DEFAULT 0,
  `content_delete` int(1) NOT NULL DEFAULT 1,
  `gm_link` text NOT NULL,
  `gm_link_target` varchar(10) NOT NULL DEFAULT '',
  `gm_priority` varchar(3) NOT NULL DEFAULT '0.5',
  `gm_changefreq` varchar(255) NOT NULL DEFAULT 'weekly',
  `gm_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `gm_sitemap_entry` int(1) NOT NULL DEFAULT 1,
  `gm_robots_entry` int(1) NOT NULL DEFAULT 0,
  `gm_url_keywords` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `contents_meta_title` text NOT NULL,
  `contents_meta_description` text NOT NULL,
  `contents_meta_keywords` text NOT NULL,
  `opengraph_image` varchar(255) DEFAULT NULL,
  `content_position` varchar(64) NOT NULL,
  `content_type` varchar(64) NOT NULL,
  `protected` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`),
  UNIQUE KEY `content_group` (`content_group`,`languages_id`,`content_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `cookie_consent_panel_purposes`;
CREATE TABLE `cookie_consent_panel_purposes` (
  `purpose_id` int(8) NOT NULL AUTO_INCREMENT,
  `language_id` int(8) NOT NULL,
  `category_id` int(8) NOT NULL,
  `purpose_description` text NOT NULL,
  `purpose_name` varchar(128) NOT NULL,
  `purpose_alias` varchar(128) DEFAULT NULL,
  `purpose_status` tinyint(1) NOT NULL DEFAULT 1,
  `purpose_deletable` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`purpose_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `counter`;
CREATE TABLE `counter` (
  `startdate` char(8) DEFAULT NULL,
  `counter` int(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `counter_history`;
CREATE TABLE `counter_history` (
  `month` char(8) DEFAULT NULL,
  `counter` int(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `countries_id` int(11) NOT NULL AUTO_INCREMENT,
  `countries_name` varchar(64) NOT NULL DEFAULT '',
  `countries_iso_code_2` char(2) NOT NULL DEFAULT '',
  `countries_iso_code_3` char(3) NOT NULL DEFAULT '',
  `address_format_id` int(11) NOT NULL DEFAULT 0,
  `status` int(1) DEFAULT 1,
  `is_state_mandatory` int(1) DEFAULT 0,
  PRIMARY KEY (`countries_id`),
  UNIQUE KEY `countries_iso_code_2` (`countries_iso_code_2`),
  UNIQUE KEY `countries_iso_code_3` (`countries_iso_code_3`),
  KEY `IDX_COUNTRIES_NAME` (`countries_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons` (
  `coupon_id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_type` char(1) NOT NULL DEFAULT 'F',
  `coupon_code` varchar(32) NOT NULL DEFAULT '',
  `coupon_amount` decimal(8,4) NOT NULL DEFAULT 0.0000,
  `coupon_minimum_order` decimal(8,4) NOT NULL DEFAULT 0.0000,
  `coupon_start_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `coupon_expire_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `uses_per_coupon` int(5) NOT NULL DEFAULT 1,
  `uses_per_user` int(5) NOT NULL DEFAULT 0,
  `restrict_to_products` text DEFAULT NULL,
  `restrict_to_categories` text DEFAULT NULL,
  `restrict_to_customers` text DEFAULT NULL,
  `coupon_active` char(1) NOT NULL DEFAULT 'Y',
  `date_created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `coupons_description`;
CREATE TABLE `coupons_description` (
  `coupon_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `coupon_name` varchar(32) NOT NULL DEFAULT '',
  `coupon_description` text DEFAULT NULL,
  PRIMARY KEY (`coupon_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `coupon_email_track`;
CREATE TABLE `coupon_email_track` (
  `unique_id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL DEFAULT 0,
  `customer_id_sent` int(11) NOT NULL DEFAULT 0,
  `sent_firstname` varchar(32) DEFAULT NULL,
  `sent_lastname` varchar(32) DEFAULT NULL,
  `emailed_to` varchar(32) DEFAULT NULL,
  `date_sent` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `coupon_gv_customer`;
CREATE TABLE `coupon_gv_customer` (
  `customer_id` int(5) NOT NULL DEFAULT 0,
  `amount` decimal(13,4) NOT NULL DEFAULT 0.0000,
  PRIMARY KEY (`customer_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `coupon_gv_queue`;
CREATE TABLE `coupon_gv_queue` (
  `unique_id` int(5) NOT NULL AUTO_INCREMENT,
  `orders_products_id` int(11) DEFAULT NULL,
  `customer_id` int(5) NOT NULL DEFAULT 0,
  `order_id` int(5) NOT NULL DEFAULT 0,
  `amount` decimal(8,4) NOT NULL DEFAULT 0.0000,
  `date_created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `ipaddr` varchar(32) NOT NULL DEFAULT '',
  `release_flag` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`unique_id`),
  KEY `uid` (`unique_id`,`customer_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `coupon_gv_redeem_track`;
CREATE TABLE `coupon_gv_redeem_track` (
  `coupon_gv_redeem_track_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `coupon_code` varchar(32) NOT NULL,
  `amount` decimal(10,4) NOT NULL,
  PRIMARY KEY (`coupon_gv_redeem_track_id`),
  KEY `orders_idx` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `coupon_redeem_track`;
CREATE TABLE `coupon_redeem_track` (
  `unique_id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL DEFAULT 0,
  `customer_id` int(11) NOT NULL DEFAULT 0,
  `redeem_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `redeem_ip` varchar(32) NOT NULL DEFAULT '',
  `order_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies` (
  `currencies_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL DEFAULT '',
  `code` char(3) NOT NULL DEFAULT '',
  `symbol_left` varchar(12) DEFAULT NULL,
  `symbol_right` varchar(12) DEFAULT NULL,
  `decimal_point` char(1) DEFAULT NULL,
  `thousands_point` char(1) DEFAULT NULL,
  `decimal_places` char(1) DEFAULT NULL,
  `value` float(13,8) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`currencies_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customers_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_cid` varchar(32) DEFAULT NULL,
  `customers_vat_id` varchar(20) DEFAULT NULL,
  `customers_vat_id_status` int(2) NOT NULL DEFAULT 0,
  `customers_warning` varchar(32) DEFAULT NULL,
  `customers_status` int(5) NOT NULL DEFAULT 1,
  `customers_gender` char(1) NOT NULL DEFAULT '',
  `customers_firstname` varchar(64) NOT NULL DEFAULT '',
  `customers_lastname` varchar(64) NOT NULL DEFAULT '',
  `customers_company` varchar(64) NOT NULL DEFAULT '',
  `customers_dob` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `customers_email_address` varchar(96) NOT NULL DEFAULT '',
  `customers_default_address_id` int(11) NOT NULL DEFAULT 0,
  `customers_telephone` varchar(32) NOT NULL DEFAULT '',
  `customers_fax` varchar(32) DEFAULT NULL,
  `customers_password` varchar(255) NOT NULL DEFAULT '',
  `customers_newsletter` char(1) DEFAULT NULL,
  `customers_newsletter_mode` char(1) NOT NULL DEFAULT '0',
  `customers_is_tradesperson` tinyint(4) NOT NULL DEFAULT 0,
  `member_flag` char(1) NOT NULL DEFAULT '0',
  `delete_user` char(1) NOT NULL DEFAULT '1',
  `account_type` int(1) NOT NULL DEFAULT 0,
  `customers_is_favorite` int(1) NOT NULL DEFAULT 0,
  `password_request_key` varchar(32) NOT NULL DEFAULT '',
  `payment_unallowed` varchar(255) NOT NULL DEFAULT '',
  `shipping_unallowed` varchar(255) NOT NULL DEFAULT '',
  `refferers_id` int(5) NOT NULL DEFAULT 0,
  `customers_date_added` datetime DEFAULT '1000-01-01 00:00:00',
  `customers_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `amparex_id` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`customers_id`),
  KEY `customers_newsletter` (`customers_newsletter`),
  KEY `customers_email_address` (`customers_email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_basket`;
CREATE TABLE `customers_basket` (
  `customers_basket_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `products_id` tinytext NOT NULL,
  `customers_basket_quantity` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `final_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `customers_basket_date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`customers_basket_id`),
  KEY `customers_id` (`customers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_basket_attributes`;
CREATE TABLE `customers_basket_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `products_id` tinytext NOT NULL,
  `products_options_id` int(11) NOT NULL DEFAULT 0,
  `products_options_value_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`customers_basket_attributes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_info`;
CREATE TABLE `customers_info` (
  `customers_info_id` int(11) NOT NULL DEFAULT 0 COMMENT 'represents customers.customers_id',
  `customers_info_date_of_last_logon` datetime DEFAULT NULL,
  `customers_info_number_of_logons` int(5) DEFAULT NULL,
  `customers_info_date_account_created` datetime DEFAULT NULL,
  `customers_info_date_account_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`customers_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_ip`;
CREATE TABLE `customers_ip` (
  `customers_ip_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `customers_ip` varchar(15) NOT NULL DEFAULT '',
  `customers_ip_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `customers_host` varchar(255) NOT NULL DEFAULT '',
  `customers_advertiser` varchar(30) DEFAULT NULL,
  `customers_referer_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customers_ip_id`),
  KEY `customers_id` (`customers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_logs_history`;
CREATE TABLE `customers_logs_history` (
  `customers_logs_history_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `confirmation_date` varchar(32) NOT NULL DEFAULT '',
  `logfile` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`customers_logs_history_id`),
  UNIQUE KEY `customers_id` (`customers_id`,`logfile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_memo`;
CREATE TABLE `customers_memo` (
  `memo_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `memo_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `memo_text` text NOT NULL,
  `poster_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`memo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_status`;
CREATE TABLE `customers_status` (
  `customers_status_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `customers_status_name` varchar(32) NOT NULL DEFAULT '',
  `customers_status_public` int(1) NOT NULL DEFAULT 1,
  `customers_status_min_order` decimal(15,2) DEFAULT NULL,
  `customers_status_max_order` decimal(15,2) DEFAULT NULL,
  `customers_status_image` varchar(255) DEFAULT NULL,
  `customers_status_discount` decimal(5,2) DEFAULT 0.00,
  `customers_status_ot_discount_flag` char(1) NOT NULL DEFAULT '0',
  `customers_status_ot_discount` decimal(5,2) DEFAULT 0.00,
  `customers_status_graduated_prices` char(1) NOT NULL DEFAULT '0',
  `customers_status_show_price` int(1) NOT NULL DEFAULT 1,
  `customers_status_show_price_tax` int(1) NOT NULL DEFAULT 1,
  `customers_status_add_tax_ot` int(1) NOT NULL DEFAULT 0,
  `customers_status_payment_unallowed` varchar(255) NOT NULL DEFAULT '',
  `customers_status_shipping_unallowed` varchar(255) NOT NULL DEFAULT '',
  `customers_status_discount_attributes` int(1) NOT NULL DEFAULT 0,
  `customers_fsk18_purchasable` int(1) NOT NULL DEFAULT 0,
  `customers_fsk18_display` int(1) NOT NULL DEFAULT 1,
  `customers_status_write_reviews` int(1) NOT NULL DEFAULT 1,
  `customers_status_read_reviews` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`customers_status_id`,`language_id`),
  KEY `idx_orders_status_name` (`customers_status_name`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_status_history`;
CREATE TABLE `customers_status_history` (
  `customers_status_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `new_value` int(5) NOT NULL DEFAULT 0,
  `old_value` int(5) DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `customer_notified` int(1) DEFAULT 0,
  PRIMARY KEY (`customers_status_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_wishlist`;
CREATE TABLE `customers_wishlist` (
  `customers_basket_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `products_id` tinytext NOT NULL,
  `customers_basket_quantity` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `final_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `customers_basket_date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`customers_basket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `customers_wishlist_attributes`;
CREATE TABLE `customers_wishlist_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `products_id` tinytext NOT NULL,
  `products_options_id` int(11) NOT NULL DEFAULT 0,
  `products_options_value_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`customers_basket_attributes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `database_version`;
CREATE TABLE `database_version` (
  `version` varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `delete_history`;
CREATE TABLE `delete_history` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `scope` varchar(255) NOT NULL,
  `deleted_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `documents_index`;
CREATE TABLE `documents_index` (
  `number` int(11) NOT NULL DEFAULT 0,
  `type` enum('invoice','packing_slip') NOT NULL DEFAULT 'invoice',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`number`,`type`),
  KEY `identifier` (`identifier`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `ekomi_order_information`;
CREATE TABLE `ekomi_order_information` (
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `link` varchar(255) NOT NULL DEFAULT '',
  `hash` varchar(255) NOT NULL DEFAULT '',
  `date_sent` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `emails`;
CREATE TABLE `emails` (
  `email_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `content_plain` text DEFAULT NULL,
  `content_html` longtext DEFAULT NULL,
  `is_pending` tinyint(4) DEFAULT 1,
  `creation_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `sent_date` datetime DEFAULT NULL,
  PRIMARY KEY (`email_id`),
  KEY `emails_creation_date_index` (`creation_date`),
  KEY `emails_sent_date_index` (`sent_date`),
  KEY `emails_subject_index` (`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `email_attachments`;
CREATE TABLE `email_attachments` (
  `email_id` int(11) NOT NULL DEFAULT 0,
  `path` text NOT NULL,
  `name` varchar(255) DEFAULT '',
  KEY `email_id_index` (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `email_contacts`;
CREATE TABLE `email_contacts` (
  `email_id` int(11) NOT NULL DEFAULT 0,
  `email_address` varchar(128) NOT NULL DEFAULT '',
  `contact_type` varchar(32) NOT NULL DEFAULT '',
  `contact_name` varchar(128) DEFAULT '',
  KEY `email_id_index` (`email_id`),
  KEY `email_contacts_email_address_index` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `email_templates_cache`;
CREATE TABLE `email_templates_cache` (
  `name` varchar(32) NOT NULL DEFAULT '',
  `language_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` enum('txt','html') NOT NULL DEFAULT 'txt',
  `content` mediumtext NOT NULL,
  `source` varchar(255) NOT NULL DEFAULT '',
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`name`,`language_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `email_templates_edited`;
CREATE TABLE `email_templates_edited` (
  `name` varchar(32) NOT NULL DEFAULT '',
  `language_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` enum('txt','html') NOT NULL DEFAULT 'txt',
  `content` mediumtext NOT NULL,
  `backup` mediumtext NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`name`,`language_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `export_cronjobs`;
CREATE TABLE `export_cronjobs` (
  `cronjob_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `scheme_id` int(10) unsigned NOT NULL DEFAULT 0,
  `due_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`cronjob_id`),
  KEY `scheme_id` (`scheme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `export_schemes`;
CREATE TABLE `export_schemes` (
  `scheme_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(11) unsigned NOT NULL DEFAULT 2,
  `scheme_name` varchar(255) NOT NULL DEFAULT '',
  `filename` varchar(45) NOT NULL DEFAULT '',
  `field_separator` varchar(8) NOT NULL DEFAULT '',
  `field_quotes` varchar(8) NOT NULL DEFAULT '',
  `date_created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_last_export` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `created_by` varchar(45) NOT NULL DEFAULT 'custom',
  `customers_status_id` int(11) unsigned NOT NULL DEFAULT 0,
  `currencies_id` int(11) unsigned NOT NULL DEFAULT 0,
  `languages_id` int(11) unsigned NOT NULL DEFAULT 0,
  `campaign_id` varchar(64) NOT NULL DEFAULT '',
  `shipping_free_minimum` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `quantity_minimum` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `export_attributes` tinyint(1) NOT NULL DEFAULT 0,
  `export_properties` tinyint(1) NOT NULL DEFAULT 0,
  `export_features` tinyint(1) NOT NULL DEFAULT 0,
  `cronjob_allowed` tinyint(1) NOT NULL DEFAULT 0,
  `cronjob_days` varchar(32) NOT NULL DEFAULT 'Mon|Tue|Wed|Thu|Fri|Sat|Sun',
  `cronjob_hour` enum('0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23') NOT NULL DEFAULT '3',
  `cronjob_interval` enum('0','1','2','3','4','5','6','7','8','9','10','11','12') NOT NULL DEFAULT '0',
  `export_all_new_ones` tinyint(1) NOT NULL DEFAULT 0,
  `export_property_image` tinyint(1) NOT NULL DEFAULT 0,
  `amount_additional_image_files` int(11) NOT NULL DEFAULT 99999,
  PRIMARY KEY (`scheme_id`),
  UNIQUE KEY `scheme_type` (`type_id`,`scheme_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `export_scheme_categories`;
CREATE TABLE `export_scheme_categories` (
  `scheme_id` int(11) NOT NULL DEFAULT 0,
  `categories_id` int(11) NOT NULL DEFAULT 0,
  `selection_state` enum('self_all_sub','self_some_sub','self_no_sub','no_self_all_sub','no_self_some_sub','no_self_no_sub') NOT NULL DEFAULT 'no_self_no_sub',
  PRIMARY KEY (`scheme_id`,`categories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `export_scheme_fields`;
CREATE TABLE `export_scheme_fields` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `scheme_id` int(11) unsigned NOT NULL DEFAULT 0,
  `field_name` varchar(255) NOT NULL DEFAULT '',
  `field_content` varchar(255) NOT NULL DEFAULT '',
  `field_content_default` varchar(255) NOT NULL DEFAULT '',
  `created_by` varchar(45) NOT NULL DEFAULT 'custom',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`field_id`),
  KEY `fk_export_scheme_fields_export_schemes_idx` (`scheme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `export_scheme_properties`;
CREATE TABLE `export_scheme_properties` (
  `scheme_id` int(11) unsigned NOT NULL DEFAULT 0,
  `properties_column` varchar(100) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`scheme_id`,`properties_column`),
  KEY `scheme_id` (`scheme_id`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `export_types`;
CREATE TABLE `export_types` (
  `type_id` int(11) unsigned NOT NULL DEFAULT 0,
  `language_id` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`type_id`,`language_id`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `feature`;
CREATE TABLE `feature` (
  `feature_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_display_type` varchar(64) NOT NULL,
  PRIMARY KEY (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `feature_description`;
CREATE TABLE `feature_description` (
  `feature_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `feature_name` varchar(45) DEFAULT NULL,
  `feature_admin_name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`feature_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `feature_index`;
CREATE TABLE `feature_index` (
  `feature_set_id` int(11) unsigned NOT NULL DEFAULT 0,
  `date_created` datetime DEFAULT NULL,
  `feature_value_index` text DEFAULT NULL,
  PRIMARY KEY (`feature_set_id`),
  FULLTEXT KEY `feature_value_index` (`feature_value_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `feature_set`;
CREATE TABLE `feature_set` (
  `feature_set_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`feature_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `feature_set_to_products`;
CREATE TABLE `feature_set_to_products` (
  `feature_set_id` int(11) unsigned NOT NULL DEFAULT 0,
  `products_id` int(11) unsigned NOT NULL DEFAULT 0,
  KEY `products_id` (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `feature_set_values`;
CREATE TABLE `feature_set_values` (
  `feature_set_id` int(11) unsigned NOT NULL DEFAULT 0,
  `feature_value_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`feature_set_id`,`feature_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `feature_value`;
CREATE TABLE `feature_value` (
  `feature_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_id` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`feature_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `feature_value_description`;
CREATE TABLE `feature_value_description` (
  `feature_value_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `feature_value_text` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`feature_value_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `field_replace_jobs`;
CREATE TABLE `field_replace_jobs` (
  `field_replace_job_id` int(11) NOT NULL AUTO_INCREMENT,
  `waiting_ticket_id` int(11) NOT NULL DEFAULT 0,
  `table_name` varchar(255) NOT NULL DEFAULT '',
  `field_name` varchar(255) NOT NULL DEFAULT '',
  `old_value` text NOT NULL,
  `new_value` text NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`field_replace_job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `geo_zones`;
CREATE TABLE `geo_zones` (
  `geo_zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_zone_name` varchar(32) NOT NULL DEFAULT '',
  `geo_zone_description` varchar(255) NOT NULL DEFAULT '',
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`geo_zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gkv_shipments`;
CREATE TABLE `gkv_shipments` (
  `gkv_shipments_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `shipmentnumber` varchar(39) NOT NULL,
  `returnshipmentnumber` varchar(39) NOT NULL DEFAULT '',
  `labelurl` text NOT NULL,
  `returnlabelurl` text NOT NULL,
  `exportlabelurl` text NOT NULL,
  `codlabelurl` text NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`gkv_shipments_id`),
  KEY `orders_id` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_admin_boxes`;
CREATE TABLE `gm_admin_boxes` (
  `boxes_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `box_key` varchar(64) NOT NULL DEFAULT '',
  `box_status` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`boxes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_admin_favorites`;
CREATE TABLE `gm_admin_favorites` (
  `favorites_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `link_key` varchar(255) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`favorites_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_counter_extern_search`;
CREATE TABLE `gm_counter_extern_search` (
  `gm_counter_extern_search_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_counter_extern_search_name` varchar(255) DEFAULT NULL,
  `gm_counter_extern_search_engine` varchar(255) DEFAULT NULL,
  `gm_counter_extern_search_hits` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`gm_counter_extern_search_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_counter_info`;
CREATE TABLE `gm_counter_info` (
  `gm_counter_info_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_counter_info_type_id` int(10) NOT NULL DEFAULT 0,
  `gm_counter_info_hits` int(10) NOT NULL DEFAULT 0,
  `gm_counter_info_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`gm_counter_info_id`),
  KEY `gm_counter_info_type_id` (`gm_counter_info_type_id`,`gm_counter_info_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_counter_info_type`;
CREATE TABLE `gm_counter_info_type` (
  `gm_counter_info_type_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_counter_info_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gm_counter_info_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_counter_intern_search`;
CREATE TABLE `gm_counter_intern_search` (
  `gm_counter_intern_search_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_counter_intern_search_name` varchar(255) DEFAULT NULL,
  `gm_counter_intern_search_hits` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`gm_counter_intern_search_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_counter_ip`;
CREATE TABLE `gm_counter_ip` (
  `gm_ip_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_ip_value` varchar(255) DEFAULT NULL,
  `gm_ip_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `session_hash` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`gm_ip_id`),
  KEY `gm_ip_date` (`gm_ip_date`),
  KEY `gm_ip_value` (`gm_ip_value`),
  KEY `session_hash` (`session_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_counter_page`;
CREATE TABLE `gm_counter_page` (
  `gm_counter_page_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_counter_page_name` varchar(255) DEFAULT NULL,
  `gm_counter_page_type` varchar(255) DEFAULT NULL,
  `gm_counter_page_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`gm_counter_page_id`),
  KEY `gm_counter_page_date` (`gm_counter_page_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_counter_page_history`;
CREATE TABLE `gm_counter_page_history` (
  `gm_counter_page_history_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_counter_page_history_name` varchar(255) DEFAULT NULL,
  `gm_counter_page_history_type` varchar(255) DEFAULT NULL,
  `gm_counter_page_history_hits` int(10) DEFAULT NULL,
  `gm_counter_page_history_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`gm_counter_page_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_counter_visits`;
CREATE TABLE `gm_counter_visits` (
  `gm_counter_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_counter_visits_total` int(10) NOT NULL DEFAULT 0,
  `gm_counter_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`gm_counter_id`),
  KEY `gm_counter_date` (`gm_counter_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_cart_elements`;
CREATE TABLE `gm_gprint_cart_elements` (
  `gm_gprint_cart_elements_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gm_gprint_elements_id` int(10) unsigned DEFAULT NULL,
  `products_id` tinytext DEFAULT NULL,
  `customers_id` int(10) unsigned DEFAULT NULL,
  `elements_value` text DEFAULT NULL,
  `gm_gprint_uploads_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`gm_gprint_cart_elements_id`),
  KEY `customers_id_products_id` (`customers_id`,`products_id`(10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_elements`;
CREATE TABLE `gm_gprint_elements` (
  `gm_gprint_elements_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gm_gprint_elements_groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `gm_gprint_surfaces_id` int(10) unsigned NOT NULL DEFAULT 0,
  `position_x` int(10) NOT NULL DEFAULT 0,
  `position_y` int(10) NOT NULL DEFAULT 0,
  `height` int(10) unsigned NOT NULL DEFAULT 0,
  `width` int(10) unsigned NOT NULL DEFAULT 0,
  `z_index` int(10) NOT NULL DEFAULT 0,
  `max_characters` int(10) NOT NULL DEFAULT 0,
  `allowed_extensions` varchar(255) NOT NULL DEFAULT '',
  `show_name` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `minimum_filesize` decimal(7,4) NOT NULL DEFAULT 0.0000,
  `maximum_filesize` decimal(7,4) NOT NULL DEFAULT 0.0000,
  PRIMARY KEY (`gm_gprint_elements_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_elements_groups`;
CREATE TABLE `gm_gprint_elements_groups` (
  `gm_gprint_elements_groups_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_type` varchar(255) DEFAULT NULL,
  `group_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gm_gprint_elements_groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_elements_values`;
CREATE TABLE `gm_gprint_elements_values` (
  `gm_gprint_elements_values_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `languages_id` int(10) unsigned NOT NULL DEFAULT 0,
  `gm_gprint_elements_groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `elements_value` text DEFAULT NULL,
  PRIMARY KEY (`gm_gprint_elements_values_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_orders_elements`;
CREATE TABLE `gm_gprint_orders_elements` (
  `gm_gprint_orders_elements_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gm_gprint_orders_surfaces_id` int(10) unsigned NOT NULL DEFAULT 0,
  `position_x` int(10) NOT NULL DEFAULT 0,
  `position_y` int(10) NOT NULL DEFAULT 0,
  `height` int(10) unsigned NOT NULL DEFAULT 0,
  `width` int(10) unsigned NOT NULL DEFAULT 0,
  `z_index` int(10) NOT NULL DEFAULT 0,
  `show_name` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `group_type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `elements_value` text DEFAULT NULL,
  `gm_gprint_uploads_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`gm_gprint_orders_elements_id`),
  KEY `gm_gprint_uploads_id` (`gm_gprint_uploads_id`),
  KEY `gm_gprint_orders_surfaces_id` (`gm_gprint_orders_surfaces_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_orders_surfaces`;
CREATE TABLE `gm_gprint_orders_surfaces` (
  `gm_gprint_orders_surfaces_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gm_gprint_orders_surfaces_groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `width` int(10) unsigned NOT NULL DEFAULT 0,
  `height` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`gm_gprint_orders_surfaces_id`),
  KEY `gm_gprint_orders_surfaces_groups_id` (`gm_gprint_orders_surfaces_groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_orders_surfaces_groups`;
CREATE TABLE `gm_gprint_orders_surfaces_groups` (
  `gm_gprint_orders_surfaces_groups_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `orders_products_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`gm_gprint_orders_surfaces_groups_id`),
  UNIQUE KEY `orders_products_id` (`orders_products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_surfaces`;
CREATE TABLE `gm_gprint_surfaces` (
  `gm_gprint_surfaces_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gm_gprint_surfaces_groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `width` int(10) unsigned NOT NULL DEFAULT 0,
  `height` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`gm_gprint_surfaces_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_surfaces_description`;
CREATE TABLE `gm_gprint_surfaces_description` (
  `gm_gprint_surfaces_id` int(10) unsigned NOT NULL DEFAULT 0,
  `languages_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gm_gprint_surfaces_id`,`languages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_surfaces_groups`;
CREATE TABLE `gm_gprint_surfaces_groups` (
  `gm_gprint_surfaces_groups_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gm_gprint_surfaces_groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_surfaces_groups_to_products`;
CREATE TABLE `gm_gprint_surfaces_groups_to_products` (
  `gm_gprint_surfaces_groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `products_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`gm_gprint_surfaces_groups_id`,`products_id`),
  UNIQUE KEY `products_id` (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_uploads`;
CREATE TABLE `gm_gprint_uploads` (
  `gm_gprint_uploads_id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `customers_id` int(10) unsigned DEFAULT NULL,
  `filename` varchar(255) NOT NULL DEFAULT '',
  `encrypted_filename` varchar(255) NOT NULL DEFAULT '',
  `download_key` varchar(32) NOT NULL DEFAULT '',
  `ip_hash` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`gm_gprint_uploads_id`),
  UNIQUE KEY `encrypted_filename` (`encrypted_filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_gprint_wishlist_elements`;
CREATE TABLE `gm_gprint_wishlist_elements` (
  `gm_gprint_wishlist_elements_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gm_gprint_elements_id` int(10) unsigned DEFAULT NULL,
  `products_id` tinytext DEFAULT NULL,
  `customers_id` int(10) unsigned DEFAULT NULL,
  `elements_value` text DEFAULT NULL,
  `gm_gprint_uploads_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`gm_gprint_wishlist_elements_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_login_history`;
CREATE TABLE `gm_login_history` (
  `gm_login_history_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_login_ip` varchar(15) NOT NULL DEFAULT '',
  `gm_login_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`gm_login_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_prd_img_alt`;
CREATE TABLE `gm_prd_img_alt` (
  `img_alt_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` int(11) NOT NULL DEFAULT 0,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `gm_alt_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`img_alt_id`),
  UNIQUE KEY `image_id` (`image_id`,`products_id`,`language_id`),
  KEY `image_id2` (`image_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gm_search_history`;
CREATE TABLE `gm_search_history` (
  `gm_search_history_id` int(10) NOT NULL AUTO_INCREMENT,
  `gm_search_ip` varchar(15) NOT NULL DEFAULT '',
  `gm_search_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`gm_search_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `google_adwords_client_customers`;
CREATE TABLE `google_adwords_client_customers` (
  `client_customer_id` varchar(12) NOT NULL,
  `primary` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`client_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `google_configurations`;
CREATE TABLE `google_configurations` (
  `scope` enum('general','auth','adwords','shopping','analytics') NOT NULL,
  `option` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`scope`,`option`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `google_export_availability`;
CREATE TABLE `google_export_availability` (
  `google_export_availability_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int(10) NOT NULL DEFAULT 2,
  `availability` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`google_export_availability_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `google_export_condition`;
CREATE TABLE `google_export_condition` (
  `google_export_condition_id` int(10) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT 2,
  `condition` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`google_export_condition_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gx_configurations`;
CREATE TABLE `gx_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` mediumtext DEFAULT NULL,
  `default` mediumtext DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sort_order` int(5) DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `gx_lang_configurations`;
CREATE TABLE `gx_lang_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `language_id` int(11) NOT NULL,
  `value` mediumtext DEFAULT NULL,
  `default` mediumtext DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_language_id` (`key`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `infobox_messages`;
CREATE TABLE `infobox_messages` (
  `infobox_messages_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source` varchar(255) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `status` enum('new','read','hidden','deleted') NOT NULL DEFAULT 'new',
  `type` enum('info','warning','success') NOT NULL DEFAULT 'info',
  `visibility` enum('alwayson','hideable','removable') NOT NULL DEFAULT 'hideable',
  `button_link` varchar(255) NOT NULL DEFAULT '',
  `customers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`infobox_messages_id`),
  UNIQUE KEY `identifier` (`identifier`,`customers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `infobox_messages_description`;
CREATE TABLE `infobox_messages_description` (
  `infobox_messages_id` int(10) unsigned NOT NULL DEFAULT 0,
  `languages_id` int(10) unsigned NOT NULL DEFAULT 0,
  `headline` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `button_label` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`infobox_messages_id`,`languages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(255) NOT NULL DEFAULT '',
  `invoice_date` datetime DEFAULT NULL,
  `invoice_file` varchar(255) NOT NULL DEFAULT '',
  `customer_id` int(11) NOT NULL DEFAULT 0,
  `customer_status_id` int(11) DEFAULT NULL,
  `customer_status_name` varchar(32) NOT NULL DEFAULT '',
  `total_sum` decimal(14,6) DEFAULT NULL,
  `currency` char(3) DEFAULT NULL,
  `customers_firstname` varchar(64) NOT NULL DEFAULT '',
  `customers_lastname` varchar(64) NOT NULL DEFAULT '',
  `delivery_firstname` varchar(64) NOT NULL DEFAULT '',
  `delivery_lastname` varchar(64) NOT NULL DEFAULT '',
  `delivery_company` varchar(255) DEFAULT NULL,
  `delivery_street_address` varchar(64) NOT NULL DEFAULT '',
  `delivery_house_number` varchar(64) NOT NULL DEFAULT '',
  `delivery_additional_info` varchar(255) NOT NULL DEFAULT '',
  `delivery_suburb` varchar(32) DEFAULT NULL,
  `delivery_city` varchar(32) NOT NULL DEFAULT '',
  `delivery_postcode` varchar(10) NOT NULL DEFAULT '',
  `delivery_state` varchar(32) DEFAULT NULL,
  `delivery_country` varchar(64) NOT NULL DEFAULT '',
  `delivery_country_iso_code_2` char(2) NOT NULL DEFAULT '',
  `delivery_address_format_id` int(5) NOT NULL DEFAULT 0,
  `billing_firstname` varchar(64) NOT NULL DEFAULT '',
  `billing_lastname` varchar(64) NOT NULL DEFAULT '',
  `billing_company` varchar(255) DEFAULT NULL,
  `billing_street_address` varchar(64) NOT NULL DEFAULT '',
  `billing_house_number` varchar(64) NOT NULL DEFAULT '',
  `billing_additional_info` varchar(255) NOT NULL DEFAULT '',
  `billing_suburb` varchar(32) DEFAULT NULL,
  `billing_city` varchar(32) NOT NULL DEFAULT '',
  `billing_postcode` varchar(10) NOT NULL DEFAULT '',
  `billing_state` varchar(32) DEFAULT NULL,
  `billing_country` varchar(64) NOT NULL DEFAULT '',
  `billing_country_iso_code_2` char(2) NOT NULL DEFAULT '',
  `billing_address_format_id` int(5) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `order_date_purchased` datetime DEFAULT NULL,
  `payment_method` varchar(32) NOT NULL DEFAULT '',
  `payment_class` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`invoice_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `ipayment_log`;
CREATE TABLE `ipayment_log` (
  `ipayment_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `action` varchar(255) NOT NULL DEFAULT '',
  `trxuser_id` varchar(255) NOT NULL DEFAULT '',
  `trx_currency` varchar(255) NOT NULL DEFAULT '',
  `trx_amount` varchar(255) NOT NULL DEFAULT '',
  `trx_typ` varchar(255) NOT NULL DEFAULT '',
  `addr_name` varchar(255) NOT NULL DEFAULT '',
  `addr_email` varchar(255) NOT NULL DEFAULT '',
  `shopper_id` varchar(255) NOT NULL DEFAULT '',
  `client_name` varchar(255) NOT NULL DEFAULT '',
  `client_version` varchar(255) NOT NULL DEFAULT '',
  `addr_street` varchar(255) NOT NULL DEFAULT '',
  `addr_zip` varchar(255) NOT NULL DEFAULT '',
  `addr_city` varchar(255) NOT NULL DEFAULT '',
  `trx_paymenttyp` varchar(255) NOT NULL DEFAULT '',
  `ret_transdate` varchar(255) NOT NULL DEFAULT '',
  `ret_transtime` varchar(255) NOT NULL DEFAULT '',
  `ret_errorcode` varchar(255) NOT NULL DEFAULT '',
  `ret_fatalerror` varchar(255) NOT NULL DEFAULT '',
  `ret_errormsg` varchar(255) NOT NULL DEFAULT '',
  `ret_additionalmsg` varchar(255) NOT NULL DEFAULT '',
  `ret_authcode` varchar(255) NOT NULL DEFAULT '',
  `ret_ip` varchar(255) NOT NULL DEFAULT '',
  `ret_booknr` varchar(255) NOT NULL DEFAULT '',
  `ret_trx_number` varchar(255) NOT NULL DEFAULT '',
  `ret_param_checksum` varchar(255) NOT NULL DEFAULT '',
  `redirect_needed` varchar(255) NOT NULL DEFAULT '',
  `trx_paymentmethod` varchar(255) NOT NULL DEFAULT '',
  `trx_paymentdata_country` varchar(255) NOT NULL DEFAULT '',
  `trx_remoteip_country` varchar(255) NOT NULL DEFAULT '',
  `ret_status` varchar(255) NOT NULL DEFAULT '',
  `trx_payauth_status` varchar(255) NOT NULL DEFAULT '',
  `trx_issuer_avs_response` varchar(255) NOT NULL DEFAULT '',
  `ret_url_checksum` varchar(255) NOT NULL DEFAULT '',
  `addr_check_result` varchar(255) NOT NULL DEFAULT '',
  `paydata` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ipayment_log_id`),
  KEY `orders_id` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `job_waiting_tickets`;
CREATE TABLE `job_waiting_tickets` (
  `waiting_ticket_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(45) NOT NULL DEFAULT '',
  `callback` varchar(45) NOT NULL DEFAULT '',
  `due_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `done_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`waiting_ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `languages_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `code` char(2) NOT NULL DEFAULT '',
  `image` varchar(255) DEFAULT NULL,
  `directory` varchar(32) DEFAULT NULL,
  `sort_order` int(3) DEFAULT NULL,
  `language_charset` text NOT NULL,
  `date_format` varchar(32) NOT NULL,
  `date_format_long` varchar(32) NOT NULL,
  `date_format_short` varchar(32) NOT NULL,
  `date_time_format` varchar(32) NOT NULL,
  `dob_format_string` varchar(32) NOT NULL,
  `html_params` text NOT NULL,
  `language_currency` varchar(32) NOT NULL,
  `php_date_time_format` varchar(32) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `status_admin` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`languages_id`),
  KEY `IDX_LANGUAGES_NAME` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `language_phrases_cache`;
CREATE TABLE `language_phrases_cache` (
  `language_id` int(11) NOT NULL DEFAULT 0,
  `section_name` varchar(100) NOT NULL DEFAULT '',
  `phrase_name` varchar(100) NOT NULL DEFAULT '',
  `phrase_text` text NOT NULL,
  `source` varchar(255) NOT NULL DEFAULT '',
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`language_id`,`section_name`,`phrase_name`),
  KEY `search` (`source`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `language_phrases_edited`;
CREATE TABLE `language_phrases_edited` (
  `language_id` int(11) NOT NULL DEFAULT 0,
  `section_name` varchar(100) NOT NULL DEFAULT '',
  `phrase_name` varchar(100) NOT NULL DEFAULT '',
  `phrase_text` text NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`language_id`,`section_name`,`phrase_name`),
  KEY `section` (`language_id`,`section_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `log_configuration`;
CREATE TABLE `log_configuration` (
  `log_group_id` int(11) NOT NULL DEFAULT 0,
  `log_level_id` int(11) NOT NULL DEFAULT 0,
  `log_output_type_id` int(11) NOT NULL DEFAULT 0,
  `log_output_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`log_group_id`,`log_level_id`,`log_output_type_id`,`log_output_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `log_groups`;
CREATE TABLE `log_groups` (
  `log_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`log_group_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `log_levels`;
CREATE TABLE `log_levels` (
  `log_level_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`log_level_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `log_outputs`;
CREATE TABLE `log_outputs` (
  `log_output_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`log_output_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `log_output_types`;
CREATE TABLE `log_output_types` (
  `log_output_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`log_output_type_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_amazon_apply`;
CREATE TABLE `magnalister_amazon_apply` (
  `mpID` int(8) unsigned NOT NULL,
  `products_id` int(10) unsigned NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `is_incomplete` enum('true','false') NOT NULL DEFAULT 'false',
  `category` text NOT NULL,
  `data` mediumtext NOT NULL,
  `leadtimeToShip` int(11) NOT NULL,
  `topMainCategory` varchar(64) NOT NULL,
  `topProductType` varchar(64) NOT NULL,
  `topBrowseNode1` varchar(64) NOT NULL,
  `topBrowseNode2` varchar(64) NOT NULL,
  `ConditionType` varchar(24) NOT NULL DEFAULT '',
  `ConditionNote` varchar(1000) NOT NULL DEFAULT '',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `variation_theme` varchar(400) DEFAULT '{"autodetect":[]}',
  `ShippingTemplate` int(11) DEFAULT NULL,
  PRIMARY KEY (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_amazon_errorlog`;
CREATE TABLE `magnalister_amazon_errorlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mpID` int(8) unsigned NOT NULL,
  `batchid` varchar(50) NOT NULL,
  `dateadded` datetime NOT NULL,
  `errorcode` varchar(30) NOT NULL DEFAULT '',
  `errormessage` text NOT NULL,
  `recommendation` text DEFAULT NULL,
  `additionaldata` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_amazon_properties`;
CREATE TABLE `magnalister_amazon_properties` (
  `mpID` int(8) unsigned NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `asin` varchar(16) NOT NULL,
  `asin_type` int(2) NOT NULL,
  `item_condition` varchar(30) NOT NULL,
  `amazon_price` decimal(15,4) NOT NULL,
  `image_url` text NOT NULL,
  `item_note` text NOT NULL,
  `will_ship_internationally` int(2) NOT NULL,
  `category_id` varchar(10) NOT NULL,
  `category_name` varchar(200) NOT NULL,
  `lowestprice` decimal(15,2) NOT NULL,
  `leadtimeToShip` int(11) NOT NULL,
  `B2BActive` enum('false','true') NOT NULL DEFAULT 'false',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ShippingTemplate` int(11) DEFAULT NULL,
  UNIQUE KEY `UC_products_id` (`mpID`,`products_id`,`products_model`),
  KEY `asin` (`asin`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_amazon_variantmatching`;
CREATE TABLE `magnalister_amazon_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_api_requests`;
CREATE TABLE `magnalister_api_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_ayn24_categories`;
CREATE TABLE `magnalister_ayn24_categories` (
  `mpID` int(11) NOT NULL,
  `platform` varchar(30) NOT NULL,
  `CategoryID` varchar(200) NOT NULL,
  `CategoryName` varchar(128) NOT NULL DEFAULT '',
  `ParentID` varchar(200) NOT NULL,
  `CategoryPath` text NOT NULL,
  `LeafCategory` enum('0','1') NOT NULL DEFAULT '0',
  `Selectable` enum('0','1') NOT NULL,
  `Fee` decimal(12,4) NOT NULL,
  `FeeCurrency` varchar(3) NOT NULL,
  `InsertTimestamp` datetime NOT NULL,
  UNIQUE KEY `UniqueEntry` (`mpID`,`platform`,`CategoryID`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_ayn24_errorlog`;
CREATE TABLE `magnalister_ayn24_errorlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mpID` int(8) unsigned NOT NULL,
  `dateadded` datetime NOT NULL,
  `errormessage` text NOT NULL,
  `additionaldata` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_ayn24_properties`;
CREATE TABLE `magnalister_ayn24_properties` (
  `mpID` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `MarketplaceCategory` varchar(30) NOT NULL,
  `StoreCategory` varchar(255) NOT NULL,
  `VariationConfiguration` varchar(255) NOT NULL,
  `ShippingDetails` tinytext NOT NULL,
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_ayn24_variantmatching`;
CREATE TABLE `magnalister_ayn24_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_bepado_properties`;
CREATE TABLE `magnalister_bepado_properties` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `MarketplaceCategories` text NOT NULL,
  `TopMarketplaceCategory` varchar(20) NOT NULL,
  `ShippingServiceOptions` mediumtext NOT NULL,
  `ShippingTime` int(11) NOT NULL,
  `SubmitPurchasePrice` enum('true','false') NOT NULL DEFAULT 'false',
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `U_PRODUCT_ID` (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_cdiscount_prepare`;
CREATE TABLE `magnalister_cdiscount_prepare` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `EAN` varchar(13) DEFAULT NULL,
  `MarketplaceCategoriesName` text DEFAULT NULL,
  `PrimaryCategory` varchar(30) DEFAULT NULL,
  `TopMarketplaceCategory` varchar(30) DEFAULT NULL,
  `CategoryAttributes` text NOT NULL,
  `Title` varchar(132) DEFAULT NULL,
  `Subtitle` varchar(132) DEFAULT NULL,
  `Description` varchar(420) DEFAULT NULL,
  `MarketingDescription` text DEFAULT NULL,
  `PictureUrl` text DEFAULT NULL,
  `ConditionType` varchar(60) DEFAULT NULL,
  `PreparationTime` int(11) NOT NULL DEFAULT 0,
  `ShippingFeeStandard` char(11) NOT NULL,
  `ShippingFeeExtraStandard` char(11) NOT NULL,
  `ShippingFeeTracked` char(11) NOT NULL,
  `ShippingFeeExtraTracked` char(11) NOT NULL,
  `ShippingFeeRegistered` char(11) NOT NULL,
  `ShippingFeeExtraRegistered` char(11) NOT NULL,
  `Comment` text DEFAULT NULL,
  `PrepareType` enum('Apply','Match') NOT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OK',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `variation_theme` varchar(400) DEFAULT NULL,
  `ShippingProfileName` text DEFAULT NULL,
  `ShippingFee` text DEFAULT NULL,
  `ShippingFeeAdditional` text DEFAULT NULL,
  PRIMARY KEY (`mpID`,`products_id`,`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_cdiscount_variantmatching`;
CREATE TABLE `magnalister_cdiscount_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_check24_properties`;
CREATE TABLE `magnalister_check24_properties` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `ShippingTime` int(11) DEFAULT NULL,
  `ShippingCost` decimal(15,4) DEFAULT NULL,
  `ItemHandlingData` text NOT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`mpID`,`products_id`,`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_config`;
CREATE TABLE `magnalister_config` (
  `mpID` int(8) unsigned NOT NULL DEFAULT 0,
  `mkey` varchar(100) NOT NULL,
  `value` longtext NOT NULL,
  UNIQUE KEY `UniqueKey` (`mpID`,`mkey`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_crowdfox_prepare`;
CREATE TABLE `magnalister_crowdfox_prepare` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ItemTitle` varchar(255) DEFAULT NULL,
  `Description` varchar(5000) DEFAULT NULL,
  `Images` text DEFAULT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OK',
  `PrepareType` enum('Apply') NOT NULL,
  `GTIN` varchar(13) DEFAULT NULL,
  `Brand` varchar(255) DEFAULT NULL,
  `MPN` varchar(50) DEFAULT NULL,
  `DeliveryTime` varchar(50) DEFAULT NULL,
  `DeliveryCost` decimal(12,2) DEFAULT NULL,
  `ShippingMethod` enum('0','1') DEFAULT NULL,
  `ShopVariation` mediumtext NOT NULL,
  PRIMARY KEY (`mpID`,`products_id`,`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_crowdfox_variantmatching`;
CREATE TABLE `magnalister_crowdfox_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_cs_deletedlog`;
CREATE TABLE `magnalister_cs_deletedlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mpID` int(8) unsigned NOT NULL,
  `products_id` int(11) unsigned NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `old_price` decimal(15,4) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_cs_errorlog`;
CREATE TABLE `magnalister_cs_errorlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mpID` int(8) unsigned NOT NULL,
  `products_id` int(11) unsigned NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `product_details` text NOT NULL,
  `errormessage` text NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_dawanda_properties`;
CREATE TABLE `magnalister_dawanda_properties` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `ShippingService` int(16) NOT NULL,
  `MarketplaceCategories` text NOT NULL,
  `topMarketplaceCategory` int(16) NOT NULL,
  `StoreCategories` text NOT NULL,
  `topStoreCategory` int(16) NOT NULL,
  `ListingDuration` tinyint(4) NOT NULL,
  `ProductType` int(11) NOT NULL DEFAULT 0,
  `ReturnPolicy` int(11) NOT NULL DEFAULT 0,
  `MpColors` text NOT NULL,
  `Attributes` longtext NOT NULL,
  `CategoryAttributes` text NOT NULL DEFAULT '',
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  UNIQUE KEY `U_PRODUCT_ID` (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_dawanda_variantmatching`;
CREATE TABLE `magnalister_dawanda_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_ebay_categories`;
CREATE TABLE `magnalister_ebay_categories` (
  `CategoryID` bigint(11) NOT NULL DEFAULT 0,
  `SiteID` int(4) NOT NULL DEFAULT 77,
  `CategoryName` varchar(128) NOT NULL DEFAULT '',
  `CategoryLevel` int(3) NOT NULL DEFAULT 1,
  `ParentID` bigint(11) NOT NULL DEFAULT 0,
  `LeafCategory` enum('0','1') NOT NULL DEFAULT '1',
  `B2BVATEnabled` enum('0','1') NOT NULL DEFAULT '0',
  `StoreCategory` enum('0','1') NOT NULL DEFAULT '0',
  `InsertTimestamp` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`CategoryID`,`SiteID`,`StoreCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_ebay_deletedlog`;
CREATE TABLE `magnalister_ebay_deletedlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(255) NOT NULL,
  `mpID` int(11) NOT NULL,
  `ItemID` varchar(20) NOT NULL,
  `Price` float(9,2) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_ebay_errorlog`;
CREATE TABLE `magnalister_ebay_errorlog` (
  `Timestamp` int(11) NOT NULL,
  `SKU` varchar(64) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `mpID` int(11) unsigned NOT NULL DEFAULT 0,
  `Title` varchar(80) DEFAULT NULL,
  `Subtitle` varchar(55) DEFAULT NULL,
  `PictureURL` varchar(255) DEFAULT NULL,
  `ConditionID` int(4) NOT NULL DEFAULT 0,
  `Price` decimal(15,4) NOT NULL,
  `BuyItNowPrice` decimal(15,4) DEFAULT NULL,
  `currencyID` enum('AUD','CAD','CHF','CNY','EUR','GBP','HKD','INR','MYR','PHP','PLN','SEK','SGD','TWD','USD') NOT NULL DEFAULT 'EUR',
  `Site` enum('Australia','Austria','Belgium_Dutch','Belgium_French','Canada','CanadaFrench','China','CustomCode','eBayMotors','France','Germany','HongKong','India','Ireland','Italy','Malaysia','Netherlands','Philippines','Poland','Singapore','Spain','Sweden','Switzerland','Taiwan','UK','US') NOT NULL DEFAULT 'Germany',
  `CategoryID` int(10) NOT NULL,
  `CategoryName` varchar(128) NOT NULL,
  `Category2ID` int(10) DEFAULT NULL,
  `Category2Name` varchar(128) DEFAULT NULL,
  `Attributes` text DEFAULT NULL,
  `ShippingServices` text DEFAULT NULL,
  `PaymentMethods` text DEFAULT NULL,
  `Quantity` int(9) NOT NULL DEFAULT 1,
  `ListingType` enum('FixedPrice','Chinese') NOT NULL DEFAULT 'Chinese',
  `Errors` text DEFAULT NULL,
  PRIMARY KEY (`Timestamp`,`SKU`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_ebay_properties`;
CREATE TABLE `magnalister_ebay_properties` (
  `products_id` int(11) unsigned DEFAULT NULL,
  `products_model` varchar(64) NOT NULL,
  `ItemID` varchar(12) DEFAULT NULL,
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `StartTime` datetime DEFAULT NULL,
  `mpID` int(11) unsigned NOT NULL DEFAULT 0,
  `Title` varchar(96) NOT NULL DEFAULT '',
  `Subtitle` varchar(55) DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `mwst` decimal(15,2) DEFAULT NULL,
  `MobileDescription` varchar(1022) NOT NULL DEFAULT '',
  `PictureURL` varchar(4095) DEFAULT NULL,
  `GalleryURL` varchar(255) DEFAULT NULL,
  `ConditionID` int(4) NOT NULL DEFAULT 0,
  `ConditionDescription` varchar(1000) NOT NULL DEFAULT '',
  `Price` decimal(15,4) NOT NULL,
  `BuyItNowPrice` decimal(15,4) DEFAULT NULL,
  `StrikePriceConf` varchar(255) NOT NULL DEFAULT '',
  `currencyID` enum('AUD','CAD','CHF','CNY','EUR','GBP','HKD','INR','MYR','PHP','PLN','SEK','SGD','TWD','USD') NOT NULL DEFAULT 'EUR',
  `Site` enum('Australia','Austria','Belgium_Dutch','Belgium_French','Canada','CanadaFrench','China','CustomCode','eBayMotors','France','Germany','HongKong','India','Ireland','Italy','Malaysia','Netherlands','Philippines','Poland','Singapore','Spain','Sweden','Switzerland','Taiwan','UK','US') NOT NULL DEFAULT 'Germany',
  `PrimaryCategory` int(10) NOT NULL,
  `PrimaryCategoryName` varchar(128) NOT NULL,
  `SecondaryCategory` int(10) DEFAULT NULL,
  `SecondaryCategoryName` varchar(128) DEFAULT NULL,
  `StoreCategory` bigint(11) DEFAULT NULL,
  `StoreCategory2` bigint(11) DEFAULT NULL,
  `Attributes` text DEFAULT NULL,
  `ItemSpecifics` longtext NOT NULL,
  `VariationThemeBlacklist` longtext DEFAULT NULL,
  `ListingType` enum('Chinese','FixedPriceItem','StoresFixedPrice') NOT NULL DEFAULT 'FixedPriceItem',
  `ListingDuration` varchar(10) NOT NULL,
  `PrivateListing` enum('0','1') DEFAULT '0',
  `BestOfferEnabled` enum('0','1') DEFAULT '0',
  `eBayPicturePackPurge` enum('0','1') DEFAULT '0',
  `GalleryType` enum('None','Gallery','Plus') DEFAULT NULL,
  `VariationDimensionForPictures` bigint(11) DEFAULT NULL,
  `eBayPlus` enum('0','1') DEFAULT '0',
  `HitCounter` enum('NoHitCounter','BasicStyle','RetroStyle','HiddenStyle') NOT NULL DEFAULT 'NoHitCounter',
  `PaymentMethods` longtext DEFAULT NULL,
  `ShippingDetails` longtext DEFAULT NULL,
  `DispatchTimeMax` tinyint(2) NOT NULL DEFAULT 63,
  `SellerProfiles` varchar(127) NOT NULL DEFAULT '',
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  `ErrorCode` varchar(10) NOT NULL DEFAULT '',
  `productRequired` enum('false','true') NOT NULL DEFAULT 'false',
  `ePID` varchar(43) NOT NULL DEFAULT '',
  `Transferred` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `deletedBy` enum('','empty','Sync','Button','expired','notML') NOT NULL DEFAULT '',
  `topPrimaryCategory` varchar(64) NOT NULL,
  `topSecondaryCategory` varchar(64) NOT NULL,
  `topStoreCategory1` varchar(64) NOT NULL,
  `topStoreCategory2` varchar(64) NOT NULL,
  UNIQUE KEY `UniqueEntry` (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`),
  KEY `topPrimaryCategory` (`topPrimaryCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_ebay_variantmatching`;
CREATE TABLE `magnalister_ebay_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_ebay_variations_epids`;
CREATE TABLE `magnalister_ebay_variations_epids` (
  `mpID` int(8) unsigned NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_sku` varchar(150) NOT NULL DEFAULT '',
  `marketplace_id` varchar(32) NOT NULL DEFAULT '',
  `marketplace_sku` varchar(150) NOT NULL DEFAULT '',
  `ePID` varchar(43) NOT NULL DEFAULT '',
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_sku` (`products_sku`),
  KEY `marketplace_id` (`marketplace_id`),
  KEY `marketplace_sku` (`marketplace_sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_etsy_categories`;
CREATE TABLE `magnalister_etsy_categories` (
  `CategoryID` varchar(32) NOT NULL DEFAULT '0',
  `Language` varchar(2) NOT NULL DEFAULT '',
  `CategoryName` varchar(128) NOT NULL DEFAULT '',
  `ParentID` varchar(32) NOT NULL DEFAULT '0',
  `LeafCategory` tinyint(4) NOT NULL DEFAULT 1,
  `InsertTimestamp` datetime NOT NULL,
  PRIMARY KEY (`CategoryID`,`Language`),
  KEY `CategoryID` (`CategoryID`),
  KEY `ParentID` (`ParentID`),
  KEY `Language` (`Language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


DROP TABLE IF EXISTS `magnalister_etsy_prepare`;
CREATE TABLE `magnalister_etsy_prepare` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OK',
  `Title` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Primarycategory` varchar(31) NOT NULL,
  `ShopVariation` mediumtext NOT NULL,
  `ShippingTemplate` varchar(127) NOT NULL,
  `Whomade` varchar(15) NOT NULL,
  `Whenmade` varchar(15) NOT NULL,
  `IsSupply` enum('false','true') NOT NULL DEFAULT 'false',
  `Image` text DEFAULT NULL,
  PRIMARY KEY (`mpID`,`products_id`,`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_etsy_variantmatching`;
CREATE TABLE `magnalister_etsy_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_fyndiq_properties`;
CREATE TABLE `magnalister_fyndiq_properties` (
  `mpID` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `MarketplaceCategory` varchar(30) NOT NULL,
  `TopMarketplaceCategory` varchar(255) NOT NULL,
  `Title` varchar(64) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `PictureUrl` text DEFAULT NULL,
  `ShippingCost` decimal(15,2) DEFAULT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_global_selection`;
CREATE TABLE `magnalister_global_selection` (
  `mpID` int(8) unsigned NOT NULL,
  `selectionname` varchar(50) NOT NULL,
  `data` text NOT NULL,
  `session_id` varchar(64) NOT NULL,
  `element_id` varchar(100) NOT NULL,
  UNIQUE KEY `UC_mp_order_id` (`mpID`,`element_id`,`session_id`,`selectionname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_googleshopping_categories`;
CREATE TABLE `magnalister_googleshopping_categories` (
  `mpID` int(11) NOT NULL,
  `platform` varchar(30) NOT NULL,
  `CategoryID` varchar(30) NOT NULL,
  `CategoryName` varchar(128) NOT NULL DEFAULT '',
  `ParentID` varchar(30) NOT NULL,
  `LeafCategory` enum('0','1') NOT NULL DEFAULT '0',
  `Selectable` enum('0','1') NOT NULL DEFAULT '1',
  `InsertTimestamp` datetime NOT NULL,
  `Language` varchar(5) NOT NULL,
  UNIQUE KEY `UniqueEntry` (`CategoryID`,`CategoryName`,`ParentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_googleshopping_prepare`;
CREATE TABLE `magnalister_googleshopping_prepare` (
  `mpID` int(11) unsigned NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `PreparedTS` datetime NOT NULL,
  `channel` varchar(6) NOT NULL DEFAULT 'online',
  `title` varchar(60) DEFAULT NULL,
  `contentLanguage` varchar(3) NOT NULL DEFAULT 'en',
  `offerId` varchar(255) NOT NULL,
  `targetCountry` varchar(255) NOT NULL DEFAULT 'DE',
  `brand` varchar(255) DEFAULT NULL,
  `condition` varchar(30) NOT NULL,
  `Price` text NOT NULL,
  `currency` varchar(3) NOT NULL,
  `link` text NOT NULL,
  `description` text NOT NULL,
  `availability` varchar(50) NOT NULL,
  `adult` tinyint(1) DEFAULT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') DEFAULT 'OPEN',
  `PrepareType` enum('manual','auto','apply') NOT NULL,
  `Primarycategory` text NOT NULL,
  `PrimaryCategoryName` text NOT NULL,
  `Image` text NOT NULL,
  `ShopVariation` mediumtext NOT NULL,
  `CustomAttributes` text NOT NULL,
  `CategoryAttributes` text NOT NULL,
  `MarketplaceCategories` varchar(255) NOT NULL,
  UNIQUE KEY `UniqueEntry` (`mpID`,`products_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_googleshopping_properties`;
CREATE TABLE `magnalister_googleshopping_properties` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `ShippingService` int(16) NOT NULL,
  `MarketplaceCategories` text NOT NULL,
  `topMarketplaceCategory` int(16) NOT NULL,
  `StoreCategories` text NOT NULL,
  `topStoreCategory` int(16) NOT NULL,
  `ListingDuration` tinyint(4) NOT NULL,
  `ProductType` int(11) NOT NULL DEFAULT 0,
  `ReturnPolicy` int(11) NOT NULL DEFAULT 0,
  `MpColors` text NOT NULL,
  `Attributes` longtext NOT NULL,
  `CategoryAttributes` text NOT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  UNIQUE KEY `U_PRODUCT_ID` (`mpID`,`products_id`,`products_model`) USING BTREE,
  KEY `mpID` (`mpID`) USING BTREE,
  KEY `products_id` (`products_id`) USING BTREE,
  KEY `products_model` (`products_model`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_googleshopping_variantmatching`;
CREATE TABLE `magnalister_googleshopping_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL,
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_hitmeister_prepare`;
CREATE TABLE `magnalister_hitmeister_prepare` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `EAN` varchar(30) DEFAULT NULL,
  `MarketplaceCategoriesName` text DEFAULT NULL,
  `MarketplaceCategories` int(11) DEFAULT NULL,
  `TopMarketplaceCategory` varchar(20) DEFAULT NULL,
  `CategoryAttributes` text NOT NULL,
  `Title` varchar(40) DEFAULT NULL,
  `Subtitle` varchar(60) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `PictureUrl` text DEFAULT NULL,
  `ConditionType` varchar(60) DEFAULT NULL,
  `ShippingTime` char(1) DEFAULT NULL,
  `HandlingTime` int(2) DEFAULT 1,
  `ShippingGroup` int(11) NOT NULL DEFAULT 0,
  `Location` char(2) NOT NULL,
  `Comment` text DEFAULT NULL,
  `PrepareType` enum('Apply','Match') NOT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OK',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_hitmeister_variantmatching`;
CREATE TABLE `magnalister_hitmeister_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_hood_categories`;
CREATE TABLE `magnalister_hood_categories` (
  `CategoryID` bigint(11) NOT NULL DEFAULT 0,
  `CategoryName` varchar(128) NOT NULL,
  `ParentID` bigint(11) NOT NULL DEFAULT 0,
  `LeafCategory` enum('0','1') NOT NULL DEFAULT '1',
  `StoreCategory` enum('0','1') NOT NULL DEFAULT '0',
  `InsertTimestamp` int(11) NOT NULL DEFAULT 0,
  `Fee` float NOT NULL,
  `FeeCurrency` varchar(5) NOT NULL,
  `Mode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CategoryID`,`StoreCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_hood_properties`;
CREATE TABLE `magnalister_hood_properties` (
  `mpID` int(8) unsigned NOT NULL DEFAULT 0,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `ItemID` varchar(12) DEFAULT NULL,
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `StartTime` datetime DEFAULT NULL,
  `Title` varchar(85) NOT NULL DEFAULT '',
  `Subtitle` varchar(100) NOT NULL DEFAULT '',
  `ShortDescription` text NOT NULL,
  `Description` longtext NOT NULL,
  `GalleryPictures` text NOT NULL,
  `ConditionType` varchar(25) DEFAULT NULL,
  `StartPrice` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `PrimaryCategory` int(10) NOT NULL,
  `PrimaryCategoryName` varchar(128) NOT NULL,
  `SecondaryCategory` int(10) NOT NULL,
  `SecondaryCategoryName` varchar(128) NOT NULL,
  `StoreCategory` bigint(11) DEFAULT 0,
  `ListingType` enum('classic','buyItNow','shopProduct') NOT NULL DEFAULT 'buyItNow',
  `ListingDuration` varchar(10) DEFAULT '1',
  `noIdentifierFlag` enum('0','1','2') NOT NULL DEFAULT '0',
  `BestOfferEnabled` enum('0','1') DEFAULT '0',
  `PaymentMethods` longtext NOT NULL,
  `ShippingServiceOptions` longtext NOT NULL,
  `Features` text NOT NULL,
  `FSK` tinyint(4) NOT NULL DEFAULT -1,
  `USK` tinyint(4) NOT NULL DEFAULT -1,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  `Transferred` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `deletedBy` enum('','empty','Sync','Button','expired','notML') NOT NULL,
  `topPrimaryCategory` varchar(64) NOT NULL,
  `topSecondaryCategory` varchar(64) NOT NULL,
  `StoreCategory2` bigint(11) DEFAULT NULL,
  `StoreCategory3` bigint(20) NOT NULL DEFAULT 0,
  `Manufacturer` varchar(200) DEFAULT NULL,
  `ManufacturerPartNumber` varchar(200) NOT NULL DEFAULT '',
  UNIQUE KEY `UniqueEntry` (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_idealo_properties`;
CREATE TABLE `magnalister_idealo_properties` (
  `mpID` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `PictureUrl` text DEFAULT NULL,
  `Checkout` varchar(20) DEFAULT NULL,
  `PaymentMethod` varchar(124) DEFAULT NULL,
  `ShippingMethod` varchar(124) DEFAULT NULL,
  `ShippingCountry` varchar(124) DEFAULT NULL,
  `ShippingCostMethod` varchar(20) DEFAULT NULL,
  `ShippingCost` decimal(15,4) DEFAULT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `DeliveryTimeSource` varchar(127) DEFAULT '',
  `DeliveryTime` varchar(31) DEFAULT '',
  `FulFillmentType` varchar(31) DEFAULT '',
  `TwoManHandlingFee` varchar(16) DEFAULT '0.00',
  `DisposalFee` varchar(16) DEFAULT '0.00',
  PRIMARY KEY (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_images`;
CREATE TABLE `magnalister_images` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `variation_id` int(11) DEFAULT NULL,
  `image_nr` smallint(6) NOT NULL DEFAULT 0,
  `image_name` varchar(254) NOT NULL DEFAULT '',
  PRIMARY KEY (`image_id`),
  KEY `magnalister_images_products_id` (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_magnacompat_categories`;
CREATE TABLE `magnalister_magnacompat_categories` (
  `mpID` int(11) NOT NULL,
  `platform` varchar(30) NOT NULL,
  `CategoryID` varchar(200) NOT NULL,
  `CategoryName` varchar(128) NOT NULL DEFAULT '',
  `ParentID` varchar(200) NOT NULL,
  `CategoryPath` text NOT NULL,
  `LeafCategory` enum('0','1') NOT NULL DEFAULT '0',
  `Selectable` enum('0','1') NOT NULL,
  `Fee` decimal(12,4) NOT NULL,
  `FeeCurrency` varchar(3) NOT NULL,
  `InsertTimestamp` datetime NOT NULL,
  UNIQUE KEY `UniqueEntry` (`mpID`,`platform`,`CategoryID`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_magnacompat_categorymatching`;
CREATE TABLE `magnalister_magnacompat_categorymatching` (
  `mpID` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `mp_category_id` varchar(255) NOT NULL,
  `store_category_id` varchar(255) NOT NULL,
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `UniqueEntry` (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_magnacompat_deletedlog`;
CREATE TABLE `magnalister_magnacompat_deletedlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `products_id` int(11) unsigned NOT NULL,
  `products_model` varchar(64) DEFAULT NULL,
  `mpID` int(8) unsigned NOT NULL,
  `old_price` decimal(15,4) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_magnacompat_errorlog`;
CREATE TABLE `magnalister_magnacompat_errorlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mpID` int(8) unsigned NOT NULL,
  `BatchId` int(11) DEFAULT NULL,
  `origin` varchar(50) NOT NULL,
  `dateadded` datetime NOT NULL,
  `errormessage` text NOT NULL,
  `recommendation` text DEFAULT NULL,
  `additionaldata` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_meinpaket_categorymatching`;
CREATE TABLE `magnalister_meinpaket_categorymatching` (
  `mpID` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `mp_category_id` varchar(30) NOT NULL,
  `store_category_id` varchar(255) NOT NULL,
  UNIQUE KEY `UniqueEntry` (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_meinpaket_errorlog`;
CREATE TABLE `magnalister_meinpaket_errorlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mpID` int(8) unsigned NOT NULL,
  `dateadded` datetime NOT NULL,
  `errormessage` text NOT NULL,
  `additionaldata` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_meinpaket_properties`;
CREATE TABLE `magnalister_meinpaket_properties` (
  `mpID` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `MarketplaceCategory` varchar(30) NOT NULL DEFAULT '',
  `StoreCategory` varchar(255) NOT NULL DEFAULT '',
  `VariationConfiguration` varchar(255) NOT NULL DEFAULT '',
  `ShippingDetails` tinytext NOT NULL,
  `CategoryAttributes` text NOT NULL DEFAULT '',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OK',
  `variation_theme` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`mpID`,`products_id`,`products_model`),
  KEY `mpID` (`mpID`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_meinpaket_variantmatching`;
CREATE TABLE `magnalister_meinpaket_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_metro_categories`;
CREATE TABLE `magnalister_metro_categories` (
  `mpID` int(11) NOT NULL,
  `platform` varchar(30) NOT NULL,
  `CategoryID` varchar(64) NOT NULL,
  `CategoryName` varchar(128) NOT NULL DEFAULT '',
  `ParentID` varchar(64) NOT NULL,
  `LeafCategory` enum('0','1') NOT NULL DEFAULT '0',
  `Selectable` enum('0','1') NOT NULL DEFAULT '1',
  `InsertTimestamp` datetime NOT NULL,
  `Language` varchar(5) NOT NULL,
  `Fee` float DEFAULT NULL,
  `FeeCurrency` varchar(5) DEFAULT NULL,
  UNIQUE KEY `UniqueEntry` (`CategoryID`,`CategoryName`,`ParentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_metro_prepare`;
CREATE TABLE `magnalister_metro_prepare` (
  `mpID` int(11) unsigned NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `PreparedTS` datetime NOT NULL,
  `StartTime` datetime DEFAULT NULL,
  `Title` varchar(256) DEFAULT NULL,
  `Manufacturer` varchar(55) DEFAULT NULL,
  `ManufacturerPartNumber` varchar(55) DEFAULT NULL,
  `ShortDescription` text DEFAULT NULL,
  `GTIN` varchar(15) DEFAULT NULL,
  `Brand` varchar(255) DEFAULT NULL,
  `Feature` text DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `Images` text DEFAULT NULL,
  `MSRP` decimal(15,4) DEFAULT NULL,
  `PrimaryCategory` varchar(50) DEFAULT NULL,
  `PrimaryCategoryName` varchar(128) DEFAULT NULL,
  `ShopVariation` mediumtext DEFAULT NULL,
  `VariationThemeBlacklist` text DEFAULT NULL,
  `Features` text NOT NULL,
  `ProcessingTime` int(4) NOT NULL,
  `MaxProcessingTime` int(4) NOT NULL,
  `FreightForwarding` enum('true','false') NOT NULL,
  `ShippingProfile` int(4) NOT NULL,
  `BusinessModel` enum('','B2B','B2C') NOT NULL DEFAULT '',
  `noidentifierflag` varchar(10) NOT NULL,
  `Verified` enum('OK','ERROR','OPEN') NOT NULL,
  `Transferred` int(1) NOT NULL,
  `deletedBy` enum('empty','Sync','Button','expired','notML') NOT NULL,
  `topPrimaryCategory` varchar(64) NOT NULL,
  UNIQUE KEY `UniqueEntry` (`mpID`,`products_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_metro_properties`;
CREATE TABLE `magnalister_metro_properties` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `ShippingService` int(16) NOT NULL,
  `MarketplaceCategories` text NOT NULL,
  `topMarketplaceCategory` int(16) NOT NULL,
  `StoreCategories` text NOT NULL,
  `topStoreCategory` int(16) NOT NULL,
  `ListingDuration` tinyint(4) NOT NULL,
  `ProductType` int(11) NOT NULL DEFAULT 0,
  `ReturnPolicy` int(11) NOT NULL DEFAULT 0,
  `MpColors` text NOT NULL,
  `Attributes` longtext NOT NULL,
  `CategoryAttributes` text NOT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  UNIQUE KEY `U_PRODUCT_ID` (`mpID`,`products_id`,`products_model`) USING BTREE,
  KEY `mpID` (`mpID`) USING BTREE,
  KEY `products_id` (`products_id`) USING BTREE,
  KEY `products_model` (`products_model`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_metro_variantmatching`;
CREATE TABLE `magnalister_metro_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL,
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_orders`;
CREATE TABLE `magnalister_orders` (
  `orders_id` int(11) NOT NULL,
  `orders_status` int(11) NOT NULL,
  `mpID` int(8) unsigned NOT NULL,
  `platform` varchar(20) NOT NULL,
  `data` text NOT NULL,
  `internaldata` longtext NOT NULL,
  `special` text DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `platform` (`platform`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_otto_categories_marketplace`;
CREATE TABLE `magnalister_otto_categories_marketplace` (
  `CategoryID` varchar(64) NOT NULL,
  `CategoryName` varchar(128) NOT NULL DEFAULT '',
  `ParentID` varchar(64) NOT NULL,
  `LeafCategory` tinyint(4) NOT NULL DEFAULT 0,
  `Expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_otto_prepare`;
CREATE TABLE `magnalister_otto_prepare` (
  `mpID` int(11) unsigned NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `PreparedTS` datetime NOT NULL,
  `StartTime` datetime DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `Images` text DEFAULT NULL,
  `PrimaryCategory` varchar(50) DEFAULT NULL,
  `PrimaryCategoryName` varchar(128) DEFAULT NULL,
  `ShopVariation` mediumtext DEFAULT NULL,
  `CategoryIndependentShopVariation` text DEFAULT NULL,
  `VariationThemeBlacklist` text DEFAULT NULL,
  `DeliveryType` enum('PARCEL','FORWARDER_PREFERREDLOCATION','FORWARDER_CURBSIDE') NOT NULL,
  `DeliveryTime` tinyint(4) NOT NULL,
  `noidentifierflag` varchar(10) NOT NULL,
  `Verified` enum('OK','ERROR','OPEN') NOT NULL,
  `Transferred` int(1) NOT NULL,
  `deletedBy` enum('empty','Sync','Button','expired','notML') NOT NULL,
  `topPrimaryCategory` varchar(64) NOT NULL,
  UNIQUE KEY `UniqueEntry` (`mpID`,`products_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_otto_variantmatching`;
CREATE TABLE `magnalister_otto_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL,
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_priceminister_prepare`;
CREATE TABLE `magnalister_priceminister_prepare` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `EAN` varchar(13) DEFAULT NULL,
  `MarketplaceCategoriesName` text DEFAULT NULL,
  `MarketplaceCategories` varchar(50) DEFAULT NULL,
  `TopMarketplaceCategory` varchar(50) DEFAULT NULL,
  `CategoryAttributes` text NOT NULL,
  `Title` varchar(200) DEFAULT NULL,
  `Description` varchar(4096) DEFAULT NULL,
  `PictureUrl` text DEFAULT NULL,
  `ConditionType` varchar(60) DEFAULT NULL,
  `PrepareType` enum('Apply','Match') NOT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OK',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `MPProductId` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`mpID`,`products_id`,`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_priceminister_variantmatching`;
CREATE TABLE `magnalister_priceminister_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_ricardo_properties`;
CREATE TABLE `magnalister_ricardo_properties` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `MarketplaceCategories` text NOT NULL,
  `TopMarketplaceCategory` varchar(20) NOT NULL,
  `TitleDe` varchar(40) DEFAULT NULL,
  `TitleFr` varchar(40) DEFAULT NULL,
  `SubtitleDe` varchar(60) DEFAULT NULL,
  `SubtitleFr` varchar(60) DEFAULT NULL,
  `DescriptionDe` text DEFAULT NULL,
  `DescriptionFr` text DEFAULT NULL,
  `PictureUrl` text DEFAULT NULL,
  `DescriptionTemplate` tinyint(4) DEFAULT NULL,
  `ArticleCondition` tinyint(4) DEFAULT NULL,
  `BuyingMode` char(10) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndTime` time DEFAULT NULL,
  `Duration` tinyint(4) DEFAULT NULL,
  `MaxRelistCount` int(11) DEFAULT NULL,
  `Warranty` bit(1) DEFAULT NULL,
  `WarrantyDescriptionDe` text DEFAULT NULL,
  `WarrantyDescriptionFr` text DEFAULT NULL,
  `PaymentDetails` varchar(25) DEFAULT NULL,
  `PaymentdetailsDescriptionDe` text DEFAULT NULL,
  `PaymentdetailsDescriptionFr` text DEFAULT NULL,
  `ShippingDetails` tinyint(4) DEFAULT NULL,
  `ShippingCost` decimal(15,4) DEFAULT NULL,
  `PackageSize` tinyint(4) DEFAULT NULL,
  `ShippingCumulative` enum('true','false') DEFAULT NULL,
  `ShippingDescriptionDe` text DEFAULT NULL,
  `ShippingDescriptionFr` text DEFAULT NULL,
  `BuyNowPrice` decimal(15,4) DEFAULT NULL,
  `EnableBuyNowPrice` varchar(3) DEFAULT NULL,
  `StartPrice` decimal(15,4) DEFAULT NULL,
  `Increment` decimal(15,4) DEFAULT NULL,
  `Availability` tinyint(4) DEFAULT NULL,
  `FirstPromotion` smallint(6) DEFAULT NULL,
  `SecondPromotion` smallint(6) DEFAULT NULL,
  `LangDe` varchar(20) DEFAULT NULL,
  `LangFr` varchar(20) DEFAULT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OPEN',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`mpID`,`products_id`,`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_selection`;
CREATE TABLE `magnalister_selection` (
  `pID` int(10) unsigned NOT NULL,
  `mpID` int(8) unsigned NOT NULL,
  `data` text NOT NULL,
  `selectionname` varchar(50) NOT NULL,
  `session_id` varchar(128) NOT NULL,
  `expires` datetime NOT NULL,
  UNIQUE KEY `selection` (`pID`,`mpID`,`selectionname`,`session_id`),
  KEY `expires` (`expires`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_selection_templates`;
CREATE TABLE `magnalister_selection_templates` (
  `tID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `mpID` int(8) unsigned NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`tID`),
  KEY `title` (`title`,`mpID`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_selection_template_entries`;
CREATE TABLE `magnalister_selection_template_entries` (
  `tID` int(11) unsigned NOT NULL,
  `pID` int(10) unsigned NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `data` text NOT NULL,
  UNIQUE KEY `entry` (`tID`,`pID`,`products_model`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_session`;
CREATE TABLE `magnalister_session` (
  `session_id` varchar(128) NOT NULL,
  `data` longblob NOT NULL,
  `expire` int(11) unsigned NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_tecdoc`;
CREATE TABLE `magnalister_tecdoc` (
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `KType` int(11) unsigned NOT NULL DEFAULT 0,
  `CompatibilityNotes` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`products_id`,`products_model`,`KType`),
  KEY `products_id` (`products_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_tradoria_prepare`;
CREATE TABLE `magnalister_tradoria_prepare` (
  `mpID` int(8) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(64) NOT NULL,
  `EAN` varchar(13) DEFAULT NULL,
  `MarketplaceCategoriesName` text DEFAULT NULL,
  `PrimaryCategory` varchar(30) DEFAULT NULL,
  `TopMarketplaceCategory` varchar(30) DEFAULT NULL,
  `CategoryAttributes` text NOT NULL,
  `PrepareType` enum('Apply','Match') NOT NULL,
  `Verified` enum('OK','ERROR','OPEN','EMPTY') NOT NULL DEFAULT 'OK',
  `PreparedTS` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`mpID`,`products_id`,`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_tradoria_variantmatching`;
CREATE TABLE `magnalister_tradoria_variantmatching` (
  `MpId` int(11) NOT NULL,
  `MpIdentifier` varchar(50) NOT NULL,
  `CustomIdentifier` varchar(64) NOT NULL DEFAULT '',
  `ShopVariation` mediumtext NOT NULL,
  `IsValid` bit(1) NOT NULL DEFAULT b'1',
  `ModificationDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MpId`,`MpIdentifier`,`CustomIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `magnalister_variations`;
CREATE TABLE `magnalister_variations` (
  `variation_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `products_sku` varchar(150) DEFAULT NULL,
  `marketplace_id` varchar(63) NOT NULL DEFAULT 'ML',
  `marketplace_sku` varchar(150) DEFAULT NULL,
  `variation_products_model` varchar(150) DEFAULT NULL,
  `variation_ean` varchar(128) DEFAULT NULL,
  `variation_attributes` varchar(63) NOT NULL,
  `variation_attributes_text` text DEFAULT NULL,
  `variation_quantity` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `variation_status` enum('0','1') DEFAULT '1',
  `variation_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `variation_weight` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `variation_shipping_time` int(2) NOT NULL DEFAULT 1,
  `variation_volume` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `variation_unit_of_measure` varchar(15) NOT NULL DEFAULT '',
  `date_added` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  PRIMARY KEY (`variation_id`),
  UNIQUE KEY `products_id_variation_attributes` (`products_id`,`variation_attributes`),
  KEY `variation_attributes` (`variation_attributes`),
  KEY `products_id` (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_yatego_categories`;
CREATE TABLE `magnalister_yatego_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title_h` varchar(50) NOT NULL,
  `title_m` varchar(50) NOT NULL,
  `title_l` varchar(50) NOT NULL,
  `object_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `magnalister_yatego_categorymatching`;
CREATE TABLE `magnalister_yatego_categorymatching` (
  `mpID` int(8) unsigned NOT NULL,
  `category_id` int(11) NOT NULL,
  `yatego_category_id` varchar(20) NOT NULL,
  KEY `category_id` (`category_id`,`yatego_category_id`),
  KEY `mpID` (`mpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_block`;
CREATE TABLE `mailbeez_block` (
  `autoemail_id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `customers_id` bigint(20) NOT NULL DEFAULT 0,
  `date_block` datetime NOT NULL,
  `simulation` int(11) NOT NULL,
  `source` int(11) DEFAULT 0,
  PRIMARY KEY (`autoemail_id`),
  KEY `customers_id` (`customers_id`,`module`(20)),
  KEY `simulation` (`simulation`),
  KEY `module` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_bounces`;
CREATE TABLE `mailbeez_bounces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `autoemail_id` int(11) NOT NULL,
  `customers_email` varchar(96) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `module` varchar(255) NOT NULL,
  `date_bounce` datetime NOT NULL,
  `bounce_type` varchar(1) DEFAULT NULL,
  `reference` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `autoemail_id` (`autoemail_id`),
  KEY `customers_id` (`customers_id`),
  KEY `customers_email` (`customers_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_bounces_msg_log`;
CREATE TABLE `mailbeez_bounces_msg_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `autoemail_id` int(11) NOT NULL,
  `bounce_msg` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `autoemail_id` (`autoemail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_event_log`;
CREATE TABLE `mailbeez_event_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type` varchar(255) NOT NULL,
  `log_entry` text DEFAULT NULL,
  `batch_id` int(11) NOT NULL,
  `module` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `result` varchar(255) NOT NULL,
  `parameters` text DEFAULT NULL,
  `log_date` datetime NOT NULL,
  `query_string` text DEFAULT NULL,
  `simulation` int(11) NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `module` (`module`),
  KEY `batch_id` (`batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_module_configuration`;
CREATE TABLE `mailbeez_module_configuration` (
  `cfg_id` int(11) NOT NULL AUTO_INCREMENT,
  `cfg_key` varchar(255) DEFAULT NULL,
  `cfg_value` text DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`cfg_id`),
  KEY `cfg_key` (`cfg_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_notifications`;
CREATE TABLE `mailbeez_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `notification_summary` varchar(255) DEFAULT NULL,
  `notification` text DEFAULT NULL,
  `link` text DEFAULT NULL,
  `ref` int(11) NOT NULL,
  `iteration` int(11) DEFAULT NULL,
  `module` varchar(255) DEFAULT NULL,
  `customers_id` int(11) DEFAULT NULL,
  `channel_id` int(2) DEFAULT NULL,
  `severity` int(1) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `icon_style` varchar(255) DEFAULT NULL,
  `link_type` varchar(1) DEFAULT NULL,
  `panel_click_action` varchar(1) DEFAULT NULL,
  `notification_only` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ref` (`ref`,`customers_id`,`iteration`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_opens_log`;
CREATE TABLE `mailbeez_opens_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`),
  KEY `user_agent` (`user_agent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_process`;
CREATE TABLE `mailbeez_process` (
  `lock_id` int(11) NOT NULL AUTO_INCREMENT,
  `lock_key` varchar(255) DEFAULT NULL,
  `lock_value` text DEFAULT NULL,
  `batch_id` int(11) NOT NULL,
  `worker_id` int(32) DEFAULT 1,
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`lock_id`),
  KEY `lock_key` (`lock_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_shrtnr_idx`;
CREATE TABLE `mailbeez_shrtnr_idx` (
  `token` varchar(32) NOT NULL,
  `shrtnr_value` text DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_read` datetime DEFAULT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_tracking`;
CREATE TABLE `mailbeez_tracking` (
  `autoemail_id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `iteration` int(11) NOT NULL,
  `customers_id` bigint(20) NOT NULL DEFAULT 0,
  `customers_email` varchar(96) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `date_sent` datetime NOT NULL,
  `simulation` int(11) NOT NULL,
  `channel` varchar(10) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `opened` datetime DEFAULT NULL,
  `clicked` datetime DEFAULT NULL,
  `ordered` datetime DEFAULT NULL,
  `bounce_status` varchar(1) DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `coupon_redeemed` int(5) NOT NULL DEFAULT 0,
  `mobile` int(1) DEFAULT 0,
  PRIMARY KEY (`autoemail_id`),
  KEY `customers_id` (`customers_id`,`iteration`,`module`(25)),
  KEY `simulation` (`simulation`),
  KEY `channel` (`channel`),
  KEY `batch_id` (`batch_id`),
  KEY `message_id` (`message_id`),
  KEY `module` (`module`),
  KEY `mobile` (`mobile`),
  KEY `ordered` (`ordered`),
  KEY `customers_email_bounce_status` (`customers_email`,`bounce_status`),
  KEY `date_sent` (`date_sent`),
  KEY `iteration` (`iteration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_tracking_clicks`;
CREATE TABLE `mailbeez_tracking_clicks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` varchar(255) NOT NULL,
  `date_record` datetime NOT NULL,
  `url` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mailbeez_tracking_orders`;
CREATE TABLE `mailbeez_tracking_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` varchar(255) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `date_record` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `manufacturers`;
CREATE TABLE `manufacturers` (
  `manufacturers_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturers_name` varchar(64) NOT NULL DEFAULT '',
  `manufacturers_image` varchar(255) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `amparex_name` varchar(255) NOT NULL DEFAULT '',
  `top5` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `top30` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `category_id` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `content_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`manufacturers_id`),
  KEY `IDX_MANUFACTURERS_NAME` (`manufacturers_name`),
  KEY `manufacturers_id` (`manufacturers_id`,`manufacturers_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `manufacturers_info`;
CREATE TABLE `manufacturers_info` (
  `manufacturers_id` int(11) NOT NULL DEFAULT 0,
  `languages_id` int(11) NOT NULL DEFAULT 0,
  `manufacturers_meta_title` text NOT NULL,
  `manufacturers_meta_description` text NOT NULL,
  `manufacturers_meta_keywords` text NOT NULL,
  `manufacturers_url` varchar(255) NOT NULL DEFAULT '',
  `url_clicked` int(5) NOT NULL DEFAULT 0,
  `date_last_click` datetime DEFAULT NULL,
  PRIMARY KEY (`manufacturers_id`,`languages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `media_content`;
CREATE TABLE `media_content` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `old_filename` text NOT NULL,
  `new_filename` text NOT NULL,
  `file_comment` text NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mf_claims`;
CREATE TABLE `mf_claims` (
  `orderId` int(10) unsigned NOT NULL DEFAULT 0,
  `fileNumber` int(10) unsigned NOT NULL DEFAULT 0,
  `firstname` varchar(100) NOT NULL DEFAULT '',
  `lastname` varchar(100) NOT NULL DEFAULT '',
  `transmissionDate` int(10) unsigned NOT NULL DEFAULT 0,
  `statusCode` smallint(5) unsigned NOT NULL DEFAULT 0,
  `statusText` text NOT NULL,
  `statusDetails` text NOT NULL,
  `lastChange` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `orderId` (`orderId`,`fileNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mf_config`;
CREATE TABLE `mf_config` (
  `config_key` varchar(255) NOT NULL DEFAULT '',
  `config_value` varchar(255) NOT NULL DEFAULT '',
  KEY `config_name` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mf_errors`;
CREATE TABLE `mf_errors` (
  `errorId` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `errorText` text NOT NULL,
  `customerId` int(10) unsigned NOT NULL DEFAULT 0,
  `date` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`errorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mf_score_results`;
CREATE TABLE `mf_score_results` (
  `scoreId` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `customerId` int(10) unsigned NOT NULL DEFAULT 0,
  `score` decimal(2,1) NOT NULL DEFAULT 0.0,
  `explanation` text NOT NULL,
  `lastCheck` int(10) unsigned NOT NULL DEFAULT 0,
  `negativeEntryList` text NOT NULL,
  PRIMARY KEY (`scoreId`),
  UNIQUE KEY `customerId` (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mixxer_items_to_mixxxer_groups`;
CREATE TABLE `mixxer_items_to_mixxxer_groups` (
  `mi2mg_id` int(11) NOT NULL AUTO_INCREMENT,
  `mg_id` int(11) NOT NULL,
  `mi_id` int(11) NOT NULL,
  PRIMARY KEY (`mi2mg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mixxxer_comp_texts`;
CREATE TABLE `mixxxer_comp_texts` (
  `mict_id` int(11) NOT NULL AUTO_INCREMENT,
  `mi_comp_gr` varchar(50) NOT NULL,
  `mi_comp_gr_text` text NOT NULL,
  `language_id` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`mict_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mixxxer_customer_config`;
CREATE TABLE `mixxxer_customer_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL,
  `config_data` text NOT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mixxxer_groups`;
CREATE TABLE `mixxxer_groups` (
  `mg_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `mg_name` varchar(32) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `mg_sortorder` int(11) NOT NULL,
  `mg_multiselect` tinyint(4) NOT NULL,
  `mg_required` tinyint(4) NOT NULL,
  `mg_description` text NOT NULL,
  `mg_image` varchar(100) NOT NULL,
  `mg_comp_gr_ref` varchar(50) NOT NULL,
  `mg_comp_gr_only` varchar(50) NOT NULL,
  `mg_multiaccordion_open` tinyint(4) NOT NULL,
  `mg_maximum` int(11) NOT NULL,
  `mg_note` varchar(200) NOT NULL,
  `mg_volume` tinyint(1) NOT NULL,
  `mg_listgroup` varchar(100) NOT NULL,
  `mg_disp` varchar(20) NOT NULL,
  PRIMARY KEY (`mg_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mixxxer_items`;
CREATE TABLE `mixxxer_items` (
  `mi_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `mi_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `mi_sortorder` int(11) NOT NULL,
  `mi_description` text NOT NULL,
  `mi_image` varchar(200) NOT NULL,
  `mi_image_2` varchar(200) NOT NULL,
  `mi_maximum` int(11) NOT NULL,
  `mi_comp_gr` varchar(50) NOT NULL,
  `mi_comp_gr_ref` varchar(50) NOT NULL,
  `mi_comp_gr_only` varchar(50) NOT NULL,
  `mi_product` int(11) NOT NULL,
  `mi_free_val_1` varchar(50) NOT NULL,
  `mi_subgroup` varchar(100) NOT NULL,
  `mi_c_text` tinyint(1) NOT NULL,
  `mi_c_upload` tinyint(1) NOT NULL,
  `mi_free_val_1_unit` varchar(20) NOT NULL,
  `mi_free_val_1_factor` float NOT NULL,
  `mi_short_description` text NOT NULL,
  PRIMARY KEY (`mi_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mixxxer_items_active`;
CREATE TABLE `mixxxer_items_active` (
  `mia_id` int(11) NOT NULL AUTO_INCREMENT,
  `mia_mi_id` int(11) NOT NULL,
  `mia_products_id` int(11) NOT NULL,
  `mia_price` decimal(15,4) NOT NULL,
  `mia_price_special` varchar(50) NOT NULL,
  `mia_stock` float NOT NULL,
  `mia_checked` tinyint(4) NOT NULL,
  `mia_model` varchar(30) NOT NULL,
  `mia_sortorder` int(11) NOT NULL,
  `mia_weight` float NOT NULL,
  PRIMARY KEY (`mia_id`),
  KEY `mia_mi_id` (`mia_mi_id`),
  KEY `mia_products_id` (`mia_products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mixxxer_items_to_mixxxer_groups`;
CREATE TABLE `mixxxer_items_to_mixxxer_groups` (
  `mi2mg_id` int(11) NOT NULL AUTO_INCREMENT,
  `mg_id` int(11) NOT NULL,
  `mi_id` int(11) NOT NULL,
  PRIMARY KEY (`mi2mg_id`),
  KEY `mg_id` (`mg_id`),
  KEY `mi_id` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mixxxes`;
CREATE TABLE `mixxxes` (
  `mix_id` int(11) NOT NULL AUTO_INCREMENT,
  `mix_key` varchar(10) NOT NULL,
  `mix_name` varchar(100) NOT NULL,
  `mix_code` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mix_user` int(11) NOT NULL,
  `mix_archive` tinyint(1) NOT NULL,
  PRIMARY KEY (`mix_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mm_attr_profile`;
CREATE TABLE `mm_attr_profile` (
  `mia_id` int(11) NOT NULL AUTO_INCREMENT,
  `mia_mi_id` int(11) NOT NULL,
  `mia_products_id` varchar(50) NOT NULL,
  `mia_price` float NOT NULL,
  `mia_stock` float NOT NULL,
  `mia_checked` tinyint(4) NOT NULL,
  `mia_model` varchar(30) NOT NULL,
  `mia_sortorder` int(11) NOT NULL,
  `mia_weight` float NOT NULL,
  `mia_price_special` varchar(50) NOT NULL,
  PRIMARY KEY (`mia_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `mm_config`;
CREATE TABLE `mm_config` (
  `am_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `am_type` varchar(10) NOT NULL,
  `am_class` varchar(2) NOT NULL,
  `am_title` varchar(50) NOT NULL,
  `am_db_field` varchar(30) NOT NULL,
  `am_single_language` tinyint(1) NOT NULL,
  `am_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`am_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `module_newsletter`;
CREATE TABLE `module_newsletter` (
  `newsletter_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `bc` text NOT NULL,
  `cc` text NOT NULL,
  `date` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 0,
  `body` text NOT NULL,
  PRIMARY KEY (`newsletter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `module_newsletter_temp_1`;
CREATE TABLE `module_newsletter_temp_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `customers_status` int(11) NOT NULL DEFAULT 0,
  `customers_firstname` varchar(64) NOT NULL DEFAULT '',
  `customers_lastname` varchar(64) NOT NULL DEFAULT '',
  `customers_email_address` text NOT NULL,
  `mail_key` varchar(32) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `comment` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE `newsletters` (
  `newsletters_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `module` varchar(255) NOT NULL DEFAULT '',
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `date_sent` datetime DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `locked` int(1) DEFAULT 0,
  PRIMARY KEY (`newsletters_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `newsletters_history`;
CREATE TABLE `newsletters_history` (
  `news_hist_id` int(11) NOT NULL DEFAULT 0,
  `news_hist_cs` int(11) NOT NULL DEFAULT 0,
  `news_hist_cs_date_sent` date DEFAULT NULL,
  PRIMARY KEY (`news_hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `newsletter_recipients`;
CREATE TABLE `newsletter_recipients` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_email_address` varchar(96) NOT NULL DEFAULT '',
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `customers_status` int(5) NOT NULL DEFAULT 0,
  `customers_firstname` varchar(32) NOT NULL DEFAULT '',
  `customers_lastname` varchar(32) NOT NULL DEFAULT '',
  `mail_status` int(1) NOT NULL DEFAULT 0,
  `created_by_admin` int(11) NOT NULL DEFAULT 0,
  `mail_key` varchar(32) NOT NULL DEFAULT '',
  `ip_address` varchar(45) DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`mail_id`),
  KEY `customers_email_address` (`customers_email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orders_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  `customers_cid` varchar(32) DEFAULT NULL,
  `customers_vat_id` varchar(20) DEFAULT NULL,
  `customers_status` int(11) DEFAULT NULL,
  `customers_status_name` varchar(32) NOT NULL DEFAULT '',
  `customers_status_image` varchar(255) DEFAULT NULL,
  `customers_status_discount` decimal(4,2) DEFAULT NULL,
  `customers_name` varchar(64) NOT NULL DEFAULT '',
  `customers_firstname` varchar(64) NOT NULL DEFAULT '',
  `customers_lastname` varchar(64) NOT NULL DEFAULT '',
  `customers_gender` char(1) NOT NULL DEFAULT '',
  `customers_company` varchar(255) DEFAULT NULL,
  `customers_street_address` varchar(64) NOT NULL DEFAULT '',
  `customers_house_number` varchar(64) NOT NULL DEFAULT '',
  `customers_additional_info` varchar(255) NOT NULL DEFAULT '',
  `customers_suburb` varchar(32) DEFAULT NULL,
  `customers_city` varchar(32) NOT NULL DEFAULT '',
  `customers_postcode` varchar(10) NOT NULL DEFAULT '',
  `customers_state` varchar(32) DEFAULT NULL,
  `customers_country` varchar(64) NOT NULL DEFAULT '',
  `customers_telephone` varchar(32) NOT NULL DEFAULT '',
  `customers_email_address` varchar(96) NOT NULL DEFAULT '',
  `customers_address_format_id` int(5) NOT NULL DEFAULT 5,
  `delivery_name` varchar(64) NOT NULL DEFAULT '',
  `delivery_firstname` varchar(64) NOT NULL DEFAULT '',
  `delivery_lastname` varchar(64) NOT NULL DEFAULT '',
  `delivery_gender` char(1) NOT NULL DEFAULT '',
  `delivery_company` varchar(255) DEFAULT NULL,
  `delivery_street_address` varchar(64) NOT NULL DEFAULT '',
  `delivery_house_number` varchar(64) NOT NULL DEFAULT '',
  `delivery_additional_info` varchar(255) NOT NULL DEFAULT '',
  `delivery_suburb` varchar(32) DEFAULT NULL,
  `delivery_city` varchar(32) NOT NULL DEFAULT '',
  `delivery_postcode` varchar(10) NOT NULL DEFAULT '',
  `delivery_state` varchar(32) DEFAULT NULL,
  `delivery_country` varchar(64) NOT NULL DEFAULT '',
  `delivery_country_iso_code_2` char(2) NOT NULL DEFAULT '',
  `delivery_address_format_id` int(5) NOT NULL DEFAULT 5,
  `billing_name` varchar(64) NOT NULL DEFAULT '',
  `billing_firstname` varchar(64) NOT NULL DEFAULT '',
  `billing_lastname` varchar(64) NOT NULL DEFAULT '',
  `billing_gender` char(1) NOT NULL DEFAULT '',
  `billing_company` varchar(255) DEFAULT NULL,
  `billing_street_address` varchar(64) NOT NULL DEFAULT '',
  `billing_house_number` varchar(64) NOT NULL DEFAULT '',
  `billing_additional_info` varchar(255) NOT NULL DEFAULT '',
  `billing_suburb` varchar(32) DEFAULT NULL,
  `billing_city` varchar(32) NOT NULL DEFAULT '',
  `billing_postcode` varchar(10) NOT NULL DEFAULT '',
  `billing_state` varchar(32) DEFAULT NULL,
  `billing_country` varchar(64) NOT NULL DEFAULT '',
  `billing_country_iso_code_2` char(2) NOT NULL DEFAULT '',
  `billing_address_format_id` int(5) NOT NULL DEFAULT 5,
  `payment_method` varchar(255) NOT NULL DEFAULT '',
  `cc_type` varchar(20) DEFAULT NULL,
  `cc_owner` varchar(64) DEFAULT NULL,
  `cc_number` varchar(64) DEFAULT NULL,
  `cc_expires` varchar(4) DEFAULT NULL,
  `cc_start` varchar(4) DEFAULT NULL,
  `cc_issue` char(3) DEFAULT NULL,
  `cc_cvv` varchar(4) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_purchased` datetime DEFAULT NULL,
  `orders_status` int(5) NOT NULL DEFAULT 0,
  `orders_date_finished` datetime DEFAULT NULL,
  `currency` char(3) DEFAULT NULL,
  `currency_value` decimal(13,8) DEFAULT NULL,
  `account_type` int(1) NOT NULL DEFAULT 0,
  `payment_class` varchar(255) NOT NULL DEFAULT '',
  `shipping_method` varchar(255) NOT NULL DEFAULT '',
  `shipping_class` varchar(255) NOT NULL DEFAULT '',
  `order_total_weight` double(11,4) DEFAULT NULL,
  `customers_ip` varchar(39) NOT NULL DEFAULT '',
  `language` varchar(32) NOT NULL DEFAULT '',
  `afterbuy_success` int(1) NOT NULL DEFAULT 0,
  `afterbuy_id` int(32) NOT NULL DEFAULT 0,
  `refferers_id` varchar(32) NOT NULL DEFAULT '',
  `conversion_type` int(1) NOT NULL DEFAULT 0,
  `orders_ident_key` varchar(128) DEFAULT NULL,
  `gm_order_html` mediumtext DEFAULT NULL,
  `gm_order_txt` mediumtext DEFAULT NULL,
  `gm_order_send_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `gm_send_order_status` int(1) NOT NULL DEFAULT 0,
  `gm_cancel_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `abandonment_download` tinyint(1) NOT NULL DEFAULT 0,
  `abandonment_service` tinyint(1) NOT NULL DEFAULT 0,
  `orders_hash` varchar(32) NOT NULL DEFAULT '',
  `exported` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'already exported to WaWi?',
  `gambio_hub_module` varchar(32) NOT NULL DEFAULT '',
  `gambio_hub_module_title` varchar(255) NOT NULL DEFAULT '',
  `gambio_hub_transaction_code` varchar(64) NOT NULL DEFAULT '',
  `gambio_hub_transaction_mode` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`orders_id`),
  UNIQUE KEY `date_purchased_orders_id` (`date_purchased`,`orders_id`),
  KEY `orders_status` (`orders_status`),
  KEY `date_purchased` (`date_purchased`),
  KEY `customers_id` (`customers_id`,`orders_id`),
  KEY `customers_status_index` (`customers_status`,`customers_status_name`),
  KEY `delivery_country_index` (`delivery_country_iso_code_2`,`delivery_country`),
  KEY `shipping_class` (`shipping_class`),
  KEY `gambio_hub_payment_index` (`payment_class`,`gambio_hub_module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_hermes`;
CREATE TABLE `orders_hermes` (
  `orderno` varchar(255) NOT NULL DEFAULT '',
  `order_type` enum('props','prips') NOT NULL DEFAULT 'props',
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `receiver_firstname` varchar(25) DEFAULT NULL,
  `receiver_lastname` varchar(25) NOT NULL DEFAULT '',
  `receiver_street` varchar(27) NOT NULL DEFAULT '',
  `receiver_housenumber` varchar(5) DEFAULT NULL,
  `receiver_addressadd` varchar(25) DEFAULT NULL,
  `receiver_postcode` varchar(25) NOT NULL DEFAULT '',
  `receiver_city` varchar(30) NOT NULL DEFAULT '',
  `receiver_district` varchar(25) DEFAULT NULL,
  `receiver_countrycode` varchar(3) NOT NULL DEFAULT '',
  `receiver_email` varchar(255) DEFAULT NULL,
  `receiver_telephonenumber` varchar(32) DEFAULT NULL,
  `receiver_telephoneprefix` varchar(25) DEFAULT NULL,
  `clientreferencenumber` varchar(255) DEFAULT NULL,
  `parcelclass` varchar(255) DEFAULT NULL,
  `amountcashondeliveryeurocent` int(11) NOT NULL DEFAULT 0,
  `state` enum('not_sent','sent','printed') NOT NULL DEFAULT 'not_sent',
  `shipping_id` varchar(255) DEFAULT NULL,
  `paket_shop_id` varchar(255) DEFAULT NULL,
  `hand_over_mode` varchar(255) DEFAULT NULL,
  `collection_desired_date` datetime DEFAULT NULL,
  PRIMARY KEY (`orderno`),
  KEY `order_id` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_iloxxdata`;
CREATE TABLE `orders_iloxxdata` (
  `orders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `parcelnumber` varchar(255) DEFAULT NULL,
  `service` varchar(255) NOT NULL DEFAULT '',
  `weight` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `shipdate` date DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `parcelnumber` (`parcelnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_parcel_tracking_codes`;
CREATE TABLE `orders_parcel_tracking_codes` (
  `orders_parcel_tracking_code_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tracking_code` varchar(255) NOT NULL DEFAULT '',
  `is_return_delivery` int(1) unsigned NOT NULL DEFAULT 0,
  `parcel_service_id` int(10) unsigned NOT NULL DEFAULT 0,
  `parcel_service_name` varchar(45) NOT NULL DEFAULT '',
  `language_id` int(10) unsigned NOT NULL DEFAULT 0,
  `url` varchar(1023) NOT NULL DEFAULT '',
  `comment` text NOT NULL,
  `shipment_type` varchar(255) NOT NULL DEFAULT '',
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`orders_parcel_tracking_code_id`),
  KEY `order_id` (`order_id`),
  KEY `tracking_code` (`tracking_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_payment_instruction`;
CREATE TABLE `orders_payment_instruction` (
  `orders_payment_instruction_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `reference` varchar(255) NOT NULL DEFAULT '',
  `bank_name` varchar(255) NOT NULL DEFAULT '',
  `account_holder` varchar(255) NOT NULL DEFAULT '',
  `iban` varchar(34) NOT NULL DEFAULT '',
  `bic` varchar(11) NOT NULL DEFAULT '',
  `value` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `currency` varchar(3) NOT NULL DEFAULT '',
  `due_date` date NOT NULL DEFAULT '1000-01-01',
  PRIMARY KEY (`orders_payment_instruction_id`),
  KEY `orders_id` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_paypal`;
CREATE TABLE `orders_paypal` (
  `orders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `correlation_id` varchar(255) DEFAULT NULL,
  `payer_id` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `paymentaction` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `correlation_id` (`correlation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_paypal_payments`;
CREATE TABLE `orders_paypal_payments` (
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `payment_id` varchar(48) NOT NULL DEFAULT '',
  `mode` varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`orders_id`,`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_products`;
CREATE TABLE `orders_products` (
  `orders_products_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `products_model` varchar(64) DEFAULT NULL,
  `products_name` varchar(255) NOT NULL DEFAULT '',
  `products_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_discount_made` decimal(4,2) DEFAULT NULL,
  `products_shipping_time` varchar(255) DEFAULT NULL,
  `final_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_tax` decimal(7,4) NOT NULL DEFAULT 0.0000,
  `products_quantity` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `allow_tax` int(1) NOT NULL DEFAULT 0,
  `product_type` int(11) NOT NULL DEFAULT 1,
  `properties_combi_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `properties_combi_model` varchar(64) NOT NULL DEFAULT '',
  `checkout_information` text DEFAULT NULL,
  PRIMARY KEY (`orders_products_id`),
  KEY `orders_id` (`orders_id`),
  KEY `products_id` (`products_id`,`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_products_attributes`;
CREATE TABLE `orders_products_attributes` (
  `orders_products_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `orders_products_id` int(11) NOT NULL DEFAULT 0,
  `products_options` varchar(255) NOT NULL DEFAULT '',
  `products_options_values` text DEFAULT NULL,
  `options_values_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `price_prefix` char(1) NOT NULL DEFAULT '',
  `options_id` int(11) NOT NULL DEFAULT 0,
  `options_values_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`orders_products_attributes_id`),
  KEY `orders_products_id` (`orders_products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_products_download`;
CREATE TABLE `orders_products_download` (
  `orders_products_download_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `orders_products_id` int(11) NOT NULL DEFAULT 0,
  `orders_products_filename` varchar(255) NOT NULL DEFAULT '',
  `download_maxdays` int(2) NOT NULL DEFAULT 0,
  `download_count` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`orders_products_download_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_products_parked`;
CREATE TABLE `orders_products_parked` (
  `orders_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  PRIMARY KEY (`orders_id`,`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_products_properties`;
CREATE TABLE `orders_products_properties` (
  `orders_products_properties_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orders_products_id` int(10) unsigned DEFAULT NULL,
  `products_properties_combis_id` int(10) unsigned DEFAULT NULL,
  `properties_name` varchar(255) NOT NULL DEFAULT '',
  `values_name` varchar(255) NOT NULL DEFAULT '',
  `properties_price_type` varchar(8) NOT NULL DEFAULT '',
  `properties_price` decimal(16,4) NOT NULL DEFAULT 0.0000,
  PRIMARY KEY (`orders_products_properties_id`),
  KEY `orders_products_id` (`orders_products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_products_quantity_units`;
CREATE TABLE `orders_products_quantity_units` (
  `orders_products_id` int(11) NOT NULL DEFAULT 0,
  `quantity_unit_id` int(11) NOT NULL DEFAULT 0,
  `unit_name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`orders_products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_products_to_coupons`;
CREATE TABLE `orders_products_to_coupons` (
  `orders_products_id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  UNIQUE KEY `orders_products_id` (`orders_products_id`,`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_products_transfer_needed`;
CREATE TABLE `orders_products_transfer_needed` (
  `orders_id` int(11) NOT NULL,
  `branch_id` varchar(255) NOT NULL,
  `products_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `target_branch_id` varchar(255) NOT NULL,
  PRIMARY KEY (`orders_id`,`branch_id`,`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_recalculate`;
CREATE TABLE `orders_recalculate` (
  `orders_recalculate_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `n_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `b_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `tax` decimal(19,8) NOT NULL DEFAULT 0.00000000,
  `tax_rate` decimal(7,4) NOT NULL DEFAULT 0.0000,
  `class` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`orders_recalculate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_shipping_options`;
CREATE TABLE `orders_shipping_options` (
  `orders_shipping_options_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `key` varchar(32) NOT NULL,
  `value` varchar(128) NOT NULL,
  PRIMARY KEY (`orders_shipping_options_id`),
  UNIQUE KEY `orders_id_idx` (`orders_id`,`key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_status`;
CREATE TABLE `orders_status` (
  `orders_status_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `orders_status_name` varchar(32) NOT NULL DEFAULT '',
  `color` char(6) NOT NULL DEFAULT '2196F3',
  PRIMARY KEY (`orders_status_id`,`language_id`),
  KEY `idx_orders_status_name` (`orders_status_name`),
  KEY `language_id_index` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_status_history`;
CREATE TABLE `orders_status_history` (
  `orders_status_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `orders_status_id` int(5) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `customer_notified` int(1) DEFAULT 0,
  `comments` text DEFAULT NULL,
  `customer_id` int(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`orders_status_history_id`),
  KEY `orders_id` (`orders_id`),
  KEY `orders_status_id` (`orders_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_tax_sum_items`;
CREATE TABLE `orders_tax_sum_items` (
  `orders_tax_sum_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_class` varchar(100) NOT NULL DEFAULT '',
  `tax_zone` varchar(100) NOT NULL DEFAULT '',
  `tax_rate` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `gross` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `net` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `tax` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `currency` varchar(100) NOT NULL DEFAULT '',
  `order_id` int(11) NOT NULL DEFAULT 0,
  `insert_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `last_change_datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tax_description` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`orders_tax_sum_item_id`),
  KEY `order_id` (`order_id`),
  KEY `insert_date` (`insert_date`,`tax_zone`,`tax_class`,`tax_rate`,`currency`),
  KEY `insert_date_2` (`insert_date`,`order_id`,`tax_zone`,`tax_class`,`tax_rate`,`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `orders_total`;
CREATE TABLE `orders_total` (
  `orders_total_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL DEFAULT '',
  `text` varchar(255) NOT NULL DEFAULT '',
  `value` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `class` varchar(32) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`orders_total_id`),
  KEY `idx_orders_total_orders_id` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `packing_slips`;
CREATE TABLE `packing_slips` (
  `packing_slip_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `order_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`packing_slip_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `parcel_services`;
CREATE TABLE `parcel_services` (
  `parcel_service_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `default` tinyint(4) NOT NULL DEFAULT 0,
  `shipment_type` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`parcel_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `parcel_services_description`;
CREATE TABLE `parcel_services_description` (
  `parcel_service_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `url` varchar(1023) NOT NULL DEFAULT '',
  `comment` text NOT NULL,
  PRIMARY KEY (`parcel_service_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payment_ipayment`;
CREATE TABLE `payment_ipayment` (
  `ip_BOOKNR` varchar(255) NOT NULL DEFAULT '',
  `ip_INFO` text NOT NULL,
  `ip_ORDERID` int(11) NOT NULL DEFAULT 0,
  `ip_IS_CAPTURED` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ip_BOOKNR`),
  KEY `ip_ORDERID` (`ip_ORDERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payment_ipayment_log`;
CREATE TABLE `payment_ipayment_log` (
  `ip_LOG_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_LOG_MESSAGE` varchar(255) NOT NULL DEFAULT '',
  `ip_LOG_INFO` text NOT NULL,
  `ip_LOG_DATE` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`ip_LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payment_qenta`;
CREATE TABLE `payment_qenta` (
  `q_TRID` varchar(255) NOT NULL DEFAULT '',
  `q_DATE` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `q_QTID` bigint(18) unsigned NOT NULL DEFAULT 0,
  `q_ORDERDESC` varchar(255) NOT NULL DEFAULT '',
  `q_STATUS` tinyint(1) NOT NULL DEFAULT 0,
  `q_ORDERID` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`q_TRID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payone_ac_cache`;
CREATE TABLE `payone_ac_cache` (
  `address_hash` varchar(32) NOT NULL DEFAULT '',
  `address_book_id` int(11) NOT NULL DEFAULT 0,
  `received` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `secstatus` int(11) NOT NULL DEFAULT 0,
  `status` varchar(7) NOT NULL DEFAULT '',
  `personstatus` varchar(4) NOT NULL DEFAULT '',
  `street` varchar(255) NOT NULL DEFAULT '',
  `streetname` varchar(255) NOT NULL DEFAULT '',
  `streetnumber` varchar(255) NOT NULL DEFAULT '',
  `zip` varchar(255) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `errorcode` varchar(255) NOT NULL DEFAULT '',
  `errormessage` text NOT NULL,
  `customermessage` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`address_hash`),
  KEY `address_book_id` (`address_book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payone_api_log`;
CREATE TABLE `payone_api_log` (
  `p1_api_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `log_count` int(11) NOT NULL DEFAULT 0,
  `log_level` int(11) NOT NULL DEFAULT 0,
  `message` mediumtext NOT NULL,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`p1_api_log_id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payone_clearingdata`;
CREATE TABLE `payone_clearingdata` (
  `p1_clearingdata_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `bankaccountholder` varchar(255) NOT NULL DEFAULT '',
  `bankcountry` varchar(2) NOT NULL DEFAULT '',
  `bankaccount` varchar(32) NOT NULL DEFAULT '',
  `bankcode` varchar(32) NOT NULL DEFAULT '',
  `bankiban` varchar(32) NOT NULL DEFAULT '',
  `bankbic` varchar(32) NOT NULL DEFAULT '',
  `bankcity` varchar(64) NOT NULL DEFAULT '',
  `bankname` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`p1_clearingdata_id`),
  KEY `orders_id` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payone_cr_cache`;
CREATE TABLE `payone_cr_cache` (
  `address_hash` varchar(32) NOT NULL DEFAULT '',
  `address_book_id` int(11) NOT NULL DEFAULT 0,
  `scoretype` varchar(2) NOT NULL DEFAULT '',
  `received` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `secstatus` int(11) NOT NULL DEFAULT 0,
  `status` varchar(7) NOT NULL DEFAULT '',
  `score` varchar(100) NOT NULL DEFAULT '',
  `scorevalue` varchar(100) NOT NULL DEFAULT '',
  `secscore` varchar(100) NOT NULL DEFAULT '',
  `personstatus` varchar(4) NOT NULL DEFAULT '',
  `firstname` varchar(255) NOT NULL DEFAULT '',
  `lastname` varchar(255) NOT NULL DEFAULT '',
  `street` varchar(255) NOT NULL DEFAULT '',
  `streetname` varchar(255) NOT NULL DEFAULT '',
  `streetnumber` varchar(255) NOT NULL DEFAULT '',
  `zip` varchar(255) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `errorcode` varchar(255) NOT NULL DEFAULT '',
  `errormessage` text NOT NULL,
  `customermessage` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`address_hash`),
  KEY `address_book_id` (`address_book_id`),
  KEY `scoretype` (`scoretype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payone_transactions`;
CREATE TABLE `payone_transactions` (
  `payone_transactions_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT '',
  `txid` varchar(100) NOT NULL DEFAULT '',
  `userid` varchar(100) NOT NULL DEFAULT '',
  `created` datetime DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`payone_transactions_id`),
  KEY `orders_id` (`orders_id`,`txid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payone_transactions_log`;
CREATE TABLE `payone_transactions_log` (
  `p1_transactions_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `log_count` int(11) NOT NULL DEFAULT 0,
  `log_level` int(11) NOT NULL DEFAULT 0,
  `message` mediumtext NOT NULL,
  `customers_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`p1_transactions_log_id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payone_txstatus`;
CREATE TABLE `payone_txstatus` (
  `payone_txstatus_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `received` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`payone_txstatus_id`),
  KEY `orders_id` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `payone_txstatus_data`;
CREATE TABLE `payone_txstatus_data` (
  `payone_txstatus_data_id` int(11) NOT NULL AUTO_INCREMENT,
  `payone_txstatus_id` int(11) NOT NULL DEFAULT 0,
  `key` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`payone_txstatus_data_id`),
  KEY `payone_txstatus_id` (`payone_txstatus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `paypal_paylink`;
CREATE TABLE `paypal_paylink` (
  `orders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `paycode` varchar(32) NOT NULL DEFAULT '',
  `amount` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `paycode` (`paycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `personal_offers_by_customers_status_`;
CREATE TABLE `personal_offers_by_customers_status_` (
  `price_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `quantity` decimal(15,4) DEFAULT NULL,
  `personal_offer` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `personal_offers_by_customers_status_0`;
CREATE TABLE `personal_offers_by_customers_status_0` (
  `price_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `quantity` decimal(15,4) DEFAULT NULL,
  `personal_offer` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`price_id`),
  UNIQUE KEY `unique_offer` (`products_id`,`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `personal_offers_by_customers_status_1`;
CREATE TABLE `personal_offers_by_customers_status_1` (
  `price_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `quantity` decimal(15,4) DEFAULT NULL,
  `personal_offer` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`price_id`),
  UNIQUE KEY `unique_offer` (`products_id`,`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `personal_offers_by_customers_status_2`;
CREATE TABLE `personal_offers_by_customers_status_2` (
  `price_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `quantity` decimal(15,4) DEFAULT NULL,
  `personal_offer` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`price_id`),
  UNIQUE KEY `unique_offer` (`products_id`,`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `personal_offers_by_customers_status_3`;
CREATE TABLE `personal_offers_by_customers_status_3` (
  `price_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `quantity` decimal(15,4) DEFAULT NULL,
  `personal_offer` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`price_id`),
  UNIQUE KEY `unique_offer` (`products_id`,`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `pricing`;
CREATE TABLE `pricing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `customers_status` int(11) NOT NULL,
  `price_without_tax` double NOT NULL,
  `price_incl_tax` double NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `products_id` (`products_id`,`customers_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `products_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_ean` varchar(128) DEFAULT NULL,
  `products_quantity` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_shippingtime` int(4) NOT NULL DEFAULT 0,
  `products_model` varchar(64) DEFAULT NULL,
  `group_permission_0` tinyint(1) NOT NULL DEFAULT 0,
  `group_permission_1` tinyint(1) NOT NULL DEFAULT 0,
  `group_permission_2` tinyint(1) NOT NULL DEFAULT 0,
  `group_permission_3` tinyint(1) NOT NULL DEFAULT 0,
  `products_sort` int(4) NOT NULL DEFAULT 0,
  `products_image` varchar(255) DEFAULT NULL,
  `products_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_discount_allowed` decimal(5,2) NOT NULL DEFAULT 0.00,
  `products_date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `products_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `products_date_available` datetime DEFAULT NULL,
  `products_weight` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_status` tinyint(1) NOT NULL DEFAULT 0,
  `products_tax_class_id` int(11) NOT NULL DEFAULT 0,
  `product_template` varchar(64) DEFAULT NULL,
  `options_template` varchar(64) DEFAULT NULL,
  `manufacturers_id` int(11) DEFAULT NULL,
  `products_ordered` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_fsk18` int(1) NOT NULL DEFAULT 0,
  `products_vpe` int(11) NOT NULL DEFAULT 0,
  `products_vpe_status` int(1) NOT NULL DEFAULT 0,
  `products_vpe_value` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_startpage` int(1) NOT NULL DEFAULT 0,
  `products_startpage_sort` int(4) NOT NULL DEFAULT 0,
  `group_ids` varchar(5) NOT NULL DEFAULT '',
  `nc_ultra_shipping_costs` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `gm_show_date_added` int(1) unsigned NOT NULL DEFAULT 0,
  `gm_show_price_offer` int(1) unsigned NOT NULL DEFAULT 0,
  `gm_show_weight` int(1) NOT NULL DEFAULT 0,
  `gm_price_status` int(10) unsigned NOT NULL DEFAULT 0,
  `gm_min_order` decimal(15,4) NOT NULL DEFAULT 1.0000,
  `gm_graduated_qty` decimal(15,4) NOT NULL DEFAULT 1.0000,
  `gm_options_template` varchar(64) DEFAULT NULL,
  `gm_priority` varchar(3) NOT NULL DEFAULT '0.5',
  `gm_changefreq` varchar(255) NOT NULL DEFAULT 'weekly',
  `gm_show_qty_info` int(1) unsigned NOT NULL DEFAULT 0,
  `gm_sitemap_entry` int(1) NOT NULL DEFAULT 1,
  `products_image_w` int(11) NOT NULL DEFAULT 0,
  `products_image_h` int(11) NOT NULL DEFAULT 0,
  `gm_show_image` int(1) unsigned NOT NULL DEFAULT 1,
  `properties_dropdown_mode` varchar(30) NOT NULL DEFAULT '',
  `properties_show_price` varchar(10) NOT NULL DEFAULT '',
  `use_properties_combis_weight` tinyint(1) NOT NULL DEFAULT 0,
  `use_properties_combis_quantity` tinyint(1) NOT NULL DEFAULT 0,
  `use_properties_combis_shipping_time` tinyint(1) NOT NULL DEFAULT 0,
  `product_type` tinyint(1) NOT NULL DEFAULT 1,
  `main_category_id` int(11) NOT NULL DEFAULT 0,
  `amparex_id` varchar(255) NOT NULL DEFAULT '',
  `products_master_mixxxer` tinyint(4) NOT NULL,
  `products_remixxx` tinyint(4) NOT NULL,
  `products_price_from_mixxx` tinyint(4) NOT NULL,
  `products_mix_id` int(11) NOT NULL,
  `products_max_values` varchar(100) NOT NULL,
  `products_price_base` varchar(50) NOT NULL,
  `products_is_mixxxer` tinyint(4) NOT NULL,
  `products_overwrite_name` tinyint(4) NOT NULL,
  `products_mixxxer_view_toggle` tinyint(4) NOT NULL,
  `products_mixxxer_default_view` tinyint(4) NOT NULL,
  `products_volume_price` float NOT NULL,
  `products_volume_unit` varchar(20) NOT NULL,
  `products_mixxxer_template` varchar(50) NOT NULL,
  `empfehlung` tinyint(1) NOT NULL DEFAULT 0,
  `bestseller` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`products_id`),
  KEY `idx_products_date_added` (`products_date_added`),
  KEY `products_id` (`products_id`,`products_status`,`products_date_added`),
  KEY `products_status` (`products_status`,`products_id`,`products_date_added`),
  KEY `products_status_2` (`products_status`,`products_id`,`products_price`),
  KEY `products_status_3` (`products_status`,`products_ordered`,`products_id`),
  KEY `products_status_4` (`products_status`,`products_model`,`products_id`),
  KEY `products_status_products_startpage` (`products_status`,`products_startpage`),
  KEY `products_id_2` (`products_id`,`products_startpage`,`products_status`,`products_startpage_sort`),
  KEY `products_date_available` (`products_date_available`,`products_id`),
  KEY `products_quantity` (`products_quantity`),
  KEY `products_sort` (`products_sort`),
  KEY `products_tax_class_id` (`products_tax_class_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `products_model` (`products_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_attributes`;
CREATE TABLE `products_attributes` (
  `products_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `options_id` int(11) NOT NULL DEFAULT 0,
  `options_values_id` int(11) NOT NULL DEFAULT 0,
  `options_values_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `price_prefix` char(1) NOT NULL DEFAULT '',
  `stock_type` varchar(16) DEFAULT 'not-managed',
  `attributes_model` varchar(64) NOT NULL DEFAULT '',
  `attributes_stock` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `options_values_weight` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `weight_prefix` char(1) NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`products_attributes_id`),
  KEY `products_id` (`products_id`,`options_id`,`options_values_id`,`sortorder`),
  KEY `options_values_id` (`options_values_id`),
  KEY `sortorder` (`sortorder`),
  FULLTEXT KEY `attributes_model` (`attributes_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_attributes_download`;
CREATE TABLE `products_attributes_download` (
  `products_attributes_id` int(11) NOT NULL DEFAULT 0,
  `products_attributes_filename` varchar(255) NOT NULL DEFAULT '',
  `products_attributes_maxdays` int(2) DEFAULT 0,
  `products_attributes_maxcount` int(2) DEFAULT 0,
  PRIMARY KEY (`products_attributes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_content`;
CREATE TABLE `products_content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `group_ids` text DEFAULT NULL,
  `content_name` varchar(32) NOT NULL DEFAULT '',
  `content_file` varchar(64) NOT NULL DEFAULT '',
  `content_link` text NOT NULL,
  `languages_id` int(11) NOT NULL DEFAULT 0,
  `content_read` int(11) NOT NULL DEFAULT 0,
  `file_comment` text NOT NULL,
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_description`;
CREATE TABLE `products_description` (
  `products_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `products_name` varchar(255) NOT NULL DEFAULT '',
  `products_description` text DEFAULT NULL,
  `products_short_description` text DEFAULT NULL,
  `products_keywords` varchar(255) DEFAULT NULL,
  `products_meta_title` text NOT NULL,
  `products_meta_description` text NOT NULL,
  `products_meta_keywords` text NOT NULL,
  `products_url` varchar(255) DEFAULT NULL,
  `products_viewed` int(5) DEFAULT 0,
  `gm_alt_text` varchar(255) DEFAULT NULL,
  `gm_url_keywords` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `checkout_information` text NOT NULL,
  PRIMARY KEY (`products_id`,`language_id`),
  KEY `products_name` (`products_name`),
  KEY `language_id` (`language_id`,`products_keywords`),
  KEY `language_id_2` (`language_id`,`products_name`),
  KEY `seo_boost_index` (`gm_url_keywords`,`products_id`,`language_id`),
  FULLTEXT KEY `products_name_2` (`products_name`),
  FULLTEXT KEY `products_description` (`products_description`),
  FULLTEXT KEY `products_short_description` (`products_short_description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_filter_config`;
CREATE TABLE `products_filter_config` (
  `pfc_id` int(11) NOT NULL AUTO_INCREMENT,
  `pfc_field_name` varchar(64) NOT NULL,
  `pfc_field_type` varchar(32) NOT NULL,
  PRIMARY KEY (`pfc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_filter_sort_order`;
CREATE TABLE `products_filter_sort_order` (
  `products_filter_key` varchar(64) NOT NULL,
  `products_filter_sort` int(11) NOT NULL,
  PRIMARY KEY (`products_filter_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_google_categories`;
CREATE TABLE `products_google_categories` (
  `products_google_categories_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) DEFAULT NULL,
  `google_category` text DEFAULT NULL,
  PRIMARY KEY (`products_google_categories_id`),
  KEY `products_id` (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_graduated_prices`;
CREATE TABLE `products_graduated_prices` (
  `products_id` int(11) NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `unitprice` decimal(15,4) NOT NULL DEFAULT 0.0000,
  KEY `products_id` (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_hermesoptions`;
CREATE TABLE `products_hermesoptions` (
  `products_id` int(11) NOT NULL DEFAULT 0,
  `min_pclass` enum('XS','S','M','L','XL','XXL') NOT NULL,
  PRIMARY KEY (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_images`;
CREATE TABLE `products_images` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `image_nr` smallint(6) NOT NULL DEFAULT 0,
  `image_name` varchar(255) NOT NULL DEFAULT '',
  `gm_show_image` int(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`image_id`),
  UNIQUE KEY `products_id` (`products_id`,`image_nr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_item_codes`;
CREATE TABLE `products_item_codes` (
  `products_id` int(11) NOT NULL DEFAULT 0,
  `code_isbn` varchar(128) DEFAULT NULL,
  `code_upc` varchar(128) DEFAULT NULL,
  `code_mpn` varchar(128) DEFAULT NULL,
  `code_jan` varchar(128) DEFAULT NULL,
  `google_export_condition_id` int(10) unsigned NOT NULL DEFAULT 1,
  `google_export_availability_id` int(10) unsigned NOT NULL DEFAULT 0,
  `brand_name` varchar(128) NOT NULL DEFAULT '',
  `identifier_exists` tinyint(1) NOT NULL DEFAULT 1,
  `gender` enum('','Herren','Damen','Unisex') NOT NULL DEFAULT '',
  `age_group` enum('','Erwachsene','Kinder') NOT NULL DEFAULT '',
  `expiration_date` date NOT NULL DEFAULT '1000-01-01',
  PRIMARY KEY (`products_id`),
  KEY `google_export_condition_id` (`google_export_condition_id`),
  KEY `brand_name` (`brand_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_options`;
CREATE TABLE `products_options` (
  `products_options_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `options_id` int(11) DEFAULT NULL COMMENT 'mirrors `properties`.`properties_id`',
  `products_options_name` varchar(255) NOT NULL DEFAULT '',
  `is_only_filter` tinyint(1) NOT NULL DEFAULT 0,
  `is_filter` tinyint(1) NOT NULL DEFAULT 0,
  `products_option_display_type` varchar(64) NOT NULL DEFAULT 'Dropdown',
  `admin_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'mirrors `properties_description`.`properties_admin_name`',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'mirrors `properties_description`.`description`',
  `sort_order` int(10) DEFAULT NULL COMMENT 'mirrors `properties`.`sort_order`',
  `filter_display` varchar(30) NOT NULL,
  `filter_consider_stock` tinyint(4) NOT NULL,
  `products_options_sortorder` int(11) NOT NULL,
  PRIMARY KEY (`products_options_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_options_values`;
CREATE TABLE `products_options_values` (
  `products_options_values_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `option_value_id` int(11) DEFAULT NULL COMMENT 'mirrors `properties_values`.`properties_values_id`',
  `products_options_values_name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'mirrors `properties_values_description`.`description`',
  `gm_filename` varchar(255) NOT NULL DEFAULT '',
  `sort_order` int(10) NOT NULL DEFAULT 0 COMMENT 'mirrors `properties_values`.`sort_order`',
  `value_model` varchar(64) NOT NULL DEFAULT '' COMMENT 'mirrors `properties_values`.`value_model`',
  `weight` decimal(9,4) NOT NULL DEFAULT 0.0000 COMMENT 'mirrors `properties_values`.`weight`',
  `value_price` decimal(9,4) NOT NULL DEFAULT 0.0000 COMMENT 'mirrors `properties_values`.`value_price`',
  `display_image` varchar(256) DEFAULT NULL COMMENT 'mirrors `properties_values`.`display_image`',
  `stock_type` varchar(32) NOT NULL DEFAULT 'not-managed' COMMENT 'mirrors `properties_values`.`stock_type`',
  `stock` decimal(9,4) NOT NULL DEFAULT 0.0000 COMMENT 'mirrors `properties_values`.`stock`',
  `stock_centrally_managed` int(1) NOT NULL DEFAULT 0 COMMENT 'mirrors `properties_values`.`stock_centrally_managed`',
  `selector_img` varchar(256) NOT NULL,
  `products_options_values_sortorder` int(11) NOT NULL DEFAULT 0,
  `mix_id` int(11) NOT NULL,
  PRIMARY KEY (`products_options_values_id`,`language_id`),
  KEY `products_options_values_name` (`products_options_values_name`,`language_id`),
  FULLTEXT KEY `products_options_values_name_2` (`products_options_values_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_options_values_to_products_options`;
CREATE TABLE `products_options_values_to_products_options` (
  `products_options_values_to_products_options_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_options_id` int(11) NOT NULL DEFAULT 0,
  `products_options_values_id` int(11) NOT NULL DEFAULT 0,
  `options_id` int(11) NOT NULL DEFAULT 0 COMMENT 'mirrors `properties`.`properties_id`',
  `option_value_id` int(11) NOT NULL DEFAULT 0 COMMENT 'mirrors `properties_values`.`properties_values_id`',
  PRIMARY KEY (`products_options_values_to_products_options_id`),
  KEY `products_options_id` (`products_options_id`),
  KEY `products_options_values_id` (`products_options_values_id`),
  KEY `products_options_id_2` (`products_options_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_properties_admin_select`;
CREATE TABLE `products_properties_admin_select` (
  `products_properties_admin_select_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `properties_id` int(11) NOT NULL DEFAULT 0,
  `properties_values_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`products_properties_admin_select_id`),
  UNIQUE KEY `unique_value_assignment` (`products_id`,`properties_values_id`),
  KEY `products_id` (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_properties_combis`;
CREATE TABLE `products_properties_combis` (
  `products_properties_combis_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `products_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `combi_model` varchar(64) NOT NULL DEFAULT '',
  `combi_ean` varchar(20) NOT NULL DEFAULT '',
  `stock_type` varchar(16) DEFAULT 'not-managed',
  `combi_quantity` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `combi_shipping_status_id` int(11) NOT NULL DEFAULT 0,
  `combi_weight` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `combi_weight_type` enum('calc','fix') DEFAULT NULL,
  `combi_price_type` enum('calc','fix') NOT NULL,
  `combi_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_vpe_id` int(11) DEFAULT 0,
  `vpe_value` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `gtin` varchar(64) DEFAULT NULL,
  `asin` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`products_properties_combis_id`),
  KEY `products_properties_combis_id` (`products_properties_combis_id`,`products_id`,`sort_order`),
  KEY `products_properties_combis_cheapest` (`products_id`,`combi_price`),
  KEY `products_id` (`products_id`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_properties_combis_defaults`;
CREATE TABLE `products_properties_combis_defaults` (
  `products_properties_combis_defaults_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `products_id` int(10) unsigned NOT NULL DEFAULT 0,
  `combi_ean` varchar(20) NOT NULL DEFAULT '',
  `combi_quantity` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `combi_shipping_status_id` int(11) NOT NULL DEFAULT 0,
  `combi_weight` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `combi_price_type` enum('calc','fix') NOT NULL,
  `combi_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `products_vpe_id` int(11) NOT NULL DEFAULT 0,
  `vpe_value` decimal(15,4) NOT NULL DEFAULT 0.0000,
  PRIMARY KEY (`products_properties_combis_defaults_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_properties_combis_values`;
CREATE TABLE `products_properties_combis_values` (
  `products_properties_combis_values_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `products_properties_combis_id` int(10) unsigned NOT NULL DEFAULT 0,
  `properties_values_id` int(10) unsigned DEFAULT NULL,
  `options_id` int(11) DEFAULT NULL COMMENT 'mirrors `properties`.`properties_id`',
  PRIMARY KEY (`products_properties_combis_values_id`),
  UNIQUE KEY `unique_value_assignment` (`products_properties_combis_id`,`properties_values_id`),
  KEY `products_properties_combis_values_id` (`products_properties_combis_values_id`,`products_properties_combis_id`,`properties_values_id`),
  KEY `products_properties_combis_id` (`products_properties_combis_id`,`properties_values_id`),
  KEY `properties_values_id` (`properties_values_id`,`products_properties_combis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_properties_index`;
CREATE TABLE `products_properties_index` (
  `products_id` int(10) NOT NULL DEFAULT 0,
  `language_id` int(10) NOT NULL DEFAULT 0,
  `properties_id` int(10) NOT NULL DEFAULT 0,
  `products_properties_combis_id` int(10) NOT NULL DEFAULT 0,
  `properties_values_id` int(10) NOT NULL DEFAULT 0,
  `properties_name` varchar(255) DEFAULT NULL,
  `properties_admin_name` varchar(255) NOT NULL DEFAULT '',
  `properties_sort_order` int(10) NOT NULL DEFAULT 0,
  `values_name` varchar(255) DEFAULT NULL,
  `values_price` decimal(9,4) NOT NULL DEFAULT 0.0000,
  `value_sort_order` int(10) DEFAULT NULL,
  PRIMARY KEY (`products_properties_combis_id`,`language_id`,`properties_values_id`),
  KEY `products_id` (`products_id`,`language_id`,`properties_id`),
  KEY `products_id_2` (`products_id`,`language_id`,`properties_values_id`,`products_properties_combis_id`),
  KEY `products_id_3` (`products_id`,`properties_values_id`,`properties_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_quantity_unit`;
CREATE TABLE `products_quantity_unit` (
  `products_id` int(11) NOT NULL DEFAULT 0,
  `quantity_unit_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_to_categories`;
CREATE TABLE `products_to_categories` (
  `products_id` int(11) NOT NULL DEFAULT 0,
  `categories_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`products_id`,`categories_id`),
  KEY `categories_id` (`categories_id`,`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_vpe`;
CREATE TABLE `products_vpe` (
  `products_vpe_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `products_vpe_name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`products_vpe_id`,`language_id`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_xsell`;
CREATE TABLE `products_xsell` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `products_id` int(10) unsigned NOT NULL DEFAULT 1,
  `products_xsell_grp_name_id` int(10) unsigned NOT NULL DEFAULT 1,
  `xsell_id` int(10) unsigned NOT NULL DEFAULT 1,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `products_id` (`products_id`,`xsell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `products_xsell_grp_name`;
CREATE TABLE `products_xsell_grp_name` (
  `products_xsell_grp_name_id` int(10) NOT NULL DEFAULT 0,
  `xsell_sort_order` int(10) NOT NULL DEFAULT 0,
  `language_id` smallint(6) NOT NULL DEFAULT 0,
  `groupname` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_contents`;
CREATE TABLE `product_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_content_customer_status`;
CREATE TABLE `product_content_customer_status` (
  `product_content_id` int(11) NOT NULL,
  `customer_status_id` int(11) NOT NULL,
  PRIMARY KEY (`product_content_id`,`customer_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_content_descriptions`;
CREATE TABLE `product_content_descriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_content_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `hits` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_content_id_language_id` (`product_content_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_content_products`;
CREATE TABLE `product_content_products` (
  `product_content_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`product_content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_content_resources`;
CREATE TABLE `product_content_resources` (
  `product_content_description_id` int(11) NOT NULL,
  `product_content_types_id` int(11) NOT NULL,
  `resource` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_content_description_id`,`product_content_types_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_content_types`;
CREATE TABLE `product_content_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_image_list`;
CREATE TABLE `product_image_list` (
  `product_image_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_image_list_name` varchar(255) NOT NULL,
  PRIMARY KEY (`product_image_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_image_list_attribute`;
CREATE TABLE `product_image_list_attribute` (
  `products_attributes_id` int(11) NOT NULL,
  `product_image_list_id` int(11) NOT NULL,
  PRIMARY KEY (`products_attributes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_image_list_combi`;
CREATE TABLE `product_image_list_combi` (
  `products_properties_combis_id` int(11) NOT NULL,
  `product_image_list_id` int(11) NOT NULL,
  PRIMARY KEY (`products_properties_combis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_image_list_image`;
CREATE TABLE `product_image_list_image` (
  `product_image_list_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_image_list_id` int(11) NOT NULL,
  `product_image_list_image_local_path` text NOT NULL,
  `product_image_list_image_sort_order` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_image_list_image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_image_list_image_text`;
CREATE TABLE `product_image_list_image_text` (
  `product_image_list_image_id` int(11) NOT NULL,
  `product_image_list_image_text_type` varchar(16) NOT NULL,
  `product_image_list_image_text_value` varchar(255) NOT NULL,
  `language_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_image_list_image_id`,`language_id`,`product_image_list_image_text_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_types`;
CREATE TABLE `product_types` (
  `product_type_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`product_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `product_type_descriptions`;
CREATE TABLE `product_type_descriptions` (
  `product_type_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`product_type_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties` (
  `properties_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sort_order` int(10) NOT NULL DEFAULT 0,
  `display_type` varchar(64) NOT NULL DEFAULT 'Dropdown',
  `properties_filter_display_type` varchar(64) NOT NULL,
  PRIMARY KEY (`properties_id`),
  KEY `properties_id` (`properties_id`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `properties_description`;
CREATE TABLE `properties_description` (
  `properties_description_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `properties_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language_id` int(10) unsigned NOT NULL DEFAULT 0,
  `properties_name` varchar(255) NOT NULL DEFAULT '',
  `properties_admin_name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`properties_description_id`),
  UNIQUE KEY `unique_description` (`properties_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `properties_values`;
CREATE TABLE `properties_values` (
  `properties_values_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `properties_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sort_order` int(10) NOT NULL DEFAULT 0,
  `value_model` varchar(64) NOT NULL DEFAULT '',
  `weight` decimal(9,4) NOT NULL DEFAULT 0.0000,
  `value_price` decimal(9,4) NOT NULL DEFAULT 0.0000,
  `display_image` varchar(256) NOT NULL DEFAULT '',
  `stock_type` varchar(32) NOT NULL DEFAULT 'not-managed',
  `stock` decimal(9,4) NOT NULL DEFAULT 0.0000,
  `stock_centrally_managed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`properties_values_id`),
  KEY `properties_values_id` (`properties_values_id`,`properties_id`,`sort_order`),
  KEY `properties_id` (`properties_id`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `properties_values_description`;
CREATE TABLE `properties_values_description` (
  `properties_values_description_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `properties_values_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language_id` int(10) unsigned NOT NULL DEFAULT 0,
  `values_name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`properties_values_description_id`),
  UNIQUE KEY `unique_description` (`properties_values_id`,`language_id`),
  KEY `properties_values_description_id` (`properties_values_description_id`,`properties_values_id`,`language_id`),
  KEY `properties_values_id` (`properties_values_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `protectedshops`;
CREATE TABLE `protectedshops` (
  `ps_id` int(11) NOT NULL AUTO_INCREMENT,
  `document_name` varchar(255) NOT NULL DEFAULT '',
  `document_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `md5` varchar(32) NOT NULL DEFAULT '',
  `document_type` varchar(32) NOT NULL DEFAULT '',
  `content` mediumtext NOT NULL,
  PRIMARY KEY (`ps_id`),
  KEY `document_name` (`document_name`,`document_date`,`document_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `quantity_unit`;
CREATE TABLE `quantity_unit` (
  `quantity_unit_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`quantity_unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `quantity_unit_description`;
CREATE TABLE `quantity_unit_description` (
  `quantity_unit_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `unit_name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`quantity_unit_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `redirectrules`;
CREATE TABLE `redirectrules` (
  `redirect_id` int(11) NOT NULL AUTO_INCREMENT,
  `url_path` varchar(200) NOT NULL,
  `query` varchar(200) NOT NULL,
  `query_match_mode` varchar(12) NOT NULL DEFAULT 'ignore',
  `response_code` int(11) NOT NULL DEFAULT 302,
  `target` varchar(200) NOT NULL,
  `query_processing` varchar(6) NOT NULL DEFAULT 'merge',
  `status` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`redirect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `reviews_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `customers_id` int(11) DEFAULT NULL,
  `customers_name` varchar(64) NOT NULL DEFAULT '',
  `reviews_rating` int(1) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reviews_read` int(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`reviews_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `reviews_description`;
CREATE TABLE `reviews_description` (
  `reviews_id` int(11) NOT NULL DEFAULT 0,
  `languages_id` int(11) NOT NULL DEFAULT 0,
  `reviews_text` text NOT NULL,
  PRIMARY KEY (`reviews_id`,`languages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `sa_deluxe`;
CREATE TABLE `sa_deluxe` (
  `sad_id` int(11) NOT NULL AUTO_INCREMENT,
  `sad_filiale` varchar(30) NOT NULL,
  `sad_strasse` varchar(35) NOT NULL,
  `sad_plz` int(5) NOT NULL,
  `sad_ort` varchar(30) NOT NULL,
  `sad_oz` varchar(512) NOT NULL,
  `sad_lat` float(10,6) NOT NULL,
  `sad_lng` float(10,6) NOT NULL,
  PRIMARY KEY (`sad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `sepa`;
CREATE TABLE `sepa` (
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `sepa_owner` varchar(64) DEFAULT NULL,
  `sepa_iban` varchar(35) DEFAULT NULL,
  `sepa_bic` varchar(15) DEFAULT NULL,
  `sepa_bankname` varchar(255) DEFAULT NULL,
  `sepa_status` int(11) DEFAULT NULL,
  `sepa_prz` char(2) DEFAULT NULL,
  `sepa_fax` char(2) DEFAULT NULL,
  PRIMARY KEY (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `name` varchar(64) NOT NULL,
  `path` varchar(200) NOT NULL,
  `session_id` varchar(64) NOT NULL,
  `data` mediumtext NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`name`,`path`,`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shared_shopping_carts`;
CREATE TABLE `shared_shopping_carts` (
  `hash` varchar(32) NOT NULL,
  `json_shopping_cart` text NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shipping_and_payment_matrix`;
CREATE TABLE `shipping_and_payment_matrix` (
  `country_code` varchar(255) NOT NULL DEFAULT '',
  `language_id` int(11) NOT NULL DEFAULT 0,
  `shipping_info` text NOT NULL,
  `payment_info` text NOT NULL,
  `shipping_time` text NOT NULL,
  PRIMARY KEY (`country_code`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shipping_status`;
CREATE TABLE `shipping_status` (
  `shipping_status_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `shipping_status_name` varchar(255) NOT NULL DEFAULT '',
  `shipping_status_image` varchar(255) NOT NULL DEFAULT '',
  `number_of_days` int(10) NOT NULL DEFAULT 0,
  `shipping_quantity` decimal(15,4) DEFAULT NULL,
  `info_link_active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`shipping_status_id`,`language_id`),
  KEY `idx_shipping_status_name` (`shipping_status_name`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shipping_status_to_google_availability`;
CREATE TABLE `shipping_status_to_google_availability` (
  `shipping_status_id` int(10) unsigned NOT NULL DEFAULT 0,
  `google_export_availability_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`shipping_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shopvote`;
CREATE TABLE `shopvote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `installed` int(1) NOT NULL DEFAULT 1,
  `reviews_html` text DEFAULT NULL,
  `reviews_script` text DEFAULT NULL,
  `stars_script` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shopvote_reviews`;
CREATE TABLE `shopvote_reviews` (
  `shopvote_reviews_id` int(11) NOT NULL AUTO_INCREMENT,
  `review_uid` varchar(32) NOT NULL,
  `sku` varchar(64) NOT NULL,
  `gtin` varchar(14) NOT NULL,
  `created` date NOT NULL,
  `author` varchar(100) NOT NULL,
  `rating_value` int(1) NOT NULL,
  `review_text` text NOT NULL,
  PRIMARY KEY (`shopvote_reviews_id`),
  UNIQUE KEY `ReviewUID` (`review_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shop_notices`;
CREATE TABLE `shop_notices` (
  `shop_notice_id` int(11) NOT NULL DEFAULT 0,
  `notice_type` enum('topbar','popup') DEFAULT NULL,
  PRIMARY KEY (`shop_notice_id`),
  UNIQUE KEY `notice_type_UNIQUE` (`notice_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shop_notice_contents`;
CREATE TABLE `shop_notice_contents` (
  `shop_notice_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `content` text NOT NULL,
  PRIMARY KEY (`shop_notice_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shop_notice_jobs`;
CREATE TABLE `shop_notice_jobs` (
  `shop_notice_job_id` int(11) NOT NULL AUTO_INCREMENT,
  `waiting_ticket_id` int(11) NOT NULL DEFAULT 0,
  `shop_active` tinyint(4) NOT NULL DEFAULT 0,
  `shop_offline_content` text NOT NULL,
  `topbar_active` int(11) NOT NULL DEFAULT 0,
  `topbar_color` varchar(45) NOT NULL DEFAULT '',
  `topbar_mode` varchar(45) NOT NULL DEFAULT '',
  `popup_active` tinyint(4) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`shop_notice_job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `shop_notice_job_contents`;
CREATE TABLE `shop_notice_job_contents` (
  `shop_notice_job_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `topbar_content` text NOT NULL,
  `popup_content` text NOT NULL,
  PRIMARY KEY (`shop_notice_job_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `sliders`;
CREATE TABLE `sliders` (
  `slider_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `speed` decimal(5,3) unsigned NOT NULL DEFAULT 3.000,
  `start_page` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`slider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `slider_assignments`;
CREATE TABLE `slider_assignments` (
  `slider_id` int(11) NOT NULL DEFAULT 0,
  `entity_id` int(11) NOT NULL DEFAULT 0,
  `entity_type` enum('category','content','product') NOT NULL DEFAULT 'category',
  PRIMARY KEY (`entity_id`,`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `slider_set`;
CREATE TABLE `slider_set` (
  `slider_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `set_name` varchar(255) DEFAULT NULL,
  `slider_speed` int(11) DEFAULT NULL,
  `width` int(10) unsigned NOT NULL DEFAULT 760,
  `height` int(10) unsigned NOT NULL DEFAULT 300,
  PRIMARY KEY (`slider_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `slides`;
CREATE TABLE `slides` (
  `slide_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `slider_id` int(10) unsigned NOT NULL DEFAULT 0,
  `thumbnail` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `alt_text` varchar(255) NOT NULL DEFAULT '',
  `url` text NOT NULL,
  `url_target` varchar(16) NOT NULL DEFAULT '_self',
  `sort_order` int(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`slide_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `slide_images`;
CREATE TABLE `slide_images` (
  `slide_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `breakpoint` enum('xs','sm','md','lg') NOT NULL DEFAULT 'lg',
  `image` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`slide_image_id`),
  UNIQUE KEY `slide_image_id` (`slide_image_id`,`slide_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `slide_image_areas`;
CREATE TABLE `slide_image_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slide_images_id` int(11) NOT NULL DEFAULT 0,
  `coordinates` text NOT NULL,
  `link_title` varchar(255) NOT NULL DEFAULT '',
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_target` enum('_self','_blank') NOT NULL DEFAULT '_self',
  PRIMARY KEY (`id`),
  KEY `fk_slide_image_maparea_slide_image1` (`slide_images_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `specials`;
CREATE TABLE `specials` (
  `specials_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT 0,
  `specials_quantity` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `specials_new_products_price` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `specials_date_added` datetime DEFAULT NULL,
  `specials_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `begins_date` datetime DEFAULT NULL,
  `started` int(1) NOT NULL DEFAULT 1,
  `expires_date` datetime DEFAULT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`specials_id`),
  UNIQUE KEY `products_id2` (`products_id`),
  KEY `products_id` (`products_id`,`status`,`specials_date_added`),
  KEY `status` (`status`,`expires_date`,`begins_date`,`started`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `static_seo_urls`;
CREATE TABLE `static_seo_urls` (
  `static_seo_url_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sitemap_entry` int(1) NOT NULL DEFAULT 0,
  `priority` varchar(3) NOT NULL DEFAULT '0.5',
  `changefreq` varchar(255) NOT NULL DEFAULT 'weekly',
  `robots_disallow_entry` int(1) NOT NULL DEFAULT 0,
  `opengraph_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`static_seo_url_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `static_seo_url_contents`;
CREATE TABLE `static_seo_url_contents` (
  `static_seo_url_content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `static_seo_url_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`static_seo_url_content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `tax_class`;
CREATE TABLE `tax_class` (
  `tax_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_class_title` varchar(32) NOT NULL DEFAULT '',
  `tax_class_description` varchar(255) NOT NULL DEFAULT '',
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`tax_class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `tax_rates`;
CREATE TABLE `tax_rates` (
  `tax_rates_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_zone_id` int(11) NOT NULL DEFAULT 0,
  `tax_class_id` int(11) NOT NULL DEFAULT 0,
  `tax_priority` int(5) DEFAULT 1,
  `tax_rate` decimal(7,4) NOT NULL DEFAULT 0.0000,
  `tax_description` varchar(255) NOT NULL DEFAULT '',
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`tax_rates_id`),
  KEY `tax_zone_id` (`tax_zone_id`),
  KEY `tax_class_id` (`tax_class_id`,`tax_priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `ts_certs`;
CREATE TABLE `ts_certs` (
  `tsid` varchar(33) NOT NULL DEFAULT '',
  `language` varchar(2) NOT NULL DEFAULT '',
  `state` enum('PRODUCTION','CANCELLED','DISABLED','INTEGRATION','TEST','INVALID_TS_ID') NOT NULL,
  `type` enum('CLASSIC','EXCELLENCE','MIGRATION') NOT NULL,
  `url` text NOT NULL,
  `user` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `login_ok` tinyint(1) NOT NULL DEFAULT 0,
  `rating_ok` tinyint(1) NOT NULL DEFAULT 0,
  `date_checked` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`tsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `ts_items`;
CREATE TABLE `ts_items` (
  `ts_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `ts_id` varchar(33) NOT NULL DEFAULT '',
  `retrievaldate` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `creationdate` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `id` int(11) NOT NULL DEFAULT 0,
  `currency` varchar(3) NOT NULL DEFAULT '',
  `grossfee` decimal(15,5) NOT NULL DEFAULT 0.00000,
  `netfee` decimal(15,5) NOT NULL DEFAULT 0.00000,
  `protectedamount` decimal(15,5) NOT NULL DEFAULT 0.00000,
  `protectionduration` int(11) NOT NULL DEFAULT 0,
  `tsproductid` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ts_items_id`),
  KEY `ts_id` (`ts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `ts_protection`;
CREATE TABLE `ts_protection` (
  `orders_id` int(11) NOT NULL DEFAULT 0,
  `application_number` int(11) NOT NULL DEFAULT 0,
  `tsid` varchar(33) NOT NULL DEFAULT '',
  `result` int(11) DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `application_number` (`application_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `url_rewrites`;
CREATE TABLE `url_rewrites` (
  `content_id` int(11) NOT NULL DEFAULT 0,
  `content_type` enum('product','category','content','search') NOT NULL DEFAULT 'product',
  `language_id` int(11) NOT NULL DEFAULT 1,
  `rewrite_url` varchar(255) NOT NULL DEFAULT '',
  `target_url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_type`,`content_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `user_configuration`;
CREATE TABLE `user_configuration` (
  `customer_id` int(11) NOT NULL DEFAULT 0,
  `configuration_key` varchar(255) NOT NULL DEFAULT '',
  `configuration_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`customer_id`,`configuration_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `version_history`;
CREATE TABLE `version_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` enum('master_update','service_pack','update') NOT NULL DEFAULT 'update',
  `revision` int(11) NOT NULL DEFAULT 0,
  `is_full_version` tinyint(1) NOT NULL DEFAULT 0,
  `installation_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `php_version` varchar(255) NOT NULL DEFAULT '',
  `mysql_version` varchar(255) NOT NULL DEFAULT '',
  `installed` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Signalisiert, ob ein Versionseintrag wirklich installiert wurde oder durch die Versionsauswahl angelegt wurde.',
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `whos_online`;
CREATE TABLE `whos_online` (
  `whos_online_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `full_name` varchar(64) NOT NULL DEFAULT '',
  `session_id` varchar(128) NOT NULL DEFAULT '',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `time_entry` varchar(14) NOT NULL DEFAULT '',
  `time_last_click` varchar(14) NOT NULL DEFAULT '',
  `last_page_url` varchar(255) NOT NULL DEFAULT '',
  `is_bot` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`whos_online_id`),
  KEY `customer_id` (`customer_id`),
  KEY `session_id` (`session_id`),
  KEY `time_last_click` (`time_last_click`),
  KEY `is_bot` (`is_bot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `withdrawals`;
CREATE TABLE `withdrawals` (
  `withdrawal_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_gender` varchar(1) NOT NULL DEFAULT '',
  `customer_firstname` varchar(255) NOT NULL DEFAULT '',
  `customer_lastname` varchar(255) NOT NULL DEFAULT '',
  `customer_street_address` varchar(255) NOT NULL DEFAULT '',
  `customer_postcode` varchar(255) NOT NULL DEFAULT '',
  `customer_city` varchar(255) NOT NULL DEFAULT '',
  `customer_country` varchar(255) NOT NULL DEFAULT '',
  `customer_email` varchar(255) NOT NULL DEFAULT '',
  `order_date` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `withdrawal_date` datetime DEFAULT NULL,
  `withdrawal_content` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `created_by_admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`withdrawal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `zones`;
CREATE TABLE `zones` (
  `zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_country_id` int(11) NOT NULL DEFAULT 0,
  `zone_code` varchar(32) NOT NULL DEFAULT '',
  `zone_name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`zone_id`),
  UNIQUE KEY `unique_country_zone` (`zone_country_id`,`zone_code`),
  KEY `zone_name` (`zone_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `zones_to_geo_zones`;
CREATE TABLE `zones_to_geo_zones` (
  `association_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_country_id` int(11) NOT NULL DEFAULT 0,
  `zone_id` int(11) NOT NULL DEFAULT 0,
  `geo_zone_id` int(11) NOT NULL DEFAULT 0,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_added` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`association_id`),
  KEY `zone_id` (`zone_id`),
  KEY `geo_zone_id` (`geo_zone_id`,`zone_country_id`),
  KEY `zone_country_id` (`zone_country_id`,`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- 2024-02-09 11:21:44
