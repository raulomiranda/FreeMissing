data CleanData;
	set dqtest.sheet1;	
	if missing(Variavel3) or missing(Variavel2) or missing(Variavel1) then delete;
	
run;

data DataQuality (drop=  Variavel1 Variavel2 Variavel3 MissingVariavel1 MissingVariavel2 MissingVariavel3 DataOK1 DataOK2 DataOK3 TotalMissing1 TotalMissing2 TotalMissing3 TotalOK1 TotalOK2 TotalOK3);
    set dqtest.sheet1 end=last;
    MissingVariavel1=nmiss(of Variavel1);
	MissingVariavel2=nmiss(of Variavel2);
	MissingVariavel3=nmiss(of Variavel3);
	
	DataOK1 = ifn(MissingVariavel1=0, 1, 0);
	DataOK2 = ifn(MissingVariavel2=0, 1, 0);
	DataOK3 = ifn(MissingVariavel3=0, 1, 0);
    if first.dqtest.sheet1 then do;
        TotalMissing1 = 0;
        TotalMissing2 = 0;
        TotalMissing3 = 0;
        TotalOK1 = 0;
        TotalOK2 = 0;
        TotalOK3 = 0;
    end;
    TotalMissing1 + MissingVariavel1;
    TotalMissing2 + MissingVariavel2;
    TotalMissing3 + MissingVariavel3;
    TotalOK1 + DataOK1;
    TotalOK2 + DataOK2;
    TotalOK3 + DataOK3;
    missing1porcentagem = (TotalMissing1 / (TotalMissing1+TotalOK1));
	missing2porcentagem = (TotalMissing2 / (TotalMissing2+TotalOK2));
	missing3porcentagem = (TotalMissing3 / (TotalMissing3+TotalOK3));
	format missing1porcentagem percent10.1;
	format missing2porcentagem percent10.1;
	format missing3porcentagem percent10.1;
    if last then do;
        output;
    end;
    
run;