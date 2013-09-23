--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Navigation.Vectors.CVector_Test_Data.

with AUnit.Assertions; use AUnit.Assertions;

package body Navigation.Vectors.CVector_Test_Data.CVector_Tests is


--  begin read only
   procedure Test_pxGet_Copy (Gnattest_T : in out Test_CVector);
   procedure Test_pxGet_Copy_903b17 (Gnattest_T : in out Test_CVector) renames Test_pxGet_Copy;
--  id:2.1/903b174499f56216/pxGet_Copy/1/0/
   procedure Test_pxGet_Copy (Gnattest_T : in out Test_CVector) is
   --  navigation-vectors.ads:10:4:pxGet_Copy
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxTestVector : pCVector;
      pxCopiedVector : pCVector;
   begin

      pxTestVector := Navigation.Vectors.pxCreate(fX => 5.2,
                                                  fY => -2.6,
                                                  fZ => 8.2);
      pxCopiedVector := pxTestVector.pxGet_Copy;

      AUnit.Assertions.Assert(Condition => pxCopiedVector.fX = 5.2,
                              Message   => "CVector.pxGetCopy failed, fX got the wrong value");
      AUnit.Assertions.Assert(Condition => pxCopiedVector.fY = -2.6,
                              Message   => "CVector.pxGetCopy failed, fY got the wrong value");
      AUnit.Assertions.Assert(Condition => pxCopiedVector.fZ = 8.2,
                              Message   => "CVector.pxGetCopy failed, fZ got the wrong value");

--  begin read only
   end Test_pxGet_Copy;
--  end read only


--  begin read only
   procedure Test_pxGet_Normalized (Gnattest_T : in out Test_CVector);
   procedure Test_pxGet_Normalized_ee3c35 (Gnattest_T : in out Test_CVector) renames Test_pxGet_Normalized;
--  id:2.1/ee3c35c873218995/pxGet_Normalized/1/0/
   procedure Test_pxGet_Normalized (Gnattest_T : in out Test_CVector) is
   --  navigation-vectors.ads:11:4:pxGet_Normalized
--  end read only

      pragma Unreferenced (Gnattest_T);


      pxTestVector : pCVector;
      pxNormalizedVector : pCVector;
   begin


      pxTestVector := Navigation.Vectors.pxCreate(fX => 14.2,
                                                  fY => -64.2,
                                                  fZ => 0.2);
      pxNormalizedVector := pxTestVector.pxGet_Normalized;
      AUnit.Assertions.Assert(Condition => abs(pxNormalizedVector.fLength - 1.0) < 0.0001,
                              Message   => "CVector.pxGet_Normalized failed");

      -- test exceptions
      pxTestVector := Navigation.Vectors.pxCreate(fX => 0.0,
                                                  fY => 0.0,
                                                  fZ => 0.0);
      pxNormalizedVector := pxTestVector.pxGet_Normalized;
      AUnit.Assertions.Assert(Condition => False,
                              Message   => "CVector.pxGet_Normalized division by zero failed, should have raised exception");
   exception
      when Numeric_Error =>
         null; -- Test passed
      when E : others =>
         AUnit.Assertions.Assert(Condition => False,
                                 Message   =>"CVector.pxGet_Normalized division by zero failed, wrong exception raised: " & Ada.Exceptions.Exception_Name (E) & ". Expected: NUMERIC_ERROR.");

--  begin read only
   end Test_pxGet_Normalized;
--  end read only


--  begin read only
   procedure Test_fLength_Squared (Gnattest_T : in out Test_CVector);
   procedure Test_fLength_Squared_3272b8 (Gnattest_T : in out Test_CVector) renames Test_fLength_Squared;
--  id:2.1/3272b8b09e9cef04/fLength_Squared/1/0/
   procedure Test_fLength_Squared (Gnattest_T : in out Test_CVector) is
   --  navigation-vectors.ads:13:4:fLength_Squared
--  end read only

      pragma Unreferenced (Gnattest_T);
      pxTestVector : Navigation.Vectors.pCVector;

    begin

      pxTestVector := Navigation.Vectors.pxCreate(fX => 10.0,
                                                  fY => 5.0,
                                                  fZ => 2.0);
      AUnit.Assertions.Assert(Condition => pxTestVector.fLength_Squared = 129.0,
                              Message   => "CVector.fLength_Squared failed");
--  begin read only
   end Test_fLength_Squared;
--  end read only


--  begin read only
   procedure Test_fLength (Gnattest_T : in out Test_CVector);
   procedure Test_fLength_c558df (Gnattest_T : in out Test_CVector) renames Test_fLength;
--  id:2.1/c558df42f64fcbf4/fLength/1/0/
   procedure Test_fLength (Gnattest_T : in out Test_CVector) is
   --  navigation-vectors.ads:14:4:fLength
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxTestVector : pCVector;
   begin

      pxTestVector := Navigation.Vectors.pxCreate(fX => 5.0,
                                                  fY => 2.0,
                                                  fZ => -6.0);

      AUnit.Assertions.Assert(Condition => abs(pxTestVector.fLength - 8.06226) < 0.0001,
                              Message   => "CVector.fLength failed");

