-- =====================================================
-- RCCG True Light Assembly - Complete Database Schema
-- =====================================================
-- Database: rccg_church_system
-- Version: 2.0
-- Created: 2025-01-26
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS `rccg_church_system` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `rccg_church_system`;

-- =====================================================
-- 1. USERS & AUTHENTICATION TABLES
-- =====================================================

-- Users Table (Core user management)
CREATE TABLE `users` (
    `user_id` INT(11) NOT NULL AUTO_INCREMENT,
    `full_name` VARCHAR(100) NOT NULL,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(150) NOT NULL UNIQUE,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `phone_number` VARCHAR(20) NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `user_role` ENUM('admin', 'pastor', 'leader', 'member', 'visitor') NOT NULL DEFAULT 'member',
    `account_status` ENUM('active', 'suspended', 'pending', 'inactive') NOT NULL DEFAULT 'pending',
    `email_verified` TINYINT(1) NOT NULL DEFAULT 0,
    `phone_verified` TINYINT(1) NOT NULL DEFAULT 0,
    `profile_image` VARCHAR(255) NULL,
    `date_registered` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `last_login` DATETIME NULL,
    `last_activity` DATETIME NULL,
    `failed_login_attempts` INT(3) NOT NULL DEFAULT 0,
    `locked_until` DATETIME NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`),
    INDEX `idx_email` (`email`),
    INDEX `idx_username` (`username`),
    INDEX `idx_user_role` (`user_role`),
    INDEX `idx_account_status` (`account_status`),
    INDEX `idx_date_registered` (`date_registered`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Password Reset Tokens
CREATE TABLE `password_resets` (
    `reset_id` INT(11) NOT NULL AUTO_INCREMENT,
    `user_id` INT(11) NOT NULL,
    `reset_token` VARCHAR(255) NOT NULL UNIQUE,
    `expires_at` DATETIME NOT NULL,
    `used` TINYINT(1) NOT NULL DEFAULT 0,
    `ip_address` VARCHAR(45) NULL,
    `user_agent` TEXT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`reset_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`) ON DELETE CASCADE,
    INDEX `idx_reset_token` (`reset_token`),
    INDEX `idx_expires_at` (`expires_at`),
    INDEX `idx_user_id` (`user_id`