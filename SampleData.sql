-- Data for KahunaSample


INSERT INTO departments (name, head_department_name, budget, notes, secret_agenda, sum_sub_department_budget, budget_with_sub_department_budget) VALUES
	('Sales', null, 50.00, 'Dept Notes - Sales', 'Agenda - Sales',1000.00,1050.00),
	('US Sales', 'Sales', 100.00, 'Dept Notes - US Sales', 'Agenda - US Sales',0,100.00),
	('Euro Sales', 'Sales', 200.00, 'Dept Notes - Euro Sales', 'Agenda - Euro Sales',400.00,600.00),
	('Heavenly Sales', 'Sales', 300.00, 'Dept Notes - Heavenly Sales', 'return to Earth',0,300.00),
	('Spanish Sales', 'Euro Sales', 400.00, 'Dept Notes - Spanish Sales', 'return to Earth',0,400.00)
;


INSERT INTO valid_customerlevel (ident, ts, Level_stored, Description)
VALUES 
	(1, now(), 'G','Gold'),
	(2, now(), 'N','Normal'),
	(3, now(), 'S','Silver')
;


INSERT INTO customers (ts, Name, Balance, Credit_Limit, Notes, Customer_Level, Is_Credit_Pre_Approved, Big_Order_Count)
VALUES 
	(now(), 'Gloria''s Garden',100.00,150.00,'Posies A. Lincoln','G',0,0),
	(now(), 'Hibernating Bears',100.00,100000.00,'Bears','S',0,2),
	(now(), 'Max Air',100.00,100000.00,'Max','N',0,2),
	(now(), 'Shari''s Shangri La',0.00,0.00,'Shari','G',0,0),
	(now(), 'Alpha and Sons',0.00,0.00,'Shari','G',0,0)
;


INSERT INTO products (ts, Name, Price, Quantity_On_Hand, Total_quantity_Ordered, Quantity_Reorder, Is_Reorder_Required, Count_Components, Sum_Components_Value, Needs_Usage_Terms, Is_Active,Notes, Is_Secret)
VALUES 
	(now(), 'Hammer',10.0000,0,4,100,0,0,0.0000,0,1,'Hammer Notes', false),
	(now(), 'Big Hammer',10.0000,0,4,100,0,0,0.0000,0,1,'Big Hammer Notes', false),
	(now(), 'Shovel',20.0000,0,8,200,0,0,0.0000,0,1,'Shovel Notes', false),
	(now(), 'Mallet',500.0000,0,0,500,0,0,0.0000,0,0,'Mallet Notes', false),
	(now(), 'Dynamite',500.0000,0,0,500,0,0,0.0000,0,1,'Dyno Notes - not to be taken internally', false),
	(now(), 'Boing 747X',0.0000,0,0,300,0,0,0.0000,0,1,'Boing Notes', false),
	(now(), 'WingX',0.0000,2,0,10,0,0,0.0000,0,1,'WingX Notes', false),
	(now(), 'Boing 747',10300.0000,0,0,300,0,3,10300.0000,0,1,'Boing 747 Notes', false),
	(now(), 'Fuselage',1300.0000,4,0,5,0,0,0.0000,0,1,'WingX Notes', false),
	(now(), 'Wing',4000.0000,2,0,10,0,2,4000.00,0,1,'Wing Notes', false),
	(now(), 'Engine',1500.00,3,0,20,0,0,0.00,0,1,'Engine Notes', false),
	(now(), 'Bolt',10.00,4000,0,10000,0,0,0.00,0,1,'Bolt Notes', false),
	(now(), 'Stealth Bolt',20.00,5000,0,10000,0,0,0.00,0,1,'Stealth Bolt Notes', true)
;


INSERT INTO product_billofmaterials (ts, Product_Name_Kit, Product_Name, Kit_Number_Required, Value)
VALUES 
	(now(), 'Boing 747','Fuselage',1,1300),
	(now(), 'Boing 747','Wing',2,8000),
	(now(), 'Boing 747','Bolt',100,1000),
	(now(), 'Wing','Engine',2,3000),
	(now(), 'Wing','Bolt',100,1000)
;


INSERT INTO employees (ts, Name, Base_Salary, Department_Name, on_loan_department_name, Employee_Type, notes)
VALUES 
	(now(), 'Lt Kiji',150000.00, NULL,NULL,'exempt','Protects us from Uncle Joe'),
	(now(), 'A. Lincoln',250000.00, 'Heavenly Sales',NULL,'exempt','from Ky'),
	(now(), 'M. Ghandi',250000.00, NULL,NULL,'exempt','non violence 1'),
	(now(), 'M. King',250000.00, NULL,NULL,'exempt','non violence 1'),
	(now(), 'Willie Loman',40000.00,'US Sales',NULL,'salesrep','ah'),
	(now(), 'charlie',40000.00,'US Sales',NULL,'salesrep','tuna'),
	(now(), 'Sami Stoner',44000.00,'Euro Sales',NULL,'salesrep','on a high')
;
	
	
INSERT INTO orders (ident, ts, Amount_Total, Amount_Discounted, Amount_Paid, Amount_Un_Paid, Is_Ready, Approving_Officer, Officer_Item_Usage_Approval,
							Unresolved_Usage_Count, Placed_Date, Due_Date, salesrep_name, customer_name, Cloned_From_Order_ident, Item_Count, empsales_ident)
