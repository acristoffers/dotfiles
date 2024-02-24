let
  intel-vaapi-driver = final: prev: {
    intel-vaapi-driver = prev.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
in
[ intel-vaapi-driver ]
