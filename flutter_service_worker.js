'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "d8b62c8bce894cfa441dd6bb7bf7fe69",
"version.json": "f3f6abc06d04b3d0bb66ec57033f6ff5",
"index.html": "b0a1f4727d538bfdbee7ae5456fa10bb",
"/": "b0a1f4727d538bfdbee7ae5456fa10bb",
"main.dart.js": "ac40a10993e1844aca84722729ee26b0",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "15009ad2092b0505a6bae1723b729b7e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "c406e09dd8773c48712454c55e2fc9f4",
"assets/AssetManifest.json": "4309081693853d0cb0c9fd78aad18826",
"assets/loading.gif": "f9dbd634bcccb46eebf47671d4dcff07",
"assets/NOTICES": "dffadba52120bbc994bab7a707fcd37e",
"assets/FontManifest.json": "ea9dc826036577df024fd0fe176dd298",
"assets/AssetManifest.bin.json": "63185d2dd3fb7bb8f3e4495bc1c7907b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/squiggly.png": "9894ce549037670d25d2c786036b810b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/strikethrough.png": "26f6729eee851adb4b598e3470e73983",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/highlight.png": "2fbda47037f7c99871891ca5e57e030b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/underline.png": "a98ff6a28215341f764f96d627a5d0f5",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/squiggly.png": "68960bf4e16479abb83841e54e1ae6f4",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/strikethrough.png": "72e2d23b4cdd8a9e5e9cadadf0f05a3f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/highlight.png": "2aecc31aaa39ad43c978f209962a985c",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/underline.png": "59886133294dd6587b0beeac054b2ca3",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "16b3f91669604dc27756a60a3122326c",
"assets/fonts/MaterialIcons-Regular.otf": "b27ab1ae1fee8d112ee1a281233f750b",
"assets/assets/sponsorPackage/Sponsors.pdf": "2c14cc32e8fb9a7990e970edaab82364",
"assets/assets/logo/GDSC.png": "15009ad2092b0505a6bae1723b729b7e",
"assets/assets/logo/loading.gif": "f9dbd634bcccb46eebf47671d4dcff07",
"assets/assets/logo/TigerLink.png": "002b81e443dd4ceab343b0c5f3b480cb",
"assets/assets/logo/Discord.png": "8762fd5a9967fc5fb3e5f860aaec7fb1",
"assets/assets/logo/LinkedIn.png": "f121d37b111a6c2724e17001c0126bf4",
"assets/assets/logo/Google.png": "18769699ba2356c4957dff304a3bbb99",
"assets/assets/members/Lillian.png": "b71ce7e2724cc3a9641be24e4a5d9052",
"assets/assets/members/Trenton.jpg": "a854ee550695f281927db7dacc8ecb49",
"assets/assets/members/Dina.jpg": "9c4e7862290650f0251638152c1c6b60",
"assets/assets/members/Jerrick.jpg": "f47fed41095948bd0ccbeeaf4b3002ae",
"assets/assets/icon/officers.png": "b1fbc631276527b9eefbadbd059ddde9",
"assets/assets/icon/Experience.png": "c9d5002e19fb1ac13e1ab44b07b4c95c",
"assets/assets/icon/Community.png": "22956d4c8fc5e20a44553fba38c95ae9",
"assets/assets/icon/members.png": "0e8b25c3d833d5ea65add5c714feb678",
"assets/assets/icon/Workshop.png": "5adbc3f725bc531f7c6f99938a209c0b",
"assets/assets/icon/Community.gif": "afae076ae9225cc92b46a2e3e2621c96",
"assets/assets/icon/Workshop.gif": "dc63c76356d9f3e8e3af65e9a7c68321",
"assets/assets/events/Flutter.jpg": "20c40a02edf20af65abaeae2fc099b5d",
"assets/assets/events/NoImage.png": "fadb14a5fb687572d07fef6c27266963",
"assets/assets/firstSlide/slide3.png": "cd4b1165b8ad1780af37ec1749ed0670",
"assets/assets/firstSlide/slide2.png": "7501106d47c6c9b8d9dd9b05fdd5c9da",
"assets/assets/firstSlide/slide1.png": "9f23f5d8fe2f53e98dc4457f93bc3b2d",
"assets/assets/firstSlide/slide5.png": "136e29f64279275df98ff3f29a367795",
"assets/assets/firstSlide/slide4.jpg": "737a808688746bafb7fff2f3dae0458d",
"assets/assets/thirdSlide/slide3.jpg": "299d7fff9b00752dd03892415b74948b",
"assets/assets/thirdSlide/slide2.jpg": "5dddd61893897e7dd144cbdb31a875fa",
"assets/assets/thirdSlide/slide1.png": "326f80ee7bf4ce6068d3529e4c6baee2",
"assets/assets/thirdSlide/slide5.png": "27852fc23c7667ee9345d9196ff13791",
"assets/assets/thirdSlide/slide4.jpg": "9e93b4c67bdb0d2da0c70b0b46b937a6",
"assets/assets/thirdSlide/slide6.jpg": "7fcb23e3631470238771b23454a824d7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
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
