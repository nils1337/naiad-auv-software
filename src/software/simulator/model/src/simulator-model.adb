package body Simulator.Model is

   --------------
   -- pxCreate --
   --------------

   function pxCreate(iMotorUpdateFrequency : Integer) return pcModel is
      pxModel : Simulator.Model.pCModel;

   begin
      pxModel := new Simulator.Model.CModel;
      pxModel.eOperationMode := OfflineMode;
      pxModel.fTimeBetweenMotorUpdates:=1.0/float(iMotorUpdateFrequency);
      pxModel.pxSubmarine := Simulator.submarine.pxCreate_Naiad;
      pxModel.pxMotionControlWrapper := Simulator.Motion_Control_Wrapper.pxCreate_Wrap_Dispatcher;

      return pxModel;
   end pxCreate;

   -----------------
   -- UpdateModel --
   -----------------

   procedure Update_Model (this : in out CModel; fDeltaTime : float) is
   begin
      case this.eOperationMode is
         when OfflineMode =>
            Update_Offline_Mode(this,fDeltaTime);
         when EthernetSimulationMode =>
            Update_Ethernet_Simulation_Mode(this,fDeltaTime);
         when ObserveMode =>
            Update_Observe_Mode(this,fDeltaTime);
      end case;



   end Update_Model;

   -------------------------------------------
   -- pxGetCurrentSubmarinePositionalVector --
   -------------------------------------------

   function xGet_Current_Submarine_Positional_Vector(this : in CModel) return Math.Vectors.CVector is
   begin
      return this.pxSubmarine.xGet_Position_Vector;
   end xGet_Current_Submarine_Positional_Vector;

   ---------------------------------------------
   -- xGet_Wanted_Submarine_Positional_Vector --
   ---------------------------------------------

   function xGet_Wanted_Submarine_Positional_Vector(this : in CModel) return Math.Vectors.CVector is

   begin
      return this.pxSubmarine.xGet_Wanted_Position;
   end xGet_Wanted_Submarine_Positional_Vector;

   ----------------------------------------------
   -- xGet_Wanted_Submarine_Orientation_Matrix --
   ----------------------------------------------

   function xGet_Wanted_Submarine_Orientation_Matrix(this : in CModel) return Math.Matrices.CMatrix is
   begin
      return this.pxSubmarine.xGet_Wanted_Orientation;
   end xGet_Wanted_Submarine_Orientation_Matrix;

   -----------------------------------------------
   -- xGet_Current_Submarine_Orientation_Matrix --
   -----------------------------------------------

   function xGet_Current_Submarine_Orientation_Matrix(this : in CModel) return math.Matrices.CMatrix is

   begin
      return this.pxSubmarine.xGet_Orientation_Matrix;
   end xGet_Current_Submarine_Orientation_Matrix;

   --------------------------------------------
   -- xGet_Current_Submarine_Velocity_Vector --
   --------------------------------------------

   function xGet_Current_Submarine_Velocity_Vector(this : in CModel) return Math.Vectors.CVector is
   begin
      return this.pxSubmarine.xGet_Velocity_Vector;
   end xGet_Current_Submarine_Velocity_Vector;

   ----------------------
   -- fGet_Motor_Force --
   ----------------------

   function fGet_Motor_Force(this : in CModel; iIndexMotor  : iMotorIndex) return float is
   begin
      return this.pxSubmarine.xGet_Motor_Values(iIndexMotor);
   end fGet_Motor_Force;

   ---------------------
   -- Set_Pid_Scaling --
   ---------------------

   procedure Set_Pid_Scaling(this : CModel ; xComponentScaling:TPIDComponentScalings;eComponentToScale : EMotionComponent) is

   begin
      this.pxMotionControlWrapper.Update_Pid_Scaling(xComponentScaling => simulator.Motion_Control_Wrapper.TPIDComponentScalings(xComponentScaling),
                                                     eComponentToScale => simulator.Motion_Control_Wrapper.EMotionComponent(eComponentToScale));
   end Set_Pid_Scaling;

   -------------
   -- Restart --
   -------------

   procedure Restart(this : in out CModel) is
      pxNewSubmarine : simulator.submarine.pCSubmarine;
   begin
      this.pxMotionControlWrapper.Restart;
      pxNewSubmarine := simulator.submarine.pxCreate_Naiad;
      simulator.submarine.Free(this.pxSubmarine);
      this.pxSubmarine := pxNewSubmarine;
   end;

   -----------------------------------------
   -- Set_Wanted_Position_And_Orientation --
   -----------------------------------------

   procedure Set_Wanted_Position_And_Orientation(this : in CModel; xWantedPosition : math.Vectors.CVector; xWantedOrientation : math.Matrices.CMatrix) is
   begin
      this.pxSubmarine.Set_Wanted_Position(xWantedPosition => xWantedPosition);
      this.pxSubmarine.Set_Wanted_Orientation(xWantedOrientation => xWantedOrientation);
      this.pxMotionControlWrapper.Update_Wanted_Position(xWantedPosition    => xWantedPosition,
                                                         xWantedOrientation => xWantedOrientation);
   end Set_Wanted_Position_And_Orientation;

   -------------------------
   -- eGet_Operation_Mode --
   -------------------------

   function eGet_Operation_Mode(this : in CModel) return EOperatingMode is

   begin
      return this.eOperationMode;
   end eGet_Operation_Mode;

   ------------------------
   -- Set_Operation_Mode --
   ------------------------

   procedure Set_Operation_Mode(this : in out CModel; eOperationMode : EOperatingMode) is
   begin
      this.eOperationMode := eOperationMode;
   end Set_Operation_Mode;

   -------------------------
   -- Update_Offline_Mode --
   -------------------------

   procedure Update_Offline_Mode(this : in out CModel; fDeltaTime : float) is
      fMaximumMotorForce : float := 66.776;
      fMotorForceChangePerSecond : float := fMaximumMotorForce/0.0001;--1.5;
      tfMotorValuesSubmarine : simulator.Model.TMotorForce;
      tfChangeInMotorValues : simulator.Model.TMotorForce;
   begin
      if this.fTimeSinceLastMotorUpdate>this.fTimeBetweenMotorUpdates then
         this.pxSubmarine.set_Wanted_Position(this.pxSubmarine.xGet_Wanted_Position);
         this.pxSubmarine.set_Wanted_Orientation(this.pxSubmarine.xGet_Wanted_Orientation);
         this.fTimeSinceLastMotorUpdate := this.fTimeSinceLastMotorUpdate - this.fTimeBetweenMotorUpdates;
         this.pxMotionControlWrapper.Update_Values(xNewCurrentAbsolutePosition => this.pxSubmarine.xGet_Position_Vector,
                                                   xNewCurrentOrientation      => this.pxSubmarine.xGet_Orientation_Matrix,
                                                   tfMotorValuesSubmarine      => simulator.submarine.TMotorForce(this.tWantedMotorForces), --out
                                                   fDeltaTime                  => this.fTimeBetweenMotorUpdates);

      end if;
      this.fTimeSinceLastMotorUpdate := this.fTimeSinceLastMotorUpdate+fDeltaTime;

      tfMotorValuesSubmarine := simulator.Model.TMotorForce(this.pxSubmarine.xGet_Motor_Values);
      for iMotorIndex in tfMotorValuesSubmarine'Range loop
         tfChangeInMotorValues(iMotorIndex) := this.tWantedMotorForces(iMotorIndex)-tfMotorValuesSubmarine(iMotorIndex);
         if tfChangeInMotorValues(iMotorIndex)>fMotorForceChangePerSecond*fDeltaTime then
            tfChangeInMotorValues(iMotorIndex) := fMotorForceChangePerSecond*fDeltaTime;
         end if;
         if tfChangeInMotorValues(iMotorIndex)<-fMotorForceChangePerSecond*fDeltaTime then
            tfChangeInMotorValues(iMotorIndex) := -fMotorForceChangePerSecond*fDeltaTime;
         end if;
         tfMotorValuesSubmarine(iMotorIndex) := tfMotorValuesSubmarine(iMotorIndex) + tfChangeInMotorValues(iMotorIndex);
      end loop;

      --tfMotorValuesSubmarine := (-3.0,0.0,3.0,0.0,0.0,0.0);
      --tfMotorValuesSubmarine := (0.0,-3.0,3.0,0.0,0.0,0.0);

      this.pxSubmarine.Time_Step_Motor_Force_To_Integrate(txMotorForce => Simulator.submarine.TMotorForce(tfMotorValuesSubmarine),
                                                          fDeltaTime   => fDeltaTime);
   end Update_Offline_Mode;


   procedure Update_Ethernet_Simulation_Mode(this : in out CModel; fDeltaTime : float) is

   begin

      null;
   end Update_Ethernet_Simulation_Mode;

   procedure Update_Observe_Mode(this : in out CModel; fDeltaTime : float) is

   begin

      null;
   end Update_Observe_Mode;

end Simulator.Model;
