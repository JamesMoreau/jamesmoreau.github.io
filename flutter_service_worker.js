'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "c8f979d408e51acd1ee06f6af9b9722c",
"index.html": "c499e3e7340a37488c86c562e7cc41db",
"/": "c499e3e7340a37488c86c562e7cc41db",
"icons8-my-computer-50%20(1).png": "104068dd0fdc778ea465350a00597d6f",
"main.dart.js": "a4d8dfad9cd0d61fc4ba733f50f5042b",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "c4d5927936a574586d1339a7f658303f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1a8e0d64f74dc53b989a979d34d206df",
".git/ORIG_HEAD": "85ea5aeeb3e1250c5b478eb79dc07aee",
".git/config": "fb1617b71a32784ec5e45a4b2a41b315",
".git/objects/57/3ca7d5bd6aca872ecfecc29f3863c0836e5637": "56c9162b077c2cab0420b3cd4365dd3a",
".git/objects/3b/dce0831f6d2c38471c72b6787dc2fc534234ed": "dbd6901ea551c325304befd68e0942b2",
".git/objects/03/c531a7a4eadfbb97e5434401927ee31890cf33": "fe6b24f60048b7f218835d95c2c650ae",
".git/objects/6a/465a027f1084e25e2ac6025b32fcde073f929a": "f1c8bdd1ee0ff332a8996e5562ae3e9e",
".git/objects/35/91af41948adc8001f3586d76b91181311953fc": "c91d33b29071dcff3b2b3385383761cb",
".git/objects/51/34e6402246228fb7f58ce8fe76727a61d99a62": "6b5e5b48febe40daec7062aecdc3b39f",
".git/objects/51/66d05ef15bef726d558d68a6283052668462cd": "9835e3d5a63faa3681de9514353b6728",
".git/objects/0b/532a412bfb30ecce6bb3601a1f62a9e2c4603d": "e77b9f4bb8a01589fdbe1c280b0461da",
".git/objects/0b/85bcdb86bf9e9f9fda81b13cec9c9349d47d77": "77cbf4b6cc88e2471afd14a98ef2e0ed",
".git/objects/93/72e70d4bd10376f970875428ef0d4ee147162b": "a31148ea9ad44886a3b63e919b16dc43",
".git/objects/0e/dc1ab29df7dba847d526286ca9f2ddc06f63a3": "c6272e501a24199f52edc627c94cfb9c",
".git/objects/34/64c61fddd80902c7e69e640262bd17bce88862": "8ca624f11a2de36f22206bcd73723034",
".git/objects/9c/6caeadd124cd6e05c4e5a117b1c8b9e0db8a3c": "f25b5b2493f805bcb45330a16b85f8a1",
".git/objects/02/ad63d14cd0ce9bfb3acd2b81601f21be778277": "c7d9ae02af7d05f0229773af615cd87b",
".git/objects/b2/2fdb2d1fa6a3bced274617d58f6ab432bb0d8b": "1b405e4dfab487f51d41422d52600614",
".git/objects/ac/a478488bbd0657aca213e22f4a16fbfc40352f": "e939c05641d7d0adcc23177ffa0d1cd2",
".git/objects/ad/27e49e0e3e010c30c3e45047c43b4accde4322": "7f177060a047c76cdb1be0cb1bffd84d",
".git/objects/bb/ac29f5ef7a40bf14c0901bc1457724156bc0de": "1393f20f0610cabefe2d4f45865b0f54",
".git/objects/bb/faa658f7389358c47dc8b531a2c46f019d36f9": "49d7bc74d5793b51260caa4dab2af6d8",
".git/objects/df/c59896ab9e537abf8ab859ead48a08ebadce41": "cd2ee1f81fc3adfb768510bed5ea2a98",
".git/objects/a5/a79294697b703f45c8a8e36b1931f4efc55866": "bb65b17066babd841193690f3fe88fe6",
".git/objects/d6/689f913658187b301eb10cbfc8a238d573c97c": "4982fa094a0fcc6dddcd9ae6736c9fcb",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/ae/37803d1933c3979fd1b939ff61cc667b0b70dc": "f5c08c98e82ebd9034dbd78b64a292fa",
".git/objects/d8/97cefccfb5fdac71e6585997bad3af3828437c": "45d0139594d3382291decab3ebd0fb97",
".git/objects/e5/354e32a84ed1444e9a15ff206ecaec16cb623c": "b4603b8bbc79860c2bcbd31dad3cf8a0",
".git/objects/f3/745a7752d79b9e72df74af1691e321135c3881": "7d34389d3f343ac5de37f072618b34c3",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/f5/9dc430d899c3aba22cb5efed734d231508669c": "30eceefdcb457f783d8ba8f04220f24a",
".git/objects/c6/2393869aa5f10c9097ef5579cb91713251f284": "e3ec0bf2e6ee9eaaadff6150fc5f61b9",
".git/objects/ec/73645f55f7dc5c31bfaac94b36d3a22cd9366a": "e527c0e290176b169898dcdd16533a96",
".git/objects/4e/d0680330d5f8f72d7feb1076c5d26d14174d7a": "eeb89b3eae023aeb212d2f4915f7a854",
".git/objects/20/15dcb9da0a86d5e695dd68f99bdf380d995d74": "7ca8291a84c61bd5b39935457cc041c3",
".git/objects/18/b2e38ffb78ec21e5ab1f7cee5856cc0cb0a353": "9e79d18da468302034183ee781e9bb4e",
".git/objects/18/6251381e214ebdd7c1624cde4c3c3a4c52085c": "31cbbc9c13d69c934ab2154aaab03dfe",
".git/objects/7d/f184e6590042827bd02274d7712e962a394932": "7072fc83288b060150859dce6b7aa594",
".git/objects/45/00c36608a697761a70b165f4df543facfc3932": "5eb891b87aed35088547ca47f6ae06ad",
".git/objects/1f/8f7eb658ad3653009610141ba4615ea984f07a": "82ee15c139405090b78c5a37021d7e1c",
".git/objects/73/5fedd9a59ad92f96b30a5f6c96520c7812e7bb": "febee6fdf44552db0064cb579c3701cc",
".git/objects/7b/73fc9beccfd025df144c1294a64ab0b9846398": "9506bc2a3f4164904616772340573514",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/19/6817c3c68a9336564d35a440ec24e543a4fbc6": "49d4b11883f9531cb0c8253f7e4f0ba1",
".git/objects/4c/e69c8bff1b5abdbbd240905e505bdddc37193c": "a5d658b213b5f2934940dde011176ee5",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/38/6a41376b227d01064ebb59513ec2c397fbed3d": "3446747788389e0af1f5185c8de0a6f7",
".git/objects/6e/d2e11286b96693ed0f99a0234edeba5b46f768": "bf08a818a78b5ec239899400a9c3b93e",
".git/objects/5d/64d65e4d07dab28945fbb82c51a28207885a53": "4d5f85dd66cb03fc59be51dc7ec4ebc0",
".git/objects/31/2ba0f39035a4fb3bb1e55684360bfb8a31a295": "1d66de7175603083ed3f8a026c8b9416",
".git/objects/62/a01d6826913d9efa140d2e9f4bc0f13918e607": "44ba2af6a4f05cb190463143170ae010",
".git/objects/54/32ae81b3587b0dc5cc43697efd890cb80ab8a2": "043c73eba15a5b68c125155a6e4947ab",
".git/objects/3f/bdd623b4f8d2e8484bff13d4b21504b159f021": "82492726c012b931b8b706e1407e2c49",
".git/objects/3f/8bc8ef97b93be1450ff3fdc0a0b5840635757a": "c598665fafb4c1f4bf769f8470ec1379",
".git/objects/5b/37cfef6c59f2abddd46ad1ced105892883bcba": "2ea4dcc5e659a47b03f4d8ee3e9d6e4d",
".git/objects/37/7580cbf691d03aea79c63a3a251b1b48ac01f1": "c196d282a50e3c372b4445c6b8868297",
".git/objects/37/bef0003e0422eea19a69e0aeef14d65d115ccb": "e3a2b5908cfed8993c221e693081e0ab",
".git/objects/37/f6308dde736a05e76b30edb263974f2f3b62d2": "e501d958817e5a0f11465edb385dc367",
".git/objects/01/c8e55fcdf54b8edfcd06b6415013b72a476a68": "493f6830026c442a2d0566bdd4337e45",
".git/objects/99/a045849500fb120fc6217060abea56108b6831": "7ee3d15a7910830f4eb037ce76ea9bfd",
".git/objects/55/c064f6bf8957280c386bb7a54c989e9b7a5689": "44a3d3894fdbbc3ca674aa3256624d6d",
".git/objects/63/186fc74b95a16d099914417a3c0b92049150a7": "4ff2569a619ccb62c5a07f4cd6942fd8",
".git/objects/0a/51c9cf1be118c77f84229e7f8df22b9717340a": "c3c10d228240b64e39005fcca8eeed7f",
".git/objects/d3/efa7fd80d9d345a1ad0aaa2e690c38f65f4d4e": "610858a6464fa97567f7cce3b11d9508",
".git/objects/ba/336592b6dfaff866196a58d03f79aa80f474ca": "12b7988313a0592ace1e6205c5005cab",
".git/objects/ba/3a83d5e9839f387b2b1630ab2307492ef9f081": "39ae4d8286de0072e4b0523ed8ac8b2b",
".git/objects/b1/1857c0b32ae9d3a0c9192ffb6b42cc9fb81b3f": "44ad88d60645651221fa1517df6838b0",
".git/objects/d5/40cfc303eabc5663ee517e8f670d0ba9810f7c": "1e490b4baefd3b41ac577ec82521678c",
".git/objects/aa/4ea63d5279017709708dad017edb62890e3931": "66ae650337a3ff7738c8b0060579e9d7",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/db/f091df9a607221e000593a8b5a97b5ea5fb073": "e6b91c6a8c1d6912e3a2fd2ac64e0a5c",
".git/objects/a8/3bec7f7fb92261294a18a8598e3311013398dd": "14dcf3ad03cc989de28f1e1b8aa5f6da",
".git/objects/a8/05db92a5f9bf58fad935ec639125e6e1395c0c": "a5678b4e059f29d8ffc71ade9996d96c",
".git/objects/a8/cdc352171a229b1bf9065c981aa69a9412c93f": "a582f0a5a13834767c6aba32b859f482",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/f6f594cd98b5ee910cde40aa1b8f48ba37c4d2": "9e3ca81f1301fb7075b60b0be3c5cac5",
".git/objects/c3/ca690793dda768bb919cb2f2ef142e737682d7": "1fb533bbd383b1812c9151f1f4e81ba8",
".git/objects/ea/75c5b854501a556ab8d6a1dc83728b16bff249": "b0c1c7bdbcd854d27fd7d6cc275e5f93",
".git/objects/f7/fb643f75870de951c5cc3373e810d8895c5222": "490143a1c5e3a529573f9ddd500f8313",
".git/objects/ff/229d641d2f58dc15923b98835d1c7aad121f1a": "174ff9dcb612c4f0b61120869c749505",
".git/objects/ff/59da19d3086a87d9d4cc1c35adc3054f940e0e": "eb4a558bfb553e45fde7c99312f43e8f",
".git/objects/c2/a0de1ccb766b79718f1a85fb1d992bdb07495c": "97450159ca138af7dba0794bd9fa8c72",
".git/objects/c2/28e62b5a24ba260569ddefbceb74dc1d7587f1": "b4d64ebd5f6bc0f2242bea61e9edc204",
".git/objects/f6/cb15f007b4c2ac0878ac9db06234207c5034e1": "73f5ac14e5dc2926a5e698d1061764fe",
".git/objects/e9/5ae345504514e14ce95ba58095ae507b5c08f0": "d411a7a205daaa8b10958117f78efd09",
".git/objects/f1/1be72a98b2e7886251234fd216109a3d96c7f7": "f02c5cebe5f2168a143b4cb3689ecd8f",
".git/objects/e7/5e920f175da53dd6f04d858636baa25dc702f4": "0fd694d0b7477cee41611e70d0cd6732",
".git/objects/cb/1a356a0d4e5e9df0a5e4ece31a860a2f600a83": "13aee3e70a87b9a4a5fb22d2579331a0",
".git/objects/f8/4c14a9d01221d608d406f566193f9f025f3995": "c17a4374daf04083d665f9890e2b00d7",
".git/objects/79/6de024def3c5ba9b9da247cdf25b2c6027c837": "5e670b4fe9d35f80395ea8c338fbc13c",
".git/objects/41/5cf6eb80869de967ff3afc66b4af1e16c49000": "0d0fc8ac3030fe32b1117ba1075a1e71",
".git/objects/41/5669494ce860b6adcfec5c1f6f66d497f5c51f": "a9dafaa9bdb3fc7b3af4ed6651193d87",
".git/objects/1b/bb3779e33d7816a619f6ba8408bb92310b981f": "8ced351496d95800781269fb190a57a0",
".git/objects/77/994057bc051b0eec4794baffb364f7f05bf4f8": "483155db50bcd8ad2d40a4cf33721969",
".git/objects/70/6f39aebeabe70925b7d9c119c8c6115bc79a50": "3b67efd9dd8b5413a14cf5b1deba3b1e",
".git/objects/1e/bf993c04c08e17a0122730f8d7ce6e139c8bad": "eeb4f0d71f24758335fe1753273ad6c2",
".git/objects/1e/1ad79f983ebf26526ad3a2d8c331c4a1d98d0a": "b07fbb67a6166098d921e0ec580e2a2f",
".git/objects/84/b82038500bbc13470c702ba1faa9ef22cb353f": "91692b81377056ab7df1e52729a929d3",
".git/objects/24/a7dfa4c85c6f3666b28b1eab4ebb4ffbb84b78": "7b256ee4a1890411686bed949149a852",
".git/objects/23/d0c66b4e93998af89ea0c3529bdb5a1b29d17d": "636cc6a31befe9ab5d09fa8860276ae7",
".git/objects/8c/e15d36294aa3f1ce01b45358dbdd4bcf79c88c": "cc446763d0ce2bbfc69898bcb73102dd",
".git/objects/1d/384f3748038966a5c7316223edf120dd5894dd": "a8d542276aa823dfefb8d26439e1077a",
".git/objects/76/3cb25d81e5f53267eaba6e3ea260b91790ef29": "b4168ab09bea208b87b089fcba77b903",
".git/objects/40/653baf6780c6a262d69aaa65326063186322a4": "5035a1189559f8b162389507cc9ec584",
".git/objects/7f/ca98153d49ebb8bbb486604c1030e36da0b18c": "cdfe0ca9908a69cd35cbb94bc93293a6",
".git/objects/8e/7f4b338840099949781ab85496d7a67fae46f1": "7f2803c236e9e7d95ef6ed16a3a2bd13",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "5f83a3d590e223e054b16b06acf0b4d8",
".git/logs/refs/heads/main": "0d9231ca76bc892b7fa281ebaf1277a2",
".git/logs/refs/remotes/origin/main": "45bcffb3ad4de4387d864b84a01d94fd",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "4b866c13eeb1c54fee04964b6d2f97f9",
".git/refs/remotes/origin/main": "4b866c13eeb1c54fee04964b6d2f97f9",
".git/index": "ab124d6f529e57dcc1e9fc02e2b8b7a1",
".git/packed-refs": "a891e6bb26eb0d480aef486a7e8ea166",
".git/COMMIT_EDITMSG": "bd4de149cd98bb0da8ff0f1fa2875f90",
".git/FETCH_HEAD": "6ef57713837dbde56df55c587fcfe132",
"assets/AssetManifest.json": "4e648d772598846f2e1bfd6697a136c9",
"assets/NOTICES": "2ba2efd21115a373bd64497df162fd92",
"assets/FontManifest.json": "29c301e5051784bb4b3c49647471b3c5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.smcbin": "c349fb2df964bb28af7bcf3b34c85408",
"assets/fonts/MaterialIcons-Regular.otf": "f9649b9cb486cd630fcb33434ff3f5ed",
"assets/assets/email.png": "07a1b1d18351d6d6b788e45d0a68baa5",
"assets/assets/lit.gif": "371df75c117e07c20c04c7d2a830976b",
"assets/assets/github.png": "ce062b599c8445758cb617c4bb72b7b7",
"assets/assets/eva_cesar_ikari.png": "3568b3d15236a0903a04c5d2cbed71ed",
"assets/assets/resume.png": "b6af48ad23cc1345a4f8527ded929e4d",
"assets/assets/linkedin.png": "30c453b7f5fbdb09ea0cb42a5dc7a6e5",
"assets/assets/mark_ferrari_nature.gif": "53b489769aa4f0a7cbe6bf71fae98525",
"assets/assets/coop_term_reports/fall_2020_report.txt": "41d69df0b3e31267686b2615ba0c6f7c",
"assets/assets/coop_term_reports/summer_2021_report.txt": "6dd28b5fa2cbb879c7dc095345c5ea56",
"assets/assets/coop_term_reports/winter_summer_2022_report.txt": "fc09597584e2278873553e14acdba7bf",
"assets/assets/github-mark.svg": "8dcc6b5262f3b6138b1566b357ba89a9",
"assets/assets/linkedin.svg": "5b238434e2862c877f08572b96c0ef7b",
"assets/assets/fonts/Inconsolata-VariableFont_wdth,wght.ttf": "aef1948adbc4c036b1517a44a2a5998e",
"favicon_old.png": "5dcef449791fa27946b3d35ad8803796",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
