--Create DataBase Account
--use Account


Create Table Post(
	Id int identity(1,1) Primary Key,
	Content nvarchar(200) not null ,
	PostedTime date DEFAULT getdate() ,
	UserId int references [User](Id)
	
)

Create Table [User] (
	Id int identity(1,1) Primary Key,
	Login nvarchar(200) not null,
	Password nvarchar(200) not null,
	Mail nvarchar(200) not null,
	PeaopleId int references People(ID)
)

Create Table Comment(

	 Id int identity(1,1) Primary Key,
	 UserId int  references [User](Id),
	 PostId int references Post(Id),
	 [Like] int not null,
	 isDeleted bit Default 0
)

Create Table People(

	Id int identity(1,1) Primary Key,
	[Name] nvarchar(200) not null,
	Surname nvarchar(200) not null,
	Age int	not null
)



Insert Into People(Name,Surname,Age) 
Values('Reshad','Dagli',45),
		('Orxan','Lokbatanli',55),
		('Baleli','Meshdaga',39),
		('Perviz','Bulbue',30),
		('Elekber','Yasamalli',58)

Insert Into [User](Login,Password,Mail,PeaopleId)
Values('OrxanDecel','Lokbata123','Orxan123@mail.ru',2),
		('ElekberOt','12345678','ElekberYasamal@mail.ru',5),
		('PervizSamire','87654321','Perviz123@mail.ru',4),
		('Reshad12','124123124','ReshadDagli987@mail.ru',1),
		('Baleli90','baleli05030213324','Baleli@mail.ru',3)


Insert Into Post(Content,PostedTime,UserId)
Values('Qemli Musiqiler','2022-07-15 18:15:00',1),
	  ('TikTok Yayim Tekrari','2021-03-13 12:35:00',5),
	  ('Nasil Yandirilir','2020-11-13 12:35:00',2),
	  ('Toydan Shekil','2019-09-13 12:35:00',4),
	  ('Mashin Maceralari','2018-02-13 12:35:00',3)

Insert Into Comment(UserId,PostId,[Like])
Values(1,1,2500),
	  (2,3,3000),
	  (3,5,10000),
	  (4,4,15000),
	  (5,2,20000)

--1ci Sorgu!
Select Post.Content,COUNT(Comment.Id) From Comment 
Join Post
on
Post.Id = Comment.PostId
Group by Post.Content


--2ci Sorgu!
Select * From GetAllData


--3cu Sorgu
--Selectle birinci hamsini cagiriram sonrada id=1'i silirem ve yene baxdigda ishlediyini gorurem.
CREATE TRIGGER IsDeletedCommentTrigger
ON Comment
INSTEAD OF DELETE
AS
DECLARE @Id int
SELECT @Id = Id from deleted
UPDATE Comment SET isDeleted = 1 WHERE Id = @Id
Select * From Comment 
Delete From Comment where Id = 1





--burdada eyni qayda ile Post table ucun

CREATE TRIGGER IsDeletedPostTrigger
ON Post
INSTEAD OF DELETE
AS
DECLARE @Id int
SELECT @Id = Id from deleted
UPDATE Post SET isDeleted = 1 WHERE Id = @Id

Select * From Post

Delete From Post where Id = 1 

-------Viewwww---------
Create view GetAllData
as
Select  People.Name, People.Surname, People.Age, [User].Login, [User].mail, [User].Password, Post.Content, Post.PostedTime, Comment.[Like] From People
Join [User]
on

People.Id = [User].PeaopleId
Join Post
on
[User].Id = Post.UserId
Join Comment
on
Post.Id = Comment.PostId