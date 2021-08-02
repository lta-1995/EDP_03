DROP DATABASE IF EXISTS Testing_System_Assignment_2;
CREATE DATABASE Testing_System_Assignment_2;
USE Testing_System_Assignment_2;

-- CREATE TABLE 1: DEPARTMENT
CREATE TABLE Department (
	DepartmentID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName	NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- CREATE TABLE 2: POSITION
CREATE TABLE Position (
	PositionID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName 	ENUM('Dev','Test','Scrum Manager','PM') NOT NULL UNIQUE KEY
);

-- CREATE TABLE 3: ACCOUNT
CREATE TABLE  `Account` (
	AccountID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(50) NOT NULL UNIQUE KEY,
    Username		VARCHAR(50) CHECK (length(username) >= 6 ) NOT NULL UNIQUE KEY,
    Fullname		NVARCHAR(50) NOT NULL,
    DepartmentID	TINYINT UNSIGNED NOT NULL,
    PositionID		SMALLINT UNSIGNED NOT NULL,
    CreateDate		DATE NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES Position (PositionID)
    );
    
 -- CREATE TABLE 4: GROUP   
CREATE TABLE `Group` (
	GroupID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName		NVARCHAR(50) NOT NULL,
    CreatorID		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATE
);

-- CREATE TABLE 5: GROUP ACCOUNT
CREATE TABLE GroupAccount (
	GroupID			TINYINT UNSIGNED NOT NULL,
    AccountID		TINYINT UNSIGNED NOT NULL,
    JoinDate		DATE
);

-- CREATE TABLE 6: TYPE QUESTION
CREATE TABLE TypeQuestion (
	TypeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 		ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

-- CREATE TABLE 7: CATEGORY QUESTION
CREATE TABLE CategoryQuestion (
	CategoryID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	CategoryName	NVARCHAR(50)	NOT NULL
);

-- CREATE TABLE 8: QUESTION
CREATE TABLE Question (
	QuestionID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			NVARCHAR(10000),
    CategoryID		TINYINT UNSIGNED,
    TypeID 			TINYINT UNSIGNED,
    CreatorID		TINYINT UNSIGNED,
    CreateDate		DATE,
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
);

-- CREATE TABLE 9: ANSWER
CREATE TABLE Answer (
	AnswerID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			NVARCHAR(50),
    QuestionID		TINYINT UNSIGNED, 
    isCorrect		ENUM('True','False'),
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);
 
 -- CREATE TABLE 10: EXAM
 CREATE TABLE Exam (
	ExamID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`			SMALLINT UNSIGNED UNIQUE KEY NOT NULL,
    Tittle			NVARCHAR(50) NOT NULL,
    CategoryID 		TINYINT UNSIGNED NOT NULL,
    Duration 		TINYINT NOT NULL,
    CreatorID		TINYINT UNSIGNED NOT NULL, 
    CreateDate		DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
 );
 
 -- CREATE TABLE 11: EXAM QUESTION
 CREATE TABLE ExamQuestion (
	ExamID			TINYINT UNSIGNED PRIMARY KEY,
	QuestionID		TINYINT UNSIGNED,
    FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
 );
 
 
 
-- ======================= ADD DATA INTO TABLES=======================
-- ===================================================================

-- Add data into "Department"
INSERT INTO Department	(DepartmentName)
VALUES					(N'Giám đốc'),
						(N'Thư ký'),
                        (N'Nhân sự'),
                        (N'Kỹ thuật'),
						(N'Sale'),
                        (N'Bảo vệ'),
                        (N'Nhà bếp'),
                        (N'Quản đốc'),
                        (N'Kế toán'),
                        (N'Pháp chế');
					
-- Add data into "Position"
INSERT INTO Position (PositionName)
VALUES 				 ('Dev'			),
					 ('Test'		),
					 ('Scrum Manager'),
					 ('PM'			);
                        
-- Add data into "Account"
INSERT INTO `Account` 	(Email 					,Username 		,Fullname 			,DepartmentID 	,PositionID 	,CreateDate)
VALUES 					('cuongtoi123@gmail.com','cuongtoi'		,'Châu Việt Cường'  ,'1'			,'2'			,'2020-01-02'),
                        ('tuananh999@gmail.com'	,'tuananh'		,'Lương Tuấn Anh'	,'2'			,'4'			,'2020-02-03'),
						('huanhoahong@yahoo.com','huanhoahong'	,'Bùi Xuân Huấn'	,'3'			,'3'			,'2020-03-04'),
                        ('namcamcute@gmail.com'	,'namcam'		,'Trương Văn Cam'	,'4'			,'1'			,'2020-04-05'),
                        ('luyendeath@gmail.com'	,'vailuyen'		,'Lê Văn Luyện'		,'5'			,'2'			,'2020-05-06'),
						('khongminh@gmail.com'	,'giacatluong'	,'Gia Cát Dự'		,'6'			,'1'			,'2020-06-07'),
                        ('taothao@yahoo.com'	,'taothaoduoi'	,'Tào Văn Tháo'		,'7'			,'3'			,'2020-07-08'),
                        ('messi@gmail.com'		,'quabongvang'	,'Nguyễn Quang Hải'	,'8'			,'3'			,'2020-08-09'),
                        ('captain@yahoo.com'	,'tienbip'		,'Nguyễn Mạnh Tiến'	,'9'			,'2'			,'2020-12-23'),
                        ('doandaihiep@yahoo.com','doandaihiep'	,'Doãn Chí Bình'	,'10'			,'2'			,'2020-09-10');
                        
-- Add data into "Group"
INSERT INTO `Group`		(GroupName	 	,CreatorID		,CreateDate)
VALUES					('VTI01'		,5				,'2019-01-02'),
						('VTI02'		,4				,'2020-09-02'),
                        ('VTI03'		,3				,'2020-07-04'),
                        ('VTI04'		,2				,'2020-10-10'),
                        ('VTI05'		,1				,'2020-02-03'),
                        ('VTI06'		,10				,'2020-03-12'),
                        ('VTI07'		,8				,'2020-07-07'),
                        ('VTI08'		,9				,'2020-05-01'),
                        ('VTI09'		,6				,'2020-06-01');
                        
-- Add data into "GroupAccount"
INSERT INTO GroupAccount 	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');
                            
-- Add data into "TypeQuestion"
INSERT INTO TypeQuestion	(TypeName)
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 
                            
-- Add data into "CategoryQuestion"                            
INSERT INTO	CategoryQuestion		(CategoryName	)
VALUES 								('Toán'			),
									('Lý'			),
									('Hóa'			),
									('Sinh'			),
									('Văn'			),
									('Sử'			),
									('Địa'			),
									('Anh'			),
									('Pháp'			),
									('Đức'			);
                                    
-- Add data into "Question"
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về Toán'	,	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'Câu Hỏi về Lý'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về Hóa'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Sinh'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Văn'		,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về Sử'		,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về Địa'		,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về Anh'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về Pháp'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Đức'		,	7		,   '1'			,   '10'	,'2020-04-07');
                        
-- Add data into "Answers" 
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,   1			,	'True'	),
					(N'Trả lời 02'	,   1			,	'False'	),
                    (N'Trả lời 03'	,   1			,	'False'	),
                    (N'Trả lời 04'	,   1			,	'TRUE'	),
                    (N'Trả lời 05'	,   2			,	'False'	),
                    (N'Trả lời 06'	,   3			,	'True'	),
                    (N'Trả lời 07'	,   4			,	'False'	),
                    (N'Trả lời 08'	,   8			,	'False'	),
                    (N'Trả lời 09'	,   9			,	'True'	),
                    (N'Trả lời 10'	,   10			,	'False'	);            
                    
-- Add data into "Exam"
INSERT INTO Exam	(`Code`		, Tittle						, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('1001'		, N'Đề thi Toán'				,	1			,	60		,   '5'			,'2019-04-05'),
					('1002'		, N'Đề thi Lý'					,	10			,	60		,   '2'			,'2019-04-05'),
                    ('1003'		, N'Đề thi Hóa'					,	9			,	120		,   '2'			,'2019-04-07'),
                    ('1004'		, N'Đề thi Sinh'				,	6			,	60		,   '3'			,'2020-04-08'),
                    ('1005'		, N'Đề thi Văn'					,	5			,	120		,   '4'			,'2020-04-10'),
                    ('1006'		, N'Đề thi Sử'					,	3			,	60		,   '6'			,'2020-04-05'),
                    ('1007'		, N'Đề thi Địa'					,	2			,	60		,   '7'			,'2020-04-05'),
                    ('1008'		, N'Đề thi Anh'					,	8			,	60		,   '8'			,'2020-04-07'),
                    ('1009'		, N'Đề thi Pháp'				,	4			,	90		,   '9'			,'2020-04-07'),
                    ('1010'		, N'Đề thi Đức'					,	7			,	90		,   '10'		,'2020-04-08');         
                    
-- Add data "ExamQuestion"
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 
                        
					


 
