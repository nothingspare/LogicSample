-- Schema for Kahuna Sample
--
-- Version: $Id: SampleSchema.sql 310 2014-04-30 00:11:46Z valhuber $

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  name varchar(30) PRIMARY KEY,
  balance decimal(19,4) DEFAULT NULL,
  credit_limit decimal(19,4) NOT NULL,
  notes varchar(50) DEFAULT NULL,
  customer_level varchar(1) DEFAULT NULL,
  is_credit_pre_approved bit(1) DEFAULT NULL,
  big_order_count Int DEFAULT NULL,
  max_unpaid_order decimal(19,4) DEFAULT NULL,
  ts timestamp
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  name varchar(45) PRIMARY KEY,
  managed_by varchar(45) DEFAULT NULL,
  head_department_name varchar(45) DEFAULT NULL,
  sum_sub_department_budget decimal(19,4) DEFAULT NULL,
  budget decimal(19,4) DEFAULT NULL,
  budget_with_sub_department_budget decimal(19,4) DEFAULT NULL,
  notes varchar(50) DEFAULT NULL,
  secret_agenda varchar(50) DEFAULT NULL,
  ts timestamp,
  KEY Manager (managed_by),
  CONSTRAINT headDepartment FOREIGN KEY (head_department_name) REFERENCES departments (name) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT manager FOREIGN KEY (managed_by) REFERENCES employees (name) ON DELETE NO ACTION ON UPDATE NO ACTION)
 ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


--
-- Table structure for table employees
--

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  name varchar(20) PRIMARY KEY,
  base_salary decimal(10,4) DEFAULT NULL,
  employee_type char(12) NOT NULL,
  ts timestamp,
  visible_to char(30) COMMENT 'placeholder - possible security use',
  department_name varchar(45) DEFAULT NULL,
  on_loan_department_name varchar(45) DEFAULT NULL,
  notes varchar(200),
  KEY reportsTo (department_name),
  KEY onLoanTo (on_loan_department_name),
  CONSTRAINT reportsTo__reportingEmployees FOREIGN KEY (department_name) REFERENCES departments (name) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT onLoanTo__onLoanEmployees FOREIGN KEY (on_loan_department_name) REFERENCES departments (name) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS empsales;
