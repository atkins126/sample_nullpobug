program asmhello;

{$APPTYPE CONSOLE}

(*
  register(fastcall)�Ăяo���K��̏ꍇ�A
  ������ EAX, EDX, ECX ���W�X�^�Ɋi�[�����
  �֐��̖߂�l�� EAX ���W�X�^�Ɋi�[����B
*)
function Add(X, Y: Integer): Integer; register;
asm
  add EAX, EDX
end;

begin
  WriteLn(Add(3, 7));
end.
