$PACKAGE EB.Inlaks
SUBROUTINE  SEC.REP.READ(Y.OUT)

    $INSERT I_COMMON
    $INSERT I_EQUATE
    $INSERT I_ENQUIRY.COMMON
	*DEBUG
	FN.SEC.FOLDER = 'SEC.REP.FOLDER'
	F.SEC.FOLDER = ''
	CALL OPF(FN.SEC.FOLDER, F.SEC.FOLDER)
	
	LOCATE 'FUND.TYPE' IN D.FIELDS<1> SETTING FTYPE.POS THEN
        FUND.TYPE = D.RANGE.AND.VALUE<FTYPE.POS>
    END
	
    LOCATE 'MANAGER' IN D.FIELDS<1> SETTING FMANAGER.POS THEN
        FMANAGER = D.RANGE.AND.VALUE<FMANAGER.POS>
    END
    	
    LOCATE 'VALUE.DATE' IN  D.FIELDS<1> SETTING DATE.POS THEN
        DATE.ENTRY      = D.RANGE.AND.VALUE<DATE.POS>
    END
	*DEBUG
	IF FUND.TYPE NE '' THEN
		OUTPUT.FOLDER = 'SEC.REP.FOLDER'
		FILE.NAME = 'Sec.Report':FUND.TYPE:'.':DATE.ENTRY:'.csv'
		OPENSEQ OUTPUT.FOLDER,FILE.NAME TO SEC.TEMP ELSE PRINT "ERROR"
	END
	IF FMANAGER NE '' THEN
		OUTPUT.FOLDER = 'SEC.REP.FOLDER'
		FILE.NAME = 'Sec.Report':FMANAGER:'.':DATE.ENTRY
		OPENSEQ OUTPUT.FOLDER,FILE.NAME TO SEC.TEMP ELSE CREATE SEC.TEMP ELSE PRINT "ERROR"
	END
	
    CALL F.READ(FN.SEC.FOLDER,FILE.NAME,SEL.LIST,F.SEC.FOLDER,ERR)
	
	Y.OUT<-1> = SEL.LIST
	
END
	
	
	