CREATE TABLE empsales (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  employee_name varchar(45),
  year int(11) DEFAULT NULL,
  month int(11) DEFAULT NULL,
  total_sales decimal(19,4) DEFAULT NULL,
  KEY employee (employee_name, year, month),
  CONSTRAINT employee FOREIGN KEY (employee_name) REFERENCES employees (name) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS employee_audits;
CREATE TABLE employee_audits (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  base_salary decimal(19,4) DEFAULT NULL,
  base_salary_old decimal(19,4) DEFAULT NULL,
  employee_name varchar(45) DEFAULT NULL,
  KEY employee (employee_name),
  CONSTRAINT auditedEmployee FOREIGN KEY (employee_name) REFERENCES employees (name) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS employee_raise_service ;
CREATE  TABLE IF NOT EXISTS employee_raise_service (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  percent_raise_to_give DECIMAL(5,2) NOT NULL ,
  current_salary DECIMAL(19,4) NULL DEFAULT NULL ,
  new_salary DECIMAL(19,4) NULL DEFAULT NULL,
  employee_name varchar(45) DEFAULT NULL,
  INDEX employeeForRaise (employee_name ASC) ,
  CONSTRAINT employeeForRaise FOREIGN KEY (employee_name) REFERENCES employees (name) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS lineitems;
CREATE TABLE lineitems (
  ident BIGINT AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  product_name varchar(45) NOT NULL,
  quantity_ordered int(11),
  part_price decimal(19,4),
  amount decimal(19,4),
  kit_quantity_ordered int(11),
  kit_number_required int(11),
  kit_component_count int(11),
  kit_item_ident BIGINT,
  notes varchar(50),
  is_ready boolean DEFAULT false,
  order_ident BIGINT NOT NULL,
  KEY KitItem (kit_item_ident),
  KEY Part (product_name)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table lineitem_note
-- -----------------------------------------------------
DROP TABLE IF EXISTS lineitem_notes ;
CREATE  TABLE IF NOT EXISTS lineitem_notes (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  special_handling VARCHAR(50),
  item_ident bigint NOT NULL,
  INDEX LineitemForNoteIndex (item_ident ASC),
  CONSTRAINT itemForNote FOREIGN KEY (item_ident) REFERENCES lineitems (ident) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS lineitem_usages;
CREATE TABLE lineitem_usages (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  explanation varchar(50) DEFAULT NULL,
  order_ident bigint,
  item_ident bigint NOT NULL,
  CONSTRAINT orderForUsage FOREIGN KEY (order_ident ) REFERENCES orders (ident ) ON DELETE NO ACTION  ON UPDATE NO ACTION,
  CONSTRAINT itemForUsage FOREIGN KEY (item_ident) REFERENCES lineitems (ident) ON DELETE NO ACTION ON UPDATE NO ACTION)
 ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS order_issues;
CREATE TABLE order_issues (
	ident bigint AUTO_INCREMENT PRIMARY KEY,
	ts timestamp,
  Issue varchar(50) DEFAULT NULL,
  DateStamp datetime DEFAULT NULL,
  po_ident bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  amount decimal(19,4) DEFAULT NULL,
  amount_un_disbursed decimal(19,4) DEFAULT NULL,
  placed_date date DEFAULT NULL,
  customer_name varchar(45) DEFAULT NULL,
  KEY PaymentCustomer (customer_name),
  CONSTRAINT paymentCustomer FOREIGN KEY (customer_name) REFERENCES customers (name) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS payment_order_allocations;
CREATE TABLE payment_order_allocations (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  order_ident bigint NOT NULL,
  payment_ident bigint NOT NULL,
  amount decimal(19,4) DEFAULT NULL,
  KEY Payment (payment_ident),
  KEY Purchaseorder (order_ident),
  CONSTRAINT payment FOREIGN KEY (payment_ident) REFERENCES payments (ident) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT allocationOrder FOREIGN KEY (order_ident) REFERENCES orders (ident) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  name varchar(45) PRIMARY KEY,
  price decimal(19,4) DEFAULT NULL,
  quantity_on_hand int(11) DEFAULT NULL,
  total_quantity_ordered int(11) DEFAULT NULL,
  quantity_reorder int(11) DEFAULT NULL,
  is_reorder_required bit(1) DEFAULT NULL,
  count_components int(11) DEFAULT NULL,
  sum_components_value decimal(19,4) DEFAULT NULL,
  needs_usage_terms bit(1) NOT NULL,
  is_active bit(1) DEFAULT NULL,
  notes varchar(50) DEFAULT NULL,
  is_secret bit(1),
  ts timestamp
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS product_billofmaterials;
CREATE TABLE product_billofmaterials (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  product_name_kit varchar(45) NOT NULL,
  product_name varchar(45) NOT NULL,
  kit_number_required int(11) DEFAULT NULL,
  value decimal(19,4) DEFAULT NULL,
  KEY Kit (product_name_kit),
  KEY Product (product_name),
  CONSTRAINT kit__components FOREIGN KEY (product_name_kit) REFERENCES products (name) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT product__inKits FOREIGN KEY (product_name) REFERENCES products (name) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  amount_total decimal(19,4) DEFAULT NULL,
  amount_discounted decimal(19,4) DEFAULT NULL,
  amount_paid decimal(19,4) DEFAULT NULL,
  amount_un_paid decimal(19,4) DEFAULT NULL COMMENT '/orders.findall({it.isPaid==false}).sum(it.amount)',
  is_ready bit(1) DEFAULT NULL,
  approving_officer varchar(10) DEFAULT NULL,
  officer_item_usage_approval varchar(50) DEFAULT NULL,
  unresolved_usage_count int(11) DEFAULT NULL,
  placed_date date DEFAULT NULL,
  due_date date DEFAULT NULL,
  salesrep_name varchar(45) DEFAULT NULL,
  customer_name varchar(45) DEFAULT NULL,
  cloned_from_order_ident bigint DEFAULT NULL,
  item_count int(11) DEFAULT NULL,
  empsales_ident bigint DEFAULT NULL,
  KEY SalesRep (salesrep_name),
  KEY Customer (customer_name),
  CONSTRAINT customer FOREIGN KEY (customer_name) REFERENCES customers (name) ON UPDATE CASCADE,
  CONSTRAINT salesRep FOREIGN KEY (salesrep_name) REFERENCES employees (name) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT empSales FOREIGN KEY (empsales_ident) REFERENCES empsales (ident) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT = 1000;


DROP TABLE IF EXISTS valid_customerlevel;
CREATE TABLE valid_customerlevel (
  ident bigint AUTO_INCREMENT PRIMARY KEY,
  ts timestamp,
  level_stored varchar(1) NOT NULL,
  description varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE lineitems
  ADD CONSTRAINT kitItem FOREIGN KEY (kit_item_ident)
  REFERENCES lineitems (ident)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE lineitems
  ADD CONSTRAINT product FOREIGN KEY (product_name)
  REFERENCES products (name)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE lineitems
  ADD CONSTRAINT itemOrder FOREIGN KEY (order_ident)
  REFERENCES orders (ident)
  ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET character_set_client = @saved_cs_client */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
