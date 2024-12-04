{
  stdenv,
  lib,
  buildPythonPackage,
  cargo,
  fetchPypi,
  pytestCheckHook,
  pythonOlder,
  rustc,
  rustPlatform,
  libiconv,
}:

buildPythonPackage rec {
  pname = "rpds-py";
  version = "0.21.0";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    pname = "rpds_py";
    inherit version;
    hash = "sha256-7WN4ydZtDekDdj53Bjg9YMM4KVgfCt/0e2U18YAvpts=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-VOmMNEdKHrPKJzs+D735Y52y47MubPwLlfkvB7Glh14=";
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    cargo
    rustc
  ];

  buildInputs = lib.optionals stdenv.hostPlatform.isDarwin [ libiconv ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "rpds" ];

  meta = with lib; {
    description = "Python bindings to Rust's persistent data structures (rpds";
    homepage = "https://pypi.org/project/rpds-py/";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
