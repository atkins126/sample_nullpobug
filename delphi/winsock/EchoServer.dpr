program EchoServer;

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils, Winsock;

const
  PORT = 5000;
  IP = '0.0.0.0';

var
  wsdata: WSAData;
  sockServer, sockClient: TSocket;
  addrServer, addrClient: TSockAddr;
  sReceivedData: AnsiString;
  buf, sendbuf: Array[0..255] of AnsiChar;
  intReceivedSize: Integer;
  AddrLength: Integer;
begin
  if WSAStartup($101, wsdata)<>0 then
  begin
    WriteLn('Winsock Error.');
    Exit;
  end;
  WriteLn('Listen: ', IP, ':', PORT);
  sockServer := socket(AF_INET, SOCK_STREAM, 0);
  if sockServer = INVALID_SOCKET then
    WriteLn('Invalid socket.');
  addrServer.sin_family := AF_INET;
  addrServer.sin_port := htons(PORT);
  addrServer.sin_addr.S_addr := inet_addr(IP);
  bind(sockServer, addrServer, SizeOf(addrServer));
  while True do
  begin
    // �Ҏ�J�n
    listen(sockServer, 1);
    AddrLength := SizeOf(addrClient);
    sockClient := accept(sockServer, @addrClient, @AddrLength);
    sReceivedData := '';
    while True do
    begin
      ZeroMemory(@buf, SizeOf(buf));
      intReceivedSize := recv(sockClient, buf, SizeOf(buf), 0);
      if intReceivedSize = SOCKET_ERROR then
      begin
        WriteLn('SocketError.');
        Break;
      end;
      // �N���C�A���g���ł̐ؒf
      if intReceivedSize = 0 then
      begin
        WriteLn('Connection closed.');
        Break;
      end;
      // �󂯎�����f�[�^�𒙂߂Ă���
      sReceivedData := sReceivedData + buf;
      // ���s�R�[�h�������Ă�����A���߂Ă��f�[�^��Ԃ�
      if Pos(#13, string(sReceivedData)) <> 0 then
      begin
        Write(sReceivedData);
        ZeroMemory(@sendbuf, SizeOf(sendbuf));
        StrCopy(@sendbuf, PAnsiChar(sReceivedData));
        send(sockClient, sendbuf, Length(sendbuf), 0);
        sReceivedData := '';
      end;
    end;
  end;
  WSACleanup;
end.
