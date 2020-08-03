{ buildPythonPackage, python, mysql-connector }:

buildPythonPackage rec {
  pname = "mysql-utilities";
  version = "1.6.5";
  src = ./mysql-utilities;

  # src = fetchurl {
  #   # url = "mirror://pypi/v/mysql-utilities/${pname}-${version}.tar.gz";
  #   # url = "https://files.pythonhosted.org/packages/b3/79/137e4dbd1f3d900bc4327dc344dacc19fa65873543867e8a9f63203630b4/mysql-utilities-1.4.3.tar.gz";
  #   url = "https://github.com/mysql/mysql-utilities/archive/release-1.6.5.tar.gz";
  #   sha256 = "0fxwizp1zfda239yshvm1xks92zddnd2qs3c539gw17jciq9idj0";
  # };

  propagatedNativeBuildInputs = [
    mysql-connector
  ];

  # error: invalid command 'test'
  doCheck = false;

  meta = {
    description = "Tool to record VNC sessions to Flash Video";
    homepage = "http://www.unixuser.org/~euske/python/vnc2flv/";
    # license = stdenv.lib.licenses.mit;
  };
}
