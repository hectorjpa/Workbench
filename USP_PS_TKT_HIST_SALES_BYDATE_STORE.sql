
USE DEMOGOLF

CREATE PROCEDURE USP_PS_TKT_HIST_SALES_BYDATE_STORE
(
	@STARTDATE DATETIME,
	@ENDDATE DATETIME

)
AS
/****************************************************************
PROCEDURE NAME: USP_PS_TKT_HIST_SALES_BYDATE_STORE
CREATED BY: HECTOR PEREZ
CREATED DATE: 09/07/2021
***************************************************************
EXECUTION SAMPLES
***************************************************************
USP_PS_TKT_HIST_SALES_BYDATE_STORE '2/2/2012', '5/1/2012'
USP_PS_TKT_HIST_SALES_BYDATE_STORE '3/1/2012', '4/1/2012'
USP_PS_TKT_HIST_SALES_BYDATE_STORE '5/1/2012', '5/31/2012'



****************************************************************/



SET NOCOUNT ON


SELECT 
PS_TKT_HIST.BUS_DAT BUSINESS_DATE,
PS_TKT_HIST_LIN.STR_ID STORE,
SUM(PS_TKT_HIST_LIN.GROSS_EXT_PRC) TOTAL_SALES,
COUNT(PS_TKT_HIST_LIN.QTY_SOLD) SOLD_QTY,
SUM(CASE PS_TKT_HIST_LIN.IS_TXBL WHEN 'Y' THEN PS_TKT_HIST_LIN.QTY_SOLD ELSE 0 END) TAXABLE_SALES,
SUM(CASE PS_TKT_HIST_LIN.IS_TXBL WHEN 'N' THEN PS_TKT_HIST_LIN.QTY_SOLD ELSE 0 END) NON_TAXABLE_SALES,
SUM(PS_TKT_HIST_LIN.PRC) PRICE,
SUM(PS_TKT_HIST_LIN.UNIT_COST) COST

FROM PS_TKT_HIST
JOIN PS_TKT_HIST_LIN 
	ON PS_TKT_HIST.DOC_ID = PS_TKT_HIST_LIN.DOC_ID 
WHERE PS_TKT_HIST.BUS_DAT Between @STARTDATE and @ENDDATE
GROUP BY PS_TKT_HIST.BUS_DAT, PS_TKT_HIST_LIN.STR_ID 


GO


 
Select * from PS_TKT_HIST where DOC_ID = 201333583338
Select * from PS_TKT_HIST_LIN where DOC_ID = 201333583338 order by LIN_SEQ_NO
Select 
FOOD_STMP_NORM_TAX_AMT
FOOD_STMP_TAX_AMT,
HAS_TAX_OVRD,
NORM_TAX_AMT,
NORM_TAX_COD,
TAX_AMT,
TAX_COD,
TAX_EXEMPT_NO,
TAX_OVRD_LINS,
TAX_OVRD_REAS
from PS_TKT_HIST
where DOC_ID = 201333583338
select name from syscolumns where id in (select id from sysobjects where name = 'PS_TKT_HIST' and type = 'u') and name like('%TAX%')

Select * from PS_TKT_HIST_LIN where DOC_ID = 201333583338 order by LIN_SEQ_NO
select name from syscolumns where id in (select id from sysobjects where name = 'PS_TKT_HIST_LIN' and type = 'u') and name like('%COST%')