--  begin read only
   end Test_fLength;
--  end read only


--  begin read only
   procedure Test_fGet_X (Gnattest_T : in out Test_CVector);
   procedure Test_fGet_X_6400b5 (Gnattest_T : in out Test_CVector) renames Test_fGet_X;
--  id:2.1/6400b5dd56bcaca7/fGet_X/1/0/
   procedure Test_fGet_X (Gnattest_T : in out Test_CVector) is
   --  navigation-vectors.ads:30:4:fGet_X
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxTestVector : pCVector;
   begin

      pxTestVector := Navigation.Vectors.pxCreate(fX => 23.5,
                                                  fY => 0.0,
                                                  fZ => 0.0);

      AUnit.Assertions.Assert(Condition => pxTestVector.fX = 23.5,
                              Message   => "CVector.fGet_X failed");

--  begin read only
   end Test_fGet_X;
--  end read only


--  begin read only
   procedure Test_fGet_Y (Gnattest_T : in out Test_CVector);
   procedure Test_fGet_Y_0af71a (Gnattest_T : in out Test_CVector) renames Test_fGet_Y;
--  id:2.1/0af71a48617648e1/fGet_Y/1/0/
   procedure Test_fGet_Y (Gnattest_T : in out Test_CVector) is
   --  navigation-vectors.ads:31:4:fGet_Y
--  end read only

      pragma Unreferenced (Gnattest_T);


      pxTestVector : pCVector;
   begin

      pxTestVector := Navigation.Vectors.pxCreate(fX => 0.0,
                                                  fY => 23.5,
                                                  fZ => 0.0);

      AUnit.Assertions.Assert(Condition => pxTestVector.fY = 23.5,
                              Message   => "CVector.fGet_Y failed");

--  begin read only
   end Test_fGet_Y;
--  end read only


--  begin read only
   procedure Test_fGet_Z (Gnattest_T : in out Test_CVector);
   procedure Test_fGet_Z_050233 (Gnattest_T : in out Test_CVector) renames Test_fGet_Z;
--  id:2.1/0502331128d9664e/fGet_Z/1/0/
   procedure Test_fGet_Z (Gnattest_T : in out Test_CVector) is
   --  navigation-vectors.ads:32:4:fGet_Z
--  end read only

      pragma Unreferenced (Gnattest_T);


      pxTestVector : pCVector;
   begin

      pxTestVector := Navigation.Vectors.pxCreate(fX => 0.0,
                                                  fY => 0.0,
                                                  fZ => 23.5);

      AUnit.Assertions.Assert(Condition => pxTestVector.fZ = 23.5,
                              Message   => "CVector.fGet_Z failed");

--  begin read only
   end Test_fGet_Z;
--  end read only


--  begin read only
   procedure Test_1_Devide (Gnattest_T : in out Test_CVector);
   procedure Test_Devide_f99f33 (Gnattest_T : in out Test_CVector) renames Test_1_Devide;
--  id:2.1/f99f33b37397ceb4/Devide/1/0/
   procedure Test_1_Devide (Gnattest_T : in out Test_CVector) is
   --  navigation-vectors.ads:43:4:"/"
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxDividedVector : Navigation.Vectors.pCVector;
      xLeftOperandVector : Navigation.Vectors.CVector;
      fRightOperand : float;

   begin

      xLeftOperandVector := (fX => 2.0, fY => 5.0,fZ => 4.0);
      fRightOperand := 2.0;

      pxDividedVector := xLeftOperandVector / fRightOperand;

      AUnit.Assertions.Assert(Condition => pxDividedVector.fX = 1.0,
                              Message   => "CVector./(binary CVector / float) failed, fX got the wrong value");
      AUnit.Assertions.Assert(Condition => pxDividedVector.fY = 2.5,
                              Message   => "CVector./(binary CVector / float) failed, fY got the wrong value");
      AUnit.Assertions.Assert(Condition => pxDividedVector.fZ = 2.0,
                              Message   => "CVector./(binary CVector / float) failed, fZ got the wrong value");

      -- test exceptions
      fRightOperand := 0.0;
      pxDividedVector := xLeftOperandVector / fRightOperand;
      AUnit.Assertions.Assert(Condition => False,
                              Message   => "CVector./(binary CVector / float) division by zero failed, should have raised exception");
   exception
      when Numeric_Error =>
         null; -- Test passed
      when E : others =>
         AUnit.Assertions.Assert(Condition => False,
                           Message   =>"CVector./(binary CVector / float) division by zero failed, wrong exception raised: " & Ada.Exceptions.Exception_Name (E) & ". Expected: NUMERIC_ERROR.");


--  begin read only
   end Test_1_Devide;
--  end read only

end Navigation.Vectors.CVector_Test_Data.CVector_Tests;