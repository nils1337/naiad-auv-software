--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Math.Quaternions.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;

package body Math.Quaternions.Test_Data.Tests is


--  begin read only
   procedure Test_1_pxCreate (Gnattest_T : in out Test);
   procedure Test_pxCreate_fbac4b (Gnattest_T : in out Test) renames Test_1_pxCreate;
--  id:2.1/fbac4bee6ca29f21/pxCreate/1/0/
   procedure Test_1_pxCreate (Gnattest_T : in out Test) is
   --  math-quaternions.ads:9:4:pxCreate
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxNewQuaternion : pCQuaternion;
      fExpectedXValue : float := 3.0;
      fExpectedYValue : float := 4.0;
      fExpectedZValue : float := -5.0;
      fExpectedWValue : float := 10.0;
   begin

      pxNewQuaternion := Math.Quaternions.pxCreate(fX => fExpectedXValue,
                                                   fY => fExpectedYValue,
                                                   fZ => fExpectedZValue,
                                                   fW => fExpectedWValue);


      AUnit.Assertions.Assert(Condition => pxNewQuaternion.fX = fExpectedXValue,
                              Message   => "CQuaternion.pxCreate failed, fX got the wrong value. Value:" & float'Image(pxNewQuaternion.fX) & ". Expected:" & float'Image(fExpectedXValue) & ".");
      AUnit.Assertions.Assert(Condition => pxNewQuaternion.fY = fExpectedYValue,
                              Message   => "CQuaternion.pxCreate failed, fY got the wrong value. Value:" & float'Image(pxNewQuaternion.fY) & ". Expected:" & float'Image(fExpectedYValue) & ".");
      AUnit.Assertions.Assert(Condition => pxNewQuaternion.fZ = fExpectedZValue,
                              Message   => "CQuaternion.pxCreate failed, fZ got the wrong value. Value:" & float'Image(pxNewQuaternion.fZ) & ". Expected:" & float'Image(fExpectedZValue) & ".");
      AUnit.Assertions.Assert(Condition => pxNewQuaternion.fW = fExpectedWValue,
                              Message   => "CQuaternion.pxCreate failed, fW got the wrong value. Value:" & float'Image(pxNewQuaternion.fW) & ". Expected:" & float'Image(fExpectedWValue) & ".");

--  begin read only
   end Test_1_pxCreate;
--  end read only


--  begin read only
   procedure Test_2_pxCreate (Gnattest_T : in out Test);
   procedure Test_pxCreate_937a51 (Gnattest_T : in out Test) renames Test_2_pxCreate;
