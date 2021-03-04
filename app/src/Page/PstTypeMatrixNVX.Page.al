page 50001 PstTypeMatrixNVX
{
    PageType = ListPart;
    SourceTable = "Gen. Business Posting Group";
    Caption = 'Matrix General Business Posting Group_VAT Posting Type', comment = 'DEA="Matrix Geschäftsbuchungsgruppe_USt Buchungsart"';
    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;
                field(Code;Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description;Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Planning;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Visible = Field1Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(1);
                    end;
                }
                field(Field1Desc; MATRIX_CellDesc[1])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field1Visible;
                    Editable = false;
                }                
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];                   
                    Visible = Field2Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(2);
                    end;
                }
                field(Field2Desc; MATRIX_CellDesc[2])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field2Visible;
                    Editable = false;
                } 
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Planning;                   
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];                   
                    Visible = Field3Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(3);
                    end;
                }
                field(Field3Desc; MATRIX_CellDesc[3])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field3Visible;
                    Editable = false;
                } 
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Planning;                   
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];                    
                    Visible = Field4Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(4);
                    end;
                }
                field(Field4Desc; MATRIX_CellDesc[4])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field4Visible;
                    Editable = false;
                } 
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];                    
                    Visible = Field5Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(5);
                    end;
                }
                field(Field5Desc; MATRIX_CellDesc[5])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field5Visible;
                    Editable = false;
                } 
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];                    
                    Visible = Field6Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(6);
                    end;
                }
                field(Field6Desc; MATRIX_CellDesc[6])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field6Visible;
                    Editable = false;
                } 
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];                    
                    Visible = Field7Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(7);
                    end;
                }
                field(Field7Desc; MATRIX_CellDesc[7])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field7Visible;
                    Editable = false;
                } 
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];                    
                    Visible = Field8Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(8);
                    end;
                }
                field(Field8Desc; MATRIX_CellDesc[8])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field8Visible;
                    Editable = false;
                } 
                field(Field9; MATRIX_CellData[9])
                {

                    ApplicationArea = Planning;                   
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];                    
                    Visible = Field9Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(9);
                    end;
                }
                field(Field9Desc; MATRIX_CellDesc[9])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field9Visible;
                    Editable = false;
                } 
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];                    
                    Visible = Field10Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(10);
                    end;
                }
                field(Field10Desc; MATRIX_CellDesc[10])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field10Visible;
                    Editable = false;
                } 
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];                    
                    Visible = Field11Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(11);
                    end;
                }
                field(Field11Desc; MATRIX_CellDesc[11])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field11Visible;
                    Editable = false;
                } 
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];                    
                    Visible = Field12Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(12);
                    end;
                }
                field(Field12Desc; MATRIX_CellDesc[12])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field12Visible;
                    Editable = false;
                } 
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[13];                    
                    Visible = Field13Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(13);
                    end;
                }
                field(Field13Desc; MATRIX_CellDesc[13])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field13Visible;
                    Editable = false;
                } 
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[14];                    
                    Visible = Field14Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(14);
                    end;
                }
                field(Field14Desc; MATRIX_CellDesc[14])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field14Visible;
                    Editable = false;
                } 
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[15];                    
                    Visible = Field15Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(15);
                    end;
                }
                field(Field15Desc; MATRIX_CellDesc[15])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field15Visible;
                    Editable = false;
                } 
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[16];                    
                    Visible = Field16Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(16);
                    end;
                }
                field(Field16Desc; MATRIX_CellDesc[16])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field16Visible;
                    Editable = false;
                } 
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[17];                   
                    Visible = Field17Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(17);
                    end;
                }
                field(Field17Desc; MATRIX_CellDesc[17])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field17Visible;
                    Editable = false;
                } 
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[18];                    
                    Visible = Field18Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(18);
                    end;
                }
                field(Field18Desc; MATRIX_CellDesc[18])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field18Visible;
                    Editable = false;
                }                 
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[19];                    
                    Visible = Field19Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(19);
                    end;
                }
                field(Field19Desc; MATRIX_CellDesc[19])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field19Visible;
                    Editable = false;
                } 
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[20];                    
                    Visible = Field20Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(20);
                    end;
                }
                field(Field20Desc; MATRIX_CellDesc[20])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field20Visible;
                    Editable = false;
                } 
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[21];                    
                    Visible = Field21Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(21);
                    end;
                }
                field(Field21Desc; MATRIX_CellDesc[21])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field21Visible;
                    Editable = false;
                } 
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[22];                    
                    Visible = Field22Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(22);
                    end;
                }
                field(Field22Desc; MATRIX_CellDesc[22])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field22Visible;
                    Editable = false;
                } 
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[23];                    
                    Visible = Field23Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(23);
                    end;
                }
                field(Field23Desc; MATRIX_CellDesc[23])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field23Visible;
                    Editable = false;
                } 
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[24];                    
                    Visible = Field24Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(24);
                    end;
                }
                field(Field24Desc; MATRIX_CellDesc[24])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field24Visible;
                    Editable = false;
                } 
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[25];                    
                    Visible = Field25Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(25);
                    end;
                }
                field(Field25Desc; MATRIX_CellDesc[25])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field25Visible;
                    Editable = false;
                } 
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[26];                    
                    Visible = Field26Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(26);
                    end;
                }
                field(Field26Desc; MATRIX_CellDesc[26])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field26Visible;
                    Editable = false;
                } 
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[27];                    
                    Visible = Field27Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(27);
                    end;
                }
                field(Field27Desc; MATRIX_CellDesc[27])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field27Visible;
                    Editable = false;
                } 
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[28];                    
                    Visible = Field28Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(28);
                    end;
                }
                field(Field28Desc; MATRIX_CellDesc[28])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field28Visible;
                    Editable = false;
                } 
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[29];                    
                    Visible = Field29Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(29);
                    end;
                }
                field(Field29Desc; MATRIX_CellDesc[29])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field29Visible;
                    Editable = false;
                } 
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[30];                    
                    Visible = Field30Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(30);
                    end;
                }
                field(Field30Desc; MATRIX_CellDesc[30])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field30Visible;
                    Editable = false;
                } 
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[31];                    
                    Visible = Field31Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(31);
                    end;
                }
                field(Field31Desc; MATRIX_CellDesc[31])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field31Visible;
                    Editable = false;
                } 
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = Planning;                    
                    CaptionClass = '3,' + MATRIX_CaptionSet[32];                    
                    Visible = Field32Visible;
                    TableRelation = "Gen. Business Posting Group";

                    trigger OnValidate()
                    begin
                        ValidateMatrixCell(32);
                    end;
                }
                field(Field32Desc; MATRIX_CellDesc[32])
                {
                    ApplicationArea = All;
                    Caption = 'Description', comment = 'DEA="Beschreibung"';
                    Visible = Field32Visible;
                    Editable = false;
                } 
                
            }
        }
    }

    var 
        MATRIX_CellData: array[32] of Code[20];
        MATRIX_CellDesc:  array[32] of Text[50];
        MATRIX_CaptionSet: array[32] of Text[80];
        Field1Visible: Boolean;
        Field2Visible: Boolean;
        Field3Visible: Boolean;
        Field4Visible: Boolean;
        Field5Visible: Boolean;
        Field6Visible: Boolean;
        Field7Visible: Boolean;
        Field8Visible: Boolean;
        Field9Visible: Boolean;
        Field10Visible: Boolean;
        Field11Visible: Boolean;
        Field12Visible: Boolean;
        Field13Visible: Boolean;
        Field14Visible: Boolean;
        Field15Visible: Boolean;
        Field16Visible: Boolean;
        Field17Visible: Boolean;
        Field18Visible: Boolean;
        Field19Visible: Boolean;
        Field20Visible: Boolean;
        Field21Visible: Boolean;
        Field22Visible: Boolean;
        Field23Visible: Boolean;
        Field24Visible: Boolean;
        Field25Visible: Boolean;
        Field26Visible: Boolean;
        Field27Visible: Boolean;
        Field28Visible: Boolean;
        Field29Visible: Boolean;
        Field30Visible: Boolean;
        Field31Visible: Boolean;
        Field32Visible: Boolean;

    trigger OnOpenPage();
    begin

    end;        

    trigger OnAfterGetRecord();
    begin
        Load();
        SetVisible();
    end;

    local procedure ValidateMatrixCell(Which: Integer);
    var
        BsnPstGrpVATPstType: Record BsnPstGrpVATPstTypeNVX;
    begin
        If BsnPstGrpVATPstType.get(Code,MATRIX_CaptionSet[Which]) then begin
            BsnPstGrpVATPstType."Gen. Bus. Posting Group2" := MATRIX_CellData[which];
            BsnPstGrpVATPstType.Modify();
        end else begin
            BsnPstGrpVATPstType.init();
            BsnPstGrpVATPstType."Gen. Bus. Posting Group" := Code;
            BsnPstGrpVATPstType."VAT Posting Type" := MATRIX_CaptionSet[which];
            BsnPstGrpVATPstType."Gen. Bus. Posting Group2" := MATRIX_CellData[Which];
            BsnPstGrpVATPstType.Insert();
        end;
        BsnPstGrpVATPstType.CalcFields(Description);
        MATRIX_CellDesc[Which] := BsnPstGrpVATPstType.Description;
    end;

    procedure Load();
    var
        BsnPstGrpVATPstType: Record BsnPstGrpVATPstTypeNVX;
        VATPostingType: Record VATPostingTypeNVX;
        i: Integer;
    begin
        clear(i);
        Clear(MATRIX_CaptionSet);
        Clear(MATRIX_CellData);
        Clear(MATRIX_CellDesc);
        VATPostingType.Reset();
        IF VATPostingType.FindSet() then
            repeat
                i += 1;
                MATRIX_CaptionSet[i] := VATPostingType.Code;
                IF BsnPstGrpVATPstType.Get(Code,VATPostingType.Code) then begin
                    MATRIX_CellData[i] := BsnPstGrpVATPstType."Gen. Bus. Posting Group2";
                    BsnPstGrpVATPstType.CalcFields(Description);
                    MATRIX_CellDesc[i] := BsnPstGrpVATPstType.Description;
                end;
            until VATPostingType.next() = 0;
       
    end;

    procedure SetVisible()
    begin
        Field1Visible := MATRIX_CaptionSet[1] <> '';
        Field2Visible := MATRIX_CaptionSet[2] <> '';
        Field3Visible := MATRIX_CaptionSet[3] <> '';
        Field4Visible := MATRIX_CaptionSet[4] <> '';
        Field5Visible := MATRIX_CaptionSet[5] <> '';
        Field6Visible := MATRIX_CaptionSet[6] <> '';
        Field7Visible := MATRIX_CaptionSet[7] <> '';
        Field8Visible := MATRIX_CaptionSet[8] <> '';
        Field9Visible := MATRIX_CaptionSet[9] <> '';
        Field10Visible := MATRIX_CaptionSet[10] <> '';
        Field11Visible := MATRIX_CaptionSet[11] <> '';
        Field12Visible := MATRIX_CaptionSet[12] <> '';
        Field13Visible := MATRIX_CaptionSet[13] <> '';
        Field14Visible := MATRIX_CaptionSet[14] <> '';
        Field15Visible := MATRIX_CaptionSet[15] <> '';
        Field16Visible := MATRIX_CaptionSet[16] <> '';
        Field17Visible := MATRIX_CaptionSet[17] <> '';
        Field18Visible := MATRIX_CaptionSet[18] <> '';
        Field19Visible := MATRIX_CaptionSet[19] <> '';
        Field20Visible := MATRIX_CaptionSet[20] <> '';
        Field21Visible := MATRIX_CaptionSet[21] <> '';
        Field22Visible := MATRIX_CaptionSet[22] <> '';
        Field23Visible := MATRIX_CaptionSet[23] <> '';
        Field24Visible := MATRIX_CaptionSet[24] <> '';
        Field25Visible := MATRIX_CaptionSet[25] <> '';
        Field26Visible := MATRIX_CaptionSet[26] <> '';
        Field27Visible := MATRIX_CaptionSet[27] <> '';
        Field28Visible := MATRIX_CaptionSet[28] <> '';
        Field29Visible := MATRIX_CaptionSet[29] <> '';
        Field30Visible := MATRIX_CaptionSet[30] <> '';
        Field31Visible := MATRIX_CaptionSet[31] <> '';
        Field32Visible := MATRIX_CaptionSet[32] <> '';
    end;
}