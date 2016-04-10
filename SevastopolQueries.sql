--Complete list of all deceased residents of Sevastopol station
SELECT tblResident.Firstname, tblResident.Lastname, tblDepartment.DepartmentName, 
tblOrigin.PlanetName AS "Planetary Origin", tblRank.RankName AS "Rank", tblGender.Gender
FROM tblDeceased 
INNER JOIN tblResident ON tblDeceased.ResidentID = tblResident.ResidentID 
INNER JOIN tblGender ON tblResident.GenderID = tblGender.GenderID 
INNER JOIN tblOrigin ON tblResident.OriginID = tblOrigin.OriginID 
INNER JOIN tblRank ON tblResident.RankID = tblRank.RankID 
INNER JOIN tblResidentDepartment ON tblResident.ResidentID = tblResidentDepartment.ResidentID 
INNER JOIN tblDepartment ON tblResidentDepartment.DepartmentID = tblDepartment.DepartmentID

--List of deceased and cause of death
SELECT tblResident.Firstname, tblResident.DateOfBirth, 
tblCauseOfAbscence.DeceasedDueTo AS "Deceased due to"
FROM tblCauseOfAbscence 
INNER JOIN tblDeceased ON tblCauseOfAbscence.CauseOfAbscenceID = tblDeceased.CauseOfAbsenceID 
INNER JOIN tblResident ON tblDeceased.ResidentID = tblResident.ResidentID

--list all dead that made 50000$ or higher
SELECT tblResident.Firstname, tblResident.Lastname, tblRank.RankName, tblRank.Salary
FROM tblCauseOfAbscence 
INNER JOIN tblDeceased ON tblCauseOfAbscence.CauseOfAbscenceID = tblDeceased.CauseOfAbsenceID 
INNER JOIN tblResident ON tblDeceased.ResidentID = tblResident.ResidentID 
INNER JOIN tblRank ON tblResident.RankID = tblRank.RankID
WHERE tblRank.Salary>50000

--SELECT people deceased from specific planet
SELECT        tblResident.Firstname, tblOrigin.PlanetName, tblCauseOfAbscence.DeceasedDueTo
FROM            tblCauseOfAbscence INNER JOIN
                         tblDeceased ON tblCauseOfAbscence.CauseOfAbscenceID = tblDeceased.CauseOfAbsenceID INNER JOIN
                         tblResident ON tblDeceased.ResidentID = tblResident.ResidentID INNER JOIN
                         tblOrigin ON tblResident.OriginID = tblOrigin.OriginID
WHERE PlanetName='earth'

--list all dead that were born between two birthdates
SELECT tblResident.Firstname, tblResident.DateOfBirth
FROM tblDeceased 
INNER JOIN tblResident ON tblDeceased.ResidentID = tblResident.ResidentID
WHERE DateOfBirth<'2120-10-10 00:00:00.000' 
AND DateOfBirth>'2100-10-10 00:00:00.000'

--count how many residents each rank consists off
SELECT RankName, COUNT(RankName) AS "Amount" 
FROM tblResident 
INNER JOIN tblRank ON tblResident.RankID = tblRank.RankID
GROUP BY RankName

--group deceased based on cause of death
SELECT CONCAT(tblResident.Firstname+' ', +tblResident.Lastname) AS "Fullname", tblCauseOfAbscence.DeceasedDueTo
FROM tblCauseOfAbscence 
INNER JOIN tblDeceased ON tblCauseOfAbscence.CauseOfAbscenceID = tblDeceased.CauseOfAbsenceID 
INNER JOIN tblResident ON tblDeceased.ResidentID = tblResident.ResidentID
ORDER BY tblCauseOfAbscence.DeceasedDueTo