--  id:2.1/937a5186dd726f3b/pxCreate/0/0/
   procedure Test_2_pxCreate (Gnattest_T : in out Test) is
   --  math-quaternions.ads:10:4:pxCreate
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxNewQuaternion : pCQuaternion;
      pxTestVector : Math.Vectors.pCVector;
      fAngle : float := 4.0;
      fExpectedXValue : float := 1.0;
      fExpectedYValue : float := 1.0;
      fExpectedZValue : float := 0.0;
   begin

      pxTestVector := Math.Vectors.pxCreate(fX => fExpectedXValue,
                                            fY => fExpectedYValue,
                                            fZ => fExpectedZValue);
      pxNewQuaternion := Math.Quaternions.pxCreate(pxAxisVector    => pxTestVector,
                                                   fAngleInDegrees => fAngle);

      pxTestVector := pxTestVector.pxGet_Normalized;
      fExpectedXValue := pxTestVector.fGet_X;
      fExpectedYValue := pxTestVector.fGet_Y;
      fExpectedZValue := pxTestVector.fGet_Z;

      pxTestVector := pxNewQuaternion.fGet_Axis_Vector;
      Ada.Text_IO.Put_Line("NEW: " & float'Image(pxNewQuaternion.fX) & float'Image(pxNewQuaternion.fY) & float'Image(pxNewQuaternion.fZ) & float'Image(pxNewQuaternion.fW));

      AUnit.Assertions.Assert(Condition => abs(pxTestVector.fGet_X - fExpectedXValue) < 0.001,
                              Message   => "CQuaternion.pxCreate failed, fX got the wrong value.");
      AUnit.Assertions.Assert(Condition => abs(pxTestVector.fGet_Y - fExpectedYValue) < 0.001,
                              Message   => "CQuaternion.pxCreate failed, fY got the wrong value.");
      AUnit.Assertions.Assert(Condition => abs(pxTestVector.fGet_Z - fExpectedZValue) < 0.001,
                              Message   => "CQuaternion.pxCreate failed, fZ got the wrong value.");
      AUnit.Assertions.Assert(Condition => abs(pxNewQuaternion.fGet_Angle - fAngle) < 0.001,
                              Message   => "CQuaternion.pxCreate failed, fW got the wrong value. Angle: " & float'Image(pxNewQuaternion.fGet_Angle));

     -- test exceptions
      pxTestVector := Math.Vectors.pxCreate(fX => 0.0,
                                            fY => 0.0,
                                            fZ => 0.0);
      fAngle := 0.0;

      pxNewQuaternion := Math.Quaternions.pxCreate(pxAxisVector    => pxTestVector,
                                                   fAngleInDegrees => fAngle);
      AUnit.Assertions.Assert(Condition => False,
                              Message   => "CQuaternion.pxCreate division by zero failed, should have raised exception");
   exception
      when Numeric_Error =>
         null; -- Test passed
      when E : others =>
         AUnit.Assertions.Assert(Condition => False,
                           Message   =>"CQuaternion.pxCreate division by zero failed, wrong exception raised: " & Ada.Exceptions.Exception_Name (E) & ". Expected: NUMERIC_ERROR.");


--  begin read only
   end Test_2_pxCreate;
--  end read only


--  begin read only
   procedure Test_Plus (Gnattest_T : in out Test);
   procedure Test_Plus_bd5b1d (Gnattest_T : in out Test) renames Test_Plus;
--  id:2.1/bd5b1df12406b840/Plus/1/0/
   procedure Test_Plus (Gnattest_T : in out Test) is
   --  math-quaternions.ads:13:4:"+"
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxLeftOperandQuaternion : pCQuaternion;
      pxRightOperandQuaternion : pCQuaternion;
      pxSumQuaternion : pCQuaternion;
   begin

      pxLeftOperandQuaternion := Math.Quaternions.pxCreate(fX => 2.3,
                                                           fY => -5.3,
                                                           fZ => 6.2,
                                                           fW => 6.0);
      pxRightOperandQuaternion := Math.Quaternions.pxCreate(fX => 12.5,
                                                            fY => 60.2,
                                                            fZ => -523.0,
                                                            fW => 23.0);
      pxSumQuaternion := pxLeftOperandQuaternion + pxRightOperandQuaternion;

      AUnit.Assertions.Assert(Condition => pxSumQuaternion'Address /= pxLeftOperandQuaternion'Address,
                              Message   => "CQuaternion.+(binary) failed, pointer to sum is the same as pointer to left operand.");
      AUnit.Assertions.Assert(Condition => pxSumQuaternion'Address /= pxRightOperandQuaternion'Address,
                              Message   => "CQuaternion.+(binary) failed, pointer to sum is the same as pointer to right operand.");

      AUnit.Assertions.Assert(Condition => pxSumQuaternion.fX = (pxLeftOperandQuaternion.fX + pxRightOperandQuaternion.fX),
                              Message   => "CQuaternion.+(binary) failed, wrong result in X component. Value: " & float'Image(pxSumQuaternion.fX) & ". Expected: " & float'Image(pxLeftOperandQuaternion.fX + pxRightOperandQuaternion.fX) & ".");
      AUnit.Assertions.Assert(Condition => pxSumQuaternion.fY = (pxLeftOperandQuaternion.fY + pxRightOperandQuaternion.fY),
                              Message   => "CQuaternion.+(binary) failed, wrong result in Y component. Value: " & float'Image(pxSumQuaternion.fY) & ". Expected: " & float'Image(pxLeftOperandQuaternion.fY + pxRightOperandQuaternion.fY) & ".");
      AUnit.Assertions.Assert(Condition => pxSumQuaternion.fZ = (pxLeftOperandQuaternion.fZ + pxRightOperandQuaternion.fZ),
                              Message   => "CQuaternion.+(binary) failed, wrong result in Z component. Value: " & float'Image(pxSumQuaternion.fZ) & ". Expected: " & float'Image(pxLeftOperandQuaternion.fZ + pxRightOperandQuaternion.fZ) & ".");
      AUnit.Assertions.Assert(Condition => pxSumQuaternion.fW = (pxLeftOperandQuaternion.fW + pxRightOperandQuaternion.fW),
                              Message   => "CQuaternion.+(binary) failed, wrong result in W component. Value: " & float'Image(pxSumQuaternion.fW) & ". Expected: " & float'Image(pxLeftOperandQuaternion.fW + pxRightOperandQuaternion.fW) & ".");

--  begin read only
   end Test_Plus;
--  end read only


--  begin read only
   procedure Test_Minus (Gnattest_T : in out Test);
   procedure Test_Minus_2f7442 (Gnattest_T : in out Test) renames Test_Minus;
--  id:2.1/2f74421dfd689023/Minus/1/0/
   procedure Test_Minus (Gnattest_T : in out Test) is
   --  math-quaternions.ads:14:4:"-"
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxLeftOperandQuaternion : pCQuaternion;
      pxRightOperandQuaternion : pCQuaternion;
      pxDifferenceQuaternion : pCQuaternion;
   begin

      pxLeftOperandQuaternion := Math.Quaternions.pxCreate(fX => 2.3,
                                                           fY => -5.3,
                                                           fZ => 6.2,
                                                           fW => 6.0);
      pxRightOperandQuaternion := Math.Quaternions.pxCreate(fX => 12.5,
                                                            fY => 60.2,
                                                            fZ => -523.0,
                                                            fW => 23.0);
      pxDifferenceQuaternion := pxLeftOperandQuaternion - pxRightOperandQuaternion;

      AUnit.Assertions.Assert(Condition => pxDifferenceQuaternion'Address /= pxLeftOperandQuaternion'Address,
                              Message   => "CQuaternion.-(binary) failed, pointer to difference is the same as pointer to left operand.");
      AUnit.Assertions.Assert(Condition => pxDifferenceQuaternion'Address /= pxRightOperandQuaternion'Address,
                              Message   => "CQuaternion.-(binary) failed, pointer to difference is the same as pointer to right operand.");

      AUnit.Assertions.Assert(Condition => pxDifferenceQuaternion.fX = (pxLeftOperandQuaternion.fX - pxRightOperandQuaternion.fX),
                              Message   => "CQuaternion.-(binary) failed, wrong result in X component. Value: " & float'Image(pxDifferenceQuaternion.fX) & ". Expected: " & float'Image(pxLeftOperandQuaternion.fX - pxRightOperandQuaternion.fX) & ".");
      AUnit.Assertions.Assert(Condition => pxDifferenceQuaternion.fY = (pxLeftOperandQuaternion.fY - pxRightOperandQuaternion.fY),
                              Message   => "CQuaternion.-(binary) failed, wrong result in Y component. Value: " & float'Image(pxDifferenceQuaternion.fY) & ". Expected: " & float'Image(pxLeftOperandQuaternion.fY - pxRightOperandQuaternion.fY) & ".");
      AUnit.Assertions.Assert(Condition => pxDifferenceQuaternion.fZ = (pxLeftOperandQuaternion.fZ - pxRightOperandQuaternion.fZ),
                              Message   => "CQuaternion.-(binary) failed, wrong result in Z component. Value: " & float'Image(pxDifferenceQuaternion.fZ) & ". Expected: " & float'Image(pxLeftOperandQuaternion.fZ - pxRightOperandQuaternion.fZ) & ".");
      AUnit.Assertions.Assert(Condition => pxDifferenceQuaternion.fW = (pxLeftOperandQuaternion.fW - pxRightOperandQuaternion.fW),
                              Message   => "CQuaternion.-(binary) failed, wrong result in W component. Value: " & float'Image(pxDifferenceQuaternion.fW) & ". Expected: " & float'Image(pxLeftOperandQuaternion.fW - pxRightOperandQuaternion.fW) & ".");

--  begin read only
   end Test_Minus;
--  end read only


--  begin read only
   procedure Test_Multiply (Gnattest_T : in out Test);
   procedure Test_Multiply_cbc666 (Gnattest_T : in out Test) renames Test_Multiply;
--  id:2.1/cbc66689b1a4c76f/Multiply/1/0/
   procedure Test_Multiply (Gnattest_T : in out Test) is
   --  math-quaternions.ads:15:4:"*"
--  end read only

      pragma Unreferenced (Gnattest_T);
      pxLeftOperandQuaternion : pCQuaternion;
      pxRightOperandQuaternion : pCQuaternion;
      pxProductQuaternion : pCQuaternion;
      fExpectedX : float;
      fExpectedY : float;
      fExpectedZ : float;
      fExpectedW : float;
   begin

      pxLeftOperandQuaternion := Math.Quaternions.pxCreate(fX => 2.3,
                                                           fY => -5.3,
                                                           fZ => 6.2,
                                                           fW => 6.0);
      pxRightOperandQuaternion := Math.Quaternions.pxCreate(fX => 12.5,
                                                            fY => 60.2,
                                                            fZ => -523.0,
                                                            fW => 23.0);
      pxProductQuaternion := pxLeftOperandQuaternion * pxRightOperandQuaternion;

      fExpectedX := ((pxLeftOperandQuaternion.fW*pxRightOperandQuaternion.fX)+(pxLeftOperandQuaternion.fX*pxRightOperandQuaternion.fW)+(pxLeftOperandQuaternion.fY*pxRightOperandQuaternion.fZ)-(pxLeftOperandQuaternion.fZ*pxRightOperandQuaternion.fY));
      fExpectedY := ((pxLeftOperandQuaternion.fW*pxRightOperandQuaternion.fY)-(pxLeftOperandQuaternion.fX*pxRightOperandQuaternion.fZ)+(pxLeftOperandQuaternion.fY*pxRightOperandQuaternion.fW)+(pxLeftOperandQuaternion.fZ*pxRightOperandQuaternion.fX));
      fExpectedZ := ((pxLeftOperandQuaternion.fW*pxRightOperandQuaternion.fZ)+(pxLeftOperandQuaternion.fX*pxRightOperandQuaternion.fY)-(pxLeftOperandQuaternion.fY*pxRightOperandQuaternion.fX)-(pxLeftOperandQuaternion.fZ*pxRightOperandQuaternion.fW));
      fExpectedW := ((pxLeftOperandQuaternion.fW*pxRightOperandQuaternion.fW)-(pxLeftOperandQuaternion.fX*pxRightOperandQuaternion.fX)-(pxLeftOperandQuaternion.fY*pxRightOperandQuaternion.fY)-(pxLeftOperandQuaternion.fZ*pxRightOperandQuaternion.fZ));

      AUnit.Assertions.Assert(Condition => pxProductQuaternion'Address /= pxLeftOperandQuaternion'Address,
                              Message   => "CQuaternion.*(binary) failed, pointer to product is the same as pointer to left operand.");
      AUnit.Assertions.Assert(Condition => pxProductQuaternion'Address /= pxRightOperandQuaternion'Address,
                              Message   => "CQuaternion.*(binary) failed, pointer to product is the same as pointer to right operand.");

      AUnit.Assertions.Assert(Condition => pxProductQuaternion.fX = fExpectedX,
                              Message   => "CQuaternion.*(binary) failed, wrong result in X component. Value: " & float'Image(pxProductQuaternion.fX) & ". Expected: " & float'Image(fExpectedX) & ".");
      AUnit.Assertions.Assert(Condition => pxProductQuaternion.fY = fExpectedY,
                              Message   => "CQuaternion.*(binary) failed, wrong result in Y component. Value: " & float'Image(pxProductQuaternion.fY) & ". Expected: " & float'Image(fExpectedY) & ".");
      AUnit.Assertions.Assert(Condition => pxProductQuaternion.fZ = fExpectedZ,
                              Message   => "CQuaternion.*(binary) failed, wrong result in Z component. Value: " & float'Image(pxProductQuaternion.fZ) & ". Expected: " & float'Image(fExpectedZ) & ".");
      AUnit.Assertions.Assert(Condition => pxProductQuaternion.fW = fExpectedW,
                              Message   => "CQuaternion.*(binary) failed, wrong result in W component. Value: " & float'Image(pxProductQuaternion.fW) & ". Expected: " & float'Image(fExpectedW) & ".");



--  begin read only
   end Test_Multiply;
--  end read only


--  begin read only
   procedure Test_Equal (Gnattest_T : in out Test);
   procedure Test_Equal_079d85 (Gnattest_T : in out Test) renames Test_Equal;
--  id:2.1/079d85964c7551a7/Equal/1/0/
   procedure Test_Equal (Gnattest_T : in out Test) is
   --  math-quaternions.ads:16:4:"="
--  end read only

      pragma Unreferenced (Gnattest_T);
     pxLeftOperandQuaternion : pCQuaternion;
      pxRightOperandQuaternion : pCQuaternion;
   begin

      pxLeftOperandQuaternion := Math.Quaternions.pxCreate(fX => 2.3,
                                                           fY => -5.3,
                                                           fZ => 6.2,
                                                           fW => 6.0);
      pxRightOperandQuaternion := pxLeftOperandQuaternion.pxGet_Copy;

      AUnit.Assertions.Assert(Condition => pxLeftOperandQuaternion = pxRightOperandQuaternion,
                              Message   => "CQuaternion.=(binary) failed, left operand does not equal right operand.");

      pxRightOperandQuaternion.fX := pxRightOperandQuaternion.fX + 0.01;
      AUnit.Assertions.Assert(Condition => not (pxLeftOperandQuaternion = pxRightOperandQuaternion),
                              Message   => "CQuaternion.=(binary) failed, left operand equals right operand.");

--  begin read only
   end Test_Equal;
--  end read only


--  begin read only
   procedure Test_fGet_Dot_Product (Gnattest_T : in out Test);
   procedure Test_fGet_Dot_Product_be0506 (Gnattest_T : in out Test) renames Test_fGet_Dot_Product;
--  id:2.1/be0506155b2e61ac/fGet_Dot_Product/1/0/
   procedure Test_fGet_Dot_Product (Gnattest_T : in out Test) is
   --  math-quaternions.ads:17:4:fGet_Dot_Product
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxLeftOperandQuaternion : pCQuaternion;
      pxRightOperandQuaternion : pCQuaternion;
      fDotProduct : float;
   begin

      --(,,,) dot (12.0,,,)
      pxLeftOperandQuaternion := Math.Quaternions.pxCreate(fX => 4.3,
                                                           fY => 7.3,
                                                           fZ => -12.3,
                                                           fW => 63.0);
      pxRightOperandQuaternion := Math.Quaternions.pxCreate(fX => 12.0,
                                                            fY => 76.3,
                                                            fZ => 12.3,
                                                            fW => -15.0);
      fDotProduct := Math.Quaternions.fGet_Dot_Product(pxLeftOperandQuaternion  => pxLeftOperandQuaternion,
                                                       pxRightOperandQuaternion => pxRightOperandQuaternion);

      AUnit.Assertions.Assert(Condition => abs(fDotProduct - (-487.7)) < 0.001,
                              Message   => "CQuaternion.fGet_Dot_Product failed, wrong value. Value: " & float'Image(fDotProduct) & ". Expected: " & float'Image(-487.7) & ".");




--  begin read only
   end Test_fGet_Dot_Product;
--  end read only


--  begin read only
   procedure Test_pxGet_Spherical_Linear_Interpolation_Quaternion (Gnattest_T : in out Test);
   procedure Test_pxGet_Spherical_Linear_Interpolation_Quaternion_ccc0de (Gnattest_T : in out Test) renames Test_pxGet_Spherical_Linear_Interpolation_Quaternion;
--  id:2.1/ccc0deca44691779/pxGet_Spherical_Linear_Interpolation_Quaternion/1/0/
   procedure Test_pxGet_Spherical_Linear_Interpolation_Quaternion (Gnattest_T : in out Test) is
   --  math-quaternions.ads:19:4:pxGet_Spherical_Linear_Interpolation_Quaternion
--  end read only

      pragma Unreferenced (Gnattest_T);

      pxFromQuaternion : pCQuaternion;
      pxToQuaternion : pCQuaternion;
      pxInterpolatedQuaternion : pCQuaternion;
      pxLastInterpolatedQuaternion : pCQuaternion;
      pxAxisVector : Math.Vectors.pCVector;
      fCoefficient : float;
   begin

      pxAxisVector := Math.Vectors.pxCreate(fX => 1.0,
                                            fY => 0.0,
                                            fZ => 0.0);
      pxFromQuaternion := Math.Quaternions.pxCreate(pxAxisVector    => pxAxisVector,
                                                    fAngleInDegrees => 45.0);

      pxAxisVector := Math.Vectors.pxCreate(fX => 1.0,
                                            fY => 0.0,
                                            fZ => 0.0);
      pxToQuaternion := Math.Quaternions.pxCreate(pxAxisVector    => pxAxisVector,
                                                  fAngleInDegrees => -45.0);


      pxLastInterpolatedQuaternion := Math.Quaternions.pxGet_Spherical_Linear_Interpolation_Quaternion(pxFromQuaternion          => pxFromQuaternion,
                                                                                                   pxToQuaternion            => pxToQuaternion,
                                                                                                   fInterpolationCoefficient => 0.0);
      for t in 1 .. 100 loop
         fCoefficient := float(t) * 0.01;
         pxInterpolatedQuaternion := Math.Quaternions.pxGet_Spherical_Linear_Interpolation_Quaternion(pxFromQuaternion          => pxFromQuaternion,
                                                                                                      pxToQuaternion            => pxToQuaternion,
                                                                                                      fInterpolationCoefficient => 0.5);
       AUnit.Assertions.Assert(Condition => pxInterpolatedQuaternion.fGet_Axis_Vector = pxLastInterpolatedQuaternion.fGet_Axis_Vector,
                              Message   => "CQuaternion.pxGet_Spherical_Linear_Interpolation_Quaternion failed, wrong axis vector in for loop.");
       AUnit.Assertions.Assert(Condition => pxInterpolatedQuaternion.fGet_Angle < pxLastInterpolatedQuaternion.fGet_Angle,
                              Message   => "CQuaternion.pxGet_Spherical_Linear_Interpolation_Quaternion failed, wrong angle in foor loop. Coefficient: " & float'Image(fCoefficient));

      end loop;

      --  begin read only
   end Test_pxGet_Spherical_Linear_Interpolation_Quaternion;
--  end read only

end Math.Quaternions.Test_Data.Tests;