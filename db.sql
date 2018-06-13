CREATE DATABASE `myticket`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_unicode_ci';
    
USE `myticket`;





CREATE TABLE `myticket_travel_class` (
  `tc_id` INTEGER(11) NOT NULL,
  `tc_name` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tc_id`) USING BTREE,
  UNIQUE KEY `XPKclasses` (`tc_id`) USING BTREE
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_vehicle_type` (
  `vt_id` INTEGER(11) NOT NULL,
  `vt_name` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`vt_id`) USING BTREE,
  UNIQUE KEY `XPKvehicle_type` (`vt_id`) USING BTREE
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_model` (
  `m_id` INTEGER(11) NOT NULL,
  `vt_id` INTEGER(11) NOT NULL,
  `m_name` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`m_id`) USING BTREE,
  UNIQUE KEY `XPKmodel` (`m_id`) USING BTREE,
  KEY `form_of_transport` (`vt_id`) USING BTREE,
  CONSTRAINT `model_ibfk_1` FOREIGN KEY (`vt_id`) REFERENCES `myticket_vehicle_type` (`vt_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_vehicle` (
  `v_id` INTEGER(11) NOT NULL,
  `m_id` INTEGER(11) NOT NULL,
  PRIMARY KEY (`v_id`) USING BTREE,
  UNIQUE KEY `XPKvehicle` (`v_id`) USING BTREE,
  KEY `vehicle_unit_of_model` (`m_id`) USING BTREE,
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`m_id`) REFERENCES `myticket_model` (`m_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_model_seats` (
  `m_id` INTEGER(11) NOT NULL,
  `ms_seats_to` INTEGER(6) NOT NULL,
  `tc_id` INTEGER(11) NOT NULL,
  `ms_price_coef` FLOAT(5,3) NOT NULL,
  PRIMARY KEY (`m_id`, `ms_seats_to`) USING BTREE,
  UNIQUE KEY `XPKmodel_seats` (`m_id`, `ms_seats_to`) USING BTREE,
  KEY `seats_of_the_model` (`m_id`) USING BTREE,
  KEY `seats_of_class` (`tc_id`) USING BTREE,
  CONSTRAINT `model_seats_ibfk_1` FOREIGN KEY (`m_id`) REFERENCES `myticket_model` (`m_id`),
  CONSTRAINT `model_seats_ibfk_2` FOREIGN KEY (`tc_id`) REFERENCES `myticket_travel_class` (`tc_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_city` (
  `c_id` INTEGER(11) NOT NULL,
  `c_name` VARCHAR(250) COLLATE utf8_unicode_ci NOT NULL,
  `c_country` VARCHAR(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_timezone_utc` VARCHAR(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`c_id`) USING BTREE,
  UNIQUE KEY `XPKcity` (`c_id`) USING BTREE
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_station` (
  `s_id` INTEGER(11) NOT NULL,
  `s_name` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  `c_id` INTEGER(11) NOT NULL,
  `s_address` VARCHAR(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `s_code` VARCHAR(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vt_id` INTEGER(11) NOT NULL,
  PRIMARY KEY (`s_id`) USING BTREE,
  UNIQUE KEY `XPKstation` (`s_id`) USING BTREE,
  KEY `form_of_station` (`vt_id`) USING BTREE,
  KEY `station_in_city` (`c_id`) USING BTREE,
  CONSTRAINT `station_ibfk_2` FOREIGN KEY (`c_id`) REFERENCES `myticket_city` (`c_id`),
  CONSTRAINT `station_ibfk_1` FOREIGN KEY (`vt_id`) REFERENCES `myticket_vehicle_type` (`vt_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_route` (
  `r_id` INTEGER(11) NOT NULL,
  `v_id` INTEGER(11) NOT NULL,
  `r_station_i` INTEGER(4) NOT NULL,
  `s_id` INTEGER(11) NOT NULL,
  `r_price` FLOAT(8,2) NOT NULL,
  `r_time1` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  `r_time2` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`r_id`, `r_station_i`) USING BTREE,
  UNIQUE KEY `XPKroute` (`r_id`, `r_station_i`) USING BTREE,
  KEY `vehicle_on_route` (`v_id`) USING BTREE,
  KEY `station_on_route` (`s_id`) USING BTREE,
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`v_id`) REFERENCES `myticket_vehicle` (`v_id`),
  CONSTRAINT `route_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `myticket_station` (`s_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_user` (
  `u_id` INTEGER(11) NOT NULL,
  `u_email` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  `u_name` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  `u_password_md5` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  `u_register_time` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  `u_type` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  `u_firstname` VARCHAR(99) COLLATE utf8_unicode_ci DEFAULT NULL,
  `u_lastname` VARCHAR(99) COLLATE utf8_unicode_ci DEFAULT NULL,
  `u_passport` VARCHAR(99) COLLATE utf8_unicode_ci DEFAULT NULL,
  `u_cardnumber` VARCHAR(99) COLLATE utf8_unicode_ci DEFAULT NULL,
  `u_card_cvv` VARCHAR(99) COLLATE utf8_unicode_ci DEFAULT NULL,
  `u_card_exp_month` VARCHAR(99) COLLATE utf8_unicode_ci DEFAULT NULL,
  `u_card_exp_year` VARCHAR(99) COLLATE utf8_unicode_ci DEFAULT NULL,
  
  PRIMARY KEY (`u_id`) USING BTREE,
  UNIQUE KEY `XPKticket` (`u_id`) USING BTREE
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;


CREATE TABLE `myticket_ticket` (
  `t_id` INTEGER(11) NOT NULL,
  `r_id` INTEGER(11) NOT NULL,
  `t_seat_i` INTEGER(6) NOT NULL,
  `t_from_station_i` INTEGER(4) NOT NULL,
  `t_to_station_i` INTEGER(4) NOT NULL,
  `t_price` FLOAT(8,2) NOT NULL,
  `t_purchase_time` VARCHAR(99) COLLATE utf8_unicode_ci NOT NULL,
  `u_id` INTEGER(11) NOT NULL,
  PRIMARY KEY (`t_id`) USING BTREE,
  UNIQUE KEY `XPKticket` (`t_id`) USING BTREE,
  KEY `ticket_on_route` (`r_id`) USING BTREE,
  KEY `user_purchased_ticket` (`u_id`) USING BTREE,
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`r_id`) REFERENCES `myticket_route` (`r_id`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `myticket_user` (`u_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'
;










INSERT INTO `myticket_travel_class` (`tc_id`, `tc_name`) VALUES
  (1,'seat first class'),
  (2,'seat'),
  (3,'sleeper first class'),
  (4,'sleeper'),
  (5,'first class'),
  (6,'business class'),
  (7,'premium economy class'),
  (8,'economy class');
COMMIT;


INSERT INTO `myticket_vehicle_type` (`vt_id`, `vt_name`) VALUES
  (1,'train'),
  (2,'aircraft'),
  (3,'ship');
COMMIT;


INSERT INTO `myticket_model` (`m_id`, `vt_id`, `m_name`) VALUES
  (1,1,'train1_seat'),
  (2,1,'train2_seat'),
  (3,1,'train3_sleaper'),
  (4,1,'train4_sleaper'),
  (5,2,'Boeing 777'),
  (6,2,'Boeing 787 Dreamliner'),
  (7,2,'Airbus A350 XWB');
COMMIT;


INSERT INTO `myticket_vehicle` (`v_id`, `m_id`) VALUES
  (1,1),
  (2,1),
  (3,2),
  (4,2),
  (5,3),
  (6,3),
  (7,4),
  (8,4),
  (9,5),
  (10,5),
  (11,6),
  (12,6),
  (13,7),
  (14,7);
COMMIT;


INSERT INTO `myticket_model_seats` (`m_id`, `ms_seats_to`, `tc_id`, `ms_price_coef`) VALUES
  (1, 75,  1, 2),
  (1, 500, 2, 1),
  (2, 400, 2, 1),
  (3, 30,  3, 2.5),
  (3, 250, 4, 1),
  (4, 200, 4, 1),
  (5, 25,  5, 3),
  (5, 100, 6, 1),
  (5, 500, 8, 0.2),
  (6, 30,  5, 3),
  (6, 150, 6, 1),
  (6, 300, 7, 0.4),
  (6, 600, 8, 0.2),
  (7, 30,  5, 2.8),
  (7, 150, 6, 1),
  (7, 350, 7, 0.35),
  (7, 800, 8, 0.25);
COMMIT;


INSERT INTO `myticket_city` (`c_id`, `c_name`, `c_country`, `c_timezone_utc`) VALUES
  (1, 'Kyiv', 'Ukraine', '+03:00'),
  (2, 'Kharkiv', 'Ukraine', '+03:00'),
  (3, 'Poltava', 'Ukraine', '+03:00'),
  (4, 'Lubny', 'Ukraine', '+03:00'),
  (5, 'Sumy', 'Ukraine', '+03:00'),
  (6, 'Konotop', 'Ukraine', '+03:00'),
  (7, 'Nizhyn', 'Ukraine', '+03:00'),
  (8, 'Brovary', 'Ukraine', '+03:00'),
  (9, 'Almaty', 'Kazakhstan', '+06:00'),
  (10, 'Doha', 'Qatar', '+03:00'),
  (11, 'Bangkok', 'Thailand', '+07:00');
COMMIT;


INSERT INTO `myticket_station` (`s_id`, `s_name`, `c_id`, `s_address`, `s_code`, `vt_id`) VALUES
  (1, 'Kyiv-pass', 1, '','', 1),
  (2, 'Kyiv Pertrovka', 1, '','', 1),
  (3, 'Kharkiv-pass', 2, '','', 1),
  (4, 'Kharkiv-levada', 2, '','', 1),
  (5, 'Kharkiv-balashovskii', 2, '','', 1),
  (6, 'Poltava Kievskaya', 3, '','', 1),
  (7, 'Lubny', 4, '','', 1),
  (8, 'Sumy', 5, '','', 1),
  (9, 'Sumy-LBK', 5, '','', 1),
  (10, 'Konotop', 6, '','', 1),
  (11, 'Nizhyn', 7, '','', 1),
  (12, 'Brovary', 8, '','', 1),
  (13, 'Zhuliany', 1, '','IEV', 2),
  (14, 'Boryspil', 1, '','KBP', 2),
  (15, 'Kharkiv', 2, '','HRK', 2),
  (16, 'Almaty', 9, '','ALA', 2),
  (17, 'Doha', 10, '','DOH', 2),
  (18, 'Suvarnabhumi', 11, '','BKK', 2),
  (19, 'Don Mueang', 11, '','DMK', 2);
COMMIT;


INSERT INTO `myticket_route` (`r_id`, `v_id`, `r_station_i`, `s_id`, `r_price`, `r_time1`, `r_time2`) VALUES
  (1, 1, 1, 1, 2, '2018.06.14 08:00', '2018.06.14 08:25'),
  (1, 1, 2, 7, 8, '2018.06.14 10:00', '2018.06.14 10:15'),
  (1, 1, 3, 6, 4, '2018.06.14 11:00', '2018.06.14 11:15'),
  (1, 1, 4, 3, 6, '2018.06.14 12:45', '2018.06.14 13:00'),
  
  (2, 2, 1, 2, 3.5, '2018.06.15 09:45', '2018.06.15 10:00'),
  (2, 2, 2, 7, 8, '2018.06.15 11:25', '2018.06.15 11:35'),
  (2, 2, 3, 6, 4.5, '2018.06.15 12:15', '2018.06.15 12:25'),
  (2, 2, 4, 3, 6, '2018.06.15 13:45', '2018.06.15 14:00'),
  
  (3, 3, 1, 1, 0.75, '2018.06.14 06:00', '2018.06.14 06:25'),
  (3, 3, 2, 7, 8, '2018.06.14 08:00', '2018.06.14 08:15'),
  (3, 3, 3, 6, 5, '2018.06.14 09:00', '2018.06.14 09:15'),
  
  (4, 9, 1, 13, 0, '2018.06.14 9:30', '2018.06.14 11:00'),
  (4, 9, 2, 16, 900, '2018.06.14 18:00', '2018.06.14 18:00'),
  
  (5, 4, 1, 7, 7, '2018.06.15 07:30', '2018.06.15 07:40'),
  (5, 4, 2, 6, 4, '2018.06.15 08:30', '2018.06.15 08:40'),
  (5, 4, 3, 3, 6, '2018.06.15 10:05', '2018.06.15 10:15'),
  
  (6, 1, 1, 4, 6, '2018.06.15 00:30', '2018.06.15 00:40'),
  (6, 1, 2, 6, 5, '2018.06.15 01:30', '2018.06.15 01:40'),
  (6, 1, 3, 7, 3.5, '2018.06.15 02:15', '2018.06.15 02:25'),
  (6, 1, 4, 1, 7, '2018.06.15 03:05', '2018.06.15 03:10');
COMMIT;






/*
*/

