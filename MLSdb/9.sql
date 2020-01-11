GO
ALTER TABLE EventsDataView ADD [PitchArea] nvarchar(10) DEFAULT 'Unknown'
GO
ALTER TABLE EventsDataView ADD CONSTRAINT check_constraint CHECK(PitchArea = 'Area1' OR 
		PitchArea = 'Area2' OR PitchArea = 'Area3' OR PitchArea = 'Area4')
GO
ALTER TABLE TracksDataView ADD [PitchArea] nvarchar(10) DEFAULT 'Unknown'
GO
ALTER TABLE TracksDataView ADD CONSTRAINT tracks_check_constraint CHECK(PitchArea = 'Area1' OR 
		PitchArea = 'Area2' OR PitchArea = 'Area3' OR PitchArea = 'Area4')