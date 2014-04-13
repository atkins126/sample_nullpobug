unit Nullpobug.Example.Spring4d.ServiceLocator;

interface

uses
  Spring.Container
  ;

function ServiceLocator: TContainer;

implementation

var
  FContainer: TContainer;

function ServiceLocator: TContainer;
begin
  if FContainer = nil then
  begin
    FContainer := TContainer.Create;
  end;
  Result := FContainer;
end;

initialization

finalization
  FContainer.Free;

end.
