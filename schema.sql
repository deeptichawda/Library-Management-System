CREATE SCHEMA `library_management` ;

USE `library_management` ;

CREATE TABLE `library_management`.`Librarian` (
  `LibrarianID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(15) NOT NULL,
  `LastName` VARCHAR(15) NULL,
  `UserName` VARCHAR(10) NOT NULL,
  `Password` VARCHAR(256) NOT NULL,
  `Mobile` CHAR(10) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `Address` VARCHAR(150) NOT NULL,
  `DOB` DATE NOT NULL,
  `Salary` DOUBLE NOT NULL,
  `AccountNumber` VARCHAR(20) NOT NULL,
  `IFSC` VARCHAR(20) NOT NULL,
  `JoiningDate` DATE NOT NULL,
  `LeavingDate` DATE NULL,
  PRIMARY KEY (`LibrarianID`),
  UNIQUE INDEX `LibrarianID_UNIQUE` (`LibrarianID` ASC) VISIBLE,
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC) VISIBLE);

CREATE TABLE `library_management`.`Member` (
  `MemberID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(15) NOT NULL,
  `LastName` VARCHAR(15) NOT NULL,
  `UserName` VARCHAR(10) NOT NULL,
  `Password` VARCHAR(256) NOT NULL,
  `Mobile` CHAR(10) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `Address` VARCHAR(150) NOT NULL,
  `DOB` DATE NOT NULL,
  `Status` TINYINT NOT NULL,
  `JoiningDate` DATE NOT NULL,
  `ExpiryDate` DATE NOT NULL,
  `NoOfBookIssued` INT ZEROFILL NOT NULL,
  PRIMARY KEY (`MemberID`),
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC) VISIBLE);

CREATE TABLE `library_management`.`Book` (
  `BookID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  `AuthorName` VARCHAR(30) NOT NULL,
  `Subject` VARCHAR(30) NOT NULL,
  `PublicationDate` DATE NOT NULL,
  `PublicationHouse` VARCHAR(50) NOT NULL,
  `NoOfCopies` INT ZEROFILL NOT NULL,
  `RackNumber` INT NOT NULL,
  PRIMARY KEY (`BookID`));

CREATE TABLE `library_management`.`BookItem` (
  `BookItemID` INT NOT NULL AUTO_INCREMENT,
  `BookID` INT NOT NULL,
  `Availability` TINYINT NOT NULL,
  `AddDate` DATE NOT NULL,
  PRIMARY KEY (`BookItemID`),
  INDEX `BookID_idx` (`BookID` ASC) VISIBLE,
  CONSTRAINT `BookIDFK`
    FOREIGN KEY (`BookID`)
    REFERENCES `library_management`.`Book` (`BookID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `library_management`.`BookIssue` (
  `IssueID` INT NOT NULL AUTO_INCREMENT,
  `BookItemID` INT NOT NULL,
  `MemberID` INT NOT NULL,
  `IssueDate` DATETIME NOT NULL,
  `ReturnDate` DATETIME NULL,
  PRIMARY KEY (`IssueID`),
  INDEX `MemberIDFK_idx` (`MemberID` ASC) VISIBLE,
  INDEX `BookItemIDFK_idx` (`BookItemID` ASC) VISIBLE,
  CONSTRAINT `BookItemIDFK`
    FOREIGN KEY (`BookItemID`)
    REFERENCES `library_management`.`BookItem` (`BookItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MemberIDFK`
    FOREIGN KEY (`MemberID`)
    REFERENCES `library_management`.`Member` (`MemberID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `library_management`.`BookReserve` (
  `ReserveID` INT NOT NULL AUTO_INCREMENT,
  `BookItemID` INT NOT NULL,
  `MemberID` INT NOT NULL,
  `Status` TINYINT NOT NULL,
  PRIMARY KEY (`ReserveID`),
  INDEX `BookItemIDFK_idx` (`BookItemID` ASC) VISIBLE,
  INDEX `MemberIDFK_idx` (`MemberID` ASC) VISIBLE,
  CONSTRAINT `BookItemIDFK1`
    FOREIGN KEY (`BookItemID`)
    REFERENCES `library_management`.`BookItem` (`BookItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MemberIDFK1`
    FOREIGN KEY (`MemberID`)
    REFERENCES `library_management`.`Member` (`MemberID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `library_management`.`Fine` (
  `FineID` INT NOT NULL AUTO_INCREMENT,
  `BookItemID` INT NOT NULL,
  `MemberID` INT NOT NULL,
  `Amount` INT ZEROFILL NOT NULL,
  `PaymentMethod` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`FineID`),
  INDEX `BookItemIDFK2_idx` (`BookItemID` ASC) VISIBLE,
  INDEX `MemberIDFK2_idx` (`MemberID` ASC) VISIBLE,
  CONSTRAINT `BookItemIDFK2`
    FOREIGN KEY (`BookItemID`)
    REFERENCES `library_management`.`BookItem` (`BookItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MemberIDFK2`
    FOREIGN KEY (`MemberID`)
    REFERENCES `library_management`.`Member` (`MemberID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
