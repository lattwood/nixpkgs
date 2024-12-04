{
  lib,
  aiohttp,
  aioresponses,
  authlib,
  bleak,
  buildPythonPackage,
  fetchFromGitHub,
  httpx,
  pytest-asyncio,
  pytestCheckHook,
  pythonOlder,
  setuptools,
  syrupy,
  websockets,
}:

buildPythonPackage rec {
  pname = "pylamarzocco";
  version = "1.3.2";
  pyproject = true;

  disabled = pythonOlder "3.11";

  src = fetchFromGitHub {
    owner = "zweckj";
    repo = "pylamarzocco";
    rev = "refs/tags/v${version}";
    hash = "sha256-ngTVm1tfs42pXGIQh8Hy8d7UY3D/skCZkbKr6AACYH0=";
  };

  build-system = [ setuptools ];

  dependencies = [
    aiohttp
    authlib
    bleak
    httpx
    websockets
  ];

  nativeCheckInputs = [
    aioresponses
    pytest-asyncio
    pytestCheckHook
    syrupy
  ];

  postInstall = ''
    find $out
  '';

  pythonImportsCheck = [ "pylamarzocco" ];

  meta = with lib; {
    description = "Library to interface with La Marzocco's cloud";
    homepage = "https://github.com/zweckj/pylamarzocco";
    changelog = "https://github.com/zweckj/pylamarzocco/releases/tag/v.${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
