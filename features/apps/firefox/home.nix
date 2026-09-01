_: {
  programs.firefox = {
    enable = true;

    profiles.default.settings = {
      "dom.storage.enabled" = true;
      "network.cookie.cookieBehavior" = 0;
      "network.cookie.lifetimePolicy" = 0;
      "browser.privatebrowsing.autostart" = false;
    };
  };
}
