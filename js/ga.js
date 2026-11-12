// Google Analytics 4 - EMPCaring
// Single source of truth: edit the ID here, it applies site-wide.
//
// Consent: the banner in js/main.js stores the visitor's choice in
// localStorage['cookie-consent'] ("accepted" or "declined"). A stored
// "declined" is applied before gtag('config'), so that visitor gets no
// analytics or ads cookies from that point on.
(function () {
  var ID = 'G-WCJEF00XZ0';
  var choice = null;
  try { choice = localStorage.getItem('cookie-consent'); } catch (e) { /* storage blocked */ }

  var granted = {
    ad_storage: 'granted',
    ad_user_data: 'granted',
    ad_personalization: 'granted',
    analytics_storage: 'granted'
  };
  var denied = {
    ad_storage: 'denied',
    ad_user_data: 'denied',
    ad_personalization: 'denied',
    analytics_storage: 'denied'
  };

  window.dataLayer = window.dataLayer || [];
  window.gtag = function () { window.dataLayer.push(arguments); };

  // Consent Mode v2 defaults must be in place before the first hit.
  window.gtag('consent', 'default', choice === 'declined' ? denied : granted);
  window.gtag('js', new Date());
  window.gtag('config', ID);

  // Shared API for the banner (and for a later change of mind).
  window.empcaringConsent = {
    choice: function () { return choice; },
    grant: function () {
      choice = 'accepted';
      try { localStorage.setItem('cookie-consent', 'accepted'); } catch (e) {}
      window.gtag('consent', 'update', granted);
    },
    deny: function () {
      choice = 'declined';
      try { localStorage.setItem('cookie-consent', 'declined'); } catch (e) {}
      window.gtag('consent', 'update', denied);
      // Remove the GA cookies already written on this device.
      var host = location.hostname;
      var bare = host.replace(/^www\./, '');
      document.cookie.split(';').forEach(function (pair) {
        var name = pair.split('=')[0].trim();
        if (name.indexOf('_ga') !== 0 && name.indexOf('_gid') !== 0) { return; }
        document.cookie = name + '=; Max-Age=0; path=/; domain=' + host;
        document.cookie = name + '=; Max-Age=0; path=/; domain=.' + bare;
      });
    }
  };

  // Load the gtag.js library asynchronously.
  var s = document.createElement('script');
  s.async = true;
  s.src = 'https://www.googletagmanager.com/gtag/js?id=' + ID;
  document.head.appendChild(s);
})();
