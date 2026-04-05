{
  config = {
    services.logind.settings = {
      # Use suspend-then-hibernate when the lid is closed
      Login.HandleLidSwitch = "suspend-then-hibernate";
    };

    # When using sleep-then-hibernate,
    # sleep for 2h before hibernating
    systemd.sleep.settings.Sleep.HibernateDelaySec = "2h";

    boot.kernelParams = [ "mem_sleep_default=deep" ];
  };
}
