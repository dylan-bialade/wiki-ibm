---
bibliotheque: BIB19
fichier_source: QDDSSRC
membre: IDBGFM
type: DDS
longueur_enregistrement: 100
lignes: 968
modifie: 2026-11-16
---

# BIB19/QDDSSRC/IDBGFM

```text
     A* IDBGFM - ecrans de BIB19 (genere par tools/gen_formats.py)
     A* Ne pas modifier : changer python/BIB19/formats.py
     A                                      DSPSIZ(24 80 *DS3)
     A                                      PRINT
     A                                      HELP
     A                                      PAGEDOWN
     A                                      PAGEUP
     A                                      CF01
     A                                      CF02
     A                                      CF03
     A                                      CF04
     A                                      CF05
     A                                      CF06
     A                                      CF07
     A                                      CF08
     A                                      CF09
     A                                      CF10
     A                                      CF11
     A                                      CF12
     A                                      CF13
     A                                      CF14
     A                                      CF15
     A                                      CF16
     A                                      CF17
     A                                      CF18
     A                                      CF19
     A                                      CF20
     A                                      CF21
     A                                      CF22
     A                                      CF23
     A                                      CF24
     A          R SRC                       CSRLOC(CSRROW CSRCOL)
     A            AMNU1         14A  B  1  3DSPATR(HI)
     A                                      CHGINPDFT
     A            AMNU2         12A  B  1 18DSPATR(HI)
     A                                      CHGINPDFT
     A            AMNU3         17A  B  1 31DSPATR(HI)
     A                                      CHGINPDFT
     A            AMNU4         15A  B  1 49DSPATR(HI)
     A                                      CHGINPDFT
     A            A01S0          1A  O  1 65DSPATR(&A01P0)
     A            AMNU5         11A  B  1 67DSPATR(HI)
     A                                      CHGINPDFT
     A            A01S1          2A  O  1 79DSPATR(&A01P1)
     A            A02S0         79A  O  2  2DSPATR(&A02P0)
     A            A03S0         79A  O  3  2DSPATR(&A03P0)
     A            A04S0         79A  O  4  2DSPATR(&A04P0)
     A            A05S0         79A  O  5  2DSPATR(&A05P0)
     A            A06S0         79A  O  6  2DSPATR(&A06P0)
     A            A07S0         79A  O  7  2DSPATR(&A07P0)
     A            A08S0         79A  O  8  2DSPATR(&A08P0)
     A            A09S0         79A  O  9  2DSPATR(&A09P0)
     A            A10S0         79A  O 10  2DSPATR(&A10P0)
     A            A11S0         79A  O 11  2DSPATR(&A11P0)
     A            A12S0         79A  O 12  2DSPATR(&A12P0)
     A            A13S0         79A  O 13  2DSPATR(&A13P0)
     A            A14S0         79A  O 14  2DSPATR(&A14P0)
     A            A15S0         79A  O 15  2DSPATR(&A15P0)
     A            A16S0         79A  O 16  2DSPATR(&A16P0)
     A            A17S0         79A  O 17  2DSPATR(&A17P0)
     A            A18S0         79A  O 18  2DSPATR(&A18P0)
     A            A19S0         79A  O 19  2DSPATR(&A19P0)
     A            A20S0         79A  O 20  2DSPATR(&A20P0)
     A            A21S0          9A  O 21  2DSPATR(&A21P0)
     A            ACMD          68A  B 21 12CHECK(LC)
     A            A22S0         79A  O 22  2DSPATR(&A22P0)
     A            A23S0         79A  O 23  2DSPATR(&A23P0)
     A            A24S0         79A  O 24  2DSPATR(&A24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            A01P0          1A  P
     A            A01P1          1A  P
     A            A02P0          1A  P
     A            A03P0          1A  P
     A            A04P0          1A  P
     A            A05P0          1A  P
     A            A06P0          1A  P
     A            A07P0          1A  P
     A            A08P0          1A  P
     A            A09P0          1A  P
     A            A10P0          1A  P
     A            A11P0          1A  P
     A            A12P0          1A  P
     A            A13P0          1A  P
     A            A14P0          1A  P
     A            A15P0          1A  P
     A            A16P0          1A  P
     A            A17P0          1A  P
     A            A18P0          1A  P
     A            A19P0          1A  P
     A            A20P0          1A  P
     A            A21P0          1A  P
     A            A22P0          1A  P
     A            A23P0          1A  P
     A            A24P0          1A  P
     A          R PD1                       CSRLOC(CSRROW CSRCOL)
     A            B01S0         79A  O  1  2DSPATR(&B01P0)
     A            B02S0         79A  O  2  2DSPATR(&B02P0)
     A            B03S0          2A  O  3  2DSPATR(&B03P0)
     A            BSEL           2A  B  3  5DSPATR(HI UL)
     A                                      CHECK(LC)
     A            B03S1         73A  O  3  8DSPATR(&B03P1)
     A            B04S0         79A  O  4  2DSPATR(&B04P0)
     A            B05S0         79A  O  5  2DSPATR(&B05P0)
     A            B06S0         79A  O  6  2DSPATR(&B06P0)
     A            B07S0         79A  O  7  2DSPATR(&B07P0)
     A            B08S0         79A  O  8  2DSPATR(&B08P0)
     A            B09S0         79A  O  9  2DSPATR(&B09P0)
     A            B10S0         79A  O 10  2DSPATR(&B10P0)
     A            B11S0         79A  O 11  2DSPATR(&B11P0)
     A            B12S0         79A  O 12  2DSPATR(&B12P0)
     A            B13S0         79A  O 13  2DSPATR(&B13P0)
     A            B14S0         79A  O 14  2DSPATR(&B14P0)
     A            B15S0         79A  O 15  2DSPATR(&B15P0)
     A            B16S0         79A  O 16  2DSPATR(&B16P0)
     A            B17S0         79A  O 17  2DSPATR(&B17P0)
     A            B18S0         79A  O 18  2DSPATR(&B18P0)
     A            B19S0         79A  O 19  2DSPATR(&B19P0)
     A            B20S0         79A  O 20  2DSPATR(&B20P0)
     A            B21S0         79A  O 21  2DSPATR(&B21P0)
     A            B22S0         79A  O 22  2DSPATR(&B22P0)
     A            B23S0         79A  O 23  2DSPATR(&B23P0)
     A            B24S0         79A  O 24  2DSPATR(&B24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            B01P0          1A  P
     A            B02P0          1A  P
     A            B03P0          1A  P
     A            B03P1          1A  P
     A            B04P0          1A  P
     A            B05P0          1A  P
     A            B06P0          1A  P
     A            B07P0          1A  P
     A            B08P0          1A  P
     A            B09P0          1A  P
     A            B10P0          1A  P
     A            B11P0          1A  P
     A            B12P0          1A  P
     A            B13P0          1A  P
     A            B14P0          1A  P
     A            B15P0          1A  P
     A            B16P0          1A  P
     A            B17P0          1A  P
     A            B18P0          1A  P
     A            B19P0          1A  P
     A            B20P0          1A  P
     A            B21P0          1A  P
     A            B22P0          1A  P
     A            B23P0          1A  P
     A            B24P0          1A  P
     A          R PD2                       CSRLOC(CSRROW CSRCOL)
     A            C01S0         79A  O  1  2DSPATR(&C01P0)
     A            C02S0         79A  O  2  2DSPATR(&C02P0)
     A            C03S0         17A  O  3  2DSPATR(&C03P0)
     A            CSEL           2A  B  3 20DSPATR(HI UL)
     A                                      CHECK(LC)
     A            C03S1         58A  O  3 23DSPATR(&C03P1)
     A            C04S0         79A  O  4  2DSPATR(&C04P0)
     A            C05S0         79A  O  5  2DSPATR(&C05P0)
     A            C06S0         79A  O  6  2DSPATR(&C06P0)
     A            C07S0         79A  O  7  2DSPATR(&C07P0)
     A            C08S0         79A  O  8  2DSPATR(&C08P0)
     A            C09S0         79A  O  9  2DSPATR(&C09P0)
     A            C10S0         79A  O 10  2DSPATR(&C10P0)
     A            C11S0         79A  O 11  2DSPATR(&C11P0)
     A            C12S0         79A  O 12  2DSPATR(&C12P0)
     A            C13S0         79A  O 13  2DSPATR(&C13P0)
     A            C14S0         79A  O 14  2DSPATR(&C14P0)
     A            C15S0         79A  O 15  2DSPATR(&C15P0)
     A            C16S0         79A  O 16  2DSPATR(&C16P0)
     A            C17S0         79A  O 17  2DSPATR(&C17P0)
     A            C18S0         79A  O 18  2DSPATR(&C18P0)
     A            C19S0         79A  O 19  2DSPATR(&C19P0)
     A            C20S0         79A  O 20  2DSPATR(&C20P0)
     A            C21S0         79A  O 21  2DSPATR(&C21P0)
     A            C22S0         79A  O 22  2DSPATR(&C22P0)
     A            C23S0         79A  O 23  2DSPATR(&C23P0)
     A            C24S0         79A  O 24  2DSPATR(&C24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            C01P0          1A  P
     A            C02P0          1A  P
     A            C03P0          1A  P
     A            C03P1          1A  P
     A            C04P0          1A  P
     A            C05P0          1A  P
     A            C06P0          1A  P
     A            C07P0          1A  P
     A            C08P0          1A  P
     A            C09P0          1A  P
     A            C10P0          1A  P
     A            C11P0          1A  P
     A            C12P0          1A  P
     A            C13P0          1A  P
     A            C14P0          1A  P
     A            C15P0          1A  P
     A            C16P0          1A  P
     A            C17P0          1A  P
     A            C18P0          1A  P
     A            C19P0          1A  P
     A            C20P0          1A  P
     A            C21P0          1A  P
     A            C22P0          1A  P
     A            C23P0          1A  P
     A            C24P0          1A  P
     A          R PD3                       CSRLOC(CSRROW CSRCOL)
     A            D01S0         79A  O  1  2DSPATR(&D01P0)
     A            D02S0         79A  O  2  2DSPATR(&D02P0)
     A            D03S0         30A  O  3  2DSPATR(&D03P0)
     A            DSEL           2A  B  3 33DSPATR(HI UL)
     A                                      CHECK(LC)
     A            D03S1         45A  O  3 36DSPATR(&D03P1)
     A            D04S0         79A  O  4  2DSPATR(&D04P0)
     A            D05S0         79A  O  5  2DSPATR(&D05P0)
     A            D06S0         79A  O  6  2DSPATR(&D06P0)
     A            D07S0         79A  O  7  2DSPATR(&D07P0)
     A            D08S0         79A  O  8  2DSPATR(&D08P0)
     A            D09S0         79A  O  9  2DSPATR(&D09P0)
     A            D10S0         79A  O 10  2DSPATR(&D10P0)
     A            D11S0         79A  O 11  2DSPATR(&D11P0)
     A            D12S0         79A  O 12  2DSPATR(&D12P0)
     A            D13S0         79A  O 13  2DSPATR(&D13P0)
     A            D14S0         79A  O 14  2DSPATR(&D14P0)
     A            D15S0         79A  O 15  2DSPATR(&D15P0)
     A            D16S0         79A  O 16  2DSPATR(&D16P0)
     A            D17S0         79A  O 17  2DSPATR(&D17P0)
     A            D18S0         79A  O 18  2DSPATR(&D18P0)
     A            D19S0         79A  O 19  2DSPATR(&D19P0)
     A            D20S0         79A  O 20  2DSPATR(&D20P0)
     A            D21S0         79A  O 21  2DSPATR(&D21P0)
     A            D22S0         79A  O 22  2DSPATR(&D22P0)
     A            D23S0         79A  O 23  2DSPATR(&D23P0)
     A            D24S0         79A  O 24  2DSPATR(&D24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            D01P0          1A  P
     A            D02P0          1A  P
     A            D03P0          1A  P
     A            D03P1          1A  P
     A            D04P0          1A  P
     A            D05P0          1A  P
     A            D06P0          1A  P
     A            D07P0          1A  P
     A            D08P0          1A  P
     A            D09P0          1A  P
     A            D10P0          1A  P
     A            D11P0          1A  P
     A            D12P0          1A  P
     A            D13P0          1A  P
     A            D14P0          1A  P
     A            D15P0          1A  P
     A            D16P0          1A  P
     A            D17P0          1A  P
     A            D18P0          1A  P
     A            D19P0          1A  P
     A            D20P0          1A  P
     A            D21P0          1A  P
     A            D22P0          1A  P
     A            D23P0          1A  P
     A            D24P0          1A  P
     A          R PD4                       CSRLOC(CSRROW CSRCOL)
     A            E01S0         79A  O  1  2DSPATR(&E01P0)
     A            E02S0         79A  O  2  2DSPATR(&E02P0)
     A            E03S0         34A  O  3  2DSPATR(&E03P0)
     A            ESEL           2A  B  3 37DSPATR(HI UL)
     A                                      CHECK(LC)
     A            E03S1         41A  O  3 40DSPATR(&E03P1)
     A            E04S0         79A  O  4  2DSPATR(&E04P0)
     A            E05S0         79A  O  5  2DSPATR(&E05P0)
     A            E06S0         79A  O  6  2DSPATR(&E06P0)
     A            E07S0         79A  O  7  2DSPATR(&E07P0)
     A            E08S0         79A  O  8  2DSPATR(&E08P0)
     A            E09S0         79A  O  9  2DSPATR(&E09P0)
     A            E10S0         79A  O 10  2DSPATR(&E10P0)
     A            E11S0         79A  O 11  2DSPATR(&E11P0)
     A            E12S0         79A  O 12  2DSPATR(&E12P0)
     A            E13S0         79A  O 13  2DSPATR(&E13P0)
     A            E14S0         79A  O 14  2DSPATR(&E14P0)
     A            E15S0         79A  O 15  2DSPATR(&E15P0)
     A            E16S0         79A  O 16  2DSPATR(&E16P0)
     A            E17S0         79A  O 17  2DSPATR(&E17P0)
     A            E18S0         79A  O 18  2DSPATR(&E18P0)
     A            E19S0         79A  O 19  2DSPATR(&E19P0)
     A            E20S0         79A  O 20  2DSPATR(&E20P0)
     A            E21S0         79A  O 21  2DSPATR(&E21P0)
     A            E22S0         79A  O 22  2DSPATR(&E22P0)
     A            E23S0         79A  O 23  2DSPATR(&E23P0)
     A            E24S0         79A  O 24  2DSPATR(&E24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            E01P0          1A  P
     A            E02P0          1A  P
     A            E03P0          1A  P
     A            E03P1          1A  P
     A            E04P0          1A  P
     A            E05P0          1A  P
     A            E06P0          1A  P
     A            E07P0          1A  P
     A            E08P0          1A  P
     A            E09P0          1A  P
     A            E10P0          1A  P
     A            E11P0          1A  P
     A            E12P0          1A  P
     A            E13P0          1A  P
     A            E14P0          1A  P
     A            E15P0          1A  P
     A            E16P0          1A  P
     A            E17P0          1A  P
     A            E18P0          1A  P
     A            E19P0          1A  P
     A            E20P0          1A  P
     A            E21P0          1A  P
     A            E22P0          1A  P
     A            E23P0          1A  P
     A            E24P0          1A  P
     A          R PD5                       CSRLOC(CSRROW CSRCOL)
     A            F01S0         79A  O  1  2DSPATR(&F01P0)
     A            F02S0         79A  O  2  2DSPATR(&F02P0)
     A            F03S0         22A  O  3  2DSPATR(&F03P0)
     A            FSEL           2A  B  3 25DSPATR(HI UL)
     A                                      CHECK(LC)
     A            F03S1         53A  O  3 28DSPATR(&F03P1)
     A            F04S0         79A  O  4  2DSPATR(&F04P0)
     A            F05S0         79A  O  5  2DSPATR(&F05P0)
     A            F06S0         79A  O  6  2DSPATR(&F06P0)
     A            F07S0         79A  O  7  2DSPATR(&F07P0)
     A            F08S0         79A  O  8  2DSPATR(&F08P0)
     A            F09S0         79A  O  9  2DSPATR(&F09P0)
     A            F10S0         79A  O 10  2DSPATR(&F10P0)
     A            F11S0         79A  O 11  2DSPATR(&F11P0)
     A            F12S0         79A  O 12  2DSPATR(&F12P0)
     A            F13S0         79A  O 13  2DSPATR(&F13P0)
     A            F14S0         79A  O 14  2DSPATR(&F14P0)
     A            F15S0         79A  O 15  2DSPATR(&F15P0)
     A            F16S0         79A  O 16  2DSPATR(&F16P0)
     A            F17S0         79A  O 17  2DSPATR(&F17P0)
     A            F18S0         79A  O 18  2DSPATR(&F18P0)
     A            F19S0         79A  O 19  2DSPATR(&F19P0)
     A            F20S0         79A  O 20  2DSPATR(&F20P0)
     A            F21S0         79A  O 21  2DSPATR(&F21P0)
     A            F22S0         79A  O 22  2DSPATR(&F22P0)
     A            F23S0         79A  O 23  2DSPATR(&F23P0)
     A            F24S0         79A  O 24  2DSPATR(&F24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            F01P0          1A  P
     A            F02P0          1A  P
     A            F03P0          1A  P
     A            F03P1          1A  P
     A            F04P0          1A  P
     A            F05P0          1A  P
     A            F06P0          1A  P
     A            F07P0          1A  P
     A            F08P0          1A  P
     A            F09P0          1A  P
     A            F10P0          1A  P
     A            F11P0          1A  P
     A            F12P0          1A  P
     A            F13P0          1A  P
     A            F14P0          1A  P
     A            F15P0          1A  P
     A            F16P0          1A  P
     A            F17P0          1A  P
     A            F18P0          1A  P
     A            F19P0          1A  P
     A            F20P0          1A  P
     A            F21P0          1A  P
     A            F22P0          1A  P
     A            F23P0          1A  P
     A            F24P0          1A  P
     A          R FINSES                    CSRLOC(CSRROW CSRCOL)
     A            G01S0         79A  O  1  2DSPATR(&G01P0)
     A            G02S0         79A  O  2  2DSPATR(&G02P0)
     A            G03S0         79A  O  3  2DSPATR(&G03P0)
     A            G04S0         79A  O  4  2DSPATR(&G04P0)
     A            G05S0         79A  O  5  2DSPATR(&G05P0)
     A            G06S0         79A  O  6  2DSPATR(&G06P0)
     A            G07S0         79A  O  7  2DSPATR(&G07P0)
     A            G08S0         79A  O  8  2DSPATR(&G08P0)
     A            G09S0         79A  O  9  2DSPATR(&G09P0)
     A            G10S0         79A  O 10  2DSPATR(&G10P0)
     A            G11S0         79A  O 11  2DSPATR(&G11P0)
     A            G12S0         79A  O 12  2DSPATR(&G12P0)
     A            G13S0         79A  O 13  2DSPATR(&G13P0)
     A            G14S0         79A  O 14  2DSPATR(&G14P0)
     A            G15S0         44A  O 15  2DSPATR(&G15P0)
     A            GREP           1A  B 15 47DSPATR(HI UL)
     A                                      CHECK(LC)
     A            G15S1         32A  O 15 49DSPATR(&G15P1)
     A            G16S0         79A  O 16  2DSPATR(&G16P0)
     A            G17S0         79A  O 17  2DSPATR(&G17P0)
     A            G18S0         79A  O 18  2DSPATR(&G18P0)
     A            G19S0         79A  O 19  2DSPATR(&G19P0)
     A            G20S0         79A  O 20  2DSPATR(&G20P0)
     A            G21S0         79A  O 21  2DSPATR(&G21P0)
     A            G22S0         79A  O 22  2DSPATR(&G22P0)
     A            G23S0         79A  O 23  2DSPATR(&G23P0)
     A            G24S0         79A  O 24  2DSPATR(&G24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            G01P0          1A  P
     A            G02P0          1A  P
     A            G03P0          1A  P
     A            G04P0          1A  P
     A            G05P0          1A  P
     A            G06P0          1A  P
     A            G07P0          1A  P
     A            G08P0          1A  P
     A            G09P0          1A  P
     A            G10P0          1A  P
     A            G11P0          1A  P
     A            G12P0          1A  P
     A            G13P0          1A  P
     A            G14P0          1A  P
     A            G15P0          1A  P
     A            G15P1          1A  P
     A            G16P0          1A  P
     A            G17P0          1A  P
     A            G18P0          1A  P
     A            G19P0          1A  P
     A            G20P0          1A  P
     A            G21P0          1A  P
     A            G22P0          1A  P
     A            G23P0          1A  P
     A            G24P0          1A  P
     A          R FINPGM                    CSRLOC(CSRROW CSRCOL)
     A            H01S0         79A  O  1  2DSPATR(&H01P0)
     A            H02S0         79A  O  2  2DSPATR(&H02P0)
     A            H03S0         79A  O  3  2DSPATR(&H03P0)
     A            H04S0         79A  O  4  2DSPATR(&H04P0)
     A            H05S0         79A  O  5  2DSPATR(&H05P0)
     A            H06S0         79A  O  6  2DSPATR(&H06P0)
     A            H07S0         79A  O  7  2DSPATR(&H07P0)
     A            H08S0         79A  O  8  2DSPATR(&H08P0)
     A            H09S0         79A  O  9  2DSPATR(&H09P0)
     A            H10S0         79A  O 10  2DSPATR(&H10P0)
     A            H11S0         79A  O 11  2DSPATR(&H11P0)
     A            H12S0         26A  O 12  2DSPATR(&H12P0)
     A            HREP           1A  B 12 29DSPATR(HI UL)
     A                                      CHECK(LC)
     A            H12S1         50A  O 12 31DSPATR(&H12P1)
     A            H13S0         79A  O 13  2DSPATR(&H13P0)
     A            H14S0         79A  O 14  2DSPATR(&H14P0)
     A            H15S0         79A  O 15  2DSPATR(&H15P0)
     A            H16S0         79A  O 16  2DSPATR(&H16P0)
     A            H17S0         79A  O 17  2DSPATR(&H17P0)
     A            H18S0         79A  O 18  2DSPATR(&H18P0)
     A            H19S0         79A  O 19  2DSPATR(&H19P0)
     A            H20S0         79A  O 20  2DSPATR(&H20P0)
     A            H21S0         79A  O 21  2DSPATR(&H21P0)
     A            H22S0         79A  O 22  2DSPATR(&H22P0)
     A            H23S0         79A  O 23  2DSPATR(&H23P0)
     A            H24S0         79A  O 24  2DSPATR(&H24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            H01P0          1A  P
     A            H02P0          1A  P
     A            H03P0          1A  P
     A            H04P0          1A  P
     A            H05P0          1A  P
     A            H06P0          1A  P
     A            H07P0          1A  P
     A            H08P0          1A  P
     A            H09P0          1A  P
     A            H10P0          1A  P
     A            H11P0          1A  P
     A            H12P0          1A  P
     A            H12P1          1A  P
     A            H13P0          1A  P
     A            H14P0          1A  P
     A            H15P0          1A  P
     A            H16P0          1A  P
     A            H17P0          1A  P
     A            H18P0          1A  P
     A            H19P0          1A  P
     A            H20P0          1A  P
     A            H21P0          1A  P
     A            H22P0          1A  P
     A            H23P0          1A  P
     A            H24P0          1A  P
     A          R MODVAR                    CSRLOC(CSRROW CSRCOL)
     A            I01S0         79A  O  1  2DSPATR(&I01P0)
     A            I02S0         79A  O  2  2DSPATR(&I02P0)
     A            I03S0         79A  O  3  2DSPATR(&I03P0)
     A            I04S0         79A  O  4  2DSPATR(&I04P0)
     A            I05S0         79A  O  5  2DSPATR(&I05P0)
     A            I06S0         79A  O  6  2DSPATR(&I06P0)
     A            I07S0         79A  O  7  2DSPATR(&I07P0)
     A            I08S0         79A  O  8  2DSPATR(&I08P0)
     A            I09S0         79A  O  9  2DSPATR(&I09P0)
     A            I10S0          5A  O 10  2DSPATR(&I10P0)
     A            IVAR          64A  B 10  8DSPATR(HI UL)
     A                                      CHECK(LC)
     A            I10S1          8A  O 10 73DSPATR(&I10P1)
     A            I11S0         29A  O 11  2DSPATR(&I11P0)
     A            IVAL          32A  B 11 32DSPATR(HI UL)
     A                                      CHECK(LC)
     A            I11S1         16A  O 11 65DSPATR(&I11P1)
     A            I12S0         79A  O 12  2DSPATR(&I12P0)
     A            I13S0         79A  O 13  2DSPATR(&I13P0)
     A            I14S0         79A  O 14  2DSPATR(&I14P0)
     A            I15S0         79A  O 15  2DSPATR(&I15P0)
     A            I16S0         79A  O 16  2DSPATR(&I16P0)
     A            I17S0         79A  O 17  2DSPATR(&I17P0)
     A            I18S0         79A  O 18  2DSPATR(&I18P0)
     A            I19S0         79A  O 19  2DSPATR(&I19P0)
     A            I20S0         79A  O 20  2DSPATR(&I20P0)
     A            I21S0         79A  O 21  2DSPATR(&I21P0)
     A            I22S0         79A  O 22  2DSPATR(&I22P0)
     A            I23S0         79A  O 23  2DSPATR(&I23P0)
     A            I24S0         79A  O 24  2DSPATR(&I24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            I01P0          1A  P
     A            I02P0          1A  P
     A            I03P0          1A  P
     A            I04P0          1A  P
     A            I05P0          1A  P
     A            I06P0          1A  P
     A            I07P0          1A  P
     A            I08P0          1A  P
     A            I09P0          1A  P
     A            I10P0          1A  P
     A            I10P1          1A  P
     A            I11P0          1A  P
     A            I11P1          1A  P
     A            I12P0          1A  P
     A            I13P0          1A  P
     A            I14P0          1A  P
     A            I15P0          1A  P
     A            I16P0          1A  P
     A            I17P0          1A  P
     A            I18P0          1A  P
     A            I19P0          1A  P
     A            I20P0          1A  P
     A            I21P0          1A  P
     A            I22P0          1A  P
     A            I23P0          1A  P
     A            I24P0          1A  P
     A          R FIND                      CSRLOC(CSRROW CSRCOL)
     A            J01S0         79A  O  1  2DSPATR(&J01P0)
     A            J02S0         79A  O  2  2DSPATR(&J02P0)
     A            J03S0         79A  O  3  2DSPATR(&J03P0)
     A            J04S0         79A  O  4  2DSPATR(&J04P0)
     A            J05S0         79A  O  5  2DSPATR(&J05P0)
     A            J06S0         79A  O  6  2DSPATR(&J06P0)
     A            J07S0         79A  O  7  2DSPATR(&J07P0)
     A            J08S0         79A  O  8  2DSPATR(&J08P0)
     A            J09S0         42A  O  9  2DSPATR(&J09P0)
     A            JSTR          30A  B  9 45DSPATR(HI UL)
     A                                      CHECK(LC)
     A            J09S1          5A  O  9 76DSPATR(&J09P1)
     A            J10S0         79A  O 10  2DSPATR(&J10P0)
     A            J11S0         42A  O 11  2DSPATR(&J11P0)
     A            JOCC           1A  B 11 45DSPATR(HI UL)
     A                                      CHECK(LC)
     A            J11S1         34A  O 11 47DSPATR(&J11P1)
     A            J12S0         79A  O 12  2DSPATR(&J12P0)
     A            J13S0         79A  O 13  2DSPATR(&J13P0)
     A            J14S0         42A  O 14  2DSPATR(&J14P0)
     A            JCAS           1A  B 14 45DSPATR(HI UL)
     A                                      CHECK(LC)
     A            J14S1         34A  O 14 47DSPATR(&J14P1)
     A            J15S0         79A  O 15  2DSPATR(&J15P0)
     A            J16S0         42A  O 16  2DSPATR(&J16P0)
     A            JDAT           1A  B 16 45DSPATR(HI UL)
     A                                      CHECK(LC)
     A            J16S1         34A  O 16 47DSPATR(&J16P1)
     A            J17S0         79A  O 17  2DSPATR(&J17P0)
     A            J18S0         79A  O 18  2DSPATR(&J18P0)
     A            J19S0         79A  O 19  2DSPATR(&J19P0)
     A            J20S0         79A  O 20  2DSPATR(&J20P0)
     A            J21S0         79A  O 21  2DSPATR(&J21P0)
     A            J22S0         79A  O 22  2DSPATR(&J22P0)
     A            J23S0         79A  O 23  2DSPATR(&J23P0)
     A            J24S0         79A  O 24  2DSPATR(&J24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            J01P0          1A  P
     A            J02P0          1A  P
     A            J03P0          1A  P
     A            J04P0          1A  P
     A            J05P0          1A  P
     A            J06P0          1A  P
     A            J07P0          1A  P
     A            J08P0          1A  P
     A            J09P0          1A  P
     A            J09P1          1A  P
     A            J10P0          1A  P
     A            J11P0          1A  P
     A            J11P1          1A  P
     A            J12P0          1A  P
     A            J13P0          1A  P
     A            J14P0          1A  P
     A            J14P1          1A  P
     A            J15P0          1A  P
     A            J16P0          1A  P
     A            J16P1          1A  P
     A            J17P0          1A  P
     A            J18P0          1A  P
     A            J19P0          1A  P
     A            J20P0          1A  P
     A            J21P0          1A  P
     A            J22P0          1A  P
     A            J23P0          1A  P
     A            J24P0          1A  P
     A          R GOINS                     CSRLOC(CSRROW CSRCOL)
     A            K01S0         79A  O  1  2DSPATR(&K01P0)
     A            K02S0         79A  O  2  2DSPATR(&K02P0)
     A            K03S0         79A  O  3  2DSPATR(&K03P0)
     A            K04S0         79A  O  4  2DSPATR(&K04P0)
     A            K05S0         79A  O  5  2DSPATR(&K05P0)
     A            K06S0         79A  O  6  2DSPATR(&K06P0)
     A            K07S0         79A  O  7  2DSPATR(&K07P0)
     A            K08S0         79A  O  8  2DSPATR(&K08P0)
     A            K09S0         79A  O  9  2DSPATR(&K09P0)
     A            K10S0         79A  O 10  2DSPATR(&K10P0)
     A            K11S0         79A  O 11  2DSPATR(&K11P0)
     A            K12S0         79A  O 12  2DSPATR(&K12P0)
     A            K13S0         51A  O 13  2DSPATR(&K13P0)
     A            KVAL          10A  B 13 54DSPATR(HI UL)
     A                                      CHECK(LC)
     A            K13S1         16A  O 13 65DSPATR(&K13P1)
     A            K14S0         79A  O 14  2DSPATR(&K14P0)
     A            K15S0         79A  O 15  2DSPATR(&K15P0)
     A            K16S0         79A  O 16  2DSPATR(&K16P0)
     A            K17S0         79A  O 17  2DSPATR(&K17P0)
     A            K18S0         79A  O 18  2DSPATR(&K18P0)
     A            K19S0         79A  O 19  2DSPATR(&K19P0)
     A            K20S0         79A  O 20  2DSPATR(&K20P0)
     A            K21S0         79A  O 21  2DSPATR(&K21P0)
     A            K22S0         79A  O 22  2DSPATR(&K22P0)
     A            K23S0         79A  O 23  2DSPATR(&K23P0)
     A            K24S0         79A  O 24  2DSPATR(&K24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            K01P0          1A  P
     A            K02P0          1A  P
     A            K03P0          1A  P
     A            K04P0          1A  P
     A            K05P0          1A  P
     A            K06P0          1A  P
     A            K07P0          1A  P
     A            K08P0          1A  P
     A            K09P0          1A  P
     A            K10P0          1A  P
     A            K11P0          1A  P
     A            K12P0          1A  P
     A            K13P0          1A  P
     A            K13P1          1A  P
     A            K14P0          1A  P
     A            K15P0          1A  P
     A            K16P0          1A  P
     A            K17P0          1A  P
     A            K18P0          1A  P
     A            K19P0          1A  P
     A            K20P0          1A  P
     A            K21P0          1A  P
     A            K22P0          1A  P
     A            K23P0          1A  P
     A            K24P0          1A  P
     A          R GOSUB                     CSRLOC(CSRROW CSRCOL)
     A            L01S0         79A  O  1  2DSPATR(&L01P0)
     A            L02S0         79A  O  2  2DSPATR(&L02P0)
     A            L03S0         79A  O  3  2DSPATR(&L03P0)
     A            L04S0         79A  O  4  2DSPATR(&L04P0)
     A            L05S0         79A  O  5  2DSPATR(&L05P0)
     A            L06S0         79A  O  6  2DSPATR(&L06P0)
     A            L07S0         79A  O  7  2DSPATR(&L07P0)
     A            L08S0         79A  O  8  2DSPATR(&L08P0)
     A            L09S0         79A  O  9  2DSPATR(&L09P0)
     A            L10S0         79A  O 10  2DSPATR(&L10P0)
     A            L11S0         79A  O 11  2DSPATR(&L11P0)
     A            L12S0         79A  O 12  2DSPATR(&L12P0)
     A            L13S0         48A  O 13  2DSPATR(&L13P0)
     A            LVAL          10A  B 13 51DSPATR(HI UL)
     A                                      CHECK(LC)
     A            L13S1         19A  O 13 62DSPATR(&L13P1)
     A            L14S0         79A  O 14  2DSPATR(&L14P0)
     A            L15S0         79A  O 15  2DSPATR(&L15P0)
     A            L16S0         79A  O 16  2DSPATR(&L16P0)
     A            L17S0         79A  O 17  2DSPATR(&L17P0)
     A            L18S0         79A  O 18  2DSPATR(&L18P0)
     A            L19S0         79A  O 19  2DSPATR(&L19P0)
     A            L20S0         79A  O 20  2DSPATR(&L20P0)
     A            L21S0         79A  O 21  2DSPATR(&L21P0)
     A            L22S0         79A  O 22  2DSPATR(&L22P0)
     A            L23S0         79A  O 23  2DSPATR(&L23P0)
     A            L24S0         79A  O 24  2DSPATR(&L24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            L01P0          1A  P
     A            L02P0          1A  P
     A            L03P0          1A  P
     A            L04P0          1A  P
     A            L05P0          1A  P
     A            L06P0          1A  P
     A            L07P0          1A  P
     A            L08P0          1A  P
     A            L09P0          1A  P
     A            L10P0          1A  P
     A            L11P0          1A  P
     A            L12P0          1A  P
     A            L13P0          1A  P
     A            L13P1          1A  P
     A            L14P0          1A  P
     A            L15P0          1A  P
     A            L16P0          1A  P
     A            L17P0          1A  P
     A            L18P0          1A  P
     A            L19P0          1A  P
     A            L20P0          1A  P
     A            L21P0          1A  P
     A            L22P0          1A  P
     A            L23P0          1A  P
     A            L24P0          1A  P
     A          R DBGOPT                    CSRLOC(CSRROW CSRCOL)
     A            M01S0         79A  O  1  2DSPATR(&M01P0)
     A            M02S0         79A  O  2  2DSPATR(&M02P0)
     A            M03S0         79A  O  3  2DSPATR(&M03P0)
     A            M04S0         79A  O  4  2DSPATR(&M04P0)
     A            M05S0         79A  O  5  2DSPATR(&M05P0)
     A            M06S0         79A  O  6  2DSPATR(&M06P0)
     A            M07S0         79A  O  7  2DSPATR(&M07P0)
     A            M08S0         79A  O  8  2DSPATR(&M08P0)
     A            M09S0         79A  O  9  2DSPATR(&M09P0)
     A            M10S0         79A  O 10  2DSPATR(&M10P0)
     A            M11S0         50A  O 11  2DSPATR(&M11P0)
     A            MREP           1A  B 11 53DSPATR(HI UL)
     A                                      CHECK(LC)
     A            M11S1         26A  O 11 55DSPATR(&M11P1)
     A            M12S0         79A  O 12  2DSPATR(&M12P0)
     A            M13S0         79A  O 13  2DSPATR(&M13P0)
     A            M14S0         79A  O 14  2DSPATR(&M14P0)
     A            M15S0         79A  O 15  2DSPATR(&M15P0)
     A            M16S0         79A  O 16  2DSPATR(&M16P0)
     A            M17S0         79A  O 17  2DSPATR(&M17P0)
     A            M18S0         79A  O 18  2DSPATR(&M18P0)
     A            M19S0         79A  O 19  2DSPATR(&M19P0)
     A            M20S0         79A  O 20  2DSPATR(&M20P0)
     A            M21S0         79A  O 21  2DSPATR(&M21P0)
     A            M22S0         79A  O 22  2DSPATR(&M22P0)
     A            M23S0         79A  O 23  2DSPATR(&M23P0)
     A            M24S0         79A  O 24  2DSPATR(&M24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            M01P0          1A  P
     A            M02P0          1A  P
     A            M03P0          1A  P
     A            M04P0          1A  P
     A            M05P0          1A  P
     A            M06P0          1A  P
     A            M07P0          1A  P
     A            M08P0          1A  P
     A            M09P0          1A  P
     A            M10P0          1A  P
     A            M11P0          1A  P
     A            M11P1          1A  P
     A            M12P0          1A  P
     A            M13P0          1A  P
     A            M14P0          1A  P
     A            M15P0          1A  P
     A            M16P0          1A  P
     A            M17P0          1A  P
     A            M18P0          1A  P
     A            M19P0          1A  P
     A            M20P0          1A  P
     A            M21P0          1A  P
     A            M22P0          1A  P
     A            M23P0          1A  P
     A            M24P0          1A  P
     A          R DSPOPT                    CSRLOC(CSRROW CSRCOL)
     A            N01S0         79A  O  1  2DSPATR(&N01P0)
     A            N02S0         79A  O  2  2DSPATR(&N02P0)
     A            N03S0         79A  O  3  2DSPATR(&N03P0)
     A            N04S0         79A  O  4  2DSPATR(&N04P0)
     A            N05S0         79A  O  5  2DSPATR(&N05P0)
     A            N06S0         79A  O  6  2DSPATR(&N06P0)
     A            N07S0         79A  O  7  2DSPATR(&N07P0)
     A            N08S0         79A  O  8  2DSPATR(&N08P0)
     A            N09S0         79A  O  9  2DSPATR(&N09P0)
     A            N10S0         52A  O 10  2DSPATR(&N10P0)
     A            NROL           3A  B 10 55DSPATR(HI UL)
     A                                      CHECK(LC)
     A            N10S1         22A  O 10 59DSPATR(&N10P1)
     A            N11S0         79A  O 11  2DSPATR(&N11P0)
     A            N12S0         52A  O 12  2DSPATR(&N12P0)
     A            NDEC           3A  B 12 55DSPATR(HI UL)
     A                                      CHECK(LC)
     A            N12S1         22A  O 12 59DSPATR(&N12P1)
     A            N13S0         79A  O 13  2DSPATR(&N13P0)
     A            N14S0         52A  O 14  2DSPATR(&N14P0)
     A            NCOU           1A  B 14 55DSPATR(HI UL)
     A                                      CHECK(LC)
     A            N14S1         24A  O 14 57DSPATR(&N14P1)
     A            N15S0         79A  O 15  2DSPATR(&N15P0)
     A            N16S0         79A  O 16  2DSPATR(&N16P0)
     A            N17S0         79A  O 17  2DSPATR(&N17P0)
     A            N18S0         79A  O 18  2DSPATR(&N18P0)
     A            N19S0         79A  O 19  2DSPATR(&N19P0)
     A            N20S0         79A  O 20  2DSPATR(&N20P0)
     A            N21S0         79A  O 21  2DSPATR(&N21P0)
     A            N22S0         79A  O 22  2DSPATR(&N22P0)
     A            N23S0         79A  O 23  2DSPATR(&N23P0)
     A            N24S0         79A  O 24  2DSPATR(&N24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            N01P0          1A  P
     A            N02P0          1A  P
     A            N03P0          1A  P
     A            N04P0          1A  P
     A            N05P0          1A  P
     A            N06P0          1A  P
     A            N07P0          1A  P
     A            N08P0          1A  P
     A            N09P0          1A  P
     A            N10P0          1A  P
     A            N10P1          1A  P
     A            N11P0          1A  P
     A            N12P0          1A  P
     A            N12P1          1A  P
     A            N13P0          1A  P
     A            N14P0          1A  P
     A            N14P1          1A  P
     A            N15P0          1A  P
     A            N16P0          1A  P
     A            N17P0          1A  P
     A            N18P0          1A  P
     A            N19P0          1A  P
     A            N20P0          1A  P
     A            N21P0          1A  P
     A            N22P0          1A  P
     A            N23P0          1A  P
     A            N24P0          1A  P
     A          R PGMLST                    CSRLOC(CSRROW CSRCOL)
     A            O01S0         79A  O  1  2DSPATR(&O01P0)
     A            O02S0         79A  O  2  2DSPATR(&O02P0)
     A            O03S0         79A  O  3  2DSPATR(&O03P0)
     A            O04S0         79A  O  4  2DSPATR(&O04P0)
     A            O05S0         79A  O  5  2DSPATR(&O05P0)
     A            O06S0         79A  O  6  2DSPATR(&O06P0)
     A            OOPT0          1A  B  7  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O07S0          3A  O  7  4DSPATR(&O07P0)
     A            OPGM0         10A  B  7  8DSPATR(HI UL)
     A                                      CHECK(LC)
     A            OLIB0         10A  B  7 20DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O07S1         50A  O  7 31DSPATR(&O07P1)
     A            OOPT1          1A  B  8  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O08S0         77A  O  8  4DSPATR(&O08P0)
     A            OOPT2          1A  B  9  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O09S0         77A  O  9  4DSPATR(&O09P0)
     A            OOPT3          1A  B 10  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O10S0         77A  O 10  4DSPATR(&O10P0)
     A            OOPT4          1A  B 11  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O11S0         77A  O 11  4DSPATR(&O11P0)
     A            OOPT5          1A  B 12  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O12S0         77A  O 12  4DSPATR(&O12P0)
     A            OOPT6          1A  B 13  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O13S0         77A  O 13  4DSPATR(&O13P0)
     A            OOPT7          1A  B 14  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O14S0         77A  O 14  4DSPATR(&O14P0)
     A            OOPT8          1A  B 15  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O15S0         77A  O 15  4DSPATR(&O15P0)
     A            OOPT9          1A  B 16  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O16S0         77A  O 16  4DSPATR(&O16P0)
     A            OOPT10         1A  B 17  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O17S0         77A  O 17  4DSPATR(&O17P0)
     A            OOPT11         1A  B 18  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O18S0         77A  O 18  4DSPATR(&O18P0)
     A            OOPT12         1A  B 19  2DSPATR(HI UL)
     A                                      CHECK(LC)
     A            O19S0         77A  O 19  4DSPATR(&O19P0)
     A            O20S0         79A  O 20  2DSPATR(&O20P0)
     A            O21S0         79A  O 21  2DSPATR(&O21P0)
     A            O22S0         79A  O 22  2DSPATR(&O22P0)
     A            O23S0         79A  O 23  2DSPATR(&O23P0)
     A            O24S0         79A  O 24  2DSPATR(&O24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            O01P0          1A  P
     A            O02P0          1A  P
     A            O03P0          1A  P
     A            O04P0          1A  P
     A            O05P0          1A  P
     A            O06P0          1A  P
     A            O07P0          1A  P
     A            O07P1          1A  P
     A            O08P0          1A  P
     A            O09P0          1A  P
     A            O10P0          1A  P
     A            O11P0          1A  P
     A            O12P0          1A  P
     A            O13P0          1A  P
     A            O14P0          1A  P
     A            O15P0          1A  P
     A            O16P0          1A  P
     A            O17P0          1A  P
     A            O18P0          1A  P
     A            O19P0          1A  P
     A            O20P0          1A  P
     A            O21P0          1A  P
     A            O22P0          1A  P
     A            O23P0          1A  P
     A            O24P0          1A  P
     A          R NOINP                     CSRLOC(CSRROW CSRCOL)
     A            P01S0         79A  O  1  2DSPATR(&P01P0)
     A            P02S0         79A  O  2  2DSPATR(&P02P0)
     A            P03S0         79A  O  3  2DSPATR(&P03P0)
     A            P04S0         79A  O  4  2DSPATR(&P04P0)
     A            P05S0         79A  O  5  2DSPATR(&P05P0)
     A            P06S0         79A  O  6  2DSPATR(&P06P0)
     A            P07S0         79A  O  7  2DSPATR(&P07P0)
     A            P08S0         79A  O  8  2DSPATR(&P08P0)
     A            P09S0         79A  O  9  2DSPATR(&P09P0)
     A            P10S0         79A  O 10  2DSPATR(&P10P0)
     A            P11S0         79A  O 11  2DSPATR(&P11P0)
     A            P12S0         79A  O 12  2DSPATR(&P12P0)
     A            P13S0         79A  O 13  2DSPATR(&P13P0)
     A            P14S0         79A  O 14  2DSPATR(&P14P0)
     A            P15S0         79A  O 15  2DSPATR(&P15P0)
     A            P16S0         79A  O 16  2DSPATR(&P16P0)
     A            P17S0         79A  O 17  2DSPATR(&P17P0)
     A            P18S0         79A  O 18  2DSPATR(&P18P0)
     A            P19S0         79A  O 19  2DSPATR(&P19P0)
     A            P20S0         79A  O 20  2DSPATR(&P20P0)
     A            P21S0         79A  O 21  2DSPATR(&P21P0)
     A            P22S0         79A  O 22  2DSPATR(&P22P0)
     A            P23S0         79A  O 23  2DSPATR(&P23P0)
     A            P24S0         79A  O 24  2DSPATR(&P24P0)
     A            CSRROW         3S 0H
     A            CSRCOL         3S 0H
     A            P01P0          1A  P
     A            P02P0          1A  P
     A            P03P0          1A  P
     A            P04P0          1A  P
     A            P05P0          1A  P
     A            P06P0          1A  P
     A            P07P0          1A  P
     A            P08P0          1A  P
     A            P09P0          1A  P
     A            P10P0          1A  P
     A            P11P0          1A  P
     A            P12P0          1A  P
     A            P13P0          1A  P
     A            P14P0          1A  P
     A            P15P0          1A  P
     A            P16P0          1A  P
     A            P17P0          1A  P
     A            P18P0          1A  P
     A            P19P0          1A  P
     A            P20P0          1A  P
     A            P21P0          1A  P
     A            P22P0          1A  P
     A            P23P0          1A  P
     A            P24P0          1A  P
```
