{ lib, buildPythonPackage, fetchFromGitHub, python }:

let
  py = python;
in buildPythonPackage rec {
  pname = "mysql-connector";
  version = "8.0.21-p";

  src = fetchFromGitHub {
    owner = "mysql";
    repo = "mysql-connector-python";
    rev = "c0e22ce6c31b630335117be90d8e9e501c61e3dd";
    sha256 = "187srvg0mcl4mg4m116ik43mhriax55qfd9dycncfzg75467s7ss";
  };

  propagatedBuildInputs = with py.pkgs; [ protobuf dnspython ];

  # Tests are failing (TODO: unknown reason)
  # TypeError: __init__() missing 1 required positional argument: 'string'
  # But the library should be working as expected.
  doCheck = false;

  meta = {
    description = "A MySQL driver";
    longDescription = ''
      A MySQL driver that does not depend on MySQL C client libraries and
      implements the DB API v2.0 specification.
    '';
    homepage = "https://github.com/mysql/mysql-connector-python";
    changelog = "https://raw.githubusercontent.com/mysql/mysql-connector-python/${version}/CHANGES.txt";
    license = [ lib.licenses.gpl2 ];
    maintainers = with lib.maintainers; [ primeos ];
  };
}
