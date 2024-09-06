'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "57f47a6146115ae9d04df034378c9616",
"version.json": "ef6541e3578e22c547cf1c9b4432d8c3",
"index.html": "1e39cb87770fda878d3da315a158168d",
"/": "1e39cb87770fda878d3da315a158168d",
"main.dart.js": "b5ab7dff440231323698fe24ba8287e1",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "c4d5927936a574586d1339a7f658303f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "e8c2ff05ba8ba3c529c5057cd95f352f",
"assets/AssetManifest.json": "256de3b43ec3af1084f733ee6850ce11",
"assets/NOTICES": "02912305a6f03603453647c944fde799",
"assets/FontManifest.json": "fd1a5774385e9f6054852275bd481cb2",
"assets/AssetManifest.bin.json": "eed043fd8d7a9c5bbd4ecea645cc14cd",
"assets/packages/syncfusion_flutter_pdfviewer/assets/squiggly.png": "c9602bfd4aa99590ca66ce212099885f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/strikethrough.png": "cb39da11cd936bd01d1c5a911e429799",
"assets/packages/syncfusion_flutter_pdfviewer/assets/highlight.png": "7384946432b51b56b0990dca1a735169",
"assets/packages/syncfusion_flutter_pdfviewer/assets/underline.png": "c94a4441e753e4744e2857f0c4359bf0",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "80d5f6879eb50b7f07f822142576a041",
"assets/fonts/MaterialIcons-Regular.otf": "86664613174ba4102b0debf2f4f1bf9d",
"assets/assets/james_eclipse.jpg": "ed1bcc629e35197dc33d62f76502fdbc",
"assets/assets/gap_of_dunloe.jpeg": "5513986d8785289d76de49fcf079d00f",
"assets/assets/lit.gif": "371df75c117e07c20c04c7d2a830976b",
"assets/assets/james_skye_scotland.jpeg": "2ba946af7f02d2446192b943a4d3c913",
"assets/assets/moon/60.png": "3e0760924dcfde37a20c9c1fb1504385",
"assets/assets/moon/48.png": "b4300e568bcf5248bce29f33061ac99f",
"assets/assets/moon/49.png": "d608fcf9b56522549a525757ef8c41ad",
"assets/assets/moon/59.png": "677a4dc8dd9ab39fce13d25dced5749e",
"assets/assets/moon/58.png": "7e8cc12ff67fcb8d0807b0b08066e204",
"assets/assets/moon/8.png": "25dd2ed8c7d217135251f56165d8a9e0",
"assets/assets/moon/9.png": "4aed38b3363ccaf8194c15f784cdc61a",
"assets/assets/moon/14.png": "ec71a35cea7eedda2532e5d45faac40c",
"assets/assets/moon/28.png": "d01bd88f6eb63d2b83a3f48fedc93985",
"assets/assets/moon/29.png": "fbfd6ff87af3fd3e94e0c7846ef53840",
"assets/assets/moon/15.png": "513e73627ee8677ac69c5853fc4ea54c",
"assets/assets/moon/17.png": "e90945073dbed961033dfc2fee595f4b",
"assets/assets/moon/16.png": "7940871d31ec6726a717f00024ad66ca",
"assets/assets/moon/12.png": "fa077bedc32d658d1005d3259f85d9d3",
"assets/assets/moon/13.png": "f7fa438b60c6fa1a6b47eeaaea995032",
"assets/assets/moon/39.png": "cf040321be65c1956c2ac5efeb799eb6",
"assets/assets/moon/11.png": "0abac21844cdf4987cb17304072b0bc8",
"assets/assets/moon/10.png": "ec9bdc4f6894d1e76a87cc3d48d33569",
"assets/assets/moon/38.png": "a890be519bcd676a0c15bca5f645be60",
"assets/assets/moon/35.png": "df2c15e2d1b6b8510ff64ae81ef3d755",
"assets/assets/moon/21.png": "640919ff56bbdeab43b1a3fc391a6303",
"assets/assets/moon/20.png": "74fa713815ec1432c7849445f977bfbb",
"assets/assets/moon/34.png": "027a04bd3178ae28d7f2ef7a5434b15c",
"assets/assets/moon/22.png": "3949eeceb2f58efc00a0125d1e84044f",
"assets/assets/moon/36.png": "486b73e884c01642643d71fd6b3455cd",
"assets/assets/moon/37.png": "ca154aa05137513c83711f893b111c8f",
"assets/assets/moon/23.png": "ef78312dd7071e5fe4093aa6d1975e20",
"assets/assets/moon/27.png": "a4e35a5b28940688b147ff899f882ff1",
"assets/assets/moon/33.png": "76de1ca24cdc6d04161383a948f2e6d6",
"assets/assets/moon/32.png": "256b9047eadcf556e3e0b7503199540b",
"assets/assets/moon/26.png": "859aedfa81919632c979abdd32ce66b7",
"assets/assets/moon/18.png": "f5f4aacf25f62ca98d55f57bfae14bc2",
"assets/assets/moon/30.png": "89e087c2411c42b3b98963722095cb39",
"assets/assets/moon/24.png": "f23aef35b3159b2e3ecea4a597a1780d",
"assets/assets/moon/25.png": "72c3e5348a8d0b08a9db106fcc4d8e4c",
"assets/assets/moon/31.png": "7db9a6f44bb3f9664206d0aa193f0c01",
"assets/assets/moon/19.png": "9231b0df7194b6b5e3e8db8e268dd3e5",
"assets/assets/moon/4.png": "2434dc43f1df90d089b1f954b456eb0a",
"assets/assets/moon/56.png": "a660a83d53b29c0861b759561536efba",
"assets/assets/moon/42.png": "65fde4740aba17b28104606ccd96870a",
"assets/assets/moon/43.png": "7bade143d3804dec3669880ab7c662d9",
"assets/assets/moon/5.png": "785ec223df0556db5b9c76c41303cfc1",
"assets/assets/moon/57.png": "f59097fee996210fcb136b77c400502b",
"assets/assets/moon/41.png": "5bc5692b5c70d606cae0b9b5ff9881a0",
"assets/assets/moon/55.png": "f96d7424afb7712936d0937ef8b16cec",
"assets/assets/moon/7.png": "b3ece62dac2c2406bab092f91cb948b1",
"assets/assets/moon/54.png": "3379b4707a8d479826ef592eb331ca12",
"assets/assets/moon/6.png": "ed9501723673c3fbf816be3daac0e6b1",
"assets/assets/moon/40.png": "4157f9d470a4727dc7749224cdc526c5",
"assets/assets/moon/44.png": "db68f6edfa4b6d94d81d024d55b70ed7",
"assets/assets/moon/2.png": "f856fd80b8d587a241d637fd06f4dfe8",
"assets/assets/moon/50.png": "5d7644c33d8cab8eee6a803a50695e78",
"assets/assets/moon/3.png": "62e646aa4dbd784a474199d9910c5533",
"assets/assets/moon/51.png": "a01b51541c57f9b6a47b7e7e5ef77209",
"assets/assets/moon/45.png": "9172fa8118e6029f5df9474e61e44465",
"assets/assets/moon/53.png": "a34d147676ab2ae200a3b99090354797",
"assets/assets/moon/1.png": "055b13d845ee58fc4e66e6efab539819",
"assets/assets/moon/47.png": "66693153dd27fa3e440163c6bf4f56ff",
"assets/assets/moon/46.png": "b138af77dbf8b0f076186e462d976c98",
"assets/assets/moon/52.png": "eb48246ebbfddf5d848bf9a018cecde2",
"assets/assets/eva_cesar_ikari.png": "3568b3d15236a0903a04c5d2cbed71ed",
"assets/assets/icons/github.png": "ce062b599c8445758cb617c4bb72b7b7",
"assets/assets/icons/github-mark.svg": "8dcc6b5262f3b6138b1566b357ba89a9",
"assets/assets/icons/linkedin.svg": "5b238434e2862c877f08572b96c0ef7b",
"assets/assets/gauntlet_cursor.png": "b9d5df759ed96009ed4d9456d7cc24ad",
"assets/assets/mark_ferrari_nature.gif": "53b489769aa4f0a7cbe6bf71fae98525",
"assets/assets/coop_term_reports/fall_2020_report.txt": "41d69df0b3e31267686b2615ba0c6f7c",
"assets/assets/coop_term_reports/summer_2021_report.txt": "6dd28b5fa2cbb879c7dc095345c5ea56",
"assets/assets/coop_term_reports/winter_summer_2022_report.txt": "fc09597584e2278873553e14acdba7bf",
"assets/assets/fonts/Inconsolata-VariableFont_wdth,wght.ttf": "aef1948adbc4c036b1517a44a2a5998e",
"assets/assets/field_juleko_o.gif": "34ff086cb26b48f258b3c4501fe7f876",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
