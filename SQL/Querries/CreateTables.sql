USE FiladelfiaDB;
GO

CREATE TABLE Districts(
	Id INT CONSTRAINT PK_District_Id PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL UNIQUE,
);

CREATE TABLE Cities(
	Id INT CONSTRAINT PK_City_Id PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL UNIQUE,
	DistrictId INT CONSTRAINT FK_Cities_To_Districts REFERENCES Districts(Id) NOT NULL,

);

CREATE TABLE Streets(
	Id INT CONSTRAINT PK_Street_Id PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	CityId INT CONSTRAINT FK_Streets_To_Cities REFERENCES Cities(Id) NOT NULL,
);

CREATE TABLE [Indexes](
	Id INT CONSTRAINT PK_Index_Id PRIMARY KEY IDENTITY,
	[Index] NVARCHAR(50) NOT NULL UNIQUE,
);

CREATE TABLE Adresses(
	Id INT CONSTRAINT PK_Adress_Id PRIMARY KEY IDENTITY,
	StreetId INT CONSTRAINT FK_Adresses_To_Streets REFERENCES Streets(Id),
	HouseNumber NVARCHAR(10),
	EntranceNumber NVARCHAR(10),
	ApartmentNumber NVARCHAR(10),
	IndexId INT CONSTRAINT FK_Adresses_To_Indexes REFERENCES [Indexes](Id),
);

CREATE TABLE Contacts(
	Id INT CONSTRAINT PK_Contact_Id PRIMARY KEY IDENTITY,
	AdressId INT CONSTRAINT FK_Contacts_To_Adresses REFERENCES Adresses(Id),
	[E-mail] NVARCHAR(50) UNIQUE,
	MobileNumber NVARCHAR(50) UNIQUE,
	LandlineNumber NVARCHAR(50) UNIQUE,
);

CREATE TABLE MemberTypes(
	Id INT CONSTRAINT PK_MemberType_Id PRIMARY KEY IDENTITY,
	MemberType NVARCHAR(50) UNIQUE,
);

CREATE TABLE Languages(
	Id INT CONSTRAINT PK_Language_Id PRIMARY KEY IDENTITY,
	Language NVARCHAR(50) UNIQUE,
)

CREATE TABLE Adressings(
	Id INT CONSTRAINT PK_Adressing_Id PRIMARY KEY IDENTITY,
	Adressing NVARCHAR(50) UNIQUE,
);

CREATE TABLE PreferableCommunicationChannels(
	Id INT CONSTRAINT PK_PreferableCommunicationChannel_Id PRIMARY KEY IDENTITY,
	InformViaEmail BIT,
	InformViaSMS BIT,
	InformViaPhone BIT,
	InformViaMail BIT,
);

CREATE TABLE Persons(
	Id INT CONSTRAINT PK_Person_Id PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50),
	Surname NVARCHAR(50),
	MiddleName NVARCHAR(50),
	MemberTypeId INT CONSTRAINT FK_Persons_To_MemberTypes REFERENCES MemberTypes(Id),
	LanguageId INT CONSTRAINT FK_Persons_To_Languages REFERENCES Languages(Id),
	AdressingId INT CONSTRAINT FK_Persons_To_Adressings REFERENCES Adressings(Id),
	ContactId INT CONSTRAINT FK_Persons_To_Contacts REFERENCES Contacts(Id) UNIQUE,
	BirthDate DATE,
	IsPoor BIT DEFAULT(0),
	PreferableCommunicationChannelId INT CONSTRAINT FK_PreferableCommunicationChannel_Id REFERENCES PreferableCommunicationChannels(Id),
);

CREATE TABLE DonationTypes(
	Id INT CONSTRAINT PK_DonationType_Id PRIMARY KEY IDENTITY,
	DonationType NVARCHAR(50),
);

CREATE TABLE SubDonations(
	Id INT CONSTRAINT PK_SubDonation_Id PRIMARY KEY IDENTITY,
	DonationTypeId INT REFERENCES DonationTypes(Id),
	DonationSum INT CONSTRAINT CK_SubDonation_DonationSum CHECK(DonationSum >0),
);

