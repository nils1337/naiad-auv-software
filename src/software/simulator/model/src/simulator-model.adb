package body Simulator.Model is

   --------------
   -- pxCreate --
   --------------

   function pxCreate(pOwnerUpdateProcedure : pTProcedure) return pcModel is
      pxModel : Simulator.Model.pCModel;

   begin
      pxModel := new Simulator.Model.CModel;

      pxModel.pxSubmarine := Simulator.submarine.pxCreate_Naiad;
      pxModel.pxMotionControlWrapper := Simulator.Motion_Control_Wrapper.pxCreate_Wrap_Dispatcher;
      pxModel.pOwnerUpdateProcedure := pOwnerUpdateProcedure;

      return pxModel;
   end pxCreate;

   -----------------
   -- UpdateModel --
   -----------------

   procedure Update_Model (this : in out CModel; fDeltaTime : float) is
      tfMotorValuesSubmarine : simulator.submarine.TMotorForce;
   begin
      this.pxMotionControlWrapper.Update_Values(pxNewCurrentAbsolutePosition => this.pxSubmarine.pxGet_Position_Vector,
                                                pxNewCurrentOrientation      => this.pxSubmarine.pxGet_Orientation_Matrix,
                                                tfMotorValuesSubmarine       => tfMotorValuesSubmarine,
                                                fDeltaTime                   => fDeltaTime);

      this.pxSubmarine.Time_Step_Motor_Force_To_Integrate(txMotorForce => tfMotorValuesSubmarine,
                                                          fDeltaTime   => fDeltaTime);
   end Update_Model;

   -------------------------------------------
   -- pxGetCurrentSubmarinePositionalVector --
   -------------------------------------------

   function xGet_Current_Submarine_Positional_Vector(this : in CModel) return Math.Vectors.CVector is
   begin
      return this.pxSubmarine.pxGet_Position_Vector.all;
   end xGet_Current_Submarine_Positional_Vector;

   function xGet_Wanted_Submarine_Positional_Vector(this : in CModel) return Math.Vectors.CVector is

   begin
      return this.pxMotionControlWrapper.pxGet_Wanted_Position.all;
   end xGet_Wanted_Submarine_Positional_Vector;

   function xGet_Wanted_Submarine_Orientation_Matrix(this : in CModel) return Math.Matrices.CMatrix is

   begin
      return this.pxMotionControlWrapper.pxGet_Wanted_Orientation.all;
   end xGet_Wanted_Submarine_Orientation_Matrix;


   function xGet_Current_Submarine_Orientation_Matrix(this : in CModel) return math.Matrices.CMatrix is

   begin
      return this.pxSubmarine.pxGet_Orientation_Matrix.all;

   end xGet_Current_Submarine_Orientation_Matrix;

   function xGet_Current_Submarine_Velocity_Vector(this : in CModel) return Math.Vectors.CVector is
   begin
      return this.pxSubmarine.pxGet_Velocity_Vector.all;
   end xGet_Current_Submarine_Velocity_Vector;

   procedure Set_Pid_Scaling(this : CModel ; xComponentScaling:TPIDComponentScalings;eComponentToScale : EMotionComponent) is

   begin
      this.pxMotionControlWrapper.Update_Pid_Scaling(xComponentScaling => simulator.Motion_Control_Wrapper.TPIDComponentScalings(xComponentScaling),
                                                     eComponentToScale => simulator.Motion_Control_Wrapper.EMotionComponent(eComponentToScale));
   end Set_Pid_Scaling;

   procedure Restart(this : in out CModel) is

   begin
      this.pxMotionControlWrapper.Restart;
      simulator.submarine.Free(this.pxSubmarine);
      this.pxSubmarine := simulator.submarine.pxCreate_Naiad;
   end;








end Simulator.Model;
