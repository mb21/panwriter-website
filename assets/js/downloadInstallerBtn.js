(function() {
  // from https://stackoverflow.com/a/38241481/214446
  var userAgent = window.navigator.userAgent
    , platform = window.navigator.platform
    , macosPlatforms = ['Macintosh', 'MacIntel']
    , windowsPlatforms = ['Win32', 'Win64', 'Windows', 'WinCE']
    , iosPlatforms = ['iPhone', 'iPad', 'iPod']
    , target = null
    , detected
    ;
  if (macosPlatforms.indexOf(platform) !== -1) {
    detected = 'macOS';
    target = '-mac.zip';
  } else if (iosPlatforms.indexOf(platform) !== -1) {
  } else if (windowsPlatforms.indexOf(platform) !== -1) {
    detected = 'Windows';
    target = '.exe';
  } else if (/Android/.test(userAgent)) {
  } else if (!os && /Linux/.test(platform)) {
    detected = 'Linux';
    target = '-x86_64.AppImage';
  }

  if (target) {
    fetch("https://api.github.com/repos/mb21/panwriter/releases")
    .then(function(data) {
        return data.json();
    })
    .then(function(json) {
      var assets = json[0].assets.filter(function(a){
        return a.name.endsWith(target)
      });
      if (assets[0]) {
        var btn = document.getElementById('downloadInstallerBtn');
        btn.setAttribute('href', assets[0].browser_download_url);
        btn.innerHTML += ' for ' + detected;
      }
    });
  }
})();
