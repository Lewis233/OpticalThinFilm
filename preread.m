function datum = preread(~)
datum = cell(1,4);
datum{1,1} = xlsread('Acrylic.xls');
datum{1,2} = xlsread('Pt.xls');
datum{1,3} = xlsread('TiSi2.xls');
datum{1,4} = xlsread('W.xls');