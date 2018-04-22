
-- ************************************** `revenues`

CREATE TABLE `revenues`
(
 `revenue_id`        BIGINT NOT NULL ,
 `total`             DECIMAL NOT NULL ,
 `method_of_payment` LINESTRING NOT NULL ,

PRIMARY KEY (`revenue_id`)
);





-- ************************************** `payments`

CREATE TABLE `payments`
(
 `payments_id`       BIGINT NOT NULL ,
 `total`             DECIMAL NOT NULL ,
 `method_of_payment` LINESTRING NOT NULL ,

PRIMARY KEY (`payments_id`)
);





-- ************************************** `users`

CREATE TABLE `users`
(
 `user_id`            BIGINT NOT NULL ,
 `email`              LINESTRING NOT NULL ,
 `name`               LINESTRING NOT NULL ,
 `nickname`           LINESTRING NOT NULL ,
 `image`              LINESTRING NOT NULL ,
 `encrypted_password` LINESTRING NOT NULL ,

PRIMARY KEY (`user_id`)
);





-- ************************************** `other_expenses`

CREATE TABLE `other_expenses`
(
 `other_expense_id` BIGINT NOT NULL ,
 `user_id`          BIGINT NOT NULL ,
 `desc`             LINESTRING NOT NULL ,
 `total`            DECIMAL NOT NULL ,

PRIMARY KEY (`other_expense_id`, `user_id`),
KEY `fkIdx_926` (`user_id`),
CONSTRAINT `FK_926` FOREIGN KEY `fkIdx_926` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `till_receipts`

CREATE TABLE `till_receipts`
(
 `till_receipt_id` BIGINT NOT NULL ,
 `user_id`         BIGINT NOT NULL ,
 `desc`            LINESTRING NOT NULL ,
 `date`            DATE NOT NULL ,
 `person`          LINESTRING NOT NULL ,

PRIMARY KEY (`till_receipt_id`, `user_id`),
KEY `fkIdx_903` (`user_id`),
CONSTRAINT `FK_903` FOREIGN KEY `fkIdx_903` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `credit_notes`

CREATE TABLE `credit_notes`
(
 `credit_note_id` BIGINT NOT NULL ,
 `user_id`        BIGINT NOT NULL ,
 `date`           DATE NOT NULL ,
 `total`          DECIMAL NOT NULL ,

PRIMARY KEY (`credit_note_id`, `user_id`),
KEY `fkIdx_1067` (`user_id`),
CONSTRAINT `FK_1067` FOREIGN KEY `fkIdx_1067` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `contributions`

CREATE TABLE `contributions`
(
 `contribution_id` BIGINT NOT NULL ,
 `user_id`         BIGINT NOT NULL ,
 `type `           LINESTRING NOT NULL ,
 `date`            DATE NOT NULL ,
 `total`           DECIMAL NOT NULL ,

PRIMARY KEY (`contribution_id`, `user_id`),
KEY `fkIdx_744` (`user_id`),
CONSTRAINT `FK_744` FOREIGN KEY `fkIdx_744` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `emloyees`

CREATE TABLE `emloyees`
(
 `employee_id` BIGINT NOT NULL ,
 `user_id`     BIGINT NOT NULL ,
 `name`        LINESTRING NOT NULL ,
 `start_date`  DATETIME NOT NULL ,
 `end_date`    DATETIME NOT NULL ,
 `role`        LINESTRING NOT NULL ,

PRIMARY KEY (`employee_id`, `user_id`),
KEY `fkIdx_520` (`user_id`),
CONSTRAINT `FK_520` FOREIGN KEY `fkIdx_520` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `penalities`

CREATE TABLE `penalities`
(
 `penality_id` BIGINT NOT NULL ,
 `user_id`     BIGINT NOT NULL ,
 `total`       DECIMAL NOT NULL ,
 `date`        DATETIME NOT NULL ,
 `deadline`    DATETIME NOT NULL ,
 `description` LINESTRING NOT NULL ,

PRIMARY KEY (`penality_id`, `user_id`),
KEY `fkIdx_483` (`user_id`),
CONSTRAINT `FK_483` FOREIGN KEY `fkIdx_483` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `vehicles`

CREATE TABLE `vehicles`
(
 `vehicle_id`                BIGINT NOT NULL ,
 `user_id`                   BIGINT NOT NULL ,
 `plate`                     LINESTRING NOT NULL ,
 `type_of_vehicle`           LINESTRING NOT NULL ,
 `charge_general_expences`   BINARY NOT NULL ,
 `roadworthiness_check_date` DATE NOT NULL ,

PRIMARY KEY (`vehicle_id`, `user_id`),
KEY `fkIdx_433` (`user_id`),
CONSTRAINT `FK_433` FOREIGN KEY `fkIdx_433` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `insurances`

CREATE TABLE `insurances`
(
 `insurance_id`       BIGINT NOT NULL ,
 `user_id`            BIGINT NOT NULL ,
 `date`               DATETIME NOT NULL ,
 `total`              DECIMAL NOT NULL ,
 `serial_of_contract` LINESTRING NOT NULL ,
 `description`        LINESTRING NOT NULL ,
 `recurrence`         INTEGER NOT NULL ,
 `deadline`           DATETIME NOT NULL ,
 `activation_date`    DATE NOT NULL ,

PRIMARY KEY (`insurance_id`, `user_id`),
KEY `fkIdx_1019` (`user_id`),
CONSTRAINT `FK_1019` FOREIGN KEY `fkIdx_1019` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `active_invoices`

CREATE TABLE `active_invoices`
(
 `active_invoice_id` BIGINT NOT NULL ,
 `user_id`           BIGINT NOT NULL ,
 `description`       LINESTRING NOT NULL ,
 `serial_number`     LINESTRING NOT NULL ,
 `deadline`          DATETIME NOT NULL ,
 `date_of_issue`     DATETIME NOT NULL ,

PRIMARY KEY (`active_invoice_id`, `user_id`),
KEY `fkIdx_1061` (`user_id`),
CONSTRAINT `FK_1061` FOREIGN KEY `fkIdx_1061` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `companies`

CREATE TABLE `companies`
(
 `company_id` BIGINT NOT NULL ,
 `user_id`    BIGINT NOT NULL ,
 `number`     LINESTRING NOT NULL ,
 `address`    LINESTRING NOT NULL ,
 `name`       LINESTRING NOT NULL ,

PRIMARY KEY (`company_id`, `user_id`),
KEY `fkIdx_1037` (`user_id`),
CONSTRAINT `FK_1037` FOREIGN KEY `fkIdx_1037` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `invoices`

CREATE TABLE `invoices`
(
 `invoice_id`    BIGINT NOT NULL ,
 `user_id`       BIGINT NOT NULL ,
 `deadline`      DATE NOT NULL ,
 `description`   LINESTRING NOT NULL ,
 `serial_number` LINESTRING NOT NULL ,
 `paid`          BINARY NOT NULL ,
 `date`          DATE NOT NULL ,

PRIMARY KEY (`invoice_id`, `user_id`),
KEY `fkIdx_974` (`user_id`),
CONSTRAINT `FK_974` FOREIGN KEY `fkIdx_974` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `credit_notes_companies`

CREATE TABLE `credit_notes_companies`
(
 `company_id`     BIGINT NOT NULL ,
 `user_id`        BIGINT NOT NULL ,
 `credit_note_id` BIGINT NOT NULL ,

PRIMARY KEY (`company_id`, `user_id`, `credit_note_id`),
KEY `fkIdx_1052` (`company_id`, `user_id`),
CONSTRAINT `FK_1052` FOREIGN KEY `fkIdx_1052` (`company_id`, `user_id`) REFERENCES `companies` (`company_id`, `user_id`),
KEY `fkIdx_1057` (`credit_note_id`, `user_id`),
CONSTRAINT `FK_1057` FOREIGN KEY `fkIdx_1057` (`credit_note_id`, `user_id`) REFERENCES `credit_notes` (`credit_note_id`, `user_id`)
);





-- ************************************** `active_invoices_companies`

CREATE TABLE `active_invoices_companies`
(
 `active_invoice_id` BIGINT NOT NULL ,
 `company_id`        BIGINT NOT NULL ,
 `user_id`           BIGINT NOT NULL ,

PRIMARY KEY (`active_invoice_id`, `company_id`, `user_id`),
KEY `fkIdx_1033` (`active_invoice_id`, `user_id`),
CONSTRAINT `FK_1033` FOREIGN KEY `fkIdx_1033` (`active_invoice_id`, `user_id`) REFERENCES `active_invoices` (`active_invoice_id`, `user_id`),
KEY `fkIdx_1047` (`company_id`, `user_id`),
CONSTRAINT `FK_1047` FOREIGN KEY `fkIdx_1047` (`company_id`, `user_id`) REFERENCES `companies` (`company_id`, `user_id`)
);





-- ************************************** `insurances_companies`

CREATE TABLE `insurances_companies`
(
 `insurance_id` BIGINT NOT NULL ,
 `company_id`   BIGINT NOT NULL ,
 `user_id`      BIGINT NOT NULL ,

PRIMARY KEY (`insurance_id`, `company_id`, `user_id`),
KEY `fkIdx_1010` (`insurance_id`, `user_id`),
CONSTRAINT `FK_1010` FOREIGN KEY `fkIdx_1010` (`insurance_id`, `user_id`) REFERENCES `insurances` (`insurance_id`, `user_id`),
KEY `fkIdx_1016` (`company_id`, `user_id`),
CONSTRAINT `FK_1016` FOREIGN KEY `fkIdx_1016` (`company_id`, `user_id`) REFERENCES `companies` (`company_id`, `user_id`)
);





-- ************************************** `invoices_companies`

CREATE TABLE `invoices_companies`
(
 `invoice_id` BIGINT NOT NULL ,
 `user_id`    BIGINT NOT NULL ,
 `company_id` BIGINT NOT NULL ,

PRIMARY KEY (`invoice_id`, `user_id`, `company_id`),
KEY `fkIdx_980` (`invoice_id`, `user_id`),
CONSTRAINT `FK_980` FOREIGN KEY `fkIdx_980` (`invoice_id`, `user_id`) REFERENCES `invoices` (`invoice_id`, `user_id`),
KEY `fkIdx_1043` (`company_id`, `user_id`),
CONSTRAINT `FK_1043` FOREIGN KEY `fkIdx_1043` (`company_id`, `user_id`) REFERENCES `companies` (`company_id`, `user_id`)
);





-- ************************************** `vehicle_tax`

CREATE TABLE `vehicle_tax`
(
 `vehicle_tax_id` BIGINT NOT NULL ,
 `vehicle_id`     BIGINT NOT NULL ,
 `user_id`        BIGINT NOT NULL ,
 `date`           DATE NOT NULL ,
 `deadline`       DATE NOT NULL ,
 `total`          DECIMAL NOT NULL ,

PRIMARY KEY (`vehicle_tax_id`, `vehicle_id`, `user_id`),
KEY `fkIdx_954` (`vehicle_id`, `user_id`),
CONSTRAINT `FK_954` FOREIGN KEY `fkIdx_954` (`vehicle_id`, `user_id`) REFERENCES `vehicles` (`vehicle_id`, `user_id`)
);





-- ************************************** `active_invoices_revenues`

CREATE TABLE `active_invoices_revenues`
(
 `revenue_id`        BIGINT NOT NULL ,
 `active_invoice_id` BIGINT NOT NULL ,
 `user_id`           BIGINT NOT NULL ,

PRIMARY KEY (`revenue_id`, `active_invoice_id`, `user_id`),
KEY `fkIdx_801` (`revenue_id`),
CONSTRAINT `FK_801` FOREIGN KEY `fkIdx_801` (`revenue_id`) REFERENCES `revenues` (`revenue_id`),
KEY `fkIdx_1083` (`active_invoice_id`, `user_id`),
CONSTRAINT `FK_1083` FOREIGN KEY `fkIdx_1083` (`active_invoice_id`, `user_id`) REFERENCES `active_invoices` (`active_invoice_id`, `user_id`)
);





-- ************************************** `credit_notes_revenues`

CREATE TABLE `credit_notes_revenues`
(
 `credit_note_id` BIGINT NOT NULL ,
 `revenue_id`     BIGINT NOT NULL ,
 `user_id`        BIGINT NOT NULL ,

PRIMARY KEY (`credit_note_id`, `revenue_id`, `user_id`),
KEY `fkIdx_776` (`credit_note_id`, `user_id`),
CONSTRAINT `FK_776` FOREIGN KEY `fkIdx_776` (`credit_note_id`, `user_id`) REFERENCES `credit_notes` (`credit_note_id`, `user_id`),
KEY `fkIdx_782` (`revenue_id`),
CONSTRAINT `FK_782` FOREIGN KEY `fkIdx_782` (`revenue_id`) REFERENCES `revenues` (`revenue_id`)
);





-- ************************************** `contributions_payments`

CREATE TABLE `contributions_payments`
(
 `contribution_id` BIGINT NOT NULL ,
 `user_id`         BIGINT NOT NULL ,
 `payments_id`     BIGINT NOT NULL ,

PRIMARY KEY (`contribution_id`, `user_id`, `payments_id`),
KEY `fkIdx_752` (`contribution_id`, `user_id`),
CONSTRAINT `FK_752` FOREIGN KEY `fkIdx_752` (`contribution_id`, `user_id`) REFERENCES `contributions` (`contribution_id`, `user_id`),
KEY `fkIdx_757` (`payments_id`),
CONSTRAINT `FK_757` FOREIGN KEY `fkIdx_757` (`payments_id`) REFERENCES `payments` (`payments_id`)
);





-- ************************************** `penalities_payments`

CREATE TABLE `penalities_payments`
(
 `penality_id` BIGINT NOT NULL ,
 `user_id`     BIGINT NOT NULL ,
 `payments_id` BIGINT NOT NULL ,

PRIMARY KEY (`penality_id`, `user_id`, `payments_id`),
KEY `fkIdx_628` (`penality_id`, `user_id`),
CONSTRAINT `FK_628` FOREIGN KEY `fkIdx_628` (`penality_id`, `user_id`) REFERENCES `penalities` (`penality_id`, `user_id`),
KEY `fkIdx_695` (`payments_id`),
CONSTRAINT `FK_695` FOREIGN KEY `fkIdx_695` (`payments_id`) REFERENCES `payments` (`payments_id`)
);





-- ************************************** `loads`

CREATE TABLE `loads`
(
 `loads_id`       BIGINT NOT NULL ,
 `user_id`        BIGINT NOT NULL ,
 `vehicle_id`     BIGINT NOT NULL ,
 `from`           LINESTRING NOT NULL ,
 `to`             LINESTRING NOT NULL ,
 `provinces`      LINESTRING NOT NULL ,
 `serial_number`  LINESTRING ,
 `km`             INTEGER NOT NULL ,
 `weight`         INTEGER NOT NULL ,
 `weight_unit`    LINESTRING ,
 `price_per_unit` DECIMAL ,
 `date`           DATE NOT NULL ,
 `notes`          LINESTRING ,

PRIMARY KEY (`loads_id`, `user_id`, `vehicle_id`),
KEY `fkIdx_576` (`vehicle_id`, `user_id`),
CONSTRAINT `FK_576` FOREIGN KEY `fkIdx_576` (`vehicle_id`, `user_id`) REFERENCES `vehicles` (`vehicle_id`, `user_id`)
);





-- ************************************** `maintenance`

CREATE TABLE `maintenance`
(
 `maintenance_id` BIGINT NOT NULL ,
 `vehicle_id`     BIGINT NOT NULL ,
 `user_id`        BIGINT NOT NULL ,
 `date`           DATE NOT NULL ,
 `description`    LINESTRING NOT NULL ,
 `deadline`       DATE NOT NULL ,
 `km`             INTEGER NOT NULL ,

PRIMARY KEY (`maintenance_id`, `vehicle_id`, `user_id`),
KEY `fkIdx_558` (`vehicle_id`, `user_id`),
CONSTRAINT `FK_558` FOREIGN KEY `fkIdx_558` (`vehicle_id`, `user_id`) REFERENCES `vehicles` (`vehicle_id`, `user_id`)
);





-- ************************************** `salaries`

CREATE TABLE `salaries`
(
 `salary_id`   BIGINT NOT NULL ,
 `employee_id` BIGINT NOT NULL ,
 `user_id`     BIGINT NOT NULL ,
 `total`       DECIMAL NOT NULL ,
 `month`       DATE NOT NULL ,
 `deadline`    DATE NOT NULL ,

PRIMARY KEY (`salary_id`, `employee_id`, `user_id`),
KEY `fkIdx_531` (`employee_id`, `user_id`),
CONSTRAINT `FK_531` FOREIGN KEY `fkIdx_531` (`employee_id`, `user_id`) REFERENCES `emloyees` (`employee_id`, `user_id`)
);





-- ************************************** `penalities_vehicles`

CREATE TABLE `penalities_vehicles`
(
 `vehicle_id`  BIGINT NOT NULL ,
 `user_id`     BIGINT NOT NULL ,
 `penality_id` BIGINT NOT NULL ,

PRIMARY KEY (`vehicle_id`, `user_id`, `penality_id`),
KEY `fkIdx_487` (`vehicle_id`, `user_id`),
CONSTRAINT `FK_487` FOREIGN KEY `fkIdx_487` (`vehicle_id`, `user_id`) REFERENCES `vehicles` (`vehicle_id`, `user_id`),
KEY `fkIdx_492` (`penality_id`, `user_id`),
CONSTRAINT `FK_492` FOREIGN KEY `fkIdx_492` (`penality_id`, `user_id`) REFERENCES `penalities` (`penality_id`, `user_id`)
);





-- ************************************** `sold_line_items`

CREATE TABLE `sold_line_items`
(
 `sold_line_item_id` BIGINT NOT NULL ,
 `active_invoice_id` BIGINT NOT NULL ,
 `user_id`           BIGINT NOT NULL ,
 `vat`               INTEGER NOT NULL ,
 `amout`             DECIMAL NOT NULL ,
 `description`       LINESTRING NOT NULL ,
 `quantity`          INTEGER NOT NULL ,

PRIMARY KEY (`sold_line_item_id`, `active_invoice_id`, `user_id`),
KEY `fkIdx_1072` (`active_invoice_id`, `user_id`),
CONSTRAINT `FK_1072` FOREIGN KEY `fkIdx_1072` (`active_invoice_id`, `user_id`) REFERENCES `active_invoices` (`active_invoice_id`, `user_id`)
);





-- ************************************** `line_items`

CREATE TABLE `line_items`
(
 `line_item_id` BIGINT NOT NULL ,
 `invoice_id`   BIGINT NOT NULL ,
 `user_id`      BIGINT NOT NULL ,
 `vat`          INTEGER NOT NULL ,
 `amount`       DECIMAL NOT NULL ,
 `description`  LINESTRING NOT NULL ,
 `quantity`     INTEGER NOT NULL ,

PRIMARY KEY (`line_item_id`, `invoice_id`, `user_id`),
KEY `fkIdx_703` (`invoice_id`, `user_id`),
CONSTRAINT `FK_703` FOREIGN KEY `fkIdx_703` (`invoice_id`, `user_id`) REFERENCES `invoices` (`invoice_id`, `user_id`)
);





-- ************************************** `invoices_vehicles`

CREATE TABLE `invoices_vehicles`
(
 `vehicle_id` BIGINT NOT NULL ,
 `user_id`    BIGINT NOT NULL ,
 `invoice_id` BIGINT NOT NULL ,
 `total`      DECIMAL NOT NULL ,

PRIMARY KEY (`vehicle_id`, `user_id`, `invoice_id`),
KEY `fkIdx_438` (`vehicle_id`, `user_id`),
CONSTRAINT `FK_438` FOREIGN KEY `fkIdx_438` (`vehicle_id`, `user_id`) REFERENCES `vehicles` (`vehicle_id`, `user_id`),
KEY `fkIdx_443` (`invoice_id`, `user_id`),
CONSTRAINT `FK_443` FOREIGN KEY `fkIdx_443` (`invoice_id`, `user_id`) REFERENCES `invoices` (`invoice_id`, `user_id`)
);





-- ************************************** `invoices_payments`

CREATE TABLE `invoices_payments`
(
 `invoice_id`  BIGINT NOT NULL ,
 `payments_id` BIGINT NOT NULL ,
 `user_id`     BIGINT NOT NULL ,

PRIMARY KEY (`invoice_id`, `payments_id`, `user_id`),
KEY `fkIdx_332` (`invoice_id`, `user_id`),
CONSTRAINT `FK_332` FOREIGN KEY `fkIdx_332` (`invoice_id`, `user_id`) REFERENCES `invoices` (`invoice_id`, `user_id`),
KEY `fkIdx_399` (`payments_id`),
CONSTRAINT `FK_399` FOREIGN KEY `fkIdx_399` (`payments_id`) REFERENCES `payments` (`payments_id`)
);





-- ************************************** `insurances_vehicles`

CREATE TABLE `insurances_vehicles`
(
 `id`           BIGINT NOT NULL ,
 `insurance_id` BIGINT NOT NULL ,
 `user_id`      BIGINT NOT NULL ,
 `vehicle_id`   BIGINT NOT NULL ,

PRIMARY KEY (`id`, `insurance_id`, `user_id`, `vehicle_id`),
KEY `fkIdx_312` (`insurance_id`, `user_id`),
CONSTRAINT `FK_312` FOREIGN KEY `fkIdx_312` (`insurance_id`, `user_id`) REFERENCES `insurances` (`insurance_id`, `user_id`),
KEY `fkIdx_466` (`vehicle_id`, `user_id`),
CONSTRAINT `FK_466` FOREIGN KEY `fkIdx_466` (`vehicle_id`, `user_id`) REFERENCES `vehicles` (`vehicle_id`, `user_id`)
);





-- ************************************** `insurance_receipts`

CREATE TABLE `insurance_receipts`
(
 `insurance_receipts_id` BIGINT NOT NULL ,
 `insurance_id`          BIGINT NOT NULL ,
 `user_id`               BIGINT NOT NULL ,
 `date`                  DATETIME NOT NULL ,
 `policy_number`         LINESTRING NOT NULL ,
 `method_of_payment`     LINESTRING NOT NULL ,
 `paid`                  DECIMAL NOT NULL ,

PRIMARY KEY (`insurance_receipts_id`, `insurance_id`, `user_id`),
KEY `fkIdx_459` (`insurance_id`, `user_id`),
CONSTRAINT `FK_459` FOREIGN KEY `fkIdx_459` (`insurance_id`, `user_id`) REFERENCES `insurances` (`insurance_id`, `user_id`)
);





-- ************************************** `fuel_receipts`

CREATE TABLE `fuel_receipts`
(
 `fuel_receipt_id` BIGINT NOT NULL ,
 `vehicle_id`      BIGINT NOT NULL ,
 `user_id`         BIGINT NOT NULL ,
 `total`           DECIMAL NOT NULL ,
 `date`            DATETIME NOT NULL ,

PRIMARY KEY (`fuel_receipt_id`, `vehicle_id`, `user_id`),
KEY `fkIdx_449` (`vehicle_id`, `user_id`),
CONSTRAINT `FK_449` FOREIGN KEY `fkIdx_449` (`vehicle_id`, `user_id`) REFERENCES `vehicles` (`vehicle_id`, `user_id`),
KEY `fkIdx_1003` (`user_id`),
CONSTRAINT `FK_1003` FOREIGN KEY `fkIdx_1003` (`user_id`) REFERENCES `users` (`user_id`)
);





-- ************************************** `fuel_receipts_companies`

CREATE TABLE `fuel_receipts_companies`
(
 `fuel_receipt_id` BIGINT NOT NULL ,
 `vehicle_id`      BIGINT NOT NULL ,
 `user_id`         BIGINT NOT NULL ,
 `company_id`      BIGINT NOT NULL ,

PRIMARY KEY (`fuel_receipt_id`, `vehicle_id`, `user_id`, `company_id`),
KEY `fkIdx_993` (`fuel_receipt_id`, `vehicle_id`, `user_id`),
CONSTRAINT `FK_993` FOREIGN KEY `fkIdx_993` (`fuel_receipt_id`, `vehicle_id`, `user_id`) REFERENCES `fuel_receipts` (`fuel_receipt_id`, `vehicle_id`, `user_id`),
KEY `fkIdx_1000` (`company_id`, `user_id`),
CONSTRAINT `FK_1000` FOREIGN KEY `fkIdx_1000` (`company_id`, `user_id`) REFERENCES `companies` (`company_id`, `user_id`)
);





-- ************************************** `vehicle_tax_payments`

CREATE TABLE `vehicle_tax_payments`
(
 `vehicle_tax_id` BIGINT NOT NULL ,
 `vehicle_id`     BIGINT NOT NULL ,
 `user_id`        BIGINT NOT NULL ,
 `payments_id`    BIGINT NOT NULL ,

PRIMARY KEY (`vehicle_tax_id`, `vehicle_id`, `user_id`, `payments_id`),
KEY `fkIdx_959` (`vehicle_tax_id`, `vehicle_id`, `user_id`),
CONSTRAINT `FK_959` FOREIGN KEY `fkIdx_959` (`vehicle_tax_id`, `vehicle_id`, `user_id`) REFERENCES `vehicle_tax` (`vehicle_tax_id`, `vehicle_id`, `user_id`),
KEY `fkIdx_965` (`payments_id`),
CONSTRAINT `FK_965` FOREIGN KEY `fkIdx_965` (`payments_id`) REFERENCES `payments` (`payments_id`)
);





-- ************************************** `insurances_payments`

CREATE TABLE `insurances_payments`
(
 `insurance_receipts_id` BIGINT NOT NULL ,
 `insurance_id`          BIGINT NOT NULL ,
 `payments_id`           BIGINT NOT NULL ,
 `user_id`               BIGINT NOT NULL ,

PRIMARY KEY (`insurance_receipts_id`, `insurance_id`, `payments_id`, `user_id`),
KEY `fkIdx_613` (`insurance_receipts_id`, `insurance_id`, `user_id`),
CONSTRAINT `FK_613` FOREIGN KEY `fkIdx_613` (`insurance_receipts_id`, `insurance_id`, `user_id`) REFERENCES `insurance_receipts` (`insurance_receipts_id`, `insurance_id`, `user_id`),
KEY `fkIdx_689` (`payments_id`),
CONSTRAINT `FK_689` FOREIGN KEY `fkIdx_689` (`payments_id`) REFERENCES `payments` (`payments_id`)
);





-- ************************************** `loads_invoices`

CREATE TABLE `loads_invoices`
(
 `loads_id`          BIGINT NOT NULL ,
 `user_id`           BIGINT NOT NULL ,
 `vehicle_id`        BIGINT NOT NULL ,
 `active_invoice_id` BIGINT NOT NULL ,

PRIMARY KEY (`loads_id`, `user_id`, `vehicle_id`, `active_invoice_id`),
KEY `fkIdx_585` (`loads_id`, `user_id`, `vehicle_id`),
CONSTRAINT `FK_585` FOREIGN KEY `fkIdx_585` (`loads_id`, `user_id`, `vehicle_id`) REFERENCES `loads` (`loads_id`, `user_id`, `vehicle_id`),
KEY `fkIdx_1088` (`active_invoice_id`, `user_id`),
CONSTRAINT `FK_1088` FOREIGN KEY `fkIdx_1088` (`active_invoice_id`, `user_id`) REFERENCES `active_invoices` (`active_invoice_id`, `user_id`)
);





-- ************************************** `salaries_payments`

CREATE TABLE `salaries_payments`
(
 `payments_id` BIGINT NOT NULL ,
 `salary_id`   BIGINT NOT NULL ,
 `employee_id` BIGINT NOT NULL ,
 `user_id`     BIGINT NOT NULL ,

PRIMARY KEY (`payments_id`, `salary_id`, `employee_id`, `user_id`),
KEY `fkIdx_540` (`payments_id`),
CONSTRAINT `FK_540` FOREIGN KEY `fkIdx_540` (`payments_id`) REFERENCES `payments` (`payments_id`),
KEY `fkIdx_544` (`salary_id`, `employee_id`, `user_id`),
CONSTRAINT `FK_544` FOREIGN KEY `fkIdx_544` (`salary_id`, `employee_id`, `user_id`) REFERENCES `salaries` (`salary_id`, `employee_id`, `user_id`)
);





-- ************************************** `invoices_fuel_receipts`

CREATE TABLE `invoices_fuel_receipts`
(
 `invoice_id`      BIGINT NOT NULL ,
 `user_id`         BIGINT NOT NULL ,
 `fuel_receipt_id` BIGINT NOT NULL ,
 `vehicle_id`      BIGINT NOT NULL ,

PRIMARY KEY (`invoice_id`, `user_id`, `fuel_receipt_id`, `vehicle_id`),
KEY `fkIdx_500` (`invoice_id`, `user_id`),
CONSTRAINT `FK_500` FOREIGN KEY `fkIdx_500` (`invoice_id`, `user_id`) REFERENCES `invoices` (`invoice_id`, `user_id`),
KEY `fkIdx_507` (`fuel_receipt_id`, `vehicle_id`, `user_id`),
CONSTRAINT `FK_507` FOREIGN KEY `fkIdx_507` (`fuel_receipt_id`, `vehicle_id`, `user_id`) REFERENCES `fuel_receipts` (`fuel_receipt_id`, `vehicle_id`, `user_id`)
);
