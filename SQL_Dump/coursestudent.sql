/*
SQLyog Ultimate v9.50 
MySQL - 5.6.17 : Database - coursestudent
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `lessons` */

DROP TABLE IF EXISTS `lessons`;

CREATE TABLE `lessons` (
  `l_id` int(11) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `s_id` int(11) DEFAULT NULL,
  `t_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lessons` */

/*Table structure for table `sms_history` */

DROP TABLE IF EXISTS `sms_history`;

CREATE TABLE `sms_history` (
  `sms_id` int(11) DEFAULT NULL,
  `s_id` int(11) DEFAULT NULL,
  `t_id` int(11) DEFAULT NULL,
  `l_id` int(11) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `text` varchar(320) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sms_history` */

/*Table structure for table `students` */

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `s_id` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `surname` varchar(40) DEFAULT NULL,
  `fathers_name` varchar(30) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0-Deactive; 1-Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `students` */

/*Table structure for table `subjects` */

DROP TABLE IF EXISTS `subjects`;

CREATE TABLE `subjects` (
  `id` tinyint(3) unsigned DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `subjects` */

/*Table structure for table `teachers` */

DROP TABLE IF EXISTS `teachers`;

CREATE TABLE `teachers` (
  `t_id` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `surname` varchar(40) DEFAULT NULL,
  `fathers_name` varchar(30) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '0 - Deactive; 1-Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `teachers` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `uname` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `regdate` date NOT NULL,
  `status` tinyint(2) DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '2',
  PRIMARY KEY (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`first_name`,`last_name`,`email`,`uname`,`pass`,`regdate`,`status`,`type`) values ('Admin','User','admin@millikart.az','admin','*4ACFE3202A5FF5CF467898FC58AAB1D615029441','2017-09-07',0,0);
insert  into `users`(`first_name`,`last_name`,`email`,`uname`,`pass`,`regdate`,`status`,`type`) values ('Mammad','mammadli','senanqerib@gmail.com','mammad','*33F3387BD368790C659C8546DC7D321365EBC477','2017-09-14',0,2);
insert  into `users`(`first_name`,`last_name`,`email`,`uname`,`pass`,`regdate`,`status`,`type`) values ('Sanan','Garibli','senanqerib@gmail.com','senan','*4BE6E49A5D8C428C8DFE1FA6E69DD8BAF9F441F5','2017-09-05',0,2);
insert  into `users`(`first_name`,`last_name`,`email`,`uname`,`pass`,`regdate`,`status`,`type`) values ('Tofig','Tofig','senanqerib@gmail.com','tofiq','*B4422AFFAFB0CD4C23029EEDDB79A9DDA5ED3890','2017-09-07',0,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
