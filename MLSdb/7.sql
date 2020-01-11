GO
ALTER TABLE TracksDataView ADD [Ball_toPlayer1(T1)] AS SQRT(SQUARE(T_BallX - [T_Player1(T1)-X]) + SQUARE(T_BallY - [T_Player1(T1)-Y]))
GO
ALTER TABLE TracksDataView ADD [Ball_toPlayer2(T1)] AS  SQRT(SQUARE(T_BallX - [T_Player2(T1)-X]) + SQUARE(T_BallY - [T_Player2(T1)-Y]))
GO
ALTER TABLE TracksDataView ADD [Ball_toPlayer1(T2)] AS  SQRT(SQUARE(T_BallX - [T_Player1(T2)-X]) + SQUARE(T_BallY - [T_Player1(T2)-Y]))
GO
ALTER TABLE TracksDataView ADD [Ball_toPlayer2(T2)] AS  SQRT(SQUARE(T_BallX - [T_Player2(T2)-X]) + SQUARE(T_BallY - [T_Player2(T2)-Y]))