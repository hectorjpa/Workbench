-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hector Perez
-- Create date: 09/07/2021
-- Description:	Trigger to insert a row to AR_CUST_NOTE Table
--				everytime there is an update at AR_CUST table 
-- =============================================
CREATE TRIGGER [dbo].[TR_RS_AR_CUSTNOTE_U] ON  [dbo].[AR_CUST] AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for trigger here
	DECLARE @Note VARCHAR(100)
	
	SELECT @Note = 'A Change was applied for Customer ' + NAM  + ' on ' + CONVERT(varchar, getdate(), 100) FROM inserted 


	INSERT INTO [dbo].[AR_CUST_NOTE]
			   ([CUST_NO]
			   ,[NOTE_ID]
			   ,[NOTE_DAT]
			   ,[USR_ID]
			   ,[NOTE]
			   ,[NOTE_TXT]
			   ,[LST_MAINT_DT]
			   ,[LST_MAINT_USR_ID]
			   ,[LST_LCK_DT])
		 --VALUES
		 SELECT 
			CUST_NO, 
			'UPDATE', 
			getdate(),
			'MGR',
			'{\rtf1\ansi\deff0{\fonttbl{\f0\fnil\fcharset0 Arial;}}  \viewkind4\uc1\pard\lang1033\fs16 ' + @Note + ' \par  \par  AH\par  }',
			@Note,
			getdate(),
			'MGR',
			NULL

	 FROM inserted 
 


END
GO