VALUES
	(1, now(), 50.00,50.00,0.00,50.00,0,'G PO.1','',0,'2013-11-1','2013-12-1','A. Lincoln','Gloria''s Garden',0,2,NULL),
	(2, now(), 50.00,50.00,0.00,50.00,1,'G PO.2','',0,'2013-11-2','2013-12-2','Willie Loman','Gloria''s Garden',0,2,NULL),
	(3, now(), 50.00,50.00,0.00,50.00,1,'M PO.1 = 3','',0,'2013-11-3','2013-12-3','Sami Stoner','Max Air',0,2,NULL),
	(4, now(), 50.00,50.00,0.00,50.00,1,'M PO.2 = 4','',0,'2013-11-4','2013-12-4','Willie Loman','Max Air',0,2,NULL),
	(5, now(), 50.00,50.00,0.00,50.00,1,'M PO.3','',0,'2013-11-5','2013-12-5','Sami Stoner','Max Air',0,2,NULL),
	(6, now(), 50.00,50.00,0.00,50.00,1,'G PO.3','',0,'2013-11-6','2013-12-6','A. Lincoln','Gloria''s Garden',0,2,NULL),
	(7, now(), 50.00,50.00,0.00,50.00,1,'M PO.3','',0,'2013-11-7','2013-12-7','charlie','Max Air',0,2,NULL),
	(8, now(), 20.00,20.00,0.00,20.00,0,'M PO.4','',0,'2013-11-8','2013-12-8','Sami Stoner','Max Air',0,2,NULL),
	(9, now(), 510.00,510.00,0.00,510.00,0,'G PO.4','',0,'2013-11-9','2013-12-9','A. Lincoln','Gloria''s Garden',0,2,NULL),
   (10, now(), 40.00,40.00,0.00,40.00,0,'G PO.5 S*','',0,'2013-11-10','2013-12-10','A. Lincoln','Gloria''s Garden',0,2,NULL),
   (11, now(), 50.00,50.00,0.00,50.00,0,'G PO.1','',0,'2013-11-1','2013-12-1','A. Lincoln','Alpha and Sons',0,2,NULL),
   (12, now(), 50.00,50.00,0.00,50.00,0,'G PO.1','',0,'2013-11-1','2013-12-1','A. Lincoln','Alpha and Sons',0,2,NULL)
;


INSERT INTO lineitems (ts, order_ident, quantity_Ordered, product_name, Part_Price, Amount, Notes, Is_Ready, ident)
VALUES 
	(now(), 1,1,'Hammer',10.00,10.00,'Part 1, Order 1: 1',0,1),
	(now(), 1,2,'Shovel',20.00,40.00,'Part 2, Order 2: 2',0,2),

	(now(), 2,1,'Hammer',10.00,10.00,'Part 1, Order 2: 1',1,3),
	(now(), 2,2,'Shovel',20.00,40.00,'Part 2, Order 2: 2',1,4),

	(now(), 3,1,'Hammer',10.00,10.00,'Part 1, Order 3: 1',1,5),
	(now(), 3,2,'Shovel',20.00,40.00,'Part 2, Order 3: 2',1,6),
	
	(now(), 4,1,'Hammer',10.00,10.00,'Part 1, Order 4: 1',1,7),
	(now(), 4,2,'Shovel',20.00,40.00,'Part 2, Order 4: 2',1,8),
	
	(now(), 5,5,'Hammer',10.00,10.00,'Part 1, Order 5: 1',1,29),

	(now(), 6,1,'Hammer',10.00,10.00,'Part 1, Order 6: 1',1,10),
	(now(), 6,2,'Shovel',20.00,40.00,'Part 2, Order 6: 2',1,11),
	(now(), 7,1,'Hammer',10.00,10.00,'Part 1, Order 7: 1',1,12),
	(now(), 7,2,'Shovel',20.00,40.00,'Part 2, Order 7: 2',1,13),

	(now(), 8,2,'Big Hammer',10.00,20.00,'Part 1, Order 8: 1',0,14),

	(now(), 9,1,'Hammer',10.00,10.00,'Part 1, Order 9: 1',1,15),
	(now(), 9,2,'Mallet',500.00,1000.00,'Part 2, Order 9: 2',1,16),

	(now(), 10,2,'Stealth Bolt',20.00,40.00,'Stealth Bolt for Order 10: 1',1,17),

	(now(), 11,1,'Hammer',10.00,10.00,'Part 1, Order 11: 1',0,18),
	(now(), 11,2,'Shovel',20.00,40.00,'Part 2, Order 11: 2',0,19),

	(now(), 12,1,'Hammer',10.00,10.00,'Part 1, Order 12: 1',0,20),
	(now(), 12,2,'Shovel',20.00,40.00,'Part 2, Order 12: 2',0,21)
;


INSERT INTO lineitem_notes (ident, ts, item_ident, Special_Handling)
VALUES
	(1, now(), 1, 'Pre-loaded Note')
;


INSERT INTO lineitem_usages (ident, ts, Explanation, item_Ident)
VALUES
	(1, now(), 'Not to be taken internally',1)
;

