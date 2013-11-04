with Simulator.Motion_Control_Wrapper;
with Simulator.submarine;
with Math.Vectors;
with math.Matrices;
with math.Planes;
with Simulator.Pid_Errors;

package Simulator.Model is

   type pTProcedure is access procedure;

   type CModel is tagged private;
   type pCModel is access CModel;

   type TPIDComponentScalings is new simulator.Motion_Control_Wrapper.TPIDComponentScalings;
   type EMotionComponent is new simulator.Motion_Control_Wrapper.EMotionComponent;
   function pxCreate(pOwnerUpdateProcedure : pTProcedure) return pcModel;

   procedure Update_Model(this : in out CModel; fDeltaTime : float);

   function xGet_Current_Submarine_Positional_Vector(this : in CModel) return Math.Vectors.CVector;
   function xGet_Current_Submarine_Orientation_Matrix(this : in CModel) return math.Matrices.CMatrix;
   function xGet_Wanted_Submarine_Positional_Vector(this : in CModel) return Math.Vectors.CVector;
   function xGet_Wanted_Submarine_Orientation_Matrix(this : in CModel) return Math.Matrices.CMatrix;
   function xGet_Current_Submarine_Velocity_Vector(this : in CModel) return Math.Vectors.CVector;

   procedure Set_Pid_Scaling(this : CModel ; xComponentScaling:TPIDComponentScalings;eComponentToScale : EMotionComponent);
   procedure Restart(this : in out CModel);

private
   --procedure On_Update;
   type CModel is tagged
      record
         pOwnerUpdateProcedure : pTProcedure;
         pxSubmarine : Simulator.submarine.pCSubmarine;
         pxMotionControlWrapper : Simulator.Motion_Control_Wrapper.pCWrapDispatcher;
      end record;
end Simulator.Model;