CREATE TABLE Donations(
	Id INT CONSTRAINT PK_Donation_Id PRIMARY KEY IDENTITY,
	SubDonationId1 INT CONSTRAINT FK_SubDonationId1_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId2 INT CONSTRAINT FK_SubDonationId2_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId3 INT CONSTRAINT FK_SubDonationId3_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId4 INT CONSTRAINT FK_SubDonationId4_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId5 INT CONSTRAINT FK_SubDonationId5_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId6 INT CONSTRAINT FK_SubDonationId6_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId7 INT CONSTRAINT FK_SubDonationId7_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId8 INT CONSTRAINT FK_SubDonationId8_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId9 INT CONSTRAINT FK_SubDonationId9_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
	SubDonationId10 INT CONSTRAINT FK_SubDonationId10_To_SubDonations REFERENCES SubDonations(Id) UNIQUE,
);

CREATE TABLE StepTypes(
	Id INT CONSTRAINT PK_StepType_Id PRIMARY KEY IDENTITY,
	StepType NVARCHAR(50),
);

CREATE TABLE Steps(
	Id INT CONSTRAINT PK_Step_Id PRIMARY KEY IDENTITY,
	StepTypeId1 INT CONSTRAINT FK_SubDonationId1_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId2 INT CONSTRAINT FK_SubDonationId2_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId3 INT CONSTRAINT FK_SubDonationId3_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId4 INT CONSTRAINT FK_SubDonationId4_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId5 INT CONSTRAINT FK_SubDonationId5_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId6 INT CONSTRAINT FK_SubDonationId6_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId7 INT CONSTRAINT FK_SubDonationId7_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId8 INT CONSTRAINT FK_SubDonationId8_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId9 INT CONSTRAINT FK_SubDonationId9_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
	StepTypeId10 INT CONSTRAINT FK_SubDonationId10_To_StepTypes REFERENCES StepTypes(Id) UNIQUE,
);

CREATE TABLE Visits(
	Id INT CONSTRAINT PK_Visit_Id PRIMARY KEY IDENTITY,
	PersonId INT CONSTRAINT FK_Visits_To_Persons REFERENCES Persons(Id),
	DonationId INT CONSTRAINT FK_Visits_To_Donations REFERENCES Donations(Id),
	Steps INT CONSTRAINT FK_Visits_To_Steps REFERENCES Steps(Id),
	Suggestion NVARCHAR(MAX),
	IsConfidential BIT,
	VisitDate Date,
);

CREATE TABLE FamilyRelationTypes(
	Id INT CONSTRAINT PK_FamilyRelationType_Id PRIMARY KEY IDENTITY,
	FamilyRelationType NVARCHAR(50) UNIQUE,
);

CREATE TABLE FamilyMembers(
	Id INT CONSTRAINT PK_FamilyMember_Id PRIMARY KEY IDENTITY,
	PersonId INT CONSTRAINT FK_FamilyMembers_To_Persons REFERENCES Persons(Id),
	FamilyRelationTypeId INT CONSTRAINT FK_FamilyMembers_To_FamilyRelationTypes REFERENCES FamilyRelationTypes(Id),
);

CREATE TABLE Families(
	Id INT CONSTRAINT PK_Family_Id PRIMARY KEY IDENTITY,
	FamilyMemberId1 INT CONSTRAINT FK_FamilyMemberId1_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId2 INT CONSTRAINT FK_FamilyMemberId2_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId3 INT CONSTRAINT FK_FamilyMemberId3_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId4 INT CONSTRAINT FK_FamilyMemberId4_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId5 INT CONSTRAINT FK_FamilyMemberId5_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId6 INT CONSTRAINT FK_FamilyMemberId6_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId7 INT CONSTRAINT FK_FamilyMemberId7_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId8 INT CONSTRAINT FK_FamilyMemberId8_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId9 INT CONSTRAINT FK_FamilyMemberId9_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId10 INT CONSTRAINT FK_FamilyMemberId10_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId11 INT CONSTRAINT FK_FamilyMemberId11_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId12 INT CONSTRAINT FK_FamilyMemberId12_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId13 INT CONSTRAINT FK_FamilyMemberId13_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId14 INT CONSTRAINT FK_FamilyMemberId14_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
	FamilyMemberId15 INT CONSTRAINT FK_FamilyMemberId15_To_FamilyMembers REFERENCES FamilyMembers(Id) UNIQUE,
);