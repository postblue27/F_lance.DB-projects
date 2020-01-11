GO
ALTER TABLE Game ADD [Final_Score] nvarchar(50)
GO
UPDATE Game SET Final_Score = '0:7' WHERE GAME_ID = 'G1'
GO
UPDATE Game SET Final_Score = '1:2' WHERE GAME_ID = 'G2'
GO
UPDATE Game SET Final_Score = '4:3' WHERE GAME_ID = 'G3'
GO
UPDATE Game SET Final_Score = '2:3' WHERE GAME_ID = 'G4'
GO
UPDATE Game SET Final_Score = '1:2' WHERE GAME_ID = 'G5'
GO
UPDATE Game SET Final_Score = '2:1' WHERE GAME_ID = 'G6'
GO
UPDATE Game SET Final_Score = '2:2' WHERE GAME_ID = 'G7'
GO
UPDATE Game SET Final_Score = '3:2' WHERE GAME_ID = 'G8'
GO
UPDATE Game SET Final_Score = '4:2' WHERE GAME_ID = 'G9